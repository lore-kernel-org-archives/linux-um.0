Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A04VI-0003g7-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 18 Sep 2003 12:31:48 -0700
Received: from esperi.demon.co.uk ([194.222.138.8] ident=0)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A04VF-0000oj-UY
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Sep 2003 12:31:46 -0700
Received: from esperi.demon.co.uk (1000@amaterasu.srvr.nix [192.168.1.14])
	by esperi.demon.co.uk (8.12.10/8.12.10) with ESMTP id h8IJVa7l032181
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 18 Sep 2003 20:31:36 +0100
Subject: Re: [uml-devel] redefinition of `struct ptrace_faultinfo' with
 uml-2.4.22-4 + skas3
References: <87brtkuwm8.fsf@amaterasu.srvr.nix>
From: Nix <nix@esperi.demon.co.uk>
In-Reply-To: <87brtkuwm8.fsf@amaterasu.srvr.nix> (nix@esperi.demon.co.uk's
 message of "Wed, 17 Sep 2003 00:44:31 +0100")
Message-ID: <87llsluc4p.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Thu, 18 Sep 2003 20:31:34 +0100
To: user-mode-linux-devel@lists.sourceforge.net

On Wed, 17 Sep 2003, nix@esperi.demon.co.uk muttered drunkenly:
> This has come up before on the lists (first report in late 2002), and
> nobody's ever come up with preprocessed source. Until now.

I've kludged around it like so:

Index: linux/include/asm-um/ptrace-generic.h
===================================================================
RCS file: /cvsroot/user-mode-linux/linux/include/asm-um/ptrace-generic.h,v
retrieving revision 1.11
diff -u -r1.11 ptrace-generic.h
--- linux/include/asm-um/ptrace-generic.h	20 Dec 2002 23:52:04 -0000	1.11
+++ linux/include/asm-um/ptrace-generic.h	18 Sep 2003 19:23:39 -0000
@@ -14,6 +14,8 @@
 
 #define pt_regs pt_regs_subarch
 #define show_regs show_regs_subarch
+#define ptrace_faultinfo ptrace_faultinfo_subarch
+#define ptrace_ldt ptrace_ldt_subarch
 
 #include "asm/arch/ptrace.h"
 
@@ -21,6 +23,8 @@
 #undef show_regs
 #undef user_mode
 #undef instruction_pointer
+#undef ptrace_faultinfo
+#undef ptrace_ldt
 
 #include "sysdep/ptrace.h"
 #include "skas_ptrace.h"

However, I now have *another* problem. (This could well be a problem for
-user, but I can't tell; SourceForge's useless mail archive search
system is down. Again.)

loki:/mirror/uml# uml-esperi ubd0=/mirror/uml/esperi-core-cow.image,/mirror/uml/esperi-core.image umid=esperi eth0=tuntap,tap0 eth1=tuntap,tap1
Checking for the skas3 patch in the host...found
Checking for /proc/mm...found
Linux version 2.4.22-4um (compiler@loki) (gcc version 2.95.4 20010319 (prerelease)) #2 Thu Sep 18 10:46:56 BST 2003
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: ubd0=/mirror/uml/esperi-core-cow.image,/mirror/uml/esperi-core.image umid=esperi eth0=tuntap,tap0 root=/dev/ubd0
Calibrating delay loop... 483.69 BogoMIPS
Memory: 30116k available
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Checking for host processor cmov support...No
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
pty: 256 Unix98 ptys configured
Initializing software serial port version 1
mconsole (version 2) initialized on /root/.uml/esperi/mconsole
Creating "/mirror/uml/esperi-core-cow.image" as COW file for "/mirror/uml/esperi-core.image"
Partition check:
 ubda: unknown partition table
io_thread - read failed, err = 9
Kernel panic: Kernel mode signal 8
 
<6>Initializing stdio console driver
Netdevice 0 : TUN/TAP backend - 
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
ip_conntrack version 2.1 (235 buckets, 1880 max) - 288 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Ethernet Bridge 008 for NET4.0
[freeze]

It's not completely repeatable; I get a boot about 20% of the time
(identical log up to the entry to userspace except for the absence of
the read failed and panic messages), and this the rest of the time.
If I turn TUN/TAP off, the problem goes away, so it looks like I'm
using TUN/TAP wrongly.

I get the same failure mode whether I say

eth0=tuntap,tap0

or whether I let uml_net do the magic via

eth0=tuntap,,,192.168.14.20

I presume something is wrong with the TUN/TAP code.

-- 
`I treat debconf as a hostile imperialist agent.  "ALL CONFIGS YOURS
 NOW CONFIGS OURS ARE."' --- Stephen J. Turnbull


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
