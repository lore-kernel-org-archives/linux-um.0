Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CEuui-0001mc-Kb for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Oct 2004 12:23:56 -0700
Received: from gtfw2.enterasys.com ([12.25.1.128] ident=firewall-user)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CEuty-0005lo-RE for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Oct 2004 12:23:56 -0700
Received: from NHROCAVG2.ets.enterasys.com (nhrocavg2.enterasys.com
	[134.141.79.124])
	by gtfw2.enterasys.com (0.25.1/8.12.6) with ESMTP id i95JMwao003874
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 5 Oct 2004 15:22:58 -0400 (EDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <EAC7622167479948B614F8B9AD41C505ECA5CD@MAANDMBX2.ets.enterasys.com>
From: "Tsillas, Demetrios J" <jtsillas@enterasys.com>
Subject: [uml-devel] 2.6.8.1: Kernel panic: handle_trap - failed to wait at
	end of syscall, errno = 4, status = 4479
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
Date: Tue, 5 Oct 2004 15:22:04 -0400
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net

I'm trying with root_fs.fc-2-client.pristine.20040504. I've got
the incrementals in there:

Checking for the skas3 patch in the host...found
Checking for /proc/mm...found
Checking PROT_EXEC mmap in /tmp...OK
Linux version 2.6.8.1-1um (jtsillas@gabriel) (gcc version 3.2.2 20030222
(Red Hat Linux 3.2.2-5)) #1 Tue Oct 5 15:17:54 EDT 2004
Built 1 zonelists
Kernel command line:
ubd0=/local/tmp/root_fs.fc-2-client.pristine.20040504 root=98:0
PID hash table entries: 16 (order 4: 128 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 30040k available
Calibrating delay loop... 3722.44 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...missing
openpty failed, errno = 8
openpty failed, errno = 8
Checking for /dev/anon on the host...Not available (open failed with
errno 2)
NET: Registered protocol family 16
mconsole (version 2) initialized on /home/jtsillas/.uml/BlLygB/mconsole
ubd : Synchronous mode
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
loop: loaded (max 8 devices)
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
NET: Registered protocol family 1
NET: Registered protocol family 17
Initializing software serial port version 1
Using anticipatory io scheduler
 /dev/ubd/disc0: unknown partition table
Initializing stdio console driver
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
INIT: version 2.85 booting
Kernel panic: handle_trap - failed to wait at end of syscall, errno = 4,
status = 4479


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
