Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C7dAl-000697-GT for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Sep 2004 10:02:23 -0700
Received: from sark4.cc.gatech.edu ([130.207.7.19])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C7dAj-00053d-4V for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Sep 2004 10:02:23 -0700
Received: from tokyo.cc.gatech.edu (tokyo.cc.gatech.edu [130.207.114.15])
	by sark4.cc.gatech.edu (8.12.10/8.12.8) with ESMTP id i8FH2Jb0007167
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 15 Sep 2004 13:02:19 -0400 (EDT)
Received: from localhost (young@localhost)
	by tokyo.cc.gatech.edu (8.12.10/8.12.8) with ESMTP id i8FH2IGU010102
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 15 Sep 2004 13:02:19 -0400 (EDT)
From: Younggyun Koh <young@cc.gatech.edu>
Message-ID: <Pine.GSO.4.58.0409151257150.24774@tokyo.cc.gatech.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] weird hanging when uml starts up
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
Date: Wed, 15 Sep 2004 13:02:18 -0400 (EDT)
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

i inserted some code in uml network stack, but after that, i can't boot
uml in skas mode. (it's okay with tt mode, tho)

the code i inserted is...

asmlinkage long sys_sendto(int fd, void * buff, size_t len, unsigned
flags,
			   struct sockaddr *addr, int addr_len)
{
	struct socket *sock;
	char address[MAX_SOCK_ADDR];
	int err;
	struct msghdr msg;
	struct iovec iov;

#ifdef MY_CODE
	{
	if (len > 16 && ((char *)buff)[0] == '$' && ((char *)buff)[1] ==
'$')
	{
		unsigned long ts1 = my_rdtscl();
		sprintf(buff+2, "%u\0", ts1);
	}
	}
#endif
....

and uml hands on "Configuring kernel paramaters"

Checking for the skas3 patch in the host...found
Checking for /proc/mm...found
Kernel virtual memory size shrunk to 258998272 bytes
Checking for /dev/anon on the host...Not available (open failed with errno
2)
Linux version 2.4.26-3um (young@odysseus.cc.gt.atl.ga.us) (gcc version
3.2.3) #19
On node 0 totalpages: 65536
zone(0): 65536 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: ubd0=root_fs.rh-7.2-full.pristine.20020312 mem=256M
eth0=tuntap,,,192.168.0.100 root=/dev/ubd0
Calibrating delay loop... 2994.99 BogoMIPS
Memory: 253116k available
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
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
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: devfs_debug: 0x0
devfs: boot_options: 0x1
JFFS version 1.0, (C) 1999, 2000  Axis Communications AB
JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis Communications
AB.
pty: 256 Unix98 ptys configured
Software Watchdog Timer: 0.05, timer margin: 60 sec
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
Initializing software serial port version 1
mconsole (version 2) initialized on /home/young/.uml/09wwe4/mconsole
Partition check:
 ubda: unknown partition table
Initializing stdio console driver
Netdevice 0 : TUN/TAP backend - IP = 192.168.0.100
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
arp_tables: (C) 2002 David S. Miller
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
SCTP: Hash tables configured (established 8192 bind 16384)
NET4: Ethernet Bridge 008 for NET4.0
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
INIT: version 2.78 booting
                        Welcome to Red Hat Linux
                Press 'I' to enter interactive startup.
Mounting proc filesystem:  [  OK  ]
Configuring kernel parameters:

anyone has any idea what's wrong with it?

thank you,

			-Younggyun Koh (young@cc.gatech.edu)


-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
