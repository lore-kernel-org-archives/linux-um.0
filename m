Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CKvXz-0007bQ-5m for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 02:17:19 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CKvXx-0008Rp-7p for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 02:17:19 -0700
Message-ID: <4178D172.7020406@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
References: <20041021231834.9D3833F37@zion.localdomain>
In-Reply-To: <20041021231834.9D3833F37@zion.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [patch 1/1] SYSEMU: avoid intercepting syscall on
	return when using SYSCALL again.
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
Date: Fri, 22 Oct 2004 11:22:58 +0200
To: blaisorblade_spam@yahoo.it
Cc: user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com

blaisorblade_spam@yahoo.it wrote:
> From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
> 
> A guest process switching from using PTRACE_SYSEMU to PTRACE_SYSCALL crashes.
> 
> The problem is in arch/i386/kernel/entry.S. The current SYSEMU patch inhibits
> the syscall-handler to be called, but does not prevent do_syscall_trace to be
> called after this for syscall completion interception.
> 
> The appended patch fixes this. It reuses the flag TIF_SYSCALL_EMU to remember
> "we come from PTRACE_SYSEMU and now are in PTRACE_SYSCALL", since the flag is
> unused in the depicted situation.
> 
> The patch is tested, AFAICS, it works fine, i.e. sysemu can be switched on and
> off dynamically without crash.
> 
> Bodo
> 
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
> ---
> 
Fine idea to move one part of the patch to sys_ptrace()!
But maybe you missed to reset TIF_SYSCALL_EMU while resuming with PTRACE_CONT?
Here is a revised patch.

Bodo

---

--- a/arch/i386/kernel/ptrace.c	2004-10-20 16:57:25.000000000 +0200
+++ b/arch/i386/kernel/ptrace.c	2004-10-22 10:57:15.460287887 +0200
@@ -366,16 +366,21 @@ asmlinkage int sys_ptrace(long request,
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
-		}
-		else {
+		} else if (request == PTRACE_CONT) {
  			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
  		}
  		if (request == PTRACE_SYSCALL) {
  			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
-		}
-		else {
+		} else {
  			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
  		}
  		child->exit_code = data;
@@ -585,7 +590,7 @@ out:
  __attribute__((regparm(3)))
  int do_syscall_trace(struct pt_regs *regs, int entryexit)
  {
-	int is_sysemu;
+	int is_sysemu, is_systrace;
  	if (unlikely(current->audit_context)) {
  		if (!entryexit)
  			audit_syscall_entry(current, regs->orig_eax,
@@ -595,9 +600,19 @@ int do_syscall_trace(struct pt_regs *reg
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


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
