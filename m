Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1YZdhf-0008Tk-5Z
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Mar 2015 11:05:59 +0000
Received: from mout.gmx.net ([212.227.15.15])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YZdhd-00034F-O7
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Mar 2015 11:05:59 +0000
Message-ID: <550EA20E.7000503@gmx.de>
Date: Sun, 22 Mar 2015 12:05:50 +0100
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
References: <54FCBB88.70605@gmx.de>
	<CAFLxGvy8mLg9R9J38uAGFdZA_QdN=qZ3L-_niYoX8+n7GA0+Vg@mail.gmail.com>
	<54FCCFF8.3030209@gmx.de> <54FCD0DB.4060308@nod.at>
	<54FF01F3.5060203@gmx.de> <54FF03DE.1080206@nod.at>
	<54FF09B5.5020707@gmx.de> <54FF1281.7070709@nod.at>
	<54FF2D3B.5090301@gmx.de> <54FF2F89.604@nod.at>
	<54FF36CC.4010401@gmx.de> <54FF3910.8060502@nod.at>
	<54FF3A7A.4010606@gmx.de> <54FF3B6C.9060808@nod.at>
	<54FF3E5D.8040204@gmx.de> <54FF606E.5050109@nod.at>
	<5502E8D5.8040500@gmx.de> <5502F4A4.6070201@nod.at>
	<550564D2.5070103@gmx.de> <55056CA7.1080700@nod.at>
	<55057604.6050308@gmx.de> <55059907.9060408@nod.at>
	<5505B889.4020401@gmx.de> <5505B9A4.8030304@nod.at>
	<5506D945.809@gmx.de> <550DF038.70202@nod.at>
In-Reply-To: <550DF038.70202@nod.at>
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

On 03/21/2015 11:27 PM, Richard Weinberger wrote:
> At least on my PC I can build and run UML with the hardened gcc. But running any UML on a hardened base system (libc) fails badly.

The picture here is the same, gcc isn't the culprit. A vanilla kernel instead of a hardened kernel doesn't help too much too.
Nowadays I do reliable get either a hang or the following at the hardened system, (tomorrow I'll your advices with a grml live cd or something in that direction) : 

...
TCP: cubic registered
NET: Registered protocol family 17
Key type dns_resolver registered
Initialized stdio console driver
Console initialized on /dev/tty0
                                console [tty0] enabled
console [tty0] enabled
                      bootconsole [earlycon0] disabled
bootconsole [earlycon0] disabled
                                Initializing software serial port version 1
console [mc-1] enabled
Netdevice 0 (72:ef:3d:9f:c3:5a) : 
TUN/TAP backend - 
Btrfs loaded
winch_thread : TIOCSCTTY failed on fd 1 err = 1
EXT4-fs (ubda): mounted filesystem with ordered data mode. Opts: (null)
VFS: Mounted root (ext4 filesystem) readonly on device 98:0.
devtmpfs: mounted
Stub registers -
        0 - 0
        1 - 101b7c
        2 - 101afc
        3 - 0
        4 - 0
        5 - 101ae8
        6 - b
        7 - 2b
        8 - 2b
        9 - 0
        10 - 0
        11 - ffffffff
        12 - 1000d9
        13 - 23
        14 - 10206
        15 - 100ad8
        16 - 2b
wait_stub_done : failed to wait for SIGTRAP, pid = 24027, n = 24027, errno = 0, status = 0xb7f
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

CPU: 0 PID: 1 Comm: init Not tainted 4.0.0-rc4-00241-ge477f3e #10
Stack:
 0855d48a 0855d48a 085be547 00000000 84c9be24 84c94000 84c87ac8 084d80f6
 00000000 84c87aa0 84c87af0 084d4165 08568eac 086a4e00 08569048 84c87b00
 84c94000 84c9be24 84c94000 84d6c948 84c87b30 08112ade 08569048 0000000b
Call Trace:
 [<080f2e26>] show_stack+0xd6/0x1a0
 [<084d80f6>] dump_stack+0x26/0x28
 [<084d4165>] panic+0x8f/0x1a9
 [<08112ade>] do_exit+0xa2e/0xa30
 [<08112b59>] do_group_exit+0x39/0xe0
 [<0811bde9>] get_signal+0x199/0x5a0
 [<084dc32c>] ? _raw_spin_unlock_irqrestore+0x1c/0x20
 [<080f29c6>] kern_do_signal+0x46/0x300
 [<0812cbc0>] ? wake_up_state+0x10/0x20
 [<08119f02>] ? signal_wake_up_state+0x22/0x30
 [<0811a56e>] ? __send_signal.constprop.24+0x11e/0x2f0
 [<0810488a>] ? unblock_signals+0x1a/0xa0
 [<08104bb8>] ? set_signals+0x48/0x60
 [<084dc32c>] ? _raw_spin_unlock_irqrestore+0x1c/0x20
 [<0811b004>] ? force_sig_info+0xa4/0xc0
 [<080f2c9a>] do_signal+0x1a/0x20
 [<080f40e5>] fatal_sigsegv+0x25/0x30
 [<0810741b>] wait_stub_done+0xeb/0x130
 [<081074cd>] get_skas_faultinfo.part.1+0x6d/0x100
 [<081075c5>] get_skas_faultinfo+0x65/0x90
 [<0810cecd>] ? get_fp_registers+0x4d/0x60
 [<08107d5a>] userspace+0x55a/0x650
 [<0819d7f4>] ? do_execve+0x24/0x30
 [<080f04fb>] ? run_init_process+0x2b/0x30
 [<080f050f>] ? try_to_run_init_process+0xf/0x40
 [<0812a632>] ? async_synchronize_full+0x22/0x30
 [<084d3cd2>] ? kernel_init+0x92/0xd0
 [<080f1a22>] new_thread_handler+0x82/0x90

/home/tfoerste/workspace/bin/start_uml.sh: line 104: 23974 Aborted                 $STRACE $LINUX earlyprintk ubda=$ROOTFS ubdb=$SWAP eth0=$NET mem=$MEM $TTY umid=uml_$NAME rootfstype=ext4 "$ARGS"
                                                                                            + rc=134
                                                                                                    + rm -f /mnt/ramdisk/trinity_swap
                             + [[ 134 -ne 0 ]]
                                              ++ expr 134 % 128
                                                               + RC=6
                                                                     + reset

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

