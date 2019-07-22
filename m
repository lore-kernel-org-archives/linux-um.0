Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hpSmK-0003Mt-TS
 for linux-um@lists.infradead.org; Mon, 22 Jul 2019 07:30:39 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCHv3 2/5] um: Added support for unix socket transports and bess
 transport
Date: Mon, 22 Jul 2019 08:30:22 +0100
Message-Id: <20190722073025.20844-2-anton.ivanov@cambridgegreys.com>
In-Reply-To: <20190722073025.20844-1-anton.ivanov@cambridgegreys.com>
References: <20190722073025.20844-1-anton.ivanov@cambridgegreys.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: richard@nod.at, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

This adds support for the UNIX domain socket transports in
general and implements a Netsys::BESS compatible transport
interface.
For details on Netsys::BESS see https://github.com/NetSys/bess

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/vector_transports.c | 11 +++++
 arch/um/drivers/vector_user.c       | 88 ++++++++++++++++++++++++++++++++++++-
 arch/um/drivers/vector_user.h       |  3 ++
 3 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_transports.c
index 2999f3bd1781..a43310cd84fb 100644
--- a/arch/um/drivers/vector_transports.c
+++ b/arch/um/drivers/vector_transports.c
@@ -465,6 +465,15 @@ static int build_tap_transport_data(struct vector_private *vp)
 }
 
 
+static int build_bess_transport_data(struct vector_private *vp)
+{
+	vp->form_header = NULL;
+	vp->verify_header = NULL;
+	vp->header_size = 0;
+	vp->rx_header_size = 0;
+	return 0;
+}
+
 int build_transport_data(struct vector_private *vp)
 {
 	char *transport = uml_vector_fetch_arg(vp->parsed, "transport");
@@ -479,6 +488,8 @@ int build_transport_data(struct vector_private *vp)
 		return build_tap_transport_data(vp);
 	if (strncmp(transport, TRANS_HYBRID, TRANS_HYBRID_LEN) == 0)
 		return build_hybrid_transport_data(vp);
+	if (strncmp(transport, TRANS_BESS, TRANS_BESS_LEN) == 0)
+		return build_bess_transport_data(vp);
 	return 0;
 }
 
diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index af1a1da432ca..6dd9b4379507 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -18,6 +18,7 @@
 #include <fcntl.h>
 #include <sys/types.h>
 #include <sys/socket.h>
+#include <sys/un.h>
 #include <net/ethernet.h>
 #include <netinet/ip.h>
 #include <netinet/ether.h>
@@ -34,7 +35,8 @@
 
 #define ID_GRE 0
 #define ID_L2TPV3 1
-#define ID_MAX 1
+#define ID_BESS 2
+#define ID_MAX 2
 
 #define TOKEN_IFNAME "ifname"
 
@@ -44,8 +46,11 @@
 #define VNET_HDR_FAIL "could not enable vnet headers on fd %d"
 #define TUN_GET_F_FAIL "tapraw: TUNGETFEATURES failed: %s"
 #define L2TPV3_BIND_FAIL "l2tpv3_open : could not bind socket err=%i"
+#define UNIX_BIND_FAIL "unix_open : could not bind socket err=%i"
 #define BPF_ATTACH_FAIL "Failed to attach filter size %d to %d, err %d\n"
 
+#define MAX_UN_LEN 107
+
 /* This is very ugly and brute force lookup, but it is done
  * only once at initialization so not worth doing hashes or
  * anything more intelligent
@@ -266,6 +271,85 @@ static struct vector_fds *user_init_hybrid_fds(struct arglist *ifspec)
 	return NULL;
 }
 
+static struct vector_fds *user_init_unix_fds(struct arglist *ifspec, int id)
+{
+	int fd = -1;
+	int socktype;
+	char *src, *dst;
+	struct vector_fds *result = NULL;
+	struct sockaddr_un *local_addr = NULL, *remote_addr = NULL;
+
+	src = uml_vector_fetch_arg(ifspec, "src");
+	dst = uml_vector_fetch_arg(ifspec, "dst");
+	result = uml_kmalloc(sizeof(struct vector_fds), UM_GFP_KERNEL);
+	if (result == NULL) {
+		printk(UM_KERN_ERR "unix open:cannot allocate remote addr");
+		goto unix_cleanup;
+	}
+	remote_addr = uml_kmalloc(sizeof(struct sockaddr_un), UM_GFP_KERNEL);
+	if (remote_addr == NULL) {
+		printk(UM_KERN_ERR "unix open:cannot allocate remote addr");
+		goto unix_cleanup;
+	}
+
+	switch (id) {
+	case ID_BESS:
+		socktype = SOCK_SEQPACKET;
+		if ((src != NULL) && (strlen(src) <= MAX_UN_LEN)) {
+			local_addr = uml_kmalloc(sizeof(struct sockaddr_un), UM_GFP_KERNEL);
+			if (local_addr == NULL) {
+				printk(UM_KERN_ERR "bess open:cannot allocate local addr");
+				goto unix_cleanup;
+			}
+			local_addr->sun_family = AF_UNIX;
+			memcpy(local_addr->sun_path, src, strlen(src) + 1);
+		}
+		if ((dst == NULL) || (strlen(dst) > MAX_UN_LEN))
+			goto unix_cleanup;
+		remote_addr->sun_family = AF_UNIX;
+		memcpy(remote_addr->sun_path, dst, strlen(dst) + 1);
+		break;
+	default:
+		printk(KERN_ERR "Unsupported unix socket type\n");
+		return NULL;
+	}
+
+	fd = socket(AF_UNIX, socktype, 0);
+	if (fd == -1) {
+		printk(UM_KERN_ERR
+			"unix open: could not open socket, error = %d",
+			-errno
+		);
+		goto unix_cleanup;
+	}
+	if (local_addr != NULL) {
+		if (bind(fd, (struct sockaddr *) local_addr, sizeof(struct sockaddr_un))) {
+			printk(UM_KERN_ERR UNIX_BIND_FAIL, errno);
+			goto unix_cleanup;
+		}
+	}
+	switch (id) {
+	case ID_BESS:
+		if (connect(fd, remote_addr, sizeof(struct sockaddr_un)) < 0) {
+			printk(UM_KERN_ERR "bess open:cannot connect to %s %i", remote_addr->sun_path, -errno);
+			goto unix_cleanup;
+		}
+		break;
+	}
+	result->rx_fd = fd;
+	result->tx_fd = fd;
+	result->remote_addr_size = sizeof(struct sockaddr_un);
+	result->remote_addr = remote_addr;
+	return result;
+unix_cleanup:
+	if (fd >= 0)
+		os_close_file(fd);
+	if (remote_addr != NULL)
+		kfree(remote_addr);
+	if (result != NULL)
+		kfree(result);
+	return NULL;
+}
 
 static struct vector_fds *user_init_raw_fds(struct arglist *ifspec)
 {
@@ -497,6 +581,8 @@ struct vector_fds *uml_vector_user_open(
 		return user_init_socket_fds(parsed, ID_GRE);
 	if (strncmp(transport, TRANS_L2TPV3, TRANS_L2TPV3_LEN) == 0)
 		return user_init_socket_fds(parsed, ID_L2TPV3);
+	if (strncmp(transport, TRANS_BESS, TRANS_BESS_LEN) == 0)
+		return user_init_unix_fds(parsed, ID_BESS);
 	return NULL;
 }
 
diff --git a/arch/um/drivers/vector_user.h b/arch/um/drivers/vector_user.h
index 6bf50cf78ad0..0a13ca9592d1 100644
--- a/arch/um/drivers/vector_user.h
+++ b/arch/um/drivers/vector_user.h
@@ -25,6 +25,9 @@
 #define TRANS_HYBRID "hybrid"
 #define TRANS_HYBRID_LEN strlen(TRANS_HYBRID)
 
+#define TRANS_BESS "bess"
+#define TRANS_BESS_LEN strlen(TRANS_BESS)
+
 #ifndef IPPROTO_GRE
 #define IPPROTO_GRE 0x2F
 #endif
-- 
2.11.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

