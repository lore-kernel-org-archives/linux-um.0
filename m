Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AxINs-0001tK-Ov for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 Feb 2004 20:16:56 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AxICv-0000BP-SC
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 Feb 2004 20:05:38 -0800
Received: from ccure.user-mode-linux.org (localhost.localdomain [127.0.0.1])
	by ccure.user-mode-linux.org (8.12.5/8.12.5) with ESMTP id
	i1T4ZoM9008623 for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 28 Feb 2004 23:35:50 -0500
Received: (from jdike@localhost)
	by ccure.user-mode-linux.org (8.12.5/8.12.5/Submit) id i1T4ZoGw008621
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 Feb 2004 23:35:50 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20040229043549.GA8583@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
Subject: [uml-devel] [PATCH] host context switch reduction
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
Date: Sat, 28 Feb 2004 23:35:49 -0500
To: user-mode-linux-devel@lists.sourceforge.net



--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The patches below are from Laurent Vivier who didn't make them public.  They
add a new feature to ptrace on the host which cuts down on the number of
context switches needed for a UML system call, plus makes UML use it.

There's some interest in this, so I'm putting it out as-is.  I haven't played
with it.

Laurent did some performance testing and found ~40% speedup on a getpid
loop, and a 3.5% speedup on a kernel build.

				Jeff


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=x

diff -Nrc skas3-linux-2.4.22/Makefile skas4-linux-2.4.22/Makefile
*** skas3-linux-2.4.22/Makefile	Tue Dec  2 21:24:14 2003
--- skas4-linux-2.4.22/Makefile	Tue Dec  2 20:32:41 2003
***************
*** 1,7 ****
  VERSION = 2
  PATCHLEVEL = 4
  SUBLEVEL = 22
! EXTRAVERSION = -skas3
  
  KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
  
--- 1,7 ----
  VERSION = 2
  PATCHLEVEL = 4
  SUBLEVEL = 22
! EXTRAVERSION = -sysemu
  
  KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
  
diff -Nrc skas3-linux-2.4.22/arch/i386/kernel/entry.S skas4-linux-2.4.22/arch/i386/kernel/entry.S
*** skas3-linux-2.4.22/arch/i386/kernel/entry.S	Fri Jun 13 16:51:29 2003
--- skas4-linux-2.4.22/arch/i386/kernel/entry.S	Tue Dec  2 20:27:41 2003
***************
*** 203,208 ****
--- 203,210 ----
  	pushl %eax			# save orig_eax
  	SAVE_ALL
  	GET_CURRENT(%ebx)
+ 	testb $0x20,tsk_ptrace(%ebx)	# PT_SCEMU
+ 	jne emulatesys
  	testb $0x02,tsk_ptrace(%ebx)	# PT_TRACESYS
  	jne tracesys
  	cmpl $(NR_syscalls),%eax
***************
*** 237,242 ****
--- 239,248 ----
  	jmp restore_all
  
  	ALIGN
+ emulatesys:
+ 	call SYMBOL_NAME(syscall_emulate)
+ 	jmp ret_from_sys_call
+ 	ALIGN
  tracesys:
  	movl $-ENOSYS,EAX(%esp)
  	call SYMBOL_NAME(syscall_trace)
diff -Nrc skas3-linux-2.4.22/arch/i386/kernel/ptrace.c skas4-linux-2.4.22/arch/i386/kernel/ptrace.c
*** skas3-linux-2.4.22/arch/i386/kernel/ptrace.c	Tue Dec  2 21:24:01 2003
--- skas4-linux-2.4.22/arch/i386/kernel/ptrace.c	Tue Dec  2 18:52:10 2003
***************
*** 275,280 ****
--- 275,281 ----
  		  }
  		  break;
  
+ 	case PTRACE_SCEMU: /* continue and replace next syscall */
  	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
  	case PTRACE_CONT: { /* restart after signal. */
  		long tmp;
***************
*** 282,287 ****
--- 283,292 ----
  		ret = -EIO;
  		if ((unsigned long) data > _NSIG)
  			break;
+ 		if (request == PTRACE_SCEMU)
+ 			child->ptrace |= PT_SCEMU;
+ 		else
+ 			child->ptrace &= ~PT_SCEMU;
  		if (request == PTRACE_SYSCALL)
  			child->ptrace |= PT_TRACESYS;
  		else
***************
*** 320,326 ****
  		ret = -EIO;
  		if ((unsigned long) data > _NSIG)
  			break;
! 		child->ptrace &= ~PT_TRACESYS;
  		if ((child->ptrace & PT_DTRACE) == 0) {
  			/* Spurious delayed TF traps may occur */
  			child->ptrace |= PT_DTRACE;
--- 325,331 ----
  		ret = -EIO;
  		if ((unsigned long) data > _NSIG)
  			break;
! 		child->ptrace &= ~(PT_TRACESYS|PT_SCEMU);
  		if ((child->ptrace & PT_DTRACE) == 0) {
  			/* Spurious delayed TF traps may occur */
  			child->ptrace |= PT_DTRACE;
***************
*** 482,487 ****
--- 487,515 ----
  	return ret;
  }
  
+ asmlinkage void syscall_emulate(void)
+ {
+ 	if ((current->ptrace & (PT_PTRACED|PT_SCEMU)) !=
+ 			(PT_PTRACED|PT_SCEMU))
+ 		return;
+ 	/* the 0x80 provides a way for the tracing parent to distinguish
+ 	   between a syscall stop and SIGTRAP delivery */
+ 	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+ 					? 0x80 : 0);
+ 	current->state = TASK_STOPPED;
+ 	notify_parent(current, SIGCHLD);
+ 	schedule();
+ 	/*
+ 	 * this isn't the same as continuing with a signal, but it will do
+ 	 * for normal use.  strace only continues with a signal if the
+ 	 * stopping signal is not SIGTRAP.  -brl
+ 	 */
+ 	if (current->exit_code) {
+ 		send_sig(current->exit_code, current, 1);
+ 		current->exit_code = 0;
+ 	}
+ }
+ 
  asmlinkage void syscall_trace(void)
  {
  	if ((current->ptrace & (PT_PTRACED|PT_TRACESYS)) !=
diff -Nrc skas3-linux-2.4.22/include/linux/ptrace.h skas4-linux-2.4.22/include/linux/ptrace.h
*** skas3-linux-2.4.22/include/linux/ptrace.h	Sat Sep 15 00:55:17 2001
--- skas4-linux-2.4.22/include/linux/ptrace.h	Tue Dec  2 18:42:55 2003
***************
*** 20,25 ****
--- 20,26 ----
  #define PTRACE_DETACH		0x11
  
  #define PTRACE_SYSCALL		  24
+ #define PTRACE_SCEMU		  25
  
  #include <asm/ptrace.h>
  
diff -Nrc skas3-linux-2.4.22/include/linux/sched.h skas4-linux-2.4.22/include/linux/sched.h
*** skas3-linux-2.4.22/include/linux/sched.h	Fri Jun 13 16:51:39 2003
--- skas4-linux-2.4.22/include/linux/sched.h	Tue Dec  2 20:28:19 2003
***************
*** 444,449 ****
--- 444,450 ----
  #define PT_DTRACE	0x00000004	/* delayed trace (used on m68k, i386) */
  #define PT_TRACESYSGOOD	0x00000008
  #define PT_PTRACE_CAP	0x00000010	/* ptracer can follow suid-exec */
+ #define PT_SCEMU	0x00000020	/* syscall emulation for UML */
  
  #define is_dumpable(tsk)    ((tsk)->task_dumpable && (tsk)->mm && (tsk)->mm->dumpable)
  


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=y

diff -Nrc uml-linux-2.4.22/arch/um/kernel/process.c sysemu-uml-linux-2.4.22/arch/um/kernel/process.c
*** uml-linux-2.4.22/arch/um/kernel/process.c	Tue Oct 14 15:28:28 2003
--- sysemu-uml-linux-2.4.22/arch/um/kernel/process.c	Thu Dec  4 20:14:33 2003
***************
*** 222,227 ****
--- 222,243 ----
  	}
  	stop_ptraced_child(pid, stack, 0);
  	printk("OK\n");
+ 
+ #ifdef PTRACE_SYSEMU
+ 	printk("Checking syscall emulation patch for ptrace...");
+ 
+ 	use_sysemu = 0;
+ 	pid = start_ptraced_child(&stack);
+ 	if(ptrace(PTRACE_SYSEMU, pid, 0, 0) >= 0)
+ 	{
+ 		printk("OK\n");
+         	use_sysemu = 1;
+ 	}
+ 	else
+ 		printk("missing\n");
+ 
+ 	stop_ptraced_child(pid, stack, 0);
+ #endif
  }
  
  int run_kernel_thread(int (*fn)(void *), void *arg, void **jmp_ptr)
diff -Nrc uml-linux-2.4.22/arch/um/kernel/skas/include/ptrace-skas.h sysemu-uml-linux-2.4.22/arch/um/kernel/skas/include/ptrace-skas.h
*** uml-linux-2.4.22/arch/um/kernel/skas/include/ptrace-skas.h	Tue Oct 14 15:28:28 2003
--- sysemu-uml-linux-2.4.22/arch/um/kernel/skas/include/ptrace-skas.h	Thu Dec  4 20:15:34 2003
***************
*** 10,15 ****
--- 10,22 ----
  
  #ifdef UML_CONFIG_MODE_SKAS
  
+ /* syscall emulation path in ptrace */
+ 
+ #ifndef PTRACE_SYSEMU
+ #define PTRACE_SYSEMU 25
+ #endif
+ extern int use_sysemu;
+ 
  #include "skas_ptregs.h"
  
  #define HOST_FRAME_SIZE 17
diff -Nrc uml-linux-2.4.22/arch/um/kernel/skas/process.c sysemu-uml-linux-2.4.22/arch/um/kernel/skas/process.c
*** uml-linux-2.4.22/arch/um/kernel/skas/process.c	Wed Dec  3 18:53:54 2003
--- sysemu-uml-linux-2.4.22/arch/um/kernel/skas/process.c	Fri Dec  5 17:57:03 2003
***************
*** 27,32 ****
--- 27,36 ----
  #include "skas_ptrace.h"
  #include "chan_user.h"
  
+ #ifdef PTRACE_SYSEMU
+ int use_sysemu = 0;
+ #endif
+ 
  int is_skas_winch(int pid, int fd, void *data)
  {
  	if(pid != getpid())
***************
*** 65,85 ****
  		return;
  	}
  
! 	err = ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_NR_OFFSET, __NR_getpid);
! 	if(err < 0)
! 	        panic("handle_trap - nullifying syscall failed errno = %d\n", 
! 		      errno);
  
! 	err = ptrace(PTRACE_SYSCALL, pid, 0, 0);
! 	if(err < 0)
! 	        panic("handle_trap - continuing to end of syscall failed, "
! 		      "errno = %d\n", errno);
! 
! 	err = waitpid(pid, &status, WUNTRACED);
! 	if((err < 0) || !WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
! 		panic("handle_trap - failed to wait at end of syscall, "
! 		      "errno = %d, status = %d\n", errno, status);
  
  	handle_syscall(regs);
  }
  
--- 69,91 ----
  		return;
  	}
  
! 	if (!use_sysemu)
! 	{
! 		err = ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_NR_OFFSET, __NR_getpid);
! 		if(err < 0)
! 	        	panic("handle_trap - nullifying syscall failed errno = %d\n", 
! 		      	errno);
  
! 		err = ptrace(PTRACE_SYSCALL, pid, 0, 0);
! 		if(err < 0)
! 	        	panic("handle_trap - continuing to end of syscall failed, "
! 		      	"errno = %d\n", errno);
  
+ 		err = waitpid(pid, &status, WUNTRACED);
+ 		if((err < 0) || !WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
+ 			panic("handle_trap - failed to wait at end of syscall, "
+ 		      	"errno = %d, status = %d\n", errno, status);
+ 	}
  	handle_syscall(regs);
  }
  
***************
*** 134,140 ****
--- 140,154 ----
  
  	restore_registers(regs);
  		
+ #ifdef PTRACE_SYSEMU
+ 	if (use_sysemu)
+ 		err = ptrace(PTRACE_SYSEMU, userspace_pid, 0, 0);
+ 	else
+ 		err = ptrace(PTRACE_SYSCALL, userspace_pid, 0, 0);
+ #else
  	err = ptrace(PTRACE_SYSCALL, userspace_pid, 0, 0);
+ #endif
+ 
  	if(err)
  		panic("userspace - PTRACE_SYSCALL failed, errno = %d\n", 
  		       errno);
***************
*** 172,179 ****
--- 186,202 ----
  
  		restore_registers(regs);
  
+ #ifdef PTRACE_SYSEMU
+ 		if (use_sysemu)
+ 			op = singlestepping_skas() ? PTRACE_SINGLESTEP : 
+ 				PTRACE_SYSEMU;
+ 		else
+ 			op = singlestepping_skas() ? PTRACE_SINGLESTEP : 
+ 				PTRACE_SYSCALL;
+ #else
  		op = singlestepping_skas() ? PTRACE_SINGLESTEP : 
  			PTRACE_SYSCALL;
+ #endif
  		err = ptrace(op, userspace_pid, 0, 0);
  		if(err)
  			panic("userspace - PTRACE_SYSCALL failed, "

--3MwIy2ne0vdjdPXF--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
