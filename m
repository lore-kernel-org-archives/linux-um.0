Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] uml: fix W=1 missing-include-dirs warnings
Date: Wed, 14 Apr 2021 12:26:57 -0700
Message-Id: <20210414192657.17764-1-rdunlap@infradead.org>
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
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Masahiro Yamada <masahiroy@kernel.org>, Michal Marek <michal.lkml@markovi.net>, linux-kbuild@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org

Currently when using "W=1" with UML builds, there are over 700 warnings
like so:

  CC      arch/um/drivers/stderr_console.o
cc1: warning: ./arch/um/include/uapi: No such file or directory [-Wmissing-include-dirs]

but arch/um/ does not have include/uapi/ at all, so don't
include arch/um/include/uapi/ in USERINCLUDE for UML.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: linux-kbuild@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
---
 Makefile |   10 ++++++++++
 1 file changed, 10 insertions(+)

Option 2: change the setting of USERINCLUDE. This could alter
	(a) build times and
	(b) which header files get used: if there are multiple
	    header files named foobar.h in the $(USERINCLUDE)
	    subdirectories, this Option changes the order in which
	    they would be found.

- linux-next-20210413.orig/Makefile
+ linux-next-20210413/Makefile
@@ -501,13 +501,16 @@ LDFLAGS_vmlinux =
 
 # Use USERINCLUDE when you must reference the UAPI directories only.
 USERINCLUDE    := \
-		-I$(srctree)/arch/$(SRCARCH)/include/uapi \
 		-I$(objtree)/arch/$(SRCARCH)/include/generated/uapi \
 		-I$(srctree)/include/uapi \
 		-I$(objtree)/include/generated/uapi \
                 -include $(srctree)/include/linux/compiler-version.h \
                 -include $(srctree)/include/linux/kconfig.h
 
+ifneq ($(ARCH),um)
+USERINCLUDE    += -I$(srctree)/arch/$(SRCARCH)/include/uapi
+endif
+
 # Use LINUXINCLUDE when you must reference the include/ directory.
 # Needed to be compatible with the O= option
 LINUXINCLUDE    := \

Option 3: modify scripts/Makefile.extrawarn not to set
	-Wmissing-include-dirs for arch=um. I think that this is not
	a good idea: it could cause valid problem reports not to be
	reported.

Option 4: simply mkdir arch/um/include/uapi
	That's what I did first, just as a test, and it works.

--- linux-next-20210413.orig/Makefile
+++ linux-next-20210413/Makefile
@@ -500,6 +500,15 @@ AFLAGS_KERNEL	=
 LDFLAGS_vmlinux =
 
 # Use USERINCLUDE when you must reference the UAPI directories only.
+# Note: arch/um/ does not have an include/uapi/ subdir.
+ifeq ($(ARCH),um)
+USERINCLUDE    := \
+		-I$(objtree)/arch/$(SRCARCH)/include/generated/uapi \
+		-I$(srctree)/include/uapi \
+		-I$(objtree)/include/generated/uapi \
+                -include $(srctree)/include/linux/compiler-version.h \
+                -include $(srctree)/include/linux/kconfig.h
+else
 USERINCLUDE    := \
 		-I$(srctree)/arch/$(SRCARCH)/include/uapi \
 		-I$(objtree)/arch/$(SRCARCH)/include/generated/uapi \
@@ -507,6 +516,7 @@ USERINCLUDE    := \
 		-I$(objtree)/include/generated/uapi \
                 -include $(srctree)/include/linux/compiler-version.h \
                 -include $(srctree)/include/linux/kconfig.h
+endif
 
 # Use LINUXINCLUDE when you must reference the include/ directory.
 # Needed to be compatible with the O= option

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

