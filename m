Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1XfsC0-0006O4-3S
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 19 Oct 2014 15:14:48 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XfsBy-00078F-3e
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 19 Oct 2014 15:14:48 +0000
Received: from [94.219.115.221] (helo=[192.168.2.108])
	by www17.your-server.de with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80.1) (envelope-from <thomas@m3y3r.de>) id 1XfsBr-0005sP-BO
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 19 Oct 2014 17:14:39 +0200
Message-ID: <1413731653.2991.24.camel@localhost.localdomain>
From: Thomas Meyer <thomas@m3y3r.de>
Date: Sun, 19 Oct 2014 17:14:13 +0200
Mime-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH v3 3/3] um: enable trace irqflags support
To: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

Add TRACE_IRQFLAGS_SUPPORT to UML.
This enables LOCKDEP_SUPPORT and TRACING_SUPPORT.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---
diff --git a/arch/um/Kconfig.common b/arch/um/Kconfig.common
index 87bc868..6a33c3a 100644
--- a/arch/um/Kconfig.common
+++ b/arch/um/Kconfig.common
@@ -28,10 +28,9 @@ config PCI
 config PCMCIA
 	bool
 
-# Yet to do!
 config TRACE_IRQFLAGS_SUPPORT
 	bool
-	default n
+	default y
 
 config LOCKDEP_SUPPORT
 	bool
diff --git a/arch/um/include/asm/irqflags.h b/arch/um/include/asm/irqflags.h
index c780d8a..c5b636e 100644
--- a/arch/um/include/asm/irqflags.h
+++ b/arch/um/include/asm/irqflags.h
@@ -34,9 +34,9 @@ static inline unsigned long arch_local_irq_save(void)
 	return flags;
 }
 
-static inline bool arch_irqs_disabled(void)
+static inline int arch_irqs_disabled_flags(unsigned long flags)
 {
-	return arch_local_save_flags() == 0;
+	return flags == 0;
 }
 
 #endif
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index f1efeee..fc188d8 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -251,6 +251,9 @@ static struct notifier_block panic_exit_notifier = {
 
 void uml_finishsetup(void)
 {
+#ifdef CONFIG_LOCKDEP
+	lockdep_init();
+#endif
 	atomic_notifier_chain_register(&panic_notifier_list,
 				       &panic_exit_notifier);
 



------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

