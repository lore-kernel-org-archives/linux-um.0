Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AwPWR-0001Mi-6G for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Feb 2004 09:42:07 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AwPMw-0005j4-02
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Feb 2004 09:32:18 -0800
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20040226180157.GA3192@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [PATCH] fix for 2.6 scheduler crashes
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
Date: Thu, 26 Feb 2004 13:01:57 -0500
To: wstearns@pobox.com, blaisorblade_spam@yahoo.it, user-mode-linux-devel@lists.sourceforge.net

The patch below fixes the 2.6 scheduler crash.  It's another subtle signal
problem.  This one is caused by siglongjmp restoring the old signal mask
before calling longjmp.  See the comment for the gory details.  I've had
the stress test running for more than an hour with this patch.  Without it,
it would be lucky to go for five minutes.

				Jeff


===== arch/um/include/signal_user.h 1.1 vs edited =====
--- 1.1/arch/um/include/signal_user.h   Fri Sep  6 13:29:28 2002
+++ edited/arch/um/include/signal_user.h        Tue Feb 24 23:02:49 2004
@@ -11,6 +11,8 @@
 extern int change_sig(int signal, int on);
 extern void set_sigstack(void *stack, int size);
 extern void set_handler(int sig, void (*handler)(int), int flags, ...);
+extern int set_signals(int enable);
+extern int get_signals(void);
 
 #endif
 
===== arch/um/kernel/time_kern.c 1.12 vs edited =====
--- 1.12/arch/um/kernel/time_kern.c     Thu Jan  8 07:43:01 2004
+++ edited/arch/um/kernel/time_kern.c   Tue Feb 24 08:48:39 2004
@@ -102,10 +102,12 @@
 
 irqreturn_t um_timer(int irq, void *dev, struct pt_regs *regs)
 {
+       unsigned long flags;
+
        do_timer(regs);
-       write_seqlock_irq(&xtime_lock);
+       write_seqlock_irqsave(&xtime_lock, flags);
        timer();
-       write_sequnlock_irq(&xtime_lock);
+       write_sequnlock_irqrestore(&xtime_lock, flags);
        return(IRQ_HANDLED);
 }
 
===== arch/um/kernel/skas/process.c 1.9 vs edited =====
--- 1.9/arch/um/kernel/skas/process.c   Thu Jan  8 07:43:01 2004
+++ edited/arch/um/kernel/skas/process.c        Tue Feb 24 23:00:59 2004
@@ -188,13 +188,25 @@
 void new_thread(void *stack, void **switch_buf_ptr, void **fork_buf_ptr,
                void (*handler)(int))
 {
+       unsigned long flags;
        jmp_buf switch_buf, fork_buf;
 
        *switch_buf_ptr = &switch_buf;
        *fork_buf_ptr = &fork_buf;
 
+       /* Somewhat subtle - siglongjmp restores the signal mask before doing
+        * the longjmp.  This means that when jumping from one stack to another
+        * when the target stack has interrupts enabled, an interrupt may occur
+        * on the source stack.  This is bad when starting up a process because
+        * it's not supposed to get timer ticks until it has been scheduled.
+        * So, we disable interrupts around the sigsetjmp to ensure that 
+        * they can't happen until we get back here where they are safe.
+        */
+       flags = get_signals();
+       block_signals();
        if(sigsetjmp(fork_buf, 1) == 0)
                new_thread_proc(stack, handler);
+       set_signals(flags);
 
        remove_sigstack();
 }


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
