Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BmGf2-0005OL-Oe for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jul 2004 11:45:20 -0700
Received: from mta10.adelphia.net ([68.168.78.202])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BmGf1-0005YK-U2 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jul 2004 11:45:20 -0700
From: Matt Zimmerman <mdz@debian.org>
Message-ID: <20040718184513.GP4090@mizar.alcor.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mxv5cy4qt+RJ9ypb"
Content-Disposition: inline
Subject: [uml-devel] [Bug#260111: user-mode-linux: upgrade hangs at "NET4:
	Linux TCP/IP 1.0 for NET4.0"]
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
Date: Sun, 18 Jul 2004 11:45:13 -0700
To: user-mode-linux-devel@lists.sourceforge.net
Cc: 260111-forwarded@bugs.debian.org, Brian McGroarty <brian@mcgroarty.net>



--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I received this bug report from a Debian user.  It seems that something is
wrong with tt mode in 2.4.26-2um; I can reproduce a similar (though not
identical) hang by trying to boot with mode=tt (my host kernel is 2.6.6 with
skas3).  In my case, it hangs after init has started.  Booting in skas mode
works fine (which is why I didn't notice this in the first place).

-- 
 - mdz

--mxv5cy4qt+RJ9ypb
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <debbugs@bugs.debian.org>
X-Original-To: mdz@csh.rit.edu
Delivered-To: mdz@csh.rit.edu
Received: from mail.csh.rit.edu [129.21.60.6]
	by localhost with IMAP (fetchmail-6.2.5)
	for mdz@localhost (single-drop); Sun, 18 Jul 2004 08:11:34 -0700 (PDT)
Received: from spohr.debian.org (spohr.debian.org [128.193.0.4])
	by blacksheep.csh.rit.edu (Postfix) with ESMTP id AE25D92F4
	for <mdz@csh.rit.edu>; Sun, 18 Jul 2004 11:09:27 -0400 (EDT)
Received: from debbugs by spohr.debian.org with local (Exim 3.35 1 (Debian))
	id 1BmDBv-0007aF-00; Sun, 18 Jul 2004 08:03:03 -0700
X-Loop: owner@bugs.debian.org
Subject: Bug#260111: user-mode-linux: upgrade hangs at "NET4: Linux TCP/IP 1.0
	for NET4.0"
Reply-To: Brian McGroarty <brian@sb.mcgroarty.net>,
	260111@bugs.debian.org
Resent-From: Brian McGroarty <brian@sb.mcgroarty.net>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Cc: Matt Zimmerman <mdz@debian.org>
Resent-Date: Sun, 18 Jul 2004 15:03:02 UTC
Resent-Message-ID: <handler.260111.B.109016229926333@bugs.debian.org>
X-Debian-PR-Message: report 260111
X-Debian-PR-Package: user-mode-linux
X-Debian-PR-Keywords: 
Received: via spool by submit@bugs.debian.org id=B.109016229926333
	(code B ref -1); Sun, 18 Jul 2004 15:03:02 UTC
Received: (at submit) by bugs.debian.org; 18 Jul 2004 14:51:39 +0000
Received: from jd.mcgroarty.net (sb.mcgroarty.net) [69.44.153.114] 
	by spohr.debian.org with esmtp (Exim 3.35 1 (Debian))
	id 1BmD0t-0006qY-00; Sun, 18 Jul 2004 07:51:39 -0700
Received: from brian by sb.mcgroarty.net with local (Exim 4.32)
	id 1BmD0v-00039M-FQ; Sun, 18 Jul 2004 09:51:41 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Brian McGroarty <brian@sb.mcgroarty.net>
To: Debian Bug Tracking System <submit@bugs.debian.org>
X-Mailer: reportbug 2.63
Date: Sun, 18 Jul 2004 09:51:41 -0500
Message-Id: <E1BmD0v-00039M-FQ@sb.mcgroarty.net>
Delivered-To: submit@bugs.debian.org
X-Spam-Checker-Version: SpamAssassin 2.60-bugs.debian.org_2004_03_25 
	(1.212-2003-09-23-exp) on spohr.debian.org
X-Spam-Status: No, hits=-8.0 required=4.0 tests=BAYES_00,HAS_PACKAGE 
	autolearn=no version=2.60-bugs.debian.org_2004_03_25
X-Spam-Level: 
Resent-Sender: Debian BTS <debbugs@bugs.debian.org>
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.92.2

Package: user-mode-linux
Version: 2.4.26-2um-1
Severity: normal


On upgrading user-mode-linux, my guest machines all hang during
startup, as below.

When I ran again with "|tee log.txt" to generate the log below, the
machine makes it through the kernel startup and hangs on usermode
daemons trying to start.


Checking for the skas3 patch in the host...not found
Checking for /proc/mm...not found
Kernel virtual memory size shrunk to 243269632 bytes
Checking for /dev/anon on the host...Not available (open failed with errno 2)
Checking for /dev/anon on the host...Not available (open failed with errno 2)
Checking for /dev/anon on the host...Not available (open failed with errno 2)
Checking for /dev/anon on the host...Not available (open failed with errno 2)
Linux version 2.4.26-2um (root@mizar) (gcc version 3.3.4 (Debian 1:3.3.4-3)) #2 Fri Jul 16 17:51
:17 PDT 2004
On node 0 totalpages: 65536
zone(0): 65536 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: -s mem=256M eth0=daemon root=/dev/ubd/0 devfs=mount hostfs=/home/brian/uml/
hostfs ubd0=/home/brian/uml/drives/mcg.root ubd1=/home/brian/uml/drives/mcg.swap
Calibrating delay loop... 2090.59 BogoMIPS
Memory: 252584k available
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
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
devfs: boot_options: 0x1
SGI XFS with ACLs, no debug enabled
SGI XFS Quota Management subsystem
Disabling 2.6 AIO in tt mode
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Initializing Cryptographic API
Initializing software serial port version 1
Netdevice 0 : daemon backend (uml_switch version 3) - unix:/var/run/uml-utilities/uml_switch.ctl
mconsole (version 2) initialized on /home/brian/.uml/mcg/mconsole
Partition check:
 ubda: unknown partition table
 ubdb: unknown partition table
Initializing stdio console driver
NET4: Linux TCP/IP 1.0 for NET4.0
[hang here]

-- System Information:
Debian Release: testing/unstable
  APT prefers unstable
  APT policy: (500, 'unstable')
Architecture: i386 (i686)
Kernel: Linux 2.6.7-1-k7
Locale: LANG=C, LC_CTYPE=C

Versions of packages user-mode-linux depends on:
ii  uml-utilities                 20040406-1 User-mode Linux (utility programs)

-- no debconf information

--mxv5cy4qt+RJ9ypb
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <brian@mcgroarty.net>
X-Original-To: mdz@csh.rit.edu
Delivered-To: mdz@csh.rit.edu
Received: from mail.csh.rit.edu [129.21.60.6]
	by localhost with IMAP (fetchmail-6.2.5)
	for mdz@localhost (single-drop); Sun, 18 Jul 2004 11:33:21 -0700 (PDT)
Received: from laphroaig.gandi.net (redir-mail-telehouse2.gandi.net
	[80.67.173.4])
	by blacksheep.csh.rit.edu (Postfix) with ESMTP id 44E7490A4
	for <mdz@csh.rit.edu>; Sun, 18 Jul 2004 14:32:43 -0400 (EDT)
Received: from mcg.mcgroarty.net (vs1.mcgroarty.net [69.44.158.141])
	by laphroaig.gandi.net (Postfix) with ESMTP id 45F77138184
	for <mdz@alcor.net>; Sun, 18 Jul 2004 20:32:42 +0200 (CEST)
Received: from brian by mcg.mcgroarty.net with local (Exim 4.32)
	id 1BmGSq-0000NB-NN; Sun, 18 Jul 2004 13:32:44 -0500
Date: Sun, 18 Jul 2004 13:32:44 -0500
To: mdz@alcor.net, 260111@bugs.debian.org
Subject: Re: Bug#260111: user-mode-linux: upgrade hangs at "NET4: Linux TCP/IP
	1.0 for NET4.0"
Message-ID: <20040718183244.GA914@mcgroarty.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
X-Debian-GNU-Linux: Rocks
From: Brian McGroarty <brian@mcgroarty.net>
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.92.2



--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> On upgrading user-mode-linux, my guest machines all hang during
> startup, as below.
> [...]
> mconsole (version 2) initialized on /home/brian/.uml/mcg/mconsole
> Partition check:
>  ubda: unknown partition table
>  ubdb: unknown partition table
> Initializing stdio console driver
> NET4: Linux TCP/IP 1.0 for NET4.0
> [hang here]

> This is about the point where the consoles should be initialized.
> You didn't specify a console configuration parameter, so it is
> presumably trying to open terminal emulators.  Any reason why that
> might not work?

I'm not sure if I know enough to answer your question.  I normally
achieve a terminal with the below in inittab. I'm not running X, and
the only user mode linux tool I'm using besides the kernel itself is
the net daemon:

1:2345:respawn:/sbin/getty 38400 /dev/ttys/0


If it's helpful, I rolled back to the user-mode-linux version in
testing, and with that version, this is what follows the NET4 line in
the boot sequence:

IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
[followed by INIT and userland stuff]

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA+sJM2PBacobwYH4RAnYdAJ447noWSGRWdCa5N2ma5Dk8koBvOwCfTHdv
UE7SAgSe+hgh1zAXvisIbDw=
=+oM/
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--

--mxv5cy4qt+RJ9ypb--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
