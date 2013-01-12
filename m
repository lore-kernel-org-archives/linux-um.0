Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dave@bob-the-boat.me.uk>) id 1TtzsJ-0007FN-9R
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Jan 2013 12:07:47 +0000
Received: from i01.ip.uk.com ([86.54.60.3])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ttzs9-000594-7N
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Jan 2013 12:07:47 +0000
From: "Dave Humphreys (Bob)" <dave@bob-the-boat.me.uk>
Message-ID: <1394921.l9eX0xA5nn@vault01>
In-Reply-To: <20130112105812.4eedc505@spider.haslach.nod.at>
References: <50F132F9.1030601@bob-the-boat.me.uk>
	<20130112105812.4eedc505@spider.haslach.nod.at>
MIME-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Date: Sat, 12 Jan 2013 12:07:49 +0000
Subject: Re: [uml-devel] "Couldn't grant pty"
To: Richard Weinberger <richard@sigma-star.at>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Saturday 12 January 2013 10:58:12 Richard Weinberger wrote:
> Am Sat, 12 Jan 2013 09:55:05 +0000
> 
> schrieb "Dave (Bob)" <dave@bob-the-boat.me.uk>:
> > Maybe someone can help me with this...
> > 
> > I have been trying to tie down an issue that I have with "UML Network
> > Related Crashing" so that Richard can reproduce my problem.
> > 
> > I am currently trying to use both a 32 bit UML and a 64 bit UML to run
> > Debian root filesystems, 32 bit and 64 bit respectively.
> > 
> > I am running on a 64 bit machine, with 64 bit kernel incorporating 32
> > bit compatibility.
> > 
> > The 32 bit environment that I am working in for the compilation of 32
> > bit UML kernels and running them is a place to which I bind
> > mount /dev, /sys, /proc to their primary locations; chroot to the top
> > of this structure; execute 'linux32'; and then work as though I was
> > on a 32 bit machine.
> > 
> > When I try to run the 32 bit UML kernel with the 32 bit Debian root
> > filesystem image, it boots to the login prompt, but I can't type
> > anything at the prompt. The UML kernel is displaying messages:
> > 
> > "Couldn't grant pty - errno = -2"
> 
> Please show us the full boot log.
> Maybe something else failed.
> 
> Thanks,
> //richard

Richard,

Boot log below.

'startup' is:

../vmlinux-3.8.0-rc3-um32-def \
root=/dev/ubda \
eth0=tuntap,tap1 \
eth1=mcast \
ubd0=../Debian-Squeeze-x86-root_fs \
ubd1=swap_fs \
mem=512M \
umid=DEB1



-sh-4.2# ./startup 
Locating the bottom of the address space ... 0x0
Locating the top of the address space ... 0xffffd000
Core dump limits :
        soft - 0
        hard - NONE
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...OK
Checking advanced syscall emulation patch for ptrace...OK
Checking for tmpfs mount on /dev/shm...OK
Checking PROT_EXEC mmap in /dev/shm/...OK
Checking for the skas3 patch in the host:
  - /proc/mm...not found: No such file or directory
  - PTRACE_FAULTINFO...not found
  - PTRACE_LDT...not found
UML running in SKAS0 mode
Adding 32870400 bytes to physical memory to account for exec-shield gap
Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Linux version 3.8.0-rc3-um32-def (root@vault01) (gcc version 4.7.2 (GCC) ) #1 
Fri Jan 11 09:13:28 UTC 2013
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 138010
Kernel command line: root=/dev/ubda eth0=tuntap,tap1 eth1=mcast 
ubd0=../Debian-Squeeze-x86-root_fs ubd1=swap_fs mem=512M
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 511712k available
NR_IRQS:15
Calibrating delay loop... 7441.61 BogoMIPS (lpj=37208064)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
Initializing cgroup subsys cpuacct
Initializing cgroup subsys devices
Initializing cgroup subsys freezer
Initializing cgroup subsys blkio
Checking for host processor cmov support...Yes
check_one_sigio failed, errno = 2
check_one_sigio failed, errno = 2
devtmpfs: initialized
Using 2.6 host AIO
NET: Registered protocol family 16
bio: create slab <bio-0> at 0
Switching to clocksource itimer
NET: Registered protocol family 2
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP: reno registered
UDP hash table entries: 512 (order: 1, 8192 bytes)
UDP-Lite hash table entries: 512 (order: 1, 8192 bytes)
NET: Registered protocol family 1
mconsole (version 2) initialized on /home/root/.uml/DEB1/mconsole
Checking host MADV_REMOVE support...OK
Host TLS support detected
Detected host type: x86_64 (GDT indexes 12 to 15)
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
msgmni has been set to 999
io scheduler noop registered
io scheduler deadline registered (default)
TCP: cubic registered
NET: Registered protocol family 17
Initialized stdio console driver
Console initialized on /dev/tty0
console [tty0] enabled
Initializing software serial port version 1
Configured mcast device: 239.192.168.1:1102-1
Choosing a random ethernet address for device eth1
Netdevice 1 (2e:79:6e:ed:c9:79) : 
mcast backend multicast address: 239.192.168.1:1102, TTL:1
console [mc-1] enabled
 ubda: unknown partition table
 ubdb: unknown partition table
Choosing a random ethernet address for device eth0
Netdevice 0 (fa:06:fd:53:63:53) : 
TUN/TAP backend - 
EXT4-fs (ubda): mounting ext3 file system using the ext4 subsystem
EXT4-fs (ubda): mounted filesystem with ordered data mode. Opts: (null)
VFS: Mounted root (ext3 filesystem) readonly on device 98:0.
devtmpfs: mounted
modprobe: FATAL: Could not load /lib/modules/3.8.0-rc3-um32-def/modules.dep: 
No such file or directory

INIT: version 2.88 booting
Using makefile-style concurrent boot in runlevel S.
Starting the hotplug events dispatcher: udevdudev[273]: starting version 164
.
Synthesizing the initial hotplug events...done.
Waiting for /dev to be fully populated...udevd-work[284]: kernel-provided name 
'hw_random' and NAME= 'hwrng' disagree, please use SYMLINK+= or change the 
kernel to provide the proper name

done.
Activating swap...done.
EXT4-fs (ubda): re-mounted. Opts: (null)
Cleaning up ifupdown....
Setting up networking....
Loading kernel modules...done.
Activating lvm and md swap...done.
Checking file systems...fsck from util-linux-ng 2.17.2
done.
Mounting local filesystems...failed.
Activating swapfile swap...done.
Cleaning up temporary files....
Configuring network interfaces...Internet Systems Consortium DHCP Client 
4.1.1-P1
Copyright 2004-2010 Internet Systems Consortium.
All rights reserved.
For info, please visit https://www.isc.org/software/dhcp/

Listening on LPF/eth0/fa:06:fd:53:63:53
Sending on   LPF/eth0/fa:06:fd:53:63:53
Sending on   Socket/fallback
DHCPREQUEST on eth0 to 255.255.255.255 port 67
DHCPNAK from 10.0.1.253
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 6
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 8
DHCPOFFER from 10.0.1.253
DHCPREQUEST on eth0 to 255.255.255.255 port 67
DHCPACK from 10.0.1.253
bound to 10.168.1.45 -- renewal in 109556 seconds.
done.
Cleaning up temporary files....
Setting kernel variables ...done.
INIT: Entering runlevel: 2
Using makefile-style concurrent boot in runlevel 2.
Starting enhanced syslogd: rsyslogd.
Starting periodic command scheduler: cron.
get_pty : Couldn't grant pty - errno = -2
open_pts : Failed to open pts
Registering fd 0 twice
Irqs : 2, 6
Ids : 0x298a3360, 0x298fbde0

Debian GNU/Linux 6.0 DEB1-32 tty0

DEB1-32 login: get_pty : Couldn't grant pty - errno = -2
open_pts : Failed to open pts
get_pty : Couldn't grant pty - errno = -2
open_pts : Failed to open pts
get_pty : Couldn't grant pty - errno = -2
open_pts : Failed to open pts
get_pty : Couldn't grant pty - errno = -2
open_pts : Failed to open pts
get_pty : Couldn't grant pty - errno = -2
open_pts : Failed to open pts
get_pty : Couldn't grant pty - errno = -2
open_pts : Failed to open pts
get_pty : Couldn't grant pty - errno = -2
open_pts : Failed to open pts
get_pty : Couldn't grant pty - errno = -2
open_pts : Failed to open pts
get_pty : Couldn't grant pty - errno = -2
open_pts : Failed to open pts
INIT: Id "s0" respawning too fast: disabled for 5 minutes


------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. SALE $99.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122912
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

