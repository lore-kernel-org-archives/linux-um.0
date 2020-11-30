Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjjjl-00014t-IP
 for linux-um@lists.infradead.org; Mon, 30 Nov 2020 14:01:06 +0000
Subject: Re: [PATCH 4/7] um: irq: clean up and rename struct irq_fd
References: <20201123195621.275470-1-johannes@sipsolutions.net>
 <20201123205446.f81b278d54b0.I24e33736cb579395f3005b9500b0b8c111983b03@changeid>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <105e39eb-3f4b-0201-e48e-43dca5536a05@kot-begemot.co.uk>
Date: Mon, 30 Nov 2020 14:01:01 +0000
MIME-Version: 1.0
In-Reply-To: <20201123205446.f81b278d54b0.I24e33736cb579395f3005b9500b0b8c111983b03@changeid>
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



On 23/11/2020 19:56, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> This really shouldn't be called "irq_fd" since it doesn't
> carry an fd. Well, it used to, apparently, but that struct
> member is unused.
> 
> Rename it to "irq_reg" since it more accurately reflects a
> registered interrupt, and remove the unused 'next' and 'fd'
> members from the struct as well.
> 
> While at it, also move it to the implementation, it's not
> used anywhere else, and the header file is shared with the
> userspace components.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   arch/um/include/shared/irq_user.h | 14 -------------
>   arch/um/kernel/irq.c              | 34 ++++++++++++++++++++-----------
>   2 files changed, 22 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/um/include/shared/irq_user.h b/arch/um/include/shared/irq_user.h
> index 107751dce153..2dd5fd7d9443 100644
> --- a/arch/um/include/shared/irq_user.h
> +++ b/arch/um/include/shared/irq_user.h
> @@ -9,25 +9,11 @@
>   #include <sysdep/ptrace.h>
>   #include <stdbool.h>
>   
> -struct irq_fd {
> -	struct irq_fd *next;
> -	void *id;
> -	int fd;
> -	int type;
> -	int irq;
> -	int events;
> -	bool active;
> -	bool pending;
> -	bool purge;
> -};
> -
>   #define IRQ_READ  0
>   #define IRQ_WRITE 1
>   #define IRQ_NONE 2
>   #define MAX_IRQ_TYPE (IRQ_NONE + 1)
>   
> -
> -
>   struct siginfo;
>   extern void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs);
>   extern void free_irq_by_fd(int fd);
> diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
> index 97ff77c297c8..923a80c9808a 100644
> --- a/arch/um/kernel/irq.c
> +++ b/arch/um/kernel/irq.c
> @@ -26,14 +26,24 @@ extern void free_irqs(void);
>   
>   /* When epoll triggers we do not know why it did so
>    * we can also have different IRQs for read and write.
> - * This is why we keep a small irq_fd array for each fd -
> + * This is why we keep a small irq_reg array for each fd -
>    * one entry per IRQ type
>    */
>   
> +struct irq_reg {
> +	void *id;
> +	int type;
> +	int irq;
> +	int events;
> +	bool active;
> +	bool pending;
> +	bool purge;
> +};
> +
>   struct irq_entry {
>   	struct irq_entry *next;
>   	int fd;
> -	struct irq_fd *irq_array[MAX_IRQ_TYPE + 1];
> +	struct irq_reg *irq_array[MAX_IRQ_TYPE + 1];
>   };
>   
>   static struct irq_entry *active_fds;
> @@ -41,7 +51,7 @@ static struct irq_entry *active_fds;
>   static DEFINE_SPINLOCK(irq_lock);
>   static DECLARE_BITMAP(irqs_allocated, NR_IRQS);
>   
> -static void irq_io_loop(struct irq_fd *irq, struct uml_pt_regs *regs)
> +static void irq_io_loop(struct irq_reg *irq, struct uml_pt_regs *regs)
>   {
>   /*
>    * irq->active guards against reentry
> @@ -65,7 +75,7 @@ static void irq_io_loop(struct irq_fd *irq, struct uml_pt_regs *regs)
>   void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
>   {
>   	struct irq_entry *irq_entry;
> -	struct irq_fd *irq;
> +	struct irq_reg *irq;
>   
>   	int n, i, j;
>   
> @@ -86,7 +96,7 @@ void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
>   		}
>   
>   		for (i = 0; i < n ; i++) {
> -			/* Epoll back reference is the entry with 3 irq_fd
> +			/* Epoll back reference is the entry with 3 irq_reg
>   			 * leaves - one for each irq type.
>   			 */
>   			irq_entry = (struct irq_entry *)
> @@ -112,7 +122,7 @@ static int assign_epoll_events_to_irq(struct irq_entry *irq_entry)
>   {
>   	int i;
>   	int events = 0;
> -	struct irq_fd *irq;
> +	struct irq_reg *irq;
>   
>   	for (i = 0; i < MAX_IRQ_TYPE ; i++) {
>   		irq = irq_entry->irq_array[i];
> @@ -131,7 +141,7 @@ static int assign_epoll_events_to_irq(struct irq_entry *irq_entry)
>   
>   static int activate_fd(int irq, int fd, int type, void *dev_id)
>   {
> -	struct irq_fd *new_fd;
> +	struct irq_reg *new_fd;
>   	struct irq_entry *irq_entry;
>   	int i, err, events;
>   	unsigned long flags;
> @@ -182,13 +192,13 @@ static int activate_fd(int irq, int fd, int type, void *dev_id)
>   		/* New entry for this fd */
>   
>   		err = -ENOMEM;
> -		new_fd = kmalloc(sizeof(struct irq_fd), GFP_ATOMIC);
> +		new_fd = kmalloc(sizeof(struct irq_reg), GFP_ATOMIC);
>   		if (new_fd == NULL)
>   			goto out_unlock;
>   
>   		events = os_event_mask(type);
>   
> -		*new_fd = ((struct irq_fd) {
> +		*new_fd = ((struct irq_reg) {
>   			.id		= dev_id,
>   			.irq		= irq,
>   			.type		= type,
> @@ -273,8 +283,8 @@ static struct irq_entry *get_irq_entry_by_fd(int fd)
>   
>   /*
>    * Walk the IRQ list and dispose of an entry for a specific
> - * device, fd and number. Note - if sharing an IRQ for read
> - * and writefor the same FD it will be disposed in either case.
> + * device and number. Note - if sharing an IRQ for read
> + * and write for the same FD it will be disposed in either case.
>    * If this behaviour is undesirable use different IRQ ids.
>    */
>   
> @@ -289,7 +299,7 @@ static void do_free_by_irq_and_dev(
>   )
>   {
>   	int i;
> -	struct irq_fd *to_free;
> +	struct irq_reg *to_free;
>   
>   	for (i = 0; i < MAX_IRQ_TYPE ; i++) {
>   		if (irq_entry->irq_array[i] != NULL) {
> 

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

