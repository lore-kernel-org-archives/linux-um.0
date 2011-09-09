Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <oscar-uml-devel@hellstrom.st>) id 1R20YZ-0002VS-EL
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Sep 2011 12:51:43 +0000
Received: from mail.hellstrom.st ([65.110.43.110])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1R20YY-0005R7-Ju for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Sep 2011 12:51:43 +0000
Received: from secure.hellstrom.st (mail.hellstrom.st [65.110.43.110])
	by mail.hellstrom.st (Postfix) with ESMTP id EE5441CC055
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri,  9 Sep 2011 13:51:36 +0100 (BST)
MIME-Version: 1.0
Date: Fri, 09 Sep 2011 13:51:36 +0100
From: =?UTF-8?Q?Oscar_Hellstr=C3=B6m?= <oscar-uml-devel@hellstrom.st>
Message-ID: <dec050d06e01facf32a7f3b6184102c1@hellstrom.st>
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
Subject: [uml-devel] =?utf-8?q?Errors_in_schedule_/_=5Fswitch=5Fto?=
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

I'm running an older version of the kernel, 2.6.32.3, and I'm experiencing
segmentations faults in _switch_to, which is called from schedule. My
stacktrace looks like:
...
#13 <signal handler called>
#14 _switch_to (prev=0x43ff1340, next=0xffffffd4, last=0x43ff1340) at
arch/um/kernel/process.c:82
#15 0x08205cd9 in schedule () at kernel/sched.c:2886
#16 0x08205dda in io_schedule () at kernel/sched.c:6784
#17 0x0809af72 in sync_page (word=0x96ba180) at mm/filemap.c:187
#18 0x08205fde in __wait_on_bit_lock (wq=0x980b7d8, q=0x43fd5ce4,
action=0x809af37 <sync_page>, mode=2) at kernel/wait.c:229
#19 0x0809af21 in __lock_page (page=0x96ba180) at mm/filemap.c:601
#20 0x0809afbd in find_lock_page (mapping=0x47608668, offset=2596) at
include/linux/pagemap.h:317
#21 0x0809c888 in filemap_fault (vma=0x43d70764, vmf=0x43fd5d8c) at
mm/filemap.c:1538
#22 0x080a88ad in __do_fault (mm=0x478855e0, vma=0x43d70764,
address=2437412980, pmd=0x472c0914, pgoff=2596, flags=0, orig_pte={pte =
0}) at mm/memory.c:2719
#23 0x080a9fec in handle_mm_fault (mm=0x478855e0, vma=0x43d70764,
address=2437412980, flags=0) at mm/memory.c:2917
#24 0x0805c5f1 in handle_page_fault (address=2437412980, ip=1076410045,
is_write=0, is_user=1, code_out=0x43fd5e40) at arch/um/kernel/trap.c:71
#25 0x0805c729 in segv (fi={error_code = 4, cr2 = 2437412980, trap_no =
14}, ip=1076410045, is_user=1, regs=0x43ff1550) at
arch/um/kernel/trap.c:178
#26 0x0805c91e in segv_handler (sig=11, regs=0x43ff1550) at
arch/um/kernel/trap.c:150
#27 0x0806c00a in userspace (regs=0x43ff1550) at
arch/um/os-Linux/skas/process.c:421
#28 0x0805aa75 in fork_handler () at arch/um/kernel/process.c:179
#29 0x00000000 in ?? ()

I've compiled in a driver into the kernel which fakes interrupts by sending
signals to the UML process. I guess this could interfere with something,
but I do believe I've seen this without the signals being enabled.
Unfortunately I don't have any easy way to reproduce this, it happens
seemingly at random.

Any pointer to what this can be and where I can start looking would be
appreciated!

Thanks
/Oscar

------------------------------------------------------------------------------
Why Cloud-Based Security and Archiving Make Sense
Osterman Research conducted this study that outlines how and why cloud
computing security and archiving is rapidly being adopted across the IT 
space for its ease of implementation, lower cost, and increased 
reliability. Learn more. http://www.accelacomm.com/jaw/sfnl/114/51425301/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

