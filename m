Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <EAC7622167479948B614F8B9AD41C505ECA54F@MAANDMBX2.ets.enterasys.com>
From: "Tsillas, Demetrios J" <jtsillas@enterasys.com>
Subject: [uml-devel] RE: [uml-user] Kernel panic: Segfault with no mm &&
	CONFIG_DEBUG_SLAB
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
Date: Wed, 22 Sep 2004 15:10:48 -0400
Content-Transfer-Encoding: 8bit
To: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-user@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

I have a core image now that I can browse. There's something
very odd about the stack after the sig_handler.

(gdb) p nsegfaults
$20 = 5

(gdb) p/x segfault_record[4]
$24 = {address = 0x28828000, is_write = 0x2, pid = 0x11db, sp =
0x40001fb4, is_user = 0x0}
(gdb) p/x segfault_record[3]
$25 = {address = 0x28000000, is_write = 0x0, pid = 0x11db, sp =
0x40001fb4, is_user = 0x0}

Note the segfault_record we are dealing with is the one with address
0x28828000

But now, look at the call stack:

(gdb) down
#6  0x080d9bf9 in segv (address=671088640, ip=135618305, is_write=0,
is_user=0, sc=0x9310270) at trap_kern.c:149
(gdb) p/x 671088640
$26 = 0x28000000

Address is wrong and is_write should be 0x2. It looks like the call
stack
from the _previous_ segfault_record.

Some other interesting stuff:

p/x regs->skas
$11 = {regs = {0x11df, 0x13, 0x11df, 0x0, 0x0, 0x40001fd0, 0x0, 0x2b,
0x2b, 0x0, 0x0, 0x25, 0x8155f01, 0x23, 0x206, 0x40001fb4, 0x2b}, fp =
{0x0 <repeats 27 times>}, xfp = {0x37f, 0x0, 0x0, 0x0, 0x0, 0x0, 0x1f80,
0xffff, 0x0 <repeats 120 times>}, fault_addr = 0x28828000, fault_type =
0x6, trap_type = 0xe, syscall = 0x0, is_user = 0x0}

(gdb) p/x start_vm
$12 = 0x28800000

(gdb) p/x end_vm
$13 = 0x48800000

#7  0x080d9f3d in segv_handler (sig=11, regs=0x9310270) at
trap_user.c:74
(gdb) p/x segfault_record[0].address
$14 = 0x28800070
(gdb) p/x segfault_record[1].address
$15 = 0x2880d070
(gdb) p/x segfault_record[2].address
$16 = 0x28820000
(gdb) p/x segfault_record[3].address
$17 = 0x28000000
(gdb) p/x segfault_record[4].address
$18 = 0x28828000
(gdb) p/x segfault_record[5].address
$19 = 0x0
(gdb)

-----Original Message-----
From: BlaisorBlade [mailto:blaisorblade_spam@yahoo.it] 
Sent: Tuesday, September 21, 2004 2:45 PM
To: user-mode-linux-user@lists.sourceforge.net
Cc: Tsillas, Demetrios J; Jeff Dike;
user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-user] Kernel panic: Segfault with no mm &&
CONFIG_DEBUG_SLAB

On Sunday 19 September 2004 15:03, Tsillas, Demetrios J wrote:

OK, let's start analyzing it. I have some ideas, but that's just a guess
about 
it.

Here there is segv handling stack, nothing new:

> #0  0x08157021 in kill ()
...
> #9  0x080d9f5e in sig_handler (sig=11, sc={gs = 0, __gsh = 0, fs = 0,
> __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 671043576,
esi
> = 671088637, ebp = 154237660, esp = 154237636, ebx = 671039488, edx =
> 4096, ecx = 2, eax = 154206208, trapno = 14, err = 4, eip = 135120628,
> cs = 35, __csh = 0, eflags = 66054, esp_at_signal = 154237636, ss =
43,
> __ssh = 0, fpstate = 0x0, oldmask = 134217728, cr2 = 671088640}) at
> trap_user.c:109

> #10 <signal handler called>
Here we have the problem:

> #11 0x080dc6f4 in copy_from_user_skas (to=0x27fff005, from=0x27fffffd,
> n=136244252) at string.h:202
Here we do copy_from_user_skas, and we should be with get_fs() ==
KERNEL_DS;  
maybe we are not with that set (although for the init task this should
be 
granted, see include/asm-um/thread_info.h: INIT_THREAD_INFO).

> #12 0x0808a50c in copy_mount_options (data=0x27fff005,
where=0x9317b30)
> at um_uaccess.h:31
This is actually inside fs/namespace.c, but executing UML code.

> #13 0x0808aa18 in sys_mount (dev_name=0x81ad3f8 "/dev/root",
> dir_name=0x81ad3fc "/root", type=0x27fff005 "ext2", flags=32769,
> data=0x0) at namespace.c:838

As you see below, we are called from kernel-space code. And with SKAS
one more 
copy_from_user hurts a lot, if get_fs() has not the right ! I guess that

get_fs() != KERNEL_DS, i.e. it is not set correctly.

> #14 0x08049878 in mount_block_root (name=0x81ad3f8 "/dev/root",
> flags=32769) at init/do_mounts.c:371
> #15 0x08049cbc in mount_root () at init/do_mounts.c:816
> #16 0x08050717 in prepare_namespace () at init/do_mounts.c:944
> #17 0x080504e1 in init (unused=0x0) at init/main.c:562
> #18 0x080d6239 in run_kernel_thread (fn=0x80504d0 <init>, arg=0x0,
> jmp_ptr=0x81eec1c) at process.c:231
> #19 0x080dba06 in new_thread_handler (sig=10) at process_kern.c:72

We are called by rest_init(), by way of kernel_thread.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
