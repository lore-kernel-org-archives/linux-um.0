Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o7DzF-0045tQ-IG
	for linux-um@lists.infradead.org; Fri, 01 Jul 2022 10:34:59 +0000
Received: by mail-lf1-x131.google.com with SMTP id t24so3132473lfr.4
        for <linux-um@lists.infradead.org>; Fri, 01 Jul 2022 03:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220630080834.2742777-1-davidgow@google.com> <20220630080834.2742777-2-davidgow@google.com>
 <CACT4Y+ZahTu0pGNSdZmx=4ZJHt4=mVuhxQnH_7ykDA5_fBJZVQ@mail.gmail.com>
 <20220630125434.GA20153@axis.com> <CA+fCnZe6zk8WQ7FkCsnMPLpDW2+wJcjdcrs5fxJRh+T=FvFDVA@mail.gmail.com>
 <CABVgOSmxnTc31C-gbmbns+8YOkpppK77sdXLzASZ-hspFYDwfA@mail.gmail.com>
 <20220701091653.GA7009@axis.com> <CABVgOSnEEWEe16O4YsyuiWttffdAAbkpuXehefGEEeYvjPqVkA@mail.gmail.com>
 <20220701100441.GA8082@axis.com>
In-Reply-To: <20220701100441.GA8082@axis.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 1 Jul 2022 12:34:35 +0200
Message-ID: <CACT4Y+ZvPDLR_e2VR8+hKZ+fnLo9_KkTTgUMqqM1kaoo0kW-fA@mail.gmail.com>
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
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: David Gow <davidgow@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, Patricia Alfonso <trishalfonso@google.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>, Brendan Higgins <brendanhiggins@google.com>, Andrew Morton <akpm@linux-foundation.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, kasan-dev <kasan-dev@googlegroups.com>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Daniel Latypov <dlatypov@google.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>

On Fri, 1 Jul 2022 at 12:04, Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
> > <vincent.whitchurch@axis.com> wrote:
> > > On Fri, Jul 01, 2022 at 11:08:27AM +0200, David Gow wrote:
> > > > On Thu, Jun 30, 2022 at 9:29 PM Andrey Konovalov <andreyknvl@gmail.com> wrote:
> > > > > Stack trace collection code might trigger KASAN splats when walking
> > > > > stack frames, but this can be resolved by using unchecked accesses.
> > > > > The main reason to disable instrumentation here is for performance
> > > > > reasons, see the upcoming patch for arm64 [1] for some details.
> > > > >
> > > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?id=802b91118d11
> > > >
> > > > Ah -- that does it! Using READ_ONCE_NOCHECK() in dump_trace() gets rid
> > > > of the nasty recursive KASAN failures we were getting in the tests.
> > > >
> > > > I'll send out v5 with those files instrumented again.
> > >
> > > Hmm, do we really want that?  In the patch Andrey linked to above he
> > > removed the READ_ONCE_NOCHECK() and added the KASAN_SANITIZE on the
> > > corresponding files for arm64, just like it's already the case in this
> > > patch for UML.
> >
> > Personally, I'm okay with the performance overhead so far: in my tests
> > with a collection of ~350 KUnit tests, the total difference in runtime
> > was about ~.2 seconds, and was within the margin of error caused by
> > fluctuations in the compilation time.
> >
> > As an example, without the stacktrace code instrumented:
> > [17:36:50] Testing complete. Passed: 364, Failed: 0, Crashed: 0,
> > Skipped: 47, Errors: 0
> > [17:36:50] Elapsed time: 15.114s total, 0.003s configuring, 8.518s
> > building, 6.433s running
> >
> > versus with it instrumented:
> > [17:35:40] Testing complete. Passed: 364, Failed: 0, Crashed: 0,
> > Skipped: 47, Errors: 0
> > [17:35:40] Elapsed time: 15.497s total, 0.003s configuring, 8.691s
> > building, 6.640s running
>
> OK, good to know.
>
> > That being said, I'm okay with disabling it again and adding a comment
> > if it's slow enough in some other usecase to cause problems (or even
> > just be annoying). That could either be done in a v6 of this patchset,
> > or a follow-up patch, depending on what people would prefer. But I'd
> > not have a problem with leaving it instrumented for now.
>
> I don't have any strong opinion either way either, so you don't have to
> change it back on my account.  Thanks.

I would consider using READ_ONCE_NOCHECK() by default. And then
switching to KASAN_SANITIZE:=n only if there is a real reason for
that. Disabling instrumentation of any part of the kernel makes things
faster, but at the same time we are losing checking coverage.
For arm it was done for a very specific reason related to performance.
While UML can be considered more test-oriented rather than
production-oriented.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

