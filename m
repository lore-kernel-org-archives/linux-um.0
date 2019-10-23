Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iN8kk-0001wO-Dg
 for linux-um@lists.infradead.org; Wed, 23 Oct 2019 05:00:15 +0000
Received: by mail-pg1-x543.google.com with SMTP id p1so11386930pgi.4
 for <linux-um@lists.infradead.org>; Tue, 22 Oct 2019 22:00:10 -0700 (PDT)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC PATCH 42/47] Revert "kallsyms: remove symbol prefix support"
Date: Wed, 23 Oct 2019 13:38:16 +0900
Message-Id: <69d18908bbc2bd8548be61889f69a1884bed659a.1571798507.git.thehajime@gmail.com>
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

This reverts commit 534c9f2ec4c92adbe8791125e7ba66d5023ad51f.

for lkl, mingw32 requires underscore-ed symbols.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 scripts/kallsyms.c      | 49 +++++++++++++++++++++++++++++++----------
 scripts/link-vmlinux.sh |  4 ++++
 2 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index ae6504d07fd6..8a62e1b6cf22 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -60,6 +60,7 @@ static struct sym_entry *table;
 static unsigned int table_size, table_cnt;
 static int all_symbols = 0;
 static int absolute_percpu = 0;
+static char symbol_prefix_char = '\0';
 static int base_relative = 0;
 
 static int token_profit[0x10000];
@@ -72,6 +73,7 @@ static unsigned char best_table_len[256];
 static void usage(void)
 {
 	fprintf(stderr, "Usage: kallsyms [--all-symbols] "
+			"[--symbol-prefix=<prefix char>] "
 			"[--base-relative] < in.map > out.S\n");
 	exit(1);
 }
@@ -109,22 +111,28 @@ static int check_symbol_range(const char *sym, unsigned long long addr,
 
 static int read_symbol(FILE *in, struct sym_entry *s)
 {
-	char sym[500], stype;
+	char str[500];
+	char *sym, stype;
 	int rc;
 
-	rc = fscanf(in, "%llx %c %499s\n", &s->addr, &stype, sym);
+	rc = fscanf(in, "%llx %c %499s\n", &s->addr, &stype, str);
 	if (rc != 3) {
-		if (rc != EOF && fgets(sym, 500, in) == NULL)
+		if (rc != EOF && fgets(str, 500, in) == NULL)
 			fprintf(stderr, "Read error or end of file.\n");
 		return -1;
 	}
-	if (strlen(sym) >= KSYM_NAME_LEN) {
-		fprintf(stderr, "Symbol %s too long for kallsyms (%zu >= %d).\n"
+	if (strlen(str) > KSYM_NAME_LEN) {
+		fprintf(stderr, "Symbol %s too long for kallsyms (%zu vs %d).\n"
 				"Please increase KSYM_NAME_LEN both in kernel and kallsyms.c\n",
-			sym, strlen(sym), KSYM_NAME_LEN);
+			str, strlen(str), KSYM_NAME_LEN);
 		return -1;
 	}
 
+	sym = str;
+	/* skip prefix char */
+	if (symbol_prefix_char && str[0] == symbol_prefix_char)
+		sym++;
+
 	/* Ignore most absolute/undefined (?) symbols. */
 	if (strcmp(sym, "_text") == 0)
 		_text = s->addr;
@@ -145,7 +153,7 @@ static int read_symbol(FILE *in, struct sym_entry *s)
 		 is_arm_mapping_symbol(sym))
 		return -1;
 	/* exclude also MIPS ELF local symbols ($L123 instead of .L123) */
-	else if (sym[0] == '$')
+	else if (str[0] == '$')
 		return -1;
 	/* exclude debugging symbols */
 	else if (stype == 'N' || stype == 'n')
@@ -156,14 +164,14 @@ static int read_symbol(FILE *in, struct sym_entry *s)
 
 	/* include the type field in the symbol name, so that it gets
 	 * compressed together */
-	s->len = strlen(sym) + 1;
+	s->len = strlen(str) + 1;
 	s->sym = malloc(s->len + 1);
 	if (!s->sym) {
 		fprintf(stderr, "kallsyms failure: "
 			"unable to allocate required amount of memory\n");
 		exit(EXIT_FAILURE);
 	}
-	strcpy((char *)s->sym + 1, sym);
+	strcpy((char *)s->sym + 1, str);
 	s->sym[0] = stype;
 
 	s->percpu_absolute = 0;
@@ -226,6 +234,11 @@ static int symbol_valid(struct sym_entry *s)
 	int i;
 	char *sym_name = (char *)s->sym + 1;
 
+	/* skip prefix char */
+	if (symbol_prefix_char && *sym_name == symbol_prefix_char)
+		sym_name++;
+
+
 	/* if --all-symbols is not specified, then symbols outside the text
 	 * and inittext sections are discarded */
 	if (!all_symbols) {
@@ -290,9 +303,15 @@ static void read_map(FILE *in)
 
 static void output_label(char *label)
 {
-	printf(".globl %s\n", label);
+	if (symbol_prefix_char)
+		printf(".globl %c%s\n", symbol_prefix_char, label);
+	else
+		printf(".globl %s\n", label);
 	printf("\tALGN\n");
-	printf("%s:\n", label);
+	if (symbol_prefix_char)
+		printf("%c%s:\n", symbol_prefix_char, label);
+	else
+		printf("%s:\n", label);
 }
 
 /* uncompress a compressed symbol. When this function is called, the best table
@@ -749,7 +768,13 @@ int main(int argc, char **argv)
 				absolute_percpu = 1;
 			else if (strcmp(argv[i], "--base-relative") == 0)
 				base_relative = 1;
-			else
+			else if (strncmp(argv[i], "--symbol-prefix=", 16) == 0) {
+				char *p = &argv[i][16];
+				/* skip quote */
+				if ((*p == '"' && *(p+2) == '"') || (*p == '\'' && *(p+2) == '\''))
+					p++;
+				symbol_prefix_char = *p;
+			} else
 				usage();
 		}
 	} else if (argc != 1)
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 27d2066238c7..553d966a1986 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -117,6 +117,10 @@ kallsyms()
 	info KSYM ${2}
 	local kallsymopt;
 
+	if [ -n "${CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX}" ]; then
+		kallsymopt="${kallsymopt} --symbol-prefix=_"
+	fi
+
 	if [ -n "${CONFIG_KALLSYMS_ALL}" ]; then
 		kallsymopt="${kallsymopt} --all-symbols"
 	fi
-- 
2.20.1 (Apple Git-117)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

