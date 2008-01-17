Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JFcU4-00018k-Ms for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 13:41:12 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JFcU4-00014t-4I
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 13:41:12 -0800
Date: Thu, 17 Jan 2008 16:40:47 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080117214047.GA6772@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 17/20] UML - LDT mutex conversion
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
Cc: Daniel Walker <dwalker@mvista.com>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

From: Daniel Walker <dwalker@mvista.com>

The ldt.semaphore conforms to the new struct mutex requirments,
so I converted it to use the new API and changed the name.

Signed-off-by: Daniel Walker <dwalker@mvista.com>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/sys-i386/ldt.c |   14 +++++++-------
 include/asm-um/ldt.h   |    4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

Index: linux-2.6.22/arch/um/sys-i386/ldt.c
===================================================================
--- linux-2.6.22.orig/arch/um/sys-i386/ldt.c	2008-01-17 13:44:46.000000000 -0500
+++ linux-2.6.22/arch/um/sys-i386/ldt.c	2008-01-17 13:45:32.000000000 -0500
@@ -147,7 +147,7 @@ static int read_ldt(void __user * ptr, u
 	if (ptrace_ldt)
 		return read_ldt_from_host(ptr, bytecount);
 
-	down(&ldt->semaphore);
+	mutex_lock(&ldt->lock);
 	if (ldt->entry_count <= LDT_DIRECT_ENTRIES) {
 		size = LDT_ENTRY_SIZE*LDT_DIRECT_ENTRIES;
 		if (size > bytecount)
@@ -171,7 +171,7 @@ static int read_ldt(void __user * ptr, u
 			ptr += size;
 		}
 	}
-	up(&ldt->semaphore);
+	mutex_unlock(&ldt->lock);
 
 	if (bytecount == 0 || err == -EFAULT)
 		goto out;
@@ -229,7 +229,7 @@ static int write_ldt(void __user * ptr, 
 	}
 
 	if (!ptrace_ldt)
-		down(&ldt->semaphore);
+		mutex_lock(&ldt->lock);
 
 	err = write_ldt_entry(mm_idp, func, &ldt_info, &addr, 1);
 	if (err)
@@ -289,7 +289,7 @@ static int write_ldt(void __user * ptr, 
 	err = 0;
 
 out_unlock:
-	up(&ldt->semaphore);
+	mutex_unlock(&ldt->lock);
 out:
 	return err;
 }
@@ -396,7 +396,7 @@ long init_new_ldt(struct mm_context *new
 
 
 	if (!ptrace_ldt)
-		init_MUTEX(&new_mm->ldt.semaphore);
+		mutex_init(&new_mm->ldt.lock);
 
 	if (!from_mm) {
 		memset(&desc, 0, sizeof(desc));
@@ -456,7 +456,7 @@ long init_new_ldt(struct mm_context *new
 		 * i.e., we have to use the stub for modify_ldt, which
 		 * can't handle the big read buffer of up to 64kB.
 		 */
-		down(&from_mm->ldt.semaphore);
+		mutex_lock(&from_mm->ldt.lock);
 		if (from_mm->ldt.entry_count <= LDT_DIRECT_ENTRIES)
 			memcpy(new_mm->ldt.u.entries, from_mm->ldt.u.entries,
 			       sizeof(new_mm->ldt.u.entries));
@@ -475,7 +475,7 @@ long init_new_ldt(struct mm_context *new
 			}
 		}
 		new_mm->ldt.entry_count = from_mm->ldt.entry_count;
-		up(&from_mm->ldt.semaphore);
+		mutex_unlock(&from_mm->ldt.lock);
 	}
 
     out:
Index: linux-2.6.22/include/asm-um/ldt.h
===================================================================
--- linux-2.6.22.orig/include/asm-um/ldt.h	2007-11-14 10:33:41.000000000 -0500
+++ linux-2.6.22/include/asm-um/ldt.h	2008-01-17 13:45:32.000000000 -0500
@@ -8,7 +8,7 @@
 #ifndef __ASM_LDT_H
 #define __ASM_LDT_H
 
-#include "asm/semaphore.h"
+#include <linux/mutex.h>
 #include "asm/host_ldt.h"
 
 extern void ldt_host_info(void);
@@ -27,7 +27,7 @@ struct ldt_entry {
 
 typedef struct uml_ldt {
 	int entry_count;
-	struct semaphore semaphore;
+	struct mutex lock;
 	union {
 		struct ldt_entry * pages[LDT_PAGES_MAX];
 		struct ldt_entry entries[LDT_DIRECT_ENTRIES];

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
