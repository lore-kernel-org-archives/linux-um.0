Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AifB3-0003bq-EH for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Jan 2004 11:35:13 -0800
Received: from main.gmane.org ([80.91.224.249])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AifB2-0001HY-Rc for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Jan 2004 11:35:13 -0800
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1AifB0-0005Nx-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 19 Jan 2004 20:35:10 +0100
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Message-ID: <buhbhd$rds$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] tmpfs broken?
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
Date: Mon, 19 Jan 2004 20:36:14 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

when booting my 2.6.1-um1 kernel, it says "Could not kern_mount tmpfs" 
and afterwards - when the system has booted - i really cannot mount a 
tmpfs. I'm in doubt if i need it, but my gentoo likes to mount a tmpfs 
to /dev/shm. Is tmpfs supposed to work?

Thx
   Sven


here the whole protocol:

Checking for the skas3 patch in the host...not found
Checking for /proc/mm...not found
tracing thread pid = 11534
Linux version 2.6.1-1um (root@erni) (gcc version 3.2.3 20030422 (Gentoo 
Linux 1. 4 3.2.3-r3, propolice)) #9 Mon Jan 19 18:28:05 CET 2004
On node 0 totalpages: 8192
   DMA zone: 8192 pages, LIFO batch:2
   Normal zone: 0 pages, LIFO batch:1
   HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: root=98:0
PID hash table entries: 16 (order 4: 128 bytes)
Memory: 28800k available
Calibrating delay loop... 1808.79 BogoMIPS
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
Checking for /dev/anon on the host...Not available (open failed with 
errno 2)
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
Initializing software serial port version 1
mconsole (version 2) initialized on /root/.uml/hn5OWp/mconsole
Initializing stdio console driver
Could not kern_mount tmpfs
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
pty: 256 Unix98 ptys configured
loop: loaded (max 8 devices)
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
NET: Registered protocol family 1
NET: Registered protocol family 17
Using anticipatory io scheduler
  /dev/ubd/disc0: unknown partition table
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ubda, size 8192, journal first block 18, 
max tra ns len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ubda) for (ubda)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
INIT: version 2.84 booting
...




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
