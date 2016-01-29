Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] um: asm/page.h: zero out a pte's high value in
 set_pte_val()
References: <871t91i7gf.fsf@gmail.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <56AAB5ED.7020200@nod.at>
Date: Fri, 29 Jan 2016 01:44:29 +0100
MIME-Version: 1.0
In-Reply-To: <871t91i7gf.fsf@gmail.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@linux-foundation.org>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 29.01.2016 um 00:56 schrieb Nicolai Stange:
> Commit 16da306849d0 ("um: kill pfn_t")
> introduced a compile warning for defconfig:
> 
>   arch/um/kernel/skas/mmu.c:38:206: warning: right shift count >= width of type
>                                     [-Wshift-count-overflow]
> 
> Aforementioned patch changes the definition of the phys_to_pfn() macro from
> 
>   ((pfn_t) ((p) >> PAGE_SHIFT))
> 
> to
> 
>   ((p) >> PAGE_SHIFT)
> 
> This effectively changes the phys_to_pfn() expansion's type from
> unsigned long long to unsigned long.
> 
> Through the callchain init_stub_pte()->mk_pte(), the expansion of
> phys_to_pfn() is (indirectly) fed into the 'phys' argument of the
> pte_set_val(pte, phys, prot) macro, eventually leading to
> 
>   (pte).pte_high = (phys) >> 32;
> 
> This results in the warning from above.
> 
> Since UML only deals with 32 bit addresses, the upper 32 bits from 'phys'
> used to be zero anyway.
> 
> Zero out the pte value's high part in pte_set_val() in order to get rid
> of the offending shift.
> 
> Fixes: 16da306849d0 ("um: kill pfn_t")
> Signed-off-by: Nicolai Stange <nicstange@gmail.com>
> ---
>  arch/um/include/asm/page.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/um/include/asm/page.h b/arch/um/include/asm/page.h
> index e13d41c..61e235f 100644
> --- a/arch/um/include/asm/page.h
> +++ b/arch/um/include/asm/page.h
> @@ -46,8 +46,8 @@ typedef struct { unsigned long pgd; } pgd_t;
>  			      smp_wmb(); \
>  			      (to).pte_low = (from).pte_low; })
>  #define pte_is_zero(pte) (!((pte).pte_low & ~_PAGE_NEWPAGE) && !(pte).pte_high)
> -#define pte_set_val(pte, phys, prot) \
> -	({ (pte).pte_high = (phys) >> 32; \
> +#define pte_set_val(pte, phys, prot)				\
> +	({ (pte).pte_high = 0;					\
>  	   (pte).pte_low = (phys) | pgprot_val(prot); })

I think we can completely kill .pte_high.

Thanks,
//richard

