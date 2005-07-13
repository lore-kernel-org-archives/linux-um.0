Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DslX5-0000x9-LQ	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2005 11:00:31 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.44)
	id 1DslX5-0002e5-2m	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2005 11:00:31 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050713180232.149E721E743@zion.home.lan>
Subject: [uml-devel] [patch 6/9] uml: reintroduce pcap support
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 13 Jul 2005 20:02:31 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


The pcap support was not working because of some linking problems (expressing
the construct in Kbuild was a bit difficult) and because there was no user
request. Now that this has come back, here's the support.

This has been tested and works on both 32 and 64-bit hosts, even when
"cross-"building 32-bit binaries.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-broken-paolo/arch/um/Kconfig_net      |    2 +-
 linux-2.6.git-broken-paolo/arch/um/Makefile         |   14 +++++++++-----
 linux-2.6.git-broken-paolo/arch/um/drivers/Makefile |   17 ++++++++++++++---
 3 files changed, 24 insertions(+), 9 deletions(-)

diff -puN arch/um/drivers/Makefile~uml-reallow-pcap arch/um/drivers/Makefile
--- linux-2.6.git-broken/arch/um/drivers/Makefile~uml-reallow-pcap	2005-07-13 19:43:05.000000000 +0200
+++ linux-2.6.git-broken-paolo/arch/um/drivers/Makefile	2005-07-13 19:43:30.000000000 +0200
@@ -10,7 +10,6 @@ slip-objs := slip_kern.o slip_user.o
 slirp-objs := slirp_kern.o slirp_user.o
 daemon-objs := daemon_kern.o daemon_user.o
 mcast-objs := mcast_kern.o mcast_user.o
-#pcap-objs := pcap_kern.o pcap_user.o $(PCAP)
 net-objs := net_kern.o net_user.o
 mconsole-objs := mconsole_kern.o mconsole_user.o
 hostaudio-objs := hostaudio_kern.o
@@ -18,6 +17,17 @@ ubd-objs := ubd_kern.o ubd_user.o
 port-objs := port_kern.o port_user.o
 harddog-objs := harddog_kern.o harddog_user.o
 
+LDFLAGS_pcap.o := -r $(shell $(CC) $(CFLAGS) -print-file-name=libpcap.a)
+
+$(obj)/pcap.o: $(obj)/pcap_kern.o $(obj)/pcap_user.o
+	$(LD) -r -dp -o $@ $^ $(LDFLAGS) $(LDFLAGS_pcap.o)
+#XXX: The call below does not work because the flags are added before the
+# object name, so nothing from the library gets linked.
+#$(call if_changed,ld)
+
+# When the above is fixed, don't forget to add this too!
+#targets := $(obj)/pcap.o
+
 obj-y := stdio_console.o fd.o chan_kern.o chan_user.o line.o
 obj-$(CONFIG_SSL) += ssl.o
 obj-$(CONFIG_STDERR_CONSOLE) += stderr_console.o
@@ -26,7 +36,7 @@ obj-$(CONFIG_UML_NET_SLIP) += slip.o sli
 obj-$(CONFIG_UML_NET_SLIRP) += slirp.o slip_common.o
 obj-$(CONFIG_UML_NET_DAEMON) += daemon.o 
 obj-$(CONFIG_UML_NET_MCAST) += mcast.o 
-#obj-$(CONFIG_UML_NET_PCAP) += pcap.o $(PCAP)
+obj-$(CONFIG_UML_NET_PCAP) += pcap.o
 obj-$(CONFIG_UML_NET) += net.o 
 obj-$(CONFIG_MCONSOLE) += mconsole.o
 obj-$(CONFIG_MMAPPER) += mmapper_kern.o 
@@ -41,6 +51,7 @@ obj-$(CONFIG_UML_WATCHDOG) += harddog.o
 obj-$(CONFIG_BLK_DEV_COW_COMMON) += cow_user.o
 obj-$(CONFIG_UML_RANDOM) += random.o
 
-USER_OBJS := fd.o null.o pty.o tty.o xterm.o slip_common.o
+# pcap_user.o must be added explicitly.
+USER_OBJS := fd.o null.o pty.o tty.o xterm.o slip_common.o pcap_user.o
 
 include arch/um/scripts/Makefile.rules
diff -puN arch/um/Kconfig_net~uml-reallow-pcap arch/um/Kconfig_net
--- linux-2.6.git-broken/arch/um/Kconfig_net~uml-reallow-pcap	2005-07-13 19:43:05.000000000 +0200
+++ linux-2.6.git-broken-paolo/arch/um/Kconfig_net	2005-07-13 19:43:05.000000000 +0200
@@ -135,7 +135,7 @@ config UML_NET_MCAST
 
 config UML_NET_PCAP
 	bool "pcap transport"
-	depends on UML_NET && BROKEN
+	depends on UML_NET && EXPERIMENTAL
 	help
 	The pcap transport makes a pcap packet stream on the host look
 	like an ethernet device inside UML.  This is useful for making 
diff -puN arch/um/Makefile~uml-reallow-pcap arch/um/Makefile
--- linux-2.6.git-broken/arch/um/Makefile~uml-reallow-pcap	2005-07-13 19:43:05.000000000 +0200
+++ linux-2.6.git-broken-paolo/arch/um/Makefile	2005-07-13 19:43:05.000000000 +0200
@@ -56,17 +56,21 @@ include $(srctree)/$(ARCH_DIR)/Makefile-
 core-y += $(SUBARCH_CORE)
 libs-y += $(SUBARCH_LIBS)
 
-# -Derrno=kernel_errno - This turns all kernel references to errno into
-# kernel_errno to separate them from the libc errno.  This allows -fno-common
-# in CFLAGS.  Otherwise, it would cause ld to complain about the two different
-# errnos.
+# -Dvmap=kernel_vmap affects everything, and prevents anything from
+# referencing the libpcap.o symbol so named.
 
 CFLAGS += $(CFLAGS-y) -D__arch_um__ -DSUBARCH=\"$(SUBARCH)\" \
-	$(ARCH_INCLUDE) $(MODE_INCLUDE)
+	$(ARCH_INCLUDE) $(MODE_INCLUDE) -Dvmap=kernel_vmap
 
 USER_CFLAGS := $(patsubst -I%,,$(CFLAGS))
 USER_CFLAGS := $(patsubst -D__KERNEL__,,$(USER_CFLAGS)) $(ARCH_INCLUDE) \
 	$(MODE_INCLUDE) $(ARCH_USER_CFLAGS)
+
+# -Derrno=kernel_errno - This turns all kernel references to errno into
+# kernel_errno to separate them from the libc errno.  This allows -fno-common
+# in CFLAGS.  Otherwise, it would cause ld to complain about the two different
+# errnos.
+
 CFLAGS += -Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask
 CFLAGS += $(call cc-option,-fno-unit-at-a-time,)
 
_


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
