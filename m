Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yehudasa@gmail.com>) id 1Lmuf7-0006Ap-ET
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Mar 2009 18:50:45 +0000
Received: from wa-out-1112.google.com ([209.85.146.179])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Lmuey-0004GH-OW for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Mar 2009 18:50:45 +0000
Received: by wa-out-1112.google.com with SMTP id j32so382985waf.10
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 26 Mar 2009 11:50:35 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 26 Mar 2009 11:50:34 -0700
Message-ID: <a37615150903261150x3642d954y296b6e8c26e53fe8@mail.gmail.com>
From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: [uml-devel] Networking issues with 2.6.29
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
To: user-mode-linux-devel@lists.sourceforge.net

Network doesn't seem to work for me in 2.6.29, although it was working
in 2.6.28. System behavior seemed really strange, as it sometimes did
work when I was using the same uml machine, when using a different
user. Bisecting the kernel tree, revels a seemingly unrelated commit
that when reverted it fixes the problem:

commit 470c66239ef0336429b35345f3f615d47341e13b
Author: David Brownell <dbrownell@users.sourceforge.net>
Date:   Mon Dec 1 14:31:37 2008 -0800

    genirq: warn when IRQF_DISABLED may be ignored
...
iff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c498a1b..7fd891c 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -635,6 +635,18 @@ int request_irq(unsigned int irq, irq_handler_t handler,
        struct irq_desc *desc;
        int retval;

+       /*
+        * handle_IRQ_event() always ignores IRQF_DISABLED except for
+        * the _first_ irqaction (sigh).  That can cause oopsing, but
+        * the behavior is classified as "will not fix" so we need to
+        * start nudging drivers away from using that idiom.
+        */
+       if ((irqflags & (IRQF_SHARED|IRQF_DISABLED))
+                       == (IRQF_SHARED|IRQF_DISABLED))
+               pr_warning("IRQ %d/%s: IRQF_DISABLED is not "
+                               "guaranteed on shared IRQs\n",
+                               irq, devname);
+
 #ifdef CONFIG_LOCKDEP
        /*
         * Lockdep wants atomic interrupt handlers:

I guess there are some timing issues?

Thanks,
Yehuda

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

