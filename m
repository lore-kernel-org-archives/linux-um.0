Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <aivanov@Brocade.com>) id 1Zwr0T-00016e-MI
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Nov 2015 12:29:37 +0000
Received: from mx0b-000f0801.pphosted.com ([67.231.152.113])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Zwr0S-000211-Aw
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Nov 2015 12:29:37 +0000
Received: from pps.filterd (m0048192.ppops.net [127.0.0.1])
	by mx0b-000f0801.pphosted.com (8.15.0.59/8.15.0.59) with SMTP id
	tACBpc5p002754 for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 12 Nov 2015 04:29:30 -0800
Received: from brmwp-exmb11.corp.brocade.com ([208.47.132.227])
	by mx0b-000f0801.pphosted.com with ESMTP id 1y4gqv96u8-1
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 12 Nov 2015 04:29:30 -0800
From: Anton Ivanov <aivanov@Brocade.com>
Date: Thu, 12 Nov 2015 12:29:26 +0000
Message-ID: <56448624.7020606@brocade.com>
References: <1447079597-17816-1-git-send-email-aivanov@brocade.com>
	<5640B5B5.7050907@kot-begemot.co.uk>	<1447274788.48401.3.camel@m3y3r.de>
	<CAFLxGvyEs9MAYMiX1GseJAVt0oKzMyRou6OPOFEg2hh0w3+kog@mail.gmail.com>
In-Reply-To: <CAFLxGvyEs9MAYMiX1GseJAVt0oKzMyRou6OPOFEg2hh0w3+kog@mail.gmail.com>
Content-Language: en-US
Content-ID: <D37C7906646B1048B10C9743DD9C54B5@brocade.local>
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

On 11/11/15 21:05, Richard Weinberger wrote:
> On Wed, Nov 11, 2015 at 9:46 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
>> Am Montag, den 09.11.2015, 15:03 +0000 schrieb Anton Ivanov:
>>> It throws a couple of harmless "epoll del fd" warnings on reboot
>>> which
>>> result the fact that disable_fd/enable_fd are not removed in the
>>> terminal/line code.
>>>
>>> These are harmless and will go away once the term/line code gets
>>> support
>>> for real write IRQs in addition to read at some point in the future.
>>>
>>> I have fixed the file descriptor leak in the reboot case.
>> Hi,
>>
>> now with the list on copy!
>>
>> Richard: can you make some sense out of these stack traces? I can
>> provide the config if you want!
>>
>> I see a lot of bugs of type "BUG: spinlock recursion on CPU#0" with
>> this patch:
>>
>> I did look over your patch and found two errors in the irq_lock
>> spinlock handling:
>>
>> http://m3y3r.dyndns.org:9100/gerrit/#/c/2/1..2/arch/um/kernel/irq.c
>>
>> But it still seems to miss something as above bugs still occurs, but
>> now the system boots up a bit more at least.
>>
>> Example:
>>   [  225.570000] BUG: spinlock lockup suspected on CPU#0, chmod/516
>>   [  225.570000]  lock: irq_lock+0x0/0x18, .magic: dead4ead, .owner:
> Hmmm, UML is UP and does not support PREEMPT, so all spinlocks
> should be a no-op.

In that case, if I understand correctly what is going on, there are a 
couple of places - the free_irqs(), activate_fd and the sigio handler 
itself, where it should not be a mutex, not a spinlock. It is there to 
ensure that you cannot use it in an interrupt context while it is being 
modified.

If spinlock is a NOP it fails to perform this duty. The code should also 
be different - it should return on try_lock so it does not deadlock so 
spinlock_irqsave is the wrong locking primitive as it does not have this 
functionality.

That is an issue both with this patch and with the original poll based 
controller - there free_irq, add_fd, reactivate_fd can all theoretically 
produce a race if you are adding/removing devices while under high IO load.

A.

> Do you have lock debugging enabled?
>
> I this case I'd start gdb and inspect the memory. Maybe a stack corruption.
>

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

