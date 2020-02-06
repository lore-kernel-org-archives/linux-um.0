Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1izn9i-0002Yo-OF
 for linux-um@lists.infradead.org; Thu, 06 Feb 2020 19:49:44 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [DEMO] um: demonstrate super early constructors
Date: Thu,  6 Feb 2020 20:49:39 +0100
Message-Id: <20200206204937.db680692f366.Ie05fc2ad440c8db59c1519194aeac356469efa72@changeid>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>, Patricia Alfonso <trishalfonso@google.com>

From: Johannes Berg <johannes.berg@intel.com>

For KASAN, we need super early constructors, demonstrate
how we could perhaps do that.

I'm not sure why we have two places with .init_array in the
linker scripts, the common one does get included, but then
the dyn one seems to override it, perhaps for alignment? but
it seems it would be harmless to do the alignment in the
common one ... not sure.

---
 arch/um/include/asm/common.lds.S |  1 +
 arch/um/kernel/dyn.lds.S         |  5 ++++-
 arch/um/kernel/mem.c             | 15 +++++++++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/common.lds.S
index eca6c452a41b..731f8c8422a2 100644
--- a/arch/um/include/asm/common.lds.S
+++ b/arch/um/include/asm/common.lds.S
@@ -83,6 +83,7 @@
   }
   .init_array : {
 	__init_array_start = .;
+	*(.kasan_init)
 	*(.init_array)
 	__init_array_end = .;
   }
diff --git a/arch/um/kernel/dyn.lds.S b/arch/um/kernel/dyn.lds.S
index f5001481010c..4f0447cd9e38 100644
--- a/arch/um/kernel/dyn.lds.S
+++ b/arch/um/kernel/dyn.lds.S
@@ -103,7 +103,10 @@ SECTIONS
      be empty, which isn't pretty.  */
   . = ALIGN(32 / 8);
   .preinit_array     : { *(.preinit_array) }
-  .init_array     : { *(.init_array) }
+  .init_array     : {
+	*(.kasan_init)
+	*(.init_array)
+  }
   .fini_array     : { *(.fini_array) }
   .data           : {
     INIT_TASK_DATA(KERNEL_STACK_SIZE)
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 30885d0b94ac..32fc941c80f7 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -19,6 +19,21 @@
 #include <mem_user.h>
 #include <os.h>
 
+extern int printf(const char *msg, ...);
+static void early_print(void)
+{
+	printf("I'm super early, before constructors\n");
+}
+
+static void __attribute__((constructor)) constructor_test(void)
+{
+	printf("yes, you can see it\n");
+}
+
+static void (*early_print_ptr)(void)
+__attribute__((section(".kasan_init"), used))
+ = early_print;
+
 /* allocated in paging_init, zeroed in mem_init, and unchanged thereafter */
 unsigned long *empty_zero_page = NULL;
 EXPORT_SYMBOL(empty_zero_page);
-- 
2.24.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

