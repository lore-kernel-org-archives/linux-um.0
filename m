Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B3Bxa-0002JC-P4 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Mar 2004 02:38:10 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B3BxX-000307-HD for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Mar 2004 02:38:07 -0800
Received: from localhost (henrik@localhost)
	by filer.marasystems.com (8.11.6/8.11.6) with ESMTP id i2GAc4Y24392
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 16 Mar 2004 11:38:05 +0100
From: Henrik Nordstrom <hno@marasystems.com>
Message-ID: <Pine.LNX.4.44.0403161053200.23697-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] /dev/kmem panic in SKAS mode
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
Date: Tue, 16 Mar 2004 11:38:04 +0100 (CET)
To: user-mode-linux-devel@lists.sourceforge.net

There seems to be some kind of vm addressing related issue in SKAS mode.  
This time related to reading of /dev/kmem.

The following kernel panic is seen when klogd starts up:

#0  panic (fmt=0xa014ce00 "Kernel mode fault at addr 0x%lx, ip 0x%lx") at 
panic.c:60
#1  0xa006fab6 in segv (address=1116127232, ip=1074706056, is_write=0, 
is_user=0, sc=0xa13c8274) at trap_kern.c:149
#2  0xa006feaa in segv_handler (sig=11, regs=0xa13c8274) at trap_user.c:67
#3  0xa007615d in sig_handler_common_skas (sig=11, sc_ptr=0x58) at 
trap_user.c:35
#4  0xa006ff99 in sig_handler (sig=0, sc= {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 123, __esh = 0, ds = 123, __dsh = 0, edi = 2705474036, esi = 1116127232, ebp = 2705111756, esp = 2705111748, ebx = 2685835552, edx = 2705111928, ecx = 15, eax = 60, trapno = 14, err = 4, eip = 2684838993, cs = 115, __csh = 0, eflags = 
66054, esp_at_signal = 2705111748, ss = 123, __ssh = 0, fpstate = 0x0, oldmask = 0, cr2 = 1116127232}) at trap_user.c:103
#5  <signal handler called>
#6  0xa0076451 in copy_chunk_to_user (to=2705474036, len=60, arg=0xa13cbb78) at string.h:202
#7  0xa00762ca in do_op (addr=2705474036, len=60, is_write=1, op=0xa007643c <copy_chunk_to_user>, arg=0xa13cbb78) at uaccess.c:46
#8  0xa007630d in buffer_op (addr=134541812, len=-1589855368, is_write=1, op=0xa007643c <copy_chunk_to_user>, arg=0xa13cbb78) at uaccess.c:59
#9  0xa00764b8 in copy_to_user_skas (to=0x804f1f4, from=0x4286c000, n=-1589855368) at uaccess.c:122
#10 0xa0079851 in read_kmem (file=0xa13ae1e4, buf=0x804f1f4 <Address 0x804f1f4 out of bounds>, count=60, ppos=0xa13ae204) at mem.c:264
#11 0xa0032d41 in sys_read (fd=60, buf=0x804f1f4 <Address 0x804f1f4 out of bounds>, count=60) at read_write.c:177
#12 0xa0075c63 in execute_syscall_skas (r=0xa13cbc3c) at syscall_kern.c:28
#13 0xa0075cd8 in handle_syscall (regs=0xa13c8274) at syscall_user.c:26
#14 0xa0074e84 in handle_trap (pid=8470, regs=0xa13c8274) at process.c:85
#15 0xa0075140 in userspace (regs=0xa13c8274) at process.c:160
#16 0xa00758fa in fork_handler (sig=10) at process_kern.c:102
#17 <signal handler called>
#18 0xa00ff3ed in syscall () at string.h:486
Previous frame inner to this frame (corrupt stack?)

(gdb) frame 1
(gdb) p/x address
$2 = 0x4286c000

(gdb) frame 10
(gdb) p/x *ppos
$3 = 0xa286c000


In TT mode on the same host this problem is not seen.

Host OS: Fedora Core 2 test 1
Host kernel: Fedora kernel-2.6.3-1.118 + host-skas3-2.6.3-v1.patch


Regards
Henrik



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
