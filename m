Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1izrYN-0006Yz-HQ
 for linux-um@lists.infradead.org; Fri, 07 Feb 2020 00:31:28 +0000
Received: by mail-wm1-x333.google.com with SMTP id a5so832711wmb.0
 for <linux-um@lists.infradead.org>; Thu, 06 Feb 2020 16:31:24 -0800 (PST)
MIME-Version: 1.0
References: <20200206204937.db680692f366.Ie05fc2ad440c8db59c1519194aeac356469efa72@changeid>
 <51a008bc836a2630ee59e8d521cd3d1cc475a96d.camel@sipsolutions.net>
In-Reply-To: <51a008bc836a2630ee59e8d521cd3d1cc475a96d.camel@sipsolutions.net>
From: Patricia Alfonso <trishalfonso@google.com>
Date: Thu, 6 Feb 2020 16:31:12 -0800
Message-ID: <CAKFsvUJzj-DXe9sDumyYmSr2WqrBCK6Xiuon+G1w8Jeycsc7tA@mail.gmail.com>
Subject: Re: [DEMO] um: demonstrate super early constructors
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org

On Thu, Feb 6, 2020 at 11:55 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> Now,
>
>
> > +static void early_print(void)
> > +{
> > +     printf("I'm super early, before constructors\n");
> > +}
> [...]
> > +static void (*early_print_ptr)(void)
> > +__attribute__((section(".kasan_init"), used))
> > + = early_print;
>
> As you can see from the section name, I was obviously thinking of KASAN
> here :-)
>
> You had the following kasan_init function, and doing it this early will
> be a bit problematic:
>
With my new changes, this actually works great! Thank you!

> > +void kasan_init(void)
> > +{
> > +       kasan_map_memory((void *)KASAN_SHADOW_START, KASAN_SHADOW_SIZE);
>
> This should be OK. I actually thought we'd have to know the memory size
> even for this, but it looks like not, which is great! I guess you just
> made it have a mapping that's basically large enough for everything.
>
> > +       // unpoison the kernel text which is form uml_physmem -> uml_reserved
> > +       kasan_unpoison_shadow((void *)uml_physmem, physmem_size);
>
> This I guess you'd have to defer until they're actually set up, but
> that's OK - we can only use them after that. So just moving that to
> wherever uml_physmem/physmem_size are initialized should be OK.
>
> > +       // unpoison the vmalloc region, which is start_vm -> end_vm
> > +       kasan_unpoison_shadow((void *)start_vm, (end_vm - start_vm + 1));
>
> This I'm not sure about, but again - I suppose kasan_unpoison_shadow()
> really only needs the shadow memory, so we can do it whenever we
> actually init the start_vm/end_vm variables (i.e. in linux_main()).
>
These are actually extraneous lines of code, as pointed out by Dmitry
Vyukov, because mmap
always gives zeroed memory so they're no longer a problem.

Thank you so much for this patch!! I have been trying to find an
elegant fix all week and this is perfect!

-- 
Patricia Alfonso

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

