Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F1h7q-0002Rw-IF for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Jan 2006 01:39:38 -0800
Received: from uproxy.gmail.com ([66.249.92.203])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1F1h7o-0000UN-Qh
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Jan 2006 01:39:38 -0800
Received: by uproxy.gmail.com with SMTP id c2so95871ugf
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 25 Jan 2006 01:39:34 -0800 (PST)
Message-ID: <84144f020601250133o1fd90c7vf05e8f17e1a51c2a@mail.gmail.com>
From: Pekka Enberg <penberg@cs.helsinki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Subject: [uml-devel] [PROBLEM] uml refuses to boot
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
Date: Wed, 25 Jan 2006 11:33:12 +0200
Content-Transfer-Encoding: 8bit
To: jdike@karaya.com, Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

Hi,

UML in 2.6.16-rc1-git4 fails to boot a Debian 3.0r2 image. The same
image works boots properly with 2.6.15. Here's the error:

penberg@haji ~/src/linux/2.6 $ ./linux
ubd0=/home/penberg/virtualized/Debian-3.0r2.ext2
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...OK
Checking advanced syscall emulation patch for ptrace...OK
Checking PROT_EXEC mmap in /tmp...OK
UML running in TT mode
tracing thread pid = 32600
Linux version 2.6.16-rc1-git4 (penberg@haji) (gcc version 3.3.6
(Gentoo 3.3.6, ssp-3.3.6-1.0, pie-8.7.8)) #1 Wed Jan 25 11:07:25 EET
2006
Built 1 zonelists
Kernel command line: ubd0=/home/penberg/virtualized/Debian-3.0r2.ext2 root=98:0
PID hash table entries: 256 (order: 8, 4096 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 29388k available
Mount-cache hash table entries: 512
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
Checking for /dev/anon on the host...Not available (open failed with errno 2)
Disabling 2.6 AIO in tt mode
2.6 host AIO support not used - falling back to I/O thread
NET: Registered protocol family 16
mconsole (version 2) initialized on /home/penberg/.uml/Z81xOu/mconsole
ubd: Synchronous mode
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
NET: Registered protocol family 2
IP route cache hash table entries: 512 (order: -1, 2048 bytes)
TCP established hash table entries: 2048 (order: 1, 8192 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Initialized stdio console driver
Console initialized on /dev/tty0
Initializing software serial port version 1
 ubda: unknown partition table
VFS: Mounted root (ext2 filesystem) readonly.
line_ioctl: tty0: ioctl KDSIGACCEPT called
os_set_fd_async : failed to set O_ASYNC and O_NONBLOCK on fd # 6, errno = 9
register_winch_irq - failed to register IRQ
os_set_fd_async : failed to set O_ASYNC and O_NONBLOCK on fd # 6, errno = 9
register_winch_irq - failed to register IRQ
INIT: os_set_fd_async : failed to set O_ASYNC and O_NONBLOCK on fd #
6, errno = 9
register_winch_irq - failed to register IRQ
version 2.84 bootingos_set_fd_async : failed to set O_ASYNC and
O_NONBLOCK on fd # 6, errno = 9
register_winch_irq - failed to register IRQ

Kernel panic - not syncing: read of switch_pipe failed, errno = 11

EIP: 0073:[<400b6e17>] CPU: 0 Not tainted ESP: 007b:9fe4a090 EFLAGS: 00200282
    Not tainted
EAX: 00000271 EBX: 9fe4a25c ECX: 0000540e EDX: 9fe4a25c
ESI: 00000000 EDI: 00000000 EBP: 9fe4a35c DS: 007b ES: 007b
a0bc3b74:  [<a0021de7>] show_regs+0xdf/0xe1
a0bc3ba0:  [<a0010521>] panic_exit+0x25/0x3f
a0bc3bb0:  [<a0033393>] notifier_call_chain+0x1c/0x3c
a0bc3bd0:  [<a0025bd2>] panic+0x4b/0xd3
a0bc3be8:  [<a0010ca2>] switch_to_tt+0xc2/0x129
a0bc3c1c:  [<a000d0c2>] _switch_to+0x39/0xbe
a0bc3c50:  [<a015d319>] schedule+0x41f/0x4a0
a0bc3cb8:  [<a000d163>] interrupt_end+0x1c/0x3a
a0bc3cc8:  [<a0012167>] sig_handler_common_tt+0xd3/0x100
a0bc3d04:  [<a001de03>] sig_handler+0x2f/0x3c
a0bc3d1c:  [<ffffe420>] _etext+0x5fe9ea61/0x0

 sleeping process 1392 got unexpected signal : 10


remove_umid_dir - actually_do_remove failed with err = -2
remove_umid_dir - actually_do_remove failed with err = -2

Here's host information using Gentoo's emerge info:

Portage 2.0.53 (default-linux/x86/2005.0, gcc-3.3.6, glibc-2.3.5-r2,
2.6.15 i686)
=================================================================
System uname: 2.6.15 i686 Intel(R) Pentium(R) M processor 2.00GHz
Gentoo Base System version 1.6.13
dev-lang/python:     2.3.5-r2, 2.4.2
sys-apps/sandbox:    1.2.12
sys-devel/autoconf:  2.13, 2.59-r6
sys-devel/automake:  1.4_p6, 1.5, 1.6.3, 1.7.9-r1, 1.8.5-r3, 1.9.6-r1
sys-devel/binutils:  2.16.1
sys-devel/libtool:   1.5.20
virtual/os-headers:  2.6.11-r2
ACCEPT_KEYWORDS="x86"
AUTOCLEAN="yes"
CBUILD="i686-pc-linux-gnu"
CFLAGS="-O2 -march=pentium3 -pipe -g"
CHOST="i686-pc-linux-gnu"
CONFIG_PROTECT="/etc /usr/kde/2/share/config /usr/kde/3.3/env
/usr/kde/3.3/share/config /usr/kde/3.3/shutdown
/usr/kde/3/share/config /usr/lib/X11/xkb
/usr/lib/mozilla/defaults/pref /usr/share/config
/usr/share/texmf/dvipdfm/config/ /usr/share/texmf/dvips/config/
/usr/share/texmf/tex/generic/config/
/usr/share/texmf/tex/platex/config/ /usr/share/texmf/xdvi/
/var/qmail/control"
CONFIG_PROTECT_MASK="/etc/gconf /etc/terminfo /etc/env.d"
CXXFLAGS="-O2 -march=pentium3 -pipe -g"
DISTDIR="/usr/portage/distfiles"
FEATURES="autoconfig distlocks nostrip sandbox sfperms strict"
GENTOO_MIRRORS="http://distfiles.gentoo.org
http://distro.ibiblio.org/pub/linux/distributions/gentoo"
LANG="en_US.UTF-8"
PKGDIR="/usr/portage/packages"
PORTAGE_TMPDIR="/var/tmp"
PORTDIR="/usr/portage"
PORTDIR_OVERLAY="/usr/local/portage"
SYNC="rsync://rsync.gentoo.org/gentoo-portage"
USE="x86 X acl alsa apm audiofile avi berkdb bitmap-fonts bzip2
cdparanoia cdr crypt cups curl dvd dvdr eds emboss encode esd exif
expat fam fontconfig foomaticdb fortran gd gdbm gif gitsendemail glut
gmp gnome gpm gstreamer gtk gtk2 guile idn imagemagick imap imlib
innodb ipv6 ithread ithreads java jpeg junit lcms ldap libg++ libwww
mbox mhash mikmod mng motif mozilla mp3 mpeg mysql ncurses nls nptl
ogg oggvorbis opengl pam pcre pdflib perl plotutils png postgres
python quicktime readline recode ruby samba sdl slang spell sse ssl
svg tcltk tcpd tetex tiff truetype truetype-fonts type1-fonts udev
unicode usb utf8 vorbis win32codecs xml xml2 xmms xv zlib userland_GNU
kernel_linux elibc_glibc"
Unset:  ASFLAGS, CTARGET, LC_ALL, LDFLAGS, LINGUAS, MAKEOPTS

Here is my config:

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.16-rc1-git4
# Wed Jan 25 11:04:03 2006
#
CONFIG_GENERIC_HARDIRQS=y
CONFIG_UML=y
CONFIG_MMU=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_IRQ_RELEASE_METHOD=y

#
# UML-specific options
#
CONFIG_MODE_TT=y
# CONFIG_HOST_2G_2G is not set
CONFIG_KERNEL_HALF_GIGS=1
# CONFIG_MODE_SKAS is not set

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
CONFIG_TOP_ADDR=0xc0000000
# CONFIG_3_LEVEL_PGTABLES is not set
CONFIG_STUB_CODE=0xbfffe000
CONFIG_STUB_DATA=0xbffff000
CONFIG_STUB_START=0xbfffe000
CONFIG_ARCH_HAS_SC_SIGNALS=y
CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_LD_SCRIPT_STATIC=y
CONFIG_NET=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
# CONFIG_HOSTFS is not set
# CONFIG_HPPFS is not set
CONFIG_MCONSOLE=y
# CONFIG_MAGIC_SYSRQ is not set
# CONFIG_SMP is not set
CONFIG_NEST_LEVEL=0
# CONFIG_HIGHMEM is not set
CONFIG_KERNEL_STACK_ORDER=2
CONFIG_UML_REAL_TIME_CLOCK=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32

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
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_UID16=y
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
CONFIG_KALLSYMS_EXTRA_PASS=y
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
CONFIG_SLAB=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
# CONFIG_SLOB is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y

#
# Block layer
#
# CONFIG_LBD is not set

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
CONFIG_BLK_DEV_UBD_SYNC=y
CONFIG_BLK_DEV_COW_COMMON=y
# CONFIG_MMAPPER is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_RAM is not set
CONFIG_BLK_DEV_RAM_COUNT=16
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
# CONFIG_DEBUG_DRIVER is not set

#
# Networking
#

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
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
# CONFIG_INET_TUNNEL is not set
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=y
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
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_XATTR is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_FS_POSIX_ACL is not set
# CONFIG_XFS_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
CONFIG_DNOTIFY=y
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m
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
# CONFIG_RELAYFS_FS is not set
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

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_INPUT is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_DETECT_SOFTLOCKUP=y
# CONFIG_SCHEDSTATS is not set
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_MUTEXES=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_FS is not set
# CONFIG_DEBUG_VM is not set
CONFIG_FRAME_POINTER=y
CONFIG_FORCED_INLINING=y
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_CMDLINE_ON_HOST is not set
CONFIG_PT_PROXY=y
# CONFIG_SYSCALL_DEBUG is not set


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
