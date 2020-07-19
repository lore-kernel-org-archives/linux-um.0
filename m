Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxGSG-0006ta-3f
 for linux-um@lists.infradead.org; Sun, 19 Jul 2020 21:02:42 +0000
Received: by mail-wm1-x344.google.com with SMTP id f139so23265600wmf.5
 for <linux-um@lists.infradead.org>; Sun, 19 Jul 2020 14:02:39 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
Subject: [PATCH v4 2/3] um: some fixes to build UML with musl
Date: Sun, 19 Jul 2020 22:02:21 +0100
Message-Id: <20200719210222.2811-3-ignat@cloudflare.com>
In-Reply-To: <20200719210222.2811-1-ignat@cloudflare.com>
References: <20200719210222.2811-1-ignat@cloudflare.com>
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
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, brendanhiggins@google.com, masahiroy@kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel-team@cloudflare.com, Ignat Korchagin <ignat@cloudflare.com>

musl toolchain and headers are a bit more strict. These fixes enable building
UML with musl as well as seem not to break on glibc.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
---
 arch/um/drivers/daemon_user.c |  1 +
 arch/um/drivers/pcap_user.c   | 12 ++++++------
 arch/um/drivers/slip_user.c   |  2 +-
 arch/um/drivers/vector_user.c |  4 +---
 arch/um/os-Linux/util.c       |  2 +-
 arch/x86/um/user-offsets.c    |  2 +-
 6 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/um/drivers/daemon_user.c b/arch/um/drivers/daemon_user.c
index 3695821d06a2..785baedc3555 100644
--- a/arch/um/drivers/daemon_user.c
+++ b/arch/um/drivers/daemon_user.c
@@ -7,6 +7,7 @@
  */
 
 #include <stdint.h>
+#include <string.h>
 #include <unistd.h>
 #include <errno.h>
 #include <sys/types.h>
diff --git a/arch/um/drivers/pcap_user.c b/arch/um/drivers/pcap_user.c
index bbd20638788a..52ddda3e3b10 100644
--- a/arch/um/drivers/pcap_user.c
+++ b/arch/um/drivers/pcap_user.c
@@ -32,7 +32,7 @@ static int pcap_user_init(void *data, void *dev)
 	return 0;
 }
 
-static int pcap_open(void *data)
+static int pcap_user_open(void *data)
 {
 	struct pcap_data *pri = data;
 	__u32 netmask;
@@ -44,14 +44,14 @@ static int pcap_open(void *data)
 	if (pri->filter != NULL) {
 		err = dev_netmask(pri->dev, &netmask);
 		if (err < 0) {
-			printk(UM_KERN_ERR "pcap_open : dev_netmask failed\n");
+			printk(UM_KERN_ERR "pcap_user_open : dev_netmask failed\n");
 			return -EIO;
 		}
 
 		pri->compiled = uml_kmalloc(sizeof(struct bpf_program),
 					UM_GFP_KERNEL);
 		if (pri->compiled == NULL) {
-			printk(UM_KERN_ERR "pcap_open : kmalloc failed\n");
+			printk(UM_KERN_ERR "pcap_user_open : kmalloc failed\n");
 			return -ENOMEM;
 		}
 
@@ -59,14 +59,14 @@ static int pcap_open(void *data)
 				   (struct bpf_program *) pri->compiled,
 				   pri->filter, pri->optimize, netmask);
 		if (err < 0) {
-			printk(UM_KERN_ERR "pcap_open : pcap_compile failed - "
+			printk(UM_KERN_ERR "pcap_user_open : pcap_compile failed - "
 			       "'%s'\n", pcap_geterr(pri->pcap));
 			goto out;
 		}
 
 		err = pcap_setfilter(pri->pcap, pri->compiled);
 		if (err < 0) {
-			printk(UM_KERN_ERR "pcap_open : pcap_setfilter "
+			printk(UM_KERN_ERR "pcap_user_open : pcap_setfilter "
 			       "failed - '%s'\n", pcap_geterr(pri->pcap));
 			goto out;
 		}
@@ -127,7 +127,7 @@ int pcap_user_read(int fd, void *buffer, int len, struct pcap_data *pri)
 
 const struct net_user_info pcap_user_info = {
 	.init		= pcap_user_init,
-	.open		= pcap_open,
+	.open		= pcap_user_open,
 	.close	 	= NULL,
 	.remove	 	= pcap_remove,
 	.add_address	= NULL,
diff --git a/arch/um/drivers/slip_user.c b/arch/um/drivers/slip_user.c
index 8016d32b6809..482a19c5105c 100644
--- a/arch/um/drivers/slip_user.c
+++ b/arch/um/drivers/slip_user.c
@@ -9,7 +9,7 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <string.h>
-#include <sys/termios.h>
+#include <termios.h>
 #include <sys/wait.h>
 #include <net_user.h>
 #include <os.h>
diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index c4a0f26b2824..45d4164ad355 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -18,9 +18,7 @@
 #include <fcntl.h>
 #include <sys/socket.h>
 #include <sys/un.h>
-#include <net/ethernet.h>
 #include <netinet/ip.h>
-#include <netinet/ether.h>
 #include <linux/if_ether.h>
 #include <linux/if_packet.h>
 #include <sys/wait.h>
@@ -332,7 +330,7 @@ static struct vector_fds *user_init_unix_fds(struct arglist *ifspec, int id)
 	}
 	switch (id) {
 	case ID_BESS:
-		if (connect(fd, remote_addr, sizeof(struct sockaddr_un)) < 0) {
+		if (connect(fd, (const struct sockaddr *) remote_addr, sizeof(struct sockaddr_un)) < 0) {
 			printk(UM_KERN_ERR "bess open:cannot connect to %s %i", remote_addr->sun_path, -errno);
 			goto unix_cleanup;
 		}
diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
index ecf2f390fad2..07327425d06e 100644
--- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -10,7 +10,7 @@
 #include <signal.h>
 #include <string.h>
 #include <termios.h>
-#include <wait.h>
+#include <sys/wait.h>
 #include <sys/mman.h>
 #include <sys/utsname.h>
 #include <init.h>
diff --git a/arch/x86/um/user-offsets.c b/arch/x86/um/user-offsets.c
index c51dd8363d25..bae61554abcc 100644
--- a/arch/x86/um/user-offsets.c
+++ b/arch/x86/um/user-offsets.c
@@ -2,7 +2,7 @@
 #include <stdio.h>
 #include <stddef.h>
 #include <signal.h>
-#include <sys/poll.h>
+#include <poll.h>
 #include <sys/mman.h>
 #include <sys/user.h>
 #define __FRAME_OFFSETS
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

