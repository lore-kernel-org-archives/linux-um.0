Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HJy9E-0007OG-2n for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 12:33:08 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HJy9D-0003Zm-HT
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 12:33:08 -0800
Message-Id: <200702212025.l1LKPKRm006789@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Wed, 21 Feb 2007 15:25:20 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 4/4] UML - lock host ldt retrieval
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

Add some locking to host_ldt_entries to prevent racing when reading
LDT information from the host.

Also fixed some style violations.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/sys-i386/ldt.c |   29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

Index: linux-2.6.18-mm/arch/um/sys-i386/ldt.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/sys-i386/ldt.c	2007-01-14 17:29:35.000000000 +1100
+++ linux-2.6.18-mm/arch/um/sys-i386/ldt.c	2007-01-15 17:03:25.000000000 +1100
@@ -7,6 +7,7 @@
 #include "linux/slab.h"
 #include "linux/types.h"
 #include "linux/errno.h"
+#include "linux/spinlock.h"
 #include "asm/uaccess.h"
 #include "asm/smp.h"
 #include "asm/ldt.h"
@@ -386,15 +387,20 @@ static long do_modify_ldt_skas(int func,
 	return ret;
 }
 
-short dummy_list[9] = {0, -1};
-short * host_ldt_entries = NULL;
+static DEFINE_SPINLOCK(host_ldt_lock);
+static short dummy_list[9] = {0, -1};
+static short * host_ldt_entries = NULL;
 
-void ldt_get_host_info(void)
+static void ldt_get_host_info(void)
 {
 	long ret;
 	struct ldt_entry * ldt;
 	int i, size, k, order;
 
+	spin_lock(&host_ldt_lock);
+	if(host_ldt_entries != NULL)
+		goto out_unlock;
+
 	host_ldt_entries = dummy_list+1;
 
 	for(i = LDT_PAGES_MAX-1, order=0; i; i>>=1, order++);
@@ -402,8 +408,9 @@ void ldt_get_host_info(void)
 	ldt = (struct ldt_entry *)
 	      __get_free_pages(GFP_KERNEL|__GFP_ZERO, order);
 	if(ldt == NULL) {
-		printk("ldt_get_host_info: couldn't allocate buffer for host ldt\n");
-		return;
+		printk("ldt_get_host_info: couldn't allocate buffer for host "
+		       "ldt\n");
+		goto out_unlock;
 	}
 
 	ret = modify_ldt(0, ldt, (1<<order)*PAGE_SIZE);
@@ -428,7 +435,8 @@ void ldt_get_host_info(void)
 		size = (size + 1) * sizeof(dummy_list[0]);
 		host_ldt_entries = kmalloc(size, GFP_KERNEL);
 		if(host_ldt_entries == NULL) {
-			printk("ldt_get_host_info: couldn't allocate host ldt list\n");
+			printk("ldt_get_host_info: couldn't allocate host ldt "
+			       "list\n");
 			goto out_free;
 		}
 	}
@@ -442,6 +450,8 @@ void ldt_get_host_info(void)
 
 out_free:
 	free_pages((unsigned long)ldt, order);
+out_unlock:
+	spin_unlock(&host_ldt_lock);
 }
 
 long init_new_ldt(struct mmu_context_skas * new_mm,
@@ -480,8 +490,7 @@ long init_new_ldt(struct mmu_context_ska
 			 * inherited from the host. All ldt-entries found
 			 * will be reset in the following loop
 			 */
-			if(host_ldt_entries == NULL)
-				ldt_get_host_info();
+			ldt_get_host_info();
 			for(num_p=host_ldt_entries; *num_p != -1; num_p++){
 				desc.entry_number = *num_p;
 				err = write_ldt_entry(&new_mm->id, 1, &desc,
@@ -560,6 +569,6 @@ void free_ldt(struct mmu_context_skas * 
 
 int sys_modify_ldt(int func, void __user *ptr, unsigned long bytecount)
 {
-	return(CHOOSE_MODE_PROC(do_modify_ldt_tt, do_modify_ldt_skas, func,
-	                        ptr, bytecount));
+	return CHOOSE_MODE_PROC(do_modify_ldt_tt, do_modify_ldt_skas, func,
+	                        ptr, bytecount);
 }


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
