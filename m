Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3eaS-0006Xr-AM	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:49:00 -0700
Received: from mail-relay-4.tiscali.it ([213.205.33.44])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E3eaR-0007cu-Se
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:49:00 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050812183551.C296524E0A7@zion.home.lan>
Subject: [uml-devel] [patch 22/39] remap file pages protection support: use
	FAULT_SIGSEGV for protection checking, uml bits
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
Date: Fri, 12 Aug 2005 20:35:51 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

This adapts the changes to the i386 handler to the UML one. It isn't enough to
make UML work, however, because UML has some peculiarities. Subsequent patches
fix this.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/kernel/trap_kern.c |   32 +++++++++++++++++++++----
 1 files changed, 27 insertions(+), 5 deletions(-)

diff -puN arch/um/kernel/trap_kern.c~rfp-fault-sigsegv-2-uml arch/um/kernel/trap_kern.c
--- linux-2.6.git/arch/um/kernel/trap_kern.c~rfp-fault-sigsegv-2-uml	2005-08-11 23:09:32.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/trap_kern.c	2005-08-11 23:09:32.000000000 +0200
@@ -37,6 +37,7 @@ int handle_page_fault(unsigned long addr
 	pmd_t *pmd;
 	pte_t *pte;
 	int err = -EFAULT;
+	int access_mask = 0;
 
 	*code_out = SEGV_MAPERR;
 	down_read(&mm->mmap_sem);
@@ -55,14 +56,15 @@ int handle_page_fault(unsigned long addr
 good_area:
 	*code_out = SEGV_ACCERR;
 	if(is_write && !(vma->vm_flags & VM_WRITE)) 
-		goto out;
+		goto prot_bad;
 
         if(!(vma->vm_flags & (VM_READ | VM_EXEC)))
-                goto out;
+                goto prot_bad;
 
+	access_mask = is_write ? VM_WRITE : 0;
 	do {
-survive:
-		switch (handle_mm_fault(mm, vma, address, is_write)){
+handle_fault:
+		switch (__handle_mm_fault(mm, vma, address, access_mask)) {
 		case VM_FAULT_MINOR:
 			current->min_flt++;
 			break;
@@ -72,6 +74,9 @@ survive:
 		case VM_FAULT_SIGBUS:
 			err = -EACCES;
 			goto out;
+		case VM_FAULT_SIGSEGV:
+			err = -EFAULT;
+			goto out;
 		case VM_FAULT_OOM:
 			err = -ENOMEM;
 			goto out_of_memory;
@@ -87,10 +92,27 @@ survive:
 	*pte = pte_mkyoung(*pte);
 	if(pte_write(*pte)) *pte = pte_mkdirty(*pte);
 	flush_tlb_page(vma, address);
+
+	/* If the PTE is not present, the vma protection are not accurate if
+	 * VM_NONUNIFORM; present PTE's are correct for VM_NONUNIFORM and were
+	 * already handled otherwise. */
 out:
 	up_read(&mm->mmap_sem);
 	return(err);
 
+prot_bad:
+	if (unlikely(vma->vm_flags & VM_NONUNIFORM)) {
+		access_mask = is_write ? VM_WRITE : 0;
+		/* Otherwise, on a legitimate read fault on a page mapped as
+		 * exec-only, we get problems. Probably, we should lower
+		 * requirements... we should always test just
+		 * pte_read/write/exec, on vma->vm_page_prot! This way is
+		 * cumbersome. However, for now things should work for UML. */
+		access_mask |= vma->vm_flags & VM_EXEC ? VM_EXEC : VM_READ;
+		goto handle_fault;
+	}
+	goto out;
+	
 /*
  * We ran out of memory, or some other thing happened to us that made
  * us unable to handle the page fault gracefully.
@@ -100,7 +122,7 @@ out_of_memory:
 		up_read(&mm->mmap_sem);
 		yield();
 		down_read(&mm->mmap_sem);
-		goto survive;
+		goto handle_fault;
 	}
 	goto out;
 }
_


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
