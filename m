Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DDncU-0005aF-V1 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Mar 2005 09:56:46 -0800
Received: from mail-relay-3.tiscali.it ([213.205.33.43])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DDncA-0005j2-T5 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Mar 2005 09:56:46 -0800
From: blaisorblade@yahoo.it
Message-Id: <20050322162145.98B97D5EA8@zion>
Subject: [uml-devel] [patch 11/12] uml: real fix for __gcov_init symbols
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
Date: Tue, 22 Mar 2005 17:21:45 +0100
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it, aia21@cam.ac.uk


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
CC: Anton Altaparmakov <aia21@cam.ac.uk>

Correctly export __gcov_init for cases where it's needed, by adding a weak
definition for the case when GCC does not define this symbol and letting it
being overriden by the real definition when GCC defines it (recent ones).

Can't be implemented as a test on GCC version because SuSE has a crippled GCC,
declared as 3.3.4 but having a lot of backported features.

Also, since gcc 3.4.3 requires profiling options even during linking, add
profiling options to final link stage.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/Makefile-skas      |   10 ++++++----
 linux-2.6.11-paolo/arch/um/kernel/gmon_syms.c |   20 ++++++++++++++------
 2 files changed, 20 insertions(+), 10 deletions(-)

diff -puN arch/um/kernel/gmon_syms.c~uml-real-fix-gcov-symbols arch/um/kernel/gmon_syms.c
--- linux-2.6.11/arch/um/kernel/gmon_syms.c~uml-real-fix-gcov-symbols	2005-03-22 11:06:13.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/gmon_syms.c	2005-03-22 11:06:13.000000000 +0100
@@ -5,14 +5,22 @@
 
 #include "linux/module.h"
 
-#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 3) || \
-	(__GNUC__ == 3 && __GNUC_MINOR__ == 3 && __GNUC_PATCHLEVEL__ >= 4)
-extern void __gcov_init(void *);
-EXPORT_SYMBOL(__gcov_init);
-#else
 extern void __bb_init_func(void *);
 EXPORT_SYMBOL(__bb_init_func);
-#endif
+
+/* This is defined (and referred to in profiling stub code) only by some GCC
+ * versions in libgcov.
+ *
+ * Since SuSE backported the fix, we cannot handle it depending on GCC version.
+ * So, unconditinally export it. But also give it a weak declaration, which will
+ * be overriden by any other one.
+ */
+
+extern void __gcov_init(void *) __attribute__((weak));
+EXPORT_SYMBOL(__gcov_init);
+
+extern void __gcov_merge_add(void *) __attribute__((weak));
+EXPORT_SYMBOL(__gcov_merge_add);
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -puN arch/um/Makefile-skas~uml-real-fix-gcov-symbols arch/um/Makefile-skas
--- linux-2.6.11/arch/um/Makefile-skas~uml-real-fix-gcov-symbols	2005-03-22 11:06:13.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/Makefile-skas	2005-03-22 11:06:13.000000000 +0100
@@ -3,10 +3,12 @@
 # Licensed under the GPL
 #
 
-PROFILE += -pg
+GPROF_OPT += -pg
+GCOV_OPT += -fprofile-arcs -ftest-coverage
 
-CFLAGS-$(CONFIG_GCOV) += -fprofile-arcs -ftest-coverage
-CFLAGS-$(CONFIG_GPROF) += $(PROFILE)
-LINK-$(CONFIG_GPROF) += $(PROFILE)
+CFLAGS-$(CONFIG_GCOV) += $(GCOV_OPT)
+CFLAGS-$(CONFIG_GPROF) += $(GPROF_OPT)
+LINK-$(CONFIG_GCOV) += $(GCOV_OPT)
+LINK-$(CONFIG_GPROF) += $(GPROF_OPT)
 
 GEN_HEADERS += $(ARCH_DIR)/include/skas_ptregs.h
_


-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
