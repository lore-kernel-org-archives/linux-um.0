Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B1VRv-0008E7-ES for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Mar 2004 11:02:31 -0800
Received: from postman2.arcor-online.net ([151.189.0.152]
	helo=postman.arcor.de)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1B1VA8-0002CL-HQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Mar 2004 10:44:08 -0800
Received: from server.schwinge.homeip.net (dialin-212-144-136-061.arcor-ip.net
	[212.144.136.61]) (authenticated bits=0)
	by postman.arcor.de (8.13.0.PreAlpha4/8.13.0.PreAlpha4) with ESMTP id
	i2BIhxkn005919 for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 11 Mar 2004 19:43:59 +0100 (MET)
From: Thomas Schwinge
	<schwinge-lists-sourceforge.net-user-mode-linux-devel@nic-nac-project.de>
Message-ID: <20040311185105.GA22820@speedy.schwinge.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
Subject: [uml-devel] UML crashing
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
Date: Thu, 11 Mar 2004 19:51:05 +0100
To: user-mode-linux-devel@lists.sourceforge.net



--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

Since my current UML (linux-2.6.3 with uml-patch-2.6.3-rc2-1.bz2 and
<URL:http://www.metaparadigm.com/~mclark/uml/uml-2.6.3-skas-1.patch>)
is crashing reproducibly I wanted to provide you with a backtrace but
that won't work.

The host's kernel was build from the same sources; I'be been running UML
in skas mode.

Previously I was running a kernel without debugging symbols etc. - after
anabling these for the guest's kernel (see the attached .config) I got
this while booting:
#v+
kernel/sched.c:1516: spin_lock(kernel/sched.c:a03703c0) already locked by k=
ernel/sched.c/1637
kernel/sched.c:876: spin_unlock(kernel/sched.c:a03703c0) not locked
[...]
kernel/sched.c:1516: spin_lock(kernel/sched.c:a03703c0) already locked by k=
ernel/sched.c/1637
kernel/sched.c:876: spin_unlock(kernel/sched.c:a03703c0) not locked
[...]
kernel/sched.c:291: spin_lock(kernel/sched.c:a03703c0) already locked by ke=
rnel/sched.c/1637
#v-

([...] was the boot scripts' output.)

When e.g. trying to compile a certain software package UML crashes:
#v+
Kernel panic: kernel BUG at kernel/exit.c:793!

 <6>SysRq : Show Regs

EIP: 0073:[<400a0137>] CPU: 0 Not tainted ESP: 007b:bffff4d0 EFLAGS: 000002=
46
    Not tainted
EAX: ffffffda EBX: 00000000 ECX: 00000000 EDX: 00000000
ESI: 4010aaac EDI: 00000000 EBP: bffff4e4 DS: 007b ES: 007b
Call Trace: [<a003a2d3>] [<a01283c7>] [<a01283af>] [<a0128348>] [<a0128334>=
]=20
   [<a001de62>] [<a003a2c1>] [<a003a2d3>] [<a004d0ca>] [<a0115e57>] [<a003a=
2d3>]=20
   [<a0039318>] [<a0039304>] [<a00392fa>] [<a003d202>] [<a003ce64>] [<a001c=
c43>]=20
   [<a00174d1>] [<a001cfac>] [<a003d45e>] [<a001d055>] [<a001d136>] [<a003d=
476>]=20
   [<a0023b25>] [<a001bc93>] [<a001be5b>] [<a0023b6c>] [<a0023b63>] [<a0022=
e14>]=20
   [<a002304a>] [<a0031f4f>] [<a001b124>] [<a002386a>] [<a0023852>] [<a01ca=
d68>]=20
   [<a0031f4f>] [<a01cbe7d>]=20
#v-

I tried to rerun UML using gdb:
#v+
GNU gdb 6.0
Copyright 2003 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain condition=
s.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
---Type <return> to continue, or q <return> to quit---
This GDB was configured as "i686-pc-linux-gnu"...
(gdb) handle SIGSEGV pass nostop noprint
Signal        Stop      Print   Pass to program Description
SIGSEGV       No        No      Yes             Segmentation fault
(gdb) handle SIGUSR1 pass nostop noprint
Signal        Stop      Print   Pass to program Description
SIGUSR1       No        No      Yes             User defined signal 1
(gdb) break panic
Breakpoint 1 at 0xa003927b: file kernel/panic.c, line 59.
(gdb) break exit
Breakpoint 2 at 0xa01c3b64
(gdb) r
Starting program: /fs/hda2/mount/home/thomas/command/linux-debug mem=3D64M =
con=3Dxterm init=3D/command/runit ubd0=3D/dev/mapper/VGhda-uml ubd1=3D/dev/=
mapper/VGhda-uml_LVM eth0=3Dtuntap,tun1,fe:fd:0:0:0:2 ip=3Ddhcp umid=3Duml
#v-

After some time of compiling I got the following and the kernel froze:
#v+
Kernel panic: Kernel mode fault at addr 0x94, ip 0x401070a5
Kernel panic: Kernel mode fault at addr 0x0, ip 0x40106b8f
Kernel panic: Kernel mode fault at addr 0x0, ip 0x40106b8f
Kernel panic: Kernel mode fault at addr 0x0, ip 0x40106b8f
Kernel panic: Kernel mode fault at addr 0x0, ip 0x40106b8f
Kernel panic: Kernel mode fault at addr 0x0, ip 0x40106b8f
Kernel panic: Kernel mode fault at addr 0x0, ip 0x40106b8f
Kernel panic: Kernel mode fault at addr 0x0, ip 0x40106b8f
Kernel panic: Kernel mode fault at addr 0x0, ip 0x40106b8f
Kernel panic: Kernel mode fault at addr 0x0, ip 0x40106b8f
In idle task - not syncing
#v-

I was not able to 'STRG-C' gdb and get a backtrace - it was also frozen.

After killing the UML processes I was able to get get the following in gdb:
#v+
Program received signal SIGTERM, Terminated.
---Type <return> to continue, or q <return> to quit---
0xa01cb032 in sigprocmask ()
(gdb) Quit
(gdb) bt
#0  0xa01cb032 in sigprocmask ()
#1  0xa001b05f in change_sig (signal=3D10, on=3D1) at arch/um/kernel/signal=
_user.c:56
#2  0xa0024024 in sig_handler_common_skas (sig=3D11, sc_ptr=3D<incomplete t=
ype>) at arch/um/kernel/skas/trap_user.c:29
#3  0xa001d7be in sig_handler (sig=3D11, sc=3D<incomplete type>) at arch/um=
/kernel/trap_user.c:101
#4  <signal handler called>
#5  free_block (cachep=3D0xa3ff8d80, objpp=3D0xa3fde2f8, nr_objects=3D16) a=
t include/linux/list.h:135
---Type <return> to continue, or q <return> to quit---
#6  0xa0064e97 in cache_flusharray (cachep=3D0xa3ff8d80, ac=3D0xa3fde2e8) a=
t mm/slab.c:2010
#7  0xa0065623 in kmem_cache_free (cachep=3D0xa3ff8d80, objp=3D2756) at mm/=
slab.c:2056
#8  0xa005e9a2 in mempool_free_slab (element=3D0xa0c70ac4, pool_data=3D0xa3=
ff8d80) at mm/mempool.c:286
#9  0xa005e964 in mempool_free (element=3D0xa0c70ac4, pool=3D0xa3f98a78) at=
 mm/mempool.c:269
#10 0xa012dcba in __blk_put_request (q=3D<error type>, req=3D<error type>) =
at drivers/block/ll_rw_blk.c:1473
#11 0xa012eead in end_that_request_last (req=3D<error type>) at drivers/blo=
ck/ll_rw_blk.c:2606
---Type <return> to continue, or q <return> to quit---
#12 0xa012ef49 in end_request (req=3D<error type>, uptodate=3D1) at drivers=
/block/ll_rw_blk.c:2619
#13 0xa002875b in ubd_finish (req=3D<incomplete type>, error=3D0) at arch/u=
m/drivers/ubd_kern.c:416
#14 0xa00289ca in ubd_handler () at arch/um/drivers/ubd_kern.c:451
#15 0xa00289ff in ubd_intr (irq=3D4, dev=3D0xa02a31a0, unused=3D0xa0c50b24)=
 at arch/um/drivers/ubd_kern.c:458
#16 0xa0014bb6 in handle_IRQ_event (irq=3D4, regs=3D0xa0c50b24, action=3D
        {task =3D 0xa3fffd08, type =3D -1597509676, op =3D {proc_get_link =
=3D 0xa3ffda18, proc_read =3D 0xa3ffda18}, pde =3D 0xa3ffd428, vfs_inode =
=3D {d_count =3D {size =3D ---Type <return> to continue, or q <return> to q=
uit---
2697268004, sect =3D 232, head =3D 2697268004, track =3D 2751462664, stretc=
h =3D 2697457668, gap =3D 20 '\024', rate =3D 92 '\\', spec1 =3D 1 '\001', =
fmt_gap =3D 160 '=A0', name =3D 0x4 <Address 0x4 out of bounds>}, d_vfs_fla=
gs =3D 232, d_lock =3D {fn =3D 0xa0c50b24, arg0 =3D 2751462664, arg1 =3D 26=
97457668, arg2 =3D 2684443668, arg3 =3D 4}, d_inode =3D 0x0, d_lru =3D {nex=
t =3D 0xa0015ba1, prev =3D 0xe8}, d_child =3D {next =3D 0xa0c50b24, prev =
=3D 0xa0000094}, d_subdirs =3D {next =3D 0x0, prev =3D 0x0}, d_alias =3D {n=
ext =3D 0x0, prev =3D 0xa0c7f034}, d_time =3D 2684502091, d_op =3D 0x1d, d_=
sb =3D 0xa0c50b24, d_flags =3D 2697457716, d_mounted =3D -1610465299, d_fsd=
ata =3D 0x1, d_rcu =3D <incomplete type>, d_cookie =3D 0x16, d_move_count =
=3D 2697457748, d_qstr =3D 0xa001d7be, d_parent =3D 0x1d, d_name =3D {list =
=3D {next =3D 0xa0c7f060, prev =3D 0x5a5a5a5a}, func =3D 0x5a5a5a5a, arg =
=3D 0x5a5a5a5a}, d_hash =3D {next =3D 0x5a5a5a5a, pprev =3D 0x5a5a5a5a}, d_=
bucket =3D 0xa0c7f34c, d_iname =3D "h=AD\034=A0\035\000\000\000\000\000\00-=
--Type <return> to continue, or q <return> to quit---
0\000\000\000\000"}}) at arch/um/kernel/irq.c:155
#17 0xa001500d in do_IRQ (irq=3D4, regs=3D0xa0c50b24) at arch/um/kernel/irq=
.c:327
#18 0xa0015c14 in sigio_handler (sig=3D29, regs=3D0xa0c50b24) at arch/um/ke=
rnel/irq_user.c:73
#19 0xa002404b in sig_handler_common_skas (sig=3D29, sc_ptr=3D<incomplete t=
ype>) at arch/um/kernel/skas/trap_user.c:33
#20 0xa001d7be in sig_handler (sig=3D29, sc=3D<incomplete type>) at arch/um=
/kernel/trap_user.c:101
#21 <signal handler called>
---Type <return> to continue, or q <return> to quit---
#22 0xa01cb032 in sigprocmask ()
#23 0xa001b0d8 in change_signals (type=3D1) at arch/um/kernel/signal_user.c=
:69
#24 0xa001b124 in unblock_signals () at arch/um/kernel/signal_user.c:80
#25 0xa002403b in sig_handler_common_skas (sig=3D11, sc_ptr=3D<incomplete t=
ype>) at arch/um/kernel/skas/trap_user.c:31
#26 0xa001d7be in sig_handler (sig=3D11, sc=3D<incomplete type>) at arch/um=
/kernel/trap_user.c:101
#27 <signal handler called>
---Type <return> to continue, or q <return> to quit---
#28 0xa003a47a in release_console_sem () at kernel/printk.c:603
#29 0xa003a2d3 in printk (fmt=3D0xa0227b60 "<3>Slab corruption: start=3D%p,=
 expend=3D%p, problemat=3D%p\n") at kernel/printk.c:543
#30 0xa0062f1b in check_poison_obj (cachep=3D0xa0800c80, objp=3D57648) at m=
m/slab.c:916
#31 0xa006524f in __kmalloc (size=3D
      {kset =3D {subsys =3D 0x6a0, ktype =3D 0x20, list =3D {debugregs =3D =
{5, 2684512258, 2751206560, 2751207168, 5, 2684505219, 2708110512, 27081108=
40}, debugregs_seq =3D -1597507500}, kobj =3D 2751206560, hotplug_ops =3D 0=
xa3fc14a0}, rwsem =3D <error type>}, flags=3D32) at mm/slab.c:1876
---Type <return> to continue, or q <return> to quit---
#32 0xa0143636 in alloc_skb (size=3D1516, gfp_mask=3D32) at include/linux/s=
lab.h:97
#33 0xa0024b8f in uml_net_rx (dev=3D<incomplete type>) at include/linux/skb=
uff.h:1059
#34 0xa0024d5b in uml_net_interrupt (irq=3D5, dev_id=3D0xa3fc14a0, regs=3D0=
xa0c50b24) at arch/um/drivers/net_kern.c:76
#35 0xa0014bb6 in handle_IRQ_event (irq=3D5, regs=3D0xa0c50b24, action=3D
        {task =3D 0xa03a8c00, type =3D -1597507356, op =3D {proc_get_link =
=3D 0xa3ffd428, proc_read =3D 0xa3ffd428}, pde =3D 0xa3ffd6d4, vfs_inode =
=3D {d_count =3D {size =3D 2697268004, sect =3D 232, head =3D 2697268004, t=
rack =3D 2688191488, stretch =3D 2697459988, gap =3D 20 '\024', rate =3D 92=
 '\\', spec1 =3D 1 '\001', fmt_gap =3D 160 '=A0', n---Type <return> to cont=
inue, or q <return> to quit---
ame =3D 0x5 <Address 0x5 out of bounds>}, d_vfs_flags =3D 232, d_lock =3D {=
fn =3D 0xa0c50b24, arg0 =3D 2688191488, arg1 =3D 2697459988, arg2 =3D 26844=
43668, arg3 =3D 5}, d_inode =3D 0x0, d_lru =3D {next =3D 0xa0015ba1, prev =
=3D 0xe8}, d_child =3D {next =3D 0xa0c50b24, prev =3D 0xa0000094}, d_subdir=
s =3D {next =3D 0x0, prev =3D 0x0}, d_alias =3D {next =3D 0x0, prev =3D 0xa=
0c7f944}, d_time =3D 2684502091, d_op =3D 0x1d, d_sb =3D 0xa0c50b24, d_flag=
s =3D 2697460036, d_mounted =3D -1610465299, d_fsdata =3D 0x1, d_rcu =3D <i=
ncomplete type>, d_cookie =3D 0x2, d_move_count =3D 2697460068, d_qstr =3D =
0xa001d7be, d_parent =3D 0x1d, d_name =3D {list =3D {next =3D 0xa0c7f970, p=
rev =3D 0xa0c7f974}, func =3D 0xa001d7dc <alarm_handler+24>, arg =3D 0xa0c7=
fd0c}, d_hash =3D {next =3D 0xa0c7fd0c, pprev =3D 0x0}, d_bucket =3D 0xa0c7=
fc5c, d_iname =3D "h=AD\034=A0\035\000\000\000\000\000\000\000\000\000\000"=
}}) at arch/um/kernel/irq.c:155
---Type <return> to continue, or q <return> to quit---
#36 0xa001500d in do_IRQ (irq=3D5, regs=3D0xa0c50b24) at arch/um/kernel/irq=
.c:327
#37 0xa0015c14 in sigio_handler (sig=3D29, regs=3D0xa0c50b24) at arch/um/ke=
rnel/irq_user.c:73
#38 0xa002404b in sig_handler_common_skas (sig=3D29, sc_ptr=3D<incomplete t=
ype>) at arch/um/kernel/skas/trap_user.c:33
#39 0xa001d7be in sig_handler (sig=3D29, sc=3D<incomplete type>) at arch/um=
/kernel/trap_user.c:101
#40 <signal handler called>
#41 0xa01cb032 in sigprocmask ()
---Type <return> to continue, or q <return> to quit---
#42 0xa001b05f in change_sig (signal=3D10, on=3D1) at arch/um/kernel/signal=
_user.c:56
#43 0xa0024024 in sig_handler_common_skas (sig=3D11, sc_ptr=3D<incomplete t=
ype>) at arch/um/kernel/skas/trap_user.c:29
#44 0xa001d7be in sig_handler (sig=3D11, sc=3D<incomplete type>) at arch/um=
/kernel/trap_user.c:101
#45 <signal handler called>
#46 sig_handler_common_skas (sig=3D11, sc_ptr=3D<incomplete type>) at arch/=
um/kernel/skas/trap_user.c:24
#47 0xa001d7be in sig_handler (sig=3D11, sc=3D<incomplete type>) at arch/um=
/kernel/trap_user.c:101
---Type <return> to continue, or q <return> to quit---
#48 <signal handler called>
#49 sig_handler_common_skas (sig=3D11, sc_ptr=3D<incomplete type>) at arch/=
um/kernel/skas/trap_user.c:24
#50 0xa001d7be in sig_handler (sig=3D11, sc=3D<incomplete type>) at arch/um=
/kernel/trap_user.c:101
#51 <signal handler called>
#52 sig_handler_common_skas (sig=3D11, sc_ptr=3D<incomplete type>) at arch/=
um/kernel/skas/trap_user.c:24
#53 0xa001d7be in sig_handler (sig=3D11, sc=3D<incomplete type>) at arch/um=
/kernel/trap_user.c:101
---Type <return> to continue, or q <return> to quit---
#54 <signal handler called>
#55 sig_handler_common_skas (sig=3D11, sc_ptr=3D<incomplete type>) at arch/=
um/kernel/skas/trap_user.c:24
#56 0xa001d7be in sig_handler (sig=3D11, sc=3D<incomplete type>) at arch/um=
/kernel/trap_user.c:101
#57 <signal handler called>
#58 sig_handler_common_skas (sig=3D11, sc_ptr=3D<incomplete type>) at arch/=
um/kernel/skas/trap_user.c:24
#59 0xa001d7be in sig_handler (sig=3D11, sc=3D<incomplete type>) at arch/um=
/kernel/trap_user.c:101
---Type <return> to continue, or q <return> to quit---
#60 <signal handler called>
#61 sig_handler_common_skas (sig=3D11, sc_ptr=3D<incomplete type>) at arch/=
um/kernel/skas/trap_user.c:24
#62 0xa001d7be in sig_handler (sig=3D11, sc=3D<incomplete type>) at arch/um=
/kernel/trap_user.c:101
#63 <signal handler called>
#64 sig_handler_common_skas (sig=3D11, sc_ptr=3D<incomplete type>) at arch/=
um/kernel/skas/trap_user.c:24
#65 0xa001d7be in sig_handler (sig=3D11, sc=3D<incomplete type>) at arch/um=
/kernel/trap_user.c:101
[repeating]
#168 <signal handler called>
#169 handle_page_fault (address=3D23786728, ip=3D1711436802, is_write=3D0, =
is_user=3D0, code_out=3D0xa0c88034) at arch/um/kernel/trap_kern.c:32
#170 0xa001d136 in segv (address=3D23786728, ip=3D1711436802, is_write=3D0,=
 is_user=3D0, sc=3D0xa001db1e) at arch/um/kernel/trap_kern.c:152
#171 0xa001d762 in segv_handler (sig=3D11, regs=3D0xa001db1e) at arch/um/ke=
rnel/trap_user.c:67
#172 0xa002404b in sig_handler_common_skas (sig=3D11, sc_ptr=3D<incomplete =
type>) at arch/um/kernel/skas/trap_user.c:33
#173 0xa001d7be in sig_handler (sig=3D11, sc=3D<incomplete type>) at arch/u=
m/kernel/trap_user.c:101
---Type <return> to continue, or q <return> to quit---
#174 <signal handler called>
#175 __down_read (sem=3D0x16af4e4) at lib/rwsem-spinlock.c:127
#176 0xa001ce35 in handle_page_fault (address=3D23786728, ip=3D1711436802, =
is_write=3D0, is_user=3D0, code_out=3D0xa0c884ec) at include/linux/rwsem.h:=
45
#177 0xa001d136 in segv (address=3D23786728, ip=3D1711436802, is_write=3D0,=
 is_user=3D0, sc=3D0xa001db1e) at arch/um/kernel/trap_kern.c:152
#178 0xa001d762 in segv_handler (sig=3D11, regs=3D0xa001db1e) at arch/um/ke=
rnel/trap_user.c:67
#179 0xa002404b in sig_handler_common_skas (sig=3D11, sc_ptr=3D<incomplete =
type>) at arch/um/kernel/skas/trap_user.c:33
---Type <return> to continue, or q <return> to quit---
#180 0xa001d7be in sig_handler (sig=3D11, sc=3D<incomplete type>) at arch/u=
m/kernel/trap_user.c:101
#181 <signal handler called>
#182 __down_read (sem=3D0x16af4e4) at lib/rwsem-spinlock.c:127
#183 0xa001ce35 in handle_page_fault (address=3D23786728, ip=3D1711436802, =
is_write=3D0, is_user=3D0, code_out=3D0xa0c889a4) at include/linux/rwsem.h:=
45
#184 0xa001d136 in segv (address=3D23786728, ip=3D1711436802, is_write=3D0,=
 is_user=3D0, sc=3D0xa001db1e) at arch/um/kernel/trap_kern.c:152
#185 0xa001d762 in segv_handler (sig=3D11, regs=3D0xa001db1e) at arch/um/ke=
rnel/trap_user.c:67
---Type <return> to continue, or q <return> to quit---
#186 0xa002404b in sig_handler_common_skas (sig=3D11, sc_ptr=3D<incomplete =
type>) at arch/um/kernel/skas/trap_user.c:33
#187 0xa001d7be in sig_handler (sig=3D11, sc=3D<incomplete type>) at arch/u=
m/kernel/trap_user.c:101
#188 <signal handler called>
#189 __down_read (sem=3D0x16af4e4) at lib/rwsem-spinlock.c:127
#190 0xa001ce35 in handle_page_fault (address=3D23786728, ip=3D1711436802, =
is_write=3D0, is_user=3D0, code_out=3D0xa0c88e5c) at include/linux/rwsem.h:=
45
#191 0xa001d136 in segv (address=3D23786728, ip=3D1711436802, is_write=3D0,=
 is_user=3D0, sc=3D0xa001db1e) at arch/um/kernel/trap_kern.c:152
---Type <return> to continue, or q <return> to quit---
#192 0xa001d762 in segv_handler (sig=3D11, regs=3D0xa001db1e) at arch/um/ke=
rnel/trap_user.c:67
#193 0xa002404b in sig_handler_common_skas (sig=3D11, sc_ptr=3D<incomplete =
type>) at arch/um/kernel/skas/trap_user.c:33
#194 0xa001d7be in sig_handler (sig=3D11, sc=3D<incomplete type>) at arch/u=
m/kernel/trap_user.c:101
#195 <signal handler called>
#196 __down_read (sem=3D0x16af4e4) at lib/rwsem-spinlock.c:127
#197 0xa001ce35 in handle_page_fault (address=3D23786728, ip=3D1711436802, =
is_write=3D0, is_user=3D0, code_out=3D0xa0c89314) at include/linux/rwsem.h:=
45
---Type <return> to continue, or q <return> to quit---
#198 0xa001d136 in segv (address=3D23786728, ip=3D1711436802, is_write=3D0,=
 is_user=3D0, sc=3D0xa001db1e) at arch/um/kernel/trap_kern.c:152
#199 0xa001d762 in segv_handler (sig=3D11, regs=3D0xa001db1e) at arch/um/ke=
rnel/trap_user.c:67
#200 0xa002404b in sig_handler_common_skas (sig=3D11, sc_ptr=3D<incomplete =
type>) at arch/um/kernel/skas/trap_user.c:33
#201 0xa001d7be in sig_handler (sig=3D11, sc=3D<incomplete type>) at arch/u=
m/kernel/trap_user.c:101
#202 <signal handler called>
#203 __down_read (sem=3D0x16af4e4) at lib/rwsem-spinlock.c:127
---Type <return> to continue, or q <return> to quit---
#204 0xa001ce35 in handle_page_fault (address=3D23786728, ip=3D1711436802, =
is_write=3D0, is_user=3D0, code_out=3D0xa0c897cc) at include/linux/rwsem.h:=
45
#205 0xa001d136 in segv (address=3D23786728, ip=3D1711436802, is_write=3D0,=
 is_user=3D0, sc=3D0xa001db1e) at arch/um/kernel/trap_kern.c:152
#206 0xa001d762 in segv_handler (sig=3D11, regs=3D0xa001db1e) at arch/um/ke=
rnel/trap_user.c:67
#207 0xa002404b in sig_handler_common_skas (sig=3D11, sc_ptr=3D<incomplete =
type>) at arch/um/kernel/skas/trap_user.c:33
#208 0xa001d7be in sig_handler (sig=3D11, sc=3D<incomplete type>) at arch/u=
m/kernel/trap_user.c:101
#209 <signal handler called>
---Type <return> to continue, or q <return> to quit---
#210 __down_read (sem=3D0x16af4e4) at lib/rwsem-spinlock.c:127
#211 0xa001ce35 in handle_page_fault (address=3D23786728, ip=3D1711436802, =
is_write=3D0, is_user=3D0, code_out=3D0xa0c89c84) at include/linux/rwsem.h:=
45
#212 0xa001d136 in segv (address=3D23786728, ip=3D1711436802, is_write=3D0,=
 is_user=3D0, sc=3D0xa001db1e) at arch/um/kernel/trap_kern.c:152
#213 0xa001d762 in segv_handler (sig=3D11, regs=3D0xa001db1e) at arch/um/ke=
rnel/trap_user.c:67
#214 0xa002404b in sig_handler_common_skas (sig=3D11, sc_ptr=3D<incomplete =
type>) at arch/um/kernel/skas/trap_user.c:33
#215 0xa001d7be in sig_handler (sig=3D11, sc=3D<incomplete type>) at arch/u=
m/kernel/trap_user.c:101
---Type <return> to continue, or q <return> to quit---
#216 <signal handler called>
#217 __down_read (sem=3D0x16af4e4) at lib/rwsem-spinlock.c:127
#218 0xa001ce35 in handle_page_fault (address=3D23786728, ip=3D1711436802, =
is_write=3D0, is_user=3D0, code_out=3D0xa0c8a13c) at include/linux/rwsem.h:=
45
#219 0xa001d136 in segv (address=3D23786728, ip=3D1711436802, is_write=3D0,=
 is_user=3D0, sc=3D0xa001db1e) at arch/um/kernel/trap_kern.c:152
#220 0xa001d762 in segv_handler (sig=3D11, regs=3D0xa001db1e) at arch/um/ke=
rnel/trap_user.c:67
#221 0xa002404b in sig_handler_common_skas (sig=3D11, sc_ptr=3D<incomplete =
type>) at arch/um/kernel/skas/trap_user.c:33
---Type <return> to continue, or q <return> to quit---
#222 0xa001d7be in sig_handler (sig=3D11, sc=3D<incomplete type>) at arch/u=
m/kernel/trap_user.c:101
#223 <signal handler called>
#224 __down_read (sem=3D0x16af4e4) at lib/rwsem-spinlock.c:127
#225 0xa001ce35 in handle_page_fault (address=3D23786728, ip=3D1711436802, =
is_write=3D0, is_user=3D0, code_out=3D0xa0c8a5f4) at include/linux/rwsem.h:=
45
#226 0xa001d136 in segv (address=3D23786728, ip=3D1711436802, is_write=3D0,=
 is_user=3D0, sc=3D0xa001db1e) at arch/um/kernel/trap_kern.c:152
#227 0xa001d762 in segv_handler (sig=3D11, regs=3D0xa001db1e) at arch/um/ke=
rnel/trap_user.c:67
---Type <return> to continue, or q <return> to quit---
#228 0xa002404b in sig_handler_common_skas (sig=3D11, sc_ptr=3D<incomplete =
type>) at arch/um/kernel/skas/trap_user.c:33
#229 0xa001d7be in sig_handler (sig=3D11, sc=3D<incomplete type>) at arch/u=
m/kernel/trap_user.c:101
#230 <signal handler called>
#231 __down_read (sem=3D0x16af4e4) at lib/rwsem-spinlock.c:127
#232 0xa001ce35 in handle_page_fault (address=3D23786728, ip=3D1711436802, =
is_write=3D0, is_user=3D0, code_out=3D0xa0c8aaac) at include/linux/rwsem.h:=
45
#233 0xa001d136 in segv (address=3D23786728, ip=3D1711436802, is_write=3D0,=
 is_user=3D0, sc=3D0xa001db1e) at arch/um/kernel/trap_kern.c:152
---Type <return> to continue, or q <return> to quit---
#234 0xa001d762 in segv_handler (sig=3D11, regs=3D0xa001db1e) at arch/um/ke=
rnel/trap_user.c:67
#235 0xa002404b in sig_handler_common_skas (sig=3D11, sc_ptr=3D<incomplete =
type>) at arch/um/kernel/skas/trap_user.c:33
#236 0xa001d7be in sig_handler (sig=3D11, sc=3D<incomplete type>) at arch/u=
m/kernel/trap_user.c:101
#237 <signal handler called>
#238 __down_read (sem=3D0x16af4e4) at lib/rwsem-spinlock.c:127
#239 0xa001ce35 in handle_page_fault (address=3D23786728, ip=3D1711436802, =
is_write=3D0, is_user=3D0, code_out=3D0xa0c8af64) at include/linux/rwsem.h:=
45
---Type <return> to continue, or q <return> to quit---
#240 0xa001d136 in segv (address=3D23786728, ip=3D1711436802, is_write=3D0,=
 is_user=3D0, sc=3D0xa001db1e) at arch/um/kernel/trap_kern.c:152
#241 0xa001d762 in segv_handler (sig=3D11, regs=3D0xa001db1e) at arch/um/ke=
rnel/trap_user.c:67
#242 0xa002404b in sig_handler_common_skas (sig=3D11, sc_ptr=3D<incomplete =
type>) at arch/um/kernel/skas/trap_user.c:33
#243 0xa001d7be in sig_handler (sig=3D11, sc=3D<incomplete type>) at arch/u=
m/kernel/trap_user.c:101
#244 <signal handler called>
#245 __down_read (sem=3D0x16af4e4) at lib/rwsem-spinlock.c:127
---Type <return> to continue, or q <return> to quit---
#246 0xa001ce35 in handle_page_fault (address=3D23786728, ip=3D1711436802, =
is_write=3D0, is_user=3D0, code_out=3D0xa0c8b41c) at include/linux/rwsem.h:=
45
#247 0xa001d136 in segv (address=3D23786728, ip=3D1711436802, is_write=3D0,=
 is_user=3D0, sc=3D0xa001db1e) at arch/um/kernel/trap_kern.c:152
#248 0xa001d762 in segv_handler (sig=3D11, regs=3D0xa001db1e) at arch/um/ke=
rnel/trap_user.c:67
#249 0xa002404b in sig_handler_common_skas (sig=3D11, sc_ptr=3D<incomplete =
type>) at arch/um/kernel/skas/trap_user.c:33
#250 0xa001d7be in sig_handler (sig=3D11, sc=3D<incomplete type>) at arch/u=
m/kernel/trap_user.c:101
#251 <signal handler called>
---Type <return> to continue, or q <return> to quit---
#252 __down_read (sem=3D0x16af4e4) at lib/rwsem-spinlock.c:127
#253 0xa001ce35 in handle_page_fault (address=3D23786728, ip=3D1711436802, =
is_write=3D0, is_user=3D0, code_out=3D0xa0c8b8d4) at include/linux/rwsem.h:=
45
#254 0xa001d136 in segv (address=3D23786728, ip=3D1711436802, is_write=3D0,=
 is_user=3D0, sc=3D0xa001db1e) at arch/um/kernel/trap_kern.c:152
#255 0xa001d762 in segv_handler (sig=3D11, regs=3D0xa001db1e) at arch/um/ke=
rnel/trap_user.c:67
#256 0xa002404b in sig_handler_common_skas (sig=3D11, sc_ptr=3D<incomplete =
type>) at arch/um/kernel/skas/trap_user.c:33
#257 0xa001d7be in sig_handler (sig=3D11, sc=3D<incomplete type>) at arch/u=
m/kernel/trap_user.c:101
---Type <return> to continue, or q <return> to quit---
#258 <signal handler called>
#259 __down_read (sem=3D0x16af4e4) at lib/rwsem-spinlock.c:127
#260 0xa001ce35 in handle_page_fault (address=3D1431636759, ip=3D1711436802=
, is_write=3D2, is_user=3D0, code_out=3D0xa0c8bd8c) at include/linux/rwsem.=
h:45
#261 0xa001d136 in segv (address=3D1431636759, ip=3D1711436802, is_write=3D=
2, is_user=3D0, sc=3D0xa001db1e) at arch/um/kernel/trap_kern.c:152
#262 0xa001d762 in segv_handler (sig=3D11, regs=3D0xa001db1e) at arch/um/ke=
rnel/trap_user.c:67
#263 0xa002404b in sig_handler_common_skas (sig=3D11, sc_ptr=3D<incomplete =
type>) at arch/um/kernel/skas/trap_user.c:33
---Type <return> to continue, or q <return> to quit---
#264 0xa001d7be in sig_handler (sig=3D11, sc=3D<incomplete type>) at arch/u=
m/kernel/trap_user.c:101
#265 <signal handler called>
#266 sig_handler_common_skas (sig=3D11, sc_ptr=3D<incomplete type>) at arch=
/um/kernel/skas/trap_user.c:24
#267 0xa001d7be in sig_handler (sig=3D11, sc=3D<incomplete type>) at arch/u=
m/kernel/trap_user.c:101
#268 <signal handler called>
#269 sig_handler_common_skas (sig=3D11, sc_ptr=3D<incomplete type>) at arch=
/um/kernel/skas/trap_user.c:24
---Type <return> to continue, or q <return> to quit---
#270 0xa001d7be in sig_handler (sig=3D11, sc=3D<incomplete type>) at arch/u=
m/kernel/trap_user.c:101
#271 <signal handler called>
#272 sig_handler_common_skas (sig=3D11, sc_ptr=3D<incomplete type>) at arch=
/um/kernel/skas/trap_user.c:24
#273 0xa001d7be in sig_handler (sig=3D11, sc=3D<incomplete type>) at arch/u=
m/kernel/trap_user.c:101
#274 <signal handler called>
#275 sig_handler_common_skas (sig=3D11, sc_ptr=3D<incomplete type>) at arch=
/um/kernel/skas/trap_user.c:24
---Type <return> to continue, or q <return> to quit---
#276 0xa001d7be in sig_handler (sig=3D11, sc=3D<incomplete type>) at arch/u=
m/kernel/trap_user.c:101
#277 <signal handler called>
#278 sig_handler_common_skas (sig=3D11, sc_ptr=3D<incomplete type>) at arch=
/um/kernel/skas/trap_user.c:24
#279 0xa001d7be in sig_handler (sig=3D11, sc=3D<incomplete type>) at arch/u=
m/kernel/trap_user.c:101
#280 <signal handler called>
#281 sig_handler_common_skas (sig=3D11, sc_ptr=3D<incomplete type>) at arch=
/um/kernel/skas/trap_user.c:24
---Type <return> to continue, or q <return> to quit---
#282 0xa001d7be in sig_handler (sig=3D11, sc=3D<incomplete type>) at arch/u=
m/kernel/trap_user.c:101
#283 <signal handler called>
#284 sig_handler_common_skas (sig=3D11, sc_ptr=3D<incomplete type>) at arch=
/um/kernel/skas/trap_user.c:24
#285 0xa001d7be in sig_handler (sig=3D11, sc=3D<incomplete type>) at arch/u=
m/kernel/trap_user.c:101
#286 <signal handler called>
#287 sig_handler_common_skas (sig=3D11, sc_ptr=3D<incomplete type>) at arch=
/um/kernel/skas/trap_user.c:24
---Type <return> to continue, or q <return> to quit---
#288 0xa001d7be in sig_handler (sig=3D11, sc=3D<incomplete type>) at arch/u=
m/kernel/trap_user.c:101
#289 <signal handler called>
#290 sig_handler_common_skas (sig=3D11, sc_ptr=3D<incomplete type>) at arch=
/um/kernel/skas/trap_user.c:24
#291 0xa001d7be in sig_handler (sig=3D11, sc=3D<incomplete type>) at arch/u=
m/kernel/trap_user.c:101
#292 <signal handler called>
#293 sig_handler_common_skas (sig=3D11, sc_ptr=3D<incomplete type>) at arch=
/um/kernel/skas/trap_user.c:24
[repeating at least to #4000 when I left gdb...]
#v-

Repeating the whole story UML crashed again, the kernel and gdb told me:
#v+
Kernel panic: kernel BUG at kernel/exit.c:793!

 <6>SysRq : Show Regs

EIP: 0073:[<400a0137>] CPU: 0 Not tainted ESP: 007b:bffff4bc EFLAGS: 000002=
46
    Not tainted
EAX: ffffffda EBX: 00000000 ECX: 00000000 EDX: 00000000
ESI: 4010aaac EDI: 00000000 EBP: bffff4d0 DS: 007b ES: 007b
Call Trace: [<a003a2d3>] [<a01283c7>] [<a01283af>] [<a0128348>] [<a0128334>=
]=20
   [<a001de62>] [<a003a2c1>] [<a003a2d3>] [<a004d0ca>] [<a0115e57>] [<a003a=
2d3>]=20
   [<a0039318>] [<a0039304>] [<a00392fa>] [<a003d202>] [<a003ce64>] [<a001c=
c43>]=20
   [<a00174d1>] [<a001cfac>] [<a003d45e>] [<a001d055>] [<a006fb96>] [<a001d=
136>]=20
   [<a003d476>] [<a0023b25>] [<a001bc93>] [<a001be5b>] [<a0023b6c>] [<a0023=
b63>]=20
   [<a0022e14>] [<a002304a>] [<a0031f4f>] [<a001b124>] [<a002386a>] [<a0023=
852>]=20
   [<a01cad68>] [<a0031f4f>] [<a01cbe7d>]=20


Program exited normally.
(gdb) bt
No stack.
#v-

So, the breakpoint at exit seems not to be working.
Since I am new in using a debugger I have to be told what to do now. :-)


Regards,
 Thomas

--CE+1k2dSO48ffgeK
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.bz2"
Content-Transfer-Encoding: base64

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

--CE+1k2dSO48ffgeK--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
