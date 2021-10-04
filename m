MIME-Version: 1.0
Date: Mon, 4 Oct 2021 13:18:23 +0200
References: <20211004111224.941450-1-geert@linux-m68k.org>
In-Reply-To: <20211004111224.941450-1-geert@linux-m68k.org>
Message-ID: <CAMuHMdXA-4Y0obSTmwkavauwpMrM8LXxnofeNXtGuC7N=bu5Uw@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.15-rc4
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-um <linux-um@lists.infradead.org>
List-ID: <linux-um.lists.infradead.org>

On Mon, Oct 4, 2021 at 1:15 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.15-rc4[1] to v5.15-rc3[3], the summaries are:
>   - build errors: +1/-4

  + /kisskb/src/drivers/video/fbdev/nvidia/nvidia.c: error: passing
argument 1 of 'iounmap' discards 'volatile' qualifier from pointer
target type [-Werror=discarded-qualifiers]:  => 1439:10, 1414:10

um-x86_64/um-allyesconfig (fix available)

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/9e1ff307c779ce1f0f810c7ecce3d95bbae40896/ (90 out of 182 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/5816b3e6577eaa676ceb00a848f0fd65fe2adc29/ (90 out of 182 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

