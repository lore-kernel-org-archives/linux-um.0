Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKML1-0006Pa-K3
 for linux-um@lists.infradead.org; Mon, 21 Sep 2020 13:58:40 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH] um: vector: Add dynamic tap interfaces and scripting
Date: Mon, 21 Sep 2020 14:58:27 +0100
Message-Id: <20200921135827.27776-1-anton.ivanov@cambridgegreys.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: richard@nod.at, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Provide functionality roughly compatible with the existing qemu
ifup scripting:
* invocation of an ifup script. The interface name is passed as the
  first and only argument
* allocating tap interfaces on the fly if they are not explicitly
  specified

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/vector_user.c | 56 +++++++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 9 deletions(-)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index c4a0f26b2824..67f53636c633 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -39,6 +39,7 @@
 #define ID_MAX 2
 
 #define TOKEN_IFNAME "ifname"
+#define TOKEN_SCRIPT "ifup"
 
 #define TRANS_RAW "raw"
 #define TRANS_RAW_LEN strlen(TRANS_RAW)
@@ -55,6 +56,9 @@
 
 #define MAX_UN_LEN 107
 
+static const char padchar[] = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
+static const char *template = "tapXXXXXX";
+
 /* This is very ugly and brute force lookup, but it is done
  * only once at initialization so not worth doing hashes or
  * anything more intelligent
@@ -191,16 +195,21 @@ static int create_raw_fd(char *iface, int flags, int proto)
 	return err;
 }
 
+
 static struct vector_fds *user_init_tap_fds(struct arglist *ifspec)
 {
-	int fd = -1;
+	int fd = -1, i;
 	char *iface;
 	struct vector_fds *result = NULL;
+	bool dynamic = false;
+	char dynamic_ifname[IFNAMSIZ];
+	char *argv[] = {NULL, NULL, NULL, NULL};
 
 	iface = uml_vector_fetch_arg(ifspec, TOKEN_IFNAME);
 	if (iface == NULL) {
-		printk(UM_KERN_ERR "uml_tap: failed to parse interface spec\n");
-		goto tap_cleanup;
+		dynamic = true;
+		iface = dynamic_ifname;
+		srand(getpid());
 	}
 
 	result = uml_kmalloc(sizeof(struct vector_fds), UM_GFP_KERNEL);
@@ -214,14 +223,30 @@ static struct vector_fds *user_init_tap_fds(struct arglist *ifspec)
 	result->remote_addr_size = 0;
 
 	/* TAP */
+	do {
+		if (dynamic) {
+			strcpy(iface, template);
+			for (i = 0; i < strlen(iface); i++) {
+				if (iface[i] == 'X') {
+					iface[i] = padchar[rand() % strlen(padchar)];
+				}
+			}
+		}
+		fd = create_tap_fd(iface);
+		if ((fd < 0) && (!dynamic)) {
+			printk(UM_KERN_ERR "uml_tap: failed to create tun interface\n");
+			goto tap_cleanup;
+		}
+		result->tx_fd = fd;
+		result->rx_fd = fd;
+	} while (fd < 0);
 
-	fd = create_tap_fd(iface);
-	if (fd < 0) {
-		printk(UM_KERN_ERR "uml_tap: failed to create tun interface\n");
-		goto tap_cleanup;
+	argv[0] = uml_vector_fetch_arg(ifspec, TOKEN_SCRIPT);
+	if (argv[0]) {
+		argv[1] = iface;
+		run_helper(NULL, NULL, argv);
 	}
-	result->tx_fd = fd;
-	result->rx_fd = fd;
+
 	return result;
 tap_cleanup:
 	printk(UM_KERN_ERR "user_init_tap: init failed, error %d", fd);
@@ -233,6 +258,7 @@ static struct vector_fds *user_init_hybrid_fds(struct arglist *ifspec)
 {
 	char *iface;
 	struct vector_fds *result = NULL;
+	char *argv[] = {NULL, NULL, NULL, NULL};
 
 	iface = uml_vector_fetch_arg(ifspec, TOKEN_IFNAME);
 	if (iface == NULL) {
@@ -266,6 +292,12 @@ static struct vector_fds *user_init_hybrid_fds(struct arglist *ifspec)
 			"uml_tap: failed to create paired raw socket: %i\n", result->rx_fd);
 		goto hybrid_cleanup;
 	}
+
+	argv[0] = uml_vector_fetch_arg(ifspec, TOKEN_SCRIPT);
+	if (argv[0]) {
+		argv[1] = iface;
+		run_helper(NULL, NULL, argv);
+	}
 	return result;
 hybrid_cleanup:
 	printk(UM_KERN_ERR "user_init_hybrid: init failed");
@@ -410,6 +442,7 @@ static struct vector_fds *user_init_raw_fds(struct arglist *ifspec)
 	int err = -ENOMEM;
 	char *iface;
 	struct vector_fds *result = NULL;
+	char *argv[] = {NULL, NULL, NULL, NULL};
 
 	iface = uml_vector_fetch_arg(ifspec, TOKEN_IFNAME);
 	if (iface == NULL)
@@ -432,6 +465,11 @@ static struct vector_fds *user_init_raw_fds(struct arglist *ifspec)
 		result->remote_addr = NULL;
 		result->remote_addr_size = 0;
 	}
+	argv[0] = uml_vector_fetch_arg(ifspec, TOKEN_SCRIPT);
+	if (argv[0]) {
+		argv[1] = iface;
+		run_helper(NULL, NULL, argv);
+	}
 	return result;
 raw_cleanup:
 	printk(UM_KERN_ERR "user_init_raw: init failed, error %d", err);
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

