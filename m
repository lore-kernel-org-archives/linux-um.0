Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19vCaV-0000lX-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 05 Sep 2003 02:09:03 -0700
Received: from [193.28.100.164] (helo=mail.epost.de)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19vCaU-00064F-Ru
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 05 Sep 2003 02:09:03 -0700
Received: from zwiebel.keller (81.89.227.165) by mail.epost.de (6.7.015) (authenticated as Marcus.Blomenkamp@epost.de)
        id 3F4499BE0017086B for user-mode-linux-devel@lists.sourceforge.net; Fri, 5 Sep 2003 11:09:00 +0200
From: Marcus Blomenkamp <Marcus.Blomenkamp@epost.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309051108.58297.Marcus.Blomenkamp@epost.de>
Subject: [uml-devel] restricting hostfs access does not work
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 5 Sep 2003 11:08:58 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Hi all,

I'm running a UML instance using a specific directory on the host as rootfs. 
How can I restrict the instance to not gain access to upper level 
directories? The hostfs=xxx option does not work for me.


Scenario:
UML boots from hosts '/mnt/lfs/thinboot' directory

Problem:
'mount -t hostfs / <somewhere>' still gives access to hosts '/' directory.


Best regards, Marcus


Checking for the skas3 patch in the host...not found
Checking for /proc/mm...not found
tracing thread pid = 3277
Linux version 2.4.20-fs1-4um (root@appserver) (gcc version 2.95.4 20011002 
(Debian prerelease)) #4 Mon Jul 21 11:55:05 CEST 2003
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: umid=uml mem=64M hostfs=/mnt/lfs/thinboot root=/dev/root 
rootflags=/mnt/lfs/thinboot rootfstype=hostfs init=/sbin/srb-init 
eth0=tuntap,tap-uml,
Calibrating delay loop... 475.16 BogoMIPS
Memory: 61312k available
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
pty: 256 Unix98 ptys configured
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
Initializing software serial port version 1
mconsole (version 2) initialized on /services/uml/.uml/uml/mconsole
unable to open root_fs for validation
UML Audio Relay (host dsp = /dev/sound/dsp, host mixer = /dev/sound/mixer)
Initializing stdio console driver
Netdevice 0 : TUN/TAP backend -
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
klips_info:ipsec_init: KLIPS startup, FreeS/WAN IPSec version: 
super-freeswan-1.99.6.2
klips_info:ipsec_alg_init: KLIPS alg v=0.8.1-0 (EALG_MAX=255, AALG_MAX=15)
klips_info:ipsec_alg_init: calling ipsec_alg_static_init()
ipsec_3des_init(alg_type=15 alg_id=3 name=3des): ret=0
ipsec_aes_init(alg_type=15 alg_id=12 name=aes): ret=0
ipsec_aes_init(alg_type=14 alg_id=9 name=aes_mac): ret=0
ipsec_blowfish_init(alg_type=15 alg_id=7 name=blowfish): ret=0
ipsec_cast_init(alg_type=15 alg_id=6 name=cast): ret=0
ipsec_md5_init(alg_type=14 alg_id=2 name=md5): ret=0
ipsec_null_init(alg_type=15 alg_id=11 name=null): ret=0
ipsec_serpent_init(alg_type=15 alg_id=252 name=serpent): ret=0
ipsec_sha1_init(alg_type=14 alg_id=3 name=sha1): ret=0
ipsec_sha2_init(alg_type=14 alg_id=5 name=sha2_256): ret=0
ipsec_sha2_init(alg_type=14 alg_id=7 name=sha2_512): ret=0
ipsec_twofish_init(alg_type=15 alg_id=253 name=twofish): ret=0
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (hostfs filesystem) readonly.
Mounted devfs on /dev



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
