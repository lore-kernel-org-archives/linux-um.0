Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1QO9zU-00040O-WE
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 May 2011 14:50:49 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QO9zU-00067d-5C
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 May 2011 14:50:48 +0000
From: Richard Weinberger <richard@nod.at>
Date: Sun, 22 May 2011 16:48:32 +0200
Message-Id: <1306075716-20042-3-git-send-email-richard@nod.at>
In-Reply-To: <1306075716-20042-1-git-send-email-richard@nod.at>
References: <1306075716-20042-1-git-send-email-richard@nod.at>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH 3/7] um: add earlyprintk support
To: akpm@linux-foundation.org
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

User Mode Linux can also benefit from earlyprintk.
UML's earlyprintk writes kernel messages directly to stdout.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/Kconfig.debug         |   10 ++++++++++
 arch/um/include/shared/os.h   |    1 +
 arch/um/kernel/Makefile       |    1 +
 arch/um/kernel/early_printk.c |   33 +++++++++++++++++++++++++++++++++
 arch/um/os-Linux/util.c       |    5 +++++
 5 files changed, 50 insertions(+), 0 deletions(-)
 create mode 100644 arch/um/kernel/early_printk.c

diff --git a/arch/um/Kconfig.debug b/arch/um/Kconfig.debug
index 8fce5e5..85c86edd 100644
--- a/arch/um/Kconfig.debug
+++ b/arch/um/Kconfig.debug
@@ -37,4 +37,14 @@ config DEBUG_STACK_USAGE
 	  stack seen so far.
 
 	  This option will slow down process creation and destruction somewhat.
+
+config EARLY_PRINTK
+	bool "Early printk"
+	default y
+	---help---
+	  Write kernel log output directly to stdout.
+
+	  This is useful for kernel debugging when your machine crashes very
+	  early before the console code is initialized.
+
 endmenu
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index f06a5da..83c7c2e 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -244,6 +244,7 @@ extern int raw(int fd);
 extern void setup_machinename(char *machine_out);
 extern void setup_hostinfo(char *buf, int len);
 extern void os_dump_core(void) __attribute__ ((noreturn));
+extern void um_early_printk(const char *s, unsigned int n);
 
 /* time.c */
 extern void idle_sleep(unsigned long long nsecs);
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index 1119233..c4491c1 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -17,6 +17,7 @@ obj-y = config.o exec.o exitcode.o init_task.o irq.o ksyms.o mem.o \
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
 obj-$(CONFIG_GCOV)	+= gmon_syms.o
+obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 
 USER_OBJS := config.o
 
diff --git a/arch/um/kernel/early_printk.c b/arch/um/kernel/early_printk.c
new file mode 100644
index 0000000..ec649bf
--- /dev/null
+++ b/arch/um/kernel/early_printk.c
@@ -0,0 +1,33 @@
+/*
+ * Copyright (C) 2011 Richard Weinberger <richrd@nod.at>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/console.h>
+#include <linux/init.h>
+#include "os.h"
+
+static void early_console_write(struct console *con, const char *s, unsigned int n)
+{
+	um_early_printk(s, n);
+}
+
+static struct console early_console = {
+	.name = "earlycon",
+	.write = early_console_write,
+	.flags = CON_BOOT,
+	.index = -1,
+};
+
+static int __init setup_early_printk(char *buf)
+{
+	register_console(&early_console);
+
+	return 0;
+}
+
+early_param("earlyprintk", setup_early_printk);
diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
index 42827ca..5803b18 100644
--- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -139,3 +139,8 @@ void os_dump_core(void)
 
 	uml_abort();
 }
+
+void um_early_printk(const char *s, unsigned int n)
+{
+	printf("%.*s", n, s);
+}
-- 
1.7.4.2


------------------------------------------------------------------------------
What Every C/C++ and Fortran developer Should Know!
Read this article and learn how Intel has extended the reach of its 
next-generation tools to help Windows* and Linux* C/C++ and Fortran 
developers boost performance applications - including clusters. 
http://p.sf.net/sfu/intel-dev2devmay
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

