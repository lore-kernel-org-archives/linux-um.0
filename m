Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hc2EY-0002AZ-Ez for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Apr 2007 09:33:18 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hc2EX-0000fj-Ol
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Apr 2007 09:33:18 -0700
Date: Thu, 12 Apr 2007 12:28:05 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070412162805.GA7255@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [ PATCH 6/6 ] UML - Speed page fault path
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Give the page fault code a specialized path.  There is only one page
to look at, so there's no point in going into the general page table
walking code.  There's only going to be one host operation, so there
are no opportunities for merging.  So, we go straight to the pte we
want, figure out what needs doing, and do it.

While I was in here, I fixed the wart where the address passed to
unmap was a void *, but an unsigned long to map and protect.

This gives me just under 10% on a kernel build.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/include/os.h                  |    2 -
 arch/um/include/skas/mode_kern_skas.h |    2 +
 arch/um/kernel/skas/tlb.c             |   66 ++++++++++++++++++++++++++++++++--
 arch/um/kernel/tlb.c                  |    4 +-
 arch/um/os-Linux/skas/mem.c           |    4 +-
 5 files changed, 72 insertions(+), 6 deletions(-)

Index: linux-2.6.21-mm/arch/um/include/skas/mode_kern_skas.h
===================================================================
--- linux-2.6.21-mm.orig/arch/um/include/skas/mode_kern_skas.h	2007-04-12 11:34:40.000000000 -0400
+++ linux-2.6.21-mm/arch/um/include/skas/mode_kern_skas.h	2007-04-12 11:48:33.000000000 -0400
@@ -33,6 +33,8 @@ extern unsigned long set_task_sizes_skas
 extern int start_uml_skas(void);
 extern int external_pid_skas(struct task_struct *task);
 extern int thread_pid_skas(struct task_struct *task);
+extern void flush_tlb_page_skas(struct vm_area_struct *vma,
+				unsigned long address);
 
 #define kmem_end_skas (host_task_size - 1024 * 1024)
 
Index: linux-2.6.21-mm/arch/um/kernel/skas/tlb.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/skas/tlb.c	2007-04-12 11:34:40.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/skas/tlb.c	2007-04-12 11:48:33.000000000 -0400
@@ -32,8 +32,7 @@ static int do_ops(union mm_context *mmu,
 				  op->u.mmap.offset, finished, flush);
 			break;
 		case MUNMAP:
-			ret = unmap(&mmu->skas.id,
-				    (void *) op->u.munmap.addr,
+			ret = unmap(&mmu->skas.id, op->u.munmap.addr,
 				    op->u.munmap.len, finished, flush);
 			break;
 		case MPROTECT:
@@ -94,3 +93,66 @@ void force_flush_all_skas(void)
 	unsigned long end = proc_mm ? task_size : CONFIG_STUB_START;
         fix_range(current->mm, 0, end, 1);
 }
+
+void flush_tlb_page_skas(struct vm_area_struct *vma, unsigned long address)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+	struct mm_struct *mm = vma->vm_mm;
+	void *flush = NULL;
+	int r, w, x, err = 0;
+	struct mm_id *mm_id;
+
+	pgd = pgd_offset(vma->vm_mm, address);
+	if(!pgd_present(*pgd))
+		goto kill;
+
+	pud = pud_offset(pgd, address);
+	if(!pud_present(*pud))
+		goto kill;
+
+	pmd = pmd_offset(pud, address);
+	if(!pmd_present(*pmd))
+		goto kill;
+
+	pte = pte_offset_kernel(pmd, address);
+
+	r = pte_read(*pte);
+	w = pte_write(*pte);
+	x = pte_exec(*pte);
+	if (!pte_young(*pte)) {
+		r = 0;
+		w = 0;
+	} else if (!pte_dirty(*pte)) {
+		w = 0;
+	}
+
+	mm_id = &mm->context.skas.id;
+	if(pte_newpage(*pte)){
+		if(pte_present(*pte)){
+			unsigned long long offset;
+			int fd;
+
+			fd = phys_mapping(pte_val(*pte) & PAGE_MASK, &offset);
+			err = map(mm_id, address, PAGE_SIZE, r, w, x, fd,
+				  offset, 1, &flush);
+		}
+		else err = unmap(mm_id, address, PAGE_SIZE, 1, &flush);
+	}
+	else if(pte_newprot(*pte))
+		err = protect(mm_id, address, PAGE_SIZE, r, w, x, 1, &flush);
+
+	if(err)
+		goto kill;
+
+	*pte = pte_mkuptodate(*pte);
+
+	return;
+
+kill:
+	printk("Failed to flush page for address 0x%lx\n", address);
+	force_sig(SIGKILL, current);
+}
+
Index: linux-2.6.21-mm/arch/um/kernel/tlb.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/tlb.c	2007-04-12 11:46:27.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/tlb.c	2007-04-12 11:48:33.000000000 -0400
@@ -380,7 +380,9 @@ pte_t *addr_pte(struct task_struct *task
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
 {
 	address &= PAGE_MASK;
-	flush_tlb_range(vma, address, address + PAGE_SIZE);
+
+	CHOOSE_MODE(flush_tlb_range(vma, address, address + PAGE_SIZE),
+		    flush_tlb_page_skas(vma, address));
 }
 
 void flush_tlb_all(void)
Index: linux-2.6.21-mm/arch/um/include/os.h
===================================================================
--- linux-2.6.21-mm.orig/arch/um/include/os.h	2007-04-12 11:38:51.000000000 -0400
+++ linux-2.6.21-mm/arch/um/include/os.h	2007-04-12 11:48:33.000000000 -0400
@@ -302,7 +302,7 @@ extern long syscall_stub_data(struct mm_
 extern int map(struct mm_id * mm_idp, unsigned long virt,
 	       unsigned long len, int r, int w, int x, int phys_fd,
 	       unsigned long long offset, int done, void **data);
-extern int unmap(struct mm_id * mm_idp, void *addr, unsigned long len,
+extern int unmap(struct mm_id * mm_idp, unsigned long addr, unsigned long len,
 		 int done, void **data);
 extern int protect(struct mm_id * mm_idp, unsigned long addr,
 		   unsigned long len, int r, int w, int x, int done,
Index: linux-2.6.21-mm/arch/um/os-Linux/skas/mem.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/os-Linux/skas/mem.c	2007-04-12 11:34:40.000000000 -0400
+++ linux-2.6.21-mm/arch/um/os-Linux/skas/mem.c	2007-04-12 11:48:33.000000000 -0400
@@ -219,8 +219,8 @@ int map(struct mm_id * mm_idp, unsigned 
 	return ret;
 }
 
-int unmap(struct mm_id * mm_idp, void *addr, unsigned long len, int done,
-	  void **data)
+int unmap(struct mm_id * mm_idp, unsigned long addr, unsigned long len,
+	  int done, void **data)
 {
 	int ret;
 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
