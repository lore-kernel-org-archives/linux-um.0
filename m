MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1bffdbbd-a317-d9a3-88d2-d02501d2fae1@deltatee.com>
References: <1495726955-27497-1-git-send-email-logang@deltatee.com>
	<3c36765c-9e23-7947-b6d9-29ca892bd348@nod.at>
	<1bffdbbd-a317-d9a3-88d2-d02501d2fae1@deltatee.com>
Date: Sat, 27 May 2017 20:08:20 +0200
Message-ID: <CAMuHMdUrDPvNoZ5UpS-qu4JOyq+JSy2tpxttKiUPFexB6yhTYw@mail.gmail.com>
Subject: Re: [PATCH v2] um: add dummy ioremap and iounmap functions
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Richard Weinberger <richard@nod.at>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Stephen Bates <sbates@raithlin.com>, Jeff Dike <jdike@addtoit.com>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hi Logan,

On Thu, May 25, 2017 at 5:53 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> On 25/05/17 09:48 AM, Richard Weinberger wrote:
>> Which ones are failing?
>> I thought we killed the problem by making CONFIG_COMPILE_TEST depend on !UML.
>
> None, at the moment. My work is trying to add iomem support to scatter
> lists and thus I want to call ioremap in scatterlist.c. That's when
> things fail to build. We could put an '#ifdef HAS_IOMEM' around only the
> uses, but I thought this approach was cleaner. However, if people would
> rather I do that, let me know and I will.
>
>> I was never a fan of that approach because in my opinion drivers should have
>> proper dependencies, including a dependency on HAS_IOMEM.
>
> This doesn't really work when we try to use it in a core library which
> can't depend on HAS_IOMEM.

Still, those code patch could be protected by #ifdef CONFIG_HAS_IOMEM,
or better, if (IS_ENABLED(CONFIG_HAS_IOMEM)).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

