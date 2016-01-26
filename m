MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1453760661-1444-22-git-send-email-richard@nod.at>
References: <1453760661-1444-1-git-send-email-richard@nod.at>
	<1453760661-1444-22-git-send-email-richard@nod.at>
Date: Tue, 26 Jan 2016 12:00:07 +0100
Message-ID: <CAMuHMdX_nH9U9gU4NH0KWPDVXBZmLbQDUp8MVXFpcciwKjmwuA@mail.gmail.com>
Subject: Re: [PATCH 21/22] mtd: cs553x: Fix dependencies for !HAS_IOMEM archs
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
To: Richard Weinberger <richard@nod.at>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Bill Pringlemeir <bpringlemeir@nbsps.com>, Stefan Agner <stefan@agner.ch>, Alex Smith <alex.smith@imgtec.com>, Zhou Wang <wangzhou1@hisilicon.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Anup Patel <anup.patel@broadcom.com>, MTD Maling List <linux-mtd@lists.infradead.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hi Richard,

On Mon, Jan 25, 2016 at 11:24 PM, Richard Weinberger <richard@nod.at> wrote:
> Not every arch has io memory nor can this driver ever work
> on UML/i386.
> So, unbreak the build by fixing the dependencies.
>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  drivers/mtd/nand/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index 545d82b..b253654 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -311,6 +311,7 @@ config MTD_NAND_CAFE
>  config MTD_NAND_CS553X
>         tristate "NAND support for CS5535/CS5536 (AMD Geode companion chip)"
>         depends on X86_32
> +       depends on !UML && HAS_IOMEM

I don't think there's a need for the !UML dependency?
Hence just "depends on X86_32 && HAS_IOMEM"?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

