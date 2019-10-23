Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iN8ki-0001in-Lc
 for linux-um@lists.infradead.org; Wed, 23 Oct 2019 05:00:14 +0000
Received: by mail-pg1-x544.google.com with SMTP id u23so697023pgo.0
 for <linux-um@lists.infradead.org>; Tue, 22 Oct 2019 22:00:08 -0700 (PDT)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC PATCH 43/47] kallsyms: Add a config option to select section for
 kallsyms
Date: Wed, 23 Oct 2019 13:38:17 +0900
Message-Id: <b56063cbad6bc3c09d4c5edd6e34c3793ed4cb5d.1571798507.git.thehajime@gmail.com>
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
Cc: Octavian Purdila <tavi.purdila@gmail.com>, Andreas Abel <aabel@google.com>, Akira Moroo <retrage01@gmail.com>

From: Andreas Abel <aabel@google.com>

This commit adds a kernel config option to select whether the
kallsyms data should be in the .rodata section (the default for
non-LKL builds), or in the .data section (the default for LKL).

This is to avoid relocations in the text segment (TEXTRELs) that
would otherwise occur with LKL when the .rodata and the .text
section end up in the same segment.

Having TEXTRELs can lead to a number of issues:

1. If a shared library contains a TEXTREL, the corresponding memory
pages cannot be shared.

2. Android >=6 and SELinux do not support binaries with TEXTRELs
(http://android-developers.blogspot.com/2016/06/android-changes-for-ndk-developers.html).

3. If a program has a TEXTREL, uses an ifunc, and is compiled with
early binding, this can lead to a segmentation fault when processing
the relocation for the ifunc during dynamic linking because the text
segment is made temporarily non-executable to process the TEXTREL
(line 248 in dl_reloc.c).

Signed-off-by: Andreas Abel <aabel@google.com>
---
 init/Kconfig            | 12 ++++++++++++
 scripts/kallsyms.c      |  9 ++++++++-
 scripts/link-vmlinux.sh |  4 ++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 81293d78a6ad..bd1a846e0ee0 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1385,6 +1385,18 @@ config POSIX_TIMERS
 
 	  If unsure say y.
 
+config KALLSYMS_USE_DATA_SECTION
+	bool "Use .data instead of .rodata section for kallsyms"
+	depends on KALLSYMS
+	default n
+	help
+	  Enabling this option will put the kallsyms data in the .data section
+	  instead of the .rodata section.
+
+	  This is useful when building the kernel as a library, as it avoids
+	  relocations in the text segment that could otherwise occur if the
+	  .rodata section is in the same segment as the .text section.
+
 config PRINTK
 	default y
 	bool "Enable support for printk" if EXPERT
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 8a62e1b6cf22..11d01516e1c8 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -59,6 +59,7 @@ static struct addr_range percpu_range = {
 static struct sym_entry *table;
 static unsigned int table_size, table_cnt;
 static int all_symbols = 0;
+static int use_data_section;
 static int absolute_percpu = 0;
 static char symbol_prefix_char = '\0';
 static int base_relative = 0;
@@ -73,6 +74,7 @@ static unsigned char best_table_len[256];
 static void usage(void)
 {
 	fprintf(stderr, "Usage: kallsyms [--all-symbols] "
+			"[--use-data-section] "
 			"[--symbol-prefix=<prefix char>] "
 			"[--base-relative] < in.map > out.S\n");
 	exit(1);
@@ -362,7 +364,10 @@ static void write_src(void)
 	printf("#define ALGN .balign 4\n");
 	printf("#endif\n");
 
-	printf("\t.section .rodata, \"a\"\n");
+	if (use_data_section)
+		printf("\t.section .data\n");
+	else
+		printf("\t.section .rodata, \"a\"\n");
 
 	/* Provide proper symbols relocatability by their relativeness
 	 * to a fixed anchor point in the runtime image, either '_text'
@@ -768,6 +773,8 @@ int main(int argc, char **argv)
 				absolute_percpu = 1;
 			else if (strcmp(argv[i], "--base-relative") == 0)
 				base_relative = 1;
+			else if (strcmp(argv[i], "--use-data-section") == 0)
+				use_data_section = 1;
 			else if (strncmp(argv[i], "--symbol-prefix=", 16) == 0) {
 				char *p = &argv[i][16];
 				/* skip quote */
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 553d966a1986..3fc1fc406b38 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -133,6 +133,10 @@ kallsyms()
 		kallsymopt="${kallsymopt} --base-relative"
 	fi
 
+	if [ -n "${CONFIG_KALLSYMS_USE_DATA_SECTION}" ]; then
+		kallsymopt="${kallsymopt} --use-data-section"
+	fi
+
 	local aflags="${KBUILD_AFLAGS} ${KBUILD_AFLAGS_KERNEL}               \
 		      ${NOSTDINC_FLAGS} ${LINUXINCLUDE} ${KBUILD_CPPFLAGS}"
 
-- 
2.20.1 (Apple Git-117)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

