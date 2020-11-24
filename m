Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khgvI-0001PG-Jl
 for linux-um@lists.infradead.org; Tue, 24 Nov 2020 22:36:33 +0000
Subject: Re: [PATCH 7/7] um: simplify IRQ handling code
References: <20201123195621.275470-1-johannes@sipsolutions.net>
 <20201123205446.6370687fa983.I811873233b8d71fbde9154b84c85b498521e3b12@changeid>
 <9cc47f08-2ca2-d4df-d0b0-09552a9a209b@kot-begemot.co.uk>
 <d60986af3d7065c2a0f9052083e4526b5f64aada.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <41545b47-bf98-f520-c832-4cbe4145b745@kot-begemot.co.uk>
Date: Tue, 24 Nov 2020 22:36:28 +0000
MIME-Version: 1.0
In-Reply-To: <d60986af3d7065c2a0f9052083e4526b5f64aada.camel@sipsolutions.net>
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

On 24/11/2020 21:58, Johannes Berg wrote:
> On Tue, 2020-11-24 at 21:50 +0000, Anton Ivanov wrote:
>>
>>>    static int activate_fd(int irq, int fd, enum um_irq_type type, void *dev_id)
>>>    {
>>> -	struct irq_reg *new_fd;
>>>    	struct irq_entry *irq_entry;
>>> -	int i, err, events;
>>> +	int err, events = os_event_mask(type);
>>>    	unsigned long flags;
>>>    
>>>    	err = os_set_fd_async(fd);
>>> @@ -151,73 +171,33 @@ static int activate_fd(int irq, int fd, enum um_irq_type type, void *dev_id)
>>>    		goto out;
>>>    
>>>    	spin_lock_irqsave(&irq_lock, flags);
>>> -
>>> -	/* Check if we have an entry for this fd */
>>> -
>>> -	err = -EBUSY;
>>> -	for (irq_entry = active_fds;
>>> -		irq_entry != NULL; irq_entry = irq_entry->next) {
>>> -		if (irq_entry->fd == fd)
>>> -			break;
>>> -	}
>>> -
>>> -	if (irq_entry == NULL) {
>>> -		/* This needs to be atomic as it may be called from an
>>> -		 * IRQ context.
>>> -		 */
>>> -		irq_entry = kmalloc(sizeof(struct irq_entry), GFP_ATOMIC);
>>> -		if (irq_entry == NULL) {
>>> -			printk(KERN_ERR
>>> -				"Failed to allocate new IRQ entry\n");
>>> +	irq_entry = get_irq_entry_by_fd(fd);
>>> +	if (irq_entry) {
>>
>> This is not right.
>>
>> You can re-register the same IRQ/fd, but with a different mask - f.e.
>> turn on/off write or read on the same fd. F.E. - you have registered a
>> read IRQ, you after that register same IRQ for write and you can alter
>> the mask.
> 
> Hmm. You snipped some code, and it continued like this:
> 
>          irq_entry = get_irq_entry_by_fd(fd);
>          if (irq_entry) {
>                  /* cannot register the same FD twice with the same type */
>                  if (WARN_ON(irq_entry->reg[type].events)) {
>                          // basically return -EALREADY
> 
> 
> I'm not sure I see this is different from what it was before? If the

The original intention was to be able to do it :)

If there is no code to use that and/or if it was not working properly 
anyway we may abandon that for the time being.

A.

> irq_entry was found before (by fd, so that's equivalent to
> get_irq_entry_by_fd(), was just open-coded), then previously it would
> have gone into
> 
> -       if (irq_entry->irq_array[type] != NULL) {
> -               printk(KERN_ERR
> -                       "Trying to reregister IRQ %d FD %d TYPE %d ID %p\n",
> -                       irq, fd, type, dev_id
> -               );
> -               goto out_unlock;
> 
> which was a failure?
> 
> But you meant a *different* type (IRQ_READ vs. IRQ_WRITE), and then in
> my new code we also accept that:
> 
>          irq_entry = get_irq_entry_by_fd(fd);
>          if (irq_entry) {
>                  /* cannot register the same FD twice with the same type */
>                  if (WARN_ON(irq_entry->reg[type].events)) {
>                          err = -EALREADY;
>                          goto out_unlock;
>                  }
> 
>                  /* temporarily disable to avoid IRQ-side locking */
>                  os_del_epoll_fd(fd);
>          } else {
> [...]
>          }
> 
>          irq_entry->reg[type].irq = irq;
>          irq_entry->reg[type].active = true;
>          irq_entry->reg[type].events = events;
> 
> 
> So not sure I see the difference wrt. this?
> 
> 
> You can't really *alter* the mask, even in the old code, you can just
> register a new IRQ (or even the same) for the other type (read/write),
> and then unregister the old type or such.
> 
> Ok ... what am I missing?
> 
> johannes
> 
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 


-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

