Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CU3wS-0000M7-RK for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Nov 2004 06:04:20 -0800
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CU3wR-00064b-MW for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Nov 2004 06:04:20 -0800
From: Anton Altaparmakov <aia21@cam.ac.uk>
Content-Type: text/plain
Message-Id: <1100613788.24599.45.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] And another bug report for UML in latest Linux 2.6-BK
	repository.
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
Date: Tue, 16 Nov 2004 14:03:09 +0000
To: jdike@karaya.com
Cc: user-mode-linux-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>

With my .config (quoted in my first bug report), just disabling SKAS
mode, makes UML compile but not work at all.  It goes like this before
it locks up:

linux umid=uml0 mem=256m ubd0=ubd0 ubd1=/usr/src/ntfs_hdd10
eth0=tuntap,uml0,fe:fd:dd:f8:a6:4e ssl=none con=xterm
xterm=gnome-terminal,-t,-x root=/dev/ubda1
Set 'uml0' persistent and owned by uid 29847
Starting uml...
Checking PROT_EXEC mmap in /tmp...OK
Kernel virtual memory size shrunk to 243269632 bytes
tracing thread pid = 29367
Linux version 2.6.10-rc2 (aia21@imp) (gcc version 3.3.4 (pre 3.3.5
20040809)) #1 Tue Nov 16 13:59:36 GMT 2004
Built 1 zonelists
Kernel command line: mem=256m ubd0=ubd0 ubd1=/usr/src/ntfs_hdd10
eth0=tuntap,uml0,fe:fd:dd:f8:a6:4e ssl=none con=xterm root=/dev/ubda1
PID hash table entries: 2048 (order: 11, 32768 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 254592k available
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...check_ptrace : child
exited with exitcode 1, while expecting 0; status 0x100
missing
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
Checking for /dev/anon on the host...Not available (open failed with
errno 2)
NET: Registered protocol family 16
sleeping process 29410 got unexpected signal : 11

I now have to press Ctrl+C to get back to my shell.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
