Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iznFc-0005RI-FP
 for linux-um@lists.infradead.org; Thu, 06 Feb 2020 19:55:49 +0000
Message-ID: <51a008bc836a2630ee59e8d521cd3d1cc475a96d.camel@sipsolutions.net>
Subject: Re: [DEMO] um: demonstrate super early constructors
From: Johannes Berg <johannes@sipsolutions.net>
Date: Thu, 06 Feb 2020 20:55:46 +0100
In-Reply-To: <20200206204937.db680692f366.Ie05fc2ad440c8db59c1519194aeac356469efa72@changeid>
References: <20200206204937.db680692f366.Ie05fc2ad440c8db59c1519194aeac356469efa72@changeid>
MIME-Version: 1.0
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
To: linux-um@lists.infradead.org
Cc: Patricia Alfonso <trishalfonso@google.com>

Now,


> +static void early_print(void)
> +{
> +	printf("I'm super early, before constructors\n");
> +}
[...]
> +static void (*early_print_ptr)(void)
> +__attribute__((section(".kasan_init"), used))
> + = early_print;

As you can see from the section name, I was obviously thinking of KASAN
here :-)

You had the following kasan_init function, and doing it this early will
be a bit problematic:

> +void kasan_init(void)
> +{
> +       kasan_map_memory((void *)KASAN_SHADOW_START, KASAN_SHADOW_SIZE);

This should be OK. I actually thought we'd have to know the memory size
even for this, but it looks like not, which is great! I guess you just
made it have a mapping that's basically large enough for everything.

> +       // unpoison the kernel text which is form uml_physmem -> uml_reserved
> +       kasan_unpoison_shadow((void *)uml_physmem, physmem_size);

This I guess you'd have to defer until they're actually set up, but
that's OK - we can only use them after that. So just moving that to
wherever uml_physmem/physmem_size are initialized should be OK.

> +       // unpoison the vmalloc region, which is start_vm -> end_vm
> +       kasan_unpoison_shadow((void *)start_vm, (end_vm - start_vm + 1));

This I'm not sure about, but again - I suppose kasan_unpoison_shadow()
really only needs the shadow memory, so we can do it whenever we
actually init the start_vm/end_vm variables (i.e. in linux_main()).

> +       init_task.kasan_depth = 0;

I guess that's OK, though it should be 0-initialized anyway?

> +       pr_info("KernelAddressSanitizer initialized\n");

That might be a bit dangerous this early in the init process, but I
guess we don't really need it :-) Can always print something much later
saying that yes, you have KASAN enabled.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

