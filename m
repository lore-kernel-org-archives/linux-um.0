MIME-Version: 1.0
Date: Tue, 23 Feb 2021 16:44:06 +0100
References: <20210223152707.408995-1-johannes@sipsolutions.net>
	<20210223161449.5fbbdace8fea.I7b2fad8378e4fde7f26ef06a03980ae2807d81c9@changeid>
In-Reply-To: <20210223161449.5fbbdace8fea.I7b2fad8378e4fde7f26ef06a03980ae2807d81c9@changeid>
Message-ID: <CAMuHMdUU40kv6SncuCYGjattnEWR2k7FG2NS+6ffY6K+D1qsiQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] um: allow disabling NO_IOMEM
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um <linux-um@lists.infradead.org>, Arnd Bergmann <arnd@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Johannes Berg <johannes.berg@intel.com>
List-ID: <linux-um.lists.infradead.org>

Hi Johannes,

On Tue, Feb 23, 2021 at 4:27 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> Adjust the kconfig a little to allow disabling NO_IOMEM in UML. To
> make an "allyesconfig" with CONFIG_NO_IOMEM=n build, adjust a few
> Kconfig things elsewhere and add dummy asm/fb.h and asm/vga.h files.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Thanks for your patch!

> --- /dev/null
> +++ b/arch/um/include/asm/fb.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_UM_FB_H
> +#define _ASM_UM_FB_H
> +
> +static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
> +                                unsigned long off)
> +{
> +}
> +
> +static inline int fb_is_primary_device(struct fb_info *info)
> +{
> +       return 0;
> +}
> +
> +#endif /* _ASM_UM_FB_H */
> diff --git a/arch/um/include/asm/vga.h b/arch/um/include/asm/vga.h
> new file mode 100644
> index 000000000000..0b0e73ccdb28
> --- /dev/null
> +++ b/arch/um/include/asm/vga.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_UM_VGA_H
> +#define _ASM_UM_VGA_H
> +
> +#define VGA_MAP_MEM(x, s)      ((unsigned long) ioremap(x, s))
> +#define vga_readb(a)           readb((u8 __iomem *)(a))
> +#define vga_writeb(v,a)                writeb(v, (u8 __iomem *)(a))
> +
> +#endif /* _ASM_UM_VGA_H */

Can't you just use the asm-generic versions instead?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

