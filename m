Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1497988398.22550.5.camel@test-lenovo>
Subject: Re: um: PTRACE_SETREGSET failure with XSTATE on Kabylake CPU
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date: Tue, 20 Jun 2017 12:53:18 -0700
In-Reply-To: <2fc7383c-852a-be3c-f934-b125fe9bdba2@nod.at>
References: <1497923806.7300.2.camel@m3y3r.de>
         <98803c66-4a36-a95f-5a1b-51a40de7a3e6@nod.at>
         <1497948550.7300.5.camel@m3y3r.de>
         <25066617-df15-6d21-713c-1ede1e953448@nod.at>
         <1497981874.22112.20.camel@test-lenovo>
         <4d431238-28c7-3680-42f2-f7cf32acbc86@nod.at>
         <2fc7383c-852a-be3c-f934-b125fe9bdba2@nod.at>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: Thomas Meyer <thomas@m3y3r.de>, elicooper@gmx.com, linux-kernel@vger.kernel.org, "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, linux-x86_64@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>, Ingo Molnar <mingo@redhat.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, 2017-06-20 at 20:59 +0200, Richard Weinberger wrote:
> Yu-cheng,
> 
> Am 20.06.2017 um 20:17 schrieb Richard Weinberger:
> > Yu-cheng,
> > 
> > Am 20.06.2017 um 20:04 schrieb Yu-cheng Yu:
> >>>> So to summarize:
> >>>>
> >>>> - PTRACE_GETREGSET with NT_X86_XSTATE gets 832 and return 832, with no
> >>>> error.
> >>>>
> >>>> - PTRACE_SETREGSET get 832 (sizeof struct _xstate) but wants at least
> >>>> 1088, otherwise it will fail with -EFAULT (why not -EINVAL?)
> >>>>
> >>>> Ideas?
> >>
> >> We considered allowing a partial XSAVE buffer for PTRACE_SETREGSET, but
> >> it was that the XSAVE instruction requires a full-size buffer led to
> >> this choice.  Using a smaller buffer for XSAVE causes a fault.
> > 
> > So, this code is not supposed to work?
> > 
> > iov.iov_base = fp_regs;
> > iov.iov_len = sizeof(struct _xstate);
> > ptrace(PTRACE_GETREGSET, pid, NT_X86_XSTATE, &iov);
> > ptrace(PTRACE_SETREGSET, pid, NT_X86_XSTATE, &iov);
> > 
> > This is what UML does and on Thomas's new Laptop PTRACE_SETREGSET is failing.
> 
> Hmm, I think we need to do what gdb does, it uses a buffer of size X86_XSTATE_MAX_SIZE.
> 

Linux kernel determines XSAVE buffer size from CPUID:
http://elixir.free-electrons.com/linux/latest/source/arch/x86/kernel/fpu/xstate.c#L626

GDB has a fixed X86_XSTATE_MAX_SIZE of 2688.  That can become an issue.

Yu-cheng



