Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfN2y-00018C-Ci
 for linux-um@lists.infradead.org; Fri, 04 Jan 2019 10:49:50 +0000
Subject: Re: [PATCH] um: Try to avoid kmalloc in signal handling
References: <20190104100517.9809-1-anton.ivanov@cambridgegreys.com>
 <2157515.SUgOQPs8Ts@blindfold>
 <108ad3b6-93ee-5d8c-c1bf-b83e22ff3d3f@cambridgegreys.com>
 <9157944.H6u4diqB1j@blindfold>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <0558d80c-1c04-3eab-eb28-307216a9b030@cambridgegreys.com>
Date: Fri, 4 Jan 2019 10:49:42 +0000
MIME-Version: 1.0
In-Reply-To: <9157944.H6u4diqB1j@blindfold>
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
To: Richard Weinberger <richard@nod.at>
Cc: linux-um@lists.infradead.org



On 1/4/19 10:33 AM, Richard Weinberger wrote:
> Am Freitag, 4. Januar 2019, 11:19:46 CET schrieb Anton Ivanov:
>>> I fear this is not correct.
>>> Think of task switching, if you push something to reg_file[],
>>> it is not guaranteed that the same task will run next and pop the item.
>>> The order can change.
>>
>> It should not occur for the signals that map onto IRQ (timer and IO) -
>> there it is all kernel.
>>
>> I cannot trigger that for the other ones, but it may be possible.
> 
> We need to be super sure about this.

I am pretty sure about the IRQ ones. That call chain goes cleanly down 
and up resulting in whatever was pushed to be popped.

I am trying to get my head around what can possibly happen in the 
various fault ones that will result in a task switch to a task which is 
half-done with handling signal and is about to return (and pop the wrong 
one).

>   
>> IMO we should just bite the bullet and go back to using the stack
>> increasing the minimum stack order needed to 1 for 32 bit and to 2 for
>> 64 bit.
> 
> Increasing the kernel stack just for this is also a huge overhead.
> But I never benchmarked it myself.
> 
>> x86 if I read it correctly is still using the stack even for the new
>> register sets.
> 
> Are you sure? I don't think so. The kernel stack is small and the xregset is
> huge.
> Where did you see this?

It looked like that when I skimmed across get_sigframe and 
fpu_alloc_mathframe in x86 signal.c in first read, but I may be wrong.

> 
> Thanks,
> //richard
> 
> 
> 

-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

