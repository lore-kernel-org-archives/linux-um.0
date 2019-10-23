Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iN8ke-0001Aw-Ca
 for linux-um@lists.infradead.org; Wed, 23 Oct 2019 05:00:05 +0000
Received: by mail-pg1-x544.google.com with SMTP id r1so11365399pgj.12
 for <linux-um@lists.infradead.org>; Tue, 22 Oct 2019 22:00:04 -0700 (PDT)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC PATCH 41/47] Revert "kbuild: remove
 CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX"
Date: Wed, 23 Oct 2019 13:38:15 +0900
Message-Id: <f979f24b032151ac63a5ba6f70172e32ed571448.1571798507.git.thehajime@gmail.com>
In-Reply-To: <cover.1571798507.git.thehajime@gmail.com>
References: <cover.1571798507.git.thehajime@gmail.com>
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
Cc: Octavian Purdila <tavi.purdila@gmail.com>, Hajime Tazaki <thehajime@gmail.com>, Akira Moroo <retrage01@gmail.com>

This reverts commit 704db5433fb43acbf1486303721bd0cbb65af251.

for lkl, mingw32 requires underscore-ed symbols.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/Kconfig                | 6 ++++++
 scripts/Makefile.build      | 7 ++++++-
 scripts/adjust_autoksyms.sh | 7 ++++++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index a7b57dd42c26..a01df2ae6a1b 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -594,6 +594,12 @@ config MODULES_USE_ELF_REL
 	  Modules only use ELF REL relocations.  Modules with ELF RELA
 	  relocations will give an error.
 
+config HAVE_UNDERSCORE_SYMBOL_PREFIX
+	bool
+	help
+	  Some architectures generate an _ in front of C symbols; things like
+	  module loading and assembly files need to know about this.
+
 config HAVE_IRQ_EXIT_ON_IRQ_STACK
 	bool
 	help
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 2f66ed388d1c..c6fe3e092ae0 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -444,10 +444,15 @@ targets += $(lib-target)
 
 dummy-object = $(obj)/.lib_exports.o
 ksyms-lds = $(dot-target).lds
+ifdef CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
+ref_prefix = EXTERN(_
+else
+ref_prefix = EXTERN(
+endif
 
 quiet_cmd_export_list = EXPORTS $@
 cmd_export_list = $(OBJDUMP) -h $< | \
-	sed -ne '/___ksymtab/s/.*+\([^ ]*\).*/EXTERN(\1)/p' >$(ksyms-lds);\
+	sed -ne '/___ksymtab/s/.*+\([^ ]*\).*/$(ref_prefix)\1)/p' >$(ksyms-lds);\
 	rm -f $(dummy-object);\
 	echo | $(CC) $(a_flags) -c -o $(dummy-object) -x assembler -;\
 	$(LD) $(ld_flags) -r -o $@ -T $(ksyms-lds) $(dummy-object);\
diff --git a/scripts/adjust_autoksyms.sh b/scripts/adjust_autoksyms.sh
index a904bf1f5e67..10e49e00a1f6 100755
--- a/scripts/adjust_autoksyms.sh
+++ b/scripts/adjust_autoksyms.sh
@@ -49,7 +49,12 @@ EOT
 sed 's/ko$/mod/' modules.order |
 xargs -n1 sed -n -e '2{s/ /\n/g;/^$/!p;}' -- |
 sort -u |
-sed -e 's/\(.*\)/#define __KSYM_\1 1/' >> "$new_ksyms_file"
+while read sym; do
+	if [ -n "$CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX" ]; then
+		sym="${sym#_}"
+	fi
+	echo "#define __KSYM_${sym} 1"
+done >> "$new_ksyms_file"
 
 # Special case for modversions (see modpost.c)
 if [ -n "$CONFIG_MODVERSIONS" ]; then
-- 
2.20.1 (Apple Git-117)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

