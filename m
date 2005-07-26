Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DxoIZ-00043r-55	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Jul 2005 08:58:23 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1DxoDd-0000uE-9v
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Jul 2005 08:53:19 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050726184352.2F0FD21DC1E@zion.home.lan>
Subject: [uml-devel] [patch 3/4] Uml support: add PTRACE_SYSEMU_SINGLESTEP
	option to i386
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
Date: Tue, 26 Jul 2005 20:43:52 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it, bstroesser@fujitsu-siemens.com


From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

This patch implements the new ptrace option PTRACE_SYSEMU_SINGLESTEP, which
can be used by UML to singlestep a process: it will receive SINGLESTEP
interceptions for normal instructions and syscalls, but syscall execution will
be skipped just like with PTRACE_SYSEMU.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/i386/kernel/ptrace.c |   21 +++++++++++++++++----
 linux-2.6.git-paolo/include/linux/ptrace.h    |    1 +
 2 files changed, 18 insertions(+), 4 deletions(-)

diff -puN arch/i386/kernel/ptrace.c~sysemu-add-SYSEMU_SINGLESTEP arch/i386/kernel/ptrace.c
--- linux-2.6.git/arch/i386/kernel/ptrace.c~sysemu-add-SYSEMU_SINGLESTEP	2005-07-26 20:27:45.000000000 +0200
+++ linux-2.6.git-paolo/arch/i386/kernel/ptrace.c	2005-07-26 20:39:55.000000000 +0200
@@ -547,11 +547,17 @@ asmlinkage int sys_ptrace(long request, 
 		wake_up_process(child);
 		break;
 
+	case PTRACE_SYSEMU_SINGLESTEP: /* Same as SYSEMU, but singlestep if not syscall */
 	case PTRACE_SINGLESTEP:	/* set the trap flag. */
 		ret = -EIO;
 		if (!valid_signal(data))
 			break;
-		clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+
+		if (request == PTRACE_SYSEMU_SINGLESTEP)
+			set_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+		else
+			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+
 		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		set_singlestep(child);
 		child->exit_code = data;
@@ -686,7 +692,10 @@ void send_sigtrap(struct task_struct *ts
 __attribute__((regparm(3)))
 int do_syscall_trace(struct pt_regs *regs, int entryexit)
 {
-	int is_sysemu, is_singlestep, ret = 0;
+	int is_sysemu = test_thread_flag(TIF_SYSCALL_EMU), ret = 0;
+	/* With TIF_SYSCALL_EMU set we want to ignore TIF_SINGLESTEP */
+	int is_singlestep = !is_sysemu && test_thread_flag(TIF_SINGLESTEP);
+
 	/* do the secure computing check first */
 	secure_computing(regs->orig_eax);
 
@@ -696,8 +705,11 @@ int do_syscall_trace(struct pt_regs *reg
 	if (!(current->ptrace & PT_PTRACED))
 		goto out;
 
-	is_sysemu = test_thread_flag(TIF_SYSCALL_EMU);
-	is_singlestep = test_thread_flag(TIF_SINGLESTEP);
+	/* If a process stops on the 1st tracepoint with SYSCALL_TRACE
+	 * and then is resumed with SYSEMU_SINGLESTEP, it will come in
+	 * here. We have to check this and return */
+	if (is_sysemu && entryexit)
+		return 0;
 
 	/* Fake a debug trap */
 	if (is_singlestep)
@@ -728,6 +740,7 @@ int do_syscall_trace(struct pt_regs *reg
 	if (ret == 0)
 		return 0;
 
+	regs->orig_eax = -1; /* force skip of syscall restarting */
 	if (unlikely(current->audit_context))
 		audit_syscall_exit(current, AUDITSC_RESULT(regs->eax), regs->eax);
 	return 1;
diff -puN include/linux/ptrace.h~sysemu-add-SYSEMU_SINGLESTEP include/linux/ptrace.h
--- linux-2.6.git/include/linux/ptrace.h~sysemu-add-SYSEMU_SINGLESTEP	2005-07-26 20:27:45.000000000 +0200
+++ linux-2.6.git-paolo/include/linux/ptrace.h	2005-07-26 20:27:45.000000000 +0200
@@ -21,6 +21,7 @@
 
 #define PTRACE_SYSCALL		  24
 #define PTRACE_SYSEMU		  31
+#define PTRACE_SYSEMU_SINGLESTEP  32
 
 /* 0x4200-0x4300 are reserved for architecture-independent additions.  */
 #define PTRACE_SETOPTIONS	0x4200
_


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
