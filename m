Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CKwxc-0004XR-SI for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 03:47:52 -0700
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CKwxb-0000pY-Vh for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 03:47:52 -0700
Received: from wfilter.us4.outblaze.com (wfilter.us4.outblaze.com
	[205.158.62.180])
	by webmail-outgoing.us4.outblaze.com (Postfix) with QMQP id
	44D2A18007E8 for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 22 Oct 2004 10:47:30 +0000 (GMT)
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
MIME-Version: 1.0
From: "Peter Breuer" <ptb@linuxmail.org>
Message-Id: <20041022104730.2E91B3AA515@ws5-8.us4.outblaze.com>
Subject: [uml-devel] 2.6.8.1 fails to boot - unexpected signal - SOLVED
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
Date: Fri, 22 Oct 2004 11:47:30 +0100
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net



 
 
The following failure has now been traced down to the following .config
difference between good and bad configs:
 
 
  (diff .config.good .config.bad)
  < # CONFIG_KMOD is not set
  ---
  > CONFIG_KMOD=y
 
 
> Checking for the skas3 patch in the host...not found
> Checking for /proc/mm...not found
> tracing thread pid = 16051
> Linux version 2.6.8.1-UML-1um (root@betty.it.uc3m.es) (gcc version
> 2.95.4 20011002 (Debian prerelease)) #36 Tue Oct 12 21:51:57 CEST 2004
> Built 1 zonelists
> Kernel command line:
> ubd0=/usr/local/src/linux-2.6.8.1-uml/root_fs_toms1.7.205.small
> eth0=tuntap,tap0,,192.168.222.254 ro pwd=/usr/oboe/ptb root=98:0
> PID hash table entries: 16 (order 4: 128 bytes)
> Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
> Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
> Memory: 29592k available
> Calibrating delay loop... 1120.66 BogoMIPS
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> Checking for host processor cmov support...Yes
> Checking for host processor xmm support...No
> Checking that ptrace can change system call numbers...OK
> Checking that host ptys support output SIGIO...Yes
> Checking that host ptys support SIGIO on close...No, enabling
> workaround
> Checking for /dev/anon on the host...Not available (open failed with
> errno 6)
> NET: Registered protocol family 16
> mconsole (version 2) initialized on /usr/oboe/ptb/.uml/JcQUhY/mconsole
> Netdevice 0 : TUN/TAP backend - IP = 192.168.222.254
> devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
> devfs: boot_options: 0x0
> Initializing Cryptographic API
> loop: loaded (max 8 devices)
> Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
> NET: Registered protocol family 2
> IP: routing cache hash table of 512 buckets, 4Kbytes
> TCP: Hash tables configured (established 2048 bind 2048)
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> Initializing software serial port version 1
> Using anticipatory io scheduler
>  /dev/ubd/disc0: unknown partition table
> Initializing stdio console driver
> VFS: Mounted root (ext2 filesystem) readonly.
> INIT: version 2.84 booting
> Entering rc.S
> none /proc proc rw,nodiratime 0 0
> Exiting rc.S
> INIT: Entering runlevel: 5
> Entering rc.M
> + echo Entering rc.custom
> Entering rc.custom
> + cd /etc
> + [ ! -s resolv.conf ]
> + [ ! -s hosts ]
> + [ ! -s networks ]
> + [ ! -s passwd ]
> + [ ! -s profile ]
> + hostname localhost
> + ifconfig lo 127.0.0.1
> Kernel panic: fix_range fixing wrong address space, current =
> 0xa02d30c0
>  <6>SysRq : Show Regs
> 
> EIP: 0023:[<a0128834>] CPU: 0 Not tainted ESP: 002b:a1ecc678 EFLAGS:
> 00000246
>     Not tainted
> EAX: 00000000 EBX: 00000001 ECX: a1ecc744 EDX: a1ecc6c4
> ESI: 00000008 EDI: 00000001 EBP: a1ecc694 DS: 002b ES: 002b
> Call Trace: [<a002ee79>] [<a00ccd30>] [<a00ccd1a>] [<a00cccd9>]
> [<a00ccde0>] 
>    [<a002ef8e>] [<a0016876>] [<a002ee67>] [<a002ee79>] [<a003a8dc>]
> [<a00bdfa7>] 
>    [<a002ee79>] [<a002e3d8>] [<a002e3c4>] [<a002e3ba>] [<a0014060>]
> [<a0018b7a>] 
>    [<a0018b5b>] [<a001413e>] [<a0019021>] [<a001584f>] [<a001577f>]
> [<a001790a>] 
>    [<a00177ce>] [<a003d768>] [<a0011aeb>] [<a0014098>] [<a0155d09>]
> [<a0155a73>] 
>    [<a003d768>] [<a0029c13>] [<a00309bc>] [<a0029c83>] [<a003d768>]
> [<a00179ac>] 
>    [<a00140ac>] [<a0017a42>] [<a0017af1>] [<a001619b>] [<a01287f8>]
> [<a0128834>] 
> sleeping process 16178 got unexpected signal : 10
 

compiler and glibc variations tried include gcc 2.95.4, 3.4.0, glibc
2.1 2.2 2.3 . It's all down to the config.
 
Peter
 
 

-- 
______________________________________________
Check out the latest SMS services @ http://www.linuxmail.org 
This allows you to send and receive SMS through your mailbox.

Powered by Outblaze


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
