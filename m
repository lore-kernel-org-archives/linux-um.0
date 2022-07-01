Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o7Cdq-003mdW-4P
	for linux-um@lists.infradead.org; Fri, 01 Jul 2022 09:08:47 +0000
Received: by mail-wr1-x42f.google.com with SMTP id v9so2237712wrp.7
        for <linux-um@lists.infradead.org>; Fri, 01 Jul 2022 02:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220630080834.2742777-1-davidgow@google.com> <20220630080834.2742777-2-davidgow@google.com>
 <CACT4Y+ZahTu0pGNSdZmx=4ZJHt4=mVuhxQnH_7ykDA5_fBJZVQ@mail.gmail.com>
 <20220630125434.GA20153@axis.com> <CA+fCnZe6zk8WQ7FkCsnMPLpDW2+wJcjdcrs5fxJRh+T=FvFDVA@mail.gmail.com>
In-Reply-To: <CA+fCnZe6zk8WQ7FkCsnMPLpDW2+wJcjdcrs5fxJRh+T=FvFDVA@mail.gmail.com>
From: David Gow <davidgow@google.com>
Date: Fri, 1 Jul 2022 17:08:27 +0800
Message-ID: <CABVgOSmxnTc31C-gbmbns+8YOkpppK77sdXLzASZ-hspFYDwfA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] UML: add support for KASAN under x86_64
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
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>, Dmitry Vyukov <dvyukov@google.com>, Johannes Berg <johannes@sipsolutions.net>, Patricia Alfonso <trishalfonso@google.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>, Brendan Higgins <brendanhiggins@google.com>, Andrew Morton <akpm@linux-foundation.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, kasan-dev <kasan-dev@googlegroups.com>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Daniel Latypov <dlatypov@google.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>

On Thu, Jun 30, 2022 at 9:29 PM Andrey Konovalov <andreyknvl@gmail.com> wrote:
>
> On Thu, Jun 30, 2022 at 2:54 PM Vincent Whitchurch
> <vincent.whitchurch@axis.com> wrote:
> >
> > On Thu, Jun 30, 2022 at 11:41:04AM +0200, Dmitry Vyukov wrote:
> > > On Thu, 30 Jun 2022 at 10:08, David Gow <davidgow@google.com> wrote:
> > > > diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
> > > > index 1c2d4b29a3d4..a089217e2f0e 100644
> > > > --- a/arch/um/kernel/Makefile
> > > > +++ b/arch/um/kernel/Makefile
> > > > @@ -27,6 +27,9 @@ obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
> > > >  obj-$(CONFIG_STACKTRACE) += stacktrace.o
> > > >  obj-$(CONFIG_GENERIC_PCI_IOMAP) += ioport.o
> > > >
> > > > +KASAN_SANITIZE_stacktrace.o := n
> > > > +KASAN_SANITIZE_sysrq.o := n
> > >
> > > Why are these needed?
> > > It's helpful to leave some comments for any of *_SANITIZE:=n.
> > > Otherwise later it's unclear if it's due to some latent bugs, some
> > > inherent incompatibility, something that can be fixed, etc.
> >
> > I believe I saw the stacktrace code itself triggering KASAN splats and
> > causing recursion when sanitization was not disabled on it.  I noticed
> > that other architectures disabled sanitization of their stacktrace code,
> > eg. ARM in commit 4d576cab16f57e1f87978f ("ARM: 9028/1: disable KASAN in
> > call stack capturing routines"), so I did not investigate it further.
> >
> > (Note that despite the name, sysrq.c is also just stacktrace code.)
>
> Stack trace collection code might trigger KASAN splats when walking
> stack frames, but this can be resolved by using unchecked accesses.
> The main reason to disable instrumentation here is for performance
> reasons, see the upcoming patch for arm64 [1] for some details.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?id=802b91118d11

Ah -- that does it! Using READ_ONCE_NOCHECK() in dump_trace() gets rid
of the nasty recursive KASAN failures we were getting in the tests.

I'll send out v5 with those files instrumented again.

Thanks!
-- David

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

