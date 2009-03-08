Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <renzo@cs.unibo.it>) id 1LgMU3-0003mp-Kn
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Mar 2009 17:08:15 +0000
Received: from leb.cs.unibo.it ([130.136.1.102])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LgMTo-0002U9-Fp
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Mar 2009 17:08:10 +0000
Date: Sun, 8 Mar 2009 18:07:58 +0100
From: Renzo Davoli <renzo@cs.unibo.it>
Message-ID: <20090308170758.GE6847@cs.unibo.it>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] Nesting and other problems on 2.6.29-rc7
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
To: user-mode-linux-devel@lists.sourceforge.net, =?iso-8859-1?Q?Am=E9rico?= Wang <xiyou.wangcong@gmail.com>

Dear Amerigo, Russell and user-mode linux developers,

I have seen the thread on the web and I've just joined the ML.
Russell Lewis asked about nesting.
http://www.mail-archive.com/user-mode-linux-devel@lists.sourceforge.net/msg06422.html

I am the one who posted:
http://groups.google.com/group/linux.kernel/browse_thread/thread/bacb6633e87708d9

When I made the tests with 2.6.28.2 it worked but now I am having Russell's
very same problem on the nested execution.
Eeek! page_mapcount(page) went negative! (-1)
Then the entire outer uml crashes.
I have spent the entire day yesterday trying to figure out what has changed since 
the beginning of February when it worked.

On 2.6.29-rc7 I get a different error (the Eeek error has been eliminated from the
kernel source code): the output of the nested execution is at the end of this message.
The nested UML crashes anyway, but the calling UML does not panic.

There are also new problems.
During the boot of uml (the first one) I get a lot of warnings like:
IRQ nn/xxxx: IRQF_DISABLED is not guaranteed on shared IRQs

VDE networking does not work. On the switch I can see the port assigned to uml but 
ping is mute.
I suppose that other services/devices involved with the shared IRQ problem are not working
properly.

Any idea on both problems?

	renzo

*********************BOOT OF THE FIRST (OUTER) UML **********************************
$ /tmp/linux.uml mem=256M ubd0=cow eth0=vde
Locating the bottom of the address space ... 0x0
Locating the top of the address space ... 0xc0000000
Core dump limits :
        soft - 0
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
Linux version 2.6.29-rc7 (renzo@picione) (gcc version 4.3.2 (Debian 4.3.2-1) ) #4 Sat Mar 7 18:09:15 CET 2009
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: mem=256M ubd0=cow eth0=vde root=98:0
PID hash table entries: 1024 (order: 10, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 255616k available
Calibrating delay loop... 4784.12 BogoMIPS (lpj=23920640)
Mount-cache hash table entries: 512
Checking for host processor cmov support...Yes
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
net_namespace: 520 bytes
Using 2.6 host AIO
NET: Registered protocol family 16
bio: create slab <bio-0> at 0
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
NET: Registered protocol family 1
IRQ 9/mconsole: IRQF_DISABLED is not guaranteed on shared IRQs
mconsole (version 2) initialized on /home/renzo/.uml/6iBHgI/mconsole
Checking host MADV_REMOVE support...OK
Host TLS support detected
Detected host type: i386 (GDT indexes 6 to 9)
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
msgmni has been set to 499
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
TCP cubic registered
NET: Registered protocol family 17
Initialized stdio console driver
Console initialized on /dev/tty0
console [tty0] enabled
Initializing software serial port version 1
Configured vde device: (default socket)
Choosing a random ethernet address for device eth0
Netdevice 0 (62:35:de:de:a7:a6) : vde backend - (default socket), undefined port
vde backend - connection opened
eth0 (uml-netdev): not using net_device_ops yet
console [mc-1] enabled
 ubda: unknown partition table
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly on device 98:0.
IRQ 3/console-write: IRQF_DISABLED is not guaranteed on shared IRQs
IRQ 2/console: IRQF_DISABLED is not guaranteed on shared IRQs
IRQ 10/winch: IRQF_DISABLED is not guaranteed on shared IRQs
Mount failed for selinuxfs on /selinux:  No such file or directory
IRQ 10/winch: IRQF_DISABLED is not guaranteed on shared IRQs
IRQ 10/winch: IRQF_DISABLED is not guaranteed on shared IRQs
INIT: IRQ 10/winch: IRQF_DISABLED is not guaranteed on shared IRQs
version 2.86 bootingIRQ 10/winch: IRQF_DISABLED is not guaranteed on shared IRQs

IRQ 10/winch: IRQF_DISABLED is not guaranteed on shared IRQs
hostname: the specified hostname is invalid
line_ioctl: tty0: unknown ioctl: 0x541e
line_ioctl: tty0: unknown ioctl: 0x5603
Setting the system clock.
modprobe: FATAL: Could not load /lib/modules/2.6.29-rc7/modules.dep: No such file or directory

hwclock is unable to get I/O port access:  the iopl(3) call failed.
* Unable to set System Clock to: Sat Mar  7 18:16:27 UTC 2009
findfs: Unable to resolve 'LABEL=ROOT'
Activating swap:.
Usage: mountpoint [-q] [-d] [-x] path
Will now check root file system:fsck 1.41.0 (10-Jul-2008)
[/sbin/fsck.ext3 (1) -- /lib/init/rw/rootdev] fsck.ext3 -a -C0 /lib/init/rw/rootdev 
/lib/init/rw/rootdev: clean, 15400/131072 files, 94572/262144 blocks (check in 2 mounts)
.
EXT3 FS on ubda, internal journal
Setting the system clock.
modprobe: FATAL: Could not load /lib/modules/2.6.29-rc7/modules.dep: No such file or directory

hwclock is unable to get I/O port access:  the iopl(3) call failed.
* Unable to set System Clock to: Sat Mar  7 18:16:28 UTC 2009
Cleaning up ifupdown....
FATAL: Could not load /lib/modules/2.6.29-rc7/modules.dep: No such file or directory
Loading device-mapper support.
Will now check all file systems.
fsck 1.41.0 (10-Jul-2008)
Checking all file systems.
Done checking file systems. 
A log is being saved in /var/log/fsck/checkfs if that location is writable.
Setting kernel variables...done.
Will now mount local filesystems:mount: none already mounted or /dev/pts busy
mount: according to mtab, devpts is already mounted on /dev/pts
 failed!
Will now activate swapfile swap:done.
Cleaning /tmp...done.
Cleaning /var/run...done.
Cleaning /var/lock...done.
Checking minimum space in /tmp...done.
Running 0dns-down to make sure resolv.conf is ok...done.
Setting up networking....
* /etc/network/options still exists and it will be IGNORED! Read README.Debian of netbase.
Configuring network interfaces...done.
Setting console screen modes and fonts.
line_ioctl: tty0: unknown ioctl: 0x541e
line_ioctl: tty0: unknown ioctl: 0x5603
Initializing random number generator...done.
Recovering nvi editor sessions...none found.
IRQ 10/winch: IRQF_DISABLED is not guaranteed on shared IRQs
INIT: IRQ 10/winch: IRQF_DISABLED is not guaranteed on shared IRQs
Entering runlevel: 2IRQ 10/winch: IRQF_DISABLED is not guaranteed on shared IRQs

IRQ 10/winch: IRQF_DISABLED is not guaranteed on shared IRQs
Starting system log daemon....
Starting kernel log daemon....
Starting MTA: exim4.
* ALERT: exim paniclog /var/log/exim4/paniclog has non-zero size, mail system possibly broken
* Not starting internet superserver: no services enabled.
Starting deferred execution scheduler: atd.
Starting periodic command scheduler: crond.
Running local boot scripts (/etc/rc.local).
IRQ 10/winch: IRQF_DISABLED is not guaranteed on shared IRQs
Serial line 0 assigned device '/dev/pts/43'
IRQ 6/ssl: IRQF_DISABLED is not guaranteed on shared IRQs
IRQ 7/ssl-write: IRQF_DISABLED is not guaranteed on shared IRQs

Debian GNU/Linux lenny/sid (none) tty0

(none) login: root
Password: 
Last login: Sat Mar  7 18:09:46 UTC 2009 on tty0
Linux (none) 2.6.29-rc7 #4 Sat Mar 7 18:09:15 CET 2009 i686

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
(none):~# uname -a
Linux (none) 2.6.29-rc7 #4 Sat Mar 7 18:09:15 CET 2009 i686 GNU/Linux
(none):~# mount -t hostfs / /mnt
********************************BOOT OF THE NESTED UML***************************************
(none):~# /mnt/tmp/linux.uml ubd0=/mnt/home/renzo/tests/linux.img
Locating the bottom of the address space ... 0x0
Locating the top of the address space ... 0xc0000000
Core dump limits :
        soft - 0
        hard - NONE
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...missing
Checking for tmpfs mount on /dev/shm...OK
Checking PROT_EXEC mmap in /dev/shm/...OK
Checking for the skas3 patch in the host:
  - /proc/mm...not found: No such file or directory
  - PTRACE_FAULTINFO...found
  - PTRACE_LDT...not found
UML running in SKAS0 mode
Linux version 2.6.29-rc7 (renzo@picione) (gcc version 4.3.2 (Debian 4.3.2-1) ) #4 Sat Mar 7 18:09:15 CET 2009
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 8128
Kernel command line: ubd0=/mnt/home/renzo/tests/linux.img root=98:0
PID hash table entries: 128 (order: 7, 512 bytes)
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 30312k available
Calibrating delay loop... 18874.36 BogoMIPS (lpj=94371840)
Mount-cache hash table entries: 512
Checking for host processor cmov support...Yes
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
net_namespace: 520 bytes
Using 2.6 host AIO
NET: Registered protocol family 16
bio: create slab <bio-0> at 0
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 1024 (order: 1, 8192 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
TCP reno registered
NET: Registered protocol family 1
IRQ 9/mconsole: IRQF_DISABLED is not guaranteed on shared IRQs
mconsole (version 2) initialized on /root/.uml/C7XqUl/mconsole
Checking host MADV_REMOVE support...OK
Host TLS support detected
Detected host type: i386 (GDT indexes 6 to 9)
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
msgmni has been set to 59
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
TCP cubic registered
NET: Registered protocol family 17
Initialized stdio console driver
Console initialized on /dev/tty0
console [tty0] enabled
Initializing software serial port version 1
console [mc-1] enabled
 ubda:
VFS: Mounted root (ext2 filesystem) readonly on device 98:0.
IRQ 3/console-write: IRQF_DISABLED is not guaranteed on shared IRQs
IRQ 2/console: IRQF_DISABLED is not guaranteed on shared IRQs
IRQ 10/winch: IRQF_DISABLED is not guaranteed on shared IRQs
BUG: Bad page map in process linux.uml  pte:00139045 pmd:0f8aa1e1
page:08a06720 flags:00000400 count:1 mapcount:-1 mapping:(null) index:0
addr:00100000 vm_flags:00060055 anon_vma:(null) mapping:(null) index:100
vma->vm_ops->fault: special_mapping_fault+0x0/0x47
1793fd64:  [<0817e79a>] dump_stack+0x1c/0x20
1793fd7c:  [<080a0def>] print_bad_pte+0x16d/0x17d
1793fdac:  [<080a16d0>] unmap_vmas+0x273/0x46f
1793fe04:  [<080a4719>] unmap_region+0x82/0xfe
1793fe3c:  [<080a5361>] do_munmap+0x1f6/0x245
1793fe6c:  [<080a5bc8>] mmap_region+0xc4/0x3fd
1793feb8:  [<080a610b>] do_mmap_pgoff+0x20a/0x253
1793fef0:  [<080589d7>] sys_mmap2+0x60/0x8e
1793ff28:  [<08059f83>] handle_syscall+0x7b/0x98
1793ff78:  [<08068d54>] userspace+0x2ca/0x371
1793ffe0:  [<08057d4e>] fork_handler+0x53/0x5b
1793fffc:  [<00000000>] 0x0

BUG: Bad page state in process linux.uml  pfn:00139
page:08a06720 flags:00000400 count:0 mapcount:-1 mapping:(null) index:0
1793fd14:  [<0817e79a>] dump_stack+0x1c/0x20
1793fd2c:  [<08096ce5>] bad_page+0xd1/0xe8
1793fd60:  [<08097397>] free_hot_cold_page+0xa1/0x15d
1793fd7c:  [<08097498>] free_hot_page+0xd/0xf
1793fd84:  [<08099d94>] put_page+0xe1/0xea
1793fd9c:  [<080a9599>] free_page_and_swap_cache+0x32/0x38
1793fdac:  [<080a16e1>] unmap_vmas+0x284/0x46f
1793fe04:  [<080a4719>] unmap_region+0x82/0xfe
1793fe3c:  [<080a5361>] do_munmap+0x1f6/0x245
1793fe6c:  [<080a5bc8>] mmap_region+0xc4/0x3fd
1793feb8:  [<080a610b>] do_mmap_pgoff+0x20a/0x253
1793fef0:  [<080589d7>] sys_mmap2+0x60/0x8e
1793ff28:  [<08059f83>] handle_syscall+0x7b/0x98
1793ff78:  [<08068d54>] userspace+0x2ca/0x371
1793ffe0:  [<08057d4e>] fork_handler+0x53/0x5b
1793fffc:  [<00000000>] 0x0

BUG: Bad page map in process linux.uml  pte:0f948045 pmd:0f8aa1e1
page:08bf6900 flags:(null) count:1 mapcount:-1 mapping:(null) index:0
addr:00101000 vm_flags:00060055 anon_vma:(null) mapping:(null) index:101
vma->vm_ops->fault: special_mapping_fault+0x0/0x47
1793fd64:  [<0817e79a>] dump_stack+0x1c/0x20
1793fd7c:  [<080a0def>] print_bad_pte+0x16d/0x17d
1793fdac:  [<080a16d0>] unmap_vmas+0x273/0x46f
1793fe04:  [<080a4719>] unmap_region+0x82/0xfe
1793fe3c:  [<080a5361>] do_munmap+0x1f6/0x245
1793fe6c:  [<080a5bc8>] mmap_region+0xc4/0x3fd
1793feb8:  [<080a610b>] do_mmap_pgoff+0x20a/0x253
1793fef0:  [<080589d7>] sys_mmap2+0x60/0x8e
1793ff28:  [<08059f83>] handle_syscall+0x7b/0x98
1793ff78:  [<08068d54>] userspace+0x2ca/0x371
1793ffe0:  [<08057d4e>] fork_handler+0x53/0x5b
1793fffc:  [<00000000>] 0x0

BUG: Bad page state in process linux.uml  pfn:0f948
page:08bf6900 flags:(null) count:0 mapcount:-1 mapping:(null) index:0
1793fd14:  [<0817e79a>] dump_stack+0x1c/0x20
1793fd2c:  [<08096ce5>] bad_page+0xd1/0xe8
1793fd60:  [<08097397>] free_hot_cold_page+0xa1/0x15d
1793fd7c:  [<08097498>] free_hot_page+0xd/0xf
1793fd84:  [<08099d94>] put_page+0xe1/0xea
1793fd9c:  [<080a9599>] free_page_and_swap_cache+0x32/0x38
1793fdac:  [<080a16e1>] unmap_vmas+0x284/0x46f
1793fe04:  [<080a4719>] unmap_region+0x82/0xfe
1793fe3c:  [<080a5361>] do_munmap+0x1f6/0x245
1793fe6c:  [<080a5bc8>] mmap_region+0xc4/0x3fd
1793feb8:  [<080a610b>] do_mmap_pgoff+0x20a/0x253
1793fef0:  [<080589d7>] sys_mmap2+0x60/0x8e
1793ff28:  [<08059f83>] handle_syscall+0x7b/0x98
1793ff78:  [<08068d54>] userspace+0x2ca/0x371
1793ffe0:  [<08057d4e>] fork_handler+0x53/0x5b
1793fffc:  [<00000000>] 0x0

Kernel panic - not syncing: Attempted to kill init!

EIP: 0073:[<40001696>] CPU: 0 Not tainted ESP: 007b:bfa9e180 EFLAGS: 00010286
    Not tainted
EAX: 00008000 EBX: 00000000 ECX: 00000000 EDX: 00000000
ESI: 00000000 EDI: 00000000 EBP: 00000000 DS: 007b ES: 007b
09c5bd7c:  [<0806b5f1>] show_regs+0xc4/0xcb
09c5bda8:  [<08059b1a>] panic_exit+0x25/0x3b
09c5bdbc:  [<08085077>] notifier_call_chain+0x27/0x4c
09c5bde4:  [<080850ca>] atomic_notifier_call_chain+0x15/0x17
09c5bdf4:  [<0817e7ea>] panic+0x4c/0xd2
09c5be10:  [<0807489c>] do_exit+0x66/0x634
09c5be5c:  [<08074ec7>] do_group_exit+0x5d/0x89
09c5be78:  [<0807cad9>] get_signal_to_deliver+0x28d/0x2a4
09c5bea4:  [<08058610>] do_signal+0x203/0x2e3
09c5bf78:  [<08057cf9>] interrupt_end+0x37/0x39
09c5bf84:  [<08068dec>] userspace+0x362/0x371
09c5bfe8:  [<08057dd1>] new_thread_handler+0x7b/0x87
09c5bffc:  [<00000000>] 0x0

Segmentation fault
(none):~# 



------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

