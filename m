Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1ofT-0005pW-Dr for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Feb 2005 08:38:19 -0800
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D1ofQ-00061b-HE for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Feb 2005 08:38:19 -0800
Message-Id: <200502171638.j1HGc3h16087@trolli.pdb.fsc.net>
From: bstroesser@fujitsu-siemens.com
Subject: [uml-devel] [patch 1/1] UML: make fix_range_common and
	flush_tlb_kernel_range_common work correctly
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
Date: Thu, 17 Feb 2005 17:37:50 +0100
To: jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net, bstroesser@fujitsu-siemens.com


From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

fix_range_common and flush_tlb_kernel_range_common don't work correctly,
if a PGD (or PUD or PMD) is not present and start_addr (resp. start) is not
aligned to a PGD boundary (or PUD or PMD boundary).

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
---


diff -puN arch/um/kernel/tlb.c~fix_range_common arch/um/kernel/tlb.c
--- linux-2.6.11-rc3-mm2/arch/um/kernel/tlb.c~fix_range_common	2005-02-17 17:07:06.000000000 +0100
+++ linux-2.6.11-rc3-mm2-root/arch/um/kernel/tlb.c	2005-02-17 17:23:19.000000000 +0100
@@ -170,46 +170,46 @@ void fix_range_common(struct mm_struct *
 	for(addr = start_addr; addr < end_addr;){
 		npgd = pgd_offset(mm, addr);
 		if(!pgd_present(*npgd)){
+			end = (addr + PGDIR_SIZE) & ~(PGDIR_SIZE - 1);
+			if(end > end_addr)
+				end = end_addr;
 			if(force || pgd_newpage(*npgd)){
-				end = addr + PGDIR_SIZE;
-				if(end > end_addr)
-					end = end_addr;
 				op_index = add_munmap(addr, end - addr, ops, 
 						      op_index, last_op, mmu,
 						      &flush, do_ops);
 				pgd_mkuptodate(*npgd);
 			}
-			addr += PGDIR_SIZE;
+			addr = end;
 			continue;
 		}
 
 		npud = pud_offset(npgd, addr);
 		if(!pud_present(*npud)){
+			end = (addr + PUD_SIZE) & ~(PUD_SIZE - 1);
+			if(end > end_addr)
+				end = end_addr;
 			if(force || pud_newpage(*npud)){
-				end = addr + PUD_SIZE;
-				if(end > end_addr)
-					end = end_addr;
 				op_index = add_munmap(addr, end - addr, ops, 
 						      op_index, last_op, mmu,
 						      &flush, do_ops);
 				pud_mkuptodate(*npud);
 			}
-			addr += PUD_SIZE;
+			addr = end;
 			continue;
 		}
 
 		npmd = pmd_offset(npud, addr);
 		if(!pmd_present(*npmd)){
+			end = (addr + PMD_SIZE) & ~(PMD_SIZE - 1);
+			if(end > end_addr)
+				end = end_addr;
 			if(force || pmd_newpage(*npmd)){
-				end = addr + PMD_SIZE;
-				if(end > end_addr)
-					end = end_addr;
 				op_index = add_munmap(addr, end - addr, ops, 
 						      op_index, last_op, mmu,
 						      &flush, do_ops);
 				pmd_mkuptodate(*npmd);
 			}
-			addr += PMD_SIZE;
+			addr = end;
 			continue;
 		}
 
@@ -259,52 +259,52 @@ int flush_tlb_kernel_range_common(unsign
 	for(addr = start; addr < end;){
 		pgd = pgd_offset(mm, addr);
  		if(!pgd_present(*pgd)){
+ 			last = (addr + PGDIR_SIZE) & ~(PGDIR_SIZE - 1);
+ 			if(last > end)
+ 				last = end;
  			if(pgd_newpage(*pgd)){
 				updated = 1;
- 				last = addr + PGDIR_SIZE;
- 				if(last > end)
- 					last = end;
 				err = os_unmap_memory((void *) addr, 
 						      last - addr);
 				if(err < 0)
 					panic("munmap failed, errno = %d\n",
 					      -err);
 			}
-			addr += PGDIR_SIZE;
+			addr = last;
 			continue;
 		}
 
 		pud = pud_offset(pgd, addr);
 		if(!pud_present(*pud)){
+ 			last = (addr + PUD_SIZE) & ~(PUD_SIZE - 1);
+ 			if(last > end)
+ 				last = end;
 			if(pud_newpage(*pud)){
 				updated = 1;
-				last = addr + PUD_SIZE;
-				if(last > end)
-					last = end;
 				err = os_unmap_memory((void *) addr,
 						      last - addr);
 				if(err < 0)
 					panic("munmap failed, errno = %d\n",
 					      -err);
 			}
-			addr += PUD_SIZE;
+			addr = last;
 			continue;
 		}
 
 		pmd = pmd_offset(pud, addr);
 		if(!pmd_present(*pmd)){
+ 			last = (addr + PMD_SIZE) & ~(PMD_SIZE - 1);
+ 			if(last > end)
+ 				last = end;
 			if(pmd_newpage(*pmd)){
 				updated = 1;
-				last = addr + PMD_SIZE;
-				if(last > end)
-					last = end;
 				err = os_unmap_memory((void *) addr,
 						      last - addr);
 				if(err < 0)
 					panic("munmap failed, errno = %d\n",
 					      -err);
 			}
-			addr += PMD_SIZE;
+			addr = last;
 			continue;
 		}
 
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
