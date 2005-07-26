Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DxoIa-0003yu-5Y	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Jul 2005 08:58:24 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1DxoDU-0000uF-4x
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Jul 2005 08:53:09 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050726184349.53E4D21DC1C@zion.home.lan>
Subject: [uml-devel] [patch 2/4] Uml support: reorganize PTRACE_SYSEMU support
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
Date: Tue, 26 Jul 2005 20:43:49 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it, bstroesser@fujitsu-siemens.com


From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

With this patch, we change the way we handle switching from PTRACE_SYSEMU to
PTRACE_{SINGLESTEP,SYSCALL}, to free TIF_SYSCALL_EMU from double use as a
preparation for PTRACE_SYSEMU_SINGLESTEP extension, without changing the
behavior of the host kernel.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/i386/kernel/entry.S  |    8 ++++
 linux-2.6.git-paolo/arch/i386/kernel/ptrace.c |   43 ++++++++------------------
 2 files changed, 21 insertions(+), 30 deletions(-)

diff -puN arch/i386/kernel/entry.S~sysemu-reorganize arch/i386/kernel/entry.S
--- linux-2.6.git/arch/i386/kernel/entry.S~sysemu-reorganize	2005-07-26 20:25:58.000000000 +0200
+++ linux-2.6.git-paolo/arch/i386/kernel/entry.S	2005-07-26 20:25:58.000000000 +0200
@@ -339,12 +339,18 @@ syscall_trace_entry:
 	xorl %edx,%edx
 	call do_syscall_trace
 	cmpl $0, %eax
-	jne syscall_exit		# ret != 0 -> running under PTRACE_SYSEMU,
+	jne syscall_skip		# ret != 0 -> running under PTRACE_SYSEMU,
 					# so must skip actual syscall
 	movl ORIG_EAX(%esp), %eax
 	cmpl $(nr_syscalls), %eax
 	jnae syscall_call
 	jmp syscall_exit
+syscall_skip:
+	cli				# make sure we don't miss an interrupt
+					# setting need_resched or sigpending
+					# between sampling and the iret
+	movl TI_flags(%ebp), %ecx
+	jmp work_pending
 
 	# perform syscall exit tracing
 	ALIGN
diff -puN arch/i386/kernel/ptrace.c~sysemu-reorganize arch/i386/kernel/ptrace.c
--- linux-2.6.git/arch/i386/kernel/ptrace.c~sysemu-reorganize	2005-07-26 20:25:58.000000000 +0200
+++ linux-2.6.git-paolo/arch/i386/kernel/ptrace.c	2005-07-26 20:39:57.000000000 +0200
@@ -515,21 +515,14 @@ asmlinkage int sys_ptrace(long request, 
 		ret = -EIO;
 		if (!valid_signal(data))
 			break;
-		/* If we came here with PTRACE_SYSEMU and now continue with
-		 * PTRACE_SYSCALL, entry.S used to intercept the syscall return.
-		 * But it shouldn't!
-		 * So we don't clear TIF_SYSCALL_EMU, which is always unused in
-		 * this special case, to remember, we came from SYSEMU. That
-		 * flag will be cleared by do_syscall_trace().
-		 */
 		if (request == PTRACE_SYSEMU) {
 			set_tsk_thread_flag(child, TIF_SYSCALL_EMU);
-		} else if (request == PTRACE_CONT) {
-			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
-		}
-		if (request == PTRACE_SYSCALL) {
+			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+		} else if (request == PTRACE_SYSCALL) {
 			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
 		} else {
+			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
 			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		}
 		child->exit_code = data;
@@ -558,8 +551,7 @@ asmlinkage int sys_ptrace(long request, 
 		ret = -EIO;
 		if (!valid_signal(data))
 			break;
-		/*See do_syscall_trace to know why we don't clear
-		 * TIF_SYSCALL_EMU.*/
+		clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
 		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		set_singlestep(child);
 		child->exit_code = data;
@@ -694,7 +686,7 @@ void send_sigtrap(struct task_struct *ts
 __attribute__((regparm(3)))
 int do_syscall_trace(struct pt_regs *regs, int entryexit)
 {
-	int is_sysemu, is_systrace, is_singlestep, ret = 0;
+	int is_sysemu, is_singlestep, ret = 0;
 	/* do the secure computing check first */
 	secure_computing(regs->orig_eax);
 
@@ -705,25 +697,13 @@ int do_syscall_trace(struct pt_regs *reg
 		goto out;
 
 	is_sysemu = test_thread_flag(TIF_SYSCALL_EMU);
-	is_systrace = test_thread_flag(TIF_SYSCALL_TRACE);
 	is_singlestep = test_thread_flag(TIF_SINGLESTEP);
 
-	/* We can detect the case of coming from PTRACE_SYSEMU and now running
-	 * with PTRACE_SYSCALL or PTRACE_SINGLESTEP, by TIF_SYSCALL_EMU being
-	 * set additionally.
-	 * If so let's reset the flag and return without action (no singlestep
-	 * nor syscall tracing, since no actual step has been executed).
-	 */
-	if (is_sysemu && (is_systrace || is_singlestep)) {
-		clear_thread_flag(TIF_SYSCALL_EMU);
-		goto out;
-	}
-
 	/* Fake a debug trap */
-	if (test_thread_flag(TIF_SINGLESTEP))
+	if (is_singlestep)
 		send_sigtrap(current, regs, 0);
 
-	if (!is_systrace && !is_sysemu)
+ 	if (!test_thread_flag(TIF_SYSCALL_TRACE) && !is_sysemu)
 		goto out;
 
 	/* the 0x80 provides a way for the tracing parent to distinguish
@@ -745,5 +725,10 @@ int do_syscall_trace(struct pt_regs *reg
 	if (unlikely(current->audit_context) && !entryexit)
 		audit_syscall_entry(current, AUDIT_ARCH_I386, regs->orig_eax,
 				    regs->ebx, regs->ecx, regs->edx, regs->esi);
-	return ret;
+	if (ret == 0)
+		return 0;
+
+	if (unlikely(current->audit_context))
+		audit_syscall_exit(current, AUDITSC_RESULT(regs->eax), regs->eax);
+	return 1;
 }
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
