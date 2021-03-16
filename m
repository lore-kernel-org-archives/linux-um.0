Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lM7b3-000WZH-JH
 for linux-um@lists.infradead.org; Tue, 16 Mar 2021 11:10:47 +0000
Subject: Re: [PATCH] um: implement flush_cache_vmap/flush_cache_vunmap
References: <20210315233804.d3e52f6a3422.I9672eef7dfa7ce6c3de1ccf7ab8d9aad1fa7f3a6@changeid>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <9afbf0af-bd49-b3d2-6f7f-23fe8041ce03@kot-begemot.co.uk>
Date: Tue, 16 Mar 2021 11:10:42 +0000
MIME-Version: 1.0
In-Reply-To: <20210315233804.d3e52f6a3422.I9672eef7dfa7ce6c3de1ccf7ab8d9aad1fa7f3a6@changeid>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>



On 15/03/2021 22:38, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> vmalloc() heavy workloads in UML are extremely slow, due to
> flushing the entire kernel VM space (flush_tlb_kernel_vm())
> on the first segfault.
> 
> Implement flush_cache_vmap() to avoid that, and while at it
> also add flush_cache_vunmap() since it's trivial.
> 
> This speeds up my vmalloc() heavy test of copying files out
> from /sys/kernel/debug/gcov/ by 30x (from 30s to 1s.)
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   arch/um/include/asm/cacheflush.h | 9 +++++++++
>   arch/um/include/asm/tlb.h        | 2 +-
>   2 files changed, 10 insertions(+), 1 deletion(-)
>   create mode 100644 arch/um/include/asm/cacheflush.h
> 
> diff --git a/arch/um/include/asm/cacheflush.h b/arch/um/include/asm/cacheflush.h
> new file mode 100644
> index 000000000000..4c9858cd36ec
> --- /dev/null
> +++ b/arch/um/include/asm/cacheflush.h
> @@ -0,0 +1,9 @@
> +#ifndef __UM_ASM_CACHEFLUSH_H
> +#define __UM_ASM_CACHEFLUSH_H
> +
> +#include <asm/tlbflush.h>
> +#define flush_cache_vmap flush_tlb_kernel_range
> +#define flush_cache_vunmap flush_tlb_kernel_range
> +
> +#include <asm-generic/cacheflush.h>
> +#endif /* __UM_ASM_CACHEFLUSH_H */
> diff --git a/arch/um/include/asm/tlb.h b/arch/um/include/asm/tlb.h
> index ff9c62828962..0422467bda5b 100644
> --- a/arch/um/include/asm/tlb.h
> +++ b/arch/um/include/asm/tlb.h
> @@ -5,7 +5,7 @@
>   #include <linux/mm.h>
>   
>   #include <asm/tlbflush.h>
> -#include <asm-generic/cacheflush.h>
> +#include <asm/cacheflush.h>
>   #include <asm-generic/tlb.h>
>   
>   #endif
> 
Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>
-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

