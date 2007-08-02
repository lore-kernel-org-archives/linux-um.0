Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IGhqi-0003b2-8y for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Aug 2007 14:04:48 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IGhqh-0000cL-5L
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Aug 2007 14:04:48 -0700
Date: Thu, 2 Aug 2007 17:04:39 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070802210439.GA11196@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 6/6] UML - physmem code tidying
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Tidying of the UML physical memory system.  These are mostly style
fixes, however the includes were cleaned as well.  This uncovered a
need for mem_user.h to be included in mode_kern_skas.h.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/include/skas/mode_kern_skas.h |    3 +-
 arch/um/kernel/physmem.c              |   50 ++++++++++++++--------------------
 2 files changed, 23 insertions(+), 30 deletions(-)

Index: linux-2.6.21-mm/arch/um/kernel/physmem.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/physmem.c	2007-08-02 16:43:25.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/physmem.c	2007-08-02 16:43:30.000000000 -0400
@@ -1,25 +1,17 @@
 /*
- * Copyright (C) 2000 - 2003 Jeff Dike (jdike@addtoit.com)
+ * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  * Licensed under the GPL
  */
 
-#include "linux/mm.h"
-#include "linux/rbtree.h"
-#include "linux/slab.h"
-#include "linux/vmalloc.h"
 #include "linux/bootmem.h"
-#include "linux/module.h"
+#include "linux/mm.h"
 #include "linux/pfn.h"
-#include "asm/types.h"
-#include "asm/pgtable.h"
-#include "kern_util.h"
+#include "asm/page.h"
 #include "as-layout.h"
+#include "init.h"
+#include "kern.h"
 #include "mode_kern.h"
-#include "mem.h"
-#include "mem_user.h"
 #include "os.h"
-#include "kern.h"
-#include "init.h"
 
 static int physmem_fd = -1;
 
@@ -49,10 +41,10 @@ int __init init_maps(unsigned long physm
 	total_len = phys_len + iomem_len + highmem_len;
 
 	map = alloc_bootmem_low_pages(total_len);
-	if(map == NULL)
+	if (map == NULL)
 		return -ENOMEM;
 
-	for(i = 0; i < total_pages; i++){
+	for (i = 0; i < total_pages; i++) {
 		p = &map[i];
 		memset(p, 0, sizeof(struct page));
 		SetPageReserved(p);
@@ -68,7 +60,7 @@ static unsigned long kmem_top = 0;
 
 unsigned long get_kmem_end(void)
 {
-	if(kmem_top == 0)
+	if (kmem_top == 0)
 		kmem_top = CHOOSE_MODE(kmem_end_tt, kmem_end_skas);
 	return kmem_top;
 }
@@ -81,8 +73,8 @@ void map_memory(unsigned long virt, unsi
 
 	fd = phys_mapping(phys, &offset);
 	err = os_map_memory((void *) virt, fd, offset, len, r, w, x);
-	if(err) {
-		if(err == -ENOMEM)
+	if (err) {
+		if (err == -ENOMEM)
 			printk("try increasing the host's "
 			       "/proc/sys/vm/max_map_count to <physical "
 			       "memory size>/4096\n");
@@ -106,7 +98,7 @@ void __init setup_physmem(unsigned long 
 	offset = uml_reserved - uml_physmem;
 	err = os_map_memory((void *) uml_reserved, physmem_fd, offset,
 			    len - offset, 1, 1, 1);
-	if(err < 0){
+	if (err < 0) {
 		os_print_error(err, "Mapping memory");
 		exit(1);
 	}
@@ -126,16 +118,16 @@ int phys_mapping(unsigned long phys, __u
 {
 	int fd = -1;
 
-	if(phys < physmem_size){
+	if (phys < physmem_size) {
 		fd = physmem_fd;
 		*offset_out = phys;
 	}
-	else if(phys < __pa(end_iomem)){
+	else if (phys < __pa(end_iomem)) {
 		struct iomem_region *region = iomem_regions;
 
-		while(region != NULL){
-			if((phys >= region->phys) &&
-			   (phys < region->phys + region->size)){
+		while (region != NULL) {
+			if ((phys >= region->phys) &&
+			    (phys < region->phys + region->size)) {
 				fd = region->fd;
 				*offset_out = phys - region->phys;
 				break;
@@ -143,7 +135,7 @@ int phys_mapping(unsigned long phys, __u
 			region = region->next;
 		}
 	}
-	else if(phys < __pa(end_iomem) + highmem){
+	else if (phys < __pa(end_iomem) + highmem) {
 		fd = physmem_fd;
 		*offset_out = phys - iomem_size;
 	}
@@ -188,8 +180,8 @@ unsigned long find_iomem(char *driver, u
 {
 	struct iomem_region *region = iomem_regions;
 
-	while(region != NULL){
-		if(!strcmp(region->driver, driver)){
+	while (region != NULL) {
+		if (!strcmp(region->driver, driver)) {
 			*len_out = region->size;
 			return region->virt;
 		}
@@ -206,10 +198,10 @@ int setup_iomem(void)
 	unsigned long iomem_start = high_physmem + PAGE_SIZE;
 	int err;
 
-	while(region != NULL){
+	while (region != NULL) {
 		err = os_map_memory((void *) iomem_start, region->fd, 0,
 				    region->size, 1, 1, 0);
-		if(err)
+		if (err)
 			printk("Mapping iomem region for driver '%s' failed, "
 			       "errno = %d\n", region->driver, -err);
 		else {
Index: linux-2.6.21-mm/arch/um/include/skas/mode_kern_skas.h
===================================================================
--- linux-2.6.21-mm.orig/arch/um/include/skas/mode_kern_skas.h	2007-08-02 16:43:16.000000000 -0400
+++ linux-2.6.21-mm/arch/um/include/skas/mode_kern_skas.h	2007-08-02 16:43:30.000000000 -0400
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{linux.intel,addtoit}.com)
  * Licensed under the GPL
  */
 
@@ -9,6 +9,7 @@
 #include "linux/sched.h"
 #include "asm/page.h"
 #include "asm/ptrace.h"
+#include "mem_user.h"
 
 extern void flush_thread_skas(void);
 extern void switch_to_skas(void *prev, void *next);

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
