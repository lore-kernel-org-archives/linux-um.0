Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RFC PATCH 3/7] um: Make non_fatal non-static for other files
Date: Fri, 28 Apr 2017 19:23:20 +0900
Message-Id: <149337499005.14717.4318763004043656817.stgit@devbox>
In-Reply-To: <149337478135.14717.16640886389891283.stgit@devbox>
References: <149337478135.14717.16640886389891283.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Move non_fatal() to util.c and make it global so that
it can be used from other files.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/um/include/shared/os.h |    1 +
 arch/um/os-Linux/start_up.c |    9 ---------
 arch/um/os-Linux/util.c     |    9 +++++++++
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index de5d572..49185f4 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -242,6 +242,7 @@ extern void setup_hostinfo(char *buf, int len);
 extern void os_dump_core(void) __attribute__ ((noreturn));
 extern void um_early_printk(const char *s, unsigned int n);
 extern void os_fix_helper_signals(void);
+extern void non_fatal(const char *fmt, ...);
 
 /* time.c */
 extern void os_idle_sleep(unsigned long long nsecs);
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 5052817..f97cd36 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -81,15 +81,6 @@ static void fatal(char *fmt, ...)
 	exit(1);
 }
 
-static void non_fatal(char *fmt, ...)
-{
-	va_list list;
-
-	va_start(list, fmt);
-	vfprintf(stderr, fmt, list);
-	va_end(list);
-}
-
 static int start_ptraced_child(void)
 {
 	int pid, n, status;
diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
index faee55e..8745f23 100644
--- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -152,3 +152,12 @@ void um_early_printk(const char *s, unsigned int n)
 {
 	printf("%.*s", n, s);
 }
+
+void non_fatal(const char *fmt, ...)
+{
+	va_list list;
+
+	va_start(list, fmt);
+	vfprintf(stderr, fmt, list);
+	va_end(list);
+}


