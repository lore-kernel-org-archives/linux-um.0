Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RFC PATCH v2 4/6] um: Add os_warn() for pre-boot warning/error messages
Date: Mon,  8 May 2017 15:20:05 +0900
Message-Id: <149422439545.11101.7179534750138663551.stgit@devbox>
In-Reply-To: <149422411127.11101.13017249012576512464.stgit@devbox>
References: <149422411127.11101.13017249012576512464.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Add os_warn() for printing out pre-boot warning/error
messages in stderr. The messages via os_warn() are not
suppressed by quiet option.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/um/include/shared/os.h |    2 ++
 arch/um/os-Linux/util.c     |    9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 9e95bce..574e03f 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -244,6 +244,8 @@ extern void um_early_printk(const char *s, unsigned int n);
 extern void os_fix_helper_signals(void);
 extern void os_info(const char *fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
+extern void os_warn(const char *fmt, ...)
+	__attribute__ ((format (printf, 1, 2)));
 
 /* time.c */
 extern void os_idle_sleep(unsigned long long nsecs);
diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
index c9bad1b..8cc8b26 100644
--- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -177,3 +177,12 @@ void os_info(const char *fmt, ...)
 	vfprintf(stderr, fmt, list);
 	va_end(list);
 }
+
+void os_warn(const char *fmt, ...)
+{
+	va_list list;
+
+	va_start(list, fmt);
+	vfprintf(stderr, fmt, list);
+	va_end(list);
+}


