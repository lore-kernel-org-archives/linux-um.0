Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CMogw-0004PK-Tb for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Oct 2004 07:22:22 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CMogv-0004xt-Mx for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Oct 2004 07:22:22 -0700
Message-ID: <417FAEFD.8070805@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: [patch 1/1] SYSEMU: avoid intercepting syscall
	on return when using SYSCALL again.
References: <20041021231834.9D3833F37@zion.localdomain>
	<4178D172.7020406@fujitsu-siemens.com>
	<200410221814.45917.blaisorblade_spam@yahoo.it>
	<41793409.70001@fujitsu-siemens.com>
In-Reply-To: <41793409.70001@fujitsu-siemens.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Wed, 27 Oct 2004 16:21:49 +0200
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com

Bodo Stroesser wrote:
> BlaisorBlade wrote:
> 
>> Yes - I forgot it. Does the revised version work? My version did not - 
>> it failed the startup test. In fact, PTRACE_CONT is called in the 
>> startup test (which fails). I'm recompiling and testing.
> 
> Yes. My system works very fine with it.
Now I've tested with host 2.6.9 and skas3.v6 patch. I adapted my latest
patch and had problems with singlestepping on UML in SKAS with sSYSEMU.
It looped receiving SIGTRAPs without moving forward. EIP of the traced
process was the same for all SIGTRAPs.
What's missing is to handle switching from PTRACE_SYSCALL_EMU to
PTRACE_SINGLESTEP in a way very similar to what is done for the change
from PTRACE_SYSCALL_EMU to PTRACE_SYSCALL_TRACE.

Here is the corresponding patch.

Bodo

P.S.: When testing UML 2.6.9 in SAKS on host 2.6.9, UML didn't terminate
after init 0. kernel-process and userspace-process didn't go out at the end.
ps aux shows S+ for kernel and T+ for userspace. I only could kill them with
kill -9 kernel-pid. After having done this, the host can't unmount its
filesystems: "in use". Doesn't that look like a host-bug?

---

--- a/arch/i386/kernel/ptrace.c	2004-10-27 10:13:55.515622561 +0200
+++ b/arch/i386/kernel/ptrace.c	2004-10-27 10:21:01.958150451 +0200
@@ -367,16 +367,21 @@ asmlinkage int sys_ptrace(long request,
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
  		clear_tsk_thread_flag(child, TIF_SINGLESTEP);
@@ -415,7 +420,6 @@ asmlinkage int sys_ptrace(long request,
  		ret = -EIO;
  		if ((unsigned long) data > _NSIG)
  			break;
-		clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
  		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
  		if ((child->ptrace & PT_DTRACE) == 0) {
  			/* Spurious delayed TF traps may occur */
@@ -589,7 +593,7 @@ out:
  __attribute__((regparm(3)))
  int do_syscall_trace(struct pt_regs *regs, int entryexit)
  {
-	int is_sysemu;
+	int is_sysemu, is_systrace, is_singlestep;
  	if (unlikely(current->audit_context)) {
  		if (!entryexit)
  			audit_syscall_entry(current, regs->orig_eax,
@@ -599,17 +603,26 @@ int do_syscall_trace(struct pt_regs *reg
  			audit_syscall_exit(current, regs->eax);
  	}
  	is_sysemu = test_thread_flag(TIF_SYSCALL_EMU);
+	is_systrace = test_thread_flag(TIF_SYSCALL_TRACE);
+	is_singlestep = test_thread_flag(TIF_SINGLESTEP);

-	if (!test_thread_flag(TIF_SYSCALL_TRACE) &&
-	    !test_thread_flag(TIF_SINGLESTEP) &&
-	    !is_sysemu)
+	if (!is_systrace && !is_sysemu && !is_singlestep )
  		return 0;
+	/* We can detect the case of coming from PTRACE_SYSEMU and now
+	 * running with PTRACE_SYSCALL, by TIF_SYSCALL_EMU being set
+	 * additionally.
+	 * If so let's reset the flag and return without action.
+	 */
+	if (is_sysemu && (is_systrace || is_singlestep)) {
+		clear_thread_flag(TIF_SYSCALL_EMU);
+		return 0;
+	}
  	if (!(current->ptrace & PT_PTRACED))
  		return 0;
  	/* the 0x80 provides a way for the tracing parent to distinguish
  	   between a syscall stop and SIGTRAP delivery */
  	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD) &&
-				 !test_thread_flag(TIF_SINGLESTEP) ? 0x80 : 0));
+				 !is_singlestep ? 0x80 : 0));

  	/*
  	 * this isn't the same as continuing with a signal, but it will do


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
