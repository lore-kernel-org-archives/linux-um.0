Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1ZyErN-0000i1-2w
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Nov 2015 08:09:57 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZyErL-0000Eo-PW
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Nov 2015 08:09:57 +0000
Received: from tun252.maui-covenant.sigsegv.cx ([192.168.17.6]
	helo=smaug.kot-begemot.co.uk) by ivanoab4.miniserver.com with esmtps
	(TLS1.2:RSA_AES_128_CBC_SHA1:128) (Exim 4.80)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1ZyErE-0001ME-Pc
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Nov 2015 08:09:48 +0000
Received: from monstrousnightmare.kot-begemot.co.uk ([192.168.3.80])
	by smaug.kot-begemot.co.uk with esmtp (Exim 4.84)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1ZyErE-0002JI-Eb
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Nov 2015 08:09:48 +0000
Message-ID: <56498F4C.6080706@kot-begemot.co.uk>
Date: Mon, 16 Nov 2015 08:09:48 +0000
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <1447079597-17816-1-git-send-email-aivanov@brocade.com>	<5640B5B5.7050907@kot-begemot.co.uk>	<1447274788.48401.3.camel@m3y3r.de>	<CAFLxGvyEs9MAYMiX1GseJAVt0oKzMyRou6OPOFEg2hh0w3+kog@mail.gmail.com>	<56448624.7020606@brocade.com>
	<5644AEE9.8060105@kot-begemot.co.uk> <5644B820.8020601@brocade.com>
In-Reply-To: <5644B820.8020601@brocade.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH v2] EPOLL Interrupt Controller V2.0
To: user-mode-linux-devel@lists.sourceforge.net

On 12/11/15 16:03, Anton Ivanov wrote:
> On 12/11/15 15:23, Anton Ivanov wrote:
>> [snip]
>>
>>>> Hmmm, UML is UP and does not support PREEMPT, so all spinlocks
>>>> should be a no-op.
>>> In that case, if I understand correctly what is going on, there are a
>>> couple of places - the free_irqs(), activate_fd and the sigio handler
>>> itself, where it should not be a mutex, not a spinlock. It is there to
>>> ensure that you cannot use it in an interrupt context while it is being
>>> modified.
>>>
>>> If spinlock is a NOP it fails to perform this duty. The code should also
>>> be different - it should return on try_lock so it does not deadlock so
>>> spinlock_irqsave is the wrong locking primitive as it does not have this
>>> functionality.
>>>
>>> That is an issue both with this patch and with the original poll based
>>> controller - there free_irq, add_fd, reactivate_fd can all theoretically
>>> produce a race if you are adding/removing devices while under high IO load.
>> We, however cannot use mutex here as it is interrupt.
>>
>> I tried with spin_trylock and finally got the correct behaviour. It
>> throws an occasional warning here and there while inserting/removing
>> devices, but works correctly with either config. No more BUGs.
>>
>> A bare (not try) spinlock with UP/PREEMPT set as they are in UML
>> actually does not guard anything effectively - it is a NOP. The try form
>> is an exemption - if you look at spinlock.h it is actually "viable" even
>> on UP. It will however throw a warning that it is activated in an
>> inappropriate context if it hits an existing lock.
>>
>> In theory - the code in signal.c should guard against nested interrupt
>> invocation. I am still struggling to understand why it fails to work in
>> practice.
>>
>> This also leaves open the question on how to add/remove interrupts. If
>> the spinlock does not actually guard the irq data structures properly
>> modifying them in a safe manner becomes a very interesting exercise. I
>> have it working with the try form, but that throws the occasional warning.
>>
>> I am going to clean it up and re-submit so we have a "working version"
>> which people can comment on.
> Putting an extra guard around the signal handler in signal.c which
> prevents recursive invocation solves it completely.
>
> I am going to clean it up, see if we need a similar guard around the
> timer interrupt and re-submit tomorrow morning.

That worked. So in principle the proposed IRQ semantics are sound.

However, in practice forcing the re-invocation of IRQs and returing up 
the IRQ chain resulted in a significant performance drop - from 15% 
above the original to 15% below the original. By using a guard we also 
lose the possibility to have edge triggers in the future so overall this 
is a no-go.

I am going to "sleep on it" and come back to it later in the week to 
figure out why we do not see recursive invocation with the original and 
see it with the epoll one.

Once I get to the bottom of that, I will resubmit a fixed version.

A.

>
>> A.
>>
>>> A.
>>>
>>>> Do you have lock debugging enabled?
>>>>
>>>> I this case I'd start gdb and inspect the memory. Maybe a stack corruption.
>>>>
>>> ------------------------------------------------------------------------------
>>> _______________________________________________
>>> User-mode-linux-devel mailing list
>>> User-mode-linux-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>>>
>> ------------------------------------------------------------------------------
>> _______________________________________________
>> User-mode-linux-devel mailing list
>> User-mode-linux-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>>
> ------------------------------------------------------------------------------
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>


------------------------------------------------------------------------------
Presto, an open source distributed SQL query engine for big data, initially
developed by Facebook, enables you to easily query your data on Hadoop in a 
more interactive manner. Teradata is also now providing full enterprise
support for Presto. Download a free open source copy now.
http://pubads.g.doubleclick.net/gampad/clk?id=250295911&iu=/4140
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

