Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNXw3-0006hk-Rm for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Oct 2004 07:40:59 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CNXw2-0001iT-HX for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Oct 2004 07:40:59 -0700
Message-ID: <4182529D.6070100@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] [Patch 1/1] uml: bad syscall restart handling
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
Date: Fri, 29 Oct 2004 16:24:29 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, BlaisorBlade <blaisorblade_spam@yahoo.it>

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

The implementation of sys_sigreturn() and sys_rt_sigreturn() in UML
differ from the ones in i386. In i386, orig_eax is set to -1.
This is neccessary, since the return value of sys_*_sigreturn()
is the value of eax in the thread, that was interrupted by the
signal handler. If accidentaly eax contains -ERESTART_*, orig_eax
*must* be -1 to avoid syscall restart processing in kern_do_signal().
If orig_eax is >=0, eip might be lowered by 2, the will fail.
In UML PT_REGS_SYSCALL_NR() or UPT_SYSCALL_NR() have to be used
instead of orig_eax.

While writing and testing an exploit for this, I saw that for most
interrupts, the syscall number is undefined. So even on a return from
interrupt a wrong syscall restart handling could happen.

And also: UML resumes a process with ptrace(PTRACE_SYSCALL/SYSEMU/SINGLESTEP
when a syscall in UML in SKAS mode has been processed. But since there
is a valid syscall number in the host's orig_eax, the host could do
a wrong syscall restarting if the syscall in UML was a sigreturn() returning
-ERESTART* To avoid this, in SKAS -1 should be written to regs.orig_eax
before restore_registers().

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
---

--- a/arch/um/kernel/skas/process.c	2004-10-29 13:58:14.795153256 +0200
+++ b/arch/um/kernel/skas/process.c	2004-10-29 15:07:48.637401531 +0200
@@ -57,7 +57,7 @@ static void handle_trap(int pid, union u
  {
  	int err, status;

-	UPT_SYSCALL_NR(regs) = PT_SYSCALL_NR(regs->skas.regs);
+	UPT_SYSCALL_NR(regs) = PT_SYSCALL_NR(regs->skas.regs); /* Mark this as a syscall */

  	if (!local_using_sysemu)
  	{
@@ -156,6 +156,7 @@ void userspace(union uml_pt_regs *regs)

  		regs->skas.is_user = 1;
  		save_registers(pid, regs);
+		UPT_SYSCALL_NR(regs) = -1; /* Assume: It's not a syscall */

  		if(WIFSTOPPED(status)){
  		  	switch(WSTOPSIG(status)){
@@ -166,7 +167,6 @@ void userspace(union uml_pt_regs *regs)
  			        handle_trap(pid, regs, local_using_sysemu);
  				break;
  			case SIGTRAP:
-				UPT_SYSCALL_NR(regs) = -1;
  				relay_signal(SIGTRAP, regs);
  				break;
  			case SIGIO:
@@ -182,6 +182,7 @@ void userspace(union uml_pt_regs *regs)
  				       "%d\n", WSTOPSIG(status));
  			}
  			interrupt_end();
+			PT_SYSCALL_NR(regs->skas.regs) = -1; /* Avoid -ERESTARTSYS handling in host */
  		}

  		restore_registers(pid, regs);
--- a/arch/um/sys-i386/signal.c	2004-10-29 12:28:57.888413276 +0200
+++ b/arch/um/sys-i386/signal.c	2004-10-29 15:11:00.366717145 +0200
@@ -317,6 +317,7 @@ long sys_sigreturn(struct pt_regs regs)
  	recalc_sigpending();
  	spin_unlock_irq(&current->sighand->siglock);
  	copy_sc_from_user(&current->thread.regs, sc);
+	PT_REGS_SYSCALL_NR(&current->thread.regs) = -1; /* Avoid ERESTART handling */
  	return(PT_REGS_SYSCALL_RET(&current->thread.regs));
  }

@@ -333,6 +334,7 @@ long sys_rt_sigreturn(struct pt_regs reg
  	recalc_sigpending();
  	spin_unlock_irq(&current->sighand->siglock);
  	copy_sc_from_user(&current->thread.regs, &uc->uc_mcontext);
+	PT_REGS_SYSCALL_NR(&current->thread.regs) = -1; /* Avoid ERESTART handling */
  	return(PT_REGS_SYSCALL_RET(&current->thread.regs));
  }

--- a/arch/um/kernel/tt/tracer.c	2004-10-26 18:50:36.000000000 +0200
+++ b/arch/um/kernel/tt/tracer.c	2004-10-29 15:29:46.206665541 +0200
@@ -302,6 +302,8 @@ int tracer(int (*init_proc)(void *), voi
  			task = cpu_tasks[proc_id].task;
  			tracing = is_tracing(task);
  			old_tracing = tracing;
+			if ( tracing ) /* Assume: no syscall, when coming from user */
+				do_sigtrap(task);

  			switch(sig){
  			case SIGUSR1:
@@ -345,7 +347,6 @@ int tracer(int (*init_proc)(void *), voi
  					continue;
  				}
  				tracing = 0;
-				do_sigtrap(task);
  				break;
  			case SIGPROF:
  				if(tracing) sig = 0;


-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
