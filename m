Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BmKKn-0007V5-C2 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jul 2004 15:40:41 -0700
Received: from mta10.adelphia.net ([68.168.78.202])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BmKKm-0000Dc-Vg for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jul 2004 15:40:41 -0700
Received: from mizar.alcor.net ([69.167.148.207]) by mta10.adelphia.net
	(InterMail vM.6.01.03.02 201-2131-111-104-20040324) with ESMTP
	id <20040718224035.LKYE19826.mta10.adelphia.net@mizar.alcor.net>
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 18 Jul 2004 18:40:35 -0400
Received: from mdz by mizar.alcor.net with local (Exim 4.34)
	id 1BmKKh-0007Yp-PC for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jul 2004 15:40:35 -0700
From: Matt Zimmerman <mdz@debian.org>
Message-ID: <20040718224035.GT4090@mizar.alcor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [alydar@users.sourceforge.net: Bug#260111:
	user-mode-linux: upgrade hangs at "NET4: Linux TCP/IP 1.0 for NET4.0"]
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
Date: Sun, 18 Jul 2004 15:40:35 -0700
To: user-mode-linux-devel@lists.sourceforge.net

Another report with the same symptoms, but this one with skas.  Has anyone
else seen this?

----- Forwarded message from Allen Chan <alydar@users.sourceforge.net> -----

Date: Sun, 18 Jul 2004 18:16:38 -0400
From: Allen Chan <alydar@users.sourceforge.net>
Resent-From: Allen Chan <alydar@users.sourceforge.net>
To: 260111@bugs.debian.org
Subject: Bug#260111: user-mode-linux: upgrade hangs at "NET4: Linux TCP/IP 1.0 for NET4.0"

I am using a 2.6.6-1-k7 host kernel with the skas3 patch, but am 
having the same problem after upgrading to 2.4.26-2um-1:


Checking for the skas3 patch in the host...found
Checking for /proc/mm...found
Checking for /dev/anon on the host...Not available (open failed with 
errno 2)
Linux version 2.4.26-2um (root@mizar) (gcc version 3.3.4 (Debian 
1:3.3.4-3)) #2 Fri Jul 16 17:51:17 PDT 2004
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: ubd0=rootfs mem=64M eth0=daemon devfs=nomount 
hostfs=hostroot root=/dev/ubd0
Calibrating delay loop... 1723.59 BogoMIPS
Memory: 60208k available
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling 
workaround
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
SGI XFS with ACLs, no debug enabled
SGI XFS Quota Management subsystem
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Initializing Cryptographic API
Initializing software serial port version 1
Netdevice 0 : daemon backend (uml_switch version 3) - 
unix:/var/run/uml-utilities/uml_switch.ctl
mconsole (version 2) initialized 
on /home/alydar/.uml/simpleuml/mconsole
Partition check:
 ubda: unknown partition table
Initializing stdio console driver
NET4: Linux TCP/IP 1.0 for NET4.0
(hangs here)


----- End forwarded message -----

-- 
 - mdz


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
