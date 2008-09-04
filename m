Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KbIXJ-0007mA-Sd for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Sep 2008 10:22:25 -0700
Received: from mail-gx0-f19.google.com ([209.85.217.19])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KbIXJ-0005ae-HT
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Sep 2008 10:22:25 -0700
Received: by gxk12 with SMTP id 12so6473751gxk.10
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 04 Sep 2008 10:22:20 -0700 (PDT)
Message-ID: <ea9232d10809041022l6bc28962sd6a0c1209c8032f6@mail.gmail.com>
Date: Thu, 4 Sep 2008 19:22:19 +0200
From: "Karol Swietlicki" <magotari@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH] Removing an unused return value of do_IRQ.
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

do_IRQ can be a void function, the return value is never used.
Compile tested.

Karol Swietlicki

Signed-off-by: Karol Swietlicki <magotari@gmail.com>
---
diff -rupN linux27r1m1-original/arch/um/include/kern_util.h
linux-2.6.27-rc1-mm1/arch/um/include/kern_util.h
--- linux27r1m1-original/arch/um/include/kern_util.h	2008-09-04
18:32:48.000000000 +0200
+++ linux-2.6.27-rc1-mm1/arch/um/include/kern_util.h	2008-09-04
18:47:16.000000000 +0200
@@ -30,7 +30,7 @@ extern unsigned long segv(struct faultin
 extern int handle_page_fault(unsigned long address, unsigned long ip,
 			     int is_write, int is_user, int *code_out);

-extern unsigned int do_IRQ(int irq, struct uml_pt_regs *regs);
+extern void do_IRQ(int irq, struct uml_pt_regs *regs);
 extern int smp_sigio_handler(void);
 extern void initial_thread_cb(void (*proc)(void *), void *arg);
 extern int is_syscall(unsigned long addr);
diff -rupN linux27r1m1-original/arch/um/kernel/irq.c
linux-2.6.27-rc1-mm1/arch/um/kernel/irq.c
--- linux27r1m1-original/arch/um/kernel/irq.c	2008-09-04
18:32:48.000000000 +0200
+++ linux-2.6.27-rc1-mm1/arch/um/kernel/irq.c	2008-09-04
18:46:13.000000000 +0200
@@ -328,14 +328,13 @@ int deactivate_all_fds(void)
  * SMP cross-CPU interrupts have their own specific
  * handlers).
  */
-unsigned int do_IRQ(int irq, struct uml_pt_regs *regs)
+void do_IRQ(int irq, struct uml_pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs((struct pt_regs *)regs);
 	irq_enter();
 	__do_IRQ(irq);
 	irq_exit();
 	set_irq_regs(old_regs);
-	return 1;
 }

 int um_request_irq(unsigned int irq, int fd, int type,

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
