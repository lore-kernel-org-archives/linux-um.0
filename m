Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v3 01/15] modpost: mitigate false-negatives for static
 EXPORT_SYMBOL checks
Date: Thu,  5 May 2022 16:22:30 +0900
Message-Id: <20220505072244.1155033-2-masahiroy@kernel.org>
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

The 'static' specifier and EXPORT_SYMBOL() are an odd combination.

Since commit 15bfc2348d54 ("modpost: check for static EXPORT_SYMBOL*
functions"), modpost tries to detect it, but there are false negatives.

Here is the sample code.

[Sample 1]

  Makefile:

    obj-m += mymod1.o mymod2.o

  mymod1.c:

    #include <linux/export.h>
    #include <linux/module.h>
    static void foo(void) {}
    EXPORT_SYMBOL(foo);
    MODULE_LICENSE("GPL");

  mymod2.c:

    #include <linux/module.h>
    void foo(void) {}
    MODULE_LICENSE("GPL");

mymod1 exports the static symbol 'foo', but modpost cannot catch it
because it is fooled by the same name symbol in another module, mymod2.
(Without mymod2, modpost can detect the error in mymod1)

find_symbol() returns the first symbol found in the hash table with the
given name. This hash table is global, so it may return a symbol from
an unrelated module. So, a global symbol in a module may unset the
'is_static' flag of another module.

To mitigate this issue, add sym_find_with_module(), which receives the
module pointer as the second argument. If non-NULL pointer is passed, it
returns the symbol in the specified module. If NULL is passed, it is
equivalent to find_module().

Please note there are still false positives in the composite module,
like below (or when both are built-in). I have no idea how to do this
correctly.

[Sample 2]  (not fixed by this commit)

  Makefile:
    obj-m += mymod.o
    mymod-objs := mymod1.o mymod2.o

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v2)

Changes in v2:
  - Rename the new func to sym_find_with_module()

 scripts/mod/modpost.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index b605f4a58759..a55fa2b88a9a 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -272,7 +272,7 @@ static void sym_add_unresolved(const char *name, struct module *mod, bool weak)
 	list_add_tail(&sym->list, &mod->unresolved_symbols);
 }
 
-static struct symbol *find_symbol(const char *name)
+static struct symbol *sym_find_with_module(const char *name, struct module *mod)
 {
 	struct symbol *s;
 
@@ -281,12 +281,17 @@ static struct symbol *find_symbol(const char *name)
 		name++;
 
 	for (s = symbolhash[tdb_hash(name) % SYMBOL_HASH_SIZE]; s; s = s->next) {
-		if (strcmp(s->name, name) == 0)
+		if (strcmp(s->name, name) == 0 && (!mod || s->module == mod))
 			return s;
 	}
 	return NULL;
 }
 
+static struct symbol *find_symbol(const char *name)
+{
+	return sym_find_with_module(name, NULL);
+}
+
 struct namespace_list {
 	struct list_head list;
 	char namespace[];
@@ -2063,8 +2068,9 @@ static void read_symbols(const char *modname)
 
 		if (bind == STB_GLOBAL || bind == STB_WEAK) {
 			struct symbol *s =
-				find_symbol(remove_dot(info.strtab +
-						       sym->st_name));
+				sym_find_with_module(remove_dot(info.strtab +
+								sym->st_name),
+						     mod);
 
 			if (s)
 				s->is_static = false;
-- 
2.32.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

