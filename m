Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1XDInV-0002CP-5I
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Aug 2014 19:47:25 +0000
Received: from mout.gmx.net ([212.227.17.21])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XDInT-0001g9-NM
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Aug 2014 19:47:24 +0000
Received: from [192.168.178.21] ([78.54.139.125]) by mail.gmx.com (mrgmx103)
	with ESMTPSA (Nemesis) id 0LhwAY-1WhnTb11mM-00nAeA for
	<user-mode-linux-devel@lists.sourceforge.net>; Fri, 01 Aug 2014 21:47:17
	+0200
Message-ID: <53DBEEC4.9020406@gmx.de>
Date: Fri, 01 Aug 2014 21:47:16 +0200
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
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
Subject: [uml-devel] fuzz testing a 32 bit UML guest - ssh login won't work
	since a hour
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>

Fuzz testing a 32 bit x86 Gentoo UML guest (especially NFSv4 files, nfs sserver and client runs within the UML guest) with current git kernel brought the guest into a state, where no ssh login is any longer possible.

At the host side I can see that the linux processes are still running.

I attached the gdb to the linux processes at the host (even 32 bit x86 Gentoo). I do get nearly all the time:


Thread 1 (process 4252):
#0  0xb7736aec in __kernel_vsyscall ()
#1  0x08496faf in __nanosleep_nocancel () at ../sysdeps/unix/syscall-template.S:81
#2  0x08073124 in idle_sleep (nsecs=606859328243668608) at arch/um/os-Linux/time.c:183
#3  0x08060b3f in arch_cpu_idle () at arch/um/kernel/process.c:208
#4  0x080a5405 in cpuidle_idle_call () at kernel/sched/idle.c:120
#5  cpu_idle_loop () at kernel/sched/idle.c:224
#6  cpu_startup_entry (state=CPUHP_ONLINE) at kernel/sched/idle.c:272
#7  0x084e16d2 in rest_init () at init/main.c:419
#8  0x0804892e in start_kernel () at init/main.c:679
#9  0x08049fc9 in start_kernel_proc (unused=0x0) at arch/um/kernel/skas/process.c:46
#10 0x0806064b in new_thread_handler () at arch/um/kernel/process.c:129
#11 0x00000000 in ?? ()

...



but at least one time I got:


0x08108de3 in __put_super (sb=0x86a60000) at fs/super.c:246
246             if (!--sb->s_count) {

Thread 1 (process 4252):
#0  0x08108de3 in __put_super (sb=0x86a60000) at fs/super.c:246
#1  0x081096ac in put_super (sb=<optimized out>) at fs/super.c:262
#2  drop_super (sb=0x86a60000) at fs/super.c:487
#3  0x0812a337 in __writeback_inodes_wb (wb=0x8421c09c, work=0x1) at fs/fs-writeback.c:733
#4  0x0812a479 in wb_writeback (wb=0x8421c09c, work=0x869d7efc) at fs/fs-writeback.c:863
#5  0x0812a74e in wb_check_background_flush (wb=<optimized out>) at fs/fs-writeback.c:944
#6  wb_do_writeback (wb=<optimized out>) at fs/fs-writeback.c:1014
#7  bdi_writeback_workfn (work=0x8421c0a8) at fs/fs-writeback.c:1043
#8  0x08090d11 in process_one_work (worker=0x84325000, work=0x8421c0a8) at kernel/workqueue.c:2081
#9  0x0809116a in worker_thread (__worker=0x84325000) at kernel/workqueue.c:2212
#10 0x08096806 in kthread (_create=0x84207410) at kernel/kthread.c:207
#11 0x0806064b in new_thread_handler () at arch/um/kernel/process.c:129
#12 0x00000000 in ?? ()

...


Now I'm wondering if this is an issue which is worth to be debugged or whether I just should ignore it.

BTW the nsecs of 2 gdb calls in a row are identical since few minutes : 606859328243668608
before the value was : 606859328233668608



-- 
Toralf


------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

