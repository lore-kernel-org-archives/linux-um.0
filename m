Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1ZtCpb-0002uv-3D
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Nov 2015 10:59:19 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZtCpZ-0002ql-Rt
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Nov 2015 10:59:19 +0000
Message-ID: <563741FE.9040605@kot-begemot.co.uk>
Date: Mon, 02 Nov 2015 10:59:10 +0000
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <1445416947-824802-1-git-send-email-aivanov@brocade.com>
	<562D236E.7020108@kot-begemot.co.uk> <562DFC90.9030308@nod.at>
	<5631BB4E.4010301@kot-begemot.co.uk>
	<CAFLxGvwDXWhw+mssT4quUaRC3DFAtRAGksmV-wuYrdzLWZEa0w@mail.gmail.com>
	<1446304232.3238.8.camel@m3y3r.de> <5634DAA4.70308@nod.at>
	<1446304594.3238.11.camel@m3y3r.de> <5634DC7B.3010707@nod.at>
	<56371B6D.3080506@kot-begemot.co.uk> <563720BA.20107@nod.at>
	<563721BB.10003@kot-begemot.co.uk> <56372439.2070509@nod.at>
	<5637257A.8000200@kot-begemot.co.uk> <563728E2.5090901@nod.at>
	<563732B7.7050008@kot-begemot.co.uk> <5637346F.6060004@nod.at>
In-Reply-To: <5637346F.6060004@nod.at>
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

On 02/11/15 10:01, Richard Weinberger wrote:
> Am 02.11.2015 um 10:53 schrieb Anton Ivanov:
>> [snip]
>>
>>>>> I'm pretty sure that you don't see the issue as your Jessy userspace uses nanosleep periodically.
>>>> There are quite a few things running so this may indeed be the case.
>>>>
>>>> What do you use for userspace (so I can try to reproduce this and debug it)?
>>> Debian Squeeze amd64 with almost nothing running.
>>>
>>>     PID TTY      STAT   TIME COMMAND
>>>       2 ?        S      0:00 [kthreadd]
>>>       3 ?        S      0:00  \_ [ksoftirqd/0]
>>>       4 ?        S      0:00  \_ [kworker/0:0]
>>>       5 ?        S<     0:00  \_ [kworker/0:0H]
>>>       6 ?        S      0:00  \_ [kworker/u2:0]
>>>       7 ?        S      0:00  \_ [kdevtmpfs]
>>>       8 ?        S<     0:00  \_ [netns]
>>>       9 ?        S<     0:00  \_ [writeback]
>>>      10 ?        S      0:00  \_ [kworker/u2:1]
>>>      11 ?        S<     0:00  \_ [crypto]
>>>      12 ?        S      0:00  \_ [kworker/0:1]
>>>      13 ?        S<     0:00  \_ [bioset]
>>>      14 ?        S<     0:00  \_ [kblockd]
>>>      15 ?        S      0:00  \_ [kswapd0]
>>>      68 ?        S      0:00  \_ [fsnotify_mark]
>>>     221 ?        S<     0:00  \_ [bioset]
>>>     229 ?        S<     0:00  \_ [deferwq]
>>>     231 ?        S      0:00  \_ [jbd2/ubda-8]
>>>     232 ?        S<     0:00  \_ [ext4-rsv-conver]
>>>     233 ?        S<     0:00  \_ [kworker/0:1H]
>>>       1 ?        Ss     0:00 init [2]
>>>     271 ?        S<s    0:00 udevd --daemon
>>>     297 ?        S<     0:00  \_ udevd --daemon
>>>     298 ?        S<     0:00  \_ udevd --daemon
>>>     549 ?        Sl     0:00 /usr/sbin/rsyslogd -c4
>>>     580 ?        Ss     0:00 /usr/sbin/cron
>>>     595 ?        Ss     0:00 /usr/bin/dbus-daemon --system
>>>     609 ?        Ss     0:00 /usr/sbin/sshd
>>>     628 tty0     Ss     0:00 /bin/login --
>>>     631 tty0     S      0:00  \_ -bash
>>>     636 tty0     R+     0:00      \_ ps fax
>>>     629 tty1     Ss+    0:00 /sbin/getty 38400 tty1 linux
>>>     630 ttyS0    Ss+    0:00 /sbin/getty 115200 ttyS0 linux
>> I cannot reproduce that by dropping jessie into single user mode so I am going to build a squeeze image and re-test with that.
> I can also reproduce using init=/bin/bash.

I may have to use that. There is a recurring sleep 1 in one of the 
scripts in udev on sarge which results in enough nanosleeps for this not 
to show up on an "out-of-the-box" sarge build.

A.

>
> Thanks,
> //richard
>
>


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

