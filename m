Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AttTC-0006em-Hc
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 19 Feb 2004 11:04:22 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AttNm-0006xn-LB
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 19 Feb 2004 10:58:46 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: Diagnosed and repeatable kernel mode panic in schedule() for 2.6!
References: <200402151911.11890.blaisorblade_spam@yahoo.it> <200402162025.24853.blaisorblade_spam@yahoo.it> <200402170446.i1H4kUsq026113@ccure.user-mode-linux.org>
In-Reply-To: <200402170446.i1H4kUsq026113@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_GgQNA14cLPmMBm/"
Message-Id: <200402192001.26102.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 19 Feb 2004 20:01:26 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Ingo Molnar <mingo@elte.hu>



--Boundary-00=_GgQNA14cLPmMBm/
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Alle 05:46, marted=EC 17 febbraio 2004, Jeff Dike ha scritto:
> blaisorblade_spam@yahoo.it said:
> > while /bin/true ; do /bin/true ; done
>
> This turned out to be slightly subtle.  It was exposed by the
> longjmp -> siglongjmp change.  New processes were created with signals
> enabled, so siglongjmp to a new process context re-enabled signals in the
> middle of the context switch.

Probably it is a needed fix, but that one is not enough. I can still panic =
the=20
kernel in the same exact way.

By the way, would you check if this is needed in the 2.4 kernel, too? I've=
=20
checked the 2.4.24-1 uml patch and it seems to miss that line (and your=20
reason seem to apply to 2.4 too).

The only change with that patch applied is that while with 2.6.2 schedule=20
recursed and panic was called twice, with 2.6.3-rc2 this didn't happen any=
=20
more, i.e. for some random reason I got only one panic, and with this patch=
=20
applied I keep getting one panic. What is more strange is that the panic=20
happens deterministically, and in the same situation (same root fs and same=
=20
kernel) I get it at the same addresses! Since what happens seem to change=20
with each single kernel, but is easily repeatable, I would say that it is n=
ot=20
a race condition, but something with a crazy pointer outside of the core=20
code. However, it cannot be a not initialized one, but one initialized with=
=20
less than needed space. I'm attaching my .config (but note that I have no=20
module loaded when I run the test, so do not check modules).

Also, I have a backtrace + some inquiries of the runqueue; I'm putting thos=
e=20
in the attached file. It is much shorter than last time. Note that I checke=
d=20
in the expired array the first process that was executing (the -32 is the=20
offset from the list_head and the task_struct):

(gdb) print ((struct task_struct*)((void=20
*)per_cpu__runqueues.expired.queue[125].next-32))

$19 =3D (struct task_struct *) 0xa08e4080

And that I dereferenced it (and it seemed valid) and I dereferenced the=20
"real_parent" task_struct. Also I checked the number of processes in the tw=
o=20
arrays (active and expired) and in the active one there were -1 processes=20
(which is invalid, right Ingo?). So it seems that both active.queue[140] an=
d=20
active.queue.nr_active are corrupted. Those datas are next to one another, =
so=20
it seems a true memory corruption.

However, even in expired.queue[125] there is a problem, since in the list=20
there is one list_head (the one at 0xa08e40a0) whose next and prev pointers=
=20
point to itself (i.e. that is an empty list); however this "empty list" can=
=20
be reached by expired.queue[125].

Note: to find what index you must give to queue when examining the run_queu=
e,=20
take a look to sched_find_first_bit inside asm-i386 and to the code in=20
schedule() which invokes it. The queue contains the "R" processes organized=
=20
in one list_head for each priority level.
=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_GgQNA14cLPmMBm/
Content-Type: text/plain;
  charset="iso-8859-1";
  name="MyUmlConfig"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="MyUmlConfig"

#
# Automatically generated make config: don't edit
#
CONFIG_USERMODE=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y

#
# UML-specific options
#
CONFIG_MODE_TT=y
CONFIG_MODE_SKAS=y
CONFIG_NET=y
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
CONFIG_HOSTFS=m
# CONFIG_HPPFS is not set
CONFIG_MCONSOLE=y
CONFIG_MAGIC_SYSRQ=y
# CONFIG_HOST_2G_2G is not set
# CONFIG_UML_SMP is not set
# CONFIG_SMP is not set
CONFIG_NEST_LEVEL=0
CONFIG_KERNEL_HALF_GIGS=1
# CONFIG_HIGHMEM is not set
CONFIG_PROC_MM=y
CONFIG_KERNEL_STACK_ORDER=2
# CONFIG_UML_REAL_TIME_CLOCK is not set

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Generic Driver Options
#

#
# Character Devices
#
CONFIG_STDIO_CONSOLE=y
CONFIG_SSL=y
CONFIG_FD_CHAN=y
CONFIG_NULL_CHAN=y
CONFIG_PORT_CHAN=y
CONFIG_PTY_CHAN=y
CONFIG_TTY_CHAN=y
CONFIG_XTERM_CHAN=y
CONFIG_CON_ZERO_CHAN="fd:0,fd:1"
CONFIG_CON_CHAN="xterm"
CONFIG_SSL_CHAN="pty"
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
# CONFIG_WATCHDOG is not set
CONFIG_UML_SOUND=m
CONFIG_SOUND=m
CONFIG_HOSTAUDIO=m

#
# Block Devices
#
CONFIG_BLK_DEV_UBD=y
CONFIG_BLK_DEV_UBD_SYNC=y
CONFIG_BLK_DEV_COW_COMMON=y
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_MMAPPER is not set
CONFIG_NETDEVICES=y

#
# UML Network Devices
#
CONFIG_UML_NET=y
CONFIG_UML_NET_ETHERTAP=y
CONFIG_UML_NET_TUNTAP=y
CONFIG_UML_NET_SLIP=y
CONFIG_UML_NET_DAEMON=y
CONFIG_UML_NET_MCAST=y
CONFIG_UML_NET_PCAP=y
CONFIG_UML_NET_SLIRP=y

#
# Networking support
#

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
# CONFIG_IP_NF_TFTP is not set
# CONFIG_IP_NF_AMANDA is not set
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
# CONFIG_IP_NF_MATCH_ECN is not set
# CONFIG_IP_NF_MATCH_DSCP is not set
# CONFIG_IP_NF_MATCH_AH_ESP is not set
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
CONFIG_IP_NF_NAT_LOCAL=y
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
# CONFIG_IP_NF_TARGET_ECN is not set
# CONFIG_IP_NF_TARGET_DSCP is not set
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
# CONFIG_IP_NF_TARGET_TCPMSS is not set
# CONFIG_IP_NF_ARPTABLES is not set
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

#
# Ethernet (1000 Mbit)
#

#
# Ethernet (10000 Mbit)
#
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_XATTR is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
# CONFIG_FAT_FS is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
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
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
# CONFIG_SUNRPC_GSS is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
# CONFIG_NLS is not set

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
# CONFIG_CRC32 is not set

#
# SCSI support
#
# CONFIG_SCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_SPINLOCK is not set
CONFIG_DEBUG_INFO=y
CONFIG_FRAME_POINTER=y
# CONFIG_PT_PROXY is not set
# CONFIG_GPROF is not set
# CONFIG_GCOV is not set

--Boundary-00=_GgQNA14cLPmMBm/
Content-Type: application/x-bzip2;
  name="debugOutput-secondTry.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="debugOutput-secondTry.bz2"

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

--Boundary-00=_GgQNA14cLPmMBm/--



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
