Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h46cQ-00039r-Pq
 for linux-um@lists.infradead.org; Wed, 13 Mar 2019 16:20:40 +0000
Subject: Re: [PATCH] um: define set_pte_at() as a static inline function, not
 a macro
References: <20190313101439.7092-1-brgl@bgdev.pl>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <ba8a9e10-cd10-c847-af2b-c41f31cf5f30@cambridgegreys.com>
Date: Wed, 13 Mar 2019 16:20:32 +0000
MIME-Version: 1.0
In-Reply-To: <20190313101439.7092-1-brgl@bgdev.pl>
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
To: Bartosz Golaszewski <brgl@bgdev.pl>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org



On 13/03/2019 10:14, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> When defined as macro, the mm argument is unused and subsequently the
> variable passed as mm is considered unused by the compiler. This fixes
> a build warning.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   arch/um/include/asm/pgtable.h | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
> index 9c04562310b3..b377df76cc28 100644
> --- a/arch/um/include/asm/pgtable.h
> +++ b/arch/um/include/asm/pgtable.h
> @@ -263,7 +263,12 @@ static inline void set_pte(pte_t *pteptr, pte_t pteval)
>   	*pteptr = pte_mknewpage(*pteptr);
>   	if(pte_present(*pteptr)) *pteptr = pte_mknewprot(*pteptr);
>   }
> -#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
> +
> +static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> +			      pte_t *pteptr, pte_t pteval)
> +{
> +	set_pte(pteptr, pteval);
> +}
>   
>   #define __HAVE_ARCH_PTE_SAME
>   static inline int pte_same(pte_t pte_a, pte_t pte_b)
> 
Reviewed-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

