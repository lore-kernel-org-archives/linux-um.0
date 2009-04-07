Return-Path: <linux-kernel-owner+geert=40linux-m68k.org-S1760185AbZDGRgK@vger.kernel.org>
Date: Wed, 8 Apr 2009 01:36:46 +0800
From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH 0/2] ptrace_vm: ptrace for syscall emulation virtual
	machines
Message-ID: <20090407173646.GL12226@hack>
References: <20090204080236.GA17452@cs.unibo.it> <20090310214436.GC5213@cs.unibo.it> <20090316074520.GC3360@hack> <20090324234753.GH22695@cs.unibo.it> <20090329163228.GE7671@hack> <20090404101708.GG4203@cs.unibo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20090404101708.GG4203@cs.unibo.it>
Sender: linux-kernel-owner@vger.kernel.org
To: Renzo Davoli <renzo@cs.unibo.it>
Cc: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>, linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, mtk.manpages@gmail.com, Roland McGrath <roland@redhat.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sat, Apr 04, 2009 at 12:17:09PM +0200, Renzo Davoli wrote:
>Dear Cong,
>
>On Mon, Mar 30, 2009 at 12:32:28AM +0800, Américo Wang wrote:
>> On Wed, Mar 25, 2009 at 12:47:53AM +0100, Renzo Davoli wrote:
>> >1- the code is now extremely simple 
>> Why adding a new request for ptrace is harder? I don't think so. :)
>> >2- if we define a different tag for syscall (e.g. PTRACE_VM), we need also
>> >different tags for PTRACE_VM_SINGLESTEP, PTRACE_VM_SINGLEBLOCK and maybe
>> >others in the future.
>> >Using the addr field we don't need this multiplication of tags
>> >(and we could soon delete PTRACE_SYSEMU and PTRACE_SYSEMU_SINGLESTEP).
>> Yes? We could also remove PTRACE_SYSEMU* if we had PTRACE_VM to replace
>> it. I would like to hear more from you on this point.
>
>I am sorry for the delay of this reply.
>I am having a quite busy time and I like to analyze problems before
>giving answers.

No problem. :)

>
>Let me point out that the primary issue is the following one:
>PTRACE_SYSEMU is a limited feature. It is twofold limited:
>- it is supported only for x86
>- it provides support for "total" virtual machines like User-Mode Linux
>and it is useless for "partial" virtual machine like fakeroot-ng, umview
>or others.
>I have published a proposal for a new support that is able to overpass
>these limits. PTRACE_SYSEMU/SYSEMU_SINGLESTEP could be deprecated.
>There will be some cleaning up of the kernel code when the deprecated
>tags are eliminated.
>
>Whether it is nicer to use the existing tags or defining new tags is a
>secondary issue. I support the hypothesis of reusing the existing tags and use
>values in the addr field but if the community says that it is nicer/better to
>have separate tags it is quite easy to update my patches (and umview).
>
>Let us discuss this latter point.
>
>PTRACE has a number of "resume" tags:
>PTRACE_SYSCALL, PTRACE_SINGLESTEP, PTRACE_SINGLEBLOCK and currently
>PTRACE_SYSEMU and PTRACE_SYSEMU_SINGLESTEP.
>all these call are managed in the code by the ptrace_resume function.
>
>My patch #1 (kernel/ptrace.c function ptrace_request) forwards the addr 
>parameter to ptrace_resume which saves the VM bits in some bits inside 
>task_struct's ptrace field.
>
>If we want to use different tags like:
>PTRACE_VM PTRACE_VM_SINGLESTEP PTRACE_VM_SINGLEBLOCK:
>the better implementation I can envision, adds another group of switch cases
>as follows (kernel/ptrace.c function ptrace_request):
> ....
> #ifdef PTRACE_SINGLESTEP
>   case PTRACE_SINGLESTEP:
> #endif
> #ifdef PTRACE_SINGLEBLOCK
>   case PTRACE_SINGLEBLOCK:
> #endif
> #ifdef PTRACE_SYSEMU
>   case PTRACE_SYSEMU:
>   case PTRACE_SYSEMU_SINGLESTEP:
> #endif
>   case PTRACE_SYSCALL:
>   case PTRACE_CONT:
>     return ptrace_resume(child, request, 0, data);
>+/* statements added for PTRACE_VM management */
>+#ifdef PTRACE_VM
>+  case PTRACE_VM:
>+#ifdef PTRACE_VM_SINGLESTEP
>+  case PTRACE_VM_SINGLESTEP:
>+#endif
>+#ifdef PTRACE_VM_SINGLEBLOCK
>+  case PTRACE_VM_SINGLEBLOCK:
>+#endif
>+    return ptrace_resume(child, PTRACE_VM_TAGS_MAPPING(request), addr, data);
>+#endif
>....
>  

Hmmm, I see your points. Thanks for your analysis.

I didn't mean to introduce three new requests for ptrace().
My point is, actually, the same with your first proposal in this thread,
i.e. introducing a new request PTRACE_SYSVM, and two tags in 'addr' for it,
i.e. PTRACE_VM_SKIPCALL, PTRACE_VM_SKIPEXIT.

This will not break any code, and is also easy to implement as you
stated above. Isn't this what you want? Why do you drop this idea now?

Thanks.


-- 
Do what you love, f**k the rest! F**k the regulations!
 
