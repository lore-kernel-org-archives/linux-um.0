Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20201119085022.3606135-1-davidgow@google.com> <CAEf4BzY4i0fH34eO=-4WOzVpifgPmJ0ER5ipBJWB0_4Zdv0AQg@mail.gmail.com>
In-Reply-To: <CAEf4BzY4i0fH34eO=-4WOzVpifgPmJ0ER5ipBJWB0_4Zdv0AQg@mail.gmail.com>
From: David Gow <davidgow@google.com>
Date: Sat, 21 Nov 2020 17:48:44 +0800
Message-ID: <CABVgOSn10kCaD7EQCMJTgD8udNx6fOExqUL1gXHzEViemiq3LA@mail.gmail.com>
Subject: Re: [RFC PATCH] bpf: preload: Fix build error when O= is set
Content-Type: text/plain; charset="UTF-8"
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Brendan Higgins <brendanhiggins@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, linux-um <linux-um@lists.infradead.org>
List-ID: <linux-um.lists.infradead.org>

On Sat, Nov 21, 2020 at 3:38 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Nov 19, 2020 at 12:51 AM David Gow <davidgow@google.com> wrote:
> >
> > If BPF_PRELOAD is enabled, and an out-of-tree build is requested with
> > make O=<path>, compilation seems to fail with:
> >
> > tools/scripts/Makefile.include:4: *** O=.kunit does not exist.  Stop.
> > make[4]: *** [../kernel/bpf/preload/Makefile:8: kernel/bpf/preload/libbpf.a] Error 2
> > make[3]: *** [../scripts/Makefile.build:500: kernel/bpf/preload] Error 2
> > make[2]: *** [../scripts/Makefile.build:500: kernel/bpf] Error 2
> > make[2]: *** Waiting for unfinished jobs....
> > make[1]: *** [.../Makefile:1799: kernel] Error 2
> > make[1]: *** Waiting for unfinished jobs....
> > make: *** [Makefile:185: __sub-make] Error 2
> >
> > By the looks of things, this is because the (relative path) O= passed on
> > the command line is being passed to the libbpf Makefile, which then
> > can't find the directory. Given OUTPUT= is being passed anyway, we can
> > work around this by explicitly setting an empty O=, which will be
> > ignored in favour of OUTPUT= in tools/scripts/Makefile.include.
>
> Strange, but I can't repro it. I use make O=<absolute path> all the
> time with no issues. I just tried specifically with a make O=.build,
> where .build is inside Linux repo, and it still worked fine. See also
> be40920fbf10 ("tools: Let O= makes handle a relative path with -C
> option") which was supposed to address such an issue. So I'm wondering
> what exactly is causing this problem.
>
[+ linux-um list]

Hmm... From a quick check, I can't reproduce this on x86, so it's
possibly a UML-specific issue.

The problem here seems to be that $PWD is, for whatever reason, equal
to the srcdir on x86, but not on UML. In general, $PWD behaves pretty
weirdly -- I don't fully understand it -- but if I add a tactical "PWD
:= $(shell pwd)" or use $(CURDIR) instead, the issue shows up on x86
as well. I guess this is because PWD only gets updated when set by a
shell or something, and UML does this somewhere?

Thoughts?

Cheers,
-- David

> >
> > Signed-off-by: David Gow <davidgow@google.com>
> > ---
> >
> > Hi all,
> >
> > I'm not 100% sure this is the correct fix here -- it seems to work for
> > me, and makes some sense, but let me know if there's a better way.
> >
> > One other thing worth noting is that I've been hitting this with
> > make allyesconfig on ARCH=um, but there's a comment in the Kconfig
> > suggesting that, because BPF_PRELOAD depends on !COMPILE_TEST, that
> > maybe it shouldn't be being built at all. I figured that it was worth
> > trying to fix this anyway.
> >
> > Cheers,
> > -- David
> >
> >
> >  kernel/bpf/preload/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/preload/Makefile b/kernel/bpf/preload/Makefile
> > index 23ee310b6eb4..39848d296097 100644
> > --- a/kernel/bpf/preload/Makefile
> > +++ b/kernel/bpf/preload/Makefile
> > @@ -5,7 +5,7 @@ LIBBPF_A = $(obj)/libbpf.a
> >  LIBBPF_OUT = $(abspath $(obj))
> >
> >  $(LIBBPF_A):
> > -       $(Q)$(MAKE) -C $(LIBBPF_SRCS) OUTPUT=$(LIBBPF_OUT)/ $(LIBBPF_OUT)/libbpf.a
> > +       $(Q)$(MAKE) -C $(LIBBPF_SRCS) O= OUTPUT=$(LIBBPF_OUT)/ $(LIBBPF_OUT)/libbpf.a
> >
> >  userccflags += -I $(srctree)/tools/include/ -I $(srctree)/tools/include/uapi \
> >         -I $(srctree)/tools/lib/ -Wno-unused-result
> > --
> > 2.29.2.454.gaff20da3a2-goog
> >

