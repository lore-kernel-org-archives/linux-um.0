Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AuvXl-00036K-EI for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Feb 2004 07:29:21 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AuvQf-00053U-UB for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Feb 2004 07:22:02 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-user] Re: [uml-devel] new skas3 patch ready for 2.4.25
References: <40338C1B.1070800@meisterwerk.net>
	<200402202125.58574.blaisorblade_spam@yahoo.it>
	<87k72gv3cg.fsf@amaterasu.srvr.nix>
In-Reply-To: <87k72gv3cg.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200402221516.09898.blaisorblade_spam@yahoo.it>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
Date: Sun, 22 Feb 2004 16:00:38 +0100
To: Nix <nix@esperi.org.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

Alle 16:50, sabato 21 febbraio 2004, Nix ha scritto:
> On Fri, 20 Feb 2004, BlaisorBlade informed the cosmos:
> > Yes, it went away, so a new skas patch must be built. I have one (tested)
> > at http://www.user-mode-linux.org/~blaisorblade/
I'm running that patch and someone else reported success.

> Checking for the skas3 patch in the host...found
> Checking for /proc/mm...found
> Checking for /dev/anon on the host...Not available (open failed with errno
> 2) Linux version 2.4.24-1um (compiler@loki) (gcc version 2.95.4 20010319
> (prerelease)) #1 Wed Feb 18 22:58:16 GMT 2004
> On node 0 totalpages: 24576
> zone(0): 24576 pages.
> zone(1): 0 pages.
> zone(2): 0 pages.
> Kernel command line: con=port:16380 con0=fd:0,fd:1 fakeide mem=96M
> ubd0=/mirror/uml/esperi-root-cow.image,/mirr or/uml/esperi-root.image
> tty_log_dir=/home/firewall/log/esperi umid=esperi
> eth0=tuntap,tap0,00:60:97:79:E2:C1 e th1=tuntap,tap1 root=/dev/ubd0
> Calibrating delay loop... 465.30 BogoMIPS
> Memory: 94412k available
> Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
> Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
> Mount cache hash table entries: 512 (order: 0, 4096 bytes)
> Buffer cache hash table entries: 4096 (order: 2, 16384 bytes)
> Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Checking for host processor cmov support...No
> Checking for host processor xmm support...No
> Checking that ptrace can change system call numbers...OK
> Checking that host ptys support output SIGIO...Yes
> Checking that host ptys support SIGIO on close...No, enabling workaround
> POSIX conformance testing by UNIFIX
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> Starting kswapd
> VFS: Disk quotas vdquot_6.5.1
> Journalled Block Device driver loaded
> pty: 256 Unix98 ptys configured
> Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
> Initializing software serial port version 1
> mconsole (version 2) initialized on /home/firewall/.uml/esperi/mconsole
> Partition check:
>  ubda: unknown partition table
> Initializing stdio console driver
> Netdevice 0 (00:60:97:79:e2:c1) : TUN/TAP backend -
> Netdevice 1 (00:60:97:79:e2:c1) : TUN/TAP backend -
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 512 buckets, 4Kbytes
> TCP: Hash tables configured (established 8192 bind 8192)
> ip_conntrack version 2.1 (737 buckets, 5896 max) - 288 bytes per conntrack
> ip_tables: (C) 2000-2002 Netfilter core team
> ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>. 
> http://snowman.net/projects/ipt_recent/ NET4: Unix domain sockets 1.0/SMP
> for Linux NET4.0.
> NET4: Ethernet Bridge 008 for NET4.0
> VFS: Mounted root (ext2 filesystem) readonly.
> Kernel panic: switch_mm_skas - PTRACE_SWITCH_MM failed, errno = 5
>
> That's -EIO.
>
> (Of course, CONFIG_PROC_MM=y on the host and the host is running
> 2.4.25+skas-2.4.25.)

Hmmm, I've looked at the faulting code and IMHO the most probable thing is a 
compilation problem (forgot make dep after applying the patch, for instance) - 
try saving your .config, running make mrproper, 
grepping through .config to check that CONFIG_PROC_MM=y and recompiling the 
bzImage:
 $ make dep bzImage

Rebuilding modules *probably* is not necessary, but I'm not sure - rerun 
depmod with the newly created System.map with the already installed 2.4.25 
modules to check that symbols can actually be resolved.

More exactly, it seems that arch/i386/kernel/ptrace.c was recompiled after 
applying the patch but without CONFIG_PROC_MM on.

Also, IMHO that kind of error cannot be returned by sys_ptrace, unless 
CONFIG_PROC_MM was off when compiling that file (I've also checked 
proc_mm_get_mm).

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
