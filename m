Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from smtp1.axis.com ([195.60.68.17])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1muybV-00D6tO-FM
 for linux-um@lists.infradead.org; Wed, 08 Dec 2021 15:11:35 +0000
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH 1/2] um: Extract load file helper from initrd.c
Date: Wed, 8 Dec 2021 16:11:22 +0100
Message-ID: <20211208151123.29313-2-vincent.whitchurch@axis.com>
In-Reply-To: <20211208151123.29313-1-vincent.whitchurch@axis.com>
References: <20211208151123.29313-1-vincent.whitchurch@axis.com>
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
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: kernel@axis.com, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, devicetree@vger.kernel.org, Vincent Whitchurch <vincent.whitchurch@axis.com>

The file loading support in initrd.c can be re-used for
loading devicetrees.  Move it out of initrd.c.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 arch/um/kernel/Makefile    |  1 +
 arch/um/kernel/initrd.c    | 48 ++++--------------------------
 arch/um/kernel/load_file.c | 61 ++++++++++++++++++++++++++++++++++++++
 arch/um/kernel/um_arch.h   |  8 +++++
 4 files changed, 75 insertions(+), 43 deletions(-)
 create mode 100644 arch/um/kernel/load_file.c
 create mode 100644 arch/um/kernel/um_arch.h

diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index 1d18e4e46989..92692bfef7ae 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -18,6 +18,7 @@ obj-y = config.o exec.o exitcode.o irq.o ksyms.o mem.o \
 	physmem.o process.o ptrace.o reboot.o sigio.o \
 	signal.o syscall.o sysrq.o time.o tlb.o trap.o \
 	um_arch.o umid.o maccess.o kmsg_dump.o capflags.o skas/
+obj-y += load_file.o
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
diff --git a/arch/um/kernel/initrd.c b/arch/um/kernel/initrd.c
index c1981ffb7179..47b8cb1a1156 100644
--- a/arch/um/kernel/initrd.c
+++ b/arch/um/kernel/initrd.c
@@ -10,37 +10,21 @@
 #include <init.h>
 #include <os.h>
 
+#include "um_arch.h"
+
 /* Changed by uml_initrd_setup, which is a setup */
 static char *initrd __initdata = NULL;
-static int load_initrd(char *filename, void *buf, int size);
 
 int __init read_initrd(void)
 {
+	unsigned long long size;
 	void *area;
-	long long size;
-	int err;
-
-	if (initrd == NULL)
-		return 0;
 
-	err = os_file_size(initrd, &size);
-	if (err)
+	if (!initrd)
 		return 0;
 
-	/*
-	 * This is necessary because alloc_bootmem craps out if you
-	 * ask for no memory.
-	 */
-	if (size == 0) {
-		printk(KERN_ERR "\"%s\" is a zero-size initrd\n", initrd);
-		return 0;
-	}
-
-	area = memblock_alloc(size, SMP_CACHE_BYTES);
+	area = uml_load_file(initrd, &size);
 	if (!area)
-		panic("%s: Failed to allocate %llu bytes\n", __func__, size);
-
-	if (load_initrd(initrd, area, size) == -1)
 		return 0;
 
 	initrd_start = (unsigned long) area;
@@ -59,25 +43,3 @@ __uml_setup("initrd=", uml_initrd_setup,
 "    This is used to boot UML from an initrd image.  The argument is the\n"
 "    name of the file containing the image.\n\n"
 );
-
-static int load_initrd(char *filename, void *buf, int size)
-{
-	int fd, n;
-
-	fd = os_open_file(filename, of_read(OPENFLAGS()), 0);
-	if (fd < 0) {
-		printk(KERN_ERR "Opening '%s' failed - err = %d\n", filename,
-		       -fd);
-		return -1;
-	}
-	n = os_read_file(fd, buf, size);
-	if (n != size) {
-		printk(KERN_ERR "Read of %d bytes from '%s' failed, "
-		       "err = %d\n", size,
-		       filename, -n);
-		return -1;
-	}
-
-	os_close_file(fd);
-	return 0;
-}
diff --git a/arch/um/kernel/load_file.c b/arch/um/kernel/load_file.c
new file mode 100644
index 000000000000..5cecd0e291fb
--- /dev/null
+++ b/arch/um/kernel/load_file.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+ */
+#include <linux/memblock.h>
+#include <os.h>
+
+#include "um_arch.h"
+
+static int __init __uml_load_file(const char *filename, void *buf, int size)
+{
+	int fd, n;
+
+	fd = os_open_file(filename, of_read(OPENFLAGS()), 0);
+	if (fd < 0) {
+		printk(KERN_ERR "Opening '%s' failed - err = %d\n", filename,
+		       -fd);
+		return -1;
+	}
+	n = os_read_file(fd, buf, size);
+	if (n != size) {
+		printk(KERN_ERR "Read of %d bytes from '%s' failed, "
+		       "err = %d\n", size,
+		       filename, -n);
+		return -1;
+	}
+
+	os_close_file(fd);
+	return 0;
+}
+
+void *uml_load_file(const char *filename, unsigned long long *size)
+{
+	void *area;
+	int err;
+
+	*size = 0;
+
+	if (!filename)
+		return NULL;
+
+	err = os_file_size(filename, size);
+	if (err)
+		return NULL;
+
+	if (*size == 0) {
+		printk(KERN_ERR "\"%s\" is empty\n", filename);
+		return NULL;
+	}
+
+	area = memblock_alloc(*size, SMP_CACHE_BYTES);
+	if (!area)
+		panic("%s: Failed to allocate %llu bytes\n", __func__, *size);
+
+	if (__uml_load_file(filename, area, *size)) {
+		memblock_free(area, *size);
+		return NULL;
+	}
+
+	return area;
+}
diff --git a/arch/um/kernel/um_arch.h b/arch/um/kernel/um_arch.h
new file mode 100644
index 000000000000..b195df3a09a0
--- /dev/null
+++ b/arch/um/kernel/um_arch.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __UML_ARCH_H__
+#define __UML_ARCH_H__
+
+extern void * __init uml_load_file(const char *filename, unsigned long long *size);
+
+#endif
-- 
2.33.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

