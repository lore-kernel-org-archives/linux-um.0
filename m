Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1ZtAgN-0006tp-FP
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Nov 2015 08:41:39 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZtAgM-0003g9-G6
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Nov 2015 08:41:39 +0000
Message-ID: <563721BB.10003@kot-begemot.co.uk>
Date: Mon, 02 Nov 2015 08:41:31 +0000
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <1445416947-824802-1-git-send-email-aivanov@brocade.com>
	<562D236E.7020108@kot-begemot.co.uk> <562DFC90.9030308@nod.at>
	<5631BB4E.4010301@kot-begemot.co.uk>
	<CAFLxGvwDXWhw+mssT4quUaRC3DFAtRAGksmV-wuYrdzLWZEa0w@mail.gmail.com>
	<1446304232.3238.8.camel@m3y3r.de> <5634DAA4.70308@nod.at>
	<1446304594.3238.11.camel@m3y3r.de> <5634DC7B.3010707@nod.at>
	<56371B6D.3080506@kot-begemot.co.uk> <563720BA.20107@nod.at>
In-Reply-To: <563720BA.20107@nod.at>
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

On 02/11/15 08:37, Richard Weinberger wrote:
> Hi!
>
> Am 02.11.2015 um 09:14 schrieb Anton Ivanov:
>> I was testing under similar conditions (CPU pinning using taskset -c 0 on a multicore).
>>
>> I have removed it and run some retests - I cannot reproduce the hang at this point with my config
>>
>> I am going to run a defconfig and compare the results to see if this will give me any insights on the root cause.
> I can reproduce on both my build machine (8 core) and my laptop (4 core).
> If it helps I can share the rootfs.
>
> On my laptop I was able to reproduce within 5 minutes.
> 1. make defconfig ARCH=um
> 2. make -j 4 linux ARCH=um
> 3. ./linux ubda=../Downloads/Debian-Squeeze-AMD64-root_fs mem=1G
> 4. login to tty0
> 5. wait a few minutes
> 6. try to run top, it will hang in nanosleep

Pretty much the same. Does not hang, multiple test runs. Userspace is a 
relatively full install of a debian jessie.

I ran deconfig and did a diff. The prime suspect differences between my 
config and defconfig are stack order 3 (not 1) and io sched of cfq, not 
deadline.

I am going to retest just with these first to see if one of them is the 
culprit, if that does not make a difference, run it with defconfig and 
try to reproduce the hang.

A.

>
> Thanks,
> //richard
>


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

