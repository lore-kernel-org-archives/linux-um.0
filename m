Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ey0e7-0002kx-ME for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 14 Jan 2006 21:41:43 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ey0e5-0004V4-CF
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 14 Jan 2006 21:41:43 -0800
Message-Id: <200601150633.k0F6Xa4u015465@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 2/3] UML - Use generic sys_rt_sigsuspend
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
Date: Sun, 15 Jan 2006 01:33:36 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Miklos Szeredi <miklos@szeredi.hu>, dwmw2@infradead.org, David Howells <dhowells@redhat.com>, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, Linus Torvalds <torvalds@osdl.org>

Use the generic sys_rt_sigsuspend.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15-mm/arch/um/kernel/signal_kern.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/signal_kern.c	2006-01-14 19:06:20.000000000 -0500
+++ linux-2.6.15-mm/arch/um/kernel/signal_kern.c	2006-01-14 19:07:05.000000000 -0500
@@ -185,30 +185,6 @@ long sys_sigsuspend(int history0, int hi
 	return -ERESTARTNOHAND;
 }
 
-long sys_rt_sigsuspend(sigset_t __user *unewset, size_t sigsetsize)
-{
-	sigset_t newset;
-
-	/* XXX: Don't preclude handling different sized sigset_t's.  */
-	if (sigsetsize != sizeof(sigset_t))
-		return -EINVAL;
-
-	if (copy_from_user(&newset, unewset, sizeof(newset)))
-		return -EFAULT;
-	sigdelsetmask(&newset, ~_BLOCKABLE);
-
-	spin_lock_irq(&current->sighand->siglock);
-	current->saved_sigmask = current->blocked;
-	current->blocked = newset;
-	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
-
-	current->state = TASK_INTERRUPTIBLE;
-	schedule();
-	set_thread_flag(TIF_RESTORE_SIGMASK);
-	return -ERESTARTNOHAND;
-}
-
 long sys_sigaltstack(const stack_t __user *uss, stack_t __user *uoss)
 {
 	return(do_sigaltstack(uss, uoss, PT_REGS_SP(&current->thread.regs)));
Index: linux-2.6.15-mm/include/asm-um/unistd.h
===================================================================
--- linux-2.6.15-mm.orig/include/asm-um/unistd.h	2006-01-14 18:50:04.000000000 -0500
+++ linux-2.6.15-mm/include/asm-um/unistd.h	2006-01-14 19:06:46.000000000 -0500
@@ -34,6 +34,7 @@ extern int um_execve(const char *file, c
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
 #define __ARCH_WANT_SYS_RT_SIGACTION
+#define __ARCH_WANT_SYS_RT_SIGSUSPEND
 #endif
 
 #ifdef __KERNEL_SYSCALLS__



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
