Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khbOi-00044P-Qb
 for linux-um@lists.infradead.org; Tue, 24 Nov 2020 16:42:33 +0000
Subject: Re: [PATCH 0/7 um: IRQ handling cleanups
References: <20201123195621.275470-1-johannes@sipsolutions.net>
 <3812c8af-edc1-a2ff-96e5-0ad96e85411b@kot-begemot.co.uk>
 <d7b1ec1bbb6995e801c3e7c54c7bb88dcffc54db.camel@sipsolutions.net>
 <293beb66b8293056a1a34ca1bc3b78900bb4d638.camel@sipsolutions.net>
 <cdf91602-b6d8-3347-4d02-747b87fac4b3@kot-begemot.co.uk>
 <61a9da79-da79-d779-78be-af30f88b6f05@kot-begemot.co.uk>
 <425d0c637bff893c89ee9374e6f741bbace89f27.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <25d38c35-c5f9-e0be-fd6d-3a77025e5dbb@kot-begemot.co.uk>
Date: Tue, 24 Nov 2020 16:42:29 +0000
MIME-Version: 1.0
In-Reply-To: <425d0c637bff893c89ee9374e6f741bbace89f27.camel@sipsolutions.net>
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



On 24/11/2020 16:39, Johannes Berg wrote:
> On Tue, 2020-11-24 at 16:34 +0000, Anton Ivanov wrote:
>> On 24/11/2020 09:06, Anton Ivanov wrote:
>>>
>>> On 24/11/2020 08:58, Johannes Berg wrote:
>>>> On Tue, 2020-11-24 at 09:55 +0100, Johannes Berg wrote:
>>>>>> I have tried some of what you did when working on timers/epoll -
>>>>>> namely turning off the HZ-like nanosleep in time.c. I could not get it
>>>>>> to work at the time. So I dropped it from the final version of the
>>>>>> patches.
>>>>>
>>>>> That one's just weird ... and unnecessary. I can't see why it could
>>>>> possibly matter.
>>>>
>>>> Or actually ... wait? I thought you were referring to "um: simplify
>>>> os_idle_sleep() and sleep longer" but that's not in this set now...
>>>>
>>>> Anyway, if you were indeed referring to that patch, it's not strictly
>>>> needed - removing it would just mean I couldn't call os_idle_sleep() for
>>>> suspend but would have to add os_suspend() or something. OTOH, it didn't
>>>> break anything for me (neither time-travel nor normal mode), and I can't
>>>> see how it was necessary since if clock_nanosleep() (or now select())
>>>> was interrupted by a signal and returned, the signal handler ran too...
>>>
>>> The early version of the timer patches were fairly fragile.
>>>
>>> There is quite a bit of belt-n-braces leftovers from that, it will be good to clean it up.
>>
>> I need to double-check the IRQ delete code. While I made most of it
>> lockless and reentrant, I never finished cleaning all of it at the
>> end.
>>
>> That is where ->purge was coming from.
> 
> I have no idea what ->purge is? :)
> 
>> There were a couple of places in the serial code which could (and did)
>> try to delete an IRQ out of the IRQ handler. I am not sure that is
>> still the case as that also got rewritten to implement write IRQs
>> instead of IRQ_NONE.
> 
> Hmm. OK, but nothing used IRQ_NONE?

Not any more. All of the serial code used it till recently for write :)

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

