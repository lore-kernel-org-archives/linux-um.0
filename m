Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dywbk-0002hd-EX	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Jul 2005 12:02:52 -0700
Received: from mail-relay-3.tiscali.it ([213.205.33.43])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1Dywbj-00076E-Ud
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Jul 2005 12:02:52 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050730190546.810CA1AEA4@zion.home.lan>
Subject: [uml-devel] [patch 1/1] uml: avoid fixing faults while atomic
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
Date: Sat, 30 Jul 2005 21:05:46 +0200
To: jdike@addtoit.com
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Following i386, we should maybe refuse trying to fault in pages when we're
doing atomic operations, because to handle the fault we could need to take
already taken spinlocks.

Also, if we're doing an atomic operation (in the sense of in_atomic()) we're
surely in kernel mode and we're surely going to handle adequately the failed
fault, so it's safe to behave this way.

Currently, on UML SMP is rarely used, and we don't support PREEMPT, so this is
unlikely to create problems right now, but it might in the future.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/kernel/trap_kern.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff -puN arch/um/kernel/trap_kern.c~uml-avoid-faults-while-atomic arch/um/kernel/trap_kern.c
--- linux-2.6.git/arch/um/kernel/trap_kern.c~uml-avoid-faults-while-atomic	2005-07-30 17:04:10.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/trap_kern.c	2005-07-30 17:04:10.000000000 +0200
@@ -39,6 +39,10 @@ int handle_page_fault(unsigned long addr
 	int err = -EFAULT;
 
 	*code_out = SEGV_MAPERR;
+
+	if (in_atomic()) //If the fault was during atomic operation, don't take the fault.
+		goto out_nosemaphore;
+
 	down_read(&mm->mmap_sem);
 	vma = find_vma(mm, address);
 	if(!vma) 
@@ -52,7 +56,7 @@ int handle_page_fault(unsigned long addr
 	else if(expand_stack(vma, address)) 
 		goto out;
 
- good_area:
+good_area:
 	*code_out = SEGV_ACCERR;
 	if(is_write && !(vma->vm_flags & VM_WRITE)) 
 		goto out;
@@ -62,7 +66,7 @@ int handle_page_fault(unsigned long addr
 
 	page = address & PAGE_MASK;
 	do {
- survive:
+survive:
 		switch (handle_mm_fault(mm, vma, address, is_write)){
 		case VM_FAULT_MINOR:
 			current->min_flt++;
@@ -88,8 +92,9 @@ int handle_page_fault(unsigned long addr
 	*pte = pte_mkyoung(*pte);
 	if(pte_write(*pte)) *pte = pte_mkdirty(*pte);
 	flush_tlb_page(vma, page);
- out:
+out:
 	up_read(&mm->mmap_sem);
+out_nosemaphore:
 	return(err);
 
 /*
_


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
