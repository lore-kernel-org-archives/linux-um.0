Return-Path: <linux-kernel-owner+geert=40linux-m68k.org-S1756133AbZCPHpI@vger.kernel.org>
Date: Mon, 16 Mar 2009 15:45:20 +0800
From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH 0/2] ptrace_vm: ptrace for syscall emulation virtual
	machines
Message-ID: <20090316074520.GC3360@hack>
References: <20090204080236.GA17452@cs.unibo.it> <20090310214436.GC5213@cs.unibo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090310214436.GC5213@cs.unibo.it>
Sender: linux-kernel-owner@vger.kernel.org
To: Renzo Davoli <renzo@cs.unibo.it>
Cc: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>, linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, mtk.manpages@gmail.com, Roland McGrath <roland@redhat.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Mar 10, 2009 at 10:44:36PM +0100, Renzo Davoli wrote:
>Cong,
>
>I have updated the PTRACE_VM patches.
>The patches have been rebased to linux-2.6.29-rc7 but apply to linux-2.6.29-rc7-git3.
>
>The set is composed by two patches.
>The first one is for all those architectures where PTRACE_SYSCALL is
>managed via tracehook (x86, powerpc etc).
>Given the wonderful work by Roland McGrath this patch is now
>architecture independent and straightforward simple.
>
>The second one is the support of PTRACE_VM for user-mode-linux.
>It provides PTRACE_VM for UML processes and uses PTRACE_VM of the hosting 
>kernel.
>

I just finished reading all of them. Good work! :)

Thanks. Comments below.

>
>The description and motivation follows.
>-----
>Proposal: let us simplify
>PTRACE_SYSCALL/PTRACE_SINGLESTEP/PTRACE_SYSEMU/PTRACE_SYSEMU_SINGLESTEP,
>and now PTRACE_BLOCKSTEP (which will require soon a PTRACE_SYSEMU_BLOCKSTEP),
>my PTRACE_SYSVM...etc. etc.
>
>Summary of the solution:
>Use tags in the "addr" parameter of existing
>PTRACE_SYSCALL/PTRACE_SINGLESTEP/PTRACE_CONT/PTRACE_BLOCKSTEP calls
>to skip the current call (PTRACE_VM_SKIPCALL) or skip the second upcall to 
>the VM/debugger after the syscall execution (PTRACE_VM_SKIPEXIT).

Why not introduce a new request for PTRACE_VM but use *tags* in 'addr'?
We are taking risks of breaking the existing code. :)


>
>Motivation:
>
>The ptrace tag PTRACE_SYSEMU is a feature mainly used for User-Mode Linux,
>or at most for other virtual machines aiming to virtualize *all* the syscalls
>(total virtual machines).
>
>In fact:
>ptrace(PTRACE_SYSEMU, pid, 0, 0)
>means that the *next* system call will not be executed.
>PTRACE_SYSEMU AFAIK has been implemented only for x86_32.

Yes.

>
>I already proposed some time ago a different tag: PTRACE_SYSVM 
>(and I maintain a patch for it) where:
>ptrace(PTRACE_SYSVM, pid, XXX, 0)
>1* is the same as PTRACE_SYSCALL when XXX==0,
>2* skips the call (and stops before entering the next syscall) when
>  PTRACE_VM_SKIPCALL | PTRACE_VM_SKIPEXIT
>3* skips the ptrace call after the system call if PTRACE_VM_SKIPEXIT.
>  PTRACE_SYSVM has been implemented for x86_32, powerpc_32, um+x86_32.
>(x86_64 and ppc64 exist too, but are less tested).


*I think* this approach is better, since it won't break anything.

>
>The main difference between SYSEMU and SYSVM is that with SYSVM it is possible
>to decide if *this* system call should be executed or not (instead of the next
>one).
>SYSVM can be used also for partial virtual machines (some syscall gets
>virtualized and some others do not), like our umview.

Agreed, I like this idea, this one can finally replace SYSEMU.

>
>PTRACE_SYSVM above can be used instead of PTRACE_SYSEMU in user-mode linux
>and in all the others total virtual machines. In fact, provided user-mode linux
>skips *all* the syscalls it does not matter if the upcall happens just after
>(SYSEMU) or just before (SYSVM) having skipped the syscall.

My question is if there are any other usages of SYSEMU beyond UML?

>
>Briefly I would like to unify SYSCALL, SYSEMU and SYSVM.
>We don't need three different tags (and all their "variations", 
>SINGLESTEP->SYSEMU_SINGLESTEP etc).
>
>We could keep PTRACE_SYSCALL, using the addr parameter as in PTRACE_SYSVM.
>In this case all the code I have seen (user-mode linux, strace, umview
>and googling around) use 0 or 1 for addr (being defined unused).
>defining PTRACE_VM_SKIPCALL=4 and PTRACE_VM_SKIPEXIT=2 (i.e. by ignoring
>the lsb) everything previously coded using PTRACE_SYSCALL should continue 
>to work.
>In the same way PTRACE_SINGLESTEP, PTRACE_CONT and PTRACE_BLOCKSTEP can use 
>the same tags restarting after a SYSCALL.

Well, since 'addr' is said to be unused, it can have any value beyond
0 or 1, we are still having the risks of breaking existing code. :(

>
>This change would eventually simplify both the kernel code
>(reducing tags and exceptions) and even user-mode linux and umview.
>
>The skip-exit feature can be implemented in a arch-independent
>manner, while for skip_call some simple changes are needed
>(the entry assembly code should process the return value of the syscall
>tracing function call, like in arch/x86/kernel/Entry_32.S).
>

Anyway, we need to find a balance between unifying old stuffs and
breaking compatibility.

BTW, please always update the corresponding man pages when you change
any syscall interface. So let's Cc Michael Kerrisk.

Thank you!

-- 
Do what you love, f**k the rest! F**k the regulations!
 
