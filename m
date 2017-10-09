MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1507576779-29445-1-git-send-email-geert@linux-m68k.org>
References: <1507576779-29445-1-git-send-email-geert@linux-m68k.org>
Date: Mon, 9 Oct 2017 22:34:52 +0200
Message-ID: <CAMuHMdWZm8XPmzwedQ604Y4YWj7XqaJUx8AdFRh2WTvwen0M6Q@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.14-rc4
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, Oct 9, 2017 at 9:19 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.14-rc4[1] to v4.14-rc3[3], the summaries are:
>   - build errors: +1/-2

  + error: "devm_ioremap_resource"
[drivers/auxdisplay/img-ascii-lcd.ko] undefined!:  => N/A

um-x86_64/um-all{yes,mod}config (patch available)

>   - build warnings: +817/-384

Thanks to the addition of um-x86_64 build coverage, a lot of warnings appeared
about missing CRCs for memcpy in modules, e.g.

   + warning: "memcpy" [crypto/af_alg.ko] has no CRC!:  => N/A

> [1] http://kisskb.ellerman.id.au/kisskb/head/8a5776a5f49812d29fe4b2d0a2d71675c3facf3f/ (all 269 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/9e66317d3c92ddaab330c125dfe9d06eee268aff/ (267 out of 269 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

