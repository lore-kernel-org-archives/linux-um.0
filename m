Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjjPT-000546-Rj
 for linux-um@lists.infradead.org; Mon, 30 Nov 2020 13:40:08 +0000
Subject: Re: [PATCH 7/7] um: simplify IRQ handling code
References: <20201123195621.275470-1-johannes@sipsolutions.net>
 <20201123205446.6370687fa983.I811873233b8d71fbde9154b84c85b498521e3b12@changeid>
 <9cc47f08-2ca2-d4df-d0b0-09552a9a209b@kot-begemot.co.uk>
 <d60986af3d7065c2a0f9052083e4526b5f64aada.camel@sipsolutions.net>
 <41545b47-bf98-f520-c832-4cbe4145b745@kot-begemot.co.uk>
 <0eb098cf6a82e6656e2179a0f43cc014d437e271.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <351b7dfe-73e0-a7b5-1b99-b09e5297f62b@kot-begemot.co.uk>
Date: Mon, 30 Nov 2020 13:40:02 +0000
MIME-Version: 1.0
In-Reply-To: <0eb098cf6a82e6656e2179a0f43cc014d437e271.camel@sipsolutions.net>
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


On 30/11/2020 12:00, Johannes Berg wrote:
> Sorry, looks like I forgot to reply to this earlier.
>
> On Tue, 2020-11-24 at 22:36 +0000, Anton Ivanov wrote:
>
>>>>> @@ -151,73 +171,33 @@ static int activate_fd(int irq, int fd, enum um_irq_type type, void *dev_id)
>>>>>     		goto out;
>>>>>     
>>>>>     	spin_lock_irqsave(&irq_lock, flags);
>>>>> -
>>>>> -	/* Check if we have an entry for this fd */
>>>>> -
>>>>> -	err = -EBUSY;
>>>>> -	for (irq_entry = active_fds;
>>>>> -		irq_entry != NULL; irq_entry = irq_entry->next) {
>>>>> -		if (irq_entry->fd == fd)
>>>>> -			break;
>>>>> -	}
>>>>> -
>>>>> -	if (irq_entry == NULL) {
>>>>> -		/* This needs to be atomic as it may be called from an
>>>>> -		 * IRQ context.
>>>>> -		 */
>>>>> -		irq_entry = kmalloc(sizeof(struct irq_entry), GFP_ATOMIC);
>>>>> -		if (irq_entry == NULL) {
>>>>> -			printk(KERN_ERR
>>>>> -				"Failed to allocate new IRQ entry\n");
>>>>> +	irq_entry = get_irq_entry_by_fd(fd);
>>>>> +	if (irq_entry) {
>>>> This is not right.
>>>>
>>>> You can re-register the same IRQ/fd, but with a different mask - f.e.
>>>> turn on/off write or read on the same fd. F.E. - you have registered a
>>>> read IRQ, you after that register same IRQ for write and you can alter
>>>> the mask.
>>> Hmm. You snipped some code, and it continued like this:
>>>
>>>           irq_entry = get_irq_entry_by_fd(fd);
>>>           if (irq_entry) {
>>>                   /* cannot register the same FD twice with the same type */
>>>                   if (WARN_ON(irq_entry->reg[type].events)) {
>>>                           // basically return -EALREADY
>>>
>>>
>>> I'm not sure I see this is different from what it was before? If the
>> The original intention was to be able to do it :)
> To do _what_ exactly? You said to re-register the same FD, but you could
> do that before by unregistering?

I need to remember what I though in 2011 when I wrote the first version :)

>
> And read/write are completely separate entries anyway. You cannot do
> both at the same time (they're not bitmasks, just enum values.)

Yeah, we reached that point over time anyway. I forgot exactly why I dropped the idea of sharing read and write IRQs, but I dropped it :)

>
> In fact, you *can* still use the same FD for both, with and without this
> patch. We find the irq_entry here (by FD), and then check if this type
> of event is already used. That means you cannot register for READ for
> the same FD twice, but using the other event (WRITE) is still fine.

I am going through the patchset. As I said - we ended up with a design where the original idea was dropped. Probably it was dropped for good too. It was making things overly complicated.

If it is dropped for good and not used anywhere, we might as well simplify the code.


Brgds,

>
> johannes
>
>
-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

