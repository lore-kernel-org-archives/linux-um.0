Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iAWBJ-0002LH-1m
 for linux-um@lists.infradead.org; Wed, 18 Sep 2019 09:23:26 +0000
Subject: Re: CONFIG_COMPAT for UM?
References: <60f73376da11640d5b335512f052a583fd784fd8.camel@sipsolutions.net>
 <76d688c3-3d8b-fb59-3ad4-ef8dd9c023be@kot-begemot.co.uk>
 <b3507d24-ebd9-8e7f-25a8-61c1891c37d4@kot-begemot.co.uk>
 <5dad6c3e76e474b9f43df99ea235eb77389ce63f.camel@sipsolutions.net>
 <bd6edd3b-f0e3-c3e8-1b2a-e1395dcaf6aa@kot-begemot.co.uk>
 <06bdd645f5f9832ec37e6e50e12602fa6661cca9.camel@sipsolutions.net>
 <5dd98ebf-7da7-ec81-ef65-709c009670a2@kot-begemot.co.uk>
 <1e6bd82c6454bd13972d68a2af74779e08462c30.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <76e045b9-b7f2-6e27-cf79-50f2bcbb3c29@kot-begemot.co.uk>
Date: Wed, 18 Sep 2019 10:23:20 +0100
MIME-Version: 1.0
In-Reply-To: <1e6bd82c6454bd13972d68a2af74779e08462c30.camel@sipsolutions.net>
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



On 18/09/2019 09:47, Johannes Berg wrote:
> On Wed, 2019-09-18 at 09:32 +0100, Anton Ivanov wrote:
>> On 18/09/2019 09:25, Johannes Berg wrote:
>>>>> Yeah, I guess I could run as a 32-bit instance, but I'd rather actually
>>>>> use a 64-bit instance.
>>>> Not if you want to run many of them.
>>> Probably not more than a dozen I guess?
>>
>> 256
> 
> That's a bit more than I was thinking :-)
> 
>>>> The 3-level page tables in 64 bit spin up a whole raft threads making it
>>>> unfeasible. Compared to that the 32 bit uses 5 threads in total per
>>>> instance.
>>> I'm probably missing something, how are threads related to page tables?
>>
>> Uml memory management spins up a thread every time it creates a level3
>> page table. It is somewhere around kernel/skas
> 
> Ah, ok, thanks for the pointer.
> 
>>> I can see how that would use more memory, but where do threads come in?
>>
>> It is not memory use, it is actually performance and stability on larger
>> machines.
>>
>> This is less acute now after the ubd transaction bulking, but it used to
>> be the case that taskset -c 0 ./run-your-uml-testcase was faster to boot
>> a linux system by a factor of 2+ times compared to just leaving all the
>> threads wonder to different CPUs.
>>
>> It was even more fun on larger machines. I had a 5 liner script to kill
>> a 2 (or 4) socket Xeon in those days - it died on the 6-9th instance
>> being spun up if they were not being assigned specific NUMA node
>> affinity. It just keeled over - NMIs due to not being able to keep up
>> the cache in sync.
> 
> Fun!
> 
> Well, I guess if I run into it I'll know what's going on. For now, not
> very likely...

I may get around and see if the APIs have improved a bit to add some 
host CPU affinity and NUMA awareness as an option. Anything else aside, 
it should improve the performance quite a bit.

Last time I looked at it, using them was rather painful - f.e. there was 
no way to say "keep these things together on X", you can only do hard 
assignments to a particular core which is not suitable for a generic use 
case.

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

