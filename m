Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BpUzs-0001mc-LT for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jul 2004 09:40:12 -0700
Received: from behlendorf.csee.wvu.edu ([157.182.194.147])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BpUzs-0006e8-31 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jul 2004 09:40:12 -0700
Received: from csee.wvu.edu (behlendorf [127.0.0.1])
	by behlendorf.csee.wvu.edu (Postfix) with SMTP id 34ED11342B7
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 27 Jul 2004 12:39:59 -0400 (EDT)
Message-ID: <1359.157.182.42.226.1090946399.squirrel@www.csee.wvu.edu>
From: <atanugul@csee.wvu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: [uml-devel] help needed for running uml on a sarge
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
Date: Tue, 27 Jul 2004 12:39:59 -0400 (EDT)
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Hi!
I am a newbie to the user mode linux.I tried to run user mode linux on a
sarge installation. I installed uml by using 'apt-get install
user-mode-linux'. Then I did the following


ashwin@Debian:~$ cd /usr/bin
ashwin@Debian:/usr/bin$ ./linux
Checking for the skas3 patch in the host...not found
Checking for /proc/mm...not found
tracing thread pid =3D 2772
Checking for /dev/anon on the host...Not available (open failed with errno =
2)
Checking for /dev/anon on the host...Not available (open failed with errno =
2)
Checking for /dev/anon on the host...Not available (open failed with errno =
2)
Checking for /dev/anon on the host...Not available (open failed with errno =
2)
Linux version 2.4.26-1um (root@mizar) (gcc version 3.3.3 (Debian
20040422)) #2 Sat Jun 5 12:15:21 PDT 2004On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=3D/dev/ubd0
Calibrating delay loop... 4010.80 BogoMIPS
Memory: 28148k available
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
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
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
SGI XFS with ACLs, no debug enabled
SGI XFS Quota Management subsystem
Disabling 2.6 AIO in tt mode
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Initializing Cryptographic API
Initializing software serial port version 1
mconsole (version 2) initialized on /home/ashwin/.uml/VoZ3kS/mconsole
unable to open root_fs for validation
Initializing stdio console driver
ashwin@Debian:/usr/bin$ cd /usr/bin
ashwin@Debian:/usr/bin$ ./linux
Checking for the skas3 patch in the host...not found
Checking for /proc/mm...not found
tracing thread pid =3D 2824
Checking for /dev/anon on the host...Not available (open failed with errno =
2)
Checking for /dev/anon on the host...Not available (open failed with errno =
2)
Checking for /dev/anon on the host...Not available (open failed with errno =
2)
Checking for /dev/anon on the host...Not available (open failed with errno =
2)
Linux version 2.4.26-1um (root@mizar) (gcc version 3.3.3 (Debian
20040422)) #2 Sat Jun 5 12:15:21 PDT 2004On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=3D/dev/ubd0
Calibrating delay loop... 4037.01 BogoMIPS
Memory: 28148k available
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
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
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
SGI XFS with ACLs, no debug enabled
SGI XFS Quota Management subsystem
Disabling 2.6 AIO in tt mode
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Initializing Cryptographic API
Initializing software serial port version 1
mconsole (version 2) initialized on /home/ashwin/.uml/TTQaVd/mconsole
unable to open root_fs for validation
Initializing stdio console driver
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Cannot open root device "ubd0" or 62:00
Please append a correct "root=3D" boot option
Kernel panic: VFS: Unable to mount root fs on 62:00
 <6>SysRq : Show Regs

EIP: 0073:[<a0201bb2>] CPU: 0 Not tainted ESP: 007b:a03f76a4 EFLAGS: 002002=
82
    Not tainted
EAX: 00000000 EBX: 00000001 ECX: a03f7744 EDX: a03f76c4
ESI: 00000008 EDI: 0000000a EBP: a03f76ac DS: 007b ES: 007b
Call Trace: [<a016ecd0>] [<a015589f>] [<a0023b2d>] [<a0014c08>] [<a0002ac0>]
   [<a02697a0>] [<a000f680>] [<a0003c0c>] [<a025f57f>] [<a000f680>]
   [<a000fc25>]   [<a025f57f>] [<a000f693>] [<a0201900>] [<a014f7b9>]
   [<a0201c44>]   [<a000f680>]   [<a014f79e>] [<a000f680>] [<a0156e35>] [<a=
000f680>]
   [<a0201b58>]   [<a0201bb2>]


can someone tell me what shd i do?

thanks
Ashwin








-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_idG21&alloc_id=10040&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
