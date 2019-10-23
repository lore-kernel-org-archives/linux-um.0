Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iN8QJ-0001nl-VR
 for linux-um@lists.infradead.org; Wed, 23 Oct 2019 04:39:09 +0000
Received: by mail-pf1-x443.google.com with SMTP id q5so12072088pfg.13
 for <linux-um@lists.infradead.org>; Tue, 22 Oct 2019 21:39:03 -0700 (PDT)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC PATCH 25/47] lkl: add support for Windows hosts
Date: Wed, 23 Oct 2019 13:37:59 +0900
Message-Id: <31f7efdcae5061daf86c0dcec2f11c326eee408d.1571798507.git.thehajime@gmail.com>
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
Cc: Octavian Purdila <tavi.purdila@gmail.com>, Jens Staal <staal1978@gmail.com>, Hajime Tazaki <thehajime@gmail.com>, Akira Moroo <retrage01@gmail.com>

From: Octavian Purdila <tavi.purdila@gmail.com>

This patch allows LKL to be compiled for windows hosts with the mingw
toolchain. Note that patches [1] that fix weak symbols linking are
required to successfully compile LKL with mingw.

The patch disables the modpost pass over vmlinux since modpost only
works with ELF objects.

It also adds and workaround to an #include_next <stdard.h> error which
is apparently caused by using -nosdtinc.

[1] https://sourceware.org/ml/binutils/2015-10/msg00234.html

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Jens Staal <staal1978@gmail.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 arch/um/lkl/include/system/stdarg.h | 2 ++
 include/linux/compiler_attributes.h | 4 ++++
 lib/.gitignore                      | 2 ++
 lib/raid6/.gitignore                | 1 +
 scripts/.gitignore                  | 2 ++
 scripts/basic/.gitignore            | 1 +
 scripts/kconfig/.gitignore          | 1 +
 scripts/link-vmlinux.sh             | 2 ++
 scripts/mod/.gitignore              | 1 +
 9 files changed, 16 insertions(+)
 create mode 100644 arch/um/lkl/include/system/stdarg.h

diff --git a/arch/um/lkl/include/system/stdarg.h b/arch/um/lkl/include/system/stdarg.h
new file mode 100644
index 000000000000..12077a36828c
--- /dev/null
+++ b/arch/um/lkl/include/system/stdarg.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* empty file to avoid #include_next<stdarg.h> error */
diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 6b318efd8a74..1981b1c323c1 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -154,7 +154,11 @@
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-format-function-attribute
  * clang: https://clang.llvm.org/docs/AttributeReference.html#format
  */
+#ifdef __MINGW32__
+#define __printf(a, b)             __attribute__((__format__(gnu_printf, a, b)))
+#else
 #define __printf(a, b)                  __attribute__((__format__(printf, a, b)))
+#endif
 #define __scanf(a, b)                   __attribute__((__format__(scanf, a, b)))
 
 /*
diff --git a/lib/.gitignore b/lib/.gitignore
index f2a39c9e5485..eb9f11b81fe1 100644
--- a/lib/.gitignore
+++ b/lib/.gitignore
@@ -2,7 +2,9 @@
 # Generated files
 #
 gen_crc32table
+gen_crc32table.exe
 gen_crc64table
+gen_crc64table.exe
 crc32table.h
 crc64table.h
 oid_registry_data.c
diff --git a/lib/raid6/.gitignore b/lib/raid6/.gitignore
index 3de0d8921286..80e3566535aa 100644
--- a/lib/raid6/.gitignore
+++ b/lib/raid6/.gitignore
@@ -1,4 +1,5 @@
 mktables
+mktables.exe
 altivec*.c
 int*.c
 tables.c
diff --git a/scripts/.gitignore b/scripts/.gitignore
index 17f8cef88fa8..ec9138a39b25 100644
--- a/scripts/.gitignore
+++ b/scripts/.gitignore
@@ -4,8 +4,10 @@
 bin2c
 conmakehash
 kallsyms
+kallsyms.exe
 pnmtologo
 unifdef
+unifdef.exe
 recordmcount
 sortextable
 asn1_compiler
diff --git a/scripts/basic/.gitignore b/scripts/basic/.gitignore
index a776371a3502..77ce153243fa 100644
--- a/scripts/basic/.gitignore
+++ b/scripts/basic/.gitignore
@@ -1 +1,2 @@
 fixdep
+fixdep.exe
diff --git a/scripts/kconfig/.gitignore b/scripts/kconfig/.gitignore
index b5bf92f66d11..aa27000d896f 100644
--- a/scripts/kconfig/.gitignore
+++ b/scripts/kconfig/.gitignore
@@ -8,6 +8,7 @@
 # configuration programs
 #
 conf
+conf.exe
 mconf
 nconf
 qconf
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 915775eb2921..27d2066238c7 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -205,6 +205,7 @@ fi;
 # final build of init/
 ${MAKE} -f "${srctree}/scripts/Makefile.build" obj=init
 
+if [ -e scripts/mod/modpost ]; then
 #link vmlinux.o
 info LD vmlinux.o
 modpost_link vmlinux.o
@@ -214,6 +215,7 @@ ${MAKE} -f "${srctree}/scripts/Makefile.modpost" MODPOST_VMLINUX=1
 
 info MODINFO modules.builtin.modinfo
 ${OBJCOPY} -j .modinfo -O binary vmlinux.o modules.builtin.modinfo
+fi
 
 kallsymso=""
 kallsyms_vmlinux=""
diff --git a/scripts/mod/.gitignore b/scripts/mod/.gitignore
index 3bd11b603173..cd67845e326d 100644
--- a/scripts/mod/.gitignore
+++ b/scripts/mod/.gitignore
@@ -1,4 +1,5 @@
 elfconfig.h
 mk_elfconfig
 modpost
+modpost.exe
 devicetable-offsets.h
-- 
2.20.1 (Apple Git-117)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

