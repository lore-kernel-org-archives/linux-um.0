Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v3 07/15] modpost: extract symbol versions from *.cmd files
Date: Thu,  5 May 2022 16:22:36 +0900
Message-Id: <20220505072244.1155033-8-masahiroy@kernel.org>
In-Reply-To: <20220505072244.1155033-1-masahiroy@kernel.org>
References: <20220505072244.1155033-1-masahiroy@kernel.org>
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
To: linux-kbuild@vger.kernel.org
Cc: clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org, Nicolas Schier a <nicolas@fjasle.eu>, Ard Biesheuvel <ardb@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org, linux-um@lists.infradead.org, linux-s390@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>, Sami Tolvanen <samitolvanen@google.com>, Kees Cook <keescook@chromium.org>, Masahiro Yamada <masahiroy@kernel.org>

Currently, CONFIG_MODVERSIONS needs extra link to embed the symbol
versions into ELF objects. Then, modpost extracts the version CRCs
from them.

The following figures show how it currently works, and how I am trying
to change it.

Current implementation
======================
                                                           |----------|
                 embed CRC      -------------------------->| final    |
      $(CC)        $(LD)       /  |---------|              | link for |
  *.c ------> *.o -------> *.o -->| modpost |              | vmlinux  |
                     /            |         |-- *.mod.c -->| or       |
     genksyms       /             |---------|              | module   |
  *.c ------> *.symversions                                |----------|

Genksyms outputs the calculated CRCs in the form of linker script
(*.symversions), which is used by $(LD) to update the object.

If CONFIG_LTO_CLANG=y, the build process becomes much more complex.
Embedding the CRCs is postponed until the LLVM bitcode is converted
into ELF, creating another intermediate *.prelink.o.

However, this complexity is unneeded. There is no reason why we must
embed version CRCs in objects so early.

There is final link stage for vmlinux (scripts/link-vmlinux.sh) and
modules (scripts/Makefile.modfinal). We can link CRCs at the very last
moment.

New implementation
==================
                                                           |----------|
                   --------------------------------------->| final    |
      $(CC)       /    |---------|                         | link for |
  *.c ------> *.o ---->|         |                         | vmlinux  |
                       | modpost |--- .vmlinux-symver.c -->| or       |
     genksyms          |         |--- *.mod.c ------------>| module   |
  *.c ------> *.cmd -->|---------|                         |----------|

Pass the symbol versions to modpost as separate text data, which are
available in *.cmd files.

This commit changes modpost to extract CRCs from *.cmd files instead of
from ELF objects.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v2)

Changes in v2:
  - Simplify the implementation (parse .cmd files after ELF)

 scripts/mod/modpost.c | 177 ++++++++++++++++++++++++++++++------------
 1 file changed, 129 insertions(+), 48 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 78a7107fcc40..92ee1f454e29 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -383,19 +383,10 @@ static struct symbol *sym_add_exported(const char *name, struct module *mod,
 	return s;
 }
 
-static void sym_set_crc(const char *name, unsigned int crc)
+static void sym_set_crc(struct symbol *sym, unsigned int crc)
 {
-	struct symbol *s = find_symbol(name);
-
-	/*
-	 * Ignore stand-alone __crc_*, which might be auto-generated symbols
-	 * such as __*_veneer in ARM ELF.
-	 */
-	if (!s)
-		return;
-
-	s->crc = crc;
-	s->crc_valid = true;
+	sym->crc = crc;
+	sym->crc_valid = true;
 }
 
 static void *grab_file(const char *filename, size_t *size)
@@ -618,33 +609,6 @@ static int ignore_undef_symbol(struct elf_info *info, const char *symname)
 	return 0;
 }
 
-static void handle_modversion(const struct module *mod,
-			      const struct elf_info *info,
-			      const Elf_Sym *sym, const char *symname)
-{
-	unsigned int crc;
-
-	if (sym->st_shndx == SHN_UNDEF) {
-		warn("EXPORT symbol \"%s\" [%s%s] version generation failed, symbol will not be versioned.\n"
-		     "Is \"%s\" prototyped in <asm/asm-prototypes.h>?\n",
-		     symname, mod->name, mod->is_vmlinux ? "" : ".ko",
-		     symname);
-
-		return;
-	}
-
-	if (sym->st_shndx == SHN_ABS) {
-		crc = sym->st_value;
-	} else {
-		unsigned int *crcp;
-
-		/* symbol points to the CRC in the ELF object */
-		crcp = sym_get_data(info, sym);
-		crc = TO_NATIVE(*crcp);
-	}
-	sym_set_crc(symname, crc);
-}
-
 static void handle_symbol(struct module *mod, struct elf_info *info,
 			  const Elf_Sym *sym, const char *symname)
 {
@@ -1955,6 +1919,102 @@ static char *remove_dot(char *s)
 	return s;
 }
 
+/*
+ * The CRCs are recorded in .*.cmd files in the form of:
+ * #SYMVER <name> <crc>
+ */
+static void extract_crcs_for_object(const char *object, struct module *mod)
+{
+	char cmd_file[PATH_MAX];
+	char *buf, *p;
+	const char *base;
+	int dirlen, ret;
+
+	base = strrchr(object, '/');
+	if (base) {
+		base++;
+		dirlen = base - object;
+	} else {
+		dirlen = 0;
+		base = object;
+	}
+
+	ret = snprintf(cmd_file, sizeof(cmd_file), "%.*s.%s.cmd",
+		       dirlen, object, base);
+	if (ret >= sizeof(cmd_file)) {
+		error("%s: too long path was truncated\n", cmd_file);
+		return;
+	}
+
+	buf = read_text_file(cmd_file);
+	p = buf;
+
+	while ((p = strstr(p, "\n#SYMVER "))) {
+		char *name;
+		size_t namelen;
+		unsigned int crc;
+		struct symbol *sym;
+
+		name = p + strlen("\n#SYMVER ");
+
+		p = strchr(name, ' ');
+		if (!p)
+			break;
+
+		namelen = p - name;
+		p++;
+
+		if (!isdigit(*p))
+			continue;	/* skip this line */
+
+		crc = strtol(p, &p, 0);
+		if (*p != '\n')
+			continue;	/* skip this line */
+
+		name[namelen] = '\0';
+
+		sym = sym_find_with_module(name, mod);
+		if (!sym) {
+			warn("Skip the version for unexported symbol \"%s\" [%s%s]\n",
+			     name, mod->name, mod->is_vmlinux ? "" : ".ko");
+			continue;
+		}
+		sym_set_crc(sym, crc);
+	}
+
+	free(buf);
+}
+
+/*
+ * The symbol versions (CRC) are recorded in the .*.cmd files.
+ * Parse them to retrieve CRCs for the current module.
+ */
+static void mod_set_crcs(struct module *mod)
+{
+	char objlist[PATH_MAX];
+	char *buf, *p, *obj;
+	int ret;
+
+	if (mod->is_vmlinux) {
+		strcpy(objlist, ".vmlinux.objs");
+	} else {
+		/* objects for a module are listed in the *.mod file. */
+		ret = snprintf(objlist, sizeof(objlist), "%s.mod", mod->name);
+		if (ret >= sizeof(objlist)) {
+			error("%s: too long path was truncated\n", objlist);
+			return;
+		}
+	}
+
+	buf = read_text_file(objlist);
+	p = buf;
+
+	while ((obj = strsep(&p, "\n")) && obj[0])
+		extract_crcs_for_object(obj, mod);
+
+	free(buf);
+}
+
 static void read_symbols(const char *modname)
 {
 	const char *symname;
@@ -2015,9 +2075,6 @@ static void read_symbols(const char *modname)
 		if (strstarts(symname, "__kstrtabns_"))
 			sym_update_namespace(symname + strlen("__kstrtabns_"),
 					     sym_get_data(&info, sym));
-		if (strstarts(symname, "__crc_"))
-			handle_modversion(mod, &info, sym,
-					  symname + strlen("__crc_"));
 	}
 
 	// check for static EXPORT_SYMBOL_* functions && global vars
@@ -2046,12 +2103,17 @@ static void read_symbols(const char *modname)
 
 	parse_elf_finish(&info);
 
-	/* Our trick to get versioning for module struct etc. - it's
-	 * never passed as an argument to an exported function, so
-	 * the automatic versioning doesn't pick it up, but it's really
-	 * important anyhow */
-	if (modversions)
+	if (modversions) {
+		/*
+		 * Our trick to get versioning for module struct etc. - it's
+		 * never passed as an argument to an exported function, so
+		 * the automatic versioning doesn't pick it up, but it's really
+		 * important anyhow
+		 */
 		sym_add_unresolved("module_layout", mod, false);
+
+		mod_set_crcs(mod);
+	}
 }
 
 static void read_symbols_from_files(const char *filename)
@@ -2214,6 +2276,23 @@ static void add_header(struct buffer *b, struct module *mod)
 		buf_printf(b, "\nMODULE_INFO(staging, \"Y\");\n");
 }
 
+static void check_symversions(struct module *mod)
+{
+	struct symbol *sym;
+
+	if (!modversions)
+		return;
+
+	list_for_each_entry(sym, &mod->exported_symbols, list) {
+		if (!sym->crc_valid) {
+			warn("EXPORT symbol \"%s\" [%s%s] version generation failed, symbol will not be versioned.\n"
+			     "Is \"%s\" prototyped in <asm/asm-prototypes.h>?\n",
+			     sym->name, mod->name, mod->is_vmlinux ? "" : ".ko",
+			     sym->name);
+		}
+	}
+}
+
 /**
  * Record CRCs for unresolved symbols
  **/
@@ -2429,7 +2508,7 @@ static void read_dump(const char *fname)
 		}
 		s = sym_add_exported(symname, mod, gpl_only);
 		s->is_static = false;
-		sym_set_crc(symname, crc);
+		sym_set_crc(s, crc);
 		sym_update_namespace(symname, namespace);
 	}
 	free(buf);
@@ -2554,6 +2633,8 @@ int main(int argc, char **argv)
 		if (mod->from_dump)
 			continue;
 
+		check_symversions(mod);
+
 		if (!mod->is_vmlinux)
 			write_mod_c_file(mod);
 	}
-- 
2.32.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

