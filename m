Return-Path: <computersforpeace@gmail.com>
Date: Tue, 26 Jan 2016 11:31:12 -0800
From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 11/22] mtd: Fix dependencies for !HAS_IOMEM archs
Message-ID: <20160126193112.GA19540@google.com>
References: <1453760661-1444-1-git-send-email-richard@nod.at>
 <1453760661-1444-12-git-send-email-richard@nod.at>
 <CAMuHMdVeayGN8qAmbvE7v=d0XzD3gM4TLop0qU2jf2SH_KKO9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVeayGN8qAmbvE7v=d0XzD3gM4TLop0qU2jf2SH_KKO9w@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Richard Weinberger <richard@nod.at>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, David Woodhouse <dwmw2@infradead.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Bill Pringlemeir <bpringlemeir@nbsps.com>, Stefan Agner <stefan@agner.ch>, Kevin Hao <haokexin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alex Smith <alex.smith@imgtec.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Zhou Wang <wangzhou1@hisilicon.com>, Anup Patel <anup.patel@broadcom.com>, Han xu <han.xu@freescale.com>, Joachim Eastwood <manabian@gmail.com>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Bayi Cheng <bayi.cheng@mediatek.com>, Fabio Estevam <fabio.estevam@freescale.com>, MTD Maling List <linux-mtd@lists.infradead.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Jan 26, 2016 at 12:00:37PM +0100, Geert Uytterhoeven wrote:
> On Mon, Jan 25, 2016 at 11:24 PM, Richard Weinberger <richard@nod.at> wrote:
> > Not every arch has io memory.
> > So, unbreak the build by fixing the dependencies.
> >
> > Signed-off-by: Richard Weinberger <richard@nod.at>
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Applied this one to l2-mtd.git

