Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNJKq-0007eF-CM for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 16:05:36 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CNJKn-0007nO-Bn for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 16:05:36 -0700
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [patch 1/1] SYSEMU: avoid intercepting syscall on
	return when using SYSCALL again.
References: <20041021231834.9D3833F37@zion.localdomain>
	<41793409.70001@fujitsu-siemens.com>
	<417FAEFD.8070805@fujitsu-siemens.com>
In-Reply-To: <417FAEFD.8070805@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_2rXgBjxiMzcF5A5"
Message-Id: <200410290104.22725.blaisorblade_spam@yahoo.it>
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
Date: Fri, 29 Oct 2004 01:04:22 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, jdike@addtoit.com

--Boundary-00=_2rXgBjxiMzcF5A5
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 27 October 2004 16:21, Bodo Stroesser wrote:
> Bodo Stroesser wrote:
> > BlaisorBlade wrote:
> >> Yes - I forgot it. Does the revised version work? My version did not -
> >> it failed the startup test. In fact, PTRACE_CONT is called in the
> >> startup test (which fails). I'm recompiling and testing.

> > Yes. My system works very fine with it.

> Now I've tested with host 2.6.9 and skas3.v6 patch. I adapted my latest
> patch and had problems with singlestepping on UML in SKAS with sSYSEMU.
> It looped receiving SIGTRAPs without moving forward. EIP of the traced
> process was the same for all SIGTRAPs.

> What's missing is to handle switching from PTRACE_SYSCALL_EMU to
> PTRACE_SINGLESTEP in a way very similar to what is done for the change
> from PTRACE_SYSCALL_EMU to PTRACE_SYSCALL_TRACE.

> Here is the corresponding patch.

Ok, I separated it from the other one.

> P.S.: When testing UML 2.6.9 in SAKS on host 2.6.9, UML didn't terminate
> after init 0. kernel-process and userspace-process didn't go out at the
> end. ps aux shows S+ for kernel and T+ for userspace. I only could kill
> them with kill -9 kernel-pid. After having done this, the host can't
> unmount its filesystems: "in use". Doesn't that look like a host-bug?

No, simply UML should use PTRACE_KILL rather than sending SIGKILL itself. It 
always just *happened* to work.

I was just about to release -v7 - I'll hold on it a bit more to include your 
fix. Then I'll do releases for 2.6.7 and 2.6.9.

> --- a/arch/i386/kernel/ptrace.c 2004-10-27 10:13:55.515622561 +0200
> +++ b/arch/i386/kernel/ptrace.c 2004-10-27 10:21:01.958150451 +0200
> @@ -367,16 +367,21 @@ asmlinkage int sys_ptrace(long request,
>     ret = -EIO;
>     if ((unsigned long) data > _NSIG)
>      break;
> +  /* If we came here with PTRACE_SYSEMU and now continue with
> +   * PTRACE_SYSCALL, entry.S used to intercept the syscall return. But it
> +   * shouldn't!
> +   * So we don't clear TIF_SYSCALL_EMU, which is always unused in this
> +   * special case, to remember, we came from SYSEMU. That flag
> +   * will be cleared by do_syscall_trace().
> +   */

I updated this comment. Also, I'm thinking to the PTRACE_CONT case: shouldn't 
it get the same special treatment? Ok, probably not, because I guess we won't 
be running do_syscall_trace in that case. After that, it seems there is no 
other way to wake up a process, right? If there is anything else, then we 
need to fix that, too.

I have idea we need something more robust, i.e. a return path avoiding 
altogether the 2nd do_syscall_trace call, like it happened in 2.4.

Now, My Mighty Bodo, after cleaning up the issues about collecting your 
patches, could you try to understand also why strace does not work with 
SYSEMU on? Even switching SYSEMU off through /proc/sysemu avoids that. It 
seems to be a guest-only problem, since the UML debugger code seems totally 
unrelated to the syscall interception on the host.

Also, something strange is that when not enabling network support, strace 
printed out some network syscalls, with bogus return values, even with SYSEMU 
active.

Bye and thanks again!
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_2rXgBjxiMzcF5A5
Content-Type: text/x-diff; charset="iso-8859-1";
	name="fix-singlestep-after-sysemu.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="fix-singlestep-after-sysemu.patch"


From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

When testing 2.6.9 and the skas3.v6 patch, with my latest
patch and had problems with singlestepping on UML in SKAS with SYSEMU.
It looped receiving SIGTRAPs without moving forward. EIP of the traced
process was the same for all SIGTRAPs.

What's missing is to handle switching from PTRACE_SYSCALL_EMU to
PTRACE_SINGLESTEP in a way very similar to what is done for the change
from PTRACE_SYSCALL_EMU to PTRACE_SYSCALL_TRACE.

I.e., after calling ptrace(PTRACE_SYSEMU), on the return path, the debugger is
notified and then wake ups the process; the syscall is executed (or skipped,
when do_syscall_trace returns 0, i.e. when using PTRACE_SYSEMU), and
do_syscall_trace is called again. Since we are on the return path of a
SYSEMU'd syscall, if the wake up is performed through ptrace(PTRACE_SYSCALL),
we must still avoid notifying the parent of the syscall exit. Now, this
behaviour is extended even to resuming with PTRACE_SINGLESTEP.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/i386/kernel/ptrace.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff -puN arch/i386/kernel/ptrace.c~fix-singlestep-after-sysemu arch/i386/kernel/ptrace.c
--- vanilla-linux-2.6.9/arch/i386/kernel/ptrace.c~fix-singlestep-after-sysemu	2004-10-29 00:43:51.000000000 +0200
+++ vanilla-linux-2.6.9-paolo/arch/i386/kernel/ptrace.c	2004-10-29 00:52:30.744281064 +0200
@@ -419,7 +419,8 @@ asmlinkage int sys_ptrace(long request, 
 		ret = -EIO;
 		if ((unsigned long) data > _NSIG)
 			break;
-		clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+		/*See do_syscall_trace to know why we don't clear
+		 * TIF_SYSCALL_EMU.*/
 		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		if ((child->ptrace & PT_DTRACE) == 0) {
 			/* Spurious delayed TF traps may occur */
@@ -543,7 +544,7 @@ out:
 __attribute__((regparm(3)))
 int do_syscall_trace(struct pt_regs *regs, int entryexit)
 {
-	int is_sysemu, is_systrace;
+	int is_sysemu, is_systrace, is_singlestep;
 	if (unlikely(current->audit_context)) {
 		if (!entryexit)
 			audit_syscall_entry(current, regs->orig_eax,
@@ -554,17 +555,16 @@ int do_syscall_trace(struct pt_regs *reg
 	}
 	is_sysemu = test_thread_flag(TIF_SYSCALL_EMU);
 	is_systrace = test_thread_flag(TIF_SYSCALL_TRACE);
+	is_singlestep = test_thread_flag(TIF_SINGLESTEP);
 
-	if (!is_systrace &&
-	    !test_thread_flag(TIF_SINGLESTEP) &&
-	    !is_sysemu)
+	if (!is_systrace && !is_singlestep && !is_sysemu)
 		return 0;
-	/* We can detect the case of coming from PTRACE_SYSEMU and now
-	 * running with PTRACE_SYSCALL, by TIF_SYSCALL_EMU being set
-	 * additionally.
+	/* We can detect the case of coming from PTRACE_SYSEMU and now running
+	 * with PTRACE_SYSCALL or PTRACE_SINGLESTEP, by TIF_SYSCALL_EMU being
+	 * set additionally.
 	 * If so let's reset the flag and return without action.
 	 */
-	if (is_sysemu && is_systrace) {
+	if (is_sysemu && (is_systrace || is_singlestep)) {
 		clear_thread_flag(TIF_SYSCALL_EMU);
 		return 0;
 	}
@@ -573,7 +573,7 @@ int do_syscall_trace(struct pt_regs *reg
 	/* the 0x80 provides a way for the tracing parent to distinguish
 	   between a syscall stop and SIGTRAP delivery */
 	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD) &&
-				 !test_thread_flag(TIF_SINGLESTEP) ? 0x80 : 0));
+				 !is_singlestep ? 0x80 : 0));
 
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
_

--Boundary-00=_2rXgBjxiMzcF5A5--


-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
