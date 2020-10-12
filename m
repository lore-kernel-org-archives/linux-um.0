MIME-Version: 1.0
Date: Mon, 12 Oct 2020 09:24:25 +0200
References: <20201012072114.5245-1-geert@linux-m68k.org>
In-Reply-To: <20201012072114.5245-1-geert@linux-m68k.org>
Message-ID: <CAMuHMdU_RtEsoRy0Accb99uiTTb4Y_z1iDAg4yijNtDZA9ZoNw@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.9
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-um <linux-um@lists.infradead.org>
List-ID: <linux-um.lists.infradead.org>

On Mon, Oct 12, 2020 at 9:22 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.9[1] to v5.9-rc8[3], the summaries are:
>   - build errors: +6/-3
>   - build warnings: +5/-0

  + error: modpost: "devm_ioremap"
[drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A
  + error: modpost: "devm_ioremap_resource"
[drivers/net/ethernet/xilinx/xilinx_emac.ko] undefined!:  => N/A
  + error: modpost: "devm_of_iomap"
[drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A
  + error: modpost: "devm_platform_ioremap_resource"
[drivers/iio/adc/adi-axi-adc.ko] undefined!:  => N/A
  + error: modpost: "devm_platform_ioremap_resource"
[drivers/ptp/ptp_ines.ko] undefined!:  => N/A
  + error: modpost: "devm_platform_ioremap_resource_byname"
[drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A

um-all{mod,yes}config

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/bbf5c979011a099af5dc76498918ed7df445635b/ (all 192 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/549738f15da0e5a00275977623be199fbbf7df50/ (all 192 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

