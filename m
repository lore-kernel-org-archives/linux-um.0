Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HKMof-0001nZ-9G for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 14:53:33 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HKMod-000498-PI
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 14:53:33 -0800
Date: Thu, 22 Feb 2007 17:45:27 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070222224527.GA7982@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 1/2] UML - Fix host LDT lookup initialization
	locking, try 2
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
To: akpm@osdl.org, Blaisorblade <blaisorblade@yahoo.it>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Add some locking to host_ldt_entries to prevent racing when reading
LDT information from the host.

The locking is somewhat more careful than my previous attempt.  Now,
only the check of host_ldt_entries is locked.  The lock is dropped
immediately afterwards, and if the LDT needs initializing, that (and
the memory allocations needed) proceed outside the lock.

Also fixed some style violations.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/sys-i386/ldt.c |   36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

Index: linux-2.6.17/arch/um/sys-i386/ldt.c
===================================================================
--- linux-2.6.17.orig/arch/um/sys-i386/ldt.c	2007-02-05 17:12:14.000000000 -0500
+++ linux-2.6.17/arch/um/sys-i386/ldt.c	2007-02-22 17:30:24.000000000 -0500
@@ -7,6 +7,7 @@
 #include "linux/slab.h"
 #include "linux/types.h"
 #include "linux/errno.h"
+#include "linux/spinlock.h"
 #include "asm/uaccess.h"
 #include "asm/smp.h"
 #include "asm/ldt.h"
@@ -386,23 +387,33 @@ static long do_modify_ldt_skas(int func,
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
-	struct ldt_entry * ldt;
+	struct ldt_entry * ldt, *tmp;
 	int i, size, k, order;
 
+	spin_lock(&host_ldt_lock);
+
+	if(host_ldt_entries != NULL){
+		spin_unlock(&host_ldt_lock);
+		return;
+	}
 	host_ldt_entries = dummy_list+1;
 
+	spin_unlock(&host_ldt_lock);
+
 	for(i = LDT_PAGES_MAX-1, order=0; i; i>>=1, order++);
 
 	ldt = (struct ldt_entry *)
 	      __get_free_pages(GFP_KERNEL|__GFP_ZERO, order);
 	if(ldt == NULL) {
-		printk("ldt_get_host_info: couldn't allocate buffer for host ldt\n");
+		printk("ldt_get_host_info: couldn't allocate buffer for host "
+		       "ldt\n");
 		return;
 	}
 
@@ -426,11 +437,13 @@ void ldt_get_host_info(void)
 		host_ldt_entries = dummy_list;
 	else {
 		size = (size + 1) * sizeof(dummy_list[0]);
-		host_ldt_entries = kmalloc(size, GFP_KERNEL);
-		if(host_ldt_entries == NULL) {
-			printk("ldt_get_host_info: couldn't allocate host ldt list\n");
+		tmp = kmalloc(size, GFP_KERNEL);
+		if(tmp == NULL) {
+			printk("ldt_get_host_info: couldn't allocate host ldt "
+			       "list\n");
 			goto out_free;
 		}
+		host_ldt_entries = tmp;
 	}
 
 	for(i=0, k=0; i<ret/LDT_ENTRY_SIZE; i++){
@@ -480,8 +493,7 @@ long init_new_ldt(struct mmu_context_ska
 			 * inherited from the host. All ldt-entries found
 			 * will be reset in the following loop
 			 */
-			if(host_ldt_entries == NULL)
-				ldt_get_host_info();
+			ldt_get_host_info();
 			for(num_p=host_ldt_entries; *num_p != -1; num_p++){
 				desc.entry_number = *num_p;
 				err = write_ldt_entry(&new_mm->id, 1, &desc,
@@ -560,6 +572,6 @@ void free_ldt(struct mmu_context_skas * 
 
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
