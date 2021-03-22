MIME-Version: 1.0
Date: Mon, 22 Mar 2021 15:43:47 +0100
References: <20210322141417.1062111-1-geert@linux-m68k.org>
In-Reply-To: <20210322141417.1062111-1-geert@linux-m68k.org>
Message-ID: <CAMuHMdVvCGa6SaumOOA-hM=WDEb7WHgXTNRsTrU=BnCXGqcr2g@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.12-rc4
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, linux-um <linux-um@lists.infradead.org>
List-ID: <linux-um.lists.infradead.org>

On Mon, Mar 22, 2021 at 3:16 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.12-rc4[1] to v5.12-rc3[3], the summaries are:
>   - build errors: +6/-2

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b/ (all 192 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/1e28eed17697bcf343c6743f0028cc3b5dd88bf0/ (all 192 configs)

> 6 error regressions:
>   + error: modpost: "devm_ioremap_resource" [drivers/net/ethernet/xilinx/xilinx_emac.ko] undefined!:  => N/A
>   + error: modpost: "devm_ioremap_resource" [drivers/net/ethernet/xilinx/xilinx_emaclite.ko] undefined!:  => N/A
>   + error: modpost: "devm_of_iomap" [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A
>   + error: modpost: "devm_platform_ioremap_resource" [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A
>   + error: modpost: "devm_platform_ioremap_resource_byname" [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A

x86_64/um-allmodconfig

>   + error: rk3399_gru_sound.c: relocation truncated to fit: R_NDS32_WORD_9_PCREL_RELA against `.text':  => (.text+0x6a8)

nds32le-gcc8/nds32-allyesconfig

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

