Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CFrmr-0004GG-Qb for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Oct 2004 03:15:45 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CFrmo-00013v-Hk for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Oct 2004 03:15:45 -0700
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [uml-devel] Kernel panic: check_ptrace : child exited with status
	0x100
Message-ID: <8B6FF516CBA0194AB0996705076B02520F7C53@ABGEX01E.abg.fsc.net>
From: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>
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
Date: Fri, 8 Oct 2004 12:13:15 +0200
Content-Transfer-Encoding: 8bit
To: "Christopher S. Aker" <caker@theshore.net>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

 

-----Original Message-----
From: user-mode-linux-devel-admin@lists.sourceforge.net
[mailto:user-mode-linux-devel-admin@lists.sourceforge.net] On Behalf Of
Christopher S. Aker
Sent: Thursday, October 07, 2004 11:17 PM
To: uml-devel
Subject: [uml-devel] Kernel panic: check_ptrace : child exited with
status 0x100

Ok, so a new combination.  This is 2.4.27 + 2.4.26-um + all the
incremental + Bodo's
sysemu-panic patch.  It works fine on non-sysemu hosts, and on a host
with the
original version of sysemu.

I think the key here is that this host has the latest (v5) SKAS patch,
whereas the
2.6.7 host kernel used the standard sysemu patch.

----
Checking for the skas3 patch in the host...found
Checking for /proc/mm...found
Checking PROT_EXEC mmap in /tmp...OK
Checking for /dev/anon on the host...Not available (open failed with
errno 6)
Linux version 2.4.27-linode35-3um (caker@host4.linode.com) (gcc version
3.2.2
20030222 (Red Hat Linux 3.2.2-5)) #1 Wed Oct 6 11:31:28 EDT 2004
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: mem=64M fake_ide fakehd con=null con0=fd:0,fd:1
devfs=nomount
root=/dev/ubda ubda=/linodes/luctourangeau/13588.fs
ubdb=/linodes/luctourangeau/13586.fs
eth0=tuntap,luctourangeau_0,fe:fd:46:55:10:64
token_max=400000 token_refill=512
fakehd : Changing ubd_gendisk.major_name to "hd".
Calibrating delay loop... 3787.98 BogoMIPS
Memory: 59436k available
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...<0>Kernel panic:
check_ptrace : child
exited with status 0x100
In idle task - not syncing
 <6>SysRq : Show Regs

EIP: 0000:[<00000000>] CPU: 0 Not tainted EFLAGS: 00000000
    Not tainted
EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
ESI: 00000000 EDI: 00000000 EBP: 00000000 DS: 0000 ES: 0000
Call Trace: [<80315778>] [<80317cb6>] [<800115f3>] [<801adc3a>]
[<801992f5>]
   [<8001e3fa>] [<80013cb4>] [<80193f0d>] [<8033efe0>] [<800075c5>]
[<803178fa>]
   [<8019d8a0>] [<80007b65>] [<800024b2>] [<8019d8a0>] [<80002459>]
[<8019d8c5>]
   [<8019d8a0>] [<80193fad>] [<8019d8a0>] [<80193f88>] [<8019d8a0>]
[<8019d609>]
   [<8019d8a0>] [<8019d07d>] [<802b0108>] [<802b0371>]

-Chris



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give
us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out
more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
