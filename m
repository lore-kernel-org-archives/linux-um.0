Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1Zrge2-0007fa-HI
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Oct 2015 06:25:06 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Zrge1-0003DL-7S
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Oct 2015 06:25:06 +0000
Message-ID: <5631BB4E.4010301@kot-begemot.co.uk>
Date: Thu, 29 Oct 2015 06:23:10 +0000
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <1445416947-824802-1-git-send-email-aivanov@brocade.com>
	<562D236E.7020108@kot-begemot.co.uk> <562DFC90.9030308@nod.at>
In-Reply-To: <562DFC90.9030308@nod.at>
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
Subject: Re: [uml-devel] [PATCH v3] um: Switch clocksource to hrtimers
To: Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net

I got the first patchset to build, it works very well on a single core 
host or with CPU pinning of the UML - the performance gain is > 25%.

However, I introduced a race somewhere along the way - it crashes UML 
reliably if you do not pin CPUs.

I will debug it, fix it and submit. I am guessing a week or so. IMHO 25% 
is worth it :)

A.


On 26/10/15 10:12, Richard Weinberger wrote:
> Hi!
>
> Am 25.10.2015 um 19:46 schrieb Anton Ivanov:
>> Hi List, hi Richard,
>>
>> I am going to sort out the UBD patchset next as that has no dependencies on timer and the other stuff which is waiting in the queue behind the timers.
>>
>> That should give UML a significant boost. It is nothing particularly revolutionary (qemu has been using some of that for ages).
>>
>> I should be able to get these out of the door early on this week.
> Nice!
>
>> A.
>>
>> P.S. If there is anything to fix on the timer one, please shout.
> Looks good so far. Unless it breaks a lot it will be part of the 4.4 merge window. :)
>
> Thanks,
> //richard
>


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

