MIME-Version: 1.0
Date: Mon, 20 Dec 2021 10:45:46 +0100
References: <20211220084013.242754-1-geert@linux-m68k.org>
In-Reply-To: <20211220084013.242754-1-geert@linux-m68k.org>
Message-ID: <CAMuHMdXTRYjtfyWTVN86pn4STO2EPR1B5+KHj=wAqguXt=hpHg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.16-rc6
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-um <linux-um@lists.infradead.org>, DRI Development <dri-devel@lists.freedesktop.org>
List-ID: <linux-um.lists.infradead.org>

On Mon, Dec 20, 2021 at 10:25 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.16-rc6[1] to v5.16-rc5[3], the summaries are:
>   - build errors: +1/-5

  + /kisskb/src/drivers/gpu/drm/ttm/ttm_module.c: error: 'struct
cpuinfo_um' has no member named 'x86':  => 71:24

um-x86_64/um-allyesconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/a7904a538933c525096ca2ccde1e60d0ee62c08e/ (all 90 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/2585cf9dfaaddf00b069673f27bb3f8530e2039c/ (all 90 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

