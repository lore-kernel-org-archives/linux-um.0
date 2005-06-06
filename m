Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DfQGQ-00079c-Vm	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Jun 2005 15:40:10 -0700
Received: from slartibartfast.pa.net ([66.59.111.182])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DfQGN-0002GV-U0	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Jun 2005 15:40:10 -0700
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
Message-ID: <Pine.LNX.4.62.0506061619590.5392@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [uml-devel] 2.6.12-rc5-mm2-patches20050605 build issues, run issues,
	backtrace
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
Date: Mon, 6 Jun 2005 18:39:21 -0400 (EDT)
To: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@addtoit.com>
Cc: William Stearns <wstearns@pobox.com>

Good afternoon, all,
 	Trying to build 2.6.5-rc5-mm2 on x86_64.  This is with all the 
patches in Jeff's quilt tarball from 20050605:

fs/externfs/externfs.c:20:23: 2_5compat.h: No such file or directory
make[2]: *** [fs/externfs/externfs.o] Error 1
make[1]: *** [fs/externfs] Error 2
make: *** [fs] Error 2

 	OK, so turn off eternfs and we skip that error.  By touching the 
file arch/um/sys-x86_64/.stub_segv.o.d we deftly sneak by the missing file 
error (but Jeff knows about this and is working on a more elegant fix). 
When running it, I get this far:

[wstearns@ford linux-2.6.12-rc5-mm2-patches20050606]$ ./linux
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...missing
Checking if syscall restart handling in host can be skipped...OK
Checking for the skas3 patch in the host:
   - /proc/mm...not found
   - PTRACE_FAULTINFO...not found
   - PTRACE_LDT...not found
Checking PROT_EXEC mmap in /tmp...OK

 	Jeff had mentioned that leaving TT mode on would cause this hang, 
so I config'ed it off, made clean, and rebuilt; it hangs in the same 
place.  Here's my best attempt at a backtrace

[wstearns@ford linux-2.6.12-rc5-mm2-patches20050606]$ gdb ./linux
GNU gdb Red Hat Linux (6.0post-0.20040223.19rh)
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you 
are welcome to change it and/or distribute copies of it under certain 
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "x86_64-redhat-linux-gnu"...Using host 
libthread_db library "/lib64/tls/libthread_db.so.1".

(gdb) r
Starting program: /usr/src/linux-2.6.12-rc5-mm2-patches20050606/linux
Detaching after fork from child process 31015.
Checking that ptrace can change system call numbers...OK
Detaching after fork from child process 31016.
Checking syscall emulation patch for ptrace...missing
Detaching after fork from child process 31017.
Checking if syscall restart handling in host can be skipped...OK
Checking for the skas3 patch in the host:
   - /proc/mm...not found
Detaching after fork from child process 31018.
   - PTRACE_FAULTINFO...not found
Detaching after fork from child process 31019.
   - PTRACE_LDT...not found
Checking PROT_EXEC mmap in /tmp...OK

Program received signal SIGUSR1, User defined signal 1.
0x00000000603140a9 in kill () at thread_info.h:47
47      {
(gdb) bt
#0  0x00000000603140a9 in kill () at thread_info.h:47
#1  0x000000006002b4be in os_usr1_process (pid=31012) at 
arch/um/os-Linux/process.c:118
#2  0x000000006001cdf5 in new_thread_proc (stack=0x7924, handler=0xa) at 
arch/um/kernel/skas/process_kern.c:81
#3  0x0000000060030a0f in start_idle_thread (stack=0x6045c000, 
switch_buf_ptr=0xa, fork_buf_ptr=0x60461de0)
     at arch/um/os-Linux/skas/process.c:489
#4  0x000000006001d0fd in start_uml_skas () at 
arch/um/kernel/skas/process_kern.c:182
#5  0x000000006001c642 in linux_main (argc=1, argv=0x7fbffff928) at 
arch/um/kernel/um_arch.c:431
#6  0x000000006002adba in main (argc=1, argv=0x7fbffff928, 
envp=0x7fbffff938) at arch/um/os-Linux/main.c:154
(gdb)


 	Cheers,
 	- Bill

---------------------------------------------------------------------------
/*
  * Leonard, I'll tie you, draw around you a pentagram
  * and read this file. Aloud.
  */
 	- from kernel 2.3.40-pre6's drivers/block/DAC960.c
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
