Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B74nw-0006mI-SC for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Mar 2004 19:48:16 -0800
Received: from hoth.xs4all.nl ([213.84.241.98] helo=seven.hoth.xs4all.nl)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B74nu-0008D6-HB for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Mar 2004 19:48:14 -0800
From: Mark Hurenkamp <mark.hurenkamp@xs4all.nl>
Subject: Re: [uml-devel] Kernel panic on UML linux
References: <200403200047.29359.mark.hurenkamp@xs4all.nl>
	<200403210034.27325.mark.hurenkamp@xs4all.nl>
	<200403222115.i2MLF9VB021469@ccure.user-mode-linux.org>
In-Reply-To: <200403222115.i2MLF9VB021469@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403270448.04891.mark.hurenkamp@xs4all.nl>
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
Date: Sat, 27 Mar 2004 04:48:04 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Monday 22 March 2004 22:15, you wrote:
> You've read the docs on debugging UML?

Aiai, I feel so emberassed now...

I went and read some more on the UML site, and found
some hints that helped me get the UML running within GDB
However, for some reason GDB reports 'Program exited normally',
eventhough there is a kernel panic.
Could that be due to disabling the SIGSEGV handler?
(according to the debugging manual I need to disable this
handler...)
I am not able to backtrace now, gdb reports 'no stack'...

I also tried a different client setup, strangely enough, it also
crashes after enabling the firewall (this case, mandrake 8.2
system with Bastille firewall), but the addresses mentioned
are different (Kernel panic: Kernel mode fault at addr 0x48b16000, 
ip 0x400fc344).
Without the firewall enabled, both systems work flawlessly.
The Suse system even works, when it is booted without the
firewall, and the firewall is then enabled via Yast after boot. 
However a reboot will result again in this problem.


Here's the output of my debug session:

root@nine # gdb ./linux
GNU gdb 6.0
Copyright 2003 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i686-pc-linux-gnu"...Using host libthread_db 
library "/lib/libthread_db.so.1".

(gdb) handle SIGSEGV pass nostop noprint
Signal        Stop      Print   Pass to program Description
SIGSEGV       No        No      Yes             Segmentation fault
(gdb) handle SIGUSR1 pass nostop noprint
Signal        Stop      Print   Pass to program Description
SIGUSR1       No        No      Yes             User defined signal 1
(gdb) r ubd0=root.cow,root.img ubd1=swap.cow,swap.img mem=128M con0=fd:0,fd:1 
con1=tty:/dev/tty9 con=null eth0=tuntap,tap_rt0,, eth1=tuntap,tap_rt1,, 
eth2=tuntap,tap_rt2,,
Starting program: /usr/src/uml/linux-2.4.24/linux ubd0=root.cow,root.img 
ubd1=swap.cow,swap.img mem=128M con0=fd:0,fd:1 con1=tty:/dev/tty9 con=null 
eth0=tuntap,tap_rt0,, eth1=tuntap,tap_rt1,, eth2=tuntap,tap_rt2,,
Detaching after fork from child process 13820.
Checking for the skas3 patch in the host...found
Checking for /proc/mm...found
Detaching after fork from child process 13822.
Detaching after fork from child process 13823.
Detaching after fork from child process 13824.
Detaching after fork from child process 13825.
Checking for /dev/anon on the host...Not available (open failed with errno 2)
Linux version 2.4.24stock-1um (root@nine) (gcc version 3.3.2 20031218 (Gentoo 
Linux 3.3.2-r5, propolice-3.3-7)) #1 Sat Mar 20 02:02:53 CET 2004
On node 0 totalpages: 32768
zone(0): 32768 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: ubd0=root.cow,root.img ubd1=swap.cow,swap.img mem=128M 
con0=fd:0,fd:1 con1=tty:/dev/tty9 con=null eth0=tuntap,tap_rt0,, 
eth1=tuntap,tap_rt1,, eth2=tuntap,tap_rt2,, root=/dev/ubd0
Calibrating delay loop... 1143.60 BogoMIPS
Memory: 125180k available
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...Detaching after fork 
from child process 13826.
OK
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
udf: registering filesystem
pty: 256 Unix98 ptys configured
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
Initializing software serial port version 1
mconsole (version 2) initialized on /root/.uml/jX9R1I/mconsole
Partition check:
 ubda: unknown partition table
 ubdb: unknown partition table
Detaching after fork from child process 13827.
UML Audio Relay (host dsp = /dev/sound/dsp, host mixer = /dev/sound/mixer)
Initializing stdio console driver
Detaching after fork from child process 13828.
                                              Netdevice 0 : TUN/TAP backend -
Netdevice 1 : TUN/TAP backend -
Netdevice 2 : TUN/TAP backend -
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
UDF-fs: No partition found (1)
reiserfs: found format "3.6" with standard journal
reiserfs: checking transaction log (device ubd(98,0)) ...
for (ubd(98,0))
reiserfs: replayed 7 transactions in 1 seconds
ubd(98,0):Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
INIT: version 2.82 booting
System Boot Control: Running /etc/init.d/boot
Mounting /proc filesystem                                                                              
done
Mounting /dev/pts                                                                                      
done
modprobe: modprobe: Can't locate module block-major-9
showconsole: Warning: the ioctl TIOCGDEV is not known by the kernel
Activating swap-devices in /etc/fstab...
Adding Swap: 262136k swap-space (priority 42)                                                          
done
showconsole: Warning: the ioctl TIOCGDEV is not known by the kernel
Checking file systems...
fsck 1.34 (25-Jul-2003)
Reiserfs super block in block 16 on 0x6200 of format 3.6 with standard journal
Blocks (total/free): 131072/43612 by 4096 bytes
Filesystem is NOT clean
Filesystem seems mounted read-only. Skipping journal replay.
Checking internal tree..finished                                                                       
done
Mounting local file systems...
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,mode=0620,gid=5)
none on /dev/shm type tmpfs (rw)                                                                       
done
Loading required kernel modules                                                                        
done
Activating remaining swap-devices in /etc/fstab...                                                     
done
Mounting shared memory FS on /dev/shm                                                                  
done
Setting up the CMOS clockhwclock is unable to get I/O port access:  the 
iopl(3) call failed.
hwclock is unable to get I/O port access:  the iopl(3) call failed.
                                                                                                       failed
Setting up timezone data                                                                               
done
Setting scheduling timeslices                                                                          
unused
Setting up hostname 'suse9-uml'                                                                        
done
Setting up loopback interface                                                                          
done
Enabling IP forwarding                                                                                 
done
Creating /var/log/boot.msg                                                                             
done
showconsole: Warning: the ioctl TIOCGDEV is not known by the kernel
System Boot Control: The system has been                                                               
setup
Skipped features:                                                                               
boot.sched
System Boot Control: Running /etc/init.d/boot.local                                                    
done
INIT: Entering runlevel: 3
Master Resource Control: previous runlevel: N, switching to runlevel:                                  
3
Initializing random number generator                                                                   
done
Starting Firewall Initialization (phase 1 of 3) modprobe: modprobe: Can't 
locate module net-pf-10
modprobe: modprobe: Can't locate module net-pf-10
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (977 buckets, 7816 max) - 292 bytes per conntrack
                                                                                                       done
Setting up network interfaces:
    lo                                                                                                 
done
    eth0      dev_ip_addr - device not assigned an IP address
IP/Netmask: 213.84.241.98 / 255.255.255.255                                                            
done
    eth1      dev_ip_addr - device not assigned an IP address
IP/Netmask: 192.168.1.1 / 255.255.255.0                                                                
done
    eth2      dev_ip_addr - device not assigned an IP address
IP/Netmask: 192.168.2.1 / 255.255.255.0                                                                
done
Starting syslog servicesmodprobe: modprobe: Can't locate module char-major-4
  syslogd: /dev/tty10: No such device
                                                                                                       done
Starting RPC portmap daemon                                                                            
done
Starting Firewall Initialization (phase 2 of 3) Kernel panic: Kernel mode 
fault at addr 0x489f2000, ip 0x400e9df8


Program exited normally.
(gdb) bt
No stack.
(gdb)


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
