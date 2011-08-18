Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7xt-0002Bn-HP
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:09:17 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7xs-0002Ui-Og
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:09:17 +0000
Date: Thu, 18 Aug 2011 20:09:09 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7xl-0007sr-Q3@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] Subject: [PATCH 61/91] um: take um_mmu.h to asm/mmu.h,
 clean asm/mmu_context.h a bit
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/include/asm/mmu.h         |   22 +++++++++++++++++-----
 arch/um/include/asm/mmu_context.h |    7 ++-----
 arch/um/include/shared/um_mmu.h   |   24 ------------------------
 3 files changed, 19 insertions(+), 34 deletions(-)
 delete mode 100644 arch/um/include/shared/um_mmu.h

diff --git a/arch/um/include/asm/mmu.h b/arch/um/include/asm/mmu.h
index cf259de..b1a7e47 100644
--- a/arch/um/include/asm/mmu.h
+++ b/arch/um/include/asm/mmu.h
@@ -1,12 +1,24 @@
 /* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  * Licensed under the GPL
  */
 
-#ifndef __MMU_H
-#define __MMU_H
+#ifndef __ARCH_UM_MMU_H
+#define __ARCH_UM_MMU_H
 
-#include "um_mmu.h"
+#include "mm_id.h"
+#include "ldt.h"
 
-#endif
+typedef struct mm_context {
+	struct mm_id id;
+	struct uml_ldt ldt;
+	struct page **stub_pages;
+} mm_context_t;
+
+extern void __switch_mm(struct mm_id * mm_idp);
 
+/* Avoid tangled inclusion with asm/ldt.h */
+extern long init_new_ldt(struct mm_context *to_mm, struct mm_context *from_mm);
+extern void free_ldt(struct mm_context *mm);
+
+#endif
diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_context.h
index 34d8130..591b3d8 100644
--- a/arch/um/include/asm/mmu_context.h
+++ b/arch/um/include/asm/mmu_context.h
@@ -6,15 +6,12 @@
 #ifndef __UM_MMU_CONTEXT_H
 #define __UM_MMU_CONTEXT_H
 
-#include "linux/sched.h"
-#include "um_mmu.h"
+#include <linux/sched.h>
+#include <asm/mmu.h>
 
 extern void arch_dup_mmap(struct mm_struct *oldmm, struct mm_struct *mm);
 extern void arch_exit_mmap(struct mm_struct *mm);
 
-#define get_mmu_context(task) do ; while(0)
-#define activate_context(tsk) do ; while(0)
-
 #define deactivate_mm(tsk,mm)	do { } while (0)
 
 extern void force_flush_all(void);
diff --git a/arch/um/include/shared/um_mmu.h b/arch/um/include/shared/um_mmu.h
deleted file mode 100644
index b1a7e47..0000000
--- a/arch/um/include/shared/um_mmu.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* 
- * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
- */
-
-#ifndef __ARCH_UM_MMU_H
-#define __ARCH_UM_MMU_H
-
-#include "mm_id.h"
-#include "ldt.h"
-
-typedef struct mm_context {
-	struct mm_id id;
-	struct uml_ldt ldt;
-	struct page **stub_pages;
-} mm_context_t;
-
-extern void __switch_mm(struct mm_id * mm_idp);
-
-/* Avoid tangled inclusion with asm/ldt.h */
-extern long init_new_ldt(struct mm_context *to_mm, struct mm_context *from_mm);
-extern void free_ldt(struct mm_context *mm);
-
-#endif
-- 
1.7.2.5



------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

