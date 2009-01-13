Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rob@landley.net>) id 1LMeSQ-00043n-CS
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Jan 2009 08:17:06 +0000
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]
	helo=grelber.thyrsus.com) by 3b2kzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1LMeSL-0000br-JN
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Jan 2009 08:17:05 +0000
Received: from driftwood.localnet (localhost [127.0.0.1])
	by grelber.thyrsus.com (Postfix) with ESMTP id D94A39F0670
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 13 Jan 2009 03:15:41 -0500 (EST)
From: Rob Landley <rob@landley.net>
Date: Tue, 13 Jan 2009 01:59:03 -0600
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_InEbJnuj2nfv+I/"
Message-Id: <200901130159.04389.rob@landley.net>
Subject: [uml-devel] Does 2.6.28 UML work for anyone else?
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

--Boundary-00=_InEbJnuj2nfv+I/
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Can anyone else reproduce building ARCH=um with the attached .config, and then 
going:

$ ./vmlinux rw init=/bin/sh rootfstype=hostfs
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
Adding 11874304 bytes to physical memory to account for exec-shield gap
Linux version 2.6.28 (landley@driftwood) (gcc version 4.3.2 (Ubuntu 
4.3.2-1ubuntu11) ) #6 Tue Jan 13 01:54:34 CST 2009
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 10939
Kernel command line: rw init=/bin/sh rootfstype=hostfs root=98:0
PID hash table entries: 256 (order: 8, 2048 bytes)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Memory: 29688k available
SLUB: Genslabs=12, HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Calibrating delay loop... 369.45 BogoMIPS (lpj=1847296)
Mount-cache hash table entries: 256
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
Using 2.6 host AIO
io scheduler noop registered (default)
loop: module loaded
Initialized stdio console driver
Using a channel type which is configured out of UML
parse_chan_pair failed for device 1 : Configuration failed
Using a channel type which is configured out of UML
parse_chan_pair failed for device 2 : Configuration failed
Using a channel type which is configured out of UML
parse_chan_pair failed for device 3 : Configuration failed
Using a channel type which is configured out of UML
parse_chan_pair failed for device 4 : Configuration failed
Using a channel type which is configured out of UML
parse_chan_pair failed for device 5 : Configuration failed
Using a channel type which is configured out of UML
parse_chan_pair failed for device 6 : Configuration failed
Using a channel type which is configured out of UML
parse_chan_pair failed for device 7 : Configuration failed
Using a channel type which is configured out of UML
parse_chan_pair failed for device 8 : Configuration failed
Using a channel type which is configured out of UML
parse_chan_pair failed for device 9 : Configuration failed
Using a channel type which is configured out of UML
parse_chan_pair failed for device 10 : Configuration failed
Using a channel type which is configured out of UML
parse_chan_pair failed for device 11 : Configuration failed
Using a channel type which is configured out of UML
parse_chan_pair failed for device 12 : Configuration failed
Using a channel type which is configured out of UML
parse_chan_pair failed for device 13 : Configuration failed
Using a channel type which is configured out of UML
parse_chan_pair failed for device 14 : Configuration failed
Using a channel type which is configured out of UML
parse_chan_pair failed for device 15 : Configuration failed
Console initialized on /dev/tty0
console [tty0] enabled
VFS: Mounted root (hostfs filesystem).

Pid: 1, comm: swapper Not tainted 2.6.28
RIP: 0033:[<000000006001e112>]
RSP: 0000000062425de0  EFLAGS: 00010216
RAX: 00000000626a4800 RBX: 00000000625a5000 RCX: 0000000003ffc09f
RDX: fffffffffff02800 RSI: 0000000060280c20 RDI: 00000000626a4800
RBP: 0000000061537048 R08: 0000000000000000 R09: 0000000000100000
R10: 0000000000000000 R11: 00007f74c6795143 R12: 0000000062522300
R13: 0000000062522300 R14: 000000006014e440 R15: 0000000062420330
Call Trace: 
6014d908:  [<60011108>] segv+0x2b8/0x300
6014d948:  [<6003cb19>] hrtimer_run_pending+0x9/0xe0
6014d968:  [<6002e8bd>] run_timer_softirq+0x1cd/0x210
6014d9e8:  [<600111a0>] segv_handler+0x50/0xe0
6014da08:  [<60040f10>] tick_handle_periodic+0x10/0x60
6014da48:  [<6002954d>] do_softirq+0x4d/0x70
6014da68:  [<600296d5>] irq_exit+0x45/0x60
6014da88:  [<6000daff>] do_IRQ+0x2f/0x50
6014daa8:  [<60018154>] sig_handler_common+0x64/0xe0
6014db30:  [<6001e112>] __memcpy+0xe/0xac
6014db50:  [<600096a4>] calibrate_delay+0xb1/0x19d
6014dbd8:  [<6001831a>] sig_handler+0x1a/0x40
6014dbe8:  [<600185f3>] handle_signal+0x73/0xb0
6014dcd8:  [<6001e112>] __memcpy+0xe/0xac

Kernel panic - not syncing: Segfault with no mm

Pid: 1, comm: swapper Not tainted 2.6.28
RIP: 0033:[<00007f74c67442c7>]
RSP: 00007fffceea2fe8  EFLAGS: 00000206
RAX: 0000000000000000 RBX: 0000000000004f7c RCX: ffffffffffffffff
RDX: 0000000000000000 RSI: 0000000000000013 RDI: 0000000000004f7c
RBP: 0000000000004f78 R08: 00007fffceea2f30 R09: 0000000000000000
R10: 00007fffceea2d70 R11: 0000000000000206 R12: 00007fffceea30f8
R13: 0000000000000004 R14: 00007fffceea32c0 R15: 00007fffceea3154
Call Trace: 
6014d7c8:  [<600113ed>] panic_exit+0x2d/0x50
6014d7e8:  [<6003d967>] notifier_call_chain+0x37/0x70
6014d818:  [<600fcfe7>] panic+0xd0/0x164
6014d8b8:  [<6001e112>] __memcpy+0xe/0xac
6014d8c8:  [<6000fca0>] show_trace+0x60/0xc0
6014d8e8:  [<6001df18>] show_regs+0x28/0x30
6014d908:  [<60011114>] segv+0x2c4/0x300
6014d948:  [<6003cb19>] hrtimer_run_pending+0x9/0xe0
6014d968:  [<6002e8bd>] run_timer_softirq+0x1cd/0x210
6014d9e8:  [<600111a0>] segv_handler+0x50/0xe0
6014da08:  [<60040f10>] tick_handle_periodic+0x10/0x60
6014da48:  [<6002954d>] do_softirq+0x4d/0x70
6014da68:  [<600296d5>] irq_exit+0x45/0x60
6014da88:  [<6000daff>] do_IRQ+0x2f/0x50
6014daa8:  [<60018154>] sig_handler_common+0x64/0xe0
6014db30:  [<6001e112>] __memcpy+0xe/0xac
6014db50:  [<600096a4>] calibrate_delay+0xb1/0x19d
6014dbd8:  [<6001831a>] sig_handler+0x1a/0x40
6014dbe8:  [<600185f3>] handle_signal+0x73/0xb0
6014dcd8:  [<6001e112>] __memcpy+0xe/0xac

Segmentation fault


--Boundary-00=_InEbJnuj2nfv+I/
Content-Type: text/plain;
  charset="us-ascii";
  name=".config"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=".config"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.28
# Tue Jan 13 01:54:25 2009
#
CONFIG_DEFCONFIG_LIST="arch/$ARCH/defconfig"
CONFIG_GENERIC_HARDIRQS=y
CONFIG_UML=y
CONFIG_MMU=y
CONFIG_NO_IOMEM=y
# CONFIG_TRACE_IRQFLAGS_SUPPORT is not set
CONFIG_LOCKDEP_SUPPORT=y
# CONFIG_STACKTRACE_SUPPORT is not set
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_TIME=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_IRQ_RELEASE_METHOD=y
CONFIG_HZ=100

#
# UML-specific options
#

#
# Host processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
CONFIG_MK8=y
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_CPU=y
# CONFIG_X86_CMPXCHG is not set
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=3
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR_64=y
# CONFIG_X86_DS is not set
CONFIG_UML_X86=y
CONFIG_64BIT=y
# CONFIG_X86_32 is not set
# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
CONFIG_RWSEM_GENERIC_SPINLOCK=y
# CONFIG_ARCH_HAS_SC_SIGNALS is not set
# CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA is not set
CONFIG_SMP_BROKEN=y
CONFIG_GENERIC_HWEIGHT=y
# CONFIG_STATIC_LINK is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_PAGEFLAGS_EXTENDED=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_RESOURCES_64BIT=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_ZONE_DMA_FLAG=0
CONFIG_VIRT_TO_BUS=y
# CONFIG_UNEVICTABLE_LRU is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
CONFIG_LD_SCRIPT_DYN=y
CONFIG_BINFMT_ELF=y
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
# CONFIG_HAVE_AOUT is not set
# CONFIG_BINFMT_MISC is not set
CONFIG_HOSTFS=y
# CONFIG_MCONSOLE is not set
CONFIG_KERNEL_STACK_ORDER=1

#
# General setup
#
# CONFIG_EXPERIMENTAL is not set
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=128
CONFIG_LOCALVERSION=""
# CONFIG_LOCALVERSION_AUTO is not set
# CONFIG_SWAP is not set
# CONFIG_SYSVIPC is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_IKCONFIG is not set
CONFIG_LOG_BUF_SHIFT=17
# CONFIG_CGROUPS is not set
# CONFIG_SYSFS_DEPRECATED_V2 is not set
# CONFIG_RELAY is not set
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
# CONFIG_EMBEDDED is not set
CONFIG_UID16=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
# CONFIG_COMPAT_BRK is not set
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_ANON_INODES=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
# CONFIG_PROFILING is not set
# CONFIG_MARKERS is not set
# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
CONFIG_SLABINFO=y
CONFIG_RT_MUTEXES=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
# CONFIG_MODULES is not set
CONFIG_BLOCK=y
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_BLK_DEV_INTEGRITY is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
# CONFIG_IOSCHED_AS is not set
# CONFIG_IOSCHED_DEADLINE is not set
# CONFIG_IOSCHED_CFQ is not set
# CONFIG_DEFAULT_AS is not set
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
CONFIG_DEFAULT_NOOP=y
CONFIG_DEFAULT_IOSCHED="noop"
CONFIG_CLASSIC_RCU=y
# CONFIG_FREEZER is not set
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_UBD is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_RAM is not set

#
# Character Devices
#
CONFIG_STDERR_CONSOLE=y
CONFIG_STDIO_CONSOLE=y
# CONFIG_SSL is not set
# CONFIG_NULL_CHAN is not set
# CONFIG_PORT_CHAN is not set
# CONFIG_PTY_CHAN is not set
# CONFIG_TTY_CHAN is not set
# CONFIG_XTERM_CHAN is not set
CONFIG_NOCONFIG_CHAN=y
CONFIG_CON_ZERO_CHAN="fd:0,fd:1"
CONFIG_CON_CHAN="xterm"
CONFIG_SSL_CHAN="pty"
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_WATCHDOG is not set
# CONFIG_UML_SOUND is not set
# CONFIG_SOUND is not set
# CONFIG_SOUND_OSS_CORE is not set
# CONFIG_HOSTAUDIO is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_UML_RANDOM is not set
# CONFIG_MMAPPER is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
CONFIG_FW_LOADER=y
# CONFIG_FIRMWARE_IN_KERNEL is not set
CONFIG_EXTRA_FIRMWARE=""
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_NET is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_XATTR is not set
# CONFIG_EXT4_FS is not set
CONFIG_JBD=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_FS_POSIX_ACL is not set
CONFIG_FILE_LOCKING=y
# CONFIG_XFS_FS is not set
# CONFIG_DNOTIFY is not set
# CONFIG_INOTIFY is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
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
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_SYSFS=y
# CONFIG_TMPFS is not set
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_CONFIGFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_HFSPLUS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_NLS is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
# CONFIG_SECURITY_FILE_CAPABILITIES is not set
# CONFIG_CRYPTO is not set

#
# Library routines
#
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_FIND_NEXT_BIT=y
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
# CONFIG_CRC_T10DIF is not set
# CONFIG_CRC_ITU_T is not set
# CONFIG_CRC32 is not set
# CONFIG_CRC7 is not set
# CONFIG_LIBCRC32C is not set
CONFIG_PLIST=y
CONFIG_HAS_DMA=y

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
# CONFIG_SCSI is not set
# CONFIG_SCSI_DMA is not set
# CONFIG_SCSI_NETLINK is not set
# CONFIG_MD is not set
# CONFIG_NEW_LEDS is not set
# CONFIG_INPUT is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
# CONFIG_ENABLE_WARN_DEPRECATED is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=2048
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_DEBUG_KERNEL is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_RCU_CPU_STALL_DETECTOR is not set
# CONFIG_SYSCTL_SYSCALL_CHECK is not set

#
# Tracers
#
# CONFIG_DYNAMIC_PRINTK_DEBUG is not set
# CONFIG_SAMPLES is not set
# CONFIG_DEBUG_STACK_USAGE is not set

--Boundary-00=_InEbJnuj2nfv+I/
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
--Boundary-00=_InEbJnuj2nfv+I/
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--Boundary-00=_InEbJnuj2nfv+I/--

