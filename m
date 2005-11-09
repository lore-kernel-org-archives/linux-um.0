Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZtII-0006gt-M4 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Nov 2005 08:59:30 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EZtIG-0008Ld-62
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Nov 2005 08:59:30 -0800
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20051109175208.GA6645@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] Fix for skas-hold-own-ldt
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
Date: Wed, 9 Nov 2005 12:52:08 -0500
To: Allan Graves <allan.graves@oracle.com>, user-mode-linux-devel@lists.sourceforge.net

The patch in $SUBJECT had an anonymous union in it, which makes it not
compilable in all versions of gcc.  The patch below gives the union a
name and should make it compile everywhere.

This also cleans up the ldt.h symlink mess.

				Jeff

Index: linux-2.6.14/arch/um/Makefile
===================================================================
--- linux-2.6.14.orig/arch/um/Makefile	2005-11-02 14:35:35.000000000 -0500
+++ linux-2.6.14/arch/um/Makefile	2005-11-02 15:01:58.000000000 -0500
@@ -17,7 +17,7 @@ core-y			+= $(ARCH_DIR)/kernel/		\
 
 # Have to precede the include because the included Makefiles reference them.
 SYMLINK_HEADERS := archparam.h system.h sigcontext.h processor.h ptrace.h \
-	module.h vm-flags.h elf.h
+	module.h vm-flags.h elf.h ldt.h
 SYMLINK_HEADERS := $(foreach header,$(SYMLINK_HEADERS),include/asm-um/$(header))
 
 # XXX: The "os" symlink is only used by arch/um/include/os.h, which includes
Index: linux-2.6.14/arch/um/sys-i386/ldt.c
===================================================================
--- linux-2.6.14.orig/arch/um/sys-i386/ldt.c	2005-11-02 14:35:34.000000000 -0500
+++ linux-2.6.14/arch/um/sys-i386/ldt.c	2005-11-02 15:05:00.000000000 -0500
@@ -228,7 +228,7 @@ static int read_ldt(void __user * ptr, u
 		size = LDT_ENTRY_SIZE*LDT_DIRECT_ENTRIES;
 		if(size > bytecount)
 			size = bytecount;
-		if(copy_to_user(ptr, ldt->entries, size))
+		if(copy_to_user(ptr, ldt->u.entries, size))
 			err = -EFAULT;
 		bytecount -= size;
 		ptr += size;
@@ -239,7 +239,7 @@ static int read_ldt(void __user * ptr, u
 			size = PAGE_SIZE;
 			if(size > bytecount)
 				size = bytecount;
-			if(copy_to_user(ptr, ldt->pages[i], size)){
+			if(copy_to_user(ptr, ldt->u.pages[i], size)){
 				err = -EFAULT;
 				break;
 			}
@@ -321,10 +321,11 @@ static int write_ldt(void __user * ptr, 
 		    i*LDT_ENTRIES_PER_PAGE <= ldt_info.entry_number;
 		    i++){
 			if(i == 0)
-				memcpy(&entry0, ldt->entries, sizeof(entry0));
-			ldt->pages[i] = (struct ldt_entry *)
-					__get_free_page(GFP_KERNEL|__GFP_ZERO);
-			if(!ldt->pages[i]){
+				memcpy(&entry0, ldt->u.entries, 
+				       sizeof(entry0));
+			ldt->u.pages[i] = (struct ldt_entry *)
+				__get_free_page(GFP_KERNEL|__GFP_ZERO);
+			if(!ldt->u.pages[i]){
 				err = -ENOMEM;
 				/* Undo the change in host */
 				memset(&ldt_info, 0, sizeof(ldt_info));
@@ -332,8 +333,9 @@ static int write_ldt(void __user * ptr, 
 				goto out_unlock;
 			}
 			if(i == 0) {
-				memcpy(ldt->pages[0], &entry0, sizeof(entry0));
-				memcpy(ldt->pages[0]+1, ldt->entries+1,
+				memcpy(ldt->u.pages[0], &entry0, 
+				       sizeof(entry0));
+				memcpy(ldt->u.pages[0]+1, ldt->u.entries+1,
 				       sizeof(entry0)*(LDT_DIRECT_ENTRIES-1));
 			}
 			ldt->entry_count = (i + 1) * LDT_ENTRIES_PER_PAGE;
@@ -343,9 +345,9 @@ static int write_ldt(void __user * ptr, 
 		ldt->entry_count = ldt_info.entry_number + 1;
 
 	if(ldt->entry_count <= LDT_DIRECT_ENTRIES)
-		ldt_p = ldt->entries + ldt_info.entry_number;
+		ldt_p = ldt->u.entries + ldt_info.entry_number;
 	else
-		ldt_p = ldt->pages[ldt_info.entry_number/LDT_ENTRIES_PER_PAGE] +
+		ldt_p = ldt->u.pages[ldt_info.entry_number/LDT_ENTRIES_PER_PAGE] +
 			ldt_info.entry_number%LDT_ENTRIES_PER_PAGE;
 
 	if(ldt_info.base_addr == 0 && ldt_info.limit == 0 &&
@@ -501,8 +503,8 @@ long init_new_ldt(struct mmu_context_ska
 		 */
 		down(&from_mm->ldt.semaphore);
 		if(from_mm->ldt.entry_count <= LDT_DIRECT_ENTRIES){
-			memcpy(new_mm->ldt.entries, from_mm->ldt.entries,
-			       sizeof(new_mm->ldt.entries));
+			memcpy(new_mm->ldt.u.entries, from_mm->ldt.u.entries,
+			       sizeof(new_mm->ldt.u.entries));
 		}
 		else{
 			i = from_mm->ldt.entry_count / LDT_ENTRIES_PER_PAGE;
@@ -512,9 +514,10 @@ long init_new_ldt(struct mmu_context_ska
 					err = -ENOMEM;
 					break;
 				}
-				new_mm->ldt.pages[i] = (struct ldt_entry*)page;
-				memcpy(new_mm->ldt.pages[i],
-				       from_mm->ldt.pages[i], PAGE_SIZE);
+				new_mm->ldt.u.pages[i] = 
+					(struct ldt_entry *) page;
+				memcpy(new_mm->ldt.u.pages[i],
+				       from_mm->ldt.u.pages[i], PAGE_SIZE);
 			}
 		}
 		new_mm->ldt.entry_count = from_mm->ldt.entry_count;
@@ -532,7 +535,7 @@ void free_ldt(struct mmu_context_skas * 
 	if(!ptrace_ldt && mm->ldt.entry_count > LDT_DIRECT_ENTRIES){
 		i = mm->ldt.entry_count / LDT_ENTRIES_PER_PAGE;
 		while(i-- > 0){
-			free_page((long )mm->ldt.pages[i]);
+			free_page((long )mm->ldt.u.pages[i]);
 		}
 	}
 	mm->ldt.entry_count = 0;
Index: linux-2.6.14/include/asm-um/ldt-i386.h
===================================================================
--- linux-2.6.14.orig/include/asm-um/ldt-i386.h	2005-11-01 16:03:09.000000000 -0500
+++ linux-2.6.14/include/asm-um/ldt-i386.h	2005-11-02 15:02:06.000000000 -0500
@@ -35,7 +35,7 @@ typedef struct uml_ldt {
 	union {
 		struct ldt_entry * pages[LDT_PAGES_MAX];
 		struct ldt_entry entries[LDT_DIRECT_ENTRIES];
-	};
+	} u;
 } uml_ldt_t;
 
 /*
Index: linux-2.6.14/include/asm-um/ldt.h
===================================================================
--- linux-2.6.14.orig/include/asm-um/ldt.h	2005-11-01 16:03:09.000000000 -0500
+++ linux-2.6.14/include/asm-um/ldt.h	2005-11-02 05:43:38.484393750 -0500
@@ -1,74 +0,0 @@
-/*
- * Copyright (C) 2004 Fujitsu Siemens Computers GmbH
- * Licensed under the GPL
- *
- * Author: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
- */
-
-#ifndef __ASM_LDT_I386_H
-#define __ASM_LDT_I386_H
-
-#include "asm/semaphore.h"
-#include "asm/arch/ldt.h"
-
-struct mmu_context_skas;
-extern void ldt_host_info(void);
-extern long init_new_ldt(struct mmu_context_skas * to_mm,
-			 struct mmu_context_skas * from_mm);
-extern void free_ldt(struct mmu_context_skas * mm);
-
-#define LDT_PAGES_MAX \
-	((LDT_ENTRIES * LDT_ENTRY_SIZE)/PAGE_SIZE)
-#define LDT_ENTRIES_PER_PAGE \
-	(PAGE_SIZE/LDT_ENTRY_SIZE)
-#define LDT_DIRECT_ENTRIES \
-	((LDT_PAGES_MAX*sizeof(void *))/LDT_ENTRY_SIZE)
-
-struct ldt_entry {
-	__u32 a;
-	__u32 b;
-};
-
-typedef struct uml_ldt {
-	int entry_count;
-	struct semaphore semaphore;
-	union {
-		struct ldt_entry * pages[LDT_PAGES_MAX];
-		struct ldt_entry entries[LDT_DIRECT_ENTRIES];
-	};
-} uml_ldt_t;
-
-/*
- * macros stolen from include/asm-i386/desc.h
- */
-#define LDT_entry_a(info) \
-	((((info)->base_addr & 0x0000ffff) << 16) | ((info)->limit & 0x0ffff))
-
-#define LDT_entry_b(info) \
-	(((info)->base_addr & 0xff000000) | \
-	(((info)->base_addr & 0x00ff0000) >> 16) | \
-	((info)->limit & 0xf0000) | \
-	(((info)->read_exec_only ^ 1) << 9) | \
-	((info)->contents << 10) | \
-	(((info)->seg_not_present ^ 1) << 15) | \
-	((info)->seg_32bit << 22) | \
-	((info)->limit_in_pages << 23) | \
-	((info)->useable << 20) | \
-	0x7000)
-
-#define LDT_empty(info) (\
-	(info)->base_addr	== 0	&& \
-	(info)->limit		== 0	&& \
-	(info)->contents	== 0	&& \
-	(info)->read_exec_only	== 1	&& \
-	(info)->seg_32bit	== 0	&& \
-	(info)->limit_in_pages	== 0	&& \
-	(info)->seg_not_present	== 1	&& \
-	(info)->useable		== 0	)
-
-#endif
-#ifndef __UM_LDT_H
-#define __UM_LDT_H
-
-#include "asm/arch/ldt.h"
-#endif


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
