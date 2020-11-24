Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khbmo-0005MA-9V
 for linux-um@lists.infradead.org; Tue, 24 Nov 2020 17:07:32 +0000
Subject: Re: [PATCH 0/7 um: IRQ handling cleanups
References: <20201123195621.275470-1-johannes@sipsolutions.net>
 <3812c8af-edc1-a2ff-96e5-0ad96e85411b@kot-begemot.co.uk>
 <d7b1ec1bbb6995e801c3e7c54c7bb88dcffc54db.camel@sipsolutions.net>
 <293beb66b8293056a1a34ca1bc3b78900bb4d638.camel@sipsolutions.net>
 <cdf91602-b6d8-3347-4d02-747b87fac4b3@kot-begemot.co.uk>
 <61a9da79-da79-d779-78be-af30f88b6f05@kot-begemot.co.uk>
 <425d0c637bff893c89ee9374e6f741bbace89f27.camel@sipsolutions.net>
 <9f8f7c56-5c63-8281-4766-3821cbe6f6a7@kot-begemot.co.uk>
 <ebcb1d02478af06d0bb368a338b63752fe6c1d68.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <b7a40102-fbc3-308a-fc55-332e6696b1b3@kot-begemot.co.uk>
Date: Tue, 24 Nov 2020 17:07:21 +0000
MIME-Version: 1.0
In-Reply-To: <ebcb1d02478af06d0bb368a338b63752fe6c1d68.camel@sipsolutions.net>
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



On 24/11/2020 16:46, Johannes Berg wrote:
> On Tue, 2020-11-24 at 16:45 +0000, Anton Ivanov wrote:
>>
>>>> That is where ->purge was coming from.
>>> I have no idea what ->purge is? :)
>>
>> One of the flags on the IRQ info structure.
>>
>> You killed that in c0b17c371b43bddcd2fbfe643ce6a6c84347c013 "simplify IRQ handling code"
> 
> And didn't even remember, oops. I'll check.
> 
> johannes
> 
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 

Looks like chan_kern.c handles it now. It schedules delayed work itself instead of trying to kill the IRQ out of IRQ context.

So the ->purge in irq.c and everything dealing with it should not be necessary any more.

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

