Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CHWgg-0000Gy-7f for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Oct 2004 17:08:14 -0700
Received: from main.gmane.org ([80.91.229.2])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CHWgb-0003ST-Nq for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Oct 2004 17:08:14 -0700
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1CHWgZ-0006go-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 13 Oct 2004 02:08:07 +0200
Received: from 209-6-22-202.c3-0.smr-ubr1.sbo-smr.ma.cable.rcn.com
	([209.6.22.202]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 13 Oct 2004 02:08:07 +0200
Received: from lars by 209-6-22-202.c3-0.smr-ubr1.sbo-smr.ma.cable.rcn.com
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 13 Oct 2004 02:08:07 +0200
From: Lars Kellogg-Stedman <lars@oddbit.com>
Message-ID: <lars-8DC59E.20075912102004@sea.gmane.org>
References: <lars-37F7DA.20415609102004@sea.gmane.org>
	<200410122333.i9CNXq3P004254@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: Kernel panic "read of switch_pipe failed" in 2.6.8.1
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
Date: Tue, 12 Oct 2004 20:07:59 -0400
To: user-mode-linux-devel@lists.sourceforge.net

In article <200410122333.i9CNXq3P004254@ccure.user-mode-linux.org>,
 Jeff Dike <jdike@addtoit.com> wrote:

> What's the full output?
> 
> This has happened once or twice before, and the cause was something closing
> the wrong file descriptor.

Here's the complete kernel log:

Checking for the skas3 patch in the host...not found
Checking for /proc/mm...not found
tracing thread pid = 10637
Linux version 2.6.8.1-1um (lars@flowers) (gcc version 3.3.4 (Debian 
1:3.3.4-13)) #1 Mon Oct 11 11:34:18 EDT 2004
Built 1 zonelists
Kernel command line: uml_dir=/var/uml/machines/lars000/control 
ubd0=root_fs.cow mem=64m con0=fd:0,fd:1 con=null umlctl=ssl4 ssl4=pts 
root=98:0
PID hash table entries: 16 (order 4: 128 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 60848k available
Calibrating delay loop... 313.75 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
Checking for /dev/anon on the host...Not available (open failed with 
errno 2)
NET: Registered protocol family 16
mconsole (version 2) initialized on 
/var/uml/machines/lars000/control/lars000/mconsole
SGI XFS with ACLs, no debug enabled
Initializing Cryptographic API
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
NET: Registered protocol family 1
NET: Registered protocol family 17
Initializing software serial port version 1
Kernel panic: read of switch_pipe failed, errno = 9
 <6>SysRq : Show Regs

EIP: 0023:[<a01c0682>] CPU: 0 Not tainted ESP: 002b:a3f386a4 EFLAGS: 
00200282
    Not tainted
EAX: 00000000 EBX: 00000001 ECX: a3f38744 EDX: a3f386c4
ESI: 00000008 EDI: 0000000a EBP: a3f386ac DS: 002b ES: 002b
Call Trace: [<a00378fb>] [<a001c44b>] [<a0044e8d>] [<a0036c4b>] 
[<a01d74f0>]
   [<a001d518>] [<a0204527>] [<a00394ab>] [<a00116a2>] [<a004805d>] 
[<a01c03d0>]
   [<a0047fd0>] [<a0016699>] [<a01c0754>] [<a0047fd0>] [<a001667e>] 
[<a0047fd0>]
   [<a001d750>] [<a0047fd0>] [<a01c0628>] [<a01c0682>]
sleeping process 10866 got unexpected signal : 11

-- Lars



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
