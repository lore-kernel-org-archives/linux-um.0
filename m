Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AR9W2-0003G2-KO
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 02 Dec 2003 04:20:30 -0800
Received: from morpheus-adsl.ednet.co.uk ([212.20.233.177] helo=mail.morpheux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AR9W1-0001UM-DT
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 02 Dec 2003 04:20:29 -0800
Received: from morpheux.org (IDENT:PQUqpCaQgNItIPW1ePWYCLMZEqHHM5pI@sue.morpheux.org [192.168.42.3])
	by mail.morpheux.org (8.12.8/8.11.2) with ESMTP id hB2CKtLd028951
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 2 Dec 2003 12:20:55 GMT
Message-ID: <3FCC83A7.2080107@morpheux.org>
From: Faye Gibbins <wibble@morpheux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] make failure with 2.4.23 and uml patch 2.4.22-6
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
Date: Tue, 02 Dec 2003 12:20:55 +0000
To: user-mode-linux-devel@lists.sourceforge.net


What failed:

cd /usr/src/uml && tar -xjf /tmp/linux-2.4.23.tar.bz2 && cd linux-2.4.23 
&& bzcat /tmp/uml-patch-2.4.22-6.bz2 | patch -p1 &&  make xconfig 
ARCH=um && make dep ARCH=um && make linux ARCH=um && make modules 
ARCH=um && make modules_install INSTALL_MOD_PATH=/tmp/UMLmods ARCH=um;

How it failed:

snip---

gcc -D__KERNEL__ -I/usr/src/uml/linux-2.4.23/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
  -U__i386__ -Ui386 -DUM_FASTCALL -g -D__arch_um__ -DSUBARCH="i386" 
-D_LARGEFILE64_SOURCE -I/usr/src/uml/linux-2.4.23/arch/um/include 
-Derrno=kernel_errno 
-I/usr/src/uml/linux-2.4.23/arch/um/kernel/tt/include 
-I/usr/src/uml/linux-2.4.23/arch/um/kernel/skas/include   -nostdinc 
-iwithprefix include -DKBUILD_BASENAME=binfmt_script  -c -o 
binfmt_script.o binfmt_script.c
gcc -D__KERNEL__ -I/usr/src/uml/linux-2.4.23/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
  -U__i386__ -Ui386 -DUM_FASTCALL -g -D__arch_um__ -DSUBARCH="i386" 
-D_LARGEFILE64_SOURCE -I/usr/src/uml/linux-2.4.23/arch/um/include 
-Derrno=kernel_errno 
-I/usr/src/uml/linux-2.4.23/arch/um/kernel/tt/include 
-I/usr/src/uml/linux-2.4.23/arch/um/kernel/skas/include   -nostdinc 
-iwithprefix include -DKBUILD_BASENAME=binfmt_elf  -c -o binfmt_elf.o 
binfmt_elf.c
binfmt_elf.c:806:44: macro "ELF_PLAT_INIT" passed 2 arguments, but takes 
just 1
binfmt_elf.c: In function `load_elf_binary':
binfmt_elf.c:806: `ELF_PLAT_INIT' undeclared (first use in this function)
binfmt_elf.c:806: (Each undeclared identifier is reported only once
binfmt_elf.c:806: for each function it appears in.)
make[3]: *** [binfmt_elf.o] Error 1
make[3]: Leaving directory `/usr/src/uml/linux-2.4.23/fs'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/uml/linux-2.4.23/fs'
make[1]: *** [_dir_fs] Error 2
make[1]: Leaving directory `/usr/src/uml/linux-2.4.23'
make: *** [patch] Error 2
[distro@sue uml]$ pwd
/home/distro/uml

snip---

Kernel configuration file used:

snip---

#
# Automatically generated make config: don't edit
#
CONFIG_USERMODE=y
# CONFIG_ISA is not set
# CONFIG_SBUS is not set
# CONFIG_PCI is not set
CONFIG_UID16=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# General Setup
#
CONFIG_MODE_SKAS=y
CONFIG_MODE_TT=y
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_HOSTFS=y
CONFIG_HPPFS=y
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

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_KMOD=y

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
CONFIG_UML_SOUND=y
CONFIG_SOUND=y
CONFIG_HOSTAUDIO=y
# CONFIG_TTY_LOG is not set

#
# Block Devices
#
CONFIG_BLK_DEV_UBD=y
# CONFIG_BLK_DEV_UBD_SYNC is not set
# CONFIG_COW is not set
CONFIG_COW_COMMON=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_NBD=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
# CONFIG_MMAPPER is not set
CONFIG_NETDEVICES=y

#
# Network Devices
#
CONFIG_UML_NET=y
CONFIG_UML_NET_ETHERTAP=y
CONFIG_UML_NET_TUNTAP=y
CONFIG_UML_NET_SLIP=y
CONFIG_UML_NET_SLIRP=y
CONFIG_UML_NET_DAEMON=y
CONFIG_UML_NET_MCAST=y
# CONFIG_UML_NET_PCAP is not set
CONFIG_DUMMY=y
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=y
CONFIG_PPP=y
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPP_ASYNC is not set
# CONFIG_PPP_SYNC_TTY is not set
# CONFIG_PPP_DEFLATE is not set
# CONFIG_PPP_BSDCOMP is not set
# CONFIG_PPPOE is not set
CONFIG_SLIP=y
# CONFIG_SLIP_COMPRESSED is not set
# CONFIG_SLIP_SMART is not set
# CONFIG_SLIP_MODE_SLIP6 is not set

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_AMANDA=m
# CONFIG_IP_NF_NAT_LOCAL is not set
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
# CONFIG_IP_NF_ARPTABLES is not set
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set

#
#   IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set

#
#    SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set

#
#
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# Appletalk devices
#
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
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

#
# File systems
#
CONFIG_QUOTA=y
# CONFIG_QFMT_V2 is not set
CONFIG_AUTOFS_FS=y
CONFIG_AUTOFS4_FS=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_UMSDOS_FS=y
CONFIG_VFAT_FS=y
# CONFIG_EFS_FS is not set
CONFIG_JFFS_FS=y
CONFIG_JFFS_FS_VERBOSE=0
CONFIG_JFFS_PROC_FS=y
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_CRAMFS=m
# CONFIG_TMPFS is not set
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_JFS_FS is not set
CONFIG_MINIX_FS=y
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_CODA_FS=m
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_TCP is not set
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_NCP_FS is not set
# CONFIG_ZISOFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
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
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=m
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=y

#
# SCSI support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_SR_EXTRA_DEVS=2
# CONFIG_CHR_DEV_SG is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_DEBUG_QUEUES is not set
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
CONFIG_SCSI_DEBUG=y

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
CONFIG_MD_MULTIPATH=m
CONFIG_BLK_DEV_LVM=m

#
# Memory Technology Devices (MTD)
#
CONFIG_MTD=y
# CONFIG_MTD_DEBUG is not set
# CONFIG_MTD_PARTITIONS is not set
# CONFIG_MTD_CONCAT is not set

#
# User Modules And Translation Layers
#
CONFIG_MTD_CHAR=y
CONFIG_MTD_BLOCK=y
# CONFIG_FTL is not set
# CONFIG_NFTL is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
# CONFIG_MTD_JEDECPROBE is not set
# CONFIG_MTD_GEN_PROBE is not set
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# CONFIG_MTD_OBSOLETE_CHIPS is not set

#
# Mapping drivers for chip access
#
# CONFIG_MTD_PCMCIA is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_MTDRAM is not set
CONFIG_MTD_BLKMTD=y

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOC1000 is not set
# CONFIG_MTD_DOC2000 is not set
# CONFIG_MTD_DOC2001 is not set
# CONFIG_MTD_DOCPROBE is not set

#
# NAND Flash Device Drivers
#
# CONFIG_MTD_NAND is not set

#
# Library routines
#
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y

#
# Kernel hacking
#
# CONFIG_DEBUG_SLAB is not set
CONFIG_DEBUGSYM=y
CONFIG_PT_PROXY=y
# CONFIG_GPROF is not set
# CONFIG_GCOV is not set

snip---

Build Box:

RH9
Celeron 400 MHz
gcc 3.2.2
glibc 2.3.2


-- 



Yours
Faye

This time she's the lesser of two evils.

http://www.morpheux.org






-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
