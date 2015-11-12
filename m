Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <aivanov@Brocade.com>) id 1ZwuLM-0000DQ-FI
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Nov 2015 16:03:24 +0000
Received: from mx0b-000f0801.pphosted.com ([67.231.152.113])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZwuLL-0008Ix-CX
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Nov 2015 16:03:24 +0000
Received: from pps.filterd (m0000700.ppops.net [127.0.0.1])
	by mx0b-000f0801.pphosted.com (8.15.0.59/8.15.0.59) with SMTP id
	tACFsR5f025399 for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 12 Nov 2015 08:03:15 -0800
Received: from brmwp-exmb11.corp.brocade.com ([208.47.132.227])
	by mx0b-000f0801.pphosted.com with ESMTP id 1y4ejd21ht-1
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 12 Nov 2015 08:03:15 -0800
From: Anton Ivanov <aivanov@Brocade.com>
Date: Thu, 12 Nov 2015 16:03:12 +0000
Message-ID: <5644B820.8020601@brocade.com>
References: <1447079597-17816-1-git-send-email-aivanov@brocade.com>
	<5640B5B5.7050907@kot-begemot.co.uk>	<1447274788.48401.3.camel@m3y3r.de>
	<CAFLxGvyEs9MAYMiX1GseJAVt0oKzMyRou6OPOFEg2hh0w3+kog@mail.gmail.com>
	<56448624.7020606@brocade.com> <5644AEE9.8060105@kot-begemot.co.uk>
In-Reply-To: <5644AEE9.8060105@kot-begemot.co.uk>
Content-Language: en-US
Content-ID: <1D92253FD2D58649AF28912ECDF55631@brocade.local>
MIME-Version: 1.0
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
To: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On 12/11/15 15:23, Anton Ivanov wrote:
> [snip]
>
>>> Hmmm, UML is UP and does not support PREEMPT, so all spinlocks
>>> should be a no-op.
>> In that case, if I understand correctly what is going on, there are a
>> couple of places - the free_irqs(), activate_fd and the sigio handler
>> itself, where it should not be a mutex, not a spinlock. It is there to
>> ensure that you cannot use it in an interrupt context while it is being
>> modified.
>>
>> If spinlock is a NOP it fails to perform this duty. The code should also
>> be different - it should return on try_lock so it does not deadlock so
>> spinlock_irqsave is the wrong locking primitive as it does not have this
>> functionality.
>>
>> That is an issue both with this patch and with the original poll based
>> controller - there free_irq, add_fd, reactivate_fd can all theoretically
>> produce a race if you are adding/removing devices while under high IO load.
> We, however cannot use mutex here as it is interrupt.
>
> I tried with spin_trylock and finally got the correct behaviour. It
> throws an occasional warning here and there while inserting/removing
> devices, but works correctly with either config. No more BUGs.
>
> A bare (not try) spinlock with UP/PREEMPT set as they are in UML
> actually does not guard anything effectively - it is a NOP. The try form
> is an exemption - if you look at spinlock.h it is actually "viable" even
> on UP. It will however throw a warning that it is activated in an
> inappropriate context if it hits an existing lock.
>
> In theory - the code in signal.c should guard against nested interrupt
> invocation. I am still struggling to understand why it fails to work in
> practice.
>
> This also leaves open the question on how to add/remove interrupts. If
> the spinlock does not actually guard the irq data structures properly
> modifying them in a safe manner becomes a very interesting exercise. I
> have it working with the try form, but that throws the occasional warning.
>
> I am going to clean it up and re-submit so we have a "working version"
> which people can comment on.

Putting an extra guard around the signal handler in signal.c which 
prevents recursive invocation solves it completely.

I am going to clean it up, see if we need a similar guard around the 
timer interrupt and re-submit tomorrow morning.

>
> A.
>
>> A.
>>
>>> Do you have lock debugging enabled?
>>>
>>> I this case I'd start gdb and inspect the memory. Maybe a stack corruption.
>>>
>> ------------------------------------------------------------------------------
>> _______________________________________________
>> User-mode-linux-devel mailing list
>> User-mode-linux-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>>
>
> ------------------------------------------------------------------------------
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

