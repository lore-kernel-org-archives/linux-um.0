Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bpie7-00080w-11 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Jul 2004 00:14:39 -0700
Received: from w218.z064002068.nyc-ny.dsl.cnc.net ([64.2.68.218])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1Bpie6-00046M-1j for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Jul 2004 00:14:38 -0700
From: Allen Chan <alydar@users.sourceforge.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407280315.08207.alydar@users.sourceforge.net>
Subject: [uml-devel] Re: Bug#260111: user-mode-linux: upgrade hangs at "NET4:
	Linux TCP/IP 1.0 for NET4.0 "
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
Date: Wed, 28 Jul 2004 03:15:02 -0400
To: user-mode-linux-devel@lists.sourceforge.net
Cc: 260111@bugs.debian.org, jdike@addtoit.com

Attached below are some stack traces for the different "linux" threads 
after the guest kernel hangs.  I tried to follow the instructions and 
examples from the Kernel Debugging section of the User Mode Linux 
HOWTO, but am unsure of how to get the stack trace from the "last 
call to schedule()".

I hope the stack traces I have attached helps.  If not, please point 
me in the right direction to getting the stack trace that you are 
looking for.

Thanks.

> This resembles the GHz bug, except that one is fixed.  If someone
> could get a stack trace from the last call to schedule(), that would
> be a help. 
> There is some sort of a deadlock on a semaphore, and I'd like to
> know which one it is.


---------- start of debug session ------------
(906)% gdb linux
GNU gdb 6.1-debian
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and 
you are
welcome to change it and/or distribute copies of it under certain 
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for 
details.
This GDB was configured as "i386-linux"...Using host libthread_db 
library "/lib/tls/libthread_db.so.1".

(gdb) break schedule
Breakpoint 1 at 0xa0011c43: file sched.c, line 557.
(gdb) handle SIGSEGV pass nostop noprint
Signal        Stop      Print   Pass to program Description
SIGSEGV       No        No      Yes             Segmentation fault
(gdb) handle SIGUSR1 pass nostop noprint
Signal        Stop      Print   Pass to program Description
SIGUSR1       No        No      Yes             User defined signal 1
(gdb) r umid=tinyuml mem=16M ubd0=umlfs eth0=daemon
Starting program: /usr/bin/linux umid=tinyuml mem=16M ubd0=umlfs 
eth0=daemon
Detaching after fork from child process 23295.
Checking for the skas3 patch in the host...found
Checking for /proc/mm...found
Detaching after fork from child process 23296.
Detaching after fork from child process 23297.
Detaching after fork from child process 23298.
Detaching after fork from child process 23299.
Checking for /dev/anon on the host...Not available (open failed with 
errno 2)
Linux version 2.4.26-2um (root@swale) (gcc version 3.3.4 (Debian 
1:3.3.4-4)) #2 Tue Jul 27 13:34:29 EDT 2004
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: mem=16M ubd0=umlfs eth0=daemon root=/dev/ubd0
Calibrating delay loop... 1648.23 BogoMIPS
Memory: 12112k available
Dentry cache hash table entries: 2048 (order: 2, 16384 bytes)
Inode cache hash table entries: 1024 (order: 1, 8192 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...Detaching after 
fork from child process 23300.
OK
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling 
workaround
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
SGI XFS with ACLs, no debug enabled
SGI XFS Quota Management subsystem
Detaching after fork from child process 23301.
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Initializing Cryptographic API
Initializing software serial port version 1
Netdevice 0 : daemon backend (uml_switch version 3) - 
unix:/var/run/uml-utilities/uml_switch.ctl
mconsole (version 2) initialized on /home/alydar/.uml/tinyuml/mconsole
Partition check:
 ubda: unknown partition table
Detaching after fork from child process 23302.
Initializing stdio console driver
Detaching after fork from child process 23303.
                            NET4: Linux TCP/IP 1.0 for NET4.0

Program received signal SIGINT, Interrupt.
0xa02177da in nanosleep () at proc_fs.h:155
155                     res->data=data;
(gdb) bt
#0  0xa02177da in nanosleep () at proc_fs.h:155
#1  0xa0153354 in idle_sleep (secs=-516) at time.c:132
#2  0xa014f091 in cpu_idle () at process_kern.c:212
#3  0xa000f635 in rest_init () at init/main.c:364
#4  0xa00025e6 in start_kernel () at init/main.c:458
#5  0xa015b617 in start_kernel_proc (unused=0x0) at process_kern.c:156
#6  0xa014ead9 in run_kernel_thread (fn=0xa015b5f0 
<start_kernel_proc>, arg=0x0, jmp_ptr=0xfffffdfc) at process.c:227
#7  0xa015b360 in new_thread_handler (sig=10) at process_kern.c:70
#8  <signal handler called>
#9  0xa0219c9d in syscall () at proc_fs.h:155
#10 0xbffff4c8 in ?? ()
#11 0xa020128c in siglongjmp () at proc_fs.h:155
#12 0xa015ae39 in start_idle_thread (stack=0xa02a2000, 
switch_buf_ptr=0xa02a057c, fork_buf_ptr=0x0) at process.c:303
#13 0xa015b678 in start_uml_skas () at process_kern.c:170
#14 0xa0154a3d in linux_main (argc=-1610612736, argv=0xbffff924) at 
um_arch.c:397
#15 0xa000f3ee in main (argc=6, argv=0xbffff924, envp=0xbffff940) at 
arch/um/main.c:148
(gdb) det
Detaching from program: /usr/bin/linux, process 23291
(gdb) att 23296
Attaching to program: /usr/bin/linux, process 23296
ptrace: Operation not permitted.
(gdb) att 23301
Attaching to program: /usr/bin/linux, process 23301
0xa0219c9d in syscall () at proc_fs.h:155
155                     res->data=data;
(gdb) bt
#0  0xa0219c9d in syscall () at proc_fs.h:155
#1  0xa015e945 in io_getevents (ctx_id=4294967292, min_nr=-4, nr=-4, 
events=0xfffffffc, timeout=0xfffffffc) at aio.c:58
#2  0xa015eb09 in aio_thread (arg=0x0) at aio.c:128
#3  0xa0219dda in clone () at proc_fs.h:155
(gdb) det
Detaching from program: /usr/bin/linux, process 23301
(gdb) att 23302
Attaching to program: /usr/bin/linux, process 23302
0xa0218aad in read () at proc_fs.h:155
155                     res->data=data;
(gdb) bt
#0  0xa0218aad in read () at proc_fs.h:155
#1  0xa08d8f84 in ?? ()
#2  0xa015fca4 in file_io (fd=12, buf=0xa08d8f84, len=76, 
io_proc=0xa0218a90 <read>, copy_user_proc=0xa014f440 
<copy_from_user_proc>)
    at file.c:489
#3  0xa015fd41 in os_read_file (fd=-512, buf=0xfffffe00, len=-512) at 
file.c:505
#4  0xa018497a in io_thread (arg=0x0) at ubd_user.c:317
#5  0xa0219dda in clone () at proc_fs.h:155
(gdb) det
Detaching from program: /usr/bin/linux, process 23302
(gdb) att 23303
Attaching to program: /usr/bin/linux, process 23303
0xa0219196 in poll () at proc_fs.h:155
155                     res->data=data;
(gdb) bt
#0  0xa0219196 in poll () at proc_fs.h:155
#1  0xa01500a9 in write_sigio_thread (unused=0x0) at sigio_user.c:190
#2  0xa0219dda in clone () at proc_fs.h:155
(gdb)
---------- end of debug session ------------


---------- ps output for "linux" threads -----------
23290 pts/68   S+     0:01 gdb linux
23291 pts/68   T      0:00 /usr/bin/linux
23296 pts/68   T      0:00 /usr/bin/linux
23301 pts/68   T      0:00 /usr/bin/linux
23302 pts/68   T      0:00 /usr/bin/linux
23303 pts/68   T      0:00 /usr/bin/linux
-------------- end ps output ----------------


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
