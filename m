Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1XPvQU-00043j-4B
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Sep 2014 15:27:50 +0000
Received: from mout.gmx.net ([212.227.15.15])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XPvQS-0006GV-E7
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Sep 2014 15:27:49 +0000
Received: from [192.168.178.21] ([80.171.149.219]) by mail.gmx.com (mrgmx003)
	with ESMTPSA (Nemesis) id 0LcShi-1Y9Sm333B8-00jsCl for
	<user-mode-linux-devel@lists.sourceforge.net>; Fri, 05 Sep 2014 17:27:41
	+0200
Message-ID: <5409D66C.8000509@gmx.de>
Date: Fri, 05 Sep 2014 17:27:40 +0200
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
Subject: [uml-devel] fuzz tested UML hangs while using NFS files as victim
 files - UML issue or NFS issue ?
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>

Within a 32 bit stable Gentoo user mode linux guest system I do experience sometimes that trinity don't exit after it completed the maximum number of jobs.
This might be either an UML, a trinity or a NFS issue (I use NFS victims files). Now I'm wondering where do report it ? (Or is it a trinity issue ?)

UML guest kernel is v3.17-rc3-94-gb7fece1, host is 3.16.1.


The trinity log gives :
...
child0:4020] <timed out>
[child0:4020] <timed out>
[main] Bailing main loop because Completed maximum number of operations..
[watchdog] [3628] Watchdog exiting because Completed maximum number of operations..



Within the UML guest I do see this :


trinity ~ # ps -ef | grep trinity
tfoerste  3415  3414  0 16:33 ?        00:00:12 bash -c logger "1#-1, M=/mnt/nfsv3"; cd ~; sudo su -c 'if [[ -d ./t3 ]]; then sudo chmod -R a+rwx ./t3; sudo rm -rf ./t3; fi'; mkdir ./t3; cd ./t3; if [[ -n /mnt/nfsv3 ]]; then if [[ -d /mnt/nfsv3/victims/v1 ]]; then sudo chmod -R a+rwx /mnt/nfsv3/victims/v1; sudo rm -rf /mnt/nfsv3/victims/v1 || exit; fi; mkdir -p /mnt/nfsv3/victims/v1/v2; for i in $(seq -w 0 99); do touch /mnt/nfsv3/victims/v1/v2/f$i; mkdir /mnt/nfsv3/victims/v1/v2/d$i; done; fi; MALLOC_CHECK_=2 trinity -C 2 -N 100000 -q -x mremap -V /mnt/nfsv3/victims/v1/v2
tfoerste  3627  3415  0 16:33 ?        00:00:00 trinity -C 2 -N 100000 -q -x mremap -V /mnt/nfsv3/victims/v1/v2
tfoerste  3628  3627  0 16:33 ?        00:00:04 [trinity-watchdo] <defunct>
tfoerste  3629  3627 36 16:33 ?        00:15:12 [trinity-main]
root      4083  4077  0 17:15 pts/0    00:00:00 grep --colour=auto trinity

trinity ~ # cat /proc/3629/stack                                                                                                                       
[<0805f8b4>] __switch_to+0x44/0x70                                                                                                                     
[<08503de4>] __schedule+0x2f4/0x3a0                                                                                                                    
[<08097ada>] __cond_resched+0x1a/0x30                                                                                                                  
[<08503fc1>] _cond_resched+0x31/0x50                                                                                                                   
[<080dbd92>] truncate_inode_pages_range+0x192/0x650
[<080dc2e2>] truncate_inode_pages_final+0x52/0x60
[<081ec088>] nfs_evict_inode+0x18/0x30
[<08125dfd>] evict+0xdd/0x1b0
[<08126a7d>] iput+0x16d/0x180
[<081e6e84>] nfs_dentry_iput+0x44/0x50
[<0812268a>] __dentry_kill+0x12a/0x200
[<08122eb6>] dput+0x156/0x180
[<0810eb65>] __fput+0x175/0x190
[<0810ebbb>] ____fput+0xb/0x10
[<080928f6>] task_work_run+0x76/0x90
[<0807ea6d>] do_exit+0x32d/0x940
[<0807f162>] do_group_exit+0xa2/0xf0
[<0807f1c7>] SyS_exit_group+0x17/0x20
[<08062990>] handle_syscall+0x60/0x80
[<0807473c>] userspace+0x46c/0x5e0
[<0805f720>] fork_handler+0x60/0x70
[<ffffffff>] 0xffffffff

trinity ~ # cat /proc/3628/stack
[<0805f8b4>] __switch_to+0x44/0x70
[<08503de4>] __schedule+0x2f4/0x3a0
[<08503ee5>] schedule+0x55/0x60
[<0807efde>] do_exit+0x89e/0x940
[<0807f162>] do_group_exit+0xa2/0xf0
[<0807f1c7>] SyS_exit_group+0x17/0x20
[<08062990>] handle_syscall+0x60/0x80
[<0807473c>] userspace+0x46c/0x5e0
[<0805f720>] fork_handler+0x60/0x70
[<ffffffff>] 0xffffffff

trinity ~ # cat /proc/3627/stack
[<0805f8b4>] __switch_to+0x44/0x70
[<08503de4>] __schedule+0x2f4/0x3a0
[<08503ee5>] schedule+0x55/0x60
[<0807e607>] do_wait+0x177/0x200
[<0807f62d>] SyS_wait4+0xbd/0xe0
[<0807f677>] SyS_waitpid+0x27/0x30
[<08062990>] handle_syscall+0x60/0x80
[<0807473c>] userspace+0x46c/0x5e0
[<0805f720>] fork_handler+0x60/0x70
[<ffffffff>] 0xffffffff



At the host I do see 1 linux process with 100% CPU this :

$ date; pgrep -af 'linux earlyprintk' | cut -f1 -d' ' | xargs -n1 gdb /home/tfoerste/devel/linux/linux -n -batch -ex 'thread apply all bt'
Fri Sep  5 17:21:05 CEST 2014

warning: Could not load shared library symbols for linux-gate.so.1.
Do you need "set solib-search-path" or "set sysroot"?
lru_add_drain_cpu (cpu=0) at mm/swap.c:798
798     {

Thread 1 (process 5266):
#0  lru_add_drain_cpu (cpu=0) at mm/swap.c:798
#1  0x080db7a6 in lru_add_drain () at mm/swap.c:849
#2  __pagevec_release (pvec=0x8551fcb0) at mm/swap.c:968
#3  0x080dbd8d in pagevec_release (pvec=<optimized out>) at include/linux/pagevec.h:69
#4  truncate_inode_pages_range (mapping=0x8587421c, lstart=0, lend=-8840006756412162049) at mm/truncate.c:308
#5  0x080dc2e2 in truncate_inode_pages (lstart=<optimized out>, mapping=<optimized out>) at mm/truncate.c:414
#6  truncate_inode_pages_final (mapping=0x8587421c) at mm/truncate.c:460
#7  0x081ec088 in nfs_evict_inode (inode=0x85874144) at fs/nfs/inode.c:131
#8  0x08125dfd in evict (inode=0x85874144) at fs/inode.c:551
#9  0x08126a7d in iput_final (inode=<optimized out>) at fs/inode.c:1419
#10 iput (inode=0x85874144) at fs/inode.c:1437
#11 0x081e6e84 in nfs_dentry_iput (dentry=0xb8c1ec0, inode=0x85874144) at fs/nfs/dir.c:1320
#12 0x0812268a in dentry_iput (dentry=<optimized out>) at fs/dcache.c:290
#13 __dentry_kill (dentry=0x85b6b640) at fs/dcache.c:477
#14 0x08122eb6 in dentry_kill (dentry=<optimized out>) at fs/dcache.c:521
#15 dput (dentry=0x678683c0) at fs/dcache.c:617
#16 0x0810eb65 in __fput (file=0x857bf900) at fs/file_table.c:234
#17 0x0810ebbb in ____fput (work=0x857bf900) at fs/file_table.c:252
#18 0x080928f6 in task_work_run () at kernel/task_work.c:123
#19 0x0807ea6d in exit_task_work (task=<optimized out>) at include/linux/task_work.h:21
#20 do_exit (code=-2065204480) at kernel/exit.c:758
#21 0x0807f162 in do_group_exit (exit_code=0) at kernel/exit.c:886
#22 0x0807f1c7 in SYSC_exit_group (error_code=<optimized out>) at kernel/exit.c:897
#23 SyS_exit_group (error_code=0) at kernel/exit.c:895
#24 0x08062990 in handle_syscall (r=0x84ec3530) at arch/um/kernel/skas/syscall.c:35
#25 0x0807473c in handle_trap (local_using_sysemu=<optimized out>, regs=<optimized out>, pid=<optimized out>) at arch/um/os-Linux/skas/process.c:193
#26 userspace (regs=0x84ec3530) at arch/um/os-Linux/skas/process.c:426
#27 0x0805f720 in fork_handler () at arch/um/kernel/process.c:149
#28 0x5a5a5a5a in ?? ()



Now the guests is completely unresponsive while I'm running this command :

trinity ~ # gdb trinity 3629 -batch -ex 'thread apply all bt'

--
Toralf
pgp key: 0076 E94E


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

