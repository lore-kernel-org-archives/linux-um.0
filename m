Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-Id: <200501121856.j0CIuMiZ003766@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH] Fix stack corruption
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
Date: Wed, 12 Jan 2005 13:56:22 -0500
To: caker@linode.com
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

This patch fixes a long-standing problem in skas mode process creation.  Chris
Aker has been seeing it at linode, and found a way of reproducing it.  Once
I spotted the bug, I found an easier way:

ping flood the UML from the host while running
	while true; do ls > /dev/null; done

In 10-15 seconds, UML will simply exit back to the shell with a segfault,
no panic, no output, no nothing.

When UML sets up the kernel stack for a new process, it sends itself a 
SA_ONSTACK signal with the signal stack being the new kernel stack.  It 
calls setjmp there to set up a context that it can longjmp to when the new
process is run for the first time.

The problem was that, while signals were blocked during this, they were 
re-enabled before SA_ONSTACK was disabled.  Thus, a signal arriving at the
wrong time, between signals being turned on and SA_ONSTACK being disabled,
would cause the signal to be handled on the stack, destroying the context
that had been set up there.

When the new process ran, it would longjmp to this trashed stack, and UML
would die.

The fix is obvious:

Index: 2.6.10/arch/um/kernel/skas/process.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/skas/process.c	2005-01-12 11:17:22.000000000 -0500
+++ 2.6.10/arch/um/kernel/skas/process.c	2005-01-12 11:18:03.000000000 -0500
@@ -323,9 +323,10 @@
 	block_signals();
 	if(sigsetjmp(fork_buf, 1) == 0)
 		new_thread_proc(stack, handler);
-	set_signals(flags);
 
 	remove_sigstack();
+
+	set_signals(flags);
 }
 
 void thread_wait(void *sw, void *fb)

				Jeff



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
