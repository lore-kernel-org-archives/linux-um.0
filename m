Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j2NP5-00025q-Ia
 for linux-um@lists.infradead.org; Thu, 13 Feb 2020 22:56:16 +0000
Received: by mail-wm1-x343.google.com with SMTP id a9so8617929wmj.3
 for <linux-um@lists.infradead.org>; Thu, 13 Feb 2020 14:56:12 -0800 (PST)
MIME-Version: 1.0
References: <20200115182816.33892-1-trishalfonso@google.com>
 <CACT4Y+b4+5PQvUeeHi=3g0my0WbaRaNEWY3P-MOVJXYSO7U5aA@mail.gmail.com>
 <CAKFsvU+zaY6B_+g=UTpOddKXXgVaKWxH3c8nw6GSLceb1Mg2qA@mail.gmail.com>
 <CACT4Y+aHRiR_7hiRE0DmaCQV2NzaqL0-kbMoVPJU=5-pcOBxJA@mail.gmail.com>
 <CAKFsvUJ2w=re_-q5PTV8c30aVwot8zMOipRvhD9cCx-9cc-Ksw@mail.gmail.com>
 <CACT4Y+ZJeABriqRZkThVa-MNDBwe7cH=Hmq1vonNmyCTMZOu6w@mail.gmail.com>
In-Reply-To: <CACT4Y+ZJeABriqRZkThVa-MNDBwe7cH=Hmq1vonNmyCTMZOu6w@mail.gmail.com>
From: Patricia Alfonso <trishalfonso@google.com>
Date: Thu, 13 Feb 2020 14:55:59 -0800
Message-ID: <CAKFsvUKun6HOk_9ocZ81YebEp90jr3WsAah24HDQQQqY9eamjg@mail.gmail.com>
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
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Brendan Higgins <brendanhiggins@google.com>, LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, linux-um@lists.infradead.org, David Gow <davidgow@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, anton.ivanov@cambridgegreys.com

On Wed, Feb 12, 2020 at 9:40 PM 'Dmitry Vyukov' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> On Wed, Feb 12, 2020 at 11:25 PM Patricia Alfonso
> <trishalfonso@google.com> wrote:
> > > On Wed, Feb 12, 2020 at 1:19 AM Patricia Alfonso
> > > <trishalfonso@google.com> wrote:
> > > >
> > > > On Thu, Jan 16, 2020 at 12:53 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > >
> > > > > > +void kasan_init(void)
> > > > > > +{
> > > > > > +       kasan_map_memory((void *)KASAN_SHADOW_START, KASAN_SHADOW_SIZE);
> > > > > > +
> > > > > > +       // unpoison the kernel text which is form uml_physmem -> uml_reserved
> > > > > > +       kasan_unpoison_shadow((void *)uml_physmem, physmem_size);
> > > > > > +
> > > > > > +       // unpoison the vmalloc region, which is start_vm -> end_vm
> > > > > > +       kasan_unpoison_shadow((void *)start_vm, (end_vm - start_vm + 1));
> > > > > > +
> > > > > > +       init_task.kasan_depth = 0;
> > > > > > +       pr_info("KernelAddressSanitizer initialized\n");
> > > > > > +}
> > > > >
> > > > > Was this tested with stack instrumentation? Stack instrumentation
> > > > > changes what shadow is being read/written and when. We don't need to
> > > > > get it working right now, but if it does not work it would be nice to
> > > > > restrict the setting and leave some comment traces for future
> > > > > generations.
> > > > If you are referring to KASAN_STACK_ENABLE, I just tested it and it
> > > > seems to work fine.
> > >
> > >
> > > I mean stack instrumentation which is enabled with CONFIG_KASAN_STACK.
> >
> > I believe I was testing with CONFIG_KASAN_STACK set to 1 since that is
> > the default value when compiling with GCC.The syscall_stub_data error
> > disappears when the value of CONFIG_KASAN_STACK is 0, though.
>
>
> Then I would either disable it for now for UML, or try to unpoision
> stack or ignore accesses.
>
Okay, I'll probably disable it in UML for now.


-- 
Patricia Alfonso

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

