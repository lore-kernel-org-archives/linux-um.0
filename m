Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1izIje-0002ew-VZ
 for linux-um@lists.infradead.org; Wed, 05 Feb 2020 11:20:48 +0000
Subject: Re: [RFC v2 07/37] lkl: interrupt support
References: <cover.1573179553.git.thehajime@gmail.com>
 <567fd4d5c395e2279e86ca0bfca544ad2773a31d.1573179553.git.thehajime@gmail.com>
 <CAFLxGvxytmS4WSFj2ibyJKCuR5TbspdNf6MvHNvzh9dtKx2rJg@mail.gmail.com>
 <m2h805qy99.wl-thehajime@gmail.com>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <739ada9a-b88a-5192-fb4b-65132a74b4de@kot-begemot.co.uk>
Date: Wed, 5 Feb 2020 10:49:37 +0000
MIME-Version: 1.0
In-Reply-To: <m2h805qy99.wl-thehajime@gmail.com>
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
To: Hajime Tazaki <thehajime@gmail.com>, richard.weinberger@gmail.com
Cc: linux-arch@vger.kernel.org, tavi.purdila@gmail.com, linux-um@lists.infradead.org, retrage01@gmail.com, linux-kernel-library@freelists.org, sigmaepsilon92@gmail.com



On 05/02/2020 07:38, Hajime Tazaki wrote:
> 
> On Tue, 26 Nov 2019 07:13:55 +0900,
> Richard Weinberger wrote:
>>
>> On Fri, Nov 8, 2019 at 6:03 AM Hajime Tazaki <thehajime@gmail.com> wrote:
>>>
>>> From: Octavian Purdila <tavi.purdila@gmail.com>
>>>
>>> Add APIs that allows the host to reserve and free and interrupt number
>>> and also to trigger an interrupt.
>>>
>>> The trigger operation will simply store the interrupt data in
>>> queue. The interrupt handler is run later, at the first opportunity it
>>> has to avoid races with any kernel threads.
>>>
>>> Currently, interrupts are run on the first interrupt enable operation
>>> if interrupts are disabled and if we are not already in interrupt
>>> context.
>>>
>>> When triggering an interrupt, it uses GCC's built-in functions for
>>> atomic memory access to synchronize and simple boolean flags.
>>>
>>> Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
>>> Signed-off-by: Michael Zimmermann <sigmaepsilon92@gmail.com>
>>> Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
>>> ---
>>>   arch/um/lkl/include/asm/irq.h             |  13 ++
>>>   arch/um/lkl/include/uapi/asm/irq.h        |  36 ++++
>>>   arch/um/lkl/include/uapi/asm/sigcontext.h |  16 ++
>>>   arch/um/lkl/kernel/irq.c                  | 193 ++++++++++++++++++++++
>>
>> Like I said before, this also something to unify with UML.
>> I'm aware that this is easily said but we cannot have too much duplication.
>>
>> Feel free to ask if UML internals give you headache. :-)
> 
> Same as nommu implementation, I left this part as-is.
> 
> Triggering interrupts with fd events (delivered by epoll&co) is a hard
> part to implement host-independent interrupts of LKL.  OTOH, the v3
> patchset shows that it is doable to use UML drivers with the LKL
> interrupt facility.

Make sure you are testing with the vector network devices, the legacy ones are scheduled to be obsoleted at some point

I know this will cause a headache on non-Linux, I am happy to write wrappers/emulators for recvmms/sendmmsg so these build on the systems which do not support them.

Brgds,


> 
> I may also need more time to evaluate/find a right direction, though.
> Your comments are always welcome.
> 
> -- Hajime
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

