MIME-Version: 1.0
Date: Mon, 9 Mar 2020 10:33:47 +0100
References: <20200309092950.3042-1-geert@linux-m68k.org>
In-Reply-To: <20200309092950.3042-1-geert@linux-m68k.org>
Message-ID: <CAMuHMdVtNjtuxJYtE9npQheDe58iWwKihkz6xUB3iuzgV8hEWg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.6-rc5
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-um <linux-um@lists.infradead.org>, netdev <netdev@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>

On Mon, Mar 9, 2020 at 10:31 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.6-rc5[1] to v5.6-rc4[3], the summaries are:
>   - build errors: +2/-0

  + error: "devm_ioremap_resource"
[drivers/net/ethernet/xilinx/xilinx_emac.ko] undefined!:  => N/A
  + error: "devm_ioremap_resource" [drivers/ptp/ptp_ines.ko] undefined!:  => N/A

um-all{mod,yes}config

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/2c523b344dfa65a3738e7039832044aa133c75fb/ (all 239 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/98d54f81e36ba3bf92172791eba5ca5bd813989b/ (all 239 configs)

>   + error: "devm_ioremap_resource" [drivers/net/ethernet/xilinx/xilinx_emac.ko] undefined!:  => N/A
>   + error: "devm_ioremap_resource" [drivers/ptp/ptp_ines.ko] undefined!:  => N/A
Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

