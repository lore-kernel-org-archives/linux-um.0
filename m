Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CKmDj-0005Z0-W6 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Oct 2004 16:19:47 -0700
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]
	helo=zion.localdomain)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CKmDh-00010I-PG for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Oct 2004 16:19:47 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20041021231834.9D3833F37@zion.localdomain>
Subject: [uml-devel] [patch 1/1] SYSEMU: avoid intercepting syscall on return
	when using SYSCALL again.
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
Date: Fri, 22 Oct 2004 01:18:34 +0200
To: bstroesser@fujitsu-siemens.com
Cc: user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com, blaisorblade_spam@yahoo.it


From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

A guest process switching from using PTRACE_SYSEMU to PTRACE_SYSCALL crashes.

The problem is in arch/i386/kernel/entry.S. The current SYSEMU patch inhibits
the syscall-handler to be called, but does not prevent do_syscall_trace to be
called after this for syscall completion interception.

The appended patch fixes this. It reuses the flag TIF_SYSCALL_EMU to remember
"we come from PTRACE_SYSEMU and now are in PTRACE_SYSCALL", since the flag is
unused in the depicted situation.

The patch is tested, AFAICS, it works fine, i.e. sysemu can be switched on and
off dynamically without crash.

Bodo

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.7-SKAS-paolo/arch/i386/kernel/ptrace.c |   28 +++++++++++----
 1 files changed, 21 insertions(+), 7 deletions(-)

diff -puN arch/i386/kernel/ptrace.c~avoid-intercepting-syscall-on-return-when-changing-state arch/i386/kernel/ptrace.c
--- vanilla-linux-2.6.7-SKAS/arch/i386/kernel/ptrace.c~avoid-intercepting-syscall-on-return-when-changing-state	2004-10-22 00:55:06.632837000 +0200
+++ vanilla-linux-2.6.7-SKAS-paolo/arch/i386/kernel/ptrace.c	2004-10-22 01:12:48.391425160 +0200
@@ -366,16 +366,20 @@ asmlinkage int sys_ptrace(long request, 
 		ret = -EIO;
 		if ((unsigned long) data > _NSIG)
 			break;
+		/* If we came here with PTRACE_SYSEMU and now continue with
+		 * PTRACE_SYSCALL, entry.S used to intercept the syscall return. But it
+		 * shouldn't!
+		 * So we don't clear TIF_SYSCALL_EMU, which is always unused in this
+		 * special case, to remember, we came from SYSEMU. That flag
+		 * will be cleared by do_syscall_trace().
+		 */
 		if (request == PTRACE_SYSEMU) {
 			set_tsk_thread_flag(child, TIF_SYSCALL_EMU);
 		}
-		else {
-			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
-		}
+
 		if (request == PTRACE_SYSCALL) {
 			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
-		}
-		else {
+		} else {
 			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		}
 		child->exit_code = data;
@@ -585,7 +589,7 @@ out:
 __attribute__((regparm(3)))
 int do_syscall_trace(struct pt_regs *regs, int entryexit)
 {
-	int is_sysemu;
+	int is_sysemu, is_systrace;
 	if (unlikely(current->audit_context)) {
 		if (!entryexit)
 			audit_syscall_entry(current, regs->orig_eax,
@@ -595,9 +599,19 @@ int do_syscall_trace(struct pt_regs *reg
 			audit_syscall_exit(current, regs->eax);
 	}
 	is_sysemu = test_thread_flag(TIF_SYSCALL_EMU);
+	is_systrace = test_thread_flag(TIF_SYSCALL_TRACE);
 
-	if (!test_thread_flag(TIF_SYSCALL_TRACE) && !is_sysemu)
+	if (!is_systrace && !is_sysemu)
 		return 0;
+	/* We can detect the case of coming from PTRACE_SYSEMU and now
+	 * running with PTRACE_SYSCALL, by TIF_SYSCALL_EMU being set
+	 * additionally.
+	 * If so let's reset the flag and return without action.
+	 */
+	if (is_sysemu && is_systrace) {
+		clear_thread_flag(TIF_SYSCALL_EMU);
+		return 0;
+	}
 	if (!(current->ptrace & PT_PTRACED))
 		return 0;
 	/* the 0x80 provides a way for the tracing parent to distinguish
_


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
