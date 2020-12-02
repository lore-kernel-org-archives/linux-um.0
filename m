Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkQlw-0008GK-CS
 for linux-um@lists.infradead.org; Wed, 02 Dec 2020 11:58:13 +0000
Subject: Re: [PATCH 7/7] um: simplify IRQ handling code
References: <20201123195621.275470-1-johannes@sipsolutions.net>
 <20201123205446.6370687fa983.I811873233b8d71fbde9154b84c85b498521e3b12@changeid>
 <36c4780dbcea541307cbcc90b37baaf49f03fc9a.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <f15a495f-5d78-63e2-9547-173d3419d177@kot-begemot.co.uk>
Date: Wed, 2 Dec 2020 11:58:09 +0000
MIME-Version: 1.0
In-Reply-To: <36c4780dbcea541307cbcc90b37baaf49f03fc9a.camel@sipsolutions.net>
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


On 02/12/2020 11:54, Johannes Berg wrote:
> Oh, I found the bug ...
>
>
>>   static int activate_fd(int irq, int fd, enum um_irq_type type, void *dev_id)
>>   {
> [...]
>
>> +	irq_entry->reg[type].irq = irq;
>> +	irq_entry->reg[type].active = true;
>> +	irq_entry->reg[type].events = events;
> Obviously, here we need
>
> 	irq_entry->reg[type].id = dev_id;
>
> :-)

OK. Cool. I am waiting for the respin.

I will look at adding proper "close" handing and getting rid of the free_irqs kludge later.


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

