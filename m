Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1YVP4X-00059z-U0
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Mar 2015 18:40:07 +0000
Received: from mout.gmx.net ([212.227.17.20])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YVP4V-0007sB-VS
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Mar 2015 18:40:05 +0000
Message-ID: <54FF3A7A.4010606@gmx.de>
Date: Tue, 10 Mar 2015 19:39:54 +0100
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
References: <54FCBB88.70605@gmx.de>
	<CAFLxGvy8mLg9R9J38uAGFdZA_QdN=qZ3L-_niYoX8+n7GA0+Vg@mail.gmail.com>
	<54FCCFF8.3030209@gmx.de> <54FCD0DB.4060308@nod.at>
	<54FF01F3.5060203@gmx.de> <54FF03DE.1080206@nod.at>
	<54FF09B5.5020707@gmx.de> <54FF1281.7070709@nod.at>
	<54FF2D3B.5090301@gmx.de> <54FF2F89.604@nod.at>
	<54FF36CC.4010401@gmx.de> <54FF3910.8060502@nod.at>
In-Reply-To: <54FF3910.8060502@nod.at>
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

On 03/10/2015 07:33 PM, Richard Weinberger wrote:
> So you see *random* crashes?
yes, the 1st RIP is varying, just the 2nd stays at 000000006001b011

Modules linked in:
Pid: 1, comm: swapper Not tainted 4.0.0-rc3-00111-gaffb817
RIP: 0033:[<00007fcd777905fb>]
RSP: 00007fcd77e6fef8  EFLAGS: 00010202
RAX: 0000000000000000 RBX: 0000000063562000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007fcd77e70f18 R08: 0000000060018090 R09: 0000000000000000
R10: 0000000062cbbd00 R11: 0000000000000246 R12: 0000000060018140
R13: 00000000600181e0 R14: 0000000062cbbd00 R15: 00000000600b7afd
Kernel panic - not syncing: Segfault with no mm
CPU: 0 PID: 1 Comm: swapper Not tainted 4.0.0-rc3-00111-gaffb817 #2
Stack:

Modules linked in:
Pid: 1, comm: swapper Not tainted 4.0.0-rc3-00111-gaffb817
RIP: 0033:[<000000006001b011>]
RSP: 000000006034f480  EFLAGS: 00010202
RAX: 0000000000000006 RBX: 000000006027a279 RCX: 00000000603f55a0
RDX: 0000000000000000 RSI: 00000000603f08b8 RDI: 0000000000000000
RBP: 000000006034f4b0 R08: 000000006034f089 R09: 000000006005ce01
R10: 0000000000000008 R11: 0000000000000206 R12: 00007fcd77e6feff
R13: 0000000000000001 R14: 000000006034f710 R15: 000000006034fb01
Kernel panic - not syncing: Segfault with no mm


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

