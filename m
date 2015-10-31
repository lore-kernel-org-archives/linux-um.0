Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1ZscbG-00071X-Ns
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 31 Oct 2015 20:18:06 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZscbF-0007zd-JR
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 31 Oct 2015 20:18:06 +0000
Message-ID: <563521EB.9020406@kot-begemot.co.uk>
Date: Sat, 31 Oct 2015 20:17:47 +0000
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <1445416947-824802-1-git-send-email-aivanov@brocade.com>
	<562D236E.7020108@kot-begemot.co.uk> <562DFC90.9030308@nod.at>
	<5631BB4E.4010301@kot-begemot.co.uk>
	<CAFLxGvwDXWhw+mssT4quUaRC3DFAtRAGksmV-wuYrdzLWZEa0w@mail.gmail.com>
	<1446304232.3238.8.camel@m3y3r.de> <5634DAA4.70308@nod.at>
	<1446304594.3238.11.camel@m3y3r.de> <5634DC7B.3010707@nod.at>
	<1446305051.3238.13.camel@m3y3r.de> <5634DEAB.8090909@nod.at>
	<1446306242.3238.16.camel@m3y3r.de>
	<5634EACE.2030906@kot-begemot.co.uk> <5635119A.3080500@nod.at>
In-Reply-To: <5635119A.3080500@nod.at>
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

On 31/10/15 19:08, Richard Weinberger wrote:
> Am 31.10.2015 um 17:22 schrieb Anton Ivanov:
>> Richard, can you send me your config.
> Sure. It is basically a defconfig.

I am dragging an old config from some work I did a while back. I will 
scrap it and do a defconfig build one I get back home (I am traveling at 
the moment).

>
>> I have had it running for a couple of days before submission both under load and idle it was doing OK.
> Well, what userspace did you try?

Debian Wheezy and Jessie including a full apt-get update ; apt-get 
dist-upgrade

> I did some more tests, if nanosleep() is called periodically the issue does not arise.
> Maybe your userspace (systemd?) fires the syscall too often. ;)

Either that, or I re-used my old scripts which for a variety of reasons 
do CPU pinning (I do not remember if I turned that off or not before 
testing).

It may be that it does not show up when you are running UML pinned on 
one host CPU. Same as above - I will re-test when I get back home, both 
with my config and and with defconfig.

A

>
> Thanks,
> //richard


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

