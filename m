Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1Y5hZZ-0000fL-DW
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Dec 2014 21:09:54 +0000
Received: from mout.gmx.net ([212.227.17.20])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Y5hZG-00013K-PM
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Dec 2014 21:09:52 +0000
Message-ID: <54A1C307.8020007@gmx.de>
Date: Mon, 29 Dec 2014 22:09:27 +0100
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
References: <54A11D8E.2010605@gmx.de>
	<5238511D-1948-4596-ADFE-478EC46A7868@m3y3r.de>
	<54A15CA4.60907@gmx.de>
In-Reply-To: <54A15CA4.60907@gmx.de>
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
Subject: Re: [uml-devel] does a x86 (== 32 bit) uml image works at a 64 bit
 system Gentoo hardened Linux ?
To: Thomas Meyer <thomas@m3y3r.de>
Cc: user-mode-linux-devel@lists.sourceforge.net


FWIW I recompiled glibc now with debug info.

Now the linux boot goes further till this step :

...
NET: Registered protocol family 10
sit: IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
Key type dns_resolver registered
Initialized stdio console driver
Console initialized on /dev/tty0
                                console [tty0] enabled
console [tty0] enabled
                      bootconsole [earlycon0] disabled
bootconsole [earlycon0] disabled
                                Initializing software serial port version 1
console [mc-1] enabled




gdb gives :
tfoerste@t44 ~ $ pgrep linux | xargs -n1 -i{} sudo gdb /home/tfoerste/devel/linux/linux {} -n -batch -ex 'bt'

warning: Cannot call inferior functions, Linux kernel PaX protection forbids return to non-executable pages!

warning: Could not load shared library symbols for linux-gate.so.1.
Do you need "set solib-search-path" or "set sysroot"?
0xf7746ca0 in ?? ()
#0  0xf7746ca0 in ?? ()
#1  0x08062042 in flush_tlb_kernel_range_common (start=4287905792, end=4293918720) at arch/um/kernel/tlb.c:364
#2  0x08062863 in flush_tlb_kernel_vm () at arch/um/kernel/tlb.c:489
#3  0x08062e30 in segv (fi=<incomplete type>, ip=139646100, is_user=0, regs=0x871f844 <cpu0_irqstack+30788>) at arch/um/kernel/trap.c:213
#4  0x0806314b in segv_handler (sig=11, unused_si=0x871fafc <cpu0_irqstack+31484>, regs=0x871f844 <cpu0_irqstack+30788>) at arch/um/kernel/trap.c:191
#5  0x0807412c in sig_handler_common (sig=11, si=0x875a3c0, mc=0x871fb90 <cpu0_irqstack+31632>) at arch/um/os-Linux/signal.c:44
#6  0x08074208 in sig_handler (sig=0, si=0x871fafc <cpu0_irqstack+31484>, mc=0x875a3c0) at arch/um/os-Linux/signal.c:231
#7  0x08073cfe in hard_handler (sig=4096, si=0x871fafc <cpu0_irqstack+31484>, p=0x871fb7c <cpu0_irqstack+31612>) at arch/um/os-Linux/signal.c:165
#8  <signal handler called>
#9  0x0852d494 in __memset_sse2_rep ()
#10 0x083732ba in check_partition (hd=0x856aa20 <check_part>, bdev=0x0) at block/partitions/check.c:165
#11 0x08372856 in rescan_partitions (disk=0x8464f870, bdev=0x8486bb80) at block/partition-generic.c:433
#12 0x08145934 in __blkdev_get (bdev=0x8486bb80, mode=2239758336, for_part=1728) at fs/block_dev.c:1189
#13 0x08145c84 in blkdev_get (bdev=0x8486bb80, mode=1, holder=0x0) at fs/block_dev.c:1296
#14 0x08370337 in register_disk (disk=<optimized out>) at block/genhd.c:556
#15 add_disk (disk=0x8464f870) at block/genhd.c:618
#16 0x0806c3ab in ubd_disk_register (major=141695968, size=7423943245824, unit=0, disk_out=0x0) at arch/um/drivers/ubd_kern.c:835
#17 0x0806cbb9 in ubd_add (n=0, error_out=0x85800000) at arch/um/drivers/ubd_kern.c:872
#18 0x0804a3a8 in ubd_init () at arch/um/drivers/ubd_kern.c:1073
#19 0x08048abc in do_one_initcall (fn=0x804a312 <ubd_init>) at init/main.c:798
#20 0x08048c67 in do_initcall_level (level=<optimized out>) at init/main.c:863
#21 do_initcalls () at init/main.c:871
#22 do_basic_setup () at init/main.c:890
#23 kernel_init_freeable () at init/main.c:1016
#24 0x085224cb in kernel_init (unused=0x0) at init/main.c:941
#25 0x0806074b in new_thread_handler () at arch/um/kernel/process.c:129
#26 0x00000000 in ?? ()




-- 
Toralf
pgp key: 7B1A 07F4 EC82 0F90 D4C2  8936 872A E508 0076 E94E


------------------------------------------------------------------------------
Dive into the World of Parallel Programming! The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

