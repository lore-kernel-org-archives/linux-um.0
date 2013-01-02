Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vegard.nossum@oracle.com>) id 1TqSFP-0008Pz-0L
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Jan 2013 17:36:59 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TqSFO-00079a-8M
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Jan 2013 17:36:58 +0000
Message-ID: <50E4702B.9050409@oracle.com>
Date: Wed, 02 Jan 2013 18:36:43 +0100
From: Vegard Nossum <vegard.nossum@oracle.com>
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
Subject: [uml-devel] [3.8.0-rc1-00091-g4a490b7] BUG: Bad page map
	(mapcount:-1)
To: user-mode-linux-devel@lists.sourceforge.net
Cc: davej@redhat.com

Hi,

A small program like this:

#include <stdio.h>
#include <sys/mman.h>

int main(int argc, char *argv[])
{
         mremap(0, 0xffffff, 1, 0, memalign(4096, 8192));
         return 0;
}

crashes my UML in this way:

BUG: Bad page map in process a.out  pte:0024b045 pmd:032301e1
page:00000000620cd068 count:1 mapcount:-1 mapping:          (null) index:0x0
page flags: 0x400(reserved)
addr:0000000000100000 vm_flags:00060055 anon_vma:          (null) 
mapping:          (null) index:100
vma->vm_ops->fault: special_mapping_fault+0x0/0x6d
Call Trace:
6320bbd8:  [<602472df>] print_bad_pte+0x229/0x249
6320bbf8:  [<6002ddc1>] do_syscall_stub+0x119/0x24b
6320bc38:  [<60096e7a>] unmap_single_vma+0x356/0x529
6320bce8:  [<60096b24>] unmap_single_vma+0x0/0x529
6320bcf8:  [<60097601>] unmap_vmas+0x39/0x54
6320bd38:  [<6009b1ac>] unmap_region+0xa1/0xfc
6320bd80:  [<60016f80>] _init+0x4a0/0x8b0
6320bdb8:  [<6009cb55>] do_munmap+0x25e/0x2fe
6320be18:  [<6009f4b6>] sys_mremap+0x25d/0x447
6320be70:  [<60016f80>] _init+0x4a0/0x8b0
6320be88:  [<6001bab1>] handle_syscall+0x65/0x7c
6320bea8:  [<6002ee7c>] userspace+0x408/0x57a
6320bf78:  [<6002ac27>] save_registers+0x1f/0x39
6320bf88:  [<6003120f>] arch_prctl+0xfb/0x171
6320bfd8:  [<60018909>] fork_handler+0x85/0x87

It was found using trinity (syscall fuzzer).


Vegard

------------------------------------------------------------------------------
Master Java SE, Java EE, Eclipse, Spring, Hibernate, JavaScript, jQuery
and much more. Keep your Java skills current with LearnJavaNow -
200+ hours of step-by-step video tutorials by Java experts.
SALE $49.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122612 
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

