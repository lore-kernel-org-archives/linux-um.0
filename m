Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hsw8d-0001hH-Qt
 for linux-um@lists.infradead.org; Wed, 31 Jul 2019 21:28:01 +0000
Subject: Re: [PATCH 1/2] um: irq: Fix LAST_IRQ usage
References: <20190731202942.29630-1-johannes@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <438c824c-a5bb-b639-4f17-abb827d03b37@cambridgegreys.com>
Date: Wed, 31 Jul 2019 21:46:27 +0100
MIME-Version: 1.0
In-Reply-To: <20190731202942.29630-1-johannes@sipsolutions.net>
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
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Erel Geron <erelx.geron@intel.com>



On 31/07/2019 21:29, Johannes Berg wrote:
> From: Erel Geron <erelx.geron@intel.com>
> 
> LAST_IRQ was used incorrectly in init_IRQ.
> Fix this.
> 
> Signed-off-by: Erel Geron <erelx.geron@intel.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> Anton submitted a very similar patch, but didn't update init_IRQ(),
> which seems necessary.
> ---
>   arch/um/include/asm/irq.h | 2 +-
>   arch/um/kernel/irq.c      | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/um/include/asm/irq.h b/arch/um/include/asm/irq.h
> index 49ed3e35b35a..ce7a78c3bcf2 100644
> --- a/arch/um/include/asm/irq.h
> +++ b/arch/um/include/asm/irq.h
> @@ -23,7 +23,7 @@
>   #define VECTOR_BASE_IRQ		15
>   #define VECTOR_IRQ_SPACE	8
>   
> -#define LAST_IRQ (VECTOR_IRQ_SPACE + VECTOR_BASE_IRQ)
> +#define LAST_IRQ (VECTOR_IRQ_SPACE + VECTOR_BASE_IRQ - 1)
>   
>   #else
>   
> diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
> index efde1f16c603..402e59bdb65b 100644
> --- a/arch/um/kernel/irq.c
> +++ b/arch/um/kernel/irq.c
> @@ -480,7 +480,7 @@ void __init init_IRQ(void)
>   	irq_set_chip_and_handler(TIMER_IRQ, &SIGVTALRM_irq_type, handle_edge_irq);
>   
>   
> -	for (i = 1; i < LAST_IRQ; i++)
> +	for (i = 1; i <= LAST_IRQ; i++)
>   		irq_set_chip_and_handler(i, &normal_irq_type, handle_edge_irq);
>   	/* Initialize EPOLL Loop */
>   	os_setup_epoll();
> 

Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.co.uk>

-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

