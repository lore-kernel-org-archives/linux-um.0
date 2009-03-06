Return-Path: <linux-kernel-owner+geert=40linux-m68k.org-S1753662AbZCFMiA@vger.kernel.org>
Date: Fri, 6 Mar 2009 20:38:02 +0800
From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Subject: [Patch] uml: don't use a too long string literal
Message-ID: <20090306123802.GE8991@hack.private>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


uml uses a concatenated string literal to store the contents of .config,
but .config file content is varaible, it can be very long.

Use an array of string literals instead.

Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>
Cc: Jeff Dike <jdike@addtoit.com>

---
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index 499e5e9..388ec0a 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -28,7 +28,7 @@ $(obj)/config.tmp: $(objtree)/.config FORCE
 	$(call if_changed,quote1)
 
 quiet_cmd_quote1 = QUOTE   $@
-      cmd_quote1 = sed -e 's/"/\\"/g' -e 's/^/"/' -e 's/$$/\\n"/' \
+      cmd_quote1 = sed -e 's/"/\\"/g' -e 's/^/"/' -e 's/$$/\\n",/' \
 		   $< > $@
 
 $(obj)/config.c: $(src)/config.c.in $(obj)/config.tmp FORCE
@@ -36,9 +36,9 @@ $(obj)/config.c: $(src)/config.c.in $(obj)/config.tmp FORCE
 
 quiet_cmd_quote2 = QUOTE   $@
       cmd_quote2 = sed -e '/CONFIG/{'          \
-		  -e 's/"CONFIG"\;/""/'        \
+		  -e 's/"CONFIG"//'            \
 		  -e 'r $(obj)/config.tmp'     \
 		  -e 'a \'                     \
-		  -e '""\;'                    \
+		  -e '""'                      \
 		  -e '}'                       \
 		  $< > $@
diff --git a/arch/um/kernel/config.c.in b/arch/um/kernel/config.c.in
index c062cbf..bee154d 100644
--- a/arch/um/kernel/config.c.in
+++ b/arch/um/kernel/config.c.in
@@ -7,11 +7,15 @@
 #include <stdlib.h>
 #include "init.h"
 
-static __initdata char *config = "CONFIG";
+static __initdata const char *config[] = {
+"CONFIG"
+};
 
 static int __init print_config(char *line, int *add)
 {
-	printf("%s", config);
+	int i;
+	for (i = 0; i < sizeof(config)/sizeof(config[0]); i++)
+		printf("%s", config[i]);
 	exit(0);
 }
 
