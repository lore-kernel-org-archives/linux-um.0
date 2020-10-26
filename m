MIME-Version: 1.0
Date: Mon, 26 Oct 2020 10:48:55 +0100
References: <20201026081811.3934205-1-geert@linux-m68k.org>
In-Reply-To: <20201026081811.3934205-1-geert@linux-m68k.org>
Message-ID: <CAMuHMdXbsJPnsXg6bA_e32zJkBG1Zzqj-ja5WzHDKL0d9OcfPg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.10-rc1
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-um <linux-um@lists.infradead.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, arcml <linux-snps-arc@lists.infradead.org>
List-ID: <linux-um.lists.infradead.org>

On Mon, Oct 26, 2020 at 10:46 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v5.10-rc1[1] compared to v5.9[2].
>
> Summarized:
>   - build errors: +3/-7
>   - build warnings: +26/-28
>
> Happy fixing! ;-)
>
> Thanks to the linux-next team for providing the build service.
>
> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/3650b228f83adda7e5ee532e2b90429c03f7b9ec/ (all 192 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/bbf5c979011a099af5dc76498918ed7df445635b/ (all 192 configs)
>
>
> *** ERRORS ***
>
> 3 error regressions:
>   + /kisskb/src/arch/um/kernel/skas/clone.c: error: expected declaration specifiers or '...' before string constant:  => 24:16

um-all{mod,yes}config

>   + error: hotplug-memory.c: undefined reference to `of_drconf_to_nid_single':  => .text+0x5e0)

powerpc-gcc5/pseries_le_defconfig+NO_NUMA

>   + {standard input}: Error: inappropriate arguments for opcode 'adc':  => 170

arc-gcc10/axs101_defconfig

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

