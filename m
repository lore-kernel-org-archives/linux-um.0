Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from smtp2.axis.com ([195.60.68.18])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1muybT-00D6ta-Hj
 for linux-um@lists.infradead.org; Wed, 08 Dec 2021 15:11:33 +0000
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH 2/2] um: Add devicetree support
Date: Wed, 8 Dec 2021 16:11:23 +0100
Message-ID: <20211208151123.29313-3-vincent.whitchurch@axis.com>
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

Add a dtb=<filename> option to boot UML with a devicetree blob.  This
can be used for testing driver code using UML.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 arch/um/Kconfig          |  1 +
 arch/um/kernel/Makefile  |  1 +
 arch/um/kernel/dtb.c     | 41 ++++++++++++++++++++++++++++++++++++++++
 arch/um/kernel/um_arch.c |  3 +++
 arch/um/kernel/um_arch.h |  6 ++++++
 5 files changed, 52 insertions(+)
 create mode 100644 arch/um/kernel/dtb.c

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index c18b45f75d41..1cf7ef3a2b81 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -18,6 +18,7 @@ config UML
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DEBUG_BUGVERBOSE
 	select NO_DMA if !UML_DMA_EMULATION
+	select OF_EARLY_FLATTREE
 	select GENERIC_IRQ_SHOW
 	select GENERIC_CPU_DEVICES
 	select HAVE_GCC_PLUGINS
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index 92692bfef7ae..ebd0cca3ff26 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -22,6 +22,7 @@ obj-y += load_file.o
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
+obj-$(CONFIG_OF) += dtb.o
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
 obj-$(CONFIG_GENERIC_PCI_IOMAP) += ioport.o
diff --git a/arch/um/kernel/dtb.c b/arch/um/kernel/dtb.c
new file mode 100644
index 000000000000..ca69d72025f3
--- /dev/null
+++ b/arch/um/kernel/dtb.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/init.h>
+#include <linux/of_fdt.h>
+#include <linux/printk.h>
+#include <linux/memblock.h>
+#include <init.h>
+
+#include "um_arch.h"
+
+static char *dtb __initdata;
+
+void uml_dtb_init(void)
+{
+	long long size;
+	void *area;
+
+	area = uml_load_file(dtb, &size);
+	if (!area)
+		return;
+
+	if (!early_init_dt_scan(area)) {
+		pr_err("invalid DTB %s\n", dtb);
+		memblock_free(area, size);
+		return;
+	}
+
+	unflatten_device_tree();
+	early_init_fdt_scan_reserved_mem();
+}
+
+static int __init uml_dtb_setup(char *line, int *add)
+{
+	dtb = line;
+	return 0;
+}
+
+__uml_setup("dtb=", uml_dtb_setup,
+"dtb=<file>\n"
+"    Boot the kernel with the devicetree blob from the specified file.\n"
+);
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 54447690de11..abceeabe29b9 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -29,6 +29,8 @@
 #include <mem_user.h>
 #include <os.h>
 
+#include "um_arch.h"
+
 #define DEFAULT_COMMAND_LINE_ROOT "root=98:0"
 #define DEFAULT_COMMAND_LINE_CONSOLE "console=tty"
 
@@ -407,6 +409,7 @@ void __init setup_arch(char **cmdline_p)
 	stack_protections((unsigned long) &init_thread_info);
 	setup_physmem(uml_physmem, uml_reserved, physmem_size, highmem);
 	mem_total_pages(physmem_size, iomem_size, highmem);
+	uml_dtb_init();
 	read_initrd();
 
 	paging_init();
diff --git a/arch/um/kernel/um_arch.h b/arch/um/kernel/um_arch.h
index b195df3a09a0..1e07fb7ee35e 100644
--- a/arch/um/kernel/um_arch.h
+++ b/arch/um/kernel/um_arch.h
@@ -5,4 +5,10 @@
 
 extern void * __init uml_load_file(const char *filename, unsigned long long *size);
 
+#ifdef CONFIG_OF
+extern void __init uml_dtb_init(void);
+#else
+static inline void uml_dtb_init(void) { }
+#endif
+
 #endif
-- 
2.33.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

