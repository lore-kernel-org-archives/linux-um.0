Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYjEZ-00BpJA-Ct
 for linux-um@lists.infradead.org; Tue, 20 Apr 2021 05:47:43 +0000
Received: by mail-pf1-x42a.google.com with SMTP id g16so11478300pfq.5
 for <linux-um@lists.infradead.org>; Mon, 19 Apr 2021 22:47:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210419153213.1337562-1-zhuyifei1999@gmail.com>
 <546324c4e77ebe65f27b0f06fea3ace28dd75fe6.camel@sipsolutions.net>
 <CABqSeASZLeK8dq-75dcM51zmkHUteuJc07bS8ixKVhEAAeuPDw@mail.gmail.com>
In-Reply-To: <CABqSeASZLeK8dq-75dcM51zmkHUteuJc07bS8ixKVhEAAeuPDw@mail.gmail.com>
From: YiFei Zhu <zhuyifei1999@gmail.com>
Date: Tue, 20 Apr 2021 00:47:27 -0500
Message-ID: <CABqSeAQdwhJCTyO9w6f2cmyobh2bnA5wG6ZgCS9gD0b7ZSi=yw@mail.gmail.com>
Subject: Re: [PATCH v2] um: Fix stack pointer alignment
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
To: Johannes Berg <johannes@sipsolutions.net>, Colin Ian King <colin.king@canonical.com>
Cc: linux-um@lists.infradead.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Benjamin Berg <benjamin@sipsolutions.net>

On Mon, Apr 19, 2021 at 3:36 PM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> > > To reproduce this bug, enable CONFIG_UML_RTC. uml_rtc will call
> > > add_sigio_fd which will then cause write_sigio_thread to go
> > > into segfault loop.
> >
> > It must also depend on the glibc version, because I've definitely been
> > testing UML_RTC on 64-bit, on Fedora 32 at the time.
> >
>
> Hmm. Interesting. I can't seem to find anything suggesting Fedora has
> a patch that would align the stack within clone() [3][4]. I also got a
> Fedora 32 docker image and could not see the aligning from disassembly
> of clone, and the gcc version installed by yum is 10.2.1-9.fc32, which
> is supposed to be affected by this issue... weird. I would expect this
> to fail outright. I'm considering compiling uml inside this container
> to see what is going on.

It seems config related. I tested with my original config and it
segfault loops, but then I tested with a fresh defconfig, then enabled
RTC_CLASS and UML_RTC and it boots successfully, with the assembly as:

  movaps (%rdx),%xmm0
  movaps %xmm0,(%r12)

The move from xmm0 to stack is omitted.

After a bit of trial and error I found changing from
CC_OPTIMIZE_FOR_SIZE to CC_OPTIMIZE_FOR_PERFORMANCE alone makes the
difference. What's also interesting is that instead of
segfault-looping (as in, segfault recovery did not do anything to fix
the fault, so after sigreturn it segfaults again), it panics with
"Segfault with no mm" which seems more like the expected behavior.

I'll send a v3 to clarify CC_OPTIMIZE_FOR_PERFORMANCE.

YiFei Zhu

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

