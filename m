Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G6Igb-0005g1-Jo for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Jul 2006 20:06:50 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G6IgT-00033D-C7
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Jul 2006 20:06:45 -0700
Message-Id: <200607280306.k6S36QuJ007941@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Thu, 27 Jul 2006 23:06:26 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 5/7] UML - Whitespace fixes
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
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

arch/um/kernel/tlb.c had some pretty serious whitespace problems.  I
also fixed some returns.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-rc2-mm1/arch/um/kernel/tlb.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/um/kernel/tlb.c	2006-07-27 15:52:15.000000000 -0400
+++ linux-2.6.18-rc2-mm1/arch/um/kernel/tlb.c	2006-07-27 22:35:46.000000000 -0400
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
  * Licensed under the GPL
  */
@@ -16,12 +16,12 @@
 #include "os.h"
 
 static int add_mmap(unsigned long virt, unsigned long phys, unsigned long len,
- 		    int r, int w, int x, struct host_vm_op *ops, int *index,
+		    int r, int w, int x, struct host_vm_op *ops, int *index,
 		    int last_filled, union mm_context *mmu, void **flush,
 		    int (*do_ops)(union mm_context *, struct host_vm_op *,
 				  int, int, void **))
 {
-        __u64 offset;
+	__u64 offset;
 	struct host_vm_op *last;
 	int fd, ret = 0;
 
@@ -89,7 +89,7 @@ static int add_munmap(unsigned long addr
 static int add_mprotect(unsigned long addr, unsigned long len, int r, int w,
 			int x, struct host_vm_op *ops, int *index,
 			int last_filled, union mm_context *mmu, void **flush,
- 			int (*do_ops)(union mm_context *, struct host_vm_op *,
+			int (*do_ops)(union mm_context *, struct host_vm_op *,
 				      int, int, void **))
 {
 	struct host_vm_op *last;
@@ -124,106 +124,105 @@ static int add_mprotect(unsigned long ad
 #define ADD_ROUND(n, inc) (((n) + (inc)) & ~((inc) - 1))
 
 void fix_range_common(struct mm_struct *mm, unsigned long start_addr,
-                      unsigned long end_addr, int force,
+		      unsigned long end_addr, int force,
 		      int (*do_ops)(union mm_context *, struct host_vm_op *,
 				    int, int, void **))
 {
-        pgd_t *npgd;
-        pud_t *npud;
-        pmd_t *npmd;
-        pte_t *npte;
-        union mm_context *mmu = &mm->context;
-        unsigned long addr, end;
-        int r, w, x;
-        struct host_vm_op ops[1];
-        void *flush = NULL;
-        int op_index = -1, last_op = ARRAY_SIZE(ops) - 1;
-        int ret = 0;
+	pgd_t *npgd;
+	pud_t *npud;
+	pmd_t *npmd;
+	pte_t *npte;
+	union mm_context *mmu = &mm->context;
+	unsigned long addr, end;
+	int r, w, x;
+	struct host_vm_op ops[1];
+	void *flush = NULL;
+	int op_index = -1, last_op = ARRAY_SIZE(ops) - 1;
+	int ret = 0;
 
-        if(mm == NULL)
+	if(mm == NULL)
 		return;
 
-        ops[0].type = NONE;
-        for(addr = start_addr; addr < end_addr && !ret;){
-                npgd = pgd_offset(mm, addr);
-                if(!pgd_present(*npgd)){
-                        end = ADD_ROUND(addr, PGDIR_SIZE);
-                        if(end > end_addr)
-                                end = end_addr;
-                        if(force || pgd_newpage(*npgd)){
-                                ret = add_munmap(addr, end - addr, ops,
-                                                 &op_index, last_op, mmu,
-                                                 &flush, do_ops);
-                                pgd_mkuptodate(*npgd);
-                        }
-                        addr = end;
-                        continue;
-                }
-
-                npud = pud_offset(npgd, addr);
-                if(!pud_present(*npud)){
-                        end = ADD_ROUND(addr, PUD_SIZE);
-                        if(end > end_addr)
-                                end = end_addr;
-                        if(force || pud_newpage(*npud)){
-                                ret = add_munmap(addr, end - addr, ops,
-                                                 &op_index, last_op, mmu,
-                                                 &flush, do_ops);
-                                pud_mkuptodate(*npud);
-                        }
-                        addr = end;
-                        continue;
-                }
-
-                npmd = pmd_offset(npud, addr);
-                if(!pmd_present(*npmd)){
-                        end = ADD_ROUND(addr, PMD_SIZE);
-                        if(end > end_addr)
-                                end = end_addr;
-                        if(force || pmd_newpage(*npmd)){
-                                ret = add_munmap(addr, end - addr, ops,
-                                                 &op_index, last_op, mmu,
-                                                 &flush, do_ops);
-                                pmd_mkuptodate(*npmd);
-                        }
-                        addr = end;
-                        continue;
-                }
-
-                npte = pte_offset_kernel(npmd, addr);
-                r = pte_read(*npte);
-                w = pte_write(*npte);
-                x = pte_exec(*npte);
+	ops[0].type = NONE;
+	for(addr = start_addr; addr < end_addr && !ret;){
+		npgd = pgd_offset(mm, addr);
+		if(!pgd_present(*npgd)){
+			end = ADD_ROUND(addr, PGDIR_SIZE);
+			if(end > end_addr)
+				end = end_addr;
+			if(force || pgd_newpage(*npgd)){
+				ret = add_munmap(addr, end - addr, ops,
+						 &op_index, last_op, mmu,
+						 &flush, do_ops);
+				pgd_mkuptodate(*npgd);
+			}
+			addr = end;
+			continue;
+		}
+
+		npud = pud_offset(npgd, addr);
+		if(!pud_present(*npud)){
+			end = ADD_ROUND(addr, PUD_SIZE);
+			if(end > end_addr)
+				end = end_addr;
+			if(force || pud_newpage(*npud)){
+				ret = add_munmap(addr, end - addr, ops,
+						 &op_index, last_op, mmu,
+						 &flush, do_ops);
+				pud_mkuptodate(*npud);
+			}
+			addr = end;
+			continue;
+		}
+
+		npmd = pmd_offset(npud, addr);
+		if(!pmd_present(*npmd)){
+			end = ADD_ROUND(addr, PMD_SIZE);
+			if(end > end_addr)
+				end = end_addr;
+			if(force || pmd_newpage(*npmd)){
+				ret = add_munmap(addr, end - addr, ops,
+						 &op_index, last_op, mmu,
+						 &flush, do_ops);
+				pmd_mkuptodate(*npmd);
+			}
+			addr = end;
+			continue;
+		}
+
+		npte = pte_offset_kernel(npmd, addr);
+		r = pte_read(*npte);
+		w = pte_write(*npte);
+		x = pte_exec(*npte);
 		if (!pte_young(*npte)) {
 			r = 0;
 			w = 0;
 		} else if (!pte_dirty(*npte)) {
 			w = 0;
 		}
-                if(force || pte_newpage(*npte)){
-                        if(pte_present(*npte))
-			  ret = add_mmap(addr,
-					 pte_val(*npte) & PAGE_MASK,
-					 PAGE_SIZE, r, w, x, ops,
-					 &op_index, last_op, mmu,
-					 &flush, do_ops);
+		if(force || pte_newpage(*npte)){
+			if(pte_present(*npte))
+				ret = add_mmap(addr,
+					       pte_val(*npte) & PAGE_MASK,
+					       PAGE_SIZE, r, w, x, ops,
+					       &op_index, last_op, mmu,
+					       &flush, do_ops);
 			else ret = add_munmap(addr, PAGE_SIZE, ops,
 					      &op_index, last_op, mmu,
 					      &flush, do_ops);
-                }
-                else if(pte_newprot(*npte))
+		}
+		else if(pte_newprot(*npte))
 			ret = add_mprotect(addr, PAGE_SIZE, r, w, x, ops,
 					   &op_index, last_op, mmu,
 					   &flush, do_ops);
 
-                *npte = pte_mkuptodate(*npte);
-                addr += PAGE_SIZE;
-        }
-
+		*npte = pte_mkuptodate(*npte);
+		addr += PAGE_SIZE;
+	}
 	if(!ret)
 		ret = (*do_ops)(mmu, ops, op_index, 1, &flush);
 
-	/* This is not an else because ret is modified above */
+/* This is not an else because ret is modified above */
 	if(ret) {
 		printk("fix_range_common: failed, killing current process\n");
 		force_sig(SIGKILL, current);
@@ -232,160 +231,160 @@ void fix_range_common(struct mm_struct *
 
 int flush_tlb_kernel_range_common(unsigned long start, unsigned long end)
 {
-        struct mm_struct *mm;
-        pgd_t *pgd;
-        pud_t *pud;
-        pmd_t *pmd;
-        pte_t *pte;
-        unsigned long addr, last;
-        int updated = 0, err;
-
-        mm = &init_mm;
-        for(addr = start; addr < end;){
-                pgd = pgd_offset(mm, addr);
-                if(!pgd_present(*pgd)){
-                        last = ADD_ROUND(addr, PGDIR_SIZE);
-                        if(last > end)
-                                last = end;
-                        if(pgd_newpage(*pgd)){
-                                updated = 1;
-                                err = os_unmap_memory((void *) addr,
-                                                      last - addr);
-                                if(err < 0)
-                                        panic("munmap failed, errno = %d\n",
-                                              -err);
-                        }
-                        addr = last;
-                        continue;
-                }
-
-                pud = pud_offset(pgd, addr);
-                if(!pud_present(*pud)){
-                        last = ADD_ROUND(addr, PUD_SIZE);
-                        if(last > end)
-                                last = end;
-                        if(pud_newpage(*pud)){
-                                updated = 1;
-                                err = os_unmap_memory((void *) addr,
-                                                      last - addr);
-                                if(err < 0)
-                                        panic("munmap failed, errno = %d\n",
-                                              -err);
-                        }
-                        addr = last;
-                        continue;
-                }
-
-                pmd = pmd_offset(pud, addr);
-                if(!pmd_present(*pmd)){
-                        last = ADD_ROUND(addr, PMD_SIZE);
-                        if(last > end)
-                                last = end;
-                        if(pmd_newpage(*pmd)){
-                                updated = 1;
-                                err = os_unmap_memory((void *) addr,
-                                                      last - addr);
-                                if(err < 0)
-                                        panic("munmap failed, errno = %d\n",
-                                              -err);
-                        }
-                        addr = last;
-                        continue;
-                }
-
-                pte = pte_offset_kernel(pmd, addr);
-                if(!pte_present(*pte) || pte_newpage(*pte)){
-                        updated = 1;
-                        err = os_unmap_memory((void *) addr,
-                                              PAGE_SIZE);
-                        if(err < 0)
-                                panic("munmap failed, errno = %d\n",
-                                      -err);
-                        if(pte_present(*pte))
-                                map_memory(addr,
-                                           pte_val(*pte) & PAGE_MASK,
-                                           PAGE_SIZE, 1, 1, 1);
-                }
-                else if(pte_newprot(*pte)){
-                        updated = 1;
-                        os_protect_memory((void *) addr, PAGE_SIZE, 1, 1, 1);
-                }
-                addr += PAGE_SIZE;
-        }
-        return(updated);
+	struct mm_struct *mm;
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+	unsigned long addr, last;
+	int updated = 0, err;
+
+	mm = &init_mm;
+	for(addr = start; addr < end;){
+		pgd = pgd_offset(mm, addr);
+		if(!pgd_present(*pgd)){
+			last = ADD_ROUND(addr, PGDIR_SIZE);
+			if(last > end)
+				last = end;
+			if(pgd_newpage(*pgd)){
+				updated = 1;
+				err = os_unmap_memory((void *) addr,
+						      last - addr);
+				if(err < 0)
+					panic("munmap failed, errno = %d\n",
+					      -err);
+			}
+			addr = last;
+			continue;
+		}
+
+		pud = pud_offset(pgd, addr);
+		if(!pud_present(*pud)){
+			last = ADD_ROUND(addr, PUD_SIZE);
+			if(last > end)
+				last = end;
+			if(pud_newpage(*pud)){
+				updated = 1;
+				err = os_unmap_memory((void *) addr,
+						      last - addr);
+				if(err < 0)
+					panic("munmap failed, errno = %d\n",
+					      -err);
+			}
+			addr = last;
+			continue;
+		}
+
+		pmd = pmd_offset(pud, addr);
+		if(!pmd_present(*pmd)){
+			last = ADD_ROUND(addr, PMD_SIZE);
+			if(last > end)
+				last = end;
+			if(pmd_newpage(*pmd)){
+				updated = 1;
+				err = os_unmap_memory((void *) addr,
+						      last - addr);
+				if(err < 0)
+					panic("munmap failed, errno = %d\n",
+					      -err);
+			}
+			addr = last;
+			continue;
+		}
+
+		pte = pte_offset_kernel(pmd, addr);
+		if(!pte_present(*pte) || pte_newpage(*pte)){
+			updated = 1;
+			err = os_unmap_memory((void *) addr,
+					      PAGE_SIZE);
+			if(err < 0)
+				panic("munmap failed, errno = %d\n",
+				      -err);
+			if(pte_present(*pte))
+				map_memory(addr,
+					   pte_val(*pte) & PAGE_MASK,
+					   PAGE_SIZE, 1, 1, 1);
+		}
+		else if(pte_newprot(*pte)){
+			updated = 1;
+			os_protect_memory((void *) addr, PAGE_SIZE, 1, 1, 1);
+		}
+		addr += PAGE_SIZE;
+	}
+	return(updated);
 }
 
 pgd_t *pgd_offset_proc(struct mm_struct *mm, unsigned long address)
 {
-        return(pgd_offset(mm, address));
+	return(pgd_offset(mm, address));
 }
 
 pud_t *pud_offset_proc(pgd_t *pgd, unsigned long address)
 {
-        return(pud_offset(pgd, address));
+	return(pud_offset(pgd, address));
 }
 
 pmd_t *pmd_offset_proc(pud_t *pud, unsigned long address)
 {
-        return(pmd_offset(pud, address));
+	return(pmd_offset(pud, address));
 }
 
 pte_t *pte_offset_proc(pmd_t *pmd, unsigned long address)
 {
-        return(pte_offset_kernel(pmd, address));
+	return(pte_offset_kernel(pmd, address));
 }
 
 pte_t *addr_pte(struct task_struct *task, unsigned long addr)
 {
-        pgd_t *pgd = pgd_offset(task->mm, addr);
-        pud_t *pud = pud_offset(pgd, addr);
-        pmd_t *pmd = pmd_offset(pud, addr);
+	pgd_t *pgd = pgd_offset(task->mm, addr);
+	pud_t *pud = pud_offset(pgd, addr);
+	pmd_t *pmd = pmd_offset(pud, addr);
 
-        return(pte_offset_map(pmd, addr));
+	return(pte_offset_map(pmd, addr));
 }
 
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
 {
-        address &= PAGE_MASK;
-        flush_tlb_range(vma, address, address + PAGE_SIZE);
+	address &= PAGE_MASK;
+	flush_tlb_range(vma, address, address + PAGE_SIZE);
 }
 
 void flush_tlb_all(void)
 {
-        flush_tlb_mm(current->mm);
+	flush_tlb_mm(current->mm);
 }
 
 void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
-        CHOOSE_MODE_PROC(flush_tlb_kernel_range_tt,
-                         flush_tlb_kernel_range_common, start, end);
+	CHOOSE_MODE_PROC(flush_tlb_kernel_range_tt,
+			 flush_tlb_kernel_range_common, start, end);
 }
 
 void flush_tlb_kernel_vm(void)
 {
-        CHOOSE_MODE(flush_tlb_kernel_vm_tt(),
-                    flush_tlb_kernel_range_common(start_vm, end_vm));
+	CHOOSE_MODE(flush_tlb_kernel_vm_tt(),
+		    flush_tlb_kernel_range_common(start_vm, end_vm));
 }
 
 void __flush_tlb_one(unsigned long addr)
 {
-        CHOOSE_MODE_PROC(__flush_tlb_one_tt, __flush_tlb_one_skas, addr);
+	CHOOSE_MODE_PROC(__flush_tlb_one_tt, __flush_tlb_one_skas, addr);
 }
 
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		     unsigned long end)
 {
-        CHOOSE_MODE_PROC(flush_tlb_range_tt, flush_tlb_range_skas, vma, start,
-                         end);
+	CHOOSE_MODE_PROC(flush_tlb_range_tt, flush_tlb_range_skas, vma, start,
+			 end);
 }
 
 void flush_tlb_mm(struct mm_struct *mm)
 {
-        CHOOSE_MODE_PROC(flush_tlb_mm_tt, flush_tlb_mm_skas, mm);
+	CHOOSE_MODE_PROC(flush_tlb_mm_tt, flush_tlb_mm_skas, mm);
 }
 
 void force_flush_all(void)
 {
-        CHOOSE_MODE(force_flush_all_tt(), force_flush_all_skas());
+	CHOOSE_MODE(force_flush_all_tt(), force_flush_all_skas());
 }
 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
