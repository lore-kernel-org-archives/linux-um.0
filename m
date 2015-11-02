Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1ZtB9v-0004lw-2e
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Nov 2015 09:12:11 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZtB9u-0007VE-34
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Nov 2015 09:12:11 +0000
References: <1445416947-824802-1-git-send-email-aivanov@brocade.com>
	<562D236E.7020108@kot-begemot.co.uk> <562DFC90.9030308@nod.at>
	<5631BB4E.4010301@kot-begemot.co.uk>
	<CAFLxGvwDXWhw+mssT4quUaRC3DFAtRAGksmV-wuYrdzLWZEa0w@mail.gmail.com>
	<1446304232.3238.8.camel@m3y3r.de> <5634DAA4.70308@nod.at>
	<1446304594.3238.11.camel@m3y3r.de> <5634DC7B.3010707@nod.at>
	<56371B6D.3080506@kot-begemot.co.uk> <563720BA.20107@nod.at>
	<563721BB.10003@kot-begemot.co.uk> <56372439.2070509@nod.at>
	<5637257A.8000200@kot-begemot.co.uk>
From: Richard Weinberger <richard@nod.at>
Message-ID: <563728E2.5090901@nod.at>
Date: Mon, 2 Nov 2015 10:12:02 +0100
MIME-Version: 1.0
In-Reply-To: <5637257A.8000200@kot-begemot.co.uk>
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
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, Thomas Meyer <thomas@m3y3r.de>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

Am 02.11.2015 um 09:57 schrieb Anton Ivanov:
> On 02/11/15 08:52, Richard Weinberger wrote:
>> Am 02.11.2015 um 09:41 schrieb Anton Ivanov:
>>> On 02/11/15 08:37, Richard Weinberger wrote:
>>>> Hi!
>>>>
>>>> Am 02.11.2015 um 09:14 schrieb Anton Ivanov:
>>>>> I was testing under similar conditions (CPU pinning using taskset -c 0 on a multicore).
>>>>>
>>>>> I have removed it and run some retests - I cannot reproduce the hang at this point with my config
>>>>>
>>>>> I am going to run a defconfig and compare the results to see if this will give me any insights on the root cause.
>>>> I can reproduce on both my build machine (8 core) and my laptop (4 core).
>>>> If it helps I can share the rootfs.
>>>>
>>>> On my laptop I was able to reproduce within 5 minutes.
>>>> 1. make defconfig ARCH=um
>>>> 2. make -j 4 linux ARCH=um
>>>> 3. ./linux ubda=../Downloads/Debian-Squeeze-AMD64-root_fs mem=1G
>>>> 4. login to tty0
>>>> 5. wait a few minutes
>>>> 6. try to run top, it will hang in nanosleep
>>> Pretty much the same. Does not hang, multiple test runs. Userspace is a relatively full install of a debian jessie.
>>>
>>> I ran deconfig and did a diff. The prime suspect differences between my config and defconfig are stack order 3 (not 1) and io sched of cfq, not deadline.
>>>
>>> I am going to retest just with these first to see if one of them is the culprit, if that does not make a difference, run it with defconfig and try to reproduce the hang.
>> I'm pretty sure that you don't see the issue as your Jessy userspace uses nanosleep periodically.
> 
> There are quite a few things running so this may indeed be the case.
> 
> What do you use for userspace (so I can try to reproduce this and debug it)?

Debian Squeeze amd64 with almost nothing running.

  PID TTY      STAT   TIME COMMAND
    2 ?        S      0:00 [kthreadd]
    3 ?        S      0:00  \_ [ksoftirqd/0]
    4 ?        S      0:00  \_ [kworker/0:0]
    5 ?        S<     0:00  \_ [kworker/0:0H]
    6 ?        S      0:00  \_ [kworker/u2:0]
    7 ?        S      0:00  \_ [kdevtmpfs]
    8 ?        S<     0:00  \_ [netns]
    9 ?        S<     0:00  \_ [writeback]
   10 ?        S      0:00  \_ [kworker/u2:1]
   11 ?        S<     0:00  \_ [crypto]
   12 ?        S      0:00  \_ [kworker/0:1]
   13 ?        S<     0:00  \_ [bioset]
   14 ?        S<     0:00  \_ [kblockd]
   15 ?        S      0:00  \_ [kswapd0]
   68 ?        S      0:00  \_ [fsnotify_mark]
  221 ?        S<     0:00  \_ [bioset]
  229 ?        S<     0:00  \_ [deferwq]
  231 ?        S      0:00  \_ [jbd2/ubda-8]
  232 ?        S<     0:00  \_ [ext4-rsv-conver]
  233 ?        S<     0:00  \_ [kworker/0:1H]
    1 ?        Ss     0:00 init [2]
  271 ?        S<s    0:00 udevd --daemon
  297 ?        S<     0:00  \_ udevd --daemon
  298 ?        S<     0:00  \_ udevd --daemon
  549 ?        Sl     0:00 /usr/sbin/rsyslogd -c4
  580 ?        Ss     0:00 /usr/sbin/cron
  595 ?        Ss     0:00 /usr/bin/dbus-daemon --system
  609 ?        Ss     0:00 /usr/sbin/sshd
  628 tty0     Ss     0:00 /bin/login --
  631 tty0     S      0:00  \_ -bash
  636 tty0     R+     0:00      \_ ps fax
  629 tty1     Ss+    0:00 /sbin/getty 38400 tty1 linux
  630 ttyS0    Ss+    0:00 /sbin/getty 115200 ttyS0 linux

Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

