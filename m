Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3e5V-0004oP-86	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:17:01 -0700
Received: from mail-relay-3.tiscali.it ([213.205.33.43])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E3e5T-000197-EG
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:17:01 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050812182113.7A94F24E7D5@zion.home.lan>
Subject: [uml-devel] [patch 07/39] uml: fault handler micro-cleanups
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
Date: Fri, 12 Aug 2005 20:21:13 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Avoid chomping low bits of address for functions doing it by themselves, fix
whitespace, add a correctness checking.

I did this for remap-file-pages protection support, it was useful on its own
too.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/kernel/trap_kern.c |   28 +++++++++++--------------
 1 files changed, 13 insertions(+), 15 deletions(-)

diff -puN arch/um/kernel/trap_kern.c~uml-fault-handler-changes arch/um/kernel/trap_kern.c
--- linux-2.6.git/arch/um/kernel/trap_kern.c~uml-fault-handler-changes	2005-08-11 11:18:03.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/trap_kern.c	2005-08-11 11:19:56.000000000 +0200
@@ -26,6 +26,7 @@
 #include "mem.h"
 #include "mem_kern.h"
 
+/* Note this is constrained to return 0, -EFAULT, -EACCESS, -ENOMEM by segv(). */
 int handle_page_fault(unsigned long address, unsigned long ip, 
 		      int is_write, int is_user, int *code_out)
 {
@@ -35,7 +36,6 @@ int handle_page_fault(unsigned long addr
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
-	unsigned long page;
 	int err = -EFAULT;
 
 	*code_out = SEGV_MAPERR;
@@ -52,7 +52,7 @@ int handle_page_fault(unsigned long addr
 	else if(expand_stack(vma, address)) 
 		goto out;
 
- good_area:
+good_area:
 	*code_out = SEGV_ACCERR;
 	if(is_write && !(vma->vm_flags & VM_WRITE)) 
 		goto out;
@@ -60,9 +60,8 @@ int handle_page_fault(unsigned long addr
         if(!(vma->vm_flags & (VM_READ | VM_EXEC)))
                 goto out;
 
-	page = address & PAGE_MASK;
 	do {
- survive:
+survive:
 		switch (handle_mm_fault(mm, vma, address, is_write)){
 		case VM_FAULT_MINOR:
 			current->min_flt++;
@@ -79,16 +78,16 @@ int handle_page_fault(unsigned long addr
 		default:
 			BUG();
 		}
-		pgd = pgd_offset(mm, page);
-		pud = pud_offset(pgd, page);
-		pmd = pmd_offset(pud, page);
-		pte = pte_offset_kernel(pmd, page);
+		pgd = pgd_offset(mm, address);
+		pud = pud_offset(pgd, address);
+		pmd = pmd_offset(pud, address);
+		pte = pte_offset_kernel(pmd, address);
 	} while(!pte_present(*pte));
 	err = 0;
 	*pte = pte_mkyoung(*pte);
 	if(pte_write(*pte)) *pte = pte_mkdirty(*pte);
-	flush_tlb_page(vma, page);
- out:
+	flush_tlb_page(vma, address);
+out:
 	up_read(&mm->mmap_sem);
 	return(err);
 
@@ -144,19 +143,18 @@ unsigned long segv(struct faultinfo fi, 
 		panic("Kernel mode fault at addr 0x%lx, ip 0x%lx", 
 		      address, ip);
 
-	if(err == -EACCES){
+	if (err == -EACCES) {
 		si.si_signo = SIGBUS;
 		si.si_errno = 0;
 		si.si_code = BUS_ADRERR;
 		si.si_addr = (void *)address;
                 current->thread.arch.faultinfo = fi;
 		force_sig_info(SIGBUS, &si, current);
-	}
-	else if(err == -ENOMEM){
+	} else if (err == -ENOMEM) {
 		printk("VM: killing process %s\n", current->comm);
 		do_exit(SIGKILL);
-	}
-	else {
+	} else {
+		BUG_ON(err != -EFAULT);
 		si.si_signo = SIGSEGV;
 		si.si_addr = (void *) address;
                 current->thread.arch.faultinfo = fi;
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
