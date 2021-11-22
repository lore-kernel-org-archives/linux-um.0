MIME-Version: 1.0
Date: Mon, 22 Nov 2021 14:24:11 +0100
References: <20211122111214.3801534-1-geert@linux-m68k.org>
In-Reply-To: <20211122111214.3801534-1-geert@linux-m68k.org>
Message-ID: <CAMuHMdW7jcoNHyBomcbkkHU-m32uAureeHYj_PhaMC=O2b4wLA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.16-rc2
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
To: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, linux-um@lists.infradead.org, sparclinux@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-um.lists.infradead.org>

On Mon, Nov 22, 2021 at 12:28 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v5.16-rc2[1] compared to v5.15[2].
>
> Summarized:
>   - build errors: +13/-12
>   - build warnings: +3/-26
>
> JFYI, when comparing v5.16-rc2[1] to v5.16-rc1[3], the summaries are:
>   - build errors: +6/-12

  + /kisskb/src/drivers/mtd/nand/raw/mpc5121_nfc.c: error: unused
variable 'mtd' [-Werror=unused-variable]:  => 294:19

ppc32_allmodconfig (patch sent)

  + /kisskb/src/drivers/video/fbdev/nvidia/nvidia.c: error: passing
argument 1 of 'iounmap' discards 'volatile' qualifier from pointer
target type [-Werror=discarded-qualifiers]:  => 1439:10, 1414:10
  + /kisskb/src/drivers/video/fbdev/riva/fbdev.c: error: passing
argument 1 of 'iounmap' discards 'volatile' qualifier from pointer
target type [-Werror=discarded-qualifiers]:  => 2095:11, 2062:11

um-all{mod,yes}config

  + /kisskb/src/fs/netfs/read_helper.c: error: implicit declaration of
function 'flush_dcache_folio' [-Werror=implicit-function-declaration]:
 => 435:4

sparc-allmodconfig
sparc64-allmodconfig

  + /kisskb/src/fs/ntfs/aops.c: error: the frame size of 2192 bytes is
larger than 2048 bytes [-Werror=frame-larger-than=]:  => 1311:1

ppc64le_allmodconfig

  + /kisskb/src/fs/ntfs/aops.c: error: the frame size of 2256 bytes is
larger than 2048 bytes [-Werror=frame-larger-than=]:  => 1311:1

powerpc-allyesconfig

> Thanks to the linux-next team for providing the build service.
>
> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/136057256686de39cc3a07c2e39ef6bc43003ff6/ (all 90 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf/ (all 90 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

