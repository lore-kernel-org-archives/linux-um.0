Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sardok@gmail.com>) id 1U3EaB-0004wE-7q
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Feb 2013 23:39:15 +0000
Received: from mail-ee0-f42.google.com ([74.125.83.42])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1U3Ea9-0007FB-D2
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Feb 2013 23:39:15 +0000
Received: by mail-ee0-f42.google.com with SMTP id b47so1028874eek.1
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 06 Feb 2013 15:39:07 -0800 (PST)
From: Sinan Nalkaya <sardok@gmail.com>
Date: Thu,  7 Feb 2013 01:39:00 +0200
Message-Id: <1360193940-31504-1-git-send-email-sardok@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH 1/1] um: Fix broken IRQs if SPARSE_IRQ is
	selected
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net, Sinan Nalkaya <sardok@gmail.com>

um: Kconfig.common: enabled SPARSE_IRQ.
um: kernel/irq: arch_probe_nr_irqs is implemented to prevent use of the default.

Signed-off-by: Sinan Nalkaya <sardok@gmail.com>
---
 arch/um/Kconfig.common |    1 +
 arch/um/kernel/irq.c   |    7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/um/Kconfig.common b/arch/um/Kconfig.common
index 648121b..8335fdd 100644
--- a/arch/um/Kconfig.common
+++ b/arch/um/Kconfig.common
@@ -12,6 +12,7 @@ config UML
 	select GENERIC_CPU_DEVICES
 	select GENERIC_IO
 	select GENERIC_CLOCKEVENTS
+	select SPARSE_IRQ
 
 config MMU
 	bool
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 36e12f0..93615f0 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -356,6 +356,13 @@ void __init init_IRQ(void)
 		irq_set_chip_and_handler(i, &normal_irq_type, handle_edge_irq);
 }
 
+#ifdef CONFIG_SPARSE_IRQ
+int __init arch_probe_nr_irqs(void)
+{
+	return NR_IRQS;
+}
+#endif
+
 /*
  * IRQ stack entry and exit:
  *
-- 
1.7.10.4


------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

