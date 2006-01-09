Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EvnYG-0000me-ER for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Jan 2006 19:18:32 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EvnYF-0004Bi-L8
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Jan 2006 19:18:32 -0800
Message-Id: <200601090410.k094AmWb001179@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/6] UML - Fix missing KBUILD_BASENAME
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
Date: Sun, 08 Jan 2006 23:10:47 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

2.6.15-mm1 caused kernel-offsets.c to stop compiling with a syntax 
error in a header.  The problem was with KBUILD_BASENAME, which didn't 
get a definition with the by-hand compilation in the main UML Makefile.
This was OK before since the expansion was syntactically the same as the
KBUILD_BASENAME token.  With -mm1, the expansion is now a quote-delimited 
string, so there needs to be a definition of it.
Since kernel-offsets.c is basically the same as other arches'
asm-offsets.c, and those seem to build OK, this patch turns
kernel-offsets.c into asm-offsets.c.
kernel-offsets.c is in arch/um/sys-$(SUBARCH), i.e. sys-i386 and
sys-x86_64, while kbuild expects it to be in arch/um/kernel.
kernel-offsets.c is moved to
arch/um/include/sysdep-$(SUBARCH)/kernel-offsets.h, which is
included by arch/um/kernel/asm-offsets.c.  With that,
include/asm-um/asm-offsets.h is generated automatically.
kernel-offsets.h continues to exist because it needs to be
accessible to userspace UML code, and include/asm-um isn't.  So, a
symlink is made from arch/um/include/kernel-offsets.h to
include/asm-um/asm-offsets.h.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15-mm/arch/um/Makefile
===================================================================
--- linux-2.6.15-mm.orig/arch/um/Makefile	2006-01-07 21:38:10.000000000 -0500
+++ linux-2.6.15-mm/arch/um/Makefile	2006-01-08 22:14:47.000000000 -0500
@@ -189,6 +189,12 @@ define filechk_umlconfig
 	sed 's/ CONFIG/ UML_CONFIG/'
 endef
 
+$(ARCH_DIR)/include/uml-config.h : include/linux/autoconf.h
+	$(call filechk,umlconfig)
+
+$(ARCH_DIR)/user-offsets.s: $(ARCH_DIR)/sys-$(SUBARCH)/user-offsets.c
+	$(CC) $(USER_CFLAGS) -S -o $@ $<
+
 define filechk_gen-asm-offsets
         (set -e; \
          echo "/*"; \
@@ -202,24 +208,13 @@ define filechk_gen-asm-offsets
          echo ""; )
 endef
 
-$(ARCH_DIR)/include/uml-config.h : include/linux/autoconf.h
-	$(call filechk,umlconfig)
-
-$(ARCH_DIR)/user-offsets.s: $(ARCH_DIR)/sys-$(SUBARCH)/user-offsets.c
-	$(CC) $(USER_CFLAGS) -S -o $@ $<
-
 $(ARCH_DIR)/include/user_constants.h: $(ARCH_DIR)/user-offsets.s
 	$(call filechk,gen-asm-offsets)
 
 CLEAN_FILES += $(ARCH_DIR)/user-offsets.s
 
-$(ARCH_DIR)/kernel-offsets.s: $(ARCH_DIR)/sys-$(SUBARCH)/kernel-offsets.c \
-				   archprepare
-	$(CC) $(CFLAGS) $(NOSTDINC_FLAGS) $(CPPFLAGS) -S -o $@ $<
-
-$(ARCH_DIR)/include/kern_constants.h: $(ARCH_DIR)/kernel-offsets.s
-	$(call filechk,gen-asm-offsets)
-
-CLEAN_FILES += $(ARCH_DIR)/kernel-offsets.s
+$(ARCH_DIR)/include/kern_constants.h:
+	@echo '  SYMLINK $@'
+	$(Q) ln -sf ../../../include/asm-um/asm-offsets.h $@
 
 export SUBARCH USER_CFLAGS OS
Index: linux-2.6.15-mm/arch/um/include/sysdep-i386/kernel-offsets.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-mm/arch/um/include/sysdep-i386/kernel-offsets.h	2006-01-08 22:16:51.000000000 -0500
@@ -0,0 +1,23 @@
+#include <linux/stddef.h>
+#include <linux/sched.h>
+#include <linux/elf.h>
+
+#define DEFINE(sym, val) \
+	asm volatile("\n->" #sym " %0 " #val : : "i" (val))
+
+#define STR(x) #x
+#define DEFINE_STR(sym, val) asm volatile("\n->" #sym " " STR(val) " " #val: : )
+
+#define BLANK() asm volatile("\n->" : : )
+
+#define OFFSET(sym, str, mem) \
+	DEFINE(sym, offsetof(struct str, mem));
+
+void foo(void)
+{
+	OFFSET(HOST_TASK_DEBUGREGS, task_struct, thread.arch.debugregs);
+#ifdef CONFIG_MODE_TT
+	OFFSET(HOST_TASK_EXTERN_PID, task_struct, thread.mode.tt.extern_pid);
+#endif
+#include <common-offsets.h>
+}
Index: linux-2.6.15-mm/arch/um/include/sysdep-x86_64/kernel-offsets.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-mm/arch/um/include/sysdep-x86_64/kernel-offsets.h	2006-01-08 22:15:19.000000000 -0500
@@ -0,0 +1,25 @@
+#include <linux/config.h>
+#include <linux/stddef.h>
+#include <linux/sched.h>
+#include <linux/time.h>
+#include <linux/elf.h>
+#include <asm/page.h>
+
+#define DEFINE(sym, val) \
+	asm volatile("\n->" #sym " %0 " #val : : "i" (val))
+
+#define DEFINE_STR1(x) #x
+#define DEFINE_STR(sym, val) asm volatile("\n->" #sym " " DEFINE_STR1(val) " " #val: : )
+
+#define BLANK() asm volatile("\n->" : : )
+
+#define OFFSET(sym, str, mem) \
+	DEFINE(sym, offsetof(struct str, mem));
+
+void foo(void)
+{
+#ifdef CONFIG_MODE_TT
+	OFFSET(HOST_TASK_EXTERN_PID, task_struct, thread.mode.tt.extern_pid);
+#endif
+#include <common-offsets.h>
+}
Index: linux-2.6.15-mm/arch/um/kernel/asm-offsets.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/asm-offsets.c	2006-01-07 21:38:10.000000000 -0500
+++ linux-2.6.15-mm/arch/um/kernel/asm-offsets.c	2006-01-07 21:38:30.000000000 -0500
@@ -1 +1 @@
-/* Dummy file to make kbuild happy - unused! */
+#include "sysdep/kernel-offsets.h"
Index: linux-2.6.15-mm/arch/um/sys-i386/kernel-offsets.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/sys-i386/kernel-offsets.c	2006-01-07 21:38:10.000000000 -0500
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,26 +0,0 @@
-#include <linux/config.h>
-#include <linux/stddef.h>
-#include <linux/sched.h>
-#include <linux/time.h>
-#include <linux/elf.h>
-#include <asm/page.h>
-
-#define DEFINE(sym, val) \
-        asm volatile("\n->" #sym " %0 " #val : : "i" (val))
-
-#define STR(x) #x
-#define DEFINE_STR(sym, val) asm volatile("\n->" #sym " " STR(val) " " #val: : )
-
-#define BLANK() asm volatile("\n->" : : )
-
-#define OFFSET(sym, str, mem) \
-	DEFINE(sym, offsetof(struct str, mem));
-
-void foo(void)
-{
-	OFFSET(HOST_TASK_DEBUGREGS, task_struct, thread.arch.debugregs);
-#ifdef CONFIG_MODE_TT
-	OFFSET(HOST_TASK_EXTERN_PID, task_struct, thread.mode.tt.extern_pid);
-#endif
-#include <common-offsets.h>
-}
Index: linux-2.6.15-mm/arch/um/sys-x86_64/kernel-offsets.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/sys-x86_64/kernel-offsets.c	2006-01-07 21:38:10.000000000 -0500
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,25 +0,0 @@
-#include <linux/config.h>
-#include <linux/stddef.h>
-#include <linux/sched.h>
-#include <linux/time.h>
-#include <linux/elf.h>
-#include <asm/page.h>
-
-#define DEFINE(sym, val) \
-        asm volatile("\n->" #sym " %0 " #val : : "i" (val))
-
-#define DEFINE_STR1(x) #x
-#define DEFINE_STR(sym, val) asm volatile("\n->" #sym " " DEFINE_STR1(val) " " #val: : )
-
-#define BLANK() asm volatile("\n->" : : )
-
-#define OFFSET(sym, str, mem) \
-	DEFINE(sym, offsetof(struct str, mem));
-
-void foo(void)
-{
-#ifdef CONFIG_MODE_TT
-	OFFSET(HOST_TASK_EXTERN_PID, task_struct, thread.mode.tt.extern_pid);
-#endif
-#include <common-offsets.h>
-}



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
