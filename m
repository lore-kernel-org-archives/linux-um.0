Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CF0Zp-0004Sq-Jr for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Oct 2004 18:26:45 -0700
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CF0Zm-0002hg-HH for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Oct 2004 18:26:45 -0700
Received: from hawk (mothership.theshore.net [69.137.84.52])
	by www.theshore.net (8.12.9/8.9.1) with SMTP id i961QfZk015484
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 5 Oct 2004 21:26:41 -0400
Message-ID: <001d01c4ab44$484f9f40$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] 2.4.27 + 2.4.26-3um - Kernel panic: handle_trap - failed
	to wait at end of syscall, errno = 4, status = 4479
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
Date: Tue, 5 Oct 2004 20:31:55 -0500
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Linux version 2.4.27-linode33-3um (root@host4.linode.com) (gcc version 3.2.2
20030222 (Red Hat Linux 3.2.2-5)) #1 Tue Oct 5 19:3
3:13 EDT 2004
On node 0 totalpages: 24576
zone(0): 24576 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: mem=96M fake_ide fakehd con=null con0=fd:0,fd:1 devfs=nomount
root=/dev/ubda ubda=/linodes/jax/3946.fs ubdb
=/linodes/jax/3947.fs eth0=tuntap,jax_0,fe:fd:45:38:ad:1e token_max=400000
token_refill=512
fakehd : Changing ubd_gendisk.major_name to "hd".
Calibrating delay loop... 2470.70 BogoMIPS
Memory: 91496k available
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...missing
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
POSIX conformance testing by UNIFIX
[snip]
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
INIT: version 2.84 booting
Kernel panic: handle_trap - failed to wait at end of syscall, errno = 4, status =
4479

 <6>SysRq : Show Regs

EIP: 0073:[<080594ec>] CPU: 0 Not tainted ESP: 007b:bffff820 EFLAGS: 00000246
    Not tainted
EAX: 00000011 EBX: bffffa20 ECX: bffff960 EDX: bffff8e0
ESI: bffff960 EDI: bffff8e0 EBP: bffff828 DS: 007b ES: 007b
Call Trace: [<80315778>] [<80317cb6>] [<800115f3>] [<801adc52>] [<80199325>]
   [<8001e3fa>] [<80013cb4>] [<80013d46>] [<8019ccf2>] [<80340e00>] [<8019cfe0>]
   [<8000f184>] [<8019d63c>] [<8019d095>] [<802b0118>] [<802b0381>]

Filesystem is Slackware 9 (no /lib/tls), will try to test some under gdb...

-Chris



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
