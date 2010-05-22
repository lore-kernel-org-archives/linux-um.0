Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <toralf.foerster@gmx.de>) id 1OFqkM-00065f-N7
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 May 2010 15:36:18 +0000
Received: from mail.gmx.net ([213.165.64.20])
	by sfi-mx-1.v28.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1OFqkL-0003HA-3z for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 May 2010 15:36:18 +0000
From: Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>
Date: Sat, 22 May 2010 17:36:08 +0200
MIME-Version: 1.0
Message-Id: <201005221736.08950.toralf.foerster@gmx.de>
Subject: [uml-devel] kernel crash with 2.6.34-07097-gf4b87de
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

Well,

probably too early b/c the merge window is open yet but anyway:
here's the what happend at a ThinkPad T400 running a vanilla 2.6.34 kernel =
as =

the host system at an almost stable Gentoo:

tfoerste@n22 ~ $ start_uml.sh ~/devel/linux-2.6/linux =

Locating the bottom of the address space ... 0x1000
Locating the top of the address space ... 0xc0000000
Core dump limits :
        soft - NONE
        hard - NONE
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...OK
Checking advanced syscall emulation patch for ptrace...OK
Checking for tmpfs mount on /dev/shm...OK
Checking PROT_EXEC mmap in /dev/shm/...OK
Checking for the skas3 patch in the host:
  - /proc/mm...not found: No such file or directory
  - PTRACE_FAULTINFO...not found
  - PTRACE_LDT...not found
UML running in SKAS0 mode
Adding 31469568 bytes to physical memory to account for exec-shield gap
Linux version 2.6.34-07097-gf4b87de (tfoerste@n22) (gcc version 4.3.4 (Gent=
oo =

4.3.4 p1.1, pie-10.1.5) ) #1 Sat May 22 10:53:57 CEST 2010
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 72646
Kernel command line: ubda=3D/home/tfoerste/virtual/uml/gentoo_root_fs =

ubdb=3D/home/tfoerste/virtual/uml/swap_fs eth0=3Dtuntap,,,192.168.0.253 mem=
=3D256M =

root=3D98:0
PID hash table entries: 2048 (order: 1, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 254080k available
Hierarchical RCU implementation.
        RCU-based detection of stalled CPUs is disabled.
        Verbose stalled-CPUs detection is disabled.
NR_IRQS:15
Calibrating delay loop... 4757.91 BogoMIPS (lpj=3D23789568)
Mount-cache hash table entries: 512
Checking for host processor cmov support...Yes
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
Using 2.6 host AIO
NET: Registered protocol family 16
bio: create slab <bio-0> at 0
Switching to clocksource itimer
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
mconsole (version 2) initialized on /home/tfoerste/.uml/tfoerste/mconsole
Checking host MADV_REMOVE support...OK
UML Audio Relay (host dsp =3D /dev/sound/dsp, host mixer =3D /dev/sound/mix=
er)
Host TLS support detected
Detected host type: i386 (GDT indexes 6 to 9)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
msgmni has been set to 496
alg: No test for stdrng (krng)
io scheduler noop registered
io scheduler cfq registered (default)
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
TCP cubic registered
NET: Registered protocol family 17
Initialized stdio console driver
Console initialized on /dev/tty0
console [tty0] enabled
Initializing software serial port version 1
console [mc-1] enabled
 ubda: unknown partition table
 ubdb: unknown partition table
Choosing a random ethernet address for device eth0
Netdevice 0 (d2:93:b9:8b:87:20) : =

TUN/TAP backend - IP =3D 192.168.0.253

EIP: 0073:[<081c96d3>] CPU: 0 Not tainted ESP: 007b:08305b3c EFLAGS: 000102=
93
    Not tainted
EAX: 00000001 EBX: 198cd000 ECX: 00000000 EDX: 00000001
ESI: 199e3930 EDI: 199e3930 EBP: 199e3930 DS: 007b ES: 007b
08305708:  [<0805f732>] segv_handler+0x52/0xe0
08305718:  [<081c96d3>] cfq_close_cooperator+0x53/0x180
083057b0:  [<080700e5>] sig_handler_common+0x55/0xa0
083057f0:  [<081c96d3>] cfq_close_cooperator+0x53/0x180
08305828:  [<08070282>] sig_handler+0x22/0x40
08305830:  [<080704fd>] handle_signal+0x5d/0xa0
08305850:  [<080728e7>] hard_handler+0x17/0x20
0830589c:  [<081c96d3>] cfq_close_cooperator+0x53/0x180
08305a38:  [<0807a35e>] enqueue_task_fair+0xbe/0x190
08305a60:  [<0807b355>] enqueue_task+0x45/0x60
08305a80:  [<0807b38f>] activate_task+0x1f/0x30
08305a8c:  [<0807b8b7>] try_to_wake_up+0x67/0xa0
08305ab8:  [<0809515f>] autoremove_wake_function+0x2f/0x60
08305ad4:  [<080797da>] __wake_up_common+0x4a/0x70
08305b00:  [<08079ab5>] __wake_up+0x45/0x60
08305b24:  [<080950bb>] __wake_up_bit+0x3b/0x40
08305b38:  [<081c96ce>] cfq_close_cooperator+0x4e/0x180
08305b40:  [<08095123>] wake_up_bit+0x63/0x70
08305b54:  [<081c9b3b>] cfq_completed_request+0x2ab/0x550
08305b64:  [<081d7837>] mix_pool_bytes_extract+0x57/0x170
08305b90:  [<081bc40b>] elv_completed_request+0x7b/0xe0
08305ba8:  [<081bdd19>] __blk_put_request+0x29/0xd0
08305bc0:  [<081bdf20>] blk_finish_request+0x160/0x1b0
08305be0:  [<081be28f>] blk_end_bidi_request+0x3f/0x60
08305bf4:  [<0806a0dd>] ubd_intr+0x2d/0xf0
08305c14:  [<080a8452>] handle_IRQ_event+0x32/0xd0
08305c34:  [<080a854b>] __do_IRQ+0x5b/0xb0
08305c50:  [<0805c414>] do_IRQ+0x24/0x40
08305c5c:  [<0805c663>] sigio_handler+0x63/0x80
08305c70:  [<080700e5>] sig_handler_common+0x55/0xa0
08305c80:  [<080701d5>] real_alarm_handler+0x35/0x40
08305cbc:  [<0805768d>] calibrate_delay+0x106/0x179
08305ce8:  [<08070282>] sig_handler+0x22/0x40
08305cf0:  [<080704fd>] handle_signal+0x5d/0xa0
08305d10:  [<080728e7>] hard_handler+0x17/0x20

Kernel panic - not syncing: Segfault with no mm
08305640:  [<082863ad>] panic+0x4d/0xc6
08305658:  [<0805f6ca>] segv+0x2aa/0x2c0
08305708:  [<0805f732>] segv_handler+0x52/0xe0
08305718:  [<081c96d3>] cfq_close_cooperator+0x53/0x180
083057b0:  [<080700e5>] sig_handler_common+0x55/0xa0
083057f0:  [<081c96d3>] cfq_close_cooperator+0x53/0x180
08305828:  [<08070282>] sig_handler+0x22/0x40
08305830:  [<080704fd>] handle_signal+0x5d/0xa0
08305850:  [<080728e7>] hard_handler+0x17/0x20
0830589c:  [<081c96d3>] cfq_close_cooperator+0x53/0x180
08305a38:  [<0807a35e>] enqueue_task_fair+0xbe/0x190
08305a60:  [<0807b355>] enqueue_task+0x45/0x60
08305a80:  [<0807b38f>] activate_task+0x1f/0x30
08305a8c:  [<0807b8b7>] try_to_wake_up+0x67/0xa0
08305ab8:  [<0809515f>] autoremove_wake_function+0x2f/0x60
08305ad4:  [<080797da>] __wake_up_common+0x4a/0x70
08305b00:  [<08079ab5>] __wake_up+0x45/0x60
08305b24:  [<080950bb>] __wake_up_bit+0x3b/0x40
08305b38:  [<081c96ce>] cfq_close_cooperator+0x4e/0x180
08305b40:  [<08095123>] wake_up_bit+0x63/0x70
08305b54:  [<081c9b3b>] cfq_completed_request+0x2ab/0x550
08305b64:  [<081d7837>] mix_pool_bytes_extract+0x57/0x170
08305b90:  [<081bc40b>] elv_completed_request+0x7b/0xe0
08305ba8:  [<081bdd19>] __blk_put_request+0x29/0xd0
08305bc0:  [<081bdf20>] blk_finish_request+0x160/0x1b0
08305be0:  [<081be28f>] blk_end_bidi_request+0x3f/0x60
08305bf4:  [<0806a0dd>] ubd_intr+0x2d/0xf0
08305c14:  [<080a8452>] handle_IRQ_event+0x32/0xd0
08305c34:  [<080a854b>] __do_IRQ+0x5b/0xb0
08305c50:  [<0805c414>] do_IRQ+0x24/0x40
08305c5c:  [<0805c663>] sigio_handler+0x63/0x80
08305c70:  [<080700e5>] sig_handler_common+0x55/0xa0
08305c80:  [<080701d5>] real_alarm_handler+0x35/0x40
08305cbc:  [<0805768d>] calibrate_delay+0x106/0x179
08305ce8:  [<08070282>] sig_handler+0x22/0x40
08305cf0:  [<080704fd>] handle_signal+0x5d/0xa0
08305d10:  [<080728e7>] hard_handler+0x17/0x20


EIP: 0000:[<00000000>] CPU: 0 Not tainted EFLAGS: 00000000
    Not tainted
EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
ESI: 00000000 EDI: 00000000 EBP: 00000000 DS: 0000 ES: 0000
0830561c:  [<0809a224>] notifier_call_chain+0x34/0x70
08305640:  [<082863d5>] panic+0x75/0xc6
08305658:  [<0805f6ca>] segv+0x2aa/0x2c0
08305708:  [<0805f732>] segv_handler+0x52/0xe0
08305718:  [<081c96d3>] cfq_close_cooperator+0x53/0x180
083057b0:  [<080700e5>] sig_handler_common+0x55/0xa0
083057f0:  [<081c96d3>] cfq_close_cooperator+0x53/0x180
08305828:  [<08070282>] sig_handler+0x22/0x40
08305830:  [<080704fd>] handle_signal+0x5d/0xa0
08305850:  [<080728e7>] hard_handler+0x17/0x20
0830589c:  [<081c96d3>] cfq_close_cooperator+0x53/0x180
08305a38:  [<0807a35e>] enqueue_task_fair+0xbe/0x190
08305a60:  [<0807b355>] enqueue_task+0x45/0x60
08305a80:  [<0807b38f>] activate_task+0x1f/0x30
08305a8c:  [<0807b8b7>] try_to_wake_up+0x67/0xa0
08305ab8:  [<0809515f>] autoremove_wake_function+0x2f/0x60
08305ad4:  [<080797da>] __wake_up_common+0x4a/0x70
08305b00:  [<08079ab5>] __wake_up+0x45/0x60
08305b24:  [<080950bb>] __wake_up_bit+0x3b/0x40
08305b38:  [<081c96ce>] cfq_close_cooperator+0x4e/0x180
08305b40:  [<08095123>] wake_up_bit+0x63/0x70
08305b54:  [<081c9b3b>] cfq_completed_request+0x2ab/0x550
08305b64:  [<081d7837>] mix_pool_bytes_extract+0x57/0x170
08305b90:  [<081bc40b>] elv_completed_request+0x7b/0xe0
08305ba8:  [<081bdd19>] __blk_put_request+0x29/0xd0
08305bc0:  [<081bdf20>] blk_finish_request+0x160/0x1b0
08305be0:  [<081be28f>] blk_end_bidi_request+0x3f/0x60
08305bf4:  [<0806a0dd>] ubd_intr+0x2d/0xf0
08305c14:  [<080a8452>] handle_IRQ_event+0x32/0xd0
08305c34:  [<080a854b>] __do_IRQ+0x5b/0xb0
08305c50:  [<0805c414>] do_IRQ+0x24/0x40
08305c5c:  [<0805c663>] sigio_handler+0x63/0x80
08305c70:  [<080700e5>] sig_handler_common+0x55/0xa0
08305c80:  [<080701d5>] real_alarm_handler+0x35/0x40
08305cbc:  [<0805768d>] calibrate_delay+0x106/0x179
08305ce8:  [<08070282>] sig_handler+0x22/0x40
08305cf0:  [<080704fd>] handle_signal+0x5d/0xa0
08305d10:  [<080728e7>] hard_handler+0x17/0x20

Terminated

-- =

MfG/Sincerely
Toralf F=F6rster

pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3


---------------------------------------------------------------------------=
---

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

