Return-Path: <anton.ivanov@cambridgegreys.com>
Subject: Re: [PATCH] um: irq: don't set the chip for all irqs
References: <20190314150344.8555-1-brgl@bgdev.pl>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <ebcc2921-9048-9943-331b-6cc5baee95ea@cambridgegreys.com>
Date: Fri, 15 Mar 2019 08:35:31 +0000
MIME-Version: 1.0
In-Reply-To: <20190314150344.8555-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <brgl@bgdev.pl>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>



On 14/03/2019 15:03, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Setting a chip for an interrupt marks it as allocated. Since UM doesn't
> support dynamic interrupt numbers (yet), it means we cannot simply
> increase NR_IRQS and then use the free irqs between LAST_IRQ and NR_IRQS
> with gpio-mockup or iio testing drivers as irq_alloc_descs() will fail
> after not being able to neither find an unallocated range of interrupts
> nor expand the range.
> 
> Only call irq_set_chip_and_handler() for irqs until LAST_IRQ.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
> Note: I plan to introduce support for SPARSE_IRQ but AFAICT it will be
> a bit more complicated, so in the meantime I'd like to propose this change.
> 
>   arch/um/kernel/irq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
> index f4874b7ec503..598d7b3d9355 100644
> --- a/arch/um/kernel/irq.c
> +++ b/arch/um/kernel/irq.c
> @@ -479,7 +479,7 @@ void __init init_IRQ(void)
>   	irq_set_chip_and_handler(TIMER_IRQ, &SIGVTALRM_irq_type, handle_edge_irq);
>   
>   
> -	for (i = 1; i < NR_IRQS; i++)
> +	for (i = 1; i < LAST_IRQ; i++)
>   		irq_set_chip_and_handler(i, &normal_irq_type, handle_edge_irq);
>   	/* Initialize EPOLL Loop */
>   	os_setup_epoll();
> 

Reviewed-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

