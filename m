Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kpYBA-00015v-22
 for linux-um@lists.infradead.org; Wed, 16 Dec 2020 14:53:25 +0000
Received: by mail-wm1-x32e.google.com with SMTP id x22so2613489wmc.5
 for <linux-um@lists.infradead.org>; Wed, 16 Dec 2020 06:53:21 -0800 (PST)
Subject: Re: [RFC PATCH] bpf: preload: Fix build error when O= is set
References: <20201119085022.3606135-1-davidgow@google.com>
 <CAEf4BzY4i0fH34eO=-4WOzVpifgPmJ0ER5ipBJWB0_4Zdv0AQg@mail.gmail.com>
 <CABVgOSn10kCaD7EQCMJTgD8udNx6fOExqUL1gXHzEViemiq3LA@mail.gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
Message-ID: <3678c6eb-3815-a360-f495-fc246513f0f5@isovalent.com>
Date: Wed, 16 Dec 2020 14:53:13 +0000
MIME-Version: 1.0
In-Reply-To: <CABVgOSn10kCaD7EQCMJTgD8udNx6fOExqUL1gXHzEViemiq3LA@mail.gmail.com>
Content-Language: en-GB
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
To: David Gow <davidgow@google.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Networking <netdev@vger.kernel.org>, =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>, Brendan Higgins <brendanhiggins@google.com>, Alexei Starovoitov <ast@kernel.org>, open list <linux-kernel@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>, bpf <bpf@vger.kernel.org>

2020-11-21 17:48 UTC+0800 ~ David Gow <davidgow@google.com>
> On Sat, Nov 21, 2020 at 3:38 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Thu, Nov 19, 2020 at 12:51 AM David Gow <davidgow@google.com> wrote:
>>>
>>> If BPF_PRELOAD is enabled, and an out-of-tree build is requested with
>>> make O=<path>, compilation seems to fail with:
>>>
>>> tools/scripts/Makefile.include:4: *** O=.kunit does not exist.  Stop.
>>> make[4]: *** [../kernel/bpf/preload/Makefile:8: kernel/bpf/preload/libbpf.a] Error 2
>>> make[3]: *** [../scripts/Makefile.build:500: kernel/bpf/preload] Error 2
>>> make[2]: *** [../scripts/Makefile.build:500: kernel/bpf] Error 2
>>> make[2]: *** Waiting for unfinished jobs....
>>> make[1]: *** [.../Makefile:1799: kernel] Error 2
>>> make[1]: *** Waiting for unfinished jobs....
>>> make: *** [Makefile:185: __sub-make] Error 2
>>>
>>> By the looks of things, this is because the (relative path) O= passed on
>>> the command line is being passed to the libbpf Makefile, which then
>>> can't find the directory. Given OUTPUT= is being passed anyway, we can
>>> work around this by explicitly setting an empty O=, which will be
>>> ignored in favour of OUTPUT= in tools/scripts/Makefile.include.
>>
>> Strange, but I can't repro it. I use make O=<absolute path> all the
>> time with no issues. I just tried specifically with a make O=.build,
>> where .build is inside Linux repo, and it still worked fine. See also
>> be40920fbf10 ("tools: Let O= makes handle a relative path with -C
>> option") which was supposed to address such an issue. So I'm wondering
>> what exactly is causing this problem.
>>
> [+ linux-um list]
> 
> Hmm... From a quick check, I can't reproduce this on x86, so it's
> possibly a UML-specific issue.
> 
> The problem here seems to be that $PWD is, for whatever reason, equal
> to the srcdir on x86, but not on UML. In general, $PWD behaves pretty
> weirdly -- I don't fully understand it -- but if I add a tactical "PWD
> := $(shell pwd)" or use $(CURDIR) instead, the issue shows up on x86
> as well. I guess this is because PWD only gets updated when set by a
> shell or something, and UML does this somewhere?
> 
> Thoughts?
> 
> Cheers,
> -- David

Hi David, Andrii,

David, did you use a different command for building for UML and x86? I'm
asking because I reproduce on x86, but only for some targets, in
particular when I tried bindeb-pkg.

With "make O=.build vmlinux", I have:
- $(O) for "dummy" check in tools/scripts/Makefile.include set to
/linux/.build
- $(PWD) for same check set to /linux/tools
- Since $(O) is an absolute path, the "dummy" check passes

With "make O=.build bindeb-pkg", I have instead:
- $(O) set to .build (relative path)
- $(PWD) set to /linux/.build
- "dummy" check changes to /linux/.build and searches for .build in it,
which fails and aborts the build

(tools/scripts/Makefile.include is included from libbpf's Makefile,
called from kernel/bpf/preload/Makefile.)

I'm not sure how exactly the bindeb-pkg target ends up passing these values.

For what it's worth, I have been solving this (before finding this
thread) with a fix close to yours, I pass "O=$(abspath .)" on the
command line for building libbpf in kernel/bpf/preload/Makefile. It
looked consistent to me with the "tools/:" target from the main
Makefile, where "O=$(abspath $(objtree))" is passed (and $(objtree) is ".").

I hope this helps,
Quentin

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

