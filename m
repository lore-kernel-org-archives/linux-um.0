Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Adx4e-00040x-UL for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 11:41:08 -0800
Received: from 62-241-36-148.kunde.vdserver.de ([62.241.36.148] ident=mail)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1Adx4e-0001mX-7K for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 11:41:08 -0800
Mime-Version: 1.0
Message-Id: <a0602040dbc20be564c59@[192.168.1.10]>
In-Reply-To: <a0602040cbc20b788b425@[192.168.1.10]>
References: <Pine.LNX.4.58.0312300027110.24938@silk.corp.fedex.com><200401061718.i 
	06HILtd002620@ccure.user-mode-linux.org><a0602040abc20a9f6862e@[192.16 
	8.1.10]><200401061918.31447.blaisorblade_spam@yahoo.it>     
	<a0602040bbc20b325acfd@[192.168.1.10]>
	<33261.193.212.97.12.1073406789.squirrel@pluto.nixia.no>
	<a0602040cbc20b788b425@[192.168.1.10]>
From: Johannes Formann <johannes@formann.de>
Subject: Re: [uml-devel] Kernel mode fault at addr 0x48965000, ip0x400e51a4
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
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
Date: Tue, 6 Jan 2004 20:40:06 +0100
To: stian@nixia.no
Cc: BlaisorBlade  <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

>ok, then I'll go an compile the uml-kernel new.

so, now I'm done:

I hope this backtrave can helpt you.

Starting program: /opt/uml/kernel/uml-2.4.23-1um 
ubd0=/home/uml0/joscompilerkiste/root_fs mem=128M eth0=tuntap,tap194 
con=pty con0=fd:0,fd:1 umid=joscompilerkiste
Checking for the skas3 patch in the host...found
Checking for /proc/mm...found
Linux version 2.4.23-1um (root@software.vdserver.de) (gcc version 
2.95.4 20011002 (Debian prerelease)) #1 Tue Jan 6 19:13:01 UTC 2004
On node 0 totalpages: 32768
zone(0): 32768 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: ubd0=/home/uml0/joscompilerkiste/root_fs 
mem=128M eth0=tuntap,tap194 con=pty con0=fd:0,fd:1 
umid=joscompilerkiste root=/dev/ubd0
Calibrating delay loop... 3816.93 BogoMIPS
Memory: 126968k available
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
Checking for /dev/anon on the host...Not available (open failed with errno 2)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
pty: 256 Unix98 ptys configured
Initializing software serial port version 1
mconsole (version 2) initialized on 
/home/uml0/joscompilerkiste/.uml/joscompilerkiste/mconsole
Partition check:
  ubda: unknown partition table
Initializing stdio console driver
Netdevice 0 : TUN/TAP backend -
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
INIT: version 2.84 booting
Activating swap.
Adding Swap: 135160k swap-space (priority -1)
Checking root file system...
fsck 1.27 (8-Mar-2002)
/dev/ubd/0 was not cleanly unmounted, check forced.
Entry 'inetd.pid' in /var/run (30722) has deleted/unused inode 30746. 
CLEARED.           
/dev/ubd/0: 53970/2664448 files (3.5% non-contiguous), 2826381/10650001 blocks 
System time was Tue Jan  6 19:38:53 UTC 2004.
Setting the System Clock using the Hardware Clock as reference...
Virtual console 1 assigned device '/dev/ptyp2'
hwclock is unable to get I/O port access:  the iopl(3) call failed.
System Clock set. System local time is now Tue Jan  6 19:38:53 UTC 2004.
Calculating module dependencies... done.
Loading modules: tun Universal TUN/TAP device driver 1.5 (C)1999-2002 
Maxim Krasnyansky

Checking all file systems...
fsck 1.27 (8-Mar-2002)
Setting kernel variables.
Mounting local filesystems...
nothing was mounted
Cleaning: /etc/network/ifstate.
Setting up IP spoofing protection: rp_filter.
Configuring network interfaces: done.

Setting the System Clock using the Hardware Clock as reference...
hwclock is unable to get I/O port access:  the iopl(3) call failed.
System Clock set. Local time: Tue Jan  6 19:38:57 UTC 2004

Cleaning: /tmp /var/lock /var/runfind: ./inetd.pid: Input/output error
.
Initializing random number generator... done.
Recovering nvi editor sessions... done.
INIT: Entering runlevel: 2
Starting system log daemon: syslogd.
Starting kernel log daemon: klogd.

Breakpoint 1, panic (fmt=0x800d17c0 "Kernel mode fault at addr 0x%lx, 
ip 0x%lx") at panic.c:58
58      in panic.c
(gdb) bt
#0  panic (fmt=0x800d17c0 "Kernel mode fault at addr 0x%lx, ip 
0x%lx") at panic.c:58
#1  0x80067b28 in segv (address=142688256, ip=1074631620, is_write=0, 
is_user=0, sc=0x82b90278)
     at trap_kern.c:149
#2  0x80067dfc in segv_handler (sig=11, regs=0x82b90278) at trap_user.c:67
#3  0x80069f8b in sig_handler_common_skas (sig=11, sc_ptr=0x82b937c0) 
at trap_user.c:33
#4  0x80067e21 in sig_handler (sig=11, sc=
       {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 
43, __dsh = 49168, edi = 2189229836, esi = 142688256, ebp = 
2193177244, esp = 2193177236, ebx = 3852, edx = 96, ecx = 24, eax = 
2193177432, trapno = 14, err = 4, eip = 2147918449, cs = 35, __csh = 
0, eflags = 66054, esp_at_signal = 2193177236, ss = 43, __ssh = 0, 
fpstate = 0x0, oldmask = 0, cr2 = 142688256}) at trap_user.c:101
#5  0x400406b8 in sigaction () from /lib/libc.so.6
#6  0x8006a0e4 in do_op (addr=134541068, len=96, is_write=1, 
op=0x8006a25c <copy_chunk_to_user>,
     arg=0x82b93b58) at uaccess.c:46
#7  0x8006a12c in buffer_op (addr=134541068, len=96, is_write=1,
     op=0x8006a25c <copy_chunk_to_user>, arg=0x82b93b58) at uaccess.c:59
#8  0x8006a2f7 in copy_to_user_skas (to=0x804ef0c, from=0x8814000, 
n=96) at uaccess.c:122
#9  0x8006cc8c in read_kmem (file=0x82319ac0, buf=0x804ef0c <Address 
0x804ef0c out of bounds>,
     count=96, ppos=0x82319ae0) at 
/usr/src/uml2.4.23-1/linux-2.4.23/include/asm/um_uaccess.h:37
#10 0x8002be4a in sys_read (fd=2, buf=0x804ef0c <Address 0x804ef0c 
out of bounds>, count=96)
     at read_write.c:177
---Type <return> to continue, or q <return> to quit---
#11 0x80069aaf in execute_syscall_skas (r=0x82b90278) at syscall_kern.c:28
#12 0x80066ae5 in execute_syscall (r=0x82b90278) at syscall_kern.c:315
#13 0x80069aea in handle_syscall (regs=0x82b90278) at syscall_user.c:26
#14 0x80068e97 in handle_trap (pid=17956, regs=0x82b90278) at process.c:85
#15 0x800690ca in userspace (regs=0x82b90278) at process.c:160
#16 0x80069887 in fork_handler (sig=10) at process_kern.c:102
#17 0x400406b8 in sigaction () from /lib/libc.so.6
(gdb)
(gdb) c
Continuing.
Kernel panic: Kernel mode fault at addr 0x8814000, ip 0x400d93c4


Program exited normally.


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
