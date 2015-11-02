Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1ZtAGM-0003la-F8
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Nov 2015 08:14:46 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZtAGL-0004px-BS
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Nov 2015 08:14:46 +0000
Message-ID: <56371B6D.3080506@kot-begemot.co.uk>
Date: Mon, 02 Nov 2015 08:14:37 +0000
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <1445416947-824802-1-git-send-email-aivanov@brocade.com>
	<562D236E.7020108@kot-begemot.co.uk> <562DFC90.9030308@nod.at>
	<5631BB4E.4010301@kot-begemot.co.uk>
	<CAFLxGvwDXWhw+mssT4quUaRC3DFAtRAGksmV-wuYrdzLWZEa0w@mail.gmail.com>
	<1446304232.3238.8.camel@m3y3r.de> <5634DAA4.70308@nod.at>
	<1446304594.3238.11.camel@m3y3r.de> <5634DC7B.3010707@nod.at>
In-Reply-To: <5634DC7B.3010707@nod.at>
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
To: Richard Weinberger <richard@nod.at>, Thomas Meyer <thomas@m3y3r.de>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

I was testing under similar conditions (CPU pinning using taskset -c 0 
on a multicore).

I have removed it and run some retests - I cannot reproduce the hang at 
this point with my config

I am going to run a defconfig and compare the results to see if this 
will give me any insights on the root cause.

A.


On 31/10/15 15:21, Richard Weinberger wrote:
> Am 31.10.2015 um 16:16 schrieb Thomas Meyer:
>> mhh. strange. I didn't see this behaviour on my machine, but my machine
>> is a rare single core system so, likely a race condition while relaying
>> the timer interrupt to the userspace process.
> Here I can trigger it by starting UML, logging in and waiting ~5min.
> Then i try to run "top" --> top hangs forever.
>
>> But I'm out of ideas how this could happen!
> Maybe some stupid timeslice over/underflow.
>
>> what happens when you send the hanging process a SIGVTALRM signal? does
>> it proceed correctly?
> You mean sending SIGVTALRM to the UML host process?
> It runs normally, I can also login on other ttys.
>
> Thanks,
> //richard
>


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

