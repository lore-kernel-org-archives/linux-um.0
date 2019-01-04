Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfRjo-0000as-QB
 for linux-um@lists.infradead.org; Fri, 04 Jan 2019 15:50:26 +0000
Subject: Re: [PATCH] um: Try to avoid kmalloc in signal handling
References: <20190103160917.10217-1-anton.ivanov@cambridgegreys.com>
 <cfcec59e-e1fd-1dd9-48ac-9645152cca4d@cambridgegreys.com>
 <da88ec54-3d0b-360a-863d-59e29c8eaa00@cambridgegreys.com>
 <8232816.4fJl4d8jsT@blindfold>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <f0771316-f932-6e60-6165-e47411ef33b3@cambridgegreys.com>
Date: Fri, 4 Jan 2019 15:50:16 +0000
MIME-Version: 1.0
In-Reply-To: <8232816.4fJl4d8jsT@blindfold>
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



On 1/3/19 9:42 PM, Richard Weinberger wrote:
> Am Donnerstag, 3. Januar 2019, 22:29:17 CET schrieb Anton Ivanov:
>> Second thought - this should not use kmalloc at all if it can. It should
>> either go on the stack the way it used to do before
>> b6024b21fec8367ef961a771cc9dde31f1831965 or it should have a sufficient
>> "register stack" to push registers for all use cases.
>>
>> Kmalloc/ATOMIC can fail just because it feels like it which means that
>> this can throw a panic() under very heavy IO.
> 
> Not good. :-(
> We cannot go back to stack based allocation. The stack is too small for
> AVX register sets.
> Maybe we can preallocate it.

I will write a pre-allocation alternative, but that may take some time 
because it needs to do additional allocations at some "safe" point in 
time like system idle, not in the IO/signal path where they can fail.

In the meantime we have to make sure that we are not sitting on a latent 
crash in the IO/Fault path so I have sent out a patch which removes 
kmalloc/ATOMIC and puts things back on the stack.

There are a few other options which are worth investigating like sizing 
the storage dynamically based on CPU and/or storing fp regs only if they 
have been touched, not every time (afaik MIPS was doing something like 
that). Once again, this may take a while to figure out if it is possible 
and some time to make it happen after that. That may be worth doing 
anyway for performance reasons. If memory serves me right, storing FPU 
state is a high cost operation. Not doing it for cases where it is not 
needed should yield some performance gains.

> (And check what arch/x86/ does)
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

