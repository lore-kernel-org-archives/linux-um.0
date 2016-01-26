MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1453760661-1444-12-git-send-email-richard@nod.at>
References: <1453760661-1444-1-git-send-email-richard@nod.at>
	<1453760661-1444-12-git-send-email-richard@nod.at>
Date: Tue, 26 Jan 2016 12:00:37 +0100
Message-ID: <CAMuHMdVeayGN8qAmbvE7v=d0XzD3gM4TLop0qU2jf2SH_KKO9w@mail.gmail.com>
Subject: Re: [PATCH 11/22] mtd: Fix dependencies for !HAS_IOMEM archs
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
To: Richard Weinberger <richard@nod.at>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Bill Pringlemeir <bpringlemeir@nbsps.com>, Stefan Agner <stefan@agner.ch>, Kevin Hao <haokexin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alex Smith <alex.smith@imgtec.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Zhou Wang <wangzhou1@hisilicon.com>, Anup Patel <anup.patel@broadcom.com>, Han xu <han.xu@freescale.com>, Joachim Eastwood <manabian@gmail.com>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Bayi Cheng <bayi.cheng@mediatek.com>, Fabio Estevam <fabio.estevam@freescale.com>, MTD Maling List <linux-mtd@lists.infradead.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, Jan 25, 2016 at 11:24 PM, Richard Weinberger <richard@nod.at> wrote:
> Not every arch has io memory.
> So, unbreak the build by fixing the dependencies.
>
> Signed-off-by: Richard Weinberger <richard@nod.at>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

