Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RFC PATCH 6/7] um: Suppress non-fatal messages when quiet
Date: Fri, 28 Apr 2017 19:26:48 +0900
Message-Id: <149337519863.14717.14783366681891976827.stgit@devbox>
In-Reply-To: <149337478135.14717.16640886389891283.stgit@devbox>
References: <149337478135.14717.16640886389891283.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Suppress non-fatal boot messages when "quiet" kernel
parameter is given.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/um/os-Linux/util.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
index 8745f23..7afcb41 100644
--- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -13,6 +13,7 @@
 #include <wait.h>
 #include <sys/mman.h>
 #include <sys/utsname.h>
+#include <init.h>
 #include <os.h>
 
 void stack_protections(unsigned long address)
@@ -153,10 +154,25 @@ void um_early_printk(const char *s, unsigned int n)
 	printf("%.*s", n, s);
 }
 
+static int quiet_non_fatal;
+
+static int __init quiet_cmd_param(char *str, int *add)
+{
+	quiet_non_fatal = 1;
+	return 0;
+}
+
+__uml_setup("quiet", quiet_cmd_param,
+"quiet\n"
+"    Turns off non-fatal message during boot.\n\n");
+
 void non_fatal(const char *fmt, ...)
 {
 	va_list list;
 
+	if (quiet_non_fatal)
+		return;
+
 	va_start(list, fmt);
 	vfprintf(stderr, fmt, list);
 	va_end(list);


