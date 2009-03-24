Return-Path: <linux-kernel-owner+geert=40linux-m68k.org-S1755978AbZCXXsM@vger.kernel.org>
Date: Wed, 25 Mar 2009 00:47:53 +0100
From: Renzo Davoli <renzo@cs.unibo.it>
Subject: Re: [PATCH 0/2] ptrace_vm: ptrace for syscall emulation virtual
	machines
Message-ID: <20090324234753.GH22695@cs.unibo.it>
References: <20090204080236.GA17452@cs.unibo.it> <20090310214436.GC5213@cs.unibo.it> <20090316074520.GC3360@hack>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090316074520.GC3360@hack>
Sender: linux-kernel-owner@vger.kernel.org
To: Am??rico Wang <xiyou.wangcong@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, mtk.manpages@gmail.com, Roland McGrath <roland@redhat.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

> I just finished reading all of them. Good work! :)
> Thanks. Comments below.
I am thanking you, not viceversa!
> 
> Why not introduce a new request for PTRACE_VM but use *tags* in 'addr'?
> We are taking risks of breaking the existing code. :)

Yes, there is a minimal risk to break some code. This is a con.
On the other side there are two main pros for this proposal:
1- the code is now extremely simple 
2- if we define a different tag for syscall (e.g. PTRACE_VM), we need also
different tags for PTRACE_VM_SINGLESTEP, PTRACE_VM_SINGLEBLOCK and maybe
others in the future.
Using the addr field we don't need this multiplication of tags
(and we could soon delete PTRACE_SYSEMU and PTRACE_SYSEMU_SINGLESTEP).

> My question is if there are any other usages of SYSEMU beyond UML?
At this time I have not find any other usage.
> 
> Well, since 'addr' is said to be unused, it can have any value beyond
> 0 or 1, we are still having the risks of breaking existing code. :(
True. 
> 
> >This change would eventually simplify both the kernel code
> >(reducing tags and exceptions) and even user-mode linux and umview.
> >
I forgot to change this sentence
> >The skip-exit feature can be implemented in a arch-independent
> >manner, while for skip_call some simple changes are needed
> >(the entry assembly code should process the return value of the syscall
> >tracing function call, like in arch/x86/kernel/Entry_32.S).
Both features are now arch independent after McGrath work on tracing hooks.
> 
> BTW, please always update the corresponding man pages when you change
> any syscall interface. So let's Cc Michael Kerrisk.

You are right, I'll patch the man page as soon as possible.

	renzo
