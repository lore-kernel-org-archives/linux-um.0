Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l23Eu-0002II-Ea
 for linux-um@lists.infradead.org; Wed, 20 Jan 2021 02:28:57 +0000
Received: by mail-pf1-x432.google.com with SMTP id w18so2273950pfu.9
 for <linux-um@lists.infradead.org>; Tue, 19 Jan 2021 18:28:55 -0800 (PST)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v8 11/20] um: lkl: basic console support
Date: Wed, 20 Jan 2021 11:27:16 +0900
Message-Id: <5ec3a7157f7d96943b5701f8d57e102181cd56d2.1611103406.git.thehajime@gmail.com>
In-Reply-To: <cover.1611103406.git.thehajime@gmail.com>
References: <cover.1611103406.git.thehajime@gmail.com>
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
To: linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: tavi.purdila@gmail.com, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org, thehajime@gmail.com, retrage01@gmail.com

This patch adds a basic structure of console support in kernel.  Write
operations are deferred to the host print operation.

This commit also disables stdio-console of UML when library mode to avoid
conflicts between multiple consoles.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/drivers/Makefile                |  8 ++++-
 arch/um/lkl/include/uapi/asm/host_ops.h |  9 ++++++
 arch/um/lkl/um/console.c                | 41 +++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 1 deletion(-)
 create mode 100644 arch/um/lkl/um/console.c

diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index ae96c83e312d..dc0d32d62294 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -37,7 +37,13 @@ $(obj)/vde.o: $(obj)/vde_kern.o $(obj)/vde_user.o
 # When the above is fixed, don't forget to add this too!
 #targets += $(obj)/pcap.o
 
-obj-y := stdio_console.o fd.o chan_kern.o chan_user.o line.o
+ifndef CONFIG_UMMODE_LIB
+obj-y := stdio_console.o
+else
+obj-y :=
+endif
+obj-y += fd.o chan_kern.o chan_user.o line.o
+
 obj-$(CONFIG_SSL) += ssl.o
 obj-$(CONFIG_STDERR_CONSOLE) += stderr_console.o
 
diff --git a/arch/um/lkl/include/uapi/asm/host_ops.h b/arch/um/lkl/include/uapi/asm/host_ops.h
index b97aa1099a17..976fc4301b3d 100644
--- a/arch/um/lkl/include/uapi/asm/host_ops.h
+++ b/arch/um/lkl/include/uapi/asm/host_ops.h
@@ -243,4 +243,13 @@ int lkl_tls_set(struct lkl_tls_key *key, void *data);
  */
 void *lkl_tls_get(struct lkl_tls_key *key);
 
+/**
+ * lkl_print - optional operation that receives console messages
+ *
+ * @str: strings to be printed
+ * @len: the length of @str
+ *
+ */
+void lkl_print(const char *str, int len);
+
 #endif
diff --git a/arch/um/lkl/um/console.c b/arch/um/lkl/um/console.c
new file mode 100644
index 000000000000..f2b48dc7ae22
--- /dev/null
+++ b/arch/um/lkl/um/console.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/console.h>
+#include <asm/host_ops.h>
+
+static void console_write(struct console *con, const char *str, unsigned len)
+{
+	lkl_print(str, len);
+}
+
+#ifdef CONFIG_LKL_EARLY_CONSOLE
+static struct console lkl_boot_console = {
+	.name	= "lkl_boot_console",
+	.write	= console_write,
+	.flags	= CON_PRINTBUFFER | CON_BOOT,
+	.index	= -1,
+};
+
+int __init lkl_boot_console_init(void)
+{
+	register_console(&lkl_boot_console);
+	return 0;
+}
+early_initcall(lkl_boot_console_init);
+#endif
+
+static struct console lkl_console = {
+	.name	= "lkl_console",
+	.write	= console_write,
+	.flags	= CON_PRINTBUFFER,
+	.index	= -1,
+};
+
+int __init lkl_console_init(void)
+{
+	register_console(&lkl_console);
+	return 0;
+}
+core_initcall(lkl_console_init);
+
-- 
2.21.0 (Apple Git-122.2)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

