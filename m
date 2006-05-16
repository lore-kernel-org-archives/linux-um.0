Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fg3cK-0002iR-UC for User-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 May 2006 10:45:56 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Fg3cK-0001dU-Qt
	for User-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 May 2006 10:45:57 -0700
Received: from mail.signal1network.com ([208.176.116.2]
	helo=ucontrol.mobiledns.com)
	by externalmx-1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1Fg3cD-0003eT-8o
	for User-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 May 2006 10:45:49 -0700
From: Steven James <pyro@linuxlabs.com>
Subject: Re: [uml-devel] [PATCH] RFC allow PTRACE_SYSCALL to selectively skip
	syscalls
In-Reply-To: <20060516151031.GA4014@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.58.0605161341350.664@ucontrol.mobiledns.com>
References: <Pine.LNX.4.58.0605111220070.664@ucontrol.mobiledns.com>
	<20060516151031.GA4014@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Tue, 16 May 2006 13:45:27 -0400 (EDT)
To: Jeff Dike <jdike@addtoit.com>
Cc: User-mode-linux-devel@lists.sourceforge.net

On Tue, 16 May 2006, Jeff Dike wrote:

> On Sat, May 13, 2006 at 01:40:48PM -0400, Steven James wrote:
> > The patch below for x86_64 implements a scheme where a ptraced system call
>
> Ummmm, so where's the patch?
>

I suppose it WOULD help to actually send it:

diff -urN linux-2.6.12.2-nimbus1/arch/x86_64/kernel/entry.S linux-2.6.12.2-nimbus2/arch/x86_64/kernel/entry.S
--- linux-2.6.12.2-nimbus1/arch/x86_64/kernel/entry.S	2005-09-12 18:04:26.000000000 -0400
+++ linux-2.6.12.2-nimbus2/arch/x86_64/kernel/entry.S	2006-05-10 17:46:15.000000000 -0400
@@ -241,6 +241,8 @@
 	FIXUP_TOP_OF_STACK %rdi
 	movq %rsp,%rdi
 	call syscall_trace_enter
+	cmpq $0, %rax
+	jne 2f
 	LOAD_ARGS ARGOFFSET  /* reload args from stack in case ptrace changed it */
 	RESTORE_REST
 	cmpq $__NR_syscall_max,%rax
@@ -251,6 +253,7 @@
 1:	SAVE_REST
 	movq %rsp,%rdi
 	call syscall_trace_leave
+2:
 	RESTORE_TOP_OF_STACK %rbx
 	RESTORE_REST
 	jmp ret_from_sys_call
diff -urN linux-2.6.12.2-nimbus1/arch/x86_64/kernel/ptrace.c linux-2.6.12.2-nimbus2/arch/x86_64/kernel/ptrace.c
--- linux-2.6.12.2-nimbus1/arch/x86_64/kernel/ptrace.c	2005-09-12 18:04:26.000000000 -0400
+++ linux-2.6.12.2-nimbus2/arch/x86_64/kernel/ptrace.c	2006-05-10 17:50:35.000000000 -0400
@@ -623,7 +623,7 @@
 }
 EXPORT_SYMBOL_GPL(sys_ptrace);

-static void syscall_trace(struct pt_regs *regs)
+static long syscall_trace(struct pt_regs *regs)
 {

 #if 0
@@ -644,16 +644,24 @@
 		send_sig(current->exit_code, current, 1);
 		current->exit_code = 0;
 	}
+	if(regs->rax != -ENOSYS)
+		return 1;
+
+	return 0;
 }

-asmlinkage void syscall_trace_enter(struct pt_regs *regs)
+asmlinkage long syscall_trace_enter(struct pt_regs *regs)
 {
+	long	res=0;
 	/* do the secure computing check first */
 	secure_computing(regs->orig_rax);

 	if (test_thread_flag(TIF_SYSCALL_TRACE)
 	    && (current->ptrace & PT_PTRACED))
-		syscall_trace(regs);
+		res = syscall_trace(regs);
+
+	if(res)
+		return res;

 	if (unlikely(current->audit_context)) {
 		if (test_thread_flag(TIF_IA32)) {
@@ -668,6 +676,7 @@
 					    regs->rdx, regs->r10);
 		}
 	}
+	return res;
 }

 asmlinkage void syscall_trace_leave(struct pt_regs *regs)

||||| |||| |||||||||||||  |||
by Linux Labs International, Inc.
   Steven James, CTO

55 Marietta Street
Suite 1830
Atlanta, Ga 30303
866 824 9737 support



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
