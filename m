MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <e519609e20be6c6be87bbf0e2dd716abdfaa698e.1399678795.git.joe@perches.com>
References: <cover.1399678795.git.joe@perches.com>
	<e519609e20be6c6be87bbf0e2dd716abdfaa698e.1399678795.git.joe@perches.com>
Date: Mon, 12 May 2014 09:59:09 +0200
Message-ID: <CAMuHMdUVzOtBtDc3atrsmEcrr0_xHR3ujnzWKSZaN_mvKs_jkA@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH 1/4] UserModeLinux: Convert UM_KERN_<LEVEL> to KERN_<LEVEL>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
To: Joe Perches <joe@perches.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sat, May 10, 2014 at 1:43 AM, Joe Perches <joe@perches.com> wrote:
> The defines are the same since commit 9429ec96c2718
> ("um: Preinclude include/linux/kern_levels.h")
> so just convert them to the normal KERN_<LEVEL> uses.
>
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Cfr.
https://lkml.org/lkml/2012/9/29/77
https://lkml.org/lkml/2012/9/29/106

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus
Torvaldshttps://lkml.org/lkml/2012/9/29/106

