Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AKggJ-0007BJ-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 14 Nov 2003 08:20:23 -0800
Received: from blacksheep.csh.rit.edu ([129.21.60.6])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AKggI-0006ht-Vg
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 14 Nov 2003 08:20:23 -0800
From: Matt Zimmerman <mdz@debian.org>
Message-ID: <20031114162017.GH9377@dijkstra.csh.rit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [dan@spaz.org: Bug#220680: user-mode-linux: Carrier not detected on serial port]
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
Date: Fri, 14 Nov 2003 11:20:17 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: 220680-forwarded@bugs.debian.org

----- Forwarded message from Daniel Burton <dan@spaz.org> -----

Date: Thu, 13 Nov 2003 19:34:59 -0800
From: Daniel Burton <dan@spaz.org>
Resent-From: Daniel Burton <dan@spaz.org>
To: Debian Bug Tracking System <submit@bugs.debian.org>
Subject: Bug#220680: user-mode-linux: Carrier not detected on serial port

Package: user-mode-linux
Version: 2.4.22-5um-1
Severity: normal


I am trying to run wvdial inside a User-Mode Linux with a serial port 
from the real computer mapped to one on the virtual machine.  The 
problem is that the carrier detect is not functioning properly.  Wvdial 
works fine on the real machine, but in the virtual machine, it seems to 
think that the carrier has been dropped as soon as it connects.

Here are wvdial's messages:

vdialup:/home/daniel# wvdial
--> WvDial: Internet dialer version 1.53
--> Initializing modem.
--> Sending: ATZ
ATZ
OK
--> Sending: ATQ0 V1 E1 S0=0 &C1 &D2 +FCLASS=0
ATQ0 V1 E1 S0=0 &C1 &D2 +FCLASS=0
OK
--> Modem initialized.
--> Sending: ATDT859-9607
--> Waiting for carrier.
ATDT859-9607
CONNECT 37333/ARQ/V90/LAPM/V42BIS
--> Carrier detected.  Waiting for prompt.
--> Connected, but carrier signal lost!  Retrying...
--> Sending: ATDT859-9607
--> Waiting for carrier.
UQKT2
dsc01-c7206.oav-ca line 1/3/60
dsc01-c7206.oav-ca
Login:
Login:
Login:
Login:
Login:ATDT859-9607
Password:Caught signal #2!  Attempting to exit gracefully...
 
--> Disconnecting at Thu Nov 13 19:26:10 2003

Here are my User-Mode Linux messages:

Checking for the skas3 patch in the host...not found
Checking for /proc/mm...not found
CONFIG_HIGHMEM not enabled - physical memory shrunk to 486539264 bytes
Kernel virtual memory size shrunk to 25165824 bytes
Linux version 2.4.22-5um (mdz@mizar) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Fri Sep 19 21:36:03 EDT 2003
On node 0 totalpages: 118784
zone(0): 118784 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: eth0=daemon,,,/var/run/uml-utilities/uml_switch.ctl con=pts con0=fd:0,fd:1 ssl0=tty:/dev/ttyS4 mem=512M root=/dev/ubd0
Calibrating delay loop... 461.50 BogoMIPS
Memory: 461376k available
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
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
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Initializing Cryptographic API
Initializing software serial port version 1
Netdevice 0 : daemon backend (uml_switch version 3) - unix:/var/run/uml-utilities/uml_switch.ctl
mconsole (version 2) initialized on /home/daniel/.uml/LpOQpJ/mconsole
Partition check:
 ubda: unknown partition table
Initializing stdio console driver
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
cramfs: wrong magic
reiserfs: found format "3.6" with standard journal
reiserfs: checking transaction log (device ubd(98,0)) ...
for (ubd(98,0))
ubd(98,0):Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.

INIT: version 2.84 booting

Activating swap.
System time was Fri Nov 14 03:33:38 UTC 2003.
Setting the System Clock using the Hardware Clock as reference...
Virtual console 1 assigned device '/dev/pts/0'
hwclock is unable to get I/O port access:  the iopl(3) call failed.
System Clock set. System local time is now Fri Nov 14 03:33:38 UTC 2003.
Calculating module dependencies... depmod: *** Unresolved symbols in /lib/modules/2.4.22-5um/kernel/arch/um/drivers/hostaudio.o
depmod: *** Unresolved symbols in /lib/modules/2.4.22-5um/kernel/drivers/scsi/scsi_mod.o
depmod: *** Unresolved symbols in /lib/modules/2.4.22-5um/kernel/drivers/scsi/sr_mod.o
done.
Loading modules: ppp_async CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
ppp_synctty ppp_deflate PPP Deflate Compression module registered

Checking all file systems...
fsck 1.27 (8-Mar-2002)
Setting kernel variables.
Loading the saved-state of the serial devices... 
Mounting local filesystems...
none on /home type hostfs (rw,/home)
none on /host type hostfs (rw,/)
Running 0dns-down to make sure resolv.conf is ok...done.
Cleaning: /etc/network/ifstate.
Setting up IP spoofing protection: rp_filter.
Configuring network interfaces: dev_ip_addr - device not assigned an IP address
done.
Starting portmap daemon: portmap.

Setting the System Clock using the Hardware Clock as reference...
hwclock is unable to get I/O port access:  the iopl(3) call failed.
System Clock set. Local time: Thu Nov 13 19:33:57 PST 2003

Cleaning: /tmp /var/lock /var/run.
Initializing random number generator... done.
Recovering nvi editor sessions... done.

INIT: Entering runlevel: 2

Starting system log daemon: syslogd.
Starting kernel log daemon: klogd.
Starting NFS common utilities: statd.
Starting diald: fifo-created diald.
Starting internet superserver: inetd.
Starting printer spooler: lpd.
Not starting NFS kernel daemon: No exports.
Starting OpenBSD Secure Shell server: sshd.
Starting HTTP cache proxy server: WWWOFFLE Now In Autodial Mode
Starting anac(h)ronistic cron: anacron.
Starting deferred execution scheduler: atd.
Starting periodic command scheduler: cron.
Virtual console 2 assigned device '/dev/pts/2'
Virtual console 4 assigned device '/dev/pts/3'
Virtual console 3 assigned device '/dev/pts/4'
Virtual console 5 assigned device '/dev/pts/5'
Virtual console 6 assigned device '/dev/pts/6'


-- System Information:
Debian Release: testing/unstable
Architecture: i386
Kernel: Linux frankenstein 2.4.22-1-686 #6 Sat Oct 4 14:09:08 EST 2003 i686
Locale: LANG=C, LC_CTYPE=C

Versions of packages user-mode-linux depends on:
ii  uml-utilities                 20030903-6 User-mode Linux (utility programs)

-- no debconf information

----- End forwarded message -----

-- 
 - mdz


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
