Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cp6wG-0005af-Bt for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 07:31:08 -0800
Received: from www.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1Cp6wC-0005zS-G0 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 07:31:07 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20050113051330.097A36324D@zion>
Subject: [uml-devel] [patch 3/8] uml: Commentary addition to recent SYSEMU fix.
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
Date: Thu, 13 Jan 2005 06:13:29 +0100
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>

Add some comments about the "uml-sysemu-fixes" patch of 2.6.10-mm1 (merged in 2.6.11-rc1).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/kernel/tt/tracer.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+)

diff -puN arch/um/kernel/tt/tracer.c~uml-comment-fix-sysemu-tt arch/um/kernel/tt/tracer.c
--- linux-2.6.11/arch/um/kernel/tt/tracer.c~uml-comment-fix-sysemu-tt	2005-01-13 01:56:56.494835760 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/tt/tracer.c	2005-01-13 01:56:56.498835152 +0100
@@ -313,6 +313,15 @@ int tracer(int (*init_proc)(void *), voi
 				sig = 0;
 				op = do_proc_op(task, proc_id);
 				switch(op){
+				/*
+				 * This is called when entering user mode; after
+				 * this, we start intercepting syscalls.
+				 *
+				 * In fact, a process is started in kernel mode,
+				 * so with is_tracing() == 0 (and that is reset
+				 * when executing syscalls, since UML kernel has
+				 * the right to do syscalls);
+				 */
 				case OP_TRACE_ON:
 					arch_leave_kernel(task, pid);
 					tracing = 1;
@@ -347,6 +356,11 @@ int tracer(int (*init_proc)(void *), voi
 					continue;
 				}
 				tracing = 0;
+				/* local_using_sysemu has been already set
+				 * below, since if we are here, is_tracing() on
+				 * the traced task was 1, i.e. the process had
+				 * already run through one iteration of the
+				 * loop which executed a OP_TRACE_ON request.*/
 				do_syscall(task, pid, local_using_sysemu);
 				sig = SIGUSR2;
 				break;
_


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
