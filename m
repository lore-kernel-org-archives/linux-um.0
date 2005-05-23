Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DaHTG-0007kp-9y	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 May 2005 11:16:10 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DaHTF-0006u8-I6	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 May 2005 11:16:10 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_I5hkCFNQwIJ2YAE"
Message-Id: <200505232017.44919.blaisorblade@yahoo.it>
Subject: [uml-devel] pcap transport support
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
Date: Mon, 23 May 2005 20:17:44 +0200
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

--Boundary-00=_I5hkCFNQwIJ2YAE
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Please try the attached patch for it... it's done on top of 2.6.11-bs*.

Remember to run UML as root as otherwise libpcap can't work... the stack trace 
you get otherwise is scaring.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_I5hkCFNQwIJ2YAE
Content-Type: text/x-diff;
  charset="us-ascii";
  name="uml-reallow-pcap.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-reallow-pcap.patch"



Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 clean-linux-2.6.11-paolo/arch/um/Kconfig_net      |    2 +-
 clean-linux-2.6.11-paolo/arch/um/Makefile         |   14 +++++++++-----
 clean-linux-2.6.11-paolo/arch/um/drivers/Makefile |   17 ++++++++++++++---
 3 files changed, 24 insertions(+), 9 deletions(-)

diff -puN arch/um/drivers/Makefile~uml-reallow-pcap arch/um/drivers/Makefile
--- clean-linux-2.6.11/arch/um/drivers/Makefile~uml-reallow-pcap	2005-05-19 18:23:17.000000000 +0200
+++ clean-linux-2.6.11-paolo/arch/um/drivers/Makefile	2005-05-19 18:27:33.000000000 +0200
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
 
+LDFLAGS_pcap.o := -r -lpcap -L/usr/lib
+
+$(obj)/pcap.o: $(obj)/pcap_kern.o $(obj)/pcap_user.o
+	$(LD) -r -dp -o $@ $^ $(LDFLAGS_pcap.o)
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
@@ -26,7 +36,7 @@ obj-$(CONFIG_UML_NET_SLIP) += slip.o
 obj-$(CONFIG_UML_NET_SLIRP) += slirp.o
 obj-$(CONFIG_UML_NET_DAEMON) += daemon.o 
 obj-$(CONFIG_UML_NET_MCAST) += mcast.o 
-#obj-$(CONFIG_UML_NET_PCAP) += pcap.o $(PCAP)
+obj-$(CONFIG_UML_NET_PCAP) += pcap.o
 obj-$(CONFIG_UML_NET) += net.o 
 obj-$(CONFIG_MCONSOLE) += mconsole.o
 obj-$(CONFIG_MMAPPER) += mmapper_kern.o 
@@ -41,6 +51,7 @@ obj-$(CONFIG_UML_WATCHDOG) += harddog.o
 obj-$(CONFIG_BLK_DEV_COW_COMMON) += cow_user.o
 
 
-USER_OBJS := fd.o null.o pty.o tty.o xterm.o
+# pcap_user.o must be added explicitly.
+USER_OBJS := fd.o null.o pty.o tty.o xterm.o pcap_user.o
 
 include arch/um/scripts/Makefile.rules
diff -puN arch/um/Kconfig_net~uml-reallow-pcap arch/um/Kconfig_net
--- clean-linux-2.6.11/arch/um/Kconfig_net~uml-reallow-pcap	2005-05-19 18:23:17.000000000 +0200
+++ clean-linux-2.6.11-paolo/arch/um/Kconfig_net	2005-05-19 18:23:17.000000000 +0200
@@ -135,7 +135,7 @@ config UML_NET_MCAST
 
 config UML_NET_PCAP
 	bool "pcap transport"
-	depends on UML_NET && BROKEN
+	depends on UML_NET
 	help
 	The pcap transport makes a pcap packet stream on the host look
 	like an ethernet device inside UML.  This is useful for making 
diff -puN arch/um/Makefile~uml-reallow-pcap arch/um/Makefile
--- clean-linux-2.6.11/arch/um/Makefile~uml-reallow-pcap	2005-05-19 18:23:17.000000000 +0200
+++ clean-linux-2.6.11-paolo/arch/um/Makefile	2005-05-19 18:23:17.000000000 +0200
@@ -51,17 +51,21 @@ include $(srctree)/$(ARCH_DIR)/Makefile-
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

--Boundary-00=_I5hkCFNQwIJ2YAE--




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
