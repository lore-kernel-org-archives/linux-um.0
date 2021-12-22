Return-Path: <daniel@ffwll.ch>
Date: Wed, 22 Dec 2021 21:56:06 +0100
From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/ttm: fix compilation on ARCH=um
Message-ID: <YcOQ5uMYLuI0/y5v@phenom.ffwll.local>
References: <CAMuHMdXTRYjtfyWTVN86pn4STO2EPR1B5+KHj=wAqguXt=hpHg@mail.gmail.com>
 <20211220111519.a4c8c6eff702.Ie4cf4e68698f6a9f546b83379bc52c266504424f@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220111519.a4c8c6eff702.Ie4cf4e68698f6a9f546b83379bc52c266504424f@changeid>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: dri-devel@lists.freedesktop.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
List-ID: <linux-um.lists.infradead.org>

On Mon, Dec 20, 2021 at 11:15:22AM +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Even if it's probably not really useful, it can get selected
> by e.g. randconfig builds, and then failing to compile is an
> annoyance. Unfortunately, it's hard to fix in Kconfig, since
> DRM_TTM is selected by many things that don't really depend
> on any specific architecture, and just depend on PCI (which
> is indeed now available in ARCH=um via simulation/emulation).
> 
> Fix this in the code instead by just ifdef'ing the relevant
> two lines that depend on "real X86".
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Probably the last thing before I disappear until 2022 :-)

Merged into drm-misc-fixes, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/ttm/ttm_module.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_module.c b/drivers/gpu/drm/ttm/ttm_module.c
> index 0037eefe3239..a3ad7c9736ec 100644
> --- a/drivers/gpu/drm/ttm/ttm_module.c
> +++ b/drivers/gpu/drm/ttm/ttm_module.c
> @@ -68,9 +68,11 @@ pgprot_t ttm_prot_from_caching(enum ttm_caching caching, pgprot_t tmp)
>  #if defined(__i386__) || defined(__x86_64__)
>  	if (caching == ttm_write_combined)
>  		tmp = pgprot_writecombine(tmp);
> +#ifndef CONFIG_UML
>  	else if (boot_cpu_data.x86 > 3)
>  		tmp = pgprot_noncached(tmp);
> -#endif
> +#endif /* CONFIG_UML */
> +#endif /* __i386__ || __x86_64__ */
>  #if defined(__ia64__) || defined(__arm__) || defined(__aarch64__) || \
>  	defined(__powerpc__) || defined(__mips__)
>  	if (caching == ttm_write_combined)
> -- 
> 2.33.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

