Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FmED9-0006CR-Bt for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Jun 2006 11:17:27 -0700
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FmED4-00026c-JL
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Jun 2006 11:17:26 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Fri, 2 Jun 2006 19:16:35 +0200
References: <20060526032424.GA8283@ccure.user-mode-linux.org>
	<200606012107.34676.blaisorblade@yahoo.it>
	<20060602151335.GA4708@ccure.user-mode-linux.org>
In-Reply-To: <20060602151335.GA4708@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0JHgE5DTBhQUqEl"
Message-Id: <200606021916.36266.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [discuss] [RFC] [PATCH] Double syscall exit traces
	on x86_64
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: discuss@x86-64.org, Steven James <pyro@linuxlabs.com>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, Roland McGrath <roland@redhat.com>

--Boundary-00=_0JHgE5DTBhQUqEl
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 02 June 2006 17:13, Jeff Dike wrote:
> On Thu, Jun 01, 2006 at 09:07:33PM +0200, Blaisorblade wrote:
> > Sorry for the question, but has this been sent to -stable (since it's a
> > -stable regression, it should be)? To 2.6.17 -git?
>
> It's in current git.
The patch is likely ok for -stable, but below I express some doubts for 
inclusion in kernel tree - it probably isn't sufficient and maybe it's not 
the better fix.
> I'm having a hard time telling when the bug was introduced.  The git web
> interface seems to be telling me that the double notification was around
> since last year,

Likely you'll looking into the wrong place - int_ret_from_syscall (if this is 
the name) wasn't used till recently, ret_from_syscall was used. And it never 
does syscall exit tracing - it expects the caller to have switched away to 
the slow path.

There's a path in which it calls int_with_check, but it does "movl 
$_TIF_NEED_RESCHED,%edi", so that int_with_check only tests _TIF_NEED_RESCHED 
and no other flag.

However, there's another potential problem in current code, it seems. 
ret_from_fork. It can jump to rff_trace and then again go to 
int_ret_from_sys_call, if _TIF_IA32 is set. The check for tracing/auditing 
should be moved to when we decide to jump to ret_from_sys_call.

I've tried doing that with the attached untested patch, but it's likely I've 
got something wrong - in particular the following pass of the patch wasn't 
easy to get right (this change is buried in the middle of other things).

+       testl $3,CS(%rsp)     # from kernel_thread?
        RESTORE_REST
-       testl $3,CS-ARGOFFSET(%rsp)     # from kernel_thread?

However, I have a bigger doubt and a proposal for a simpler change. Do we need 
at all to test for syscall tracing in int_ret_from_sys_call? And why is there 
a difference with ret_from_sys_call?

Instead of removing the test from tracesys, could we remove it from 
int_ret_from_sys_call (and no, calling int_with_check with a custom %edi 
doesn't work)?

Can syscall tracing be needed on exit and not on entry?

I've the suspect that either:
a) if some other process kicks in, we'll make him trace from next syscall 
start onwards (and int_ret_from_sys_call is buggy) - this makes much more 
sense and works almost always.
b) or if we want tracer to see syscall exit, it only works in 
int_ret_from_sys_call (rare cases).

I've thought to how a process can kick in and answers were:

*) schedule() to a process which does a ptrace attach
*) the syscall is ptrace(PTRACE_TRACEME)

in both cases the ptracer must do PTRACE_SYSCALL, and in both cases we need 
behaviour a).

For singlestep on syscall exit I'm totally unsure. But I've not the time to 
look more this code - I didn't know it and it's very intricate.

> which I don't believe, since I've run much more 
> recent x86_64 kernels.  If the bug existed before 2.6.16, then it's
> fine -stable fodder.
Can you handle sending it to stable@kernel.org?

First introduced in 2.6.16.5 as first diagnosed by Chuck Ebbert:

commit 6b12095a4a0e1f21bbf83f95f13299ca99d758fe
tree 5d2a3d96f7b99a3a225c0f7a110c6631848524b0
parent 59b2832a31ae2f3279bb5b16ae9b1c4e38e40dea
author Andi Kleen <ak@suse.de> Wed, 12 Apr 2006 08:19:29 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Wed, 12 Apr 2006 13:06:54 -0700

    [PATCH] x86_64: When user could have changed RIP always force IRET 
(CVE-2006-0744)

    Intel EM64T CPUs handle uncanonical return addresses differently from
    AMD CPUs.

    The exception is reported in the SYSRET, not the next instruction.
    Thgis leads to the kernel exception handler running on the user stack
    with the wrong GS because the kernel didn't expect exceptions on this
    instruction.

    This version of the patch has the teething problems that plagued an
    earlier version fixed.

    This is CVE-2006-0744

    Thanks to Ernie Petrides and Asit B. Mallick for analysis and initial
    patches.

    Signed-off-by: Andi Kleen <ak@suse.de>
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_0JHgE5DTBhQUqEl
Content-Type: text/x-diff; charset="iso-8859-1";
	name="x86_64-fix-ret_from_fork"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="x86_64-fix-ret_from_fork"

Index: linux-2.6.16/arch/x86_64/kernel/entry.S
===================================================================
--- linux-2.6.16.orig/arch/x86_64/kernel/entry.S
+++ linux-2.6.16/arch/x86_64/kernel/entry.S
@@ -137,15 +137,17 @@
 ENTRY(ret_from_fork)
 	CFI_DEFAULT_STACK
 	call schedule_tail
+
+	testl $3,CS(%rsp)	# from kernel_thread?
+	je   rff_int_path
 	GET_THREAD_INFO(%rcx)
+	testl $_TIF_IA32,threadinfo_flags(%rcx)
+	jnz  rff_int_path
+
 	testl $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT),threadinfo_flags(%rcx)
 	jnz rff_trace
-rff_action:	
+rff_action:
 	RESTORE_REST
-	testl $3,CS-ARGOFFSET(%rsp)	# from kernel_thread?
-	je   int_ret_from_sys_call
-	testl $_TIF_IA32,threadinfo_flags(%rcx)
-	jnz  int_ret_from_sys_call
 	RESTORE_TOP_OF_STACK %rdi,ARGOFFSET
 	jmp ret_from_sys_call
 rff_trace:
@@ -154,6 +156,9 @@ rff_trace:
 	GET_THREAD_INFO(%rcx)	
 	jmp rff_action
 	CFI_ENDPROC
+rff_int_path:
+	RESTORE_REST
+	jmp  int_ret_from_sys_call
 
 /*
  * System call entry. Upto 6 arguments in registers are supported.
@@ -211,6 +216,7 @@ ENTRY(system_call)
 /*
  * Syscall return path ending with SYSRET (fast path)
  * Has incomplete stack frame and undefined top of stack. 
+ * Will not test _TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP
  */		
 	.globl ret_from_sys_call
 ret_from_sys_call:
@@ -316,6 +322,7 @@ ENTRY(int_ret_from_sys_call)
 	testl $3,CS-ARGOFFSET(%rsp)
 	je retint_restore_args
 	movl $_TIF_ALLWORK_MASK,%edi
+
 	/* edi:	mask to check */
 int_with_check:
 	GET_THREAD_INFO(%rcx)

--Boundary-00=_0JHgE5DTBhQUqEl
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary-00=_0JHgE5DTBhQUqEl
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--Boundary-00=_0JHgE5DTBhQUqEl--
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 

