Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i2U2N-0005YN-W0
 for linux-um@lists.infradead.org; Tue, 27 Aug 2019 05:29:01 +0000
Subject: Re: [PATCH 3/4] arch: um: remove misleading #define ARCh_IRQ_ENABLED
References: <20190823104429.11047-1-johannes@sipsolutions.net>
 <20190823104429.11047-3-johannes@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <20658329-a148-40de-66d1-d820f905b8fd@kot-begemot.co.uk>
Date: Tue, 27 Aug 2019 06:28:54 +0100
MIME-Version: 1.0
In-Reply-To: <20190823104429.11047-3-johannes@sipsolutions.net>
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



On 23/08/2019 11:44, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Due to the typo in the name, this can never be used, but
> it's also misleading because our value for enabled/disabled
> is always just 0/1, not an actual signal mask.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   arch/um/include/asm/irqflags.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/um/include/asm/irqflags.h b/arch/um/include/asm/irqflags.h
> index cbc6c0013a64..0642ad9035d1 100644
> --- a/arch/um/include/asm/irqflags.h
> +++ b/arch/um/include/asm/irqflags.h
> @@ -32,7 +32,6 @@ static inline void arch_local_irq_disable(void)
>   }
>   
>   #define ARCH_IRQ_DISABLED	0
> -#define ARCh_IRQ_ENABLED	(SIGIO|SIGVTALRM)
>   
>   #include <asm-generic/irqflags.h>
>   
> 

Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.co.uk>


-- 
Anton R Ivanov

http://www.kot-begemot.co.uk

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

