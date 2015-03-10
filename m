Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1YVOBs-0002Kh-3T
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Mar 2015 17:43:36 +0000
Received: from mout.gmx.net ([212.227.15.18])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YVOBm-0008Cw-H8
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Mar 2015 17:43:36 +0000
Message-ID: <54FF2D3B.5090301@gmx.de>
Date: Tue, 10 Mar 2015 18:43:23 +0100
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
References: <54FCBB88.70605@gmx.de>
	<CAFLxGvy8mLg9R9J38uAGFdZA_QdN=qZ3L-_niYoX8+n7GA0+Vg@mail.gmail.com>
	<54FCCFF8.3030209@gmx.de> <54FCD0DB.4060308@nod.at>
	<54FF01F3.5060203@gmx.de> <54FF03DE.1080206@nod.at>
	<54FF09B5.5020707@gmx.de> <54FF1281.7070709@nod.at>
In-Reply-To: <54FF1281.7070709@nod.at>
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

On 03/10/2015 04:49 PM, Richard Weinberger wrote:
> Then just reboot into a pristine kernel and retest. :-)

With latest host vanilla 4.0.0-rc3 kernel I get a similar picture:

TUN/TAP backend - 
winch_thread : TIOCSCTTY failed on fd 1 err = 1
EXT4-fs (ubda): mounted filesystem with ordered data mode. Opts: (null)
VFS: Mounted root (ext4 filesystem) readonly on device 98:0.
devtmpfs: mounted

Modules linked in:
Pid: 1, comm: swapper Not tainted 4.0.0-rc3-00111-gaffb817
RIP: 0033:[<0000000060250c0e>]
RSP: 00007f4710704f08  EFLAGS: 00010202
RAX: 0000000060250bfc RBX: 00000000606069c8 RCX: 00007f471002cb99
RDX: 00000000602356a0 RSI: 00007f4710705fe8 RDI: 00000000a013c000
RBP: 00007f4710705fe8 R08: 0000000000000000 R09: 0000000000000000
R10: 000000009fc19778 R11: 0000000000000246 R12: 00000000a013c000
R13: 00007f4710705000 R14: 0000000060235bb0 R15: 00000000602d981b
Kernel panic - not syncing: Segfault with no mm
CPU: 0 PID: 1 Comm: swapper Not tainted 4.0.0-rc3-00111-gaffb817 #1
Stack:

Modules linked in:
Pid: 1, comm: swapper Not tainted 4.0.0-rc3-00111-gaffb817
RIP: 0033:[<0000000060238a01>]
RSP: 0000000060573450  EFLAGS: 00010202
RAX: 0000000000000006 RBX: 000000006049c50e RCX: 00000000606069c8
RDX: 0000000000000000 RSI: 0000000060615338 RDI: 0000000000000000
RBP: 0000000060573480 R08: 0000000060573059 R09: 000000006027eb1f
R10: 0000000000000008 R11: 00000000003b9089 R12: 00007f4710704f0f
R13: 0000000000000001 R14: 00000000605736f0 R15: 0000000000000001
Kernel panic - not syncing: Segfault with no mm


And I tried the vanilla gcc too instead of the hardened gcc, but no successs :


tfoerste@t44 ~/devel/linux $ sudo gcc-config -l
 [1] x86_64-pc-linux-gnu-4.8.3
 [2] x86_64-pc-linux-gnu-4.8.3-hardenednopie
 [3] x86_64-pc-linux-gnu-4.8.3-hardenednopiessp
 [4] x86_64-pc-linux-gnu-4.8.3-hardenednossp
 [5] x86_64-pc-linux-gnu-4.8.3-vanilla *


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

