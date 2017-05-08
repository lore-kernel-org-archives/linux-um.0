Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RFC PATCH v2 2/6] um: Add os_info() for pre-boot information messages
Date: Mon,  8 May 2017 15:17:46 +0900
Message-Id: <149422425674.11101.479418925777852556.stgit@devbox>
In-Reply-To: <149422411127.11101.13017249012576512464.stgit@devbox>
References: <149422411127.11101.13017249012576512464.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Add os_info() for printing out pre-boot information
level messages in stderr. The messages via os_info()
are suppressed by "quiet" kernel command line.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/um/include/shared/os.h |    2 ++
 arch/um/os-Linux/util.c     |   25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index cd1fa97..9e95bce 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -242,6 +242,8 @@ extern void setup_hostinfo(char *buf, int len);
 extern void os_dump_core(void) __attribute__ ((noreturn));
 extern void um_early_printk(const char *s, unsigned int n);
 extern void os_fix_helper_signals(void);
+extern void os_info(const char *fmt, ...)
+	__attribute__ ((format (printf, 1, 2)));
 
 /* time.c */
 extern void os_idle_sleep(unsigned long long nsecs);
diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
index faee55e..c9bad1b 100644
--- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -13,6 +13,7 @@
 #include <wait.h>
 #include <sys/mman.h>
 #include <sys/utsname.h>
+#include <init.h>
 #include <os.h>
 
 void stack_protections(unsigned long address)
@@ -152,3 +153,27 @@ void um_early_printk(const char *s, unsigned int n)
 {
 	printf("%.*s", n, s);
 }
+
+static int quiet_info;
+
+static int __init quiet_cmd_param(char *str, int *add)
+{
+	quiet_info = 1;
+	return 0;
+}
+
+__uml_setup("quiet", quiet_cmd_param,
+"quiet\n"
+"    Turns off information messages during boot.\n\n");
+
+void os_info(const char *fmt, ...)
+{
+	va_list list;
+
+	if (quiet_info)
+		return;
+
+	va_start(list, fmt);
+	vfprintf(stderr, fmt, list);
+	va_end(list);
+}


