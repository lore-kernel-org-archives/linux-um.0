Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Adz37-00030p-EV for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 13:47:41 -0800
Received: from 62-241-36-148.kunde.vdserver.de ([62.241.36.148] ident=mail)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1Adz36-0003Xc-Pw for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 13:47:40 -0800
Mime-Version: 1.0
Message-Id: <a0602040fbc20d995ae8b@[192.168.1.10]>
In-Reply-To: <Pine.LNX.4.58.0401070444370.1840@boston.corp.fedex.com>
References: <Pine.LNX.4.58.0312300027110.24938@silk.corp.fedex.com><200401061718.i 
	06HILtd002620@ccure.user-mode-linux.org><a0602040abc20a9f6862e@[192.16 
	8.1.10]><200401061918.31447.blaisorblade_spam@yahoo.it>     
	<a0602040bbc20b325acfd@[192.168.1.10]>
	<33261.193.212.97.12.1073406789.squirrel@pluto.nixia.no>
	<a0602040cbc20b788b425@[192.168.1.10]>
	<a0602040dbc20be564c59@[192.168.1.10]>
	<Pine.LNX.4.58.0401070325360.1840@boston.corp.fedex.com>
	<a0602040ebc20d1fee774@[192.168.1.10]>
	<Pine.LNX.4.58.0401070444370.1840@boston.corp.fedex.com>
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
Date: Tue, 6 Jan 2004 22:47:35 +0100
To: Jeff Chua <jchua@fedex.com>
Cc: UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>

At 4:47 Uhr +0800 07.01.2004, Jeff Chua wrote:
>untar linux-2.4.24.tar.bz2
>cd uml
>bzip2 -d -c /tar/uml/uml-patch-2.4.23-1.bz2 | patch -p1
>patch -p1 </tar/uml/uml-patch-2.4.23-3 (my patch)

at ../../sourcen/uml-patc_chua | patch -p1
patching file drivers/char/mem.c
Hunk #1 succeeded at 272 (offset 3 lines).

where does that offset come from?


hust to be shure, your patch ist:

--- uml/drivers/char/mem.c.org	Wed Jan  7 03:30:40 2004
+++ uml/drivers/char/mem.c	Wed Jan  7 03:31:47 2004
@@ -269,3 +269,3 @@
  	}
-	*ppos = __pa((void *) p);
+	*ppos = p;
  	return virtr + read;

or the other longer one?

>make mrproper ARCH=um
>make menuconfig ARCH=um
>make depend ARCH=um
>make clean ARCH=um
>make linux ARCH=um
>make modules ARCH=um

Kernel panic: Kernel mode fault at addr 0x8814000, ip 0x400d93c4

and the gd-output:

Starting kernel log daemon: klogd
Breakpoint 1, panic (fmt=0x800d16a0 "Kernel mode fault at addr 0x%lx, 
ip 0x%lx") at panic.c:58
58      panic.c: No such file or directory.
         in panic.c
(gdb) bt
#0  panic (fmt=0x800d16a0 "Kernel mode fault at addr 0x%lx, ip 
0x%lx") at panic.c:58
#1  0x80067af8 in segv (address=142688256, ip=1074631620, is_write=0, 
is_user=0, sc=0x87aa8278)
     at trap_kern.c:149
#2  0x80067dcc in segv_handler (sig=11, regs=0x87aa8278) at trap_user.c:67
#3  0x80069f5b in sig_handler_common_skas (sig=11, sc_ptr=0x87aab7c0) 
at trap_user.c:33
#4  0x80067df1 in sig_handler (sig=11, sc=
       {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 
43, __dsh = 0, edi = 2182041356, esi = 142688256, ebp = 2276113052, 
esp = 2276113044, ebx = 3852, edx = 96, ecx = 24, eax = 2276113240, 
trapno = 14, err = 4, eip = 2147918401, cs = 35, __csh = 0, eflags = 
66054, esp_at_signal = 2276113044, ss = 43, __ssh = 0, fpstate = 0x0, 
oldmask = 0, cr2 = 142688256}) at trap_user.c:101
#5  0x400406b8 in sigaction () from /lib/libc.so.6
#6  0x8006a0b4 in do_op (addr=134541068, len=96, is_write=1, 
op=0x8006a22c <copy_chunk_to_user>,
     arg=0x87aabb58) at uaccess.c:46
#7  0x8006a0fc in buffer_op (addr=134541068, len=96, is_write=1, 
op=0x8006a22c <copy_chunk_to_user>,
     arg=0x87aabb58) at uaccess.c:59
#8  0x8006a2c7 in copy_to_user_skas (to=0x804ef0c, from=0x8814000, 
n=96) at uaccess.c:122
#9  0x8006cc5c in read_kmem (file=0x84174ac0, buf=0x804ef0c <Address 
0x804ef0c out of bounds>,
     count=96, ppos=0x84174ae0) at 
/usr/src/uml2.4.23-1/linux-2.4.23/arch/um/include/um_uaccess.h:37
#10 0x8002be4a in sys_read (fd=2, buf=0x804ef0c <Address 0x804ef0c 
out of bounds>, count=96)
     at read_write.c:177
#11 0x80069a7f in execute_syscall_skas (r=0x87aa8278) at syscall_kern.c:28
#12 0x80066ae5 in execute_syscall (r=0x87aa8278) at syscall_kern.c:315
#13 0x80069aba in handle_syscall (regs=0x87aa8278) at syscall_user.c:26
#14 0x80068e67 in handle_trap (pid=20155, regs=0x87aa8278) at process.c:85
#15 0x8006909a in userspace (regs=0x87aa8278) at process.c:160
#16 0x80069857 in fork_handler (sig=10) at process_kern.c:102
#17 0x400406b8 in sigaction () from /lib/libc.so.6
#18 0x800697aa in new_thread_proc (stack=0x2, handler=0) at process_kern.c:79
#19 0x00000000 in ?? ()
(gdb) c
Continuing.
Kernel panic: Kernel mode fault at addr 0x8814000, ip 0x400d93c4
.


Program exited normally.

HTH

Johannes


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
