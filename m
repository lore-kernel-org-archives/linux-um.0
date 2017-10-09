Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 9 Oct 2017 21:16:46 +0200
From: Thomas Meyer <thomas@m3y3r.de>
Subject: Re: [thomas@m3y3r.de: Re: [PATCH] um: Fix kcov crash before kernel
 is started.]
Message-ID: <20171009191646.GA2277@maria>
References: <20171009163710.o5z5xjnlvmo3mi52@olymp>
 <CACT4Y+Y2BfbjaqR1DTXxZftuZVN66H+=2Sj1a=DsbCrFKTY=LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Y2BfbjaqR1DTXxZftuZVN66H+=2Sj1a=DsbCrFKTY=LA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzkaller <syzkaller@googlegroups.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, Oct 09, 2017 at 08:10:45PM +0200, Dmitry Vyukov wrote:
> On Mon, Oct 9, 2017 at 6:47 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
> > ----- Forwarded message from Thomas Meyer <thomas@m3y3r.de> -----
> >
> > Hi,
> >
> > are you able to shed light on this topic?
> > Any help is greatly appreciated!
> >
> > With kind regards
> > thomas
> >
> > Date: Sun, 8 Oct 2017 13:18:24 +0200
> > From: Thomas Meyer <thomas@m3y3r.de>
> > To: Richard Weinberger <richard@nod.at>
> > Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] um: Fix kcov crash before kernel is started.
> > User-Agent: NeoMutt/20170113 (1.7.2)
> >
> > On Sun, Oct 08, 2017 at 12:44:12PM +0200, Richard Weinberger wrote:
> >> Am Sonntag, 8. Oktober 2017, 12:31:58 CEST schrieb Thomas Meyer:
> >> > UMLs current_thread_info() unconditionally assumes that the top of the stack
> >> > contains the thread_info structure. But on UML the __sanitizer_cov_trace_pc
> >> > function is called for *all* functions! This results in an early crash:
> >> >
> >> > Prevent kcov from using invalid curent_thread_info() data by checking
> >> > the system_state.
> >> >
> >> > Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
> >> > ---
> >> >  kernel/kcov.c | 6 ++++++
> >> >  1 file changed, 6 insertions(+)
> >> >
> >> > diff --git a/kernel/kcov.c b/kernel/kcov.c
> >> > index 3f693a0f6f3e..d601c0e956f6 100644
> >> > --- a/kernel/kcov.c
> >> > +++ b/kernel/kcov.c
> >> > @@ -56,6 +56,12 @@ void notrace __sanitizer_cov_trace_pc(void)
> >> >     struct task_struct *t;
> >> >     enum kcov_mode mode;
> >> >
> >> > +#ifdef CONFIG_UML
> >> > +   if(!(system_state == SYSTEM_SCHEDULING ||
> >> > +        system_state == SYSTEM_RUNNING))
> >> > +           return;
> >> > +#endif
> >>
> >> Hmm, and why does it work on all other archs then?
> >
> > Hi,
> >
> > I guess UML is different then other archs! But to be honest I'm not sure
> > why. I assume that __sanitizer_cov_trace_pc on other archs isn't called
> > that early, or that curent_thread_info returns NULL on other archs when
> > the first task isn't running yet.
> >
> > But as I fail to use/setup the qemu gdb attachment to debug early x86_64 code
> > I can't say exactly why.
> >
> > Maybe someone how knows the inner workings of x86_64 and/or kcov can
> > answer this question!
> 
> 
> Hi,

Hi,

> Yes, kcov can have some issues with early bootstrap code, because it
> accesses current and it can also conflict with say, per-cpu setup code
> (at least it was the case for x86). For x86 and arm64 we just bulk
> blacklist instrumentation of arch code involved in early bootstrap.
> See e.g. KCOV_INSTRUMENT in arch/x86/boot/Makefile. I think you need
> to do the same for um. Start with bulk ignoring as much as possible
> until you get it booting and then bisect back from there.

oh, arch/um/* already contains the Makefile exception settings!
I guess CONFIG_KCOV_INSTRUMENT_ALL overrides the the Makefile settings?
Or doesn't it? I looked at scripts/Makefile.lib but failed to understand
what config options has precedens in that case.

greets
thomas 

