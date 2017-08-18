Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@sigma-star.at>
Subject: Re: [PATCH] um: Fix check for _xstate for older hosts
Date: Fri, 18 Aug 2017 23:42:29 +0200
Message-ID: <2730918.b85RVvVloc@blindfold>
In-Reply-To: <7e61844a-800e-bee4-d06b-6037d0f7e38b@gmail.com>
References: <20170718234347.21560-1-f.fainelli@gmail.com> <CAFLxGvyD8YGYSSx=J__F=kzTzu729VzAqHDc9v+E7+VOCskxQA@mail.gmail.com> <7e61844a-800e-bee4-d06b-6037d0f7e38b@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Richard Weinberger <richard.weinberger@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am Freitag, 18. August 2017, 23:40:36 CEST schrieb Florian Fainelli:
> On 07/24/2017 05:46 AM, Richard Weinberger wrote:
> > On Wed, Jul 19, 2017 at 1:43 AM, Florian Fainelli <f.fainelli@gmail.com> 
wrote:
> >> Commit 0a987645672e ("um: Allow building and running on older
> >> hosts") attempted to check for PTRACE_{GET,SET}REGSET under the premise
> >> that these ptrace(2) parameters were directly linked with the presence
> >> of the _xstate structure.
> >> 
> >> After Richard's commit 61e8d462457f ("um: Correctly check for
> >> PTRACE_GETRESET/SETREGSET") which properly included linux/ptrace.h
> >> instead of asm/ptrace.h, we could get into the original build failure
> >> that I reported:
> >> 
> >> arch/x86/um/user-offsets.c: In function 'foo':
> >> arch/x86/um/user-offsets.c:54: error: invalid application of 'sizeof' to
> >> incomplete type 'struct _xstate'
> >> 
> >> On this particular host, we do have PTRACE_GETREGSET and
> >> PTRACE_SETREGSET defined in linux/ptrace.h, but not the structure
> >> _xstate that should be pulled from the following include chain: signal.h
> >> -> bits/sigcontext.h.
> >> 
> >> Correctly fix this by checking for FP_XSTATE_MAGIC1 which is the correct
> >> way to see if struct _xstate is available or not on the host.
> >> 
> >> Fixes: 61e8d462457f ("um: Correctly check for PTRACE_GETRESET/SETREGSET")
> >> Fixes: 0a987645672e ("um: Allow building and running on older hosts")
> >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >> ---
> >> 
> >>  arch/x86/um/user-offsets.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/arch/x86/um/user-offsets.c b/arch/x86/um/user-offsets.c
> >> index ae4cd58c0c7a..02250b2633b8 100644
> >> --- a/arch/x86/um/user-offsets.c
> >> +++ b/arch/x86/um/user-offsets.c
> >> @@ -50,7 +50,7 @@ void foo(void)
> >> 
> >>         DEFINE(HOST_GS, GS);
> >>         DEFINE(HOST_ORIG_AX, ORIG_EAX);
> >>  
> >>  #else
> >> 
> >> -#if defined(PTRACE_GETREGSET) && defined(PTRACE_SETREGSET)
> >> +#ifdef FP_XSTATE_MAGIC1
> >> 
> >>         DEFINE(HOST_FP_SIZE, sizeof(struct _xstate) / sizeof(unsigned
> >>         long));
> >>  
> >>  #else
> >>  
> >>         DEFINE(HOST_FP_SIZE, sizeof(struct _fpstate) / sizeof(unsigned
> >>         long));
> >> 
> >> --
> >> 2.9.3
> > 
> > Applied, thanks for fixing!
> 
> Can you submit this to Linus before v4.13 is released? Thank you!

Sure. The UML queue is just a bit slow, sorry for that.

Thanks,
//richard

-- 
sigma star gmbh - Eduard-Bodem-Gasse 6 - 6020 Innsbruck - Austria
ATU66964118 - FN 374287y

