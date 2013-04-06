Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <pbutler@pt.com>) id 1UObzc-0006CJ-Gq
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 06 Apr 2013 22:53:52 +0000
Received: from ottgw.pt.com ([209.217.107.194])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UObzX-0004K1-4g for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 06 Apr 2013 22:53:52 +0000
Message-ID: <51054.173.206.136.128.1365288799.squirrel@webmail3.pt.com>
In-Reply-To: <51604F00.10507@nod.at>
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
Date: Sat, 6 Apr 2013 18:53:19 -0400 (EDT)
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

OK setting SUBARCH did the trick.  Thanks for that.  :-)

Here's the output from a crash using the associated build.  Too several
boots to trigger the crash - probably some sort of a race condition.  Note
that I am doing nothing other than booting up the UML to trigger the crash
(that is, I am not doing anything at the command line).  If no crash
occurs I simply do a graceful shutdown and then start it up again (in
order to trigger a crash).  In this particular case the crash actually
occurred during the shutdown and triggered this bug:

BUG: scheduling while atomic: systemd-logind/485/0x00000001

Here's the full output:

bash $ ./linux ubd0=Fedora18-AMD64-root_fs rw mem=4096M con0=fd:0,fd:1

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
Adding 10190848 bytes to physical memory to account for exec-shield gap
Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Linux version 3.9.0-rc5 (pbutler@ufo) (gcc version 4.7.2 (Ubuntu/Linaro
4.7.2-2ubuntu1) ) #1 Sat Apr 6 13:15:06 EDT 2013
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1036693
Kernel command line: ubd0=Fedora18-AMD64-root_fs rw mem=4096M
con0=fd:0,fd:1 root=98:0
PID hash table entries: 4096 (order: 3, 32768 bytes)
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Memory: 4069176k available
NR_IRQS:15
Calibrating delay loop... 5532.87 BogoMIPS (lpj=27664384)
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
mconsole (version 2) initialized on /home/pbutler/.uml/cW8jYG/mconsole
Checking host MADV_REMOVE support...OK
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
msgmni has been set to 7947
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
[  OK  ] Mounted POSIX Message Queue File System.
[  OK  ] Started Remount Root and Kernel File Systems.
[  OK  ] Reached target Local File Systems (Pre).
         Starting Load Random Seed...
[  OK  ] Started Apply Kernel Variables.
[FAILED] Failed to start Setup Virtual Console.
See 'systemctl status systemd-vconsole-setup.service' for details.
[  OK  ] Started Load Random Seed.
[  OK  ] Started Configure read-only root support.
[  OK  ] Started udev Kernel Device Manager.
systemd-udevd[238]: starting version 197
[  OK  ] Started udev Coldplug all Devices.
         Starting udev Wait for Complete Device Initialization...
         Starting Show Plymouth Boot Screen...
systemd-journald[234]: Received SIGUSR1
systemd-shutdownd[497]: Shutting down at Sat 2013-04-06 17:00:30 EDT
(poweroff)...
systemd-shutdownd[497]: Creating /run/nologin, blocking further logins...
BUG: scheduling while atomic: systemd-logind/485/0x00000001
Modules linked in:
Call Trace:
15e417e70:  [<6024c6ea>] __schedule_bug+0x6e/0x83
15e417e78:  [<60046970>] sigsuspend+0x0/0x9e
15e417e80:  [<60046970>] sigsuspend+0x0/0x9e
15e417e90:  [<6024fefc>] __schedule+0x67/0x3ca
15e417ea0:  [<6005c136>] pick_next_task_fair+0x0/0x127
15e417ec0:  [<60046970>] sigsuspend+0x0/0x9e
15e417ed0:  [<600182c0>] _init+0x7e0/0x8b0
15e417ef0:  [<602503cc>] schedule+0x76/0x78
15e417f00:  [<6004579c>] set_current_blocked+0x17/0x19
15e417f10:  [<600469cc>] sigsuspend+0x5c/0x9e
15e417f30:  [<6001e6da>] winch_thread+0x204/0x242
15e417fd0:  [<6001e4d6>] winch_thread+0x0/0x242


Modules linked in:
Pid: 486, comm: dbus-daemon Not tainted 3.9.0-rc5
RIP: 0033:[<000000006008482e>]
RSP: 000000015f77bba0  EFLAGS: 00010206
RAX: 000000006032e4f8 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 000000006844f358 RSI: 0000000000200200 RDI: 0000000000100100
RBP: 000000015f77bbe0 R08: 0000000068485048 R09: 00000000000f5725
R10: 0000000068485068 R11: 0000000068485068 R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000000 R15: 000000006844f338
Call Trace:
6030b5f8:  [<6001c0d5>] segv+0x285/0x2d5
6030b608:  [<6002cdc9>] set_signals+0x29/0x3f
6030b628:  [<6003c5b5>] __local_bh_enable+0x5f/0xb0
6030b638:  [<6007e999>] rcu_bh_qs+0x79/0x7d
6030b658:  [<6003c7de>] __do_softirq+0x1c1/0x1f5
6030b660:  [<6007d2ef>] unmask_irq+0x0/0x23
6030b6c8:  [<6001c19c>] segv_handler+0x77/0x81
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

Call Trace:

160445b38:  [<6024be78>]6030b790:  [<6008482e>] panic+0x145/0x2a7
__rmqueue+0x57/0x27f

160445b60:  [<600bc075>]6030b7c0:  [<60095c0d>] kill_fasync+0x0/0xb2

6030b818:  [<6001675c>]160445b70:  [<6024bd33>] _einittext+0x24eb/0x386f
panic+0x0/0x2a7

6030b828:  [<60016250>]160445b78:  [<6007768c>] _einittext+0x1fdf/0x386f
cgroup_exit+0x6d/0xde6030b908:  [<6001675c>]
 _einittext+0x24eb/0x386f160445c48:  [<6003a648>]
 forget_original_parent+0xe5/0x4046030b9b0:  [<60018010>]
 _init+0x530/0x8b0160445cb8:  [<6003ac75>]6030b9d0:  [<6002cc7f>]
do_exit+0x30e/0x526 sig_handler_common+0x0/0xbd
6030b9e0:  [<60018010>] _init+0x530/0x8b0 get_signal_to_deliver+0x0/0x506

 _init+0x530/0x8b0160445cf8:  [<6003b077>]
6030ba48:  [<6002ce82>] do_group_exit+0xbb/0x10c sig_handler+0x4a/0x5c

6030ba68:  [<6002c96a>] hard_handler+0x86/0xc5
get_signal_to_deliver+0x0/0x506

6030bb68:  [<6008482e>]160445d28:  [<6004555d>] __rmqueue+0x57/0x27f
get_signal_to_deliver+0x4e0/0x506

160445d48:  [<60043316>]
 signal_wake_up_state+0x1b/0x1dKernel panic - not syncing: Kernel mode
fault at addr 0x100108, ip 0x6008482e

Call Trace:
160445d68:  [<6004507d>]6030b4e8:  [<6024be78>]
get_signal_to_deliver+0x0/0x506
 panic+0x145/0x2a7160445d70:  [<6001a76c>]
 handle_signal+0x0/0x1d26030b520:  [<6008482e>]
 __rmqueue+0x57/0x27f160445d88:  [<6001a99f>]
 kern_do_signal+0x61/0x14d6030b528:  [<6024bd33>]
 panic+0x0/0x2a7160445db8:  [<600439c9>]
 __send_signal.constprop.26+0x1f5/0x226
 __module_text_address+0x14/0x5a160445e18:  [<60044468>]
 force_sig_info+0xc9/0xd86030b558:  [<6006f70d>]
 is_module_text_address+0x10/0x18160445e20:  [<60017f80>]
 _init+0x4a0/0x8b06030b568:  [<6004eba2>]
 __kernel_text_address+0x30/0x5c160445e58:  [<60017f80>]
 _init+0x4a0/0x8b06030b588:  [<6001abbe>]
 show_trace+0xda/0xe5160445e68:  [<6001aab3>]
 do_signal+0x28/0x2d6030b5b8:  [<6008482e>]
 __rmqueue+0x57/0x27f

6030b5d8:  [<6008482e>]160445ea8:  [<6002fbfa>] __rmqueue+0x57/0x27f
userspace+0x196/0x57a

6030b5f8:  [<6001c0f3>]160445f68:  [<6001849c>] segv+0x2a3/0x2d5
run_init_process+0x0/0x296030b608:  [<6002cdc9>]
 set_signals+0x29/0x3f
 do_execve+0x10/0x126030b628:  [<6003c5b5>]
 __local_bh_enable+0x5f/0xb0160445fd8:  [<600199ac>]
 new_thread_handler+0xa1/0xa36030b638:  [<6007e999>]
 rcu_bh_qs+0x79/0x7d
6030b658:  [<6003c7de>]Modules linked in: __do_softirq+0x1c1/0x1f5
Pid: 1, comm: systemd Tainted: G        W    3.9.0-rc5
6030b660:  [<6007d2ef>]RIP: 0033:[<0000000041a00a33>]
 unmask_irq+0x0/0x23RSP: 0000007fbfe41548  EFLAGS: 00000246

RAX: 0000000000000001 RBX: 000000552adb0660 RCX: ffffffffffffffff
6030b6c8:  [<6001c19c>]RDX: 0000000000000001 RSI: 0000007fbfe415f0 RDI:
0000000000000004
 segv_handler+0x77/0x81RBP: 0000000000c9db57 R08: 0000000000000001 R09:
0000000000000000

R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000000001
6030b708:  [<6002cd26>]R13: 000000552ab3b360 R14: 000000552ab3a299 R15:
0000000000000202
 sig_handler_common+0xa7/0xbdCall Trace:

160445a90:  [<6006b2d6>]6030b790:  [<6008482e>]
__module_text_address+0x14/0x5a __rmqueue+0x57/0x27f

160445aa8:  [<6001c48f>]6030b7c0:  [<60095c0d>] panic_exit+0x3a/0x58
anon_vma_interval_tree_insert+0x2f/0x8c

160445ab8:  [<6004eba2>]6030b818:  [<6001675c>]
__kernel_text_address+0x30/0x5c _einittext+0x24eb/0x386f

160445ad8:  [<60055b34>]6030b828:  [<60016250>]
notifier_call_chain+0x32/0x5c _einittext+0x1fdf/0x386f

160445b18:  [<60055b6e>]6030b908:  [<6001675c>]
__atomic_notifier_call_chain+0x10/0x12 _einittext+0x24eb/0x386f

160445b28:  [<60055b86>]6030b9b0:  [<60018010>]
atomic_notifier_call_chain+0x16/0x18 _init+0x530/0x8b0

160445b38:  [<6024beab>]6030b9d0:  [<6002cc7f>] panic+0x178/0x2a7
sig_handler_common+0x0/0xbd

160445b60:  [<600bc075>]6030b9e0:  [<60018010>] kill_fasync+0x0/0xb2

6030ba30:  [<60018010>]160445b70:  [<6024bd33>] _init+0x530/0x8b0
panic+0x0/0x2a7

6030ba48:  [<6002ce82>]160445b78:  [<6007768c>] sig_handler+0x4a/0x5c
cgroup_exit+0x6d/0xde

6030ba68:  [<6002c96a>]160445c48:  [<6003a648>] hard_handler+0x86/0xc5
forget_original_parent+0xe5/0x404

6030bb68:  [<6008482e>]160445cb8:  [<6003ac75>] __rmqueue+0x57/0x27f
do_exit+0x30e/0x526

160445ce8:  [<6004507d>]
 get_signal_to_deliver+0x0/0x506

Modules linked in:160445cf8:  [<6003b077>]
 do_group_exit+0xbb/0x10cPid: 486, comm: dbus-daemon Not tainted 3.9.0-rc5

RIP: 0033:[<0000000040a9f110>]
160445d08:  [<6004507d>]RSP: 0000007fbf81d558  EFLAGS: 00000246
 get_signal_to_deliver+0x0/0x506RAX: ffffffffffffffda RBX:
0000000000000000 RCX: ffffffffffffffff

RDX: 0000000000000032 RSI: 000000000066b710 RDI: 000000000000000a
160445d28:  [<6004555d>]RBP: 000000000000000a R08: 000000000066b710 R09:
0000000000000000
 get_signal_to_deliver+0x4e0/0x506R10: 0000000000000000 R11:
0000000000000246 R12: 0000000000000032

R13: 000000000066b710 R14: 0000007fbf81d5c0 R15: 0000000000000000
160445d48:  [<60043316>]Call Trace:
 signal_wake_up_state+0x1b/0x1d6030b440:  [<6006b2d6>]
 __module_text_address+0x14/0x5a160445d68:  [<6004507d>]
 get_signal_to_deliver+0x0/0x5066030b458:  [<6001c48f>]
 panic_exit+0x3a/0x58160445d70:  [<6001a76c>]
 handle_signal+0x0/0x1d2 __kernel_text_address+0x30/0x5c160445d88: 
[<6001a99f>]
 kern_do_signal+0x61/0x14d6030b488:  [<60055b34>]
160445db8:  [<600439c9>] notifier_call_chain+0x32/0x5c
__send_signal.constprop.26+0x1f5/0x226
160445e18:  [<60044468>]6030b4b0:  [<6008482e>] force_sig_info+0xc9/0xd8
__rmqueue+0x57/0x27f

 _init+0x4a0/0x8b06030b4c8:  [<60055b6e>]
160445e58:  [<60017f80>]

6030b4d8:  [<60055b86>]160445e68:  [<6001aab3>] do_signal+0x28/0x2d
atomic_notifier_call_chain+0x16/0x18

160445e88:  [<6001be44>]6030b4e8:  [<6024beab>]
 panic+0x178/0x2a7160445ea8:  [<6002fbfa>]
 userspace+0x196/0x57a6030b520:  [<6008482e>]160445f68: 
[<6001849c>]6030b5b8:  [<6008482e>] __rmqueue+0x57/0x27f
6030b5d8:  [<6008482e>] __rmqueue+0x57/0x27f
6030b5f8:  [<6001c0f3>] segv+0x2a3/0x2d5
6030b608:  [<6002cdc9>] set_signals+0x29/0x3f
6030b628:  [<6003c5b5>] __local_bh_enable+0x5f/0xb0
6030b638:  [<6007e999>] rcu_bh_qs+0x79/0x7d
6030b658:  [<6003c7de>] __do_softirq+0x1c1/0x1f5
6030b660:  [<6007d2ef>] unmask_irq+0x0/0x23
6030b6c8:  [<6001c19c>] segv_handler+0x77/0x81
6030b708:  [<6002cd26>] sig_handler_common+0xa7/0xbd
6030b790:  [<6008482e>] __rmqueue+0x57/0x27f
6030b7c0:  [<60095c0d>] anon_vma_interval_tree_insert+0x2f/0x8c
6030b818:  [<6001675c>] _einittext+0x24eb/0x386f
6030b828:  [<60016250>] _einittext+0x1fdf/0x386f
6030b908:  [<6001675c>] _einittext+0x24eb/0x386f
6030b9b0:  [<60018010>] _init+0x530/0x8b0
6030b9d0:  [<6002cc7f>] sig_handler_common+0x0/0xbd
6030b9e0:  [<60018010>] _init+0x530/0x8b0
6030ba30:  [<60018010>] _init+0x530/0x8b0
6030ba48:  [<6002ce82>] sig_handler+0x4a/0x5c
6030ba68:  [<6002c96a>] hard_handler+0x86/0xc5
6030bb68:  [<6008482e>] __rmqueue+0x57/0x27f







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

