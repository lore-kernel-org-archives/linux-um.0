Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <pbutler@pt.com>) id 1UOd1O-0006iv-H9
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 06 Apr 2013 23:59:46 +0000
Received: from ottawa.pt.com ([209.217.107.194] helo=ottgw.pt.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UOd1L-00005I-TC for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 06 Apr 2013 23:59:46 +0000
Message-ID: <51180.173.206.136.128.1365292755.squirrel@webmail3.pt.com>
In-Reply-To: <51054.173.206.136.128.1365288799.squirrel@webmail3.pt.com>
References: <45722.173.206.176.149.1364962278.squirrel@webmail3.pt.com>
	<20130405092141.61f2f61c@spider.haslach.nod.at>
	<OFF553D1A8.B32C41CE-ON85257B44.004D6DD3-85257B44.004D81FA@pt.com>
	<20130405160739.68d74008@spider.haslach.nod.at>
	<OF04169121.A123E516-ON85257B44.004E1BE5-85257B44.004E21A8@pt.com>
	<20130405161541.6e4a2472@spider.haslach.nod.at>
	<39656.10.100.142.174.1365215174.squirrel@webmail3.pt.com>
	<515FE511.8060601@nod.at>
	<39111.173.206.136.128.1365266052.squirrel@webmail3.pt.com>
	<51604F00.10507@nod.at>
	<51054.173.206.136.128.1365288799.squirrel@webmail3.pt.com>
Date: Sat, 6 Apr 2013 19:59:15 -0400 (EDT)
From: "Peter Butler" <pbutler@pt.com>
MIME-Version: 1.0
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
Subject: Re: [uml-devel] BUG: failure at
 block/blk-core.c:2985/blk_flush_plug_list()
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net

Here's another one where the crash is from startup rather than shutdown:


Core dump limits :
        soft - 0
        hard - NONE
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...OK
Checking advanced syscall emulation patch for ptrace...OK
Checking for tmpfs mount on /dev/shm...nothing mounted on /dev/shm
Checking PROT_EXEC mmap in /tmp/...OK
Checking for the skas3 patch in the host:
  - /proc/mm...not found: No such file or directory
  - PTRACE_FAULTINFO...not found
  - PTRACE_LDT...not found
UML running in SKAS0 mode
Adding 21495808 bytes to physical memory to account for exec-shield gap
Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Linux version 3.9.0-rc5 (pbutler@ufo) (gcc version 4.7.2 (Ubuntu/Linaro
4.7.2-2ubuntu1) ) #1 Sat Apr 6 13:15:06 EDT 2013
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1039416
Kernel command line: ubd0=Fedora18-AMD64-root_fs rw mem=4096M
con0=fd:0,fd:1 root=98:0
PID hash table entries: 4096 (order: 3, 32768 bytes)
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Memory: 4068860k available
NR_IRQS:15
Calibrating delay loop... 5215.84 BogoMIPS (lpj=26079232)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 256
Initializing cgroup subsys cpuacct
Initializing cgroup subsys devices
Initializing cgroup subsys freezer
Initializing cgroup subsys blkio
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
devtmpfs: initialized
Using 2.6 host AIO
NET: Registered protocol family 16
bio: create slab <bio-0> at 0
Switching to clocksource itimer
NET: Registered protocol family 2
TCP established hash table entries: 32768 (order: 7, 524288 bytes)
TCP bind hash table entries: 32768 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP: reno registered
UDP hash table entries: 2048 (order: 4, 65536 bytes)
UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes)
NET: Registered protocol family 1
mconsole (version 2) initialized on /home/pbutler/.uml/U0YR3q/mconsole
Checking host MADV_REMOVE support...OK
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
msgmni has been set to 7946
io scheduler noop registered
io scheduler deadline registered (default)
TCP: cubic registered
NET: Registered protocol family 17
Initialized stdio console driver
Console initialized on /dev/tty0
console [tty0] enabled
Initializing software serial port version 1
console [mc-1] enabled
 ubda: unknown partition table
EXT4-fs (ubda): couldn't mount as ext3 due to feature incompatibilities
EXT4-fs (ubda): couldn't mount as ext2 due to feature incompatibilities
EXT4-fs (ubda): warning: maximal mount count reached, running e2fsck is
recommended
EXT4-fs (ubda): mounted filesystem with ordered data mode. Opts: (null)
VFS: Mounted root (ext4 filesystem) on device 98:0.
devtmpfs: mounted
systemd[1]: systemd 197 running in system mode. (+PAM +LIBWRAP +AUDIT
+SELINUX +IMA +SYSVINIT +LIBCRYPTSETUP +GCRYPT +ACL +XZ)

Welcome to Fedora 18 (Spherical Cow)!

systemd[1]: Failed to insert module 'autofs4'
systemd[1]: No hostname configured.
systemd[1]: Set hostname to <localhost>.
systemd[1]: Failed to enable kbrequest handling: Inappropriate ioctl for
device
systemd[1]: Cannot add dependency job for unit display-manager.service,
ignoring: Unit display-manager.service failed to load: No such file or
directory. See system logs and 'systemctl status display-manager.service'
for details.
systemd[1]: Started Replay Read-Ahead Data.
systemd[1]: Starting Collect Read-Ahead Data...
         Starting Collect Read-Ahead Data...
systemd[1]: Starting Forward Password Requests to Wall Directory Watch.
systemd[1]: Started Forward Password Requests to Wall Directory Watch.
systemd[1]: Starting Remote File Systems.
[  OK  ] Reached target Remote File Systems.
systemd-readahead[228]: Failed to create fanotify object: Function not
implemented
systemd[1]: Reached target Remote File Systems.
systemd[1]: Starting Syslog Socket.
[  OK  ] Listening on Syslog Socket.
systemd[1]: Listening on Syslog Socket.
systemd[1]: Starting /dev/initctl Compatibility Named Pipe.
[  OK  ] Listening on /dev/initctl Compatibility Named Pipe.
systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
systemd[1]: Starting Delayed Shutdown Socket.
[  OK  ] Listening on Delayed Shutdown Socket.
systemd[1]: Listening on Delayed Shutdown Socket.
systemd[1]: Starting Encrypted Volumes.
[  OK  ] Reached target Encrypted Volumes.
systemd[1]: Reached target Encrypted Volumes.
systemd[1]: Starting Arbitrary Executable File Formats File System
Automount Point.
systemd[1]: Failed to open /dev/autofs: No such file or directory
systemd[1]: Failed to initialize automounter: No such file or directory
[FAILED] Failed to set up automount Arbitrary Executable File...utomount
Point.
See 'systemctl status proc-sys-fs-binfmt_misc.automount' for details.
systemd[1]: Failed to set up automount Arbitrary Executable File Formats
File System Automount Point.
systemd[1]: Unit proc-sys-fs-binfmt_misc.automount entered failed state
systemd[1]: Starting LVM2 metadata daemon socket.
[  OK  ] Listening on LVM2 metadata daemon socket.
systemd[1]: Listening on LVM2 metadata daemon socket.
systemd[1]: Starting Device-mapper event daemon FIFOs.
[  OK  ] Listening on Device-mapper event daemon FIFOs.
systemd[1]: Listening on Device-mapper event daemon FIFOs.
systemd[1]: Starting Swap.
[  OK  ] Reached target Swap.
systemd[1]: Reached target Swap.
systemd[1]: Starting udev Kernel Socket.
[  OK  ] Listening on udev Kernel Socket.
systemd[1]: Listening on udev Kernel Socket.
systemd[1]: Starting udev Control Socket.
[  OK  ] Listening on udev Control Socket.
systemd[1]: Listening on udev Control Socket.
systemd[1]: Starting Journal Socket.
[  OK  ] Listening on Journal Socket.
systemd[1]: Listening on Journal Socket.
systemd[1]: Starting Syslog.
[  OK  ] Reached target Syslog.
systemd[1]: Reached target Syslog.
systemd[1]: Mounting Temporary Directory...
         Mounting Temporary Directory...
systemd[1]: tmp.mount: Directory /tmp to mount over is not empty, mounting
anyway.
systemd[1]: Started Import network configuration from initramfs.
systemd[1]: Starting Configure read-only root support...
         Starting Configure read-only root support...
systemd[1]: Mounted Huge Pages File System.
systemd[1]: Starting Journal Service...
         Starting Journal Service...
[  OK  ] Started Journal Service.
systemd[1]: Started Journal Service.
systemd[1]: Mounted Debug File System.
systemd[1]: Mounting POSIX Message Queue File System...
         Mounting POSIX Message Queue File System...
systemd[1]: Starting udev Kernel Device Manager...
         Starting udev Kernel Device Manager...
systemd[1]: Starting udev Coldplug all Devices...
         Starting udev Coldplug all Devices...
systemd[1]: systemd-readahead-collect.service: main process exited,
code=exited, status=1/FAILURE
[  OK  ] Started Collect Read-Ahead Data.
systemd[1]: Started Collect Read-Ahead Data.
[  OK  ] Mounted Temporary Directory.
systemd[1]: Mounted Temporary Directory.
systemd[1]: Started Load legacy module configuration.
systemd[1]: Started Load Kernel Modules.
systemd[1]: Mounted Configuration File System.
systemd[1]: Mounted FUSE Control File System.
systemd[1]: Started File System Check on Root Device.
systemd[1]: Starting Remount Root and Kernel File Systems...
         Starting Remount Root and Kernel File Systems...
systemd[1]: Started Set Up Additional Binary Formats.
systemd[1]: Starting Apply Kernel Variables...
         Starting Apply Kernel Variables...
systemd[1]: Starting Setup Virtual Console...
         Starting Setup Virtual Console...
[  OK  ] Started Remount Root and Kernel File Systems.
[  OK  ] Reached target Local File Systems (Pre).
         Starting Load Random Seed...
[  OK  ] Started udev Kernel Device Manager.
systemd-udevd[238]: starting version 197
[  OK  ] Started Apply Kernel Variables.
[FAILED] Failed to start Setup Virtual Console.
See 'systemctl status systemd-vconsole-setup.service' for details.
[  OK  ] Started Load Random Seed.
[  OK  ] Started udev Coldplug all Devices.
         Starting udev Wait for Complete Device Initialization...
         Starting Show Plymouth Boot Screen...
[  OK  ] Started Configure read-only root support.
[  OK  ] Mounted POSIX Message Queue File System.
systemd-journald[234]: Received SIGUSR1
BUG: scheduling while atomic: systemd-logind/479/0x00000001
Modules linked in:
Call Trace:
15fe75e70:  [<6024c6ea>] __schedule_bug+0x6e/0x83
15fe75e78:  [<60046970>] sigsuspend+0x0/0x9e
15fe75e80:  [<60046970>] sigsuspend+0x0/0x9e
15fe75e90:  [<6024fefc>] __schedule+0x67/0x3ca
15fe75ea0:  [<6005c136>] pick_next_task_fair+0x0/0x127
15fe75ec0:  [<60046970>] sigsuspend+0x0/0x9e
15fe75ed0:  [<600182c0>] _init+0x7e0/0x8b0
15fe75ef0:  [<602503cc>] schedule+0x76/0x78
15fe75f00:  [<6004579c>] set_current_blocked+0x17/0x19
15fe75f10:  [<600469cc>] sigsuspend+0x5c/0x9e
15fe75f30:  [<6001e6da>] winch_thread+0x204/0x242
15fe75fd0:  [<6001e4d6>] winch_thread+0x0/0x242

BUG: Bad page state in process systemd-logind  pfn:feac0
page:0000000069020a00 count:0 mapcount:1 mapping:          (null)
index:0x552ad48
page flags: 0x80008(uptodate|swapbacked)
Modules linked in:
Call Trace:
15fe47b58:  [<60085001>] bad_page+0x13f/0x163
15fe47b88:  [<6008509a>] free_pages_prepare+0x75/0xb0
15fe47bc8:  [<60086565>] free_hot_cold_page+0x26/0x140
15fe47bf0:  [<6008653f>] free_hot_cold_page+0x0/0x140
15fe47c08:  [<60086928>] free_hot_cold_page_list+0x31/0x51
15fe47c38:  [<600893ab>] release_pages+0x19a/0x1a9
15fe47c88:  [<60088da0>] __pagevec_lru_add_fn+0x0/0x78
15fe47c98:  [<60089488>] pagevec_lru_move_fn+0xce/0xe4
15fe47cd8:  [<6008949e>] __pagevec_lru_add+0x0/0x1e
15fe47cf8:  [<600894ba>] __pagevec_lru_add+0x1c/0x1e
15fe47d08:  [<60089a3b>] lru_add_drain_cpu+0x30/0xb5
15fe47d38:  [<60089b35>] lru_add_drain+0x12/0x14
15fe47d48:  [<6009c3c2>] unmap_region+0x3b/0xfc
15fe47d68:  [<6009c783>] vma_rb_erase+0x194/0x1e7
15fe47dc8:  [<6009ddc9>] do_munmap+0x25e/0x2fe
15fe47e28:  [<6009debb>] vm_munmap+0x52/0x74
15fe47e38:  [<600ae7b7>] ____fput+0x10/0x12
15fe47e68:  [<60017f80>] _init+0x4a0/0x8b0
15fe47e78:  [<6009deed>] sys_munmap+0x10/0x14
15fe47e88:  [<6001ca91>] handle_syscall+0x65/0x7c
15fe47ea8:  [<6002fe6c>] userspace+0x408/0x57a
15fe47f78:  [<6002bc17>] save_registers+0x1f/0x39
15fe47f88:  [<60032bd3>] arch_prctl+0xfb/0x171
15fe47fd8:  [<60019909>] fork_handler+0x85/0x87

Disabling lock debugging due to kernel taint
BUG: Bad page state in process systemd-logind  pfn:feac1
page:0000000069020a38 count:0 mapcount:1 mapping:          (null)
index:0x552ad47
page flags: 0x80008(uptodate|swapbacked)
Modules linked in:
Call Trace:
15fe47b58:  [<60085001>] bad_page+0x13f/0x163
15fe47b88:  [<6008509a>] free_pages_prepare+0x75/0xb0
15fe47bc8:  [<60086565>] free_hot_cold_page+0x26/0x140
15fe47bf0:  [<6008653f>] free_hot_cold_page+0x0/0x140
15fe47c08:  [<60086928>] free_hot_cold_page_list+0x31/0x51
15fe47c38:  [<600893ab>] release_pages+0x19a/0x1a9
15fe47c88:  [<60088da0>] __pagevec_lru_add_fn+0x0/0x78
15fe47c98:  [<60089488>] pagevec_lru_move_fn+0xce/0xe4
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

15fe47cd8:  [<6008949e>]Call Trace:
161045b38:  [<6024be78>] __pagevec_lru_add+0x0/0x1e panic+0x145/0x2a7

161045b70:  [<6024bd33>]15fe47cf8:  [<600894ba>] panic+0x0/0x2a7
 __pagevec_lru_add+0x1c/0x1e161045b78:  [<6007768c>]
 cgroup_exit+0x6d/0xde15fe47d08:  [<60089a3b>]
161045b98:  [<600bffdd>] lru_add_drain_cpu+0x30/0xb5 d_free+0xc7/0xe4

161045c48:  [<6003a648>]15fe47d38:  [<60089b35>]
forget_original_parent+0xe5/0x404 lru_add_drain+0x12/0x14
161045cb8:  [<6003ac75>]
 do_exit+0x30e/0x52615fe47d48:  [<6009c3c2>]
161045ce8:  [<6004507d>] unmap_region+0x3b/0xfc
get_signal_to_deliver+0x0/0x506

161045cf8:  [<6003b077>]15fe47d68:  [<6009c783>] do_group_exit+0xbb/0x10c
 vma_rb_erase+0x194/0x1e7161045d08:  [<6004507d>]
get_signal_to_deliver+0x0/0x506

161045d28:  [<6004555d>]15fe47dc8:  [<6009ddc9>]
get_signal_to_deliver+0x4e0/0x506
 do_munmap+0x25e/0x2fe161045d48:  [<60043316>] signal_wake_up_state+0x1b/0x1d
15fe47e28:  [<6009debb>]161045d68:  [<6004507d>]
get_signal_to_deliver+0x0/0x506 vm_munmap+0x52/0x74
161045d70:  [<6001a76c>]
 handle_signal+0x0/0x1d215fe47e38:  [<600ae7b7>]
161045d88:  [<6001a99f>] ____fput+0x10/0x12 kern_do_signal+0x61/0x14d

161045db8:  [<600439c9>] __send_signal.constprop.26+0x1f5/0x22615fe47e68: 
[<60017f80>]
161045e18:  [<60044468>] _init+0x4a0/0x8b0 force_sig_info+0xc9/0xd8

161045e20:  [<60017f80>]15fe47e78:  [<6009deed>] _init+0x4a0/0x8b0
 sys_munmap+0x10/0x14161045e58:  [<60017f80>] _init+0x4a0/0x8b0
15fe47e88:  [<6001ca91>]161045e68:  [<6001aab3>] do_signal+0x28/0x2d
handle_syscall+0x65/0x7c
161045e88:  [<6001be44>]
 fatal_sigsegv+0x32/0x3e15fe47ea8:  [<6002fe6c>]161045ea8:  [<6002fbfa>]
userspace+0x408/0x57a

161045f68:  [<6001849c>] run_init_process+0x0/0x2915fe47f78:  [<6002bc17>]
161045f98:  [<600b3c39>] save_registers+0x1f/0x39 do_execve+0x10/0x12

161045fd8:  [<600199ac>]15fe47f88:  [<60032bd3>] new_thread_handler+0xa1/0xa3
 arch_prctl+0xfb/0x171

Modules linked in:15fe47fd8:  [<60019909>]
Pid: 1, comm: systemd Tainted: G        W    3.9.0-rc5
 fork_handler+0x85/0x87RIP: 0033:[<0000000041a00a33>]

RSP: 0000007fbfd65548  EFLAGS: 00000246

RDX: 0000000000000001 RSI: 0000007fbfd655f0 RDI: 0000000000000004
RBP: 0000000000c326c4 R08: 0000000000000ad8 R09: 0000000000000007
R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000000001
page:0000000069020a70 count:0 mapcount:1 mapping:          (null)
index:0x552ad46
R13: 000000552ab3b360 R14: 000000552ab3a299 R15: 00000000000001ed
Call Trace:
page flags: 0x80008(161045a90:  [<6006b2d6>]uptodate
__module_text_address+0x14/0x5a
|swapbacked161045aa8:  [<6001c48f>] panic_exit+0x3a/0x58
Modules linked in:161045ab8:  [<6004eba2>]
 __kernel_text_address+0x30/0x5c
Call Trace:
161045ad8:  [<60055b34>]15fe47b58:  [<60085001>]
161045b18:  [<60055b6e>] bad_page+0x13f/0x163
__atomic_notifier_call_chain+0x10/0x12

161045b28:  [<60055b86>]15fe47b88:  [<6008509a>]
atomic_notifier_call_chain+0x16/0x18 free_pages_prepare+0x75/0xb0
161045b38:  [<6024beab>]
 panic+0x178/0x2a715fe47bc8:  [<60086565>]
161045b70:  [<6024bd33>] free_hot_cold_page+0x26/0x140 panic+0x0/0x2a7

161045b78:  [<6007768c>]15fe47bf0:  [<6008653f>] cgroup_exit+0x6d/0xde
free_hot_cold_page+0x0/0x140
161045b98:  [<600bffdd>]
 d_free+0xc7/0xe415fe47c08:  [<60086928>]
161045c48:  [<6003a648>] free_hot_cold_page_list+0x31/0x51
forget_original_parent+0xe5/0x404

161045cb8:  [<6003ac75>]15fe47c38:  [<600893ab>] do_exit+0x30e/0x526
161045ce8:  [<6004507d>]
 get_signal_to_deliver+0x0/0x506
15fe47c88:  [<60088da0>]161045cf8:  [<6003b077>] do_group_exit+0xbb/0x10c
__pagevec_lru_add_fn+0x0/0x78
161045d08:  [<6004507d>]
 get_signal_to_deliver+0x0/0x506
15fe47c98:  [<60089488>]161045d28:  [<6004555d>]
get_signal_to_deliver+0x4e0/0x506 pagevec_lru_move_fn+0xce/0xe4
161045d48:  [<60043316>]
 signal_wake_up_state+0x1b/0x1d15fe47cd8:  [<6008949e>]
161045d68:  [<6004507d>] __pagevec_lru_add+0x0/0x1e
get_signal_to_deliver+0x0/0x506

161045d70:  [<6001a76c>]15fe47cf8:  [<600894ba>]
161045d88:  [<6001a99f>] __pagevec_lru_add+0x1c/0x1e
kern_do_signal+0x61/0x14d

161045db8:  [<600439c9>]15fe47d08:  [<60089a3b>]
__send_signal.constprop.26+0x1f5/0x226
 lru_add_drain_cpu+0x30/0xb5161045e18:  [<60044468>] save_registers+0x1f/0x39
15fe47f88:  [<60032bd3>] arch_prctl+0xfb/0x171
15fe47fd8:  [<60019909>] fork_handler+0x85/0x87

BUG: Bad page state in process systemd-logind  pfn:feac3
page:0000000069020aa8 count:0 mapcount:1 mapping:          (null)
index:0x552ad45
page flags: 0x80008(uptodate|swapbacked)
Modules linked in:
Call Trace:
15fe47b58:  [<60085001>] bad_page+0x13f/0x163
15fe47b88:  [<6008509a>] free_pages_prepare+0x75/0xb0
15fe47bc8:  [<60086565>] free_hot_cold_page+0x26/0x140
15fe47bf0:  [<6008653f>] free_hot_cold_page+0x0/0x140
15fe47c08:  [<60086928>] free_hot_cold_page_list+0x31/0x51
15fe47c38:  [<600893ab>] release_pages+0x19a/0x1a9
15fe47c88:  [<60088da0>] __pagevec_lru_add_fn+0x0/0x78
15fe47c98:  [<60089488>] pagevec_lru_move_fn+0xce/0xe4
15fe47cd8:  [<6008949e>] __pagevec_lru_add+0x0/0x1e
15fe47cf8:  [<600894ba>] __pagevec_lru_add+0x1c/0x1e
15fe47d08:  [<60089a3b>] lru_add_drain_cpu+0x30/0xb5
15fe47d38:  [<60089b35>] lru_add_drain+0x12/0x14
15fe47d48:  [<6009c3c2>] unmap_region+0x3b/0xfc
15fe47d68:  [<6009c783>] vma_rb_erase+0x194/0x1e7
15fe47dc8:  [<6009ddc9>] do_munmap+0x25e/0x2fe
15fe47e28:  [<6009debb>] vm_munmap+0x52/0x74
15fe47e38:  [<600ae7b7>] ____fput+0x10/0x12
15fe47e68:  [<60017f80>] _init+0x4a0/0x8b0
15fe47e78:  [<6009deed>] sys_munmap+0x10/0x14
15fe47e88:  [<6001ca91>] handle_syscall+0x65/0x7c
15fe47ea8:  [<6002fe6c>] userspace+0x408/0x57a
15fe47f78:  [<6002bc17>] save_registers+0x1f/0x39
15fe47f88:  [<60032bd3>] arch_prctl+0xfb/0x171
15fe47fd8:  [<60019909>] fork_handler+0x85/0x87

BUG: Bad page state in process systemd-logind  pfn:feac4
page:0000000069020ae0 count:0 mapcount:1 mapping:          (null)
index:0x40021
page flags: 0x80008(uptodate|swapbacked)
Modules linked in:
Call Trace:
15fe47b58:  [<60085001>] bad_page+0x13f/0x163
15fe47b88:  [<6008509a>] free_pages_prepare+0x75/0xb0
15fe47bc8:  [<60086565>] free_hot_cold_page+0x26/0x140
15fe47bf0:  [<6008653f>] free_hot_cold_page+0x0/0x140
15fe47c08:  [<60086928>] free_hot_cold_page_list+0x31/0x51
15fe47c38:  [<600893ab>] release_pages+0x19a/0x1a9
15fe47c88:  [<60088da0>] __pagevec_lru_add_fn+0x0/0x78
15fe47c98:  [<60089488>] pagevec_lru_move_fn+0xce/0xe4
15fe47cd8:  [<6008949e>] __pagevec_lru_add+0x0/0x1e
15fe47cf8:  [<600894ba>] __pagevec_lru_add+0x1c/0x1e
15fe47d08:  [<60089a3b>] lru_add_drain_cpu+0x30/0xb5
15fe47d38:  [<60089b35>] lru_add_drain+0x12/0x14
15fe47d48:  [<6009c3c2>] unmap_region+0x3b/0xfc
15fe47d68:  [<6009c783>] vma_rb_erase+0x194/0x1e7
15fe47dc8:  [<6009ddc9>] do_munmap+0x25e/0x2fe
15fe47e28:  [<6009debb>] vm_munmap+0x52/0x74
15fe47e38:  [<600ae7b7>] ____fput+0x10/0x12
15fe47e68:  [<60017f80>] _init+0x4a0/0x8b0
15fe47e78:  [<6009deed>] sys_munmap+0x10/0x14
15fe47e88:  [<6001ca91>] handle_syscall+0x65/0x7c
15fe47ea8:  [<6002fe6c>] userspace+0x408/0x57a
15fe47f78:  [<6002bc17>] save_registers+0x1f/0x39
15fe47f88:  [<60032bd3>] arch_prctl+0xfb/0x171
15fe47fd8:  [<60019909>] fork_handler+0x85/0x87

BUG: Bad page state in process systemd-logind  pfn:feac7
page:0000000069020b88 count:0 mapcount:1 mapping:          (null)
index:0x41040
page flags: 0x80008(uptodate|swapbacked)
Modules linked in:
Call Trace:
15fe47b58:  [<60085001>] bad_page+0x13f/0x163
15fe47b88:  [<6008509a>] free_pages_prepare+0x75/0xb0
15fe47bc8:  [<60086565>] free_hot_cold_page+0x26/0x140
15fe47bf0:  [<6008653f>] free_hot_cold_page+0x0/0x140
15fe47c08:  [<60086928>] free_hot_cold_page_list+0x31/0x51
15fe47c38:  [<600893ab>] release_pages+0x19a/0x1a9
15fe47c88:  [<60088da0>] __pagevec_lru_add_fn+0x0/0x78
15fe47c98:  [<60089488>] pagevec_lru_move_fn+0xce/0xe4
15fe47cd8:  [<6008949e>] __pagevec_lru_add+0x0/0x1e
15fe47cf8:  [<600894ba>] __pagevec_lru_add+0x1c/0x1e
15fe47d08:  [<60089a3b>] lru_add_drain_cpu+0x30/0xb5
15fe47d38:  [<60089b35>] lru_add_drain+0x12/0x14
15fe47d48:  [<6009c3c2>] unmap_region+0x3b/0xfc
15fe47d68:  [<6009c783>] vma_rb_erase+0x194/0x1e7
15fe47dc8:  [<6009ddc9>] do_munmap+0x25e/0x2fe
15fe47e28:  [<6009debb>] vm_munmap+0x52/0x74
15fe47e38:  [<600ae7b7>] ____fput+0x10/0x12
15fe47e68:  [<60017f80>] _init+0x4a0/0x8b0
15fe47e78:  [<6009deed>] sys_munmap+0x10/0x14
15fe47e88:  [<6001ca91>] handle_syscall+0x65/0x7c
15fe47ea8:  [<6002fe6c>] userspace+0x408/0x57a
15fe47f78:  [<6002bc17>] save_registers+0x1f/0x39
15fe47f88:  [<60032bd3>] arch_prctl+0xfb/0x171
15fe47fd8:  [<60019909>] fork_handler+0x85/0x87

BUG: Bad page state in process systemd-logind  pfn:feac8
page:0000000069020bc0 count:0 mapcount:1 mapping:          (null) index:0x6e4
page flags: 0x80008(uptodate|swapbacked)
Modules linked in:
Call Trace:
15fe47b58:  [<60085001>] bad_page+0x13f/0x163
15fe47b88:  [<6008509a>] free_pages_prepare+0x75/0xb0
15fe47bc8:  [<60086565>] free_hot_cold_page+0x26/0x140
15fe47bf0:  [<6008653f>] free_hot_cold_page+0x0/0x140
15fe47c08:  [<60086928>] free_hot_cold_page_list+0x31/0x51
15fe47c38:  [<600893ab>] release_pages+0x19a/0x1a9
15fe47c88:  [<60088da0>] __pagevec_lru_add_fn+0x0/0x78
15fe47c98:  [<60089488>] pagevec_lru_move_fn+0xce/0xe4
15fe47cd8:  [<6008949e>] __pagevec_lru_add+0x0/0x1e
15fe47cf8:  [<600894ba>] __pagevec_lru_add+0x1c/0x1e
15fe47d08:  [<60089a3b>] lru_add_drain_cpu+0x30/0xb5
15fe47d38:  [<60089b35>] lru_add_drain+0x12/0x14
15fe47d48:  [<6009c3c2>] unmap_region+0x3b/0xfc
15fe47d68:  [<6009c783>] vma_rb_erase+0x194/0x1e7
15fe47dc8:  [<6009ddc9>] do_munmap+0x25e/0x2fe
15fe47e28:  [<6009debb>] vm_munmap+0x52/0x74
15fe47e38:  [<600ae7b7>] ____fput+0x10/0x12
15fe47e68:  [<60017f80>] _init+0x4a0/0x8b0
15fe47e78:  [<6009deed>] sys_munmap+0x10/0x14
15fe47e88:  [<6001ca91>] handle_syscall+0x65/0x7c
15fe47ea8:  [<6002fe6c>] userspace+0x408/0x57a
15fe47f78:  [<6002bc17>] save_registers+0x1f/0x39
15fe47f88:  [<60032bd3>] arch_prctl+0xfb/0x171
15fe47fd8:  [<60019909>] fork_handler+0x85/0x87

BUG: Bad page state in process systemd-logind  pfn:feaa8
page:00000000690204c0 count:0 mapcount:1 mapping:          (null) index:0xda
page flags: 0x80008(uptodate|swapbacked)
Modules linked in:
Call Trace:
15fe47b58:  [<60085001>] bad_page+0x13f/0x163
15fe47b88:  [<6008509a>] free_pages_prepare+0x75/0xb0
15fe47bc8:  [<60086565>] free_hot_cold_page+0x26/0x140
15fe47bf0:  [<6008653f>] free_hot_cold_page+0x0/0x140
15fe47c08:  [<60086928>] free_hot_cold_page_list+0x31/0x51
15fe47c38:  [<600893ab>] release_pages+0x19a/0x1a9
15fe47c88:  [<60088da0>] __pagevec_lru_add_fn+0x0/0x78
15fe47c98:  [<60089488>] pagevec_lru_move_fn+0xce/0xe4
15fe47cd8:  [<6008949e>] __pagevec_lru_add+0x0/0x1e
15fe47cf8:  [<600894ba>] __pagevec_lru_add+0x1c/0x1e
15fe47d08:  [<60089a3b>] lru_add_drain_cpu+0x30/0xb5
15fe47d38:  [<60089b35>] lru_add_drain+0x12/0x14
15fe47d48:  [<6009c3c2>] unmap_region+0x3b/0xfc
15fe47d68:  [<6009c783>] vma_rb_erase+0x194/0x1e7
15fe47dc8:  [<6009ddc9>] do_munmap+0x25e/0x2fe
15fe47e28:  [<6009debb>] vm_munmap+0x52/0x74
15fe47e38:  [<600ae7b7>] ____fput+0x10/0x12
15fe47e68:  [<60017f80>] _init+0x4a0/0x8b0
15fe47e78:  [<6009deed>] sys_munmap+0x10/0x14
15fe47e88:  [<6001ca91>] handle_syscall+0x65/0x7c
15fe47ea8:  [<6002fe6c>] userspace+0x408/0x57a
15fe47f78:  [<6002bc17>] save_registers+0x1f/0x39
15fe47f88:  [<60032bd3>] arch_prctl+0xfb/0x171
15fe47fd8:  [<60019909>] fork_handler+0x85/0x87

BUG: Bad page state in process systemd-logind  pfn:feab8
page:0000000069020840 count:0 mapcount:0 mapping:0000000160e65400 index:0x2
page flags: 0x20008(uptodate|mappedtodisk)
Modules linked in:
Call Trace:
15fe47b58:  [<60085001>] bad_page+0x13f/0x163
15fe47b88:  [<6008509a>] free_pages_prepare+0x75/0xb0
15fe47bc8:  [<60086565>] free_hot_cold_page+0x26/0x140
15fe47bf0:  [<6008653f>] free_hot_cold_page+0x0/0x140
15fe47c08:  [<60086928>] free_hot_cold_page_list+0x31/0x51
15fe47c38:  [<600893ab>] release_pages+0x19a/0x1a9
15fe47c88:  [<60088da0>] __pagevec_lru_add_fn+0x0/0x78
15fe47c98:  [<60089488>] pagevec_lru_move_fn+0xce/0xe4
15fe47cd8:  [<6008949e>] __pagevec_lru_add+0x0/0x1e
15fe47cf8:  [<600894ba>] __pagevec_lru_add+0x1c/0x1e
15fe47d08:  [<60089a3b>] lru_add_drain_cpu+0x30/0xb5
15fe47d38:  [<60089b35>] lru_add_drain+0x12/0x14
15fe47d48:  [<6009c3c2>] unmap_region+0x3b/0xfc
15fe47d68:  [<6009c783>] vma_rb_erase+0x194/0x1e7
15fe47dc8:  [<6009ddc9>] do_munmap+0x25e/0x2fe
15fe47e28:  [<6009debb>] vm_munmap+0x52/0x74
15fe47e38:  [<600ae7b7>] ____fput+0x10/0x12
15fe47e68:  [<60017f80>] _init+0x4a0/0x8b0
15fe47e78:  [<6009deed>] sys_munmap+0x10/0x14
15fe47e88:  [<6001ca91>] handle_syscall+0x65/0x7c
15fe47ea8:  [<6002fe6c>] userspace+0x408/0x57a
15fe47f78:  [<6002bc17>] save_registers+0x1f/0x39
15fe47f88:  [<60032bd3>] arch_prctl+0xfb/0x171
15fe47fd8:  [<60019909>] fork_handler+0x85/0x87

BUG: Bad page state in process systemd-logind  pfn:feab7
page:0000000069020808 count:0 mapcount:0 mapping:0000000160e65400 index:0x1
page flags: 0x2000c(referenced|uptodate|mappedtodisk)
Modules linked in:
Call Trace:
15fe47b58:  [<60085001>] bad_page+0x13f/0x163
15fe47b88:  [<6008509a>] free_pages_prepare+0x75/0xb0
15fe47bc8:  [<60086565>] free_hot_cold_page+0x26/0x140
15fe47bf0:  [<6008653f>] free_hot_cold_page+0x0/0x140
15fe47c08:  [<60086928>] free_hot_cold_page_list+0x31/0x51
15fe47c38:  [<600893ab>] release_pages+0x19a/0x1a9
15fe47c88:  [<60088da0>] __pagevec_lru_add_fn+0x0/0x78
15fe47c98:  [<60089488>] pagevec_lru_move_fn+0xce/0xe4
15fe47cd8:  [<6008949e>] __pagevec_lru_add+0x0/0x1e
15fe47cf8:  [<600894ba>] __pagevec_lru_add+0x1c/0x1e
15fe47d08:  [<60089a3b>] lru_add_drain_cpu+0x30/0xb5
15fe47d38:  [<60089b35>] lru_add_drain+0x12/0x14
15fe47d48:  [<6009c3c2>] unmap_region+0x3b/0xfc
15fe47d68:  [<6009c783>] vma_rb_erase+0x194/0x1e7
15fe47dc8:  [<6009ddc9>] do_munmap+0x25e/0x2fe
15fe47e28:  [<6009debb>] vm_munmap+0x52/0x74
15fe47e38:  [<600ae7b7>] ____fput+0x10/0x12
15fe47e68:  [<60017f80>] _init+0x4a0/0x8b0
15fe47e78:  [<6009deed>] sys_munmap+0x10/0x14
15fe47e88:  [<6001ca91>] handle_syscall+0x65/0x7c
15fe47ea8:  [<6002fe6c>] userspace+0x408/0x57a
15fe47f78:  [<6002bc17>] save_registers+0x1f/0x39
15fe47f88:  [<60032bd3>] arch_prctl+0xfb/0x171
15fe47fd8:  [<60019909>] fork_handler+0x85/0x87

BUG: Bad page state in process systemd-logind  pfn:feab6
page:00000000690207d0 count:0 mapcount:0 mapping:0000000160e65400 index:0x0
page flags: 0x2000c(referenced|uptodate|mappedtodisk)
Modules linked in:
Call Trace:
15fe47b58:  [<60085001>] bad_page+0x13f/0x163
15fe47b88:  [<6008509a>] free_pages_prepare+0x75/0xb0
15fe47bc8:  [<60086565>] free_hot_cold_page+0x26/0x140
15fe47bf0:  [<6008653f>] free_hot_cold_page+0x0/0x140
15fe47c08:  [<60086928>] free_hot_cold_page_list+0x31/0x51
15fe47c38:  [<600893ab>] release_pages+0x19a/0x1a9
15fe47c88:  [<60088da0>] __pagevec_lru_add_fn+0x0/0x78
15fe47c98:  [<60089488>] pagevec_lru_move_fn+0xce/0xe4
15fe47cd8:  [<6008949e>] __pagevec_lru_add+0x0/0x1e
15fe47cf8:  [<600894ba>] __pagevec_lru_add+0x1c/0x1e
15fe47d08:  [<60089a3b>] lru_add_drain_cpu+0x30/0xb5
15fe47d38:  [<60089b35>] lru_add_drain+0x12/0x14
15fe47d48:  [<6009c3c2>] unmap_region+0x3b/0xfc
15fe47d68:  [<6009c783>] vma_rb_erase+0x194/0x1e7
15fe47dc8:  [<6009ddc9>] do_munmap+0x25e/0x2fe
15fe47e28:  [<6009debb>] vm_munmap+0x52/0x74
15fe47e38:  [<600ae7b7>] ____fput+0x10/0x12
15fe47e68:  [<60017f80>] _init+0x4a0/0x8b0
15fe47e78:  [<6009deed>] sys_munmap+0x10/0x14
15fe47e88:  [<6001ca91>] handle_syscall+0x65/0x7c
15fe47ea8:  [<6002fe6c>] userspace+0x408/0x57a
15fe47f78:  [<6002bc17>] save_registers+0x1f/0x39
15fe47f88:  [<60032bd3>] arch_prctl+0xfb/0x171
15fe47fd8:  [<60019909>] fork_handler+0x85/0x87





------------------------------------------------------------------------------
Minimize network downtime and maximize team effectiveness.
Reduce network management and security costs.Learn how to hire 
the most talented Cisco Certified professionals. Visit the 
Employer Resources Portal
http://www.cisco.com/web/learning/employer_resources/index.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

