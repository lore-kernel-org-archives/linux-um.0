Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <pbutler@pt.com>) id 1UOuMg-0004fu-5b
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 Apr 2013 18:30:54 +0000
Received: from ottgw.pt.com ([209.217.107.194])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UOuMe-00053g-JH for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 Apr 2013 18:30:53 +0000
Message-ID: <51879.173.206.136.128.1365359421.squirrel@webmail3.pt.com>
In-Reply-To: <CAFLxGvy7gWtSk4fNq+UnpX0_g6sYHgPo6nft9ghJR4ktvWmAPQ@mail.gmail.com>
References: <CAER6CkdnaFQshNMPkQVdXjB9Z3MyoMTg+grcPwwW=yGVjmhEZg@mail.gmail.com>
	<CAFLxGvy7gWtSk4fNq+UnpX0_g6sYHgPo6nft9ghJR4ktvWmAPQ@mail.gmail.com>
Date: Sun, 7 Apr 2013 14:30:21 -0400 (EDT)
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
Subject: Re: [uml-devel] Endless page fault for the same miss address in my
 UML
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

Here's one more example, still the same setup, but this time crashing at
the same place as the original bug report. (BUG: failure at
block/blk-core.c:2978/blk_flush_plug_list()!) See below for output.

BTW my host setup is Linux Mint 14:

Linux ufo 3.5.0-17-generic #28-Ubuntu SMP Tue Oct 9 19:31:23 UTC 2012
x86_64 x86_64 x86_64 GNU/Linux



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
Adding 26181632 bytes to physical memory to account for exec-shield gap
Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Linux version 3.9.0-rc5 (pbutler@ufo) (gcc version 4.7.2 (Ubuntu/Linaro
4.7.2-2ubuntu1) ) #1 Sat Apr 6 13:15:06 EDT 2013
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1040544
Kernel command line: ubd0=Fedora18-AMD64-root_fs rw mem=4096M
con0=fd:0,fd:1 root=98:0
PID hash table entries: 4096 (order: 3, 32768 bytes)
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Memory: 4068740k available
NR_IRQS:15
Calibrating delay loop... 3800.26 BogoMIPS (lpj=19001344)
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
mconsole (version 2) initialized on /home/pbutler/.uml/ovuM3w/mconsole
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
BUG: failure at block/blk-core.c:2978/blk_flush_plug_list()!
Kernel panic - not syncing: BUG!
Call Trace:
160477d70:  [<6024be78>] panic+0x145/0x2a7
160477da8:  [<6024bd33>] panic+0x0/0x2a7
160477de8:  [<6024bfda>] printk+0x0/0xa0
160477e60:  [<600182c0>] _init+0x7e0/0x8b0
160477e80:  [<6018c15d>] blk_flush_plug_list+0x191/0x252
160477ec0:  [<60046970>] sigsuspend+0x0/0x9e
160477ed0:  [<600182c0>] _init+0x7e0/0x8b0
160477ef0:  [<602503c0>] schedule+0x6a/0x78
160477f00:  [<6004579c>] set_current_blocked+0x17/0x19
160477f10:  [<600469cc>] sigsuspend+0x5c/0x9e
160477f30:  [<6001e6da>] winch_thread+0x204/0x242
160477fd0:  [<6001e4d6>] winch_thread+0x0/0x242


Modules linked in:
Pid: 1615311232, comm: Not tainted 3.9.0-rc5
RIP: 12f0:[<0000000160476e50>]
RSP: 0000000000000000  EFLAGS: 00000000
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 000000016047b3a8
RDX: 000000016047b3a8 RSI: 000000016047b3b8 RDI: 000000016047b3b8
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 000000016047b380 R11: 000000016047b380 R12: 0000000000000000
R13: 0000000c00000000 R14: 000000000c731a70 R15: 0000000051618cac
Call Trace:
160477cc8:  [<6006b2d6>] __module_text_address+0x14/0x5a
160477ce0:  [<6001c48f>] panic_exit+0x3a/0x58
160477cf0:  [<6004eba2>] __kernel_text_address+0x30/0x5c
160477d10:  [<60055b34>] notifier_call_chain+0x32/0x5c
160477d38:  [<600182c0>] _init+0x7e0/0x8b0
160477d50:  [<60055b6e>] __atomic_notifier_call_chain+0x10/0x12
160477d60:  [<60055b86>] atomic_notifier_call_chain+0x16/0x18
160477d70:  [<6024beab>] panic+0x178/0x2a7
160477da8:  [<6024bd33>] panic+0x0/0x2a7
160477de8:  [<6024bfda>] printk+0x0/0xa0
160477e60:  [<600182c0>] _init+0x7e0/0x8b0
160477e80:  [<6018c15d>] blk_flush_plug_list+0x191/0x252
160477ec0:  [<60046970>] sigsuspend+0x0/0x9e
160477ed0:  [<600182c0>] _init+0x7e0/0x8b0
160477ef0:  [<602503c0>] schedule+0x6a/0x78
160477f00:  [<6004579c>] set_current_blocked+0x17/0x19
160477f10:  [<600469cc>] sigsuspend+0x5c/0x9e
160477f30:  [<6001e6da>] winch_thread+0x204/0x242
160477fd0:  [<6001e4d6>] winch_thread+0x0/0x242

systemd-journald[233]: Received SIGUSR1




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

