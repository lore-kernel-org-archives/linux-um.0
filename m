Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkStM-0002lS-4n
 for linux-um@lists.infradead.org; Wed, 02 Dec 2020 14:14:05 +0000
Subject: Re: [PATCH v2 3/7] um: clean up alarm IRQ chip name
References: <20201202115956.42963-1-johannes@sipsolutions.net>
 <20201202125915.db46a482942e.I782d052498e91373788c1650029d3571a26e4bdf@changeid>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <afe8a32d-6b1a-f4a5-cdd5-957687a86532@cambridgegreys.com>
Date: Wed, 2 Dec 2020 14:13:57 +0000
MIME-Version: 1.0
In-Reply-To: <20201202125915.db46a482942e.I782d052498e91373788c1650029d3571a26e4bdf@changeid>
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



On 02/12/2020 11:59, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> We don't use "SIGVTALRM", it's just SIGALRM. Clean up the naming.
> While at it, fix the comment's grammar.
> 
> Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   arch/um/kernel/irq.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
> index b94c72f56617..97ff77c297c8 100644
> --- a/arch/um/kernel/irq.c
> +++ b/arch/um/kernel/irq.c
> @@ -481,7 +481,7 @@ static void dummy(struct irq_data *d)
>   {
>   }
>   
> -/* This is used for everything else than the timer. */
> +/* This is used for everything other than the timer. */
>   static struct irq_chip normal_irq_type = {
>   	.name = "SIGIO",
>   	.irq_disable = dummy,
> @@ -491,8 +491,8 @@ static struct irq_chip normal_irq_type = {
>   	.irq_unmask = dummy,
>   };
>   
> -static struct irq_chip SIGVTALRM_irq_type = {
> -	.name = "SIGVTALRM",
> +static struct irq_chip alarm_irq_type = {
> +	.name = "SIGALRM",
>   	.irq_disable = dummy,
>   	.irq_enable = dummy,
>   	.irq_ack = dummy,
> @@ -504,8 +504,7 @@ void __init init_IRQ(void)
>   {
>   	int i;
>   
> -	irq_set_chip_and_handler(TIMER_IRQ, &SIGVTALRM_irq_type, handle_edge_irq);
> -
> +	irq_set_chip_and_handler(TIMER_IRQ, &alarm_irq_type, handle_edge_irq);
>   
>   	for (i = 1; i < NR_IRQS; i++)
>   		irq_set_chip_and_handler(i, &normal_irq_type, handle_edge_irq);
> 

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

