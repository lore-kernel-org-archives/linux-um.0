Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G4D8H-00079K-FP for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 Jul 2006 01:46:45 -0700
Received: from courier.cs.helsinki.fi ([128.214.9.1] helo=mail.cs.helsinki.fi)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G4D8F-0002I6-AT
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 Jul 2006 01:46:45 -0700
From: Pekka Enberg <penberg@cs.helsinki.fi>
Date: Sat, 22 Jul 2006 11:46:37 +0300
Message-Id: <1153557998.5589.20.camel@ubuntu>
Mime-Version: 1.0
Subject: [uml-devel] UML hangs after forking gettys
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: jdike@addtoit.com, blaisorblade@yahoo.it
Cc: user-mode-linux-devel@lists.sourceforge.net

Hi,

I have a problem with UML compiled from 2.6.18-rc2 git head. The kernel
boots fine and starts up the userspace but hangs completely after
forking gettys. I have port-helper in /usr/lib/uml but it doesn't seem
to start up.

The host is Ubuntu Dapper Drake running on Intel Core Duo.

				Pekka

penberg@ubuntu:~/src/linux/2.6$ ./linux ubd0=/home/penberg/uml-debian/root_fs_woody umid=debian
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...OK
Checking advanced syscall emulation patch for ptrace...OK
Checking for tmpfs mount on /dev/shm...OK
Checking PROT_EXEC mmap in /dev/shm/...OK
Checking for the skas3 patch in the host:
  - /proc/mm...not found
  - PTRACE_FAULTINFO...not found
  - PTRACE_LDT...not found
UML running in SKAS0 mode
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...OK
Checking advanced syscall emulation patch for ptrace...OK
Linux version 2.6.18-rc2-dirty (penberg@ubuntu) (gcc version 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #4 Sat Jul 22 11:35:03 EEST 2006
Built 1 zonelists.  Total pages: 8192
Kernel command line: ubd0=/home/penberg/uml-debian/root_fs_woody root=98:0
PID hash table entries: 256 (order: 8, 1024 bytes)
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 30552k available
Mount-cache hash table entries: 512
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
Using 2.6 host AIO
NET: Registered protocol family 16
NET: Registered protocol family 2
IP route cache hash table entries: 256 (order: -2, 1024 bytes)
TCP established hash table entries: 1024 (order: 0, 4096 bytes)
TCP bind hash table entries: 512 (order: -1, 2048 bytes)
TCP: Hash tables configured (established 1024 bind 512)
TCP reno registered
Checking host MADV_REMOVE support...OK
mconsole (version 2) initialized on /home/penberg/.uml/debian/mconsole
Host TLS support detected
Detected host type: i386
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Initialized stdio console driver
Console initialized on /dev/tty0
Initializing software serial port version 1
 ubda: unknown partition table
VFS: Mounted root (ext2 filesystem) readonly.
line_ioctl: tty0: ioctl KDSIGACCEPT called
INIT: version 2.84 booting
Activating swap.
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
System time was Sat Jul 22 08:37:28 UTC 2006.
Setting the System Clock using the Hardware Clock as reference...
hwclock is unable to get I/O port access:  the iopl(3) call failed.
System Clock set. System local time is now Sat Jul 22 08:37:28 UTC 2006.
Calculating module dependencies... depmod: QM_MODULES: Function not implemented

done.
Loading modules:
modprobe: Can't open dependencies file /lib/modules/2.6.18-rc2-dirty/modules.dep (No such file or directory)
Checking all file systems...
fsck 1.27 (8-Mar-2002)
Setting kernel variables.
Loading the saved-state of the serial devices...
Mounting local filesystems...
nothing was mounted
Running 0dns-down to make sure resolv.conf is ok...done.
Setting up IP spoofing protection: rp_filter.
Configuring network interfaces: done.

Setting the System Clock using the Hardware Clock as reference...
hwclock is unable to get I/O port access:  the iopl(3) call failed.
System Clock set. Local time: Sat Jul 22 08:37:30 UTC 2006

Cleaning: /tmp /var/lock /var/run.
Initializing random number generator... done.
Recovering nvi editor sessions... done.
INIT: Entering runlevel: 2
Starting system log daemon: syslogd.
Starting kernel log daemon: klogd.
Starting internet superserver: inetd.
Starting PCMCIA services: module directory /lib/modules/2.6.18-rc2-dirty/pcmcia not found.
Starting deferred execution scheduler: atd.
Starting periodic command scheduler: cron.


penberg@ubuntu:~/src/tools/mconsole$ ./uml_mconsole debian
(debian) sysrq t
OK SysRq : Show State

                                               sibling
  task             PC      pid father child younger older
init          S 400E07CE     0     1      0     2               (NOTLB)
00000001 0817fb14 00000000 087fb6f8 08180f80 08895640 087fb804 087fb6ec
       080680c7 00000000 081adf00 087fb73c 081adf00 08948780 00000000 087fb74c
       087fb77c 087fb740 00005401 b7f29bf0 ffffffff 087879d4 00000001 00000000 Call Trace:
087fb70c:  [<080680c7>] switch_threads+0x2d/0x4e
087fb750:  [<08080012>] autoremove_wake_function+0x18/0x3a
087fb764:  [<0807730f>] lock_timer_base+0x1e/0x35
087fb784:  [<0806977e>] arch_switch_to_skas+0xd/0x39
087fb790:  [<080596c9>] switch_to_skas+0x4d/0x6a
087fb798:  [<080596b5>] switch_to_skas+0x39/0x6a
087fb7ac:  [<08056db5>] _switch_to+0x37/0x70
087fb7c8:  [<08147cd3>] schedule+0x3fd/0x46a
087fb808:  [<081483f8>] schedule_timeout+0x79/0x99
087fb820:  [<08077fbc>] process_timeout+0x0/0x9
087fb83c:  [<080b1e3c>] do_select+0x300/0x377
087fb884:  [<080b1a0a>] __pollwait+0x0/0x4e
087fb8a0:  [<0806c5cc>] default_wake_function+0x0/0x12
087fb8e8:  [<08059cd9>] maybe_map+0x25/0x85
087fb924:  [<08059e20>] do_buffer_op+0x93/0x13d
087fb934:  [<08059f1c>] copy_chunk_from_user+0x0/0x27
087fb940:  [<08059f1c>] copy_chunk_from_user+0x0/0x27
087fb95c:  [<08059cd9>] maybe_map+0x25/0x85
087fb980:  [<08059d55>] do_op_one_page+0x1c/0x54
087fb998:  [<08059e20>] do_buffer_op+0x93/0x13d
087fb9a8:  [<08059f1c>] copy_chunk_from_user+0x0/0x27
087fb9b4:  [<08059f1c>] copy_chunk_from_user+0x0/0x27
087fb9d4:  [<0806679f>] setjmp_wrapper+0x3d/0x4a
087fb9f4:  [<08066775>] setjmp_wrapper+0x13/0x4a
087fba0c:  [<08059d55>] do_op_one_page+0x1c/0x54
087fba10:  [<0804deee>] free_all_bootmem_core+0x36/0x188
087fba18:  [<0804deee>] free_all_bootmem_core+0x36/0x188
087fba28:  [<08059cd9>] maybe_map+0x25/0x85
087fba4c:  [<08059d55>] do_op_one_page+0x1c/0x54
087fba74:  [<08059fcd>] copy_chunk_to_user+0x0/0x27
087fba84:  [<08059ef3>] buffer_op+0x29/0x52
087fba88:  [<08059d8d>] do_buffer_op+0x0/0x13d
087fba98:  [<08059f1c>] copy_chunk_from_user+0x0/0x27
087fbab4:  [<08059fc2>] copy_from_user_skas+0x7f/0x8a
087fbad8:  [<080b20b7>] core_sys_select+0x204/0x2d4
087fbb24:  [<0806679f>] setjmp_wrapper+0x3d/0x4a
087fbb44:  [<08066775>] setjmp_wrapper+0x13/0x4a
087fbb54:  [<08059d8d>] do_buffer_op+0x0/0x13d
087fbb64:  [<08059fcd>] copy_chunk_to_user+0x0/0x27
087fbb80:  [<0805a058>] copy_to_user_skas+0x64/0x6f
087fbb90:  [<08059fcd>] copy_chunk_to_user+0x0/0x27
087fbb9c:  [<0804deee>] free_all_bootmem_core+0x36/0x188
087fbba4:  [<080a9f14>] cp_new_stat64+0xf0/0x100
087fbbd4:  [<08059ef3>] buffer_op+0x29/0x52
087fbbd8:  [<08059d8d>] do_buffer_op+0x0/0x13d
087fbbe8:  [<08059f1c>] copy_chunk_from_user+0x0/0x27
087fbc20:  [<080b221e>] sys_select+0x97/0x168
087fbc74:  [<08059ae4>] handle_syscall+0x90/0xa8
087fbc90:  [<080b2187>] sys_select+0x0/0x168
087fbcc0:  [<08067f8d>] userspace+0x1fe/0x242
087fbcfc:  [<08055389>] init+0x0/0x10f
087fbd04:  [<0805977e>] new_thread_handler+0x98/0xa5

ksoftirqd/0   S 400E07CE     0     2      1             3       (L-TLB)
00000001 0817fb14 00000000 087ffb10 08180f80 08895040 087ffc1c 087ffb04
       080680c7 00000000 087fc000 09d8d620 09db4000 08800900 0809f0f3 0809ffd1
       09d8d620 088a6620 088a6abc 09d8d620 0809fd1d 00000000 09d8d620 00000004 Call Trace:
087ffb24:  [<080680c7>] switch_threads+0x2d/0x4e
087ffb3c:  [<0809f0f3>] slab_destroy+0x3c/0x5b
087ffb40:  [<0809ffd1>] kmem_cache_free+0x70/0xa1
087ffb54:  [<0809fd1d>] free_block+0xb2/0xef
087ffb78:  [<0809fdcc>] cache_flusharray+0x72/0x7a
087ffb94:  [<0809ffd1>] kmem_cache_free+0x70/0xa1
087ffb9c:  [<0806977e>] arch_switch_to_skas+0xd/0x39
087ffba8:  [<080596c9>] switch_to_skas+0x4d/0x6a
087ffbb0:  [<080596b5>] switch_to_skas+0x39/0x6a
087ffbc4:  [<08056db5>] _switch_to+0x37/0x70
087ffbe0:  [<08147cd3>] schedule+0x3fd/0x46a
087ffc08:  [<080656b9>] set_signals+0x18/0x28
087ffc1c:  [<0807436e>] ksoftirqd+0x0/0x9a
087ffc20:  [<080743af>] ksoftirqd+0x41/0x9a
087ffc2c:  [<0807fc93>] kthread+0x74/0x9a
087ffc48:  [<0807fc1f>] kthread+0x0/0x9a
087ffc50:  [<08064db6>] run_kernel_thread+0x43/0x4d
087ffc64:  [<0807fc1f>] kthread+0x0/0x9a
087ffc70:  [<08064d95>] run_kernel_thread+0x22/0x4d
087ffce8:  [<0806c0c5>] schedule_tail+0x23/0xb5
087ffcfc:  [<08059763>] new_thread_handler+0x7d/0xa5
087ffd00:  [<0807fc1f>] kthread+0x0/0x9a

events/0      S 400E07CE     0     3      1             4     2 (L-TLB)
00000001 0817fb14 00000000 081e7ad8 08180f80 087f2660 081e7be4 081e7acc
       080680c7 00000000 00000004 00000001 00000018 00000001 00000001 00000004
       08851780 00000002 0808d9cf 081871e0 00000001 081e7b28 00000002 081e7b28 Call Trace:
081e7aec:  [<080680c7>] switch_threads+0x2d/0x4e
081e7b14:  [<0808d9cf>] free_one_page+0x28/0x2c
081e7b30:  [<0808da90>] __free_pages_ok+0xbd/0xd4
081e7b50:  [<080656b9>] set_signals+0x18/0x28
081e7b54:  [<0809fcfb>] free_block+0x90/0xef
081e7b70:  [<080a0373>] drain_array+0x84/0x97
081e7b78:  [<080596b5>] switch_to_skas+0x39/0x6a
081e7b8c:  [<08056db5>] _switch_to+0x37/0x70
081e7ba8:  [<08147cd3>] schedule+0x3fd/0x46a
081e7be4:  [<0807d57a>] worker_thread+0x0/0x134
081e7be8:  [<0807d645>] worker_thread+0xcb/0x134
081e7c08:  [<0806c5cc>] default_wake_function+0x0/0x12
081e7c2c:  [<0807fc93>] kthread+0x74/0x9a
081e7c48:  [<0807fc1f>] kthread+0x0/0x9a
081e7c50:  [<08064db6>] run_kernel_thread+0x43/0x4d
081e7c64:  [<0807fc1f>] kthread+0x0/0x9a
081e7c70:  [<08064d95>] run_kernel_thread+0x22/0x4d
081e7ce8:  [<0806c0c5>] schedule_tail+0x23/0xb5
081e7cfc:  [<08059763>] new_thread_handler+0x7d/0xa5
081e7d00:  [<0807fc1f>] kthread+0x0/0x9a

khelper       S 400E07CE     0     4      1             5     3 (L-TLB)
00000001 087fb85c 00000000 087f7ad8 08895640 087f2060 087f7be4 087f7acc
       080680c7 00000000 087f2060 08180640 08147ced 087f2060 09dc8880 087f2060
       00000000 087f2060 081adf00 08895640 087f7b34 0806bc6b 08895640 081adf34 Call Trace:
087f7aec:  [<080680c7>] switch_threads+0x2d/0x4e
087f7afc:  [<08147ced>] schedule+0x417/0x46a
087f7b20:  [<0806bc6b>] __activate_task+0x1e/0x2f
087f7b38:  [<0806bd6e>] activate_task+0x5a/0x64
087f7b58:  [<0806be06>] try_to_wake_up+0x45/0x7e
087f7b60:  [<0806be35>] try_to_wake_up+0x74/0x7e
087f7b78:  [<080596b5>] switch_to_skas+0x39/0x6a
087f7b8c:  [<08056db5>] _switch_to+0x37/0x70
087f7ba8:  [<08147cd3>] schedule+0x3fd/0x46a
087f7be4:  [<0807d57a>] worker_thread+0x0/0x134
087f7be8:  [<0807d645>] worker_thread+0xcb/0x134
087f7c08:  [<0806c5cc>] default_wake_function+0x0/0x12
087f7c2c:  [<0807fc93>] kthread+0x74/0x9a
087f7c48:  [<0807fc1f>] kthread+0x0/0x9a
087f7c50:  [<08064db6>] run_kernel_thread+0x43/0x4d
087f7c64:  [<0807fc1f>] kthread+0x0/0x9a
087f7c70:  [<08064d95>] run_kernel_thread+0x22/0x4d
087f7ce8:  [<0806c0c5>] schedule_tail+0x23/0xb5
087f7cfc:  [<08059763>] new_thread_handler+0x7d/0xa5
087f7d00:  [<0807fc1f>] kthread+0x0/0x9a

kthread       S 400E07CE     0     5      1     6     746     4 (L-TLB)
00000001 087fba34 00000000 088b3ad8 08895640 088af680 088b3be4 088b3acc
       080680c7 00000000 00000000 00000000 00000000 088b0000 08897060 00000000
       0806977e 08209740 081adf00 08895640 088b3b34 0806bc6b 08895640 081adf34 Call Trace:
088b3aec:  [<080680c7>] switch_threads+0x2d/0x4e
088b3b0c:  [<0806977e>] arch_switch_to_skas+0xd/0x39
088b3b20:  [<0806bc6b>] __activate_task+0x1e/0x2f
088b3b38:  [<0806bd6e>] activate_task+0x5a/0x64
088b3b58:  [<0806be06>] try_to_wake_up+0x45/0x7e
088b3b60:  [<0806be35>] try_to_wake_up+0x74/0x7e
088b3b78:  [<080596b5>] switch_to_skas+0x39/0x6a
088b3b8c:  [<08056db5>] _switch_to+0x37/0x70
088b3ba8:  [<08147cd3>] schedule+0x3fd/0x46a
088b3be4:  [<0807d57a>] worker_thread+0x0/0x134
088b3be8:  [<0807d645>] worker_thread+0xcb/0x134
088b3c08:  [<0806c5cc>] default_wake_function+0x0/0x12
088b3c2c:  [<0807fc93>] kthread+0x74/0x9a
088b3c48:  [<0807fc1f>] kthread+0x0/0x9a
088b3c50:  [<08064db6>] run_kernel_thread+0x43/0x4d
088b3c64:  [<0807fc1f>] kthread+0x0/0x9a
088b3c70:  [<08064d95>] run_kernel_thread+0x22/0x4d
088b3ce8:  [<0806c0c5>] schedule_tail+0x23/0xb5
088b3cfc:  [<08059763>] new_thread_handler+0x7d/0xa5
088b3d00:  [<0807fc1f>] kthread+0x0/0x9a

kblockd/0     S 400E07CE     0     6      5            23       (L-TLB)
00000001 0817fb14 00000000 088c3ad8 08180f80 088af080 088c3be4 088c3acc
       080680c7 00000000 087df784 087df780 0890f20c 087df780 0890f20c 00000000
       080e73d7 0890dad0 0890ed4c 088c3b6c 00000040 088c3b6c b7f235c3 088c3b6c Call Trace:
088c3aec:  [<080680c7>] switch_threads+0x2d/0x4e
088c3b0c:  [<080e73d7>] as_move_to_dispatch+0xe4/0x109
088c3b2c:  [<08063594>] file_io+0x19/0xa7
088c3b48:  [<080e01fb>] elv_next_request+0x2a/0x109
088c3b5c:  [<08060b99>] do_ubd_request+0x81/0x9f
088c3b60:  [<08054b08>] _init+0x148/0x8c0
088c3b64:  [<0805712e>] copy_to_user_proc+0x0/0x5
088c3b78:  [<080596b5>] switch_to_skas+0x39/0x6a
088c3b8c:  [<08056db5>] _switch_to+0x37/0x70
088c3ba8:  [<08147cd3>] schedule+0x3fd/0x46a
088c3be4:  [<0807d57a>] worker_thread+0x0/0x134
088c3be8:  [<0807d645>] worker_thread+0xcb/0x134
088c3c08:  [<0806c5cc>] default_wake_function+0x0/0x12
088c3c2c:  [<0807fc93>] kthread+0x74/0x9a
088c3c48:  [<0807fc1f>] kthread+0x0/0x9a
088c3c50:  [<08064db6>] run_kernel_thread+0x43/0x4d
088c3c64:  [<0807fc1f>] kthread+0x0/0x9a
088c3c70:  [<08064d95>] run_kernel_thread+0x22/0x4d
088c3ce8:  [<0806c0c5>] schedule_tail+0x23/0xb5
088c3cfc:  [<08059763>] new_thread_handler+0x7d/0xa5
088c3d00:  [<0807fc1f>] kthread+0x0/0x9a

pdflush       S 400E07CE     0    23      5            24     6 (L-TLB)
00000001 087dbc5c 00000000 087d7adc 088c66a0 088c60a0 087d7be8 087d7ad0
       080680c7 00000000 087d7c1c 00000001 080680d5 00000000 088b3a80 00000000
       087d7b10 088af680 088c60a0 087d7c1c 087d7b04 080680c7 00000000 087d7c6c Call Trace:
087d7af0:  [<080680c7>] switch_threads+0x2d/0x4e
087d7b00:  [<080680d5>] switch_threads+0x3b/0x4e
087d7b24:  [<080680c7>] switch_threads+0x2d/0x4e
087d7b3c:  [<0806c6b1>] __wake_up_sync+0x38/0x43
087d7b54:  [<080ef627>] vsnprintf+0x421/0x460
087d7b7c:  [<080596b5>] switch_to_skas+0x39/0x6a
087d7b90:  [<08056db5>] _switch_to+0x37/0x70
087d7bac:  [<08147cd3>] schedule+0x3fd/0x46a
087d7be8:  [<0808f6e0>] pdflush+0x0/0x2e
087d7bec:  [<0808f629>] __pdflush+0x81/0x138
087d7bfc:  [<0808f709>] pdflush+0x29/0x2e
087d7c2c:  [<0807fc93>] kthread+0x74/0x9a
087d7c48:  [<0807fc1f>] kthread+0x0/0x9a
087d7c50:  [<08064db6>] run_kernel_thread+0x43/0x4d
087d7c64:  [<0807fc1f>] kthread+0x0/0x9a
087d7c70:  [<08064d95>] run_kernel_thread+0x22/0x4d
087d7ce8:  [<0806c0c5>] schedule_tail+0x23/0xb5
087d7cfc:  [<08059763>] new_thread_handler+0x7d/0xa5
087d7d00:  [<0807fc1f>] kthread+0x0/0x9a

pdflush       S 400E07CE     0    24      5            25    23 (L-TLB)
00000001 0817fb14 00000000 087dbadc 08180f80 088c66a0 087dbbe8 087dbad0
       080680c7 00000000 00000003 08342f90 00000003 00000000 080be3c8 08342e6c
       09ce1600 00000000 08342e74 087dbbb4 09ce1600 08342e6c 080be4d7 08342e6c Call Trace:
087dbaf0:  [<080680c7>] switch_threads+0x2d/0x4e
087dbb08:  [<080be3c8>] __sync_single_inode+0x1a6/0x1b0
087dbb28:  [<080be4d7>] __writeback_single_inode+0x105/0x10f
087dbb4c:  [<080d5594>] ext2_discard_prealloc+0x2b/0x30
087dbb54:  [<080d54e7>] ext2_put_inode+0xb/0x1c
087dbb5c:  [<080b76ba>] iput+0x5b/0x89
087dbb68:  [<0806977e>] arch_switch_to_skas+0xd/0x39
087dbb7c:  [<080596b5>] switch_to_skas+0x39/0x6a
087dbb90:  [<08056db5>] _switch_to+0x37/0x70
087dbbac:  [<08147cd3>] schedule+0x3fd/0x46a
087dbbe8:  [<0808f6e0>] pdflush+0x0/0x2e
087dbbec:  [<0808f629>] __pdflush+0x81/0x138
087dbbfc:  [<0808f709>] pdflush+0x29/0x2e
087dbc2c:  [<0807fc93>] kthread+0x74/0x9a
087dbc48:  [<0807fc1f>] kthread+0x0/0x9a
087dbc50:  [<08064db6>] run_kernel_thread+0x43/0x4d
087dbc64:  [<0807fc1f>] kthread+0x0/0x9a
087dbc70:  [<08064d95>] run_kernel_thread+0x22/0x4d
087dbce8:  [<0806c0c5>] schedule_tail+0x23/0xb5
087dbcfc:  [<08059763>] new_thread_handler+0x7d/0xa5
087dbd00:  [<0807fc1f>] kthread+0x0/0x9a

kswapd0       S 400E07CE     0    25      5            26    24 (L-TLB)
00000001 0820fc5c 00000000 08207af4 08209740 087de120 08207c00 08207ae8
       080680c7 00000000 08207b10 088af680 087de120 08207c1c 08207b04 080680c7
       00000000 08207c6c b7e91d79 00000000 00000000 00000000 00000000 00000000 Call Trace:
08207b08:  [<080680c7>] switch_threads+0x2d/0x4e
08207b24:  [<080680c7>] switch_threads+0x2d/0x4e
08207b7c:  [<0806bc6b>] __activate_task+0x1e/0x2f
08207b94:  [<080596b5>] switch_to_skas+0x39/0x6a
08207ba8:  [<08056db5>] _switch_to+0x37/0x70
08207bc4:  [<08147cd3>] schedule+0x3fd/0x46a
08207c00:  [<08091e02>] kswapd+0x0/0xa7
08207c04:  [<08091e8b>] kswapd+0x89/0xa7
08207c10:  [<0807fffa>] autoremove_wake_function+0x0/0x3a
08207c2c:  [<0807fc93>] kthread+0x74/0x9a
08207c48:  [<0807fc1f>] kthread+0x0/0x9a
08207c50:  [<08064db6>] run_kernel_thread+0x43/0x4d
08207c64:  [<0807fc1f>] kthread+0x0/0x9a
08207c70:  [<08064d95>] run_kernel_thread+0x22/0x4d
08207ce8:  [<0806c0c5>] schedule_tail+0x23/0xb5
08207cfc:  [<08059763>] new_thread_handler+0x7d/0xa5
08207d00:  [<0807fc1f>] kthread+0x0/0x9a

aio/0         S 400E07CE     0    26      5                  25 (L-TLB)
00000001 087f7ad8 00000000 0820fad8 087f2060 08209740 0820fbe4 0820facc
       080680c7 00000000 08209740 0820fc1c 00000001 080680d5 00000000 088b3a80
       00000000 0820fb10 088af680 08209740 0820fc1c 0820fb04 080680c7 00000000 Call Trace:
0820faec:  [<080680c7>] switch_threads+0x2d/0x4e
0820fb00:  [<080680d5>] switch_threads+0x3b/0x4e
0820fb24:  [<080680c7>] switch_threads+0x2d/0x4e
0820fb78:  [<080596b5>] switch_to_skas+0x39/0x6a
0820fb8c:  [<08056db5>] _switch_to+0x37/0x70
0820fba8:  [<08147cd3>] schedule+0x3fd/0x46a
0820fbe4:  [<0807d57a>] worker_thread+0x0/0x134
0820fbe8:  [<0807d645>] worker_thread+0xcb/0x134
0820fc08:  [<0806c5cc>] default_wake_function+0x0/0x12
0820fc2c:  [<0807fc93>] kthread+0x74/0x9a
0820fc48:  [<0807fc1f>] kthread+0x0/0x9a
0820fc50:  [<08064db6>] run_kernel_thread+0x43/0x4d
0820fc64:  [<0807fc1f>] kthread+0x0/0x9a
0820fc70:  [<08064d95>] run_kernel_thread+0x22/0x4d
0820fce8:  [<0806c0c5>] schedule_tail+0x23/0xb5
0820fcfc:  [<08059763>] new_thread_handler+0x7d/0xa5
0820fd00:  [<0807fc1f>] kthread+0x0/0x9a

syslogd       S 400E07CE     0   746      1           749     5 (NOTLB)
00000001 0817fb14 00000000 082b76fc 08180f80 087ae160 082b7808 082b76f0
       080680c7 00000000 00000007 b7f9e420 0000001d 00000033 00000000 0000007b
       0000007b 00000040 082b7a54 082b7a54 082b7a00 00000007 00000007 b7f9e420 Call Trace:
082b7710:  [<080680c7>] switch_threads+0x2d/0x4e
082b7788:  [<0806977e>] arch_switch_to_skas+0xd/0x39
082b7794:  [<080596c9>] switch_to_skas+0x4d/0x6a
082b779c:  [<080596b5>] switch_to_skas+0x39/0x6a
082b77b0:  [<08056db5>] _switch_to+0x37/0x70
082b77cc:  [<08147cd3>] schedule+0x3fd/0x46a
082b77f4:  [<080b1a54>] __pollwait+0x4a/0x4e
082b780c:  [<08148393>] schedule_timeout+0x14/0x99
082b7820:  [<080fe0f3>] sock_poll+0x13/0x17
082b7838:  [<080b1e3c>] do_select+0x300/0x377
082b7880:  [<080b1a0a>] __pollwait+0x0/0x4e
082b789c:  [<0806c5cc>] default_wake_function+0x0/0x12
082b78b4:  [<0809fe12>] kmem_cache_alloc+0x3e/0x44
082b78c4:  [<0808cf79>] mempool_alloc+0x21/0xbf
082b78dc:  [<080e7c8e>] as_set_request+0x1c/0x6d
082b7928:  [<080e778e>] as_add_request+0xb1/0xbe
082b7940:  [<080e005f>] elv_insert+0xa7/0x156
082b7958:  [<08059cd9>] maybe_map+0x25/0x85
082b797c:  [<08059d55>] do_op_one_page+0x1c/0x54
082b7994:  [<08059e20>] do_buffer_op+0x93/0x13d
082b79a4:  [<08059f1c>] copy_chunk_from_user+0x0/0x27
082b79b0:  [<08059f1c>] copy_chunk_from_user+0x0/0x27
082b79d0:  [<0806679f>] setjmp_wrapper+0x3d/0x4a
082b79f0:  [<08066775>] setjmp_wrapper+0x13/0x4a
082b7a08:  [<080e7299>] as_remove_queued_request+0xff/0x10e
082b7a34:  [<0806977e>] arch_switch_to_skas+0xd/0x39
082b7a40:  [<080596c9>] switch_to_skas+0x4d/0x6a
082b7a5c:  [<08056db5>] _switch_to+0x37/0x70
082b7a80:  [<08059ef3>] buffer_op+0x29/0x52
082b7a84:  [<08059d8d>] do_buffer_op+0x0/0x13d
082b7a94:  [<08059f1c>] copy_chunk_from_user+0x0/0x27
082b7ab0:  [<08059fc2>] copy_from_user_skas+0x7f/0x8a
082b7ad4:  [<080b20b7>] core_sys_select+0x204/0x2d4
082b7b0c:  [<0808a0c8>] wait_on_page_writeback_range+0x82/0xf5
082b7b24:  [<08080034>] wake_bit_function+0x0/0x34
082b7b44:  [<080a5f45>] sync_dirty_buffer+0x72/0xa4
082b7b70:  [<0808a865>] find_get_pages_tag+0x2c/0x67
082b7b84:  [<0808a899>] find_get_pages_tag+0x60/0x67
082b7b98:  [<080905ab>] pagevec_lookup_tag+0x1e/0x27
082b7bb4:  [<0808a0f9>] wait_on_page_writeback_range+0xb3/0xf5
082b7bdc:  [<080d6a70>] ext2_sync_inode+0x1d/0x22
082b7c1c:  [<080b221e>] sys_select+0x97/0x168
082b7c3c:  [<080a3876>] do_fsync+0x52/0x66
082b7c50:  [<080a38b3>] __do_fsync+0x29/0x30
082b7c68:  [<0804ec40>] init_tmpfs+0x3/0x7b
082b7c70:  [<08059ae4>] handle_syscall+0x90/0xa8
082b7c88:  [<0804ec40>] init_tmpfs+0x3/0x7b
082b7c8c:  [<080b2187>] sys_select+0x0/0x168
082b7ca4:  [<0804ec40>] init_tmpfs+0x3/0x7b
082b7cbc:  [<08067f8d>] userspace+0x1fe/0x242
082b7d00:  [<08059841>] fork_handler+0x98/0x9d

klogd         R running     0   749      1           757   746 (NOTLB)
inetd         S 400E07CE     0   757      1           778   749 (NOTLB)
00000001 087b7ba4 00000000 087bb6fc 09daa220 088e9260 087bb808 087bb6f0
       080680c7 00000000 00005da7 00000b7f 09c9ccdc 080675eb 00005da7 00000000
       080676b3 00005d0a 087bb8a4 00005cbc 00000013 00005cbc 00005cb8 00000011 Call Trace:
087bb710:  [<080680c7>] switch_threads+0x2d/0x4e
087bb724:  [<080675eb>] do_syscall_stub+0x67/0x13f
087bb730:  [<080676b3>] do_syscall_stub+0x12f/0x13f
087bb790:  [<0806793a>] map+0x14c/0x15b
087bb79c:  [<080596b5>] switch_to_skas+0x39/0x6a
087bb7b0:  [<08056db5>] _switch_to+0x37/0x70
087bb7cc:  [<08147cd3>] schedule+0x3fd/0x46a
087bb80c:  [<08148393>] schedule_timeout+0x14/0x99
087bb820:  [<080fe0f3>] sock_poll+0x13/0x17
087bb838:  [<080b1e3c>] do_select+0x300/0x377
087bb880:  [<080b1a0a>] __pollwait+0x0/0x4e
087bb89c:  [<0806c5cc>] default_wake_function+0x0/0x12
087bb8b8:  [<0806c5cc>] default_wake_function+0x0/0x12
087bb8d4:  [<0806c5cc>] default_wake_function+0x0/0x12
087bb8f0:  [<0806c5cc>] default_wake_function+0x0/0x12
087bb90c:  [<0806c5cc>] default_wake_function+0x0/0x12
087bb958:  [<08059cd9>] maybe_map+0x25/0x85
087bb97c:  [<08059d55>] do_op_one_page+0x1c/0x54
087bb994:  [<08059e20>] do_buffer_op+0x93/0x13d
087bb9a4:  [<08059f1c>] copy_chunk_from_user+0x0/0x27
087bb9b0:  [<08059f1c>] copy_chunk_from_user+0x0/0x27
087bb9d0:  [<0806679f>] setjmp_wrapper+0x3d/0x4a
087bb9f0:  [<08066775>] setjmp_wrapper+0x13/0x4a
087bba48:  [<0806793a>] map+0x14c/0x15b
087bba80:  [<08059ef3>] buffer_op+0x29/0x52
087bba84:  [<08059d8d>] do_buffer_op+0x0/0x13d
087bba94:  [<08059f1c>] copy_chunk_from_user+0x0/0x27
087bbab0:  [<08059fc2>] copy_from_user_skas+0x7f/0x8a
087bbad4:  [<080b20b7>] core_sys_select+0x204/0x2d4
087bbb10:  [<080586d2>] fix_range_common+0x22c/0x260
087bbb70:  [<08059c0c>] fix_range+0x32/0x36
087bbb84:  [<08059afc>] do_ops+0x0/0xde
087bbb88:  [<08059c4d>] flush_tlb_range_skas+0x29/0x2d
087bbb9c:  [<0805888b>] flush_tlb_page+0x1b/0x1f
087bbbac:  [<08058a5d>] handle_page_fault+0x185/0x1df
087bbbb0:  [<08058a6e>] handle_page_fault+0x196/0x1df
087bbbd4:  [<08058bae>] segv+0xa1/0x25f
087bbc1c:  [<080b221e>] sys_select+0x97/0x168
087bbc44:  [<0807a032>] sys_rt_sigprocmask+0x4b/0xb1
087bbc70:  [<08059ae4>] handle_syscall+0x90/0xa8
087bbc8c:  [<080b2187>] sys_select+0x0/0x168
087bbcbc:  [<08067f8d>] userspace+0x1fe/0x242
087bbd00:  [<08059841>] fork_handler+0x98/0x9d

atd           S 400E07CE     0   778      1           781   757 (NOTLB)
00000001 087a7c64 00000000 08933ac4 087ac720 0879a100 08933bd0 08933ab8
       080680c7 00000000 bf7256b8 08933af0 08930000 08059d55 003141e1 08933c58
       00000008 08059d55 bf7256b8 00000000 00000008 bf7256b8 00000008 08059e20 Call Trace:
08933ad8:  [<080680c7>] switch_threads+0x2d/0x4e
08933aec:  [<08059d55>] do_op_one_page+0x1c/0x54
08933afc:  [<08059d55>] do_op_one_page+0x1c/0x54
08933b14:  [<08059e20>] do_buffer_op+0x93/0x13d
08933b44:  [<080580ec>] do_gettimeofday+0x3d/0x60
08933b64:  [<080596b5>] switch_to_skas+0x39/0x6a
08933b78:  [<08056db5>] _switch_to+0x37/0x70
08933b94:  [<08147cd3>] schedule+0x3fd/0x46a
08933bd4:  [<08148774>] do_nanosleep+0x46/0x72
08933bf4:  [<08082576>] hrtimer_nanosleep+0x32/0xf2
08933c28:  [<08082515>] hrtimer_wakeup+0x0/0x1c
08933c50:  [<08082673>] sys_nanosleep+0x3d/0x4f
08933c70:  [<08059ae4>] handle_syscall+0x90/0xa8
08933c8c:  [<08082636>] sys_nanosleep+0x0/0x4f
08933cbc:  [<08067f8d>] userspace+0x1fe/0x242
08933d00:  [<08059841>] fork_handler+0x98/0x9d

cron          S 400E07CE     0   781      1           811   778 (NOTLB)
00000001 0817fb14 00000000 082cbac4 08180f80 087ad140 082cbbd0 082cbab8
       080680c7 00000000 bfb85358 082cbaf0 082c8000 08059d55 006f01e1 082cbc58
       00000008 08059d55 bfb85358 00000000 00000008 bfb85358 00000008 08059e20 Call Trace:
082cbad8:  [<080680c7>] switch_threads+0x2d/0x4e
082cbaec:  [<08059d55>] do_op_one_page+0x1c/0x54
082cbafc:  [<08059d55>] do_op_one_page+0x1c/0x54
082cbb14:  [<08059e20>] do_buffer_op+0x93/0x13d
082cbb44:  [<080580ec>] do_gettimeofday+0x3d/0x60
082cbb64:  [<080596b5>] switch_to_skas+0x39/0x6a
082cbb78:  [<08056db5>] _switch_to+0x37/0x70
082cbb94:  [<08147cd3>] schedule+0x3fd/0x46a
082cbbd4:  [<08148774>] do_nanosleep+0x46/0x72
082cbbf4:  [<08082576>] hrtimer_nanosleep+0x32/0xf2
082cbc28:  [<08082515>] hrtimer_wakeup+0x0/0x1c
082cbc50:  [<08082673>] sys_nanosleep+0x3d/0x4f
082cbc70:  [<08059ae4>] handle_syscall+0x90/0xa8
082cbc8c:  [<08082636>] sys_nanosleep+0x0/0x4f
082cbcbc:  [<08067f8d>] userspace+0x1fe/0x242
082cbd00:  [<08059841>] fork_handler+0x98/0x9d

getty         S 400E07CE     0   811      1           812   781 (NOTLB)
00000001 087fbba8 00000000 08a73ac4 08895640 09daa820 08a73bd0 08a73ab8
       080680c7 00000000 bfa1f158 08a73af0 08a70000 08059d55 0075d1e1 08a73c58
       00000008 08059d55 bfa1f158 00000000 00000008 bfa1f158 00000008 08059e20 Call Trace:
08a73ad8:  [<080680c7>] switch_threads+0x2d/0x4e
08a73aec:  [<08059d55>] do_op_one_page+0x1c/0x54
08a73afc:  [<08059d55>] do_op_one_page+0x1c/0x54
08a73b14:  [<08059e20>] do_buffer_op+0x93/0x13d
08a73b44:  [<080580ec>] do_gettimeofday+0x3d/0x60
08a73b64:  [<080596b5>] switch_to_skas+0x39/0x6a
08a73b78:  [<08056db5>] _switch_to+0x37/0x70
08a73b94:  [<08147cd3>] schedule+0x3fd/0x46a
08a73bd4:  [<08148774>] do_nanosleep+0x46/0x72
08a73bf4:  [<08082576>] hrtimer_nanosleep+0x32/0xf2
08a73c28:  [<08082515>] hrtimer_wakeup+0x0/0x1c
08a73c50:  [<08082673>] sys_nanosleep+0x3d/0x4f
08a73c70:  [<08059ae4>] handle_syscall+0x90/0xa8
08a73c8c:  [<08082636>] sys_nanosleep+0x0/0x4f
08a73cbc:  [<08067f8d>] userspace+0x1fe/0x242
08a73d00:  [<08059841>] fork_handler+0x98/0x9d

getty         S 400E07CE     0   812      1           813   811 (NOTLB)
00000001 087fbba8 00000000 0879fac4 08895640 087ad740 0879fbd0 0879fab8
       080680c7 00000000 bf5a0cd8 0879faf0 0879c000 08059d55 009ca1e1 0879fc58
       00000008 08059d55 bf5a0cd8 00000000 00000008 bf5a0cd8 00000008 08059e20 Call Trace:
0879fad8:  [<080680c7>] switch_threads+0x2d/0x4e
0879faec:  [<08059d55>] do_op_one_page+0x1c/0x54
0879fafc:  [<08059d55>] do_op_one_page+0x1c/0x54
0879fb14:  [<08059e20>] do_buffer_op+0x93/0x13d
0879fb44:  [<080580ec>] do_gettimeofday+0x3d/0x60
0879fb64:  [<080596b5>] switch_to_skas+0x39/0x6a
0879fb78:  [<08056db5>] _switch_to+0x37/0x70
0879fb94:  [<08147cd3>] schedule+0x3fd/0x46a
0879fbd4:  [<08148774>] do_nanosleep+0x46/0x72
0879fbf4:  [<08082576>] hrtimer_nanosleep+0x32/0xf2
0879fc28:  [<08082515>] hrtimer_wakeup+0x0/0x1c
0879fc50:  [<08082673>] sys_nanosleep+0x3d/0x4f
0879fc70:  [<08059ae4>] handle_syscall+0x90/0xa8
0879fc8c:  [<08082636>] sys_nanosleep+0x0/0x4f
0879fcbc:  [<08067f8d>] userspace+0x1fe/0x242
0879fd00:  [<08059841>] fork_handler+0x98/0x9d

getty         S 400E07CE     0   813      1           814   812 (NOTLB)
00000001 087fbba8 00000000 082c7ac4 08895640 09daa220 082c7bd0 082c7ab8
       080680c7 00000000 bf72fe68 082c7af0 082c4000 08059d55 0074d1e1 082c7c58
       00000008 08059d55 bf72fe68 00000000 00000008 bf72fe68 00000008 08059e20 Call Trace:
082c7ad8:  [<080680c7>] switch_threads+0x2d/0x4e
082c7aec:  [<08059d55>] do_op_one_page+0x1c/0x54
082c7afc:  [<08059d55>] do_op_one_page+0x1c/0x54
082c7b14:  [<08059e20>] do_buffer_op+0x93/0x13d
082c7b44:  [<080580ec>] do_gettimeofday+0x3d/0x60
082c7b64:  [<080596b5>] switch_to_skas+0x39/0x6a
082c7b78:  [<08056db5>] _switch_to+0x37/0x70
082c7b94:  [<08147cd3>] schedule+0x3fd/0x46a
082c7bd4:  [<08148774>] do_nanosleep+0x46/0x72
082c7bf4:  [<08082576>] hrtimer_nanosleep+0x32/0xf2
082c7c28:  [<08082515>] hrtimer_wakeup+0x0/0x1c
082c7c50:  [<08082673>] sys_nanosleep+0x3d/0x4f
082c7c70:  [<08059ae4>] handle_syscall+0x90/0xa8
082c7c8c:  [<08082636>] sys_nanosleep+0x0/0x4f
082c7cbc:  [<08067f8d>] userspace+0x1fe/0x242
082c7d00:  [<08059841>] fork_handler+0x98/0x9d

getty         S 400E07CE     0   814      1           815   813 (NOTLB)
00000001 087fbba8 00000000 0878fac4 08895640 088e9860 0878fbd0 0878fab8
       080680c7 00000000 bfa1d158 0878faf0 0878c000 08059d55 01c341e1 0878fc58
       00000008 08059d55 bfa1d158 00000000 00000008 bfa1d158 00000008 08059e20 Call Trace:
0878fad8:  [<080680c7>] switch_threads+0x2d/0x4e
0878faec:  [<08059d55>] do_op_one_page+0x1c/0x54
0878fafc:  [<08059d55>] do_op_one_page+0x1c/0x54
0878fb14:  [<08059e20>] do_buffer_op+0x93/0x13d
0878fb44:  [<080580ec>] do_gettimeofday+0x3d/0x60
0878fb64:  [<080596b5>] switch_to_skas+0x39/0x6a
0878fb78:  [<08056db5>] _switch_to+0x37/0x70
0878fb94:  [<08147cd3>] schedule+0x3fd/0x46a
0878fbd4:  [<08148774>] do_nanosleep+0x46/0x72
0878fbf4:  [<08082576>] hrtimer_nanosleep+0x32/0xf2
0878fc28:  [<08082515>] hrtimer_wakeup+0x0/0x1c
0878fc50:  [<08082673>] sys_nanosleep+0x3d/0x4f
0878fc70:  [<08059ae4>] handle_syscall+0x90/0xa8
0878fc8c:  [<08082636>] sys_nanosleep+0x0/0x4f
0878fcbc:  [<08067f8d>] userspace+0x1fe/0x242
0878fd00:  [<08059841>] fork_handler+0x98/0x9d

getty         S 400E07CE     0   815      1           816   814 (NOTLB)
00000001 087fbba8 00000000 0878bac4 08895640 088d6240 0878bbd0 0878bab8
       080680c7 00000000 bf458b88 0878baf0 08788000 08059d55 0046d1e1 0878bc58
       00000008 08059d55 bf458b88 00000000 00000008 bf458b88 00000008 08059e20 Call Trace:
0878bad8:  [<080680c7>] switch_threads+0x2d/0x4e
0878baec:  [<08059d55>] do_op_one_page+0x1c/0x54
0878bafc:  [<08059d55>] do_op_one_page+0x1c/0x54
0878bb14:  [<08059e20>] do_buffer_op+0x93/0x13d
0878bb44:  [<080580ec>] do_gettimeofday+0x3d/0x60
0878bb64:  [<080596b5>] switch_to_skas+0x39/0x6a
0878bb78:  [<08056db5>] _switch_to+0x37/0x70
0878bb94:  [<08147cd3>] schedule+0x3fd/0x46a
0878bbd4:  [<08148774>] do_nanosleep+0x46/0x72
0878bbf4:  [<08082576>] hrtimer_nanosleep+0x32/0xf2
0878bc28:  [<08082515>] hrtimer_wakeup+0x0/0x1c
0878bc50:  [<08082673>] sys_nanosleep+0x3d/0x4f
0878bc70:  [<08059ae4>] handle_syscall+0x90/0xa8
0878bc8c:  [<08082636>] sys_nanosleep+0x0/0x4f
0878bcbc:  [<08067f8d>] userspace+0x1fe/0x242
0878bd00:  [<08059841>] fork_handler+0x98/0x9d

getty         S 400E07CE     0   816      1                 815 (NOTLB)
00000001 087fbba8 00000000 09dbfac4 08895640 09d8f800 09dbfbd0 09dbfab8
       080680c7 00000000 bf8e4818 09dbfaf0 09dbc000 08059d55 006541e1 09dbfc58
       00000008 08059d55 bf8e4818 00000000 00000008 bf8e4818 00000008 08059e20 Call Trace:
09dbfad8:  [<080680c7>] switch_threads+0x2d/0x4e
09dbfaec:  [<08059d55>] do_op_one_page+0x1c/0x54
09dbfafc:  [<08059d55>] do_op_one_page+0x1c/0x54
09dbfb14:  [<08059e20>] do_buffer_op+0x93/0x13d
09dbfb44:  [<080580ec>] do_gettimeofday+0x3d/0x60
09dbfb64:  [<080596b5>] switch_to_skas+0x39/0x6a
09dbfb78:  [<08056db5>] _switch_to+0x37/0x70
09dbfb94:  [<08147cd3>] schedule+0x3fd/0x46a
09dbfbd4:  [<08148774>] do_nanosleep+0x46/0x72
09dbfbf4:  [<08082576>] hrtimer_nanosleep+0x32/0xf2
09dbfc28:  [<08082515>] hrtimer_wakeup+0x0/0x1c
09dbfc50:  [<08082673>] sys_nanosleep+0x3d/0x4f
09dbfc70:  [<08059ae4>] handle_syscall+0x90/0xa8
09dbfc8c:  [<08082636>] sys_nanosleep+0x0/0x4f
09dbfcbc:  [<08067f8d>] userspace+0x1fe/0x242
09dbfd00:  [<08059841>] fork_handler+0x98/0x9d


(debian)


#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.18-rc2
# Sat Jul 22 11:32:17 2006
#
CONFIG_GENERIC_HARDIRQS=y
CONFIG_UML=y
CONFIG_MMU=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_IRQ_RELEASE_METHOD=y

#
# UML-specific options
#
# CONFIG_MODE_TT is not set
# CONFIG_STATIC_LINK is not set
CONFIG_MODE_SKAS=y

#
# Host processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_UML_X86=y
# CONFIG_64BIT is not set
CONFIG_SEMAPHORE_SLEEPERS=y
# CONFIG_HOST_2G_2G is not set
CONFIG_TOP_ADDR=0xc0000000
# CONFIG_3_LEVEL_PGTABLES is not set
CONFIG_STUB_CODE=0xbfffe000
CONFIG_STUB_DATA=0xbffff000
CONFIG_STUB_START=0xbfffe000
CONFIG_ARCH_HAS_SC_SIGNALS=y
CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_RESOURCES_64BIT is not set
CONFIG_LD_SCRIPT_DYN=y
CONFIG_NET=y
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
CONFIG_HOSTFS=y
# CONFIG_HPPFS is not set
CONFIG_MCONSOLE=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_NEST_LEVEL=0
# CONFIG_HIGHMEM is not set
CONFIG_KERNEL_STACK_ORDER=2
CONFIG_UML_REAL_TIME_CLOCK=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=128

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
# CONFIG_TASKSTATS is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_RELAY is not set
CONFIG_INITRAMFS_SOURCE=""
CONFIG_UID16=y
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_EXTRA_PASS=y
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_RT_MUTEXES=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_SLAB=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
# CONFIG_SLOB is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y

#
# Block layer
#
# CONFIG_LBD is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_LSF is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_AS=y
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="anticipatory"

#
# Block devices
#
CONFIG_BLK_DEV_UBD=y
# CONFIG_BLK_DEV_UBD_SYNC is not set
CONFIG_BLK_DEV_COW_COMMON=y
# CONFIG_MMAPPER is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_ATA_OVER_ETH is not set

#
# Character Devices
#
CONFIG_STDERR_CONSOLE=y
CONFIG_STDIO_CONSOLE=y
CONFIG_SSL=y
CONFIG_NULL_CHAN=y
CONFIG_PORT_CHAN=y
CONFIG_PTY_CHAN=y
CONFIG_TTY_CHAN=y
CONFIG_XTERM_CHAN=y
# CONFIG_NOCONFIG_CHAN is not set
CONFIG_CON_ZERO_CHAN="fd:0,fd:1"
CONFIG_CON_CHAN="xterm"
CONFIG_SSL_CHAN="pty"
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_WATCHDOG is not set
CONFIG_UML_SOUND=m
CONFIG_SOUND=m
CONFIG_HOSTAUDIO=m
CONFIG_UML_RANDOM=y

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
# CONFIG_FW_LOADER is not set
# CONFIG_SYS_HYPERVISOR is not set

#
# Networking
#

#
# Networking options
#
# CONFIG_NETDEBUG is not set
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=y
# CONFIG_IPV6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETFILTER is not set

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set

#
# TIPC Configuration (EXPERIMENTAL)
#
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set

#
# UML Network Devices
#
CONFIG_UML_NET=y
CONFIG_UML_NET_ETHERTAP=y
CONFIG_UML_NET_TUNTAP=y
CONFIG_UML_NET_SLIP=y
CONFIG_UML_NET_DAEMON=y
CONFIG_UML_NET_MCAST=y
# CONFIG_UML_NET_PCAP is not set
CONFIG_UML_NET_SLIRP=y

#
# Network device support
#
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m

#
# PHY device support
#

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPP_FILTER is not set
# CONFIG_PPP_ASYNC is not set
# CONFIG_PPP_SYNC_TTY is not set
# CONFIG_PPP_DEFLATE is not set
# CONFIG_PPP_BSDCOMP is not set
# CONFIG_PPP_MPPE is not set
# CONFIG_PPPOE is not set
CONFIG_SLIP=m
# CONFIG_SLIP_COMPRESSED is not set
# CONFIG_SLIP_SMART is not set
# CONFIG_SLIP_MODE_SLIP6 is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# Connector - unified userspace <-> kernelspace linker
#
# CONFIG_CONNECTOR is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT2_FS_XIP is not set
# CONFIG_EXT3_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_FS_POSIX_ACL is not set
# CONFIG_XFS_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
# CONFIG_CONFIGFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Hardware crypto devices
#

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
CONFIG_CRC32=m
# CONFIG_LIBCRC32C is not set
CONFIG_PLIST=y

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_INPUT is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_DEBUG_KERNEL is not set
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_DEBUG_FS is not set
# CONFIG_UNWIND_INFO is not set



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
