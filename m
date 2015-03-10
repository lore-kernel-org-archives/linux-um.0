Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1YVOpK-0004XT-VB
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Mar 2015 18:24:22 +0000
Received: from mout.gmx.net ([212.227.17.21])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YVOpJ-0002CW-R1
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Mar 2015 18:24:22 +0000
Message-ID: <54FF36CC.4010401@gmx.de>
Date: Tue, 10 Mar 2015 19:24:12 +0100
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
References: <54FCBB88.70605@gmx.de>
	<CAFLxGvy8mLg9R9J38uAGFdZA_QdN=qZ3L-_niYoX8+n7GA0+Vg@mail.gmail.com>
	<54FCCFF8.3030209@gmx.de> <54FCD0DB.4060308@nod.at>
	<54FF01F3.5060203@gmx.de> <54FF03DE.1080206@nod.at>
	<54FF09B5.5020707@gmx.de> <54FF1281.7070709@nod.at>
	<54FF2D3B.5090301@gmx.de> <54FF2F89.604@nod.at>
In-Reply-To: <54FF2F89.604@nod.at>
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
Subject: Re: [uml-devel] starting an 32 bit x86 chroot uml image at a
 ahrdened Gentoo amd64 system fails
To: Richard Weinberger <richard@nod.at>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>

On 03/10/2015 06:53 PM, Richard Weinberger wrote:
> What is addr2line -e linux 0000000060250c0e?

$ addr2line -e linux 0000000060250c0e
/home/tfoerste/devel/linux/include/linux/skbuff.h:1502

$ addr2line -e linux 0000000060238a01
/home/tfoerste/devel/linux/net/ipv4/tcp_output.c:1919


The command line is:
$> /home/tfoerste/devel/linux/linux earlyprintk ubda=/home/tfoerste/virtual/uml/trinity ubdb=/mnt/ramdisk/trinity_swap eth0=tuntap,tap0,72:ef:3d:9f:c3:5a mem=1000M con0=fd:0,fd:1 con=pts umid=uml_trinity rootfstype=ext4 softlockup_all_cpu_backtrace=1

but a simple 
$>  /home/tfoerste/devel/linux/linux ubda=/home/tfoerste/virtual/uml/trinity
is enough too to get the issue.

What let me wonder is that I can't reproduce the RIP from the first email in moment. However now I do get reproducible a RIP of 00007fc6487765fb and 000000006001b011 respectively :

$ addr2line -e linux 00007fc6487765fb
??:0
$ addr2line -e linux 000000006001b011
/home/tfoerste/devel/linux/arch/um/kernel/sysrq.c:56



-- 
Toralf
pgp key: 7B1A 07F4 EC82 0F90 D4C2  8936 872A E508 0076 E94E


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

