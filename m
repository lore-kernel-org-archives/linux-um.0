Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ErEB9-0002vt-0V for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Dec 2005 04:43:47 -0800
Received: from nproxy.gmail.com ([64.233.182.207])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1ErEB8-0003un-Az
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Dec 2005 04:43:47 -0800
Received: by nproxy.gmail.com with SMTP id n15so431263nfc
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 27 Dec 2005 04:43:44 -0800 (PST)
Message-ID: <84144f020512270443k4a1f794el1fbb286c4186f383@mail.gmail.com>
From: Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <Pine.LNX.4.64.0512241930370.14098@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
References: <Pine.LNX.4.64.0512241930370.14098@g5.osdl.org>
Subject: [uml-devel] Re: Ho ho ho.. Linux 2.6.15-rc7
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 27 Dec 2005 14:43:44 +0200
Content-Transfer-Encoding: quoted-printable
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, jdike@karaya.com, blaisorblade@yahoo.it

On 12/25/05, Linus Torvalds <torvalds@osdl.org> wrote:
> Please do give it a try, and if you have any issues/regressions, send out
> a note (even if you sent one earlier) so that we don't forget about it.

Hmm. Somebody broke UML compile for my config again...

  CC      arch/um/sys-i386/stub_segv.o
In file included from arch/um/sys-i386/stub_segv.c:10:
arch/um/include/sysdep/stub.h:12:23: stub-data.h: No such file or directory
In file included from arch/um/sys-i386/stub_segv.c:10:
arch/um/include/sysdep/stub.h: In function `remap_stack':
arch/um/include/sysdep/stub.h:97: error: dereferencing pointer to
incomplete type
make[1]: *** [arch/um/sys-i386/stub_segv.o] Error 1
make: *** [arch/um/sys-i386] Error 2

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.15-rc7
# Tue Dec 27 14:28:35 2005
#
CONFIG_GENERIC_HARDIRQS=3Dy
CONFIG_UML=3Dy
CONFIG_MMU=3Dy
CONFIG_UID16=3Dy
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
CONFIG_IRQ_RELEASE_METHOD=3Dy

#
# UML-specific options
#
CONFIG_MODE_TT=3Dy
# CONFIG_HOST_2G_2G is not set
CONFIG_KERNEL_HALF_GIGS=3D1
# CONFIG_MODE_SKAS is not set

#
# Host processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=3Dy
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
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_XADD=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D5
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_X86_PPRO_FENCE=3Dy
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INVLPG=3Dy
CONFIG_X86_BSWAP=3Dy
CONFIG_X86_POPAD_OK=3Dy
CONFIG_X86_CMPXCHG64=3Dy
CONFIG_X86_GOOD_APIC=3Dy
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
CONFIG_X86_TSC=3Dy
CONFIG_UML_X86=3Dy
# CONFIG_64BIT is not set
CONFIG_SEMAPHORE_SLEEPERS=3Dy
CONFIG_TOP_ADDR=3D0xc0000000
# CONFIG_3_LEVEL_PGTABLES is not set
CONFIG_STUB_CODE=3D0xbfffe000
CONFIG_STUB_DATA=3D0xbffff000
CONFIG_STUB_START=3D0xbfffe000
CONFIG_ARCH_HAS_SC_SIGNALS=3Dy
CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA=3Dy
CONFIG_SELECT_MEMORY_MODEL=3Dy
CONFIG_FLATMEM_MANUAL=3Dy
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=3Dy
CONFIG_FLAT_NODE_MEM_MAP=3Dy
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=3D4
CONFIG_LD_SCRIPT_STATIC=3Dy
CONFIG_NET=3Dy
CONFIG_BINFMT_ELF=3Dy
CONFIG_BINFMT_MISC=3Dm
# CONFIG_HOSTFS is not set
# CONFIG_HPPFS is not set
CONFIG_MCONSOLE=3Dy
# CONFIG_MAGIC_SYSRQ is not set
# CONFIG_SMP is not set
CONFIG_NEST_LEVEL=3D0
# CONFIG_HIGHMEM is not set
CONFIG_KERNEL_STACK_ORDER=3D2
CONFIG_UML_REAL_TIME_CLOCK=3Dy

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=3Dy
CONFIG_CLEAN_COMPILE=3Dy
CONFIG_BROKEN_ON_SMP=3Dy
CONFIG_INIT_ENV_ARG_LIMIT=3D32

#
# General setup
#
CONFIG_LOCALVERSION=3D""
CONFIG_LOCALVERSION_AUTO=3Dy
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_POSIX_MQUEUE=3Dy
CONFIG_BSD_PROCESS_ACCT=3Dy
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_SYSCTL=3Dy
# CONFIG_AUDIT is not set
# CONFIG_HOTPLUG is not set
CONFIG_KOBJECT_UEVENT=3Dy
CONFIG_IKCONFIG=3Dy
CONFIG_IKCONFIG_PROC=3Dy
CONFIG_INITRAMFS_SOURCE=3D""
CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=3Dy
# CONFIG_KALLSYMS_ALL is not set
CONFIG_KALLSYMS_EXTRA_PASS=3Dy
CONFIG_PRINTK=3Dy
CONFIG_BUG=3Dy
CONFIG_BASE_FULL=3Dy
CONFIG_FUTEX=3Dy
CONFIG_EPOLL=3Dy
CONFIG_SHMEM=3Dy
CONFIG_CC_ALIGN_FUNCTIONS=3D0
CONFIG_CC_ALIGN_LABELS=3D0
CONFIG_CC_ALIGN_LOOPS=3D0
CONFIG_CC_ALIGN_JUMPS=3D0
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=3D0

#
# Loadable module support
#
CONFIG_MODULES=3Dy
CONFIG_MODULE_UNLOAD=3Dy
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=3Dy
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=3Dy

#
# Block layer
#
# CONFIG_LBD is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=3Dy
CONFIG_IOSCHED_AS=3Dy
CONFIG_IOSCHED_DEADLINE=3Dy
CONFIG_IOSCHED_CFQ=3Dy
CONFIG_DEFAULT_AS=3Dy
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED=3D"anticipatory"

#
# Networking
#

#
# Networking options
#
CONFIG_PACKET=3Dy
CONFIG_PACKET_MMAP=3Dy
CONFIG_UNIX=3Dy
# CONFIG_NET_KEY is not set
CONFIG_INET=3Dy
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=3Dy
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_INET_DIAG=3Dy
CONFIG_INET_TCP_DIAG=3Dy
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=3Dy
# CONFIG_IPV6 is not set
# CONFIG_NETFILTER is not set

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
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
# Generic Driver Options
#
CONFIG_STANDALONE=3Dy
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
# CONFIG_FW_LOADER is not set
# CONFIG_DEBUG_DRIVER is not set

#
# Character Devices
#
CONFIG_STDERR_CONSOLE=3Dy
CONFIG_STDIO_CONSOLE=3Dy
CONFIG_SSL=3Dy
CONFIG_NULL_CHAN=3Dy
CONFIG_PORT_CHAN=3Dy
CONFIG_PTY_CHAN=3Dy
CONFIG_TTY_CHAN=3Dy
CONFIG_XTERM_CHAN=3Dy
# CONFIG_NOCONFIG_CHAN is not set
CONFIG_CON_ZERO_CHAN=3D"fd:0,fd:1"
CONFIG_CON_CHAN=3D"xterm"
CONFIG_SSL_CHAN=3D"pty"
CONFIG_UNIX98_PTYS=3Dy
CONFIG_LEGACY_PTYS=3Dy
CONFIG_LEGACY_PTY_COUNT=3D256
# CONFIG_WATCHDOG is not set
CONFIG_UML_SOUND=3Dm
CONFIG_SOUND=3Dm
CONFIG_HOSTAUDIO=3Dm
CONFIG_UML_RANDOM=3Dy
# CONFIG_MMAPPER is not set

#
# Block devices
#
CONFIG_BLK_DEV_UBD=3Dy
CONFIG_BLK_DEV_UBD_SYNC=3Dy
CONFIG_BLK_DEV_COW_COMMON=3Dy
CONFIG_BLK_DEV_LOOP=3Dm
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
CONFIG_BLK_DEV_NBD=3Dm
# CONFIG_BLK_DEV_RAM is not set
CONFIG_BLK_DEV_RAM_COUNT=3D16
# CONFIG_ATA_OVER_ETH is not set
CONFIG_NETDEVICES=3Dy

#
# UML Network Devices
#
CONFIG_UML_NET=3Dy
CONFIG_UML_NET_ETHERTAP=3Dy
CONFIG_UML_NET_TUNTAP=3Dy
CONFIG_UML_NET_SLIP=3Dy
CONFIG_UML_NET_DAEMON=3Dy
CONFIG_UML_NET_MCAST=3Dy
# CONFIG_UML_NET_PCAP is not set
CONFIG_UML_NET_SLIRP=3Dy

#
# Network device support
#
CONFIG_DUMMY=3Dm
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=3Dm

#
# PHY device support
#

#
# Wan interfaces
#
# CONFIG_WAN is not set
CONFIG_PPP=3Dm
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPP_FILTER is not set
# CONFIG_PPP_ASYNC is not set
# CONFIG_PPP_SYNC_TTY is not set
# CONFIG_PPP_DEFLATE is not set
# CONFIG_PPP_BSDCOMP is not set
# CONFIG_PPP_MPPE is not set
# CONFIG_PPPOE is not set
CONFIG_SLIP=3Dm
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
CONFIG_EXT2_FS=3Dy
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=3Dy
# CONFIG_EXT3_FS_XATTR is not set
CONFIG_JBD=3Dy
# CONFIG_JBD_DEBUG is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_FS_POSIX_ACL is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=3Dy
CONFIG_QUOTA=3Dy
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=3Dy
CONFIG_DNOTIFY=3Dy
CONFIG_AUTOFS_FS=3Dm
CONFIG_AUTOFS4_FS=3Dm
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=3Dm
CONFIG_JOLIET=3Dy
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
CONFIG_PROC_FS=3Dy
CONFIG_PROC_KCORE=3Dy
CONFIG_SYSFS=3Dy
CONFIG_TMPFS=3Dy
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=3Dy
# CONFIG_RELAYFS_FS is not set

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
CONFIG_MSDOS_PARTITION=3Dy

#
# Native Language Support
#
CONFIG_NLS=3Dy
CONFIG_NLS_DEFAULT=3D"iso8859-1"
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
CONFIG_CRC32=3Dm
# CONFIG_LIBCRC32C is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_INPUT is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_DEBUG_KERNEL=3Dy
CONFIG_LOG_BUF_SHIFT=3D14
CONFIG_DETECT_SOFTLOCKUP=3Dy
# CONFIG_SCHEDSTATS is not set
CONFIG_DEBUG_SLAB=3Dy
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_INFO=3Dy
# CONFIG_DEBUG_FS is not set
# CONFIG_DEBUG_VM is not set
CONFIG_FRAME_POINTER=3Dy
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_CMDLINE_ON_HOST is not set
CONFIG_PT_PROXY=3Dy
# CONFIG_SYSCALL_DEBUG is not set


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_idv37&alloc_id=16865&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
