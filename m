Return-Path: <linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org>
Subject: Re: [PATCH 16/31] m68knommu: use asm-generic/cacheflush.h
References: <20200510075510.987823-1-hch@lst.de>
 <20200510075510.987823-17-hch@lst.de>
From: Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <fb98853b-c02a-a682-443e-2ae62d0502d9@linux-m68k.org>
Date: Wed, 13 May 2020 00:44:59 +1000
MIME-Version: 1.0
In-Reply-To: <20200510075510.987823-17-hch@lst.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org
To: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Roman Zippel <zippel@linux-m68k.org>
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, Jessica Yu <jeyu@kernel.org>, linux-ia64@vger.kernel.org, linux-c6x-dev@linux-c6x.org, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, x86@kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-ID: <linux-um.lists.infradead.org>

Hi Christoph,

On 10/5/20 5:54 pm, Christoph Hellwig wrote:
> m68knommu needs almost no cache flushing routines of its own.  Rely on
> asm-generic/cacheflush.h for the defaults.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Regards
Greg


> ---
>   arch/m68k/include/asm/cacheflush_no.h | 19 ++-----------------
>   1 file changed, 2 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/m68k/include/asm/cacheflush_no.h b/arch/m68k/include/asm/cacheflush_no.h
> index 11e9a9dcbfb24..2731f07e7be8c 100644
> --- a/arch/m68k/include/asm/cacheflush_no.h
> +++ b/arch/m68k/include/asm/cacheflush_no.h
> @@ -9,25 +9,8 @@
>   #include <asm/mcfsim.h>
>   
>   #define flush_cache_all()			__flush_cache_all()
> -#define flush_cache_mm(mm)			do { } while (0)
> -#define flush_cache_dup_mm(mm)			do { } while (0)
> -#define flush_cache_range(vma, start, end)	do { } while (0)
> -#define flush_cache_page(vma, vmaddr)		do { } while (0)
>   #define flush_dcache_range(start, len)		__flush_dcache_all()
> -#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
> -#define flush_dcache_page(page)			do { } while (0)
> -#define flush_dcache_mmap_lock(mapping)		do { } while (0)
> -#define flush_dcache_mmap_unlock(mapping)	do { } while (0)
>   #define flush_icache_range(start, len)		__flush_icache_all()
> -#define flush_icache_page(vma,pg)		do { } while (0)
> -#define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
> -#define flush_cache_vmap(start, end)		do { } while (0)
> -#define flush_cache_vunmap(start, end)		do { } while (0)
> -
> -#define copy_to_user_page(vma, page, vaddr, dst, src, len) \
> -	memcpy(dst, src, len)
> -#define copy_from_user_page(vma, page, vaddr, dst, src, len) \
> -	memcpy(dst, src, len)
>   
>   void mcf_cache_push(void);
>   
> @@ -98,4 +81,6 @@ static inline void cache_clear(unsigned long paddr, int len)
>   	__clear_cache_all();
>   }
>   
> +#include <asm-generic/cacheflush.h>
> +
>   #endif /* _M68KNOMMU_CACHEFLUSH_H */
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

