Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1497981874.22112.20.camel@test-lenovo>
Subject: Re: um: PTRACE_SETREGSET failure with XSTATE on Kabylake CPU
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date: Tue, 20 Jun 2017 11:04:34 -0700
In-Reply-To: <25066617-df15-6d21-713c-1ede1e953448@nod.at>
References: <1497923806.7300.2.camel@m3y3r.de>
         <98803c66-4a36-a95f-5a1b-51a40de7a3e6@nod.at>
         <1497948550.7300.5.camel@m3y3r.de>
         <25066617-df15-6d21-713c-1ede1e953448@nod.at>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: Thomas Meyer <thomas@m3y3r.de>, elicooper@gmx.com, linux-kernel@vger.kernel.org, "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, linux-x86_64@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>, Ingo Molnar <mingo@redhat.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, 2017-06-20 at 11:05 +0200, Richard Weinberger wrote:
> [adding x86 folks]
> 
> Am 20.06.2017 um 10:49 schrieb Thomas Meyer:
> > 
> > In UML the first userspace ptrace always fails, so init get's killed.
> > 
> > The check "count < fpu_user_xstate_size" was introduced by commit:
> > 
> > commit 91c3dba7dbc199191272f4a9863f86ea3bfd679f
> > Author: Yu-cheng Yu <yu-cheng.yu@intel.com>
> > Date:   Fri Jun 17 13:07:17 2016 -0700
> > 
> >     x86/fpu/xstate: Fix PTRACE frames for XSAVES
> >     
> >     XSAVES uses compacted format and is a kernel instruction. The kernel
> >     should use standard-format, non-supervisor state data for PTRACE.
> > 
> > So to summarize:
> > 
> > - PTRACE_GETREGSET with NT_X86_XSTATE gets 832 and return 832, with no
> > error.
> > 
> > - PTRACE_SETREGSET get 832 (sizeof struct _xstate) but wants at least
> > 1088, otherwise it will fail with -EFAULT (why not -EINVAL?)
> > 
> > Ideas?

We considered allowing a partial XSAVE buffer for PTRACE_SETREGSET, but
it was that the XSAVE instruction requires a full-size buffer led to
this choice.  Using a smaller buffer for XSAVE causes a fault.

Yu-cheng



