Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DxoIY-0003xC-RV	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Jul 2005 08:58:22 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1DxoDd-0000uG-Aw
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Jul 2005 08:53:21 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050726184354.D584D21DC20@zion.home.lan>
Subject: [uml-devel] [patch 4/4] SYSEMU: fix sysaudit / singlestep interaction
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
Date: Tue, 26 Jul 2005 20:43:54 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it, bstroesser@fujitsu-siemens.com, roland@redhat.com


From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
CC: Roland McGrath <roland@redhat.com>

This is simply an adjustment for "Ptrace - i386: fix Syscall Audit interaction
with singlestep" to work on top of SYSEMU patches, too. On this patch, I have
some doubts: I wonder why we need to alter that way ptrace_disable().

I left the patch this way because it has been extensively tested, but I don't
understand the reason.

The current PTRACE_DETACH handling simply clears child->ptrace; actually this
is not enough because entry.S just looks at the thread_flags; actually,
do_syscall_trace checks current->ptrace but I don't think depending on that is
good, at least for performance, so I think the clearing is done elsewhere. For
instance, on PTRACE_CONT it's done, but doing PTRACE_DETACH without
PTRACE_CONT is possible (and happens when gdb crashes and one kills it
manually).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/i386/kernel/ptrace.c |   23 ++++++++++++++++++++---
 1 files changed, 20 insertions(+), 3 deletions(-)

diff -puN arch/i386/kernel/ptrace.c~sysaudit-singlestep-umlhost arch/i386/kernel/ptrace.c
--- linux-2.6.git/arch/i386/kernel/ptrace.c~sysaudit-singlestep-umlhost	2005-07-26 20:27:56.000000000 +0200
+++ linux-2.6.git-paolo/arch/i386/kernel/ptrace.c	2005-07-26 20:27:56.000000000 +0200
@@ -271,6 +271,8 @@ static void clear_singlestep(struct task
 void ptrace_disable(struct task_struct *child)
 { 
 	clear_singlestep(child);
+	clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+	clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
 }
 
 /*
@@ -693,14 +695,29 @@ __attribute__((regparm(3)))
 int do_syscall_trace(struct pt_regs *regs, int entryexit)
 {
 	int is_sysemu = test_thread_flag(TIF_SYSCALL_EMU), ret = 0;
-	/* With TIF_SYSCALL_EMU set we want to ignore TIF_SINGLESTEP */
+	/* With TIF_SYSCALL_EMU set we want to ignore TIF_SINGLESTEP for syscall
+	 * interception. */
 	int is_singlestep = !is_sysemu && test_thread_flag(TIF_SINGLESTEP);
 
 	/* do the secure computing check first */
 	secure_computing(regs->orig_eax);
 
-	if (unlikely(current->audit_context) && entryexit)
-		audit_syscall_exit(current, AUDITSC_RESULT(regs->eax), regs->eax);
+	if (unlikely(current->audit_context)) {
+		if (entryexit)
+			audit_syscall_exit(current, AUDITSC_RESULT(regs->eax), regs->eax);
+		/* Debug traps, when using PTRACE_SINGLESTEP, must be sent only
+		 * on the syscall exit path. Normally, when TIF_SYSCALL_AUDIT is
+		 * not used, entry.S will call us only on syscall exit, not
+		 * entry; so when TIF_SYSCALL_AUDIT is used we must avoid
+		 * calling send_sigtrap() on syscall entry.
+		 *
+		 * Note that when PTRACE_SYSEMU_SINGLESTEP is used,
+		 * is_singlestep is false, despite his name, so we will still do
+		 * the correct thing.
+		 */
+		else if (is_singlestep)
+			goto out;
+	}
 
 	if (!(current->ptrace & PT_PTRACED))
 		goto out;
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
