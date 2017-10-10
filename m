Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 10 Oct 2017 11:14:01 +0100
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [thomas@m3y3r.de: Re: [PATCH] um: Fix kcov crash before kernel
 is started.]
Message-ID: <20171010101401.GG27659@leverpostej>
References: <20171009163710.o5z5xjnlvmo3mi52@olymp>
 <CACT4Y+Y2BfbjaqR1DTXxZftuZVN66H+=2Sj1a=DsbCrFKTY=LA@mail.gmail.com>
 <20171009191646.GA2277@maria>
 <CACT4Y+Ye1Yw3SPCy80_JAqNGdqtSFTMVMc02-rbfJv1omT5Qhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Ye1Yw3SPCy80_JAqNGdqtSFTMVMc02-rbfJv1omT5Qhw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Thomas Meyer <thomas@m3y3r.de>, syzkaller <syzkaller@googlegroups.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hi,

On Tue, Oct 10, 2017 at 10:59:23AM +0200, 'Dmitry Vyukov' via syzkaller wrote:
> On Mon, Oct 9, 2017 at 9:16 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
> >> > Date: Sun, 8 Oct 2017 13:18:24 +0200
> >> > From: Thomas Meyer <thomas@m3y3r.de>
> >> > To: Richard Weinberger <richard@nod.at>
> >> > Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
> >> > Subject: Re: [PATCH] um: Fix kcov crash before kernel is started.
> >> > User-Agent: NeoMutt/20170113 (1.7.2)
> >> >
> >> > On Sun, Oct 08, 2017 at 12:44:12PM +0200, Richard Weinberger wrote:
> >> >> Am Sonntag, 8. Oktober 2017, 12:31:58 CEST schrieb Thomas Meyer:
> >> >> > UMLs current_thread_info() unconditionally assumes that the top of the stack
> >> >> > contains the thread_info structure. But on UML the __sanitizer_cov_trace_pc
> >> >> > function is called for *all* functions! This results in an early crash:
> >> >> >
> >> >> > Prevent kcov from using invalid curent_thread_info() data by checking
> >> >> > the system_state.
> >> >> >
> >> >> > Signed-off-by: Thomas Meyer <thomas@m3y3r.de>

[...]

> >> Yes, kcov can have some issues with early bootstrap code, because it
> >> accesses current and it can also conflict with say, per-cpu setup code
> >> (at least it was the case for x86). For x86 and arm64 we just bulk
> >> blacklist instrumentation of arch code involved in early bootstrap.
> >> See e.g. KCOV_INSTRUMENT in arch/x86/boot/Makefile. I think you need
> >> to do the same for um. Start with bulk ignoring as much as possible
> >> until you get it booting and then bisect back from there.
> >
> > oh, arch/um/* already contains the Makefile exception settings!
> > I guess CONFIG_KCOV_INSTRUMENT_ALL overrides the the Makefile settings?
> > Or doesn't it? I looked at scripts/Makefile.lib but failed to understand
> > what config options has precedens in that case.
> 
> Then, I guess, boot code calls into some common instrumented code,
> which gets into kcov and crashes.
> 
> This check helps, right?
> 
> +#ifdef CONFIG_UML
> +   if(!(system_state == SYSTEM_SCHEDULING ||
> +        system_state == SYSTEM_RUNNING))
> +           return;
> +#endif
> 
> Which means we somehow get here during boot. Is it possible to get a
> stack trace for the return statement?
> 
> There is no common recipe. I think x86/arm64 are somewhat fragile in
> this aspect as well, but somehow work. First of all we need to
> understand how we get into the instrumentation callback during boot.

Small info dump below. I *think* arm64 is mostly ok.

On arm64, our get_current() reads a system register that we setup in
early assembly with a pointer to our task struct. Our thread_info is
embedded in our task_struct.

That's setup in {primary,secondary}_switched, before we execute most C
code, including early init code like kasan_early_init and
kaslr_early_init, so it's safe to use current_thread_info() even in
those early bootstrap functions.

The only exception that I'm aware of is the EFI stub. However, that
isn't permitted to make calls to most kernel functions, and in its
makefile we (try to) enforce that it only calls into uninstrumented
position-independent functions. So any problems should be apparent at
build time.

There are a few special files (e.g. the out-of-line LL/SC atomics) which
we need to disable instrumentation for, which I intend to send patches
for at some point soon.

Thanks,
Mark.

