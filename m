Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1YXBlC-0000Ik-L7
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 15 Mar 2015 16:51:30 +0000
Received: from mout.gmx.net ([212.227.15.18])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YXBlB-00039g-A6
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 15 Mar 2015 16:51:30 +0000
Message-ID: <5505B889.4020401@gmx.de>
Date: Sun, 15 Mar 2015 17:51:21 +0100
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
In-Reply-To: <55059907.9060408@nod.at>
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

On 03/15/2015 03:36 PM, Richard Weinberger wrote:
> BTW: Just ran a x86 UML with CONFIG_MCORE2=y. Works perfectly fine.

The picture isn't clear.

After twiddling with the kernel config I got a working  .config with CORE2=y. This runs fine if compiled with vanilla gcc 4.8.3.

Compiled with the default (hardened) gcc it hangs as expected. After waiting a long time I do get :

$> /home/tfoerste/devel/linux/linux earlyprintk ubda=/home/tfoerste/virtual/uml/trinity ubdb=/mnt/ramdisk/trinity_swap eth0=tuntap,tap0,72:ef:3d:9f:c3:5a mem=2000M con0=fd:0,fd:1 con=pts umid=uml_trinity rootfstype=ext4 softlockup_all_cpu_backtrace=1
Locating the bottom of the address space ... 0x1000
Locating the top of the address space ... 0xffffd000
Core dump limits :
        soft - 0
        hard - NONE
...
device-mapper: ioctl: 4.30.0-ioctl (2014-12-22) initialised: dm-devel@redhat.com
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
wait_stub_done : failed to wait for SIGTRAP, pid = 1420, n = 1420, errno = 0, status = 0xb7f
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

CPU: 0 PID: 1 Comm: init Not tainted 4.0.0-rc3-00222-g7cd9beb3 #3
Stack:
 0854eca5 0854eca5 085ae547 00000000 84c9fe24 84eb1c38 84c8bad0 084c9933
 00000000 84c8baa8 84c8baf8 084c61c0 0855b150 0868f580 0855b2ec 84c8bb08
 0810329a 84c9fe24 84eb1c38 84c98000 84c8bb38 08111881 0855b2ec 0000000b
Call Trace:
 [<080ef8c6>] show_stack+0xd6/0x1a0
 [<084c9933>] dump_stack+0x26/0x28
 [<084c61c0>] panic+0x7a/0x194
 [<0810329a>] ? unblock_signals+0x1a/0xa0
 [<08111881>] do_exit+0x9d1/0x9e0
 [<08117ee5>] ? recalc_sigpending+0x15/0x50
 [<08111907>] do_group_exit+0x37/0xc0
 [<0811a46b>] get_signal+0x18b/0x570
 [<08103599>] ? set_signals+0x19/0x60
 [<080ef466>] kern_do_signal+0x46/0x300
 [<0812ab00>] ? wake_up_state+0x10/0x20
 [<08118782>] ? signal_wake_up_state+0x22/0x30
 [<08118dcd>] ? __send_signal.constprop.29+0xfd/0x2b0
 [<081387f5>] ? vprintk_emit+0x205/0x450
 [<0810329a>] ? unblock_signals+0x1a/0xa0
 [<081035c8>] ? set_signals+0x48/0x60
 [<081197a5>] ? force_sig_info+0x95/0xb0
 [<080ef73a>] do_signal+0x1a/0x20
 [<080f0b85>] fatal_sigsegv+0x25/0x30
 [<0810678b>] wait_stub_done+0xeb/0x130
 [<0810683d>] get_skas_faultinfo.part.1+0x6d/0x100
 [<08106935>] get_skas_faultinfo+0x65/0x90
 [<0810c20d>] ? get_fp_registers+0x4d/0x60
 [<081070ca>] userspace+0x55a/0x650
 [<08199c54>] ? do_execve+0x24/0x30
 [<080ed01b>] ? run_init_process+0x2b/0x30
 [<080ed02f>] ? try_to_run_init_process+0xf/0x40
 [<08128652>] ? async_synchronize_full+0x22/0x30
 [<084c5d32>] ? kernel_init+0x92/0xd0
 [<080ee512>] new_thread_handler+0x82/0x90

/home/tfoerste/workspace/bin/start_uml.sh: line 104:  1351 Aborted                 $STRACE $LINUX earlyprintk ubda=$ROOTFS ubdb=$SWAP eth0=$NET mem=$MEM $TTY umid=uml_$NAME rootfstype=ext4 "$ARGS"



FWIW Gentoo give us the choice :

$ gcc-config  -l
 [1] x86_64-pc-linux-gnu-4.8.3 *
 [2] x86_64-pc-linux-gnu-4.8.3-hardenednopie
 [3] x86_64-pc-linux-gnu-4.8.3-hardenednopiessp
 [4] x86_64-pc-linux-gnu-4.8.3-hardenednossp
 [5] x86_64-pc-linux-gnu-4.8.3-vanilla


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

