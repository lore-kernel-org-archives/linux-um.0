Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1Zwca8-0007bK-Le
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Nov 2015 21:05:28 +0000
Received: from mail-ob0-f176.google.com ([209.85.214.176])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Zwca7-0002lZ-PR
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Nov 2015 21:05:28 +0000
Received: by obbww6 with SMTP id ww6so31600367obb.0
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 11 Nov 2015 13:05:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1447274788.48401.3.camel@m3y3r.de>
References: <1447079597-17816-1-git-send-email-aivanov@brocade.com>
	<5640B5B5.7050907@kot-begemot.co.uk>
	<1447274788.48401.3.camel@m3y3r.de>
Date: Wed, 11 Nov 2015 22:05:22 +0100
Message-ID: <CAFLxGvyEs9MAYMiX1GseJAVt0oKzMyRou6OPOFEg2hh0w3+kog@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
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
To: Thomas Meyer <thomas@m3y3r.de>
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

On Wed, Nov 11, 2015 at 9:46 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
> Am Montag, den 09.11.2015, 15:03 +0000 schrieb Anton Ivanov:
>> It throws a couple of harmless "epoll del fd" warnings on reboot
>> which
>> result the fact that disable_fd/enable_fd are not removed in the
>> terminal/line code.
>>
>> These are harmless and will go away once the term/line code gets
>> support
>> for real write IRQs in addition to read at some point in the future.
>>
>> I have fixed the file descriptor leak in the reboot case.
>
> Hi,
>
> now with the list on copy!
>
> Richard: can you make some sense out of these stack traces? I can
> provide the config if you want!
>
> I see a lot of bugs of type "BUG: spinlock recursion on CPU#0" with
> this patch:
>
> I did look over your patch and found two errors in the irq_lock
> spinlock handling:
>
> http://m3y3r.dyndns.org:9100/gerrit/#/c/2/1..2/arch/um/kernel/irq.c
>
> But it still seems to miss something as above bugs still occurs, but
> now the system boots up a bit more at least.
>
> Example:
>  [  225.570000] BUG: spinlock lockup suspected on CPU#0, chmod/516
>  [  225.570000]  lock: irq_lock+0x0/0x18, .magic: dead4ead, .owner:

Hmmm, UML is UP and does not support PREEMPT, so all spinlocks
should be a no-op.
Do you have lock debugging enabled?

I this case I'd start gdb and inspect the memory. Maybe a stack corruption.

-- 
Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

