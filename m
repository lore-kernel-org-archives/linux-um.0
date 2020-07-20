Return-Path: <johannes@sipsolutions.net>
Message-ID: <2b2e1695f6d9341f357f12ffdce59c06e36a383b.camel@sipsolutions.net>
Subject: Re: Build regressions/improvements in v5.8-rc6
From: Johannes Berg <johannes@sipsolutions.net>
Date: Mon, 20 Jul 2020 19:20:40 +0200
In-Reply-To: <CAMuHMdUB5kFC5R6b6-OxPfP-PRLYBOK_d7dPjU_LcmYuLtGJpg@mail.gmail.com>
References: <20200720130737.4428-1-geert@linux-m68k.org>
	 <CAMuHMdUB5kFC5R6b6-OxPfP-PRLYBOK_d7dPjU_LcmYuLtGJpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-um <linux-um@lists.infradead.org>
List-ID: <linux-um.lists.infradead.org>

On Mon, 2020-07-20 at 16:01 +0200, Geert Uytterhoeven wrote:
> On Mon, Jul 20, 2020 at 3:12 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > JFYI, when comparing v5.8-rc6[1] to v5.8-rc5[3], the summaries are:
> >   - build errors: +6/-3
> 
>   + error: modpost: "devm_ioremap"
> [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A
>   + error: modpost: "devm_ioremap_resource"
> [drivers/net/ethernet/xilinx/xilinx_emac.ko] undefined!:  => N/A
>   + error: modpost: "devm_of_iomap"
> [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A
>   + error: modpost: "devm_platform_ioremap_resource"
> [drivers/iio/adc/adi-axi-adc.ko] undefined!:  => N/A
>   + error: modpost: "devm_platform_ioremap_resource"
> [drivers/ptp/ptp_ines.ko] undefined!:  => N/A
>   + error: modpost: "devm_platform_ioremap_resource"
> [drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.ko] undefined!:
>  => N/A
> 
> um-x86_64/um-all{mod,yes}config

Must be an issue with those drivers - ARCH=um can't do ioremap(). The
drivers should depend on HAS_IOMEM or something like that?

johannes


