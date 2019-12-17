Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ih9nJ-0002cL-Bi
 for linux-um@lists.infradead.org; Tue, 17 Dec 2019 10:09:35 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH v4 8/9] um: Add daemon transport to vector subsystem
Date: Tue, 17 Dec 2019 10:09:12 +0000
Message-Id: <20191217100913.3422-8-anton.ivanov@cambridgegreys.com>
In-Reply-To: <20191217100913.3422-1-anton.ivanov@cambridgegreys.com>
References: <20191217100913.3422-1-anton.ivanov@cambridgegreys.com>
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
Cc: richard@nod.at, brendanhiggins@google.com, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Adds a transport compatible with the old uml_switch from
uml-utilities package to the vector subsystem.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/Kconfig       |   2 +-
 arch/um/drivers/vector_kern.c |   4 ++
 arch/um/drivers/vector_user.c | 110 ++++++++++++++++++++++++++++++++--
 arch/um/drivers/vector_user.h |   4 ++
 4 files changed, 115 insertions(+), 5 deletions(-)

diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
index 7362ac9953fc..2369bdf4be91 100644
--- a/arch/um/drivers/Kconfig
+++ b/arch/um/drivers/Kconfig
@@ -152,7 +152,7 @@ config UML_NET_TUNTAP
 	depends on UML_NET
 	help
 	  The UML TUN/TAP network transport allows a UML instance to exchange
-	  packets with the host over a TUN/TAP device. 
+	  packets with the host over a TUN/TAP device.
 
 	  To use this transport, your host kernel must have support for TUN/TAP
 	  devices, either built-in or as a module.
diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 224db8833b8e..aba2dc634f44 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -1187,6 +1187,10 @@ static int vector_net_close(struct net_device *dev)
 		os_close_file(vp->fds->rx_fd);
 		vp->fds->rx_fd = -1;
 	}
+	if (vp->fds->control_fd > 0) {
+		os_close_file(vp->fds->control_fd);
+		vp->fds->control_fd = -1;
+	}
 	if (vp->fds->tx_fd > 0) {
 		os_close_file(vp->fds->tx_fd);
 		vp->fds->tx_fd = -1;
diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index ab01c194fba5..20c3bb22a211 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -25,6 +25,7 @@
 #include <linux/if_packet.h>
 #include <sys/wait.h>
 #include <sys/uio.h>
+#include <sys/time.h>
 #include <linux/virtio_net.h>
 #include <netdb.h>
 #include <stdlib.h>
@@ -37,7 +38,8 @@
 #define ID_BESS 2
 #define ID_UCAST 3
 #define ID_MCAST 4
-#define ID_MAX 4
+#define ID_DAEMON 5
+#define ID_MAX 5
 
 #define TOKEN_IFNAME "ifname"
 #define TOKEN_SCRIPT "script"
@@ -57,6 +59,18 @@
 static const char padchar[] = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
 static const char *template = "tapXXXXXX";
 
+enum request_type { REQ_NEW_CONTROL };
+
+#define SWITCH_MAGIC 0xfeedface
+
+struct request_v3 {
+	uint32_t magic;
+	uint32_t version;
+	enum request_type type;
+	struct sockaddr_un sock;
+};
+
+
 /* This is very ugly and brute force lookup, but it is done
  * only once at initialization so not worth doing hashes or
  * anything more intelligent
@@ -217,6 +231,7 @@ static struct vector_fds *user_init_tap_fds(struct arglist *ifspec)
 	}
 	result->rx_fd = -1;
 	result->tx_fd = -1;
+	result->control_fd = -1;
 	result->remote_addr = NULL;
 	result->remote_addr_size = 0;
 
@@ -272,6 +287,7 @@ static struct vector_fds *user_init_hybrid_fds(struct arglist *ifspec)
 	}
 	result->rx_fd = -1;
 	result->tx_fd = -1;
+	result->control_fd = -1;
 	result->remote_addr = NULL;
 	result->remote_addr_size = 0;
 
@@ -305,21 +321,35 @@ static struct vector_fds *user_init_hybrid_fds(struct arglist *ifspec)
 	return NULL;
 }
 
+#define SWITCH_VERSION 3
+
 static struct vector_fds *user_init_unix_fds(struct arglist *ifspec, int id)
 {
-	int fd = -1;
+	int fd = -1, n;
 	int socktype;
 	char *src, *dst;
 	struct vector_fds *result = NULL;
-	struct sockaddr_un *local_addr = NULL, *remote_addr = NULL;
+	struct sockaddr_un *local_addr = NULL, *remote_addr = NULL, *control_addr = NULL;
+	struct request_v3 req;
+	struct {
+		char zero;
+		int pid;
+		int usecs;
+	} name;
+	struct timeval tv;
 
 	src = uml_vector_fetch_arg(ifspec, "src");
 	dst = uml_vector_fetch_arg(ifspec, "dst");
+
+	if (dst == NULL)
+		dst = "/tmp/uml.ctl";
+
 	result = uml_kmalloc(sizeof(struct vector_fds), UM_GFP_KERNEL);
 	if (result == NULL) {
 		printk(UM_KERN_ERR "unix open:cannot allocate remote addr");
 		goto unix_cleanup;
 	}
+	result->control_fd = -1;
 	remote_addr = uml_kmalloc(sizeof(struct sockaddr_un), UM_GFP_KERNEL);
 	if (remote_addr == NULL) {
 		printk(UM_KERN_ERR "unix open:cannot allocate remote addr");
@@ -327,6 +357,62 @@ static struct vector_fds *user_init_unix_fds(struct arglist *ifspec, int id)
 	}
 
 	switch (id) {
+	case ID_DAEMON:
+		name.zero = 0;
+		name.pid = os_getpid();
+		gettimeofday(&tv, NULL);
+		name.usecs = tv.tv_usec;
+
+		local_addr = uml_kmalloc(sizeof(struct sockaddr_un), UM_GFP_KERNEL);
+		if (local_addr == NULL) {
+			printk(UM_KERN_ERR "daemon open:cannot allocate local addr");
+			goto unix_cleanup;
+		}
+		local_addr->sun_family = AF_UNIX;
+		memcpy(local_addr->sun_path, &name, sizeof(name));
+
+		result->control_fd = socket(AF_UNIX, SOCK_STREAM, 0);
+		if (result->control_fd < 0) {
+			printk(UM_KERN_ERR
+				"unix open: could not open socket, error = %d",
+				-errno
+			);
+			goto unix_cleanup;
+		}
+		if (strlen(dst) <= MAX_UN_LEN) {
+			control_addr = uml_kmalloc(sizeof(struct sockaddr_un), UM_GFP_KERNEL);
+			if (control_addr == NULL) {
+				printk(UM_KERN_ERR "daemon open:cannot allocate control addr");
+				goto unix_cleanup;
+			}
+			control_addr->sun_family = AF_UNIX;
+			memcpy(control_addr->sun_path, dst, strlen(dst) + 1);
+		}
+
+		if (connect(result->control_fd, (struct sockaddr *) control_addr, sizeof(*control_addr)) < 0) {
+			printk(UM_KERN_ERR "daemon_open : control connect failed, " "errno = %d\n", -errno);
+			goto unix_cleanup;
+		}
+		req.magic = SWITCH_MAGIC;
+		req.version = SWITCH_VERSION;
+		req.type = REQ_NEW_CONTROL;
+		req.sock = *local_addr;
+
+		n = write(result->control_fd, &req, sizeof(req));
+		if (n != sizeof(req)) {
+			printk(UM_KERN_ERR "daemon_open : control setup request "
+			       "failed, err = %d\n", -errno);
+			goto unix_cleanup;
+		}
+		n = read(result->control_fd, remote_addr, sizeof(struct sockaddr_un));
+		if (n != sizeof(struct sockaddr_un)) {
+			printk(UM_KERN_ERR "daemon_open : read of data socket failed, "
+			       "err = %d\n", -errno);
+			goto unix_cleanup;
+		}
+		socktype = SOCK_DGRAM;
+
+		break;
 	case ID_BESS:
 		socktype = SOCK_SEQPACKET;
 		if ((src != NULL) && (strlen(src) <= MAX_UN_LEN)) {
@@ -374,14 +460,27 @@ static struct vector_fds *user_init_unix_fds(struct arglist *ifspec, int id)
 	result->tx_fd = fd;
 	result->remote_addr_size = sizeof(struct sockaddr_un);
 	result->remote_addr = remote_addr;
+
+	if (control_addr != NULL)
+		kfree(control_addr);
+	if (local_addr != NULL)
+		kfree(local_addr);
+
 	return result;
 unix_cleanup:
 	if (fd >= 0)
 		os_close_file(fd);
 	if (remote_addr != NULL)
 		kfree(remote_addr);
-	if (result != NULL)
+	if (control_addr != NULL)
+		kfree(control_addr);
+	if (local_addr != NULL)
+		kfree(local_addr);
+	if (result != NULL) {
+		if (result->control_fd > 0)
+			close(result->control_fd);
 		kfree(result);
+	}
 	return NULL;
 }
 
@@ -422,6 +521,7 @@ static struct vector_fds *user_init_raw_fds(struct arglist *ifspec)
 	if (result != NULL) {
 		result->rx_fd = rxfd;
 		result->tx_fd = txfd;
+		result->control_fd = -1;
 		result->remote_addr = NULL;
 		result->remote_addr_size = 0;
 	}
@@ -677,6 +777,8 @@ struct vector_fds *uml_vector_user_open(
 		return user_init_socket_fds(parsed, ID_L2TPV3);
 	if (strncmp(transport, TRANS_BESS, TRANS_BESS_LEN) == 0)
 		return user_init_unix_fds(parsed, ID_BESS);
+	if (strncmp(transport, TRANS_DAEMON, TRANS_DAEMON_LEN) == 0)
+		return user_init_unix_fds(parsed, ID_DAEMON);
 	if (strncmp(transport, TRANS_UCAST, TRANS_UCAST_LEN) == 0)
 		return user_init_socket_fds(parsed, ID_UCAST);
 	if (strncmp(transport, TRANS_MCAST, TRANS_MCAST_LEN) == 0)
diff --git a/arch/um/drivers/vector_user.h b/arch/um/drivers/vector_user.h
index 3b05850a9c46..590ece585929 100644
--- a/arch/um/drivers/vector_user.h
+++ b/arch/um/drivers/vector_user.h
@@ -34,6 +34,9 @@
 #define TRANS_MCAST "mcast"
 #define TRANS_MCAST_LEN strlen(TRANS_MCAST)
 
+#define TRANS_DAEMON "daemon"
+#define TRANS_DAEMON_LEN strlen(TRANS_MCAST)
+
 #define DEFAULT_BPF_LEN 6
 
 #ifndef IPPROTO_GRE
@@ -71,6 +74,7 @@ struct vector_fds {
 	int tx_fd;
 	void *remote_addr;
 	int remote_addr_size;
+	int control_fd;
 };
 
 #define VECTOR_READ	1
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

