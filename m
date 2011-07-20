Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4E27163A.6090102@mit.edu>
Date: Wed, 20 Jul 2011 13:54:02 -0400
From: Andy Lutomirski <luto@MIT.EDU>
MIME-Version: 1.0
References: <1310994456-14142-1-git-send-email-richard@nod.at> <1310994456-14142-3-git-send-email-richard@nod.at>
In-Reply-To: <1310994456-14142-3-git-send-email-richard@nod.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 3/3] um: Implement a x86_64 vDSO
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 07/18/2011 09:07 AM, Richard Weinberger wrote:
> Until now UML had no x86_64 vDSO.
> So glibc always used the vsyscall page for gettimeday()
> and friends.
> Calls to gettimeday() returned falsely the host time and
> confused some programs.
>
> This patch adds a vDSO which turns all __vdso_* calls into
> a system call so that UML can trap them.
>
> As glibc still uses the vsyscall page for static binaries this
> patch improves the situation only for dynamic binaries.
>
> Signed-off-by: Richard Weinberger<richard@nod.at>

> +	asm("syscall" : "=a" (ret) :
> +		"0" (__NR_clock_gettime), "D" (clock), "S" (ts) : "memory");
> +

The x86-64 ABI and glibc think that rcx, and r11 are clobbered.  glibc 
also thinks that cc is clobbered.  I personally think that rdx and 
r8-r15 ought to be clobbered under the principle that syscall should 
look like a function call.

It's hard to imagine this causing a problem in a function this trivial, 
though.

This applies to the other two syscall instructions as well.

--Andy

P.S.  If you really care, with the changes in tip/x86/vdso, it ought to 
be possible for UML to trap vsyscalls as well.  This would need a change 
to do_emulate_vsyscall to honor TIF_SYSCALL_EMU with intelligent 
semantics.  I know nothing about ptrace, so I'm not volunteering :)
