Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1izlxp-0001IY-Nt
 for linux-um@lists.infradead.org; Thu, 06 Feb 2020 18:33:23 +0000
Received: by mail-wr1-x443.google.com with SMTP id a6so8380443wrx.12
 for <linux-um@lists.infradead.org>; Thu, 06 Feb 2020 10:33:21 -0800 (PST)
MIME-Version: 1.0
References: <20200115182816.33892-1-trishalfonso@google.com>
 <dce24e66d89940c8998ccc2916e57877ccc9f6ae.camel@sipsolutions.net>
 <CAKFsvU+sUdGC9TXK6vkg5ZM9=f7ePe7+rh29DO+kHDzFXacx2w@mail.gmail.com>
 <4f382794416c023b6711ed2ca645abe4fb17d6da.camel@sipsolutions.net>
 <b55720804de8e56febf48c7c3c11b578d06a8c9f.camel@sipsolutions.net>
 <CACT4Y+brqD-o-u3Vt=C-PBiS2Wz+wXN3Q3RqBhf3XyRYaRoZJw@mail.gmail.com>
 <2092169e6dd1f8d15f1db4b3787cc9fe596097b7.camel@sipsolutions.net>
 <CACT4Y+b6C+y9sDfMYPDy-nh=WTt5+u2kLcWx2LQmHc1A5L7y0A@mail.gmail.com>
 <CACT4Y+atPME1RYvusmr2EQpv_mNkKJ2_LjMeANv0HxF=+Uu5hw@mail.gmail.com>
 <CACT4Y+bsaZoPC1Q7_rV-e_aO=LVPA-cE3btT_VARStWYk6dcPA@mail.gmail.com>
 <CACT4Y+Z6_CwVyJhr3SdDejFsrXcM11LVY+gh4oKP6k03Pn95AA@mail.gmail.com>
In-Reply-To: <CACT4Y+Z6_CwVyJhr3SdDejFsrXcM11LVY+gh4oKP6k03Pn95AA@mail.gmail.com>
From: Patricia Alfonso <trishalfonso@google.com>
Date: Thu, 6 Feb 2020 10:33:08 -0800
Message-ID: <CAKFsvULhg7i=tuw1LMS9avy4-NgDDfK2k-_kCa3CH3sNRXa0Qw@mail.gmail.com>
Subject: Re: [RFC PATCH] UML: add support for KASAN under x86_64
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Brendan Higgins <brendanhiggins@google.com>, LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, linux-um@lists.infradead.org, David Gow <davidgow@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Johannes Berg <johannes@sipsolutions.net>, anton.ivanov@cambridgegreys.com

On Fri, Jan 17, 2020 at 2:05 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Fri, Jan 17, 2020 at 11:03 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Fri, Jan 17, 2020 at 10:59 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > On Thu, Jan 16, 2020 at 10:39 PM Patricia Alfonso
> > > <trishalfonso@google.com> wrote:
> > > >
> > > > On Thu, Jan 16, 2020 at 1:23 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > >
> > > > > On Thu, Jan 16, 2020 at 10:20 AM Johannes Berg
> > > > > <johannes@sipsolutions.net> wrote:
> > > > > >
> > > > > > On Thu, 2020-01-16 at 10:18 +0100, Dmitry Vyukov wrote:
> > > > > > >
> > > > > > > This should resolve the problem with constructors (after they
> > > > > > > initialize KASAN, they can proceed to do anything they need) and it
> > > > > > > should get rid of most KASAN_SANITIZE (in particular, all of
> > > > > > > lib/Makefile and kernel/Makefile) and should fix stack instrumentation
> > > > > > > (in case it does not work now). The only tiny bit we should not
> > > > > > > instrument is the path from constructor up to mmap call.
> > > >

By initializing KASAN as the first thing that executes, I have been
able to get rid of most of the "KASAN_SANITIZE := n" lines and I am
very happy about that. Thanks for the suggestions!

> > > If that part of the code I mentioned is instrumented, manifestation
> > > would be different -- stack instrumentation will try to access shadow,
> > > shadow is not mapped yet, so it would crash on the shadow access.
> > >
> > > What you are seeing looks like, well, a kernel bug where it does a bad
> > > stack access. Maybe it's KASAN actually _working_? :)
> >
> > Though, stack instrumentation may have issues with longjmp-like things.
> > I would suggest first turning off stack instrumentation and getting
> > that work. Solving problems one-by-one is always easier.
> > If you need help debugging this, please post more info: patch, what
> > you are doing, full kernel output (preferably from start, if it's not
> > too lengthy).
>
> I see syscall_stub_data does some weird things with stack (stack
> copy?). Maybe we just need to ignore accesses there: individual
> accesses, or whole function/file.

It is still not clear whether the syscall_stub_data errors are false
positives, but while moving the kasan_init() to be as early as
possible in main(), I ran into a few more stack-related errors like
this(show_stack, dump_trace, and get_wchan). I will be taking your
advice to focus on one thing at a time and temporarily disable stack
instrumentation wherever possible.

--
Patricia Alfonso

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

