Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bx2O4-0001EH-MY for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Aug 2004 04:44:20 -0700
Received: from ip-217-18-179-10.reverse.dsi.net ([217.18.179.10]
	helo=sindar.exse.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bx2KI-0002BF-NY for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Aug 2004 04:44:20 -0700
Received: from localhost (localhost [127.0.0.1])
	by sindar.exse.net (Postfix) with ESMTP id 6880C216CC
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 17 Aug 2004 13:39:41 +0200 (CEST)
Received: from sindar.exse.net ([127.0.0.1])
	by localhost (sindar [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 16710-16
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 17 Aug 2004 13:39:40 +0200 (CEST)
Received: from [10.0.2.5] (port-212-202-42-103.dynamic.qsc.de [212.202.42.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sindar.exse.net (Postfix) with ESMTP id 421FE21631
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 17 Aug 2004 13:39:40 +0200 (CEST)
Message-ID: <4121EE8B.2090804@exse.net>
From: seb <seb@exse.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] 2.4.26-3 crash
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
Date: Tue, 17 Aug 2004 13:39:55 +0200
To: user-mode-linux-devel@lists.sourceforge.net

please contact me if you need any more information or if I should try 
something (differend host kernel or some patch to the guest kernel or 
whatever, I have enough time to help getting this stable)

host and guest are debian sarge (reiserfs).

the guest paniced in the moment I did a 'apt-get remove libconsole1' , 
after I entered 'yes'.

is there a bugtracker and a cvs repository for uml ?

/seb


------------------------
file linux
handle SIGSEGV pass nostop noprint
handle SIGUSR1 pass nostop noprint
break panic
r umid=test mem=64M ubd0=rootfs_test eth0=tuntap,,,10.0.0.1
------------------------
Checking for the skas3 patch in the host...found
Checking for /proc/mm...found
Checking for /dev/anon on the host...Not available (open failed with 
errno 2)
Linux version 2.4.26-3um (uml@host) (gcc version 3.3.4 (Debian 
1:3.3.4-3)) #2 Fri Aug 13 10:17:50 CEST 2004
------------------------
host ist 2.4.26 with linux-vservers patch (cause they're also running on 
that machine, but can use a differend kernel if that matters)
Linux host 2.4.26-vs1.27 #1 SMP Sat Jun 5 22:15:42 CEST 2004 i686 GNU/Linux
------------------------
Breakpoint 1, panic (fmt=0x84c1000 "") at panic.c:58
58              machine_paniced = 1;
(gdb) .[K(gdb) bt
#0  panic (fmt=0x84c1000 "") at panic.c:58
#1  0x080d6258 in handle_page_fault (address=139203124, ip=0, is_write=2,
    is_user=1, code_out=0x84c3bfc) at trap_kern.c:56
#2  0x080d63a6 in segv (address=139203124, ip=0, is_write=2, is_user=1,
    sc=0x84c1000) at trap_kern.c:133
#3  0x080d7c44 in handle_segv (pid=139202560) at process.c:56
#4  0x080d803a in userspace (regs=0x84c0270) at process.c:157
#5  0x080d8944 in fork_handler (sig=10) at process_kern.c:104
#6  <signal handler called>
#7  0x40044721 in kill () from /lib/libc.so.6
#8  0x080dd3ca in os_usr1_process (pid=0) at process.c:98
#9  0x080d8112 in new_thread (stack=0x84c0000, switch_buf_ptr=0x0,
    fork_buf_ptr=0x0, handler=0x80d88c0 <fork_handler>) at process.c:199
#10 0x080d89df in copy_thread_skas (nr=0, clone_flags=17, sp=0, stack_top=0,
    p=0x84c0000, regs=0x0) at process_kern.c:133
#11 0x080d251b in copy_thread (nr=0, clone_flags=0, sp=0, stack_top=0,
    p=0x84c0000, regs=0x0) at process_kern.c:165
#12 0x095c3b94 in ?? ()
#13 0x0be257a0 in ?? ()
#14 0x00000000 in ?? ()
#15 0x084c0000 in ?? ()
#16 0x0816dec0 in warn.2 ()
#17 0x00000003 in ?? ()
---Type <return> to continue, or q <return> to quit---
#18 0x0b20ab60 in ?? ()
#19 0x095c3b3c in ?? ()
#20 0xffffffff in ?? ()
#21 0x00000000 in ?? ()
#22 0x00000000 in ?? ()
#23 0x095c3bbc in ?? ()
#24 0x08057743 in sys_wait4 (pid=17, stat_addr=0xb20ab60, options=157024256,
    ru=0x80d5f6a) at exit.c:580
Previous frame identical to this frame (corrupt stack?)
----------------------------------------
CONFIG_USERMODE=y
CONFIG_UID16=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_MODE_SKAS=y
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_BINFMT_ELF=y
CONFIG_MCONSOLE=y
CONFIG_NEST_LEVEL=0
CONFIG_KERNEL_HALF_GIGS=1
CONFIG_KERNEL_STACK_ORDER=2
CONFIG_UML_REAL_TIME_CLOCK=y
CONFIG_STDIO_CONSOLE=y
CONFIG_FD_CHAN=y
CONFIG_NULL_CHAN=y
CONFIG_CON_ZERO_CHAN="fd:0,fd:1"
CONFIG_CON_CHAN="null"
CONFIG_SSL_CHAN="null"
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_BLK_DEV_UBD=y
CONFIG_COW_COMMON=y
CONFIG_NETDEVICES=y
CONFIG_UML_NET=y
CONFIG_UML_NET_TUNTAP=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_REISERFS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_DEBUGSYM=y


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
