Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkSu7-00030s-5f
 for linux-um@lists.infradead.org; Wed, 02 Dec 2020 14:14:48 +0000
Subject: Re: [PATCH v2 5/7] um: irq: reduce irq_reg allocation
References: <20201202115956.42963-1-johannes@sipsolutions.net>
 <20201202125915.069ecd8bffe6.I3351860a05d7ec403e2abc5337660c9d9726f095@changeid>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <25e4d878-05d1-663e-40cf-24bcca163564@kot-begemot.co.uk>
Date: Wed, 2 Dec 2020 14:14:43 +0000
MIME-Version: 1.0
In-Reply-To: <20201202125915.069ecd8bffe6.I3351860a05d7ec403e2abc5337660c9d9726f095@changeid>
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
> We don't need an array of 4 entries to capture three and the
> name 'MAX_IRQ_TYPE' really gets confusing as well. Remove it
> and add a correct NUM_IRQ_TYPES, and use that correctly.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   arch/um/include/shared/irq_user.h |  2 +-
>   arch/um/kernel/irq.c              | 12 ++++++------
>   2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/um/include/shared/irq_user.h b/arch/um/include/shared/irq_user.h
> index 2dd5fd7d9443..5e975a9e8354 100644
> --- a/arch/um/include/shared/irq_user.h
> +++ b/arch/um/include/shared/irq_user.h
> @@ -12,7 +12,7 @@
>   #define IRQ_READ  0
>   #define IRQ_WRITE 1
>   #define IRQ_NONE 2
> -#define MAX_IRQ_TYPE (IRQ_NONE + 1)
> +#define NUM_IRQ_TYPES (IRQ_NONE + 1)
>   
>   struct siginfo;
>   extern void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs);
> diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
> index 923a80c9808a..93eb742ecafe 100644
> --- a/arch/um/kernel/irq.c
> +++ b/arch/um/kernel/irq.c
> @@ -43,7 +43,7 @@ struct irq_reg {
>   struct irq_entry {
>   	struct irq_entry *next;
>   	int fd;
> -	struct irq_reg *irq_array[MAX_IRQ_TYPE + 1];
> +	struct irq_reg *irq_array[NUM_IRQ_TYPES];
>   };
>   
>   static struct irq_entry *active_fds;
> @@ -101,7 +101,7 @@ void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
>   			 */
>   			irq_entry = (struct irq_entry *)
>   				os_epoll_get_data_pointer(i);
> -			for (j = 0; j < MAX_IRQ_TYPE ; j++) {
> +			for (j = 0; j < NUM_IRQ_TYPES ; j++) {
>   				irq = irq_entry->irq_array[j];
>   				if (irq == NULL)
>   					continue;
> @@ -124,7 +124,7 @@ static int assign_epoll_events_to_irq(struct irq_entry *irq_entry)
>   	int events = 0;
>   	struct irq_reg *irq;
>   
> -	for (i = 0; i < MAX_IRQ_TYPE ; i++) {
> +	for (i = 0; i < NUM_IRQ_TYPES ; i++) {
>   		irq = irq_entry->irq_array[i];
>   		if (irq != NULL)
>   			events = irq->events | events;
> @@ -172,7 +172,7 @@ static int activate_fd(int irq, int fd, int type, void *dev_id)
>   			goto out_unlock;
>   		}
>   		irq_entry->fd = fd;
> -		for (i = 0; i < MAX_IRQ_TYPE; i++)
> +		for (i = 0; i < NUM_IRQ_TYPES; i++)
>   			irq_entry->irq_array[i] = NULL;
>   		irq_entry->next = active_fds;
>   		active_fds = irq_entry;
> @@ -244,7 +244,7 @@ static void garbage_collect_irq_entries(void)
>   	walk = active_fds;
>   	while (walk != NULL) {
>   		reap = true;
> -		for (i = 0; i < MAX_IRQ_TYPE ; i++) {
> +		for (i = 0; i < NUM_IRQ_TYPES ; i++) {
>   			if (walk->irq_array[i] != NULL) {
>   				reap = false;
>   				break;
> @@ -301,7 +301,7 @@ static void do_free_by_irq_and_dev(
>   	int i;
>   	struct irq_reg *to_free;
>   
> -	for (i = 0; i < MAX_IRQ_TYPE ; i++) {
> +	for (i = 0; i < NUM_IRQ_TYPES ; i++) {
>   		if (irq_entry->irq_array[i] != NULL) {
>   			if (
>   			((flags & IGNORE_IRQ) ||
> 

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

