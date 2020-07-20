MIME-Version: 1.0
Date: Mon, 20 Jul 2020 16:01:46 +0200
References: <20200720130737.4428-1-geert@linux-m68k.org>
In-Reply-To: <20200720130737.4428-1-geert@linux-m68k.org>
Message-ID: <CAMuHMdUB5kFC5R6b6-OxPfP-PRLYBOK_d7dPjU_LcmYuLtGJpg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.8-rc6
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-um <linux-um@lists.infradead.org>
List-ID: <linux-um.lists.infradead.org>

On Mon, Jul 20, 2020 at 3:12 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.8-rc6[1] to v5.8-rc5[3], the summaries are:
>   - build errors: +6/-3

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
  + error: modpost: "devm_platform_ioremap_resource"
[drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.ko] undefined!:
 => N/A

um-x86_64/um-all{mod,yes}config

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/ba47d845d715a010f7b51f6f89bae32845e6acb7/ (192 out of 194 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/11ba468877bb23f28956a35e896356252d63c983/ (192 out of 194 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

