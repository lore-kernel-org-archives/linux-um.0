Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1Zwd7f-00076I-3w
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Nov 2015 21:40:07 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Zwd7d-00028o-Jq
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Nov 2015 21:40:07 +0000
Received: from tun252.maui-covenant.sigsegv.cx ([192.168.17.6]
	helo=smaug.kot-begemot.co.uk) by ivanoab4.miniserver.com with esmtps
	(TLS1.2:RSA_AES_128_CBC_SHA1:128) (Exim 4.80)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1Zwd7W-0007MM-Pm
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Nov 2015 21:39:58 +0000
Received: from [144.49.132.3] (helo=[10.102.151.39])
	by smaug.kot-begemot.co.uk with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.84)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1Zwd7W-0003I9-67
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Nov 2015 21:39:58 +0000
Message-ID: <5643B5A0.9080507@kot-begemot.co.uk>
Date: Wed, 11 Nov 2015 21:39:44 +0000
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <1447079597-17816-1-git-send-email-aivanov@brocade.com>	<5640B5B5.7050907@kot-begemot.co.uk>	<1447274788.48401.3.camel@m3y3r.de>
	<CAFLxGvyEs9MAYMiX1GseJAVt0oKzMyRou6OPOFEg2hh0w3+kog@mail.gmail.com>
In-Reply-To: <CAFLxGvyEs9MAYMiX1GseJAVt0oKzMyRou6OPOFEg2hh0w3+kog@mail.gmail.com>
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

I do not see it with my config. I have cleaned up a few things and can 
send an updated version.

At the same time it is 100% reproducible using the config I got from 
Thomas. So this is somehow config dependent.

I have compared the configs and the biggest difference I can see is that 
Thomas has most of the debug options enabled.

Everything else is the same or not relevant (nat, etc - module options).

In any case - I cannot make sense of the traces - they show nested 
invocation of the sigio handler and nested interrupt invocation. If 
there is no stack corruption there should be no way to get that - the 
enable/disable and hard handler code in signal.c ensures that.

I will probably add some "manual" debug code to check if the nested 
invocation happens with the debug options off.

A.


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
> Do you have lock debugging enabled?
>
> I this case I'd start gdb and inspect the memory. Maybe a stack corruption.
>


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

