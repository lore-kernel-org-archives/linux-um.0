Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9Asd-0000oh-Gq for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 15:46:19 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D9Asc-0006yd-J6 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 15:46:19 -0800
Message-Id: <200503100216.j2A2GrDN015259@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 9/9] UML - Fix rounding bug in tlb flushing
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
Date: Wed, 09 Mar 2005 21:16:53 -0500
To: torvalds@osdl.org
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

fix_range_common and flush_tlb_kernel_range_common don't work correctly,
if a PGD (or PUD or PMD) is not present and start_addr (resp. start) is not
aligned to a PGD boundary (or PUD or PMD boundary).

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/kernel/tlb.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/tlb.c	2005-03-08 23:46:28.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/tlb.c	2005-03-09 00:03:30.000000000 -0500
@@ -15,6 +15,8 @@
 #include "mem_user.h"
 #include "os.h"
 
+#define ADD_ROUND(n, inc) (((n) + (inc)) & ~((inc) - 1))
+
 void fix_range_common(struct mm_struct *mm, unsigned long start_addr,
                       unsigned long end_addr, int force, int data,
                       void (*do_ops)(int, struct host_vm_op *, int))
@@ -33,46 +35,46 @@
         for(addr = start_addr; addr < end_addr;){
                 npgd = pgd_offset(mm, addr);
                 if(!pgd_present(*npgd)){
+                        end = ADD_ROUND(addr, PGDIR_SIZE);
+                        if(end > end_addr)
+                                end = end_addr;
                         if(force || pgd_newpage(*npgd)){
-                                end = addr + PGDIR_SIZE;
-                                if(end > end_addr)
-                                        end = end_addr;
                                 op_index = add_munmap(addr, end - addr, ops, 
                                                       op_index, last_op, data,
                                                       do_ops);
                                 pgd_mkuptodate(*npgd);
                         }
-                        addr += PGDIR_SIZE;
+                        addr = end;
                         continue;
                 }
 
                 npud = pud_offset(npgd, addr);
                 if(!pud_present(*npud)){
+                        end = ADD_ROUND(addr, PUD_SIZE);
+                        if(end > end_addr)
+                                end = end_addr;
                         if(force || pud_newpage(*npud)){
-                                end = addr + PUD_SIZE;
-                                if(end > end_addr)
-                                        end = end_addr;
                                 op_index = add_munmap(addr, end - addr, ops, 
                                                       op_index, last_op, data,
                                                       do_ops);
                                 pud_mkuptodate(*npud);
                         }
-                        addr += PUD_SIZE;
+                        addr = end;
                         continue;
                 }
 
                 npmd = pmd_offset(npud, addr);
                 if(!pmd_present(*npmd)){
+                        end = ADD_ROUND(addr, PMD_SIZE);
+                        if(end > end_addr)
+                                end = end_addr;
                         if(force || pmd_newpage(*npmd)){
-                                end = addr + PMD_SIZE;
-                                if(end > end_addr)
-                                        end = end_addr;
                                 op_index = add_munmap(addr, end - addr, ops, 
                                                       op_index, last_op, data,
                                                       do_ops);
                                 pmd_mkuptodate(*npmd);
                         }
-                        addr += PMD_SIZE;
+                        addr = end;
                         continue;
                 }
 
@@ -122,52 +124,52 @@
         for(addr = start; addr < end;){
                 pgd = pgd_offset(mm, addr);
                 if(!pgd_present(*pgd)){
+                        last = ADD_ROUND(addr, PGDIR_SIZE);
+                        if(last > end)
+                                last = end;
                         if(pgd_newpage(*pgd)){
                                 updated = 1;
-                                last = addr + PGDIR_SIZE;
-                                if(last > end)
-                                        last = end;
                                 err = os_unmap_memory((void *) addr, 
                                                       last - addr);
                                 if(err < 0)
                                         panic("munmap failed, errno = %d\n",
                                               -err);
                         }
-                        addr += PGDIR_SIZE;
+                        addr = last;
                         continue;
                 }
 
                 pud = pud_offset(pgd, addr);
                 if(!pud_present(*pud)){
+                        last = ADD_ROUND(addr, PUD_SIZE);
+                        if(last > end)
+                                last = end;
                         if(pud_newpage(*pud)){
                                 updated = 1;
-                                last = addr + PUD_SIZE;
-                                if(last > end)
-                                        last = end;
                                 err = os_unmap_memory((void *) addr,
                                                       last - addr);
                                 if(err < 0)
                                         panic("munmap failed, errno = %d\n",
                                               -err);
                         }
-                        addr += PUD_SIZE;
+                        addr = last;
                         continue;
                 }
 
                 pmd = pmd_offset(pud, addr);
                 if(!pmd_present(*pmd)){
+                        last = ADD_ROUND(addr, PMD_SIZE);
+                        if(last > end)
+                                last = end;
                         if(pmd_newpage(*pmd)){
                                 updated = 1;
-                                last = addr + PMD_SIZE;
-                                if(last > end)
-                                        last = end;
                                 err = os_unmap_memory((void *) addr,
                                                       last - addr);
                                 if(err < 0)
                                         panic("munmap failed, errno = %d\n",
                                               -err);
                         }
-                        addr += PMD_SIZE;
+                        addr = last;
                         continue;
                 }
 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
