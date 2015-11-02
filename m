Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1ZtAcI-0006lN-Sz
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Nov 2015 08:37:26 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZtAcH-000876-2Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Nov 2015 08:37:26 +0000
References: <1445416947-824802-1-git-send-email-aivanov@brocade.com>
	<562D236E.7020108@kot-begemot.co.uk> <562DFC90.9030308@nod.at>
	<5631BB4E.4010301@kot-begemot.co.uk>
	<CAFLxGvwDXWhw+mssT4quUaRC3DFAtRAGksmV-wuYrdzLWZEa0w@mail.gmail.com>
	<1446304232.3238.8.camel@m3y3r.de> <5634DAA4.70308@nod.at>
	<1446304594.3238.11.camel@m3y3r.de> <5634DC7B.3010707@nod.at>
	<56371B6D.3080506@kot-begemot.co.uk>
From: Richard Weinberger <richard@nod.at>
Message-ID: <563720BA.20107@nod.at>
Date: Mon, 2 Nov 2015 09:37:14 +0100
MIME-Version: 1.0
In-Reply-To: <56371B6D.3080506@kot-begemot.co.uk>
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

Hi!

Am 02.11.2015 um 09:14 schrieb Anton Ivanov:
> I was testing under similar conditions (CPU pinning using taskset -c 0 on a multicore).
> 
> I have removed it and run some retests - I cannot reproduce the hang at this point with my config
> 
> I am going to run a defconfig and compare the results to see if this will give me any insights on the root cause.

I can reproduce on both my build machine (8 core) and my laptop (4 core).
If it helps I can share the rootfs.

On my laptop I was able to reproduce within 5 minutes.
1. make defconfig ARCH=um
2. make -j 4 linux ARCH=um
3. ./linux ubda=../Downloads/Debian-Squeeze-AMD64-root_fs mem=1G
4. login to tty0
5. wait a few minutes
6. try to run top, it will hang in nanosleep

Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

