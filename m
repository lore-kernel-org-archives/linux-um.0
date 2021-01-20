Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l23EG-0002Ae-DT
 for linux-um@lists.infradead.org; Wed, 20 Jan 2021 02:28:17 +0000
Received: by mail-pl1-x634.google.com with SMTP id s15so11672825plr.9
 for <linux-um@lists.infradead.org>; Tue, 19 Jan 2021 18:28:15 -0800 (PST)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v8 04/20] um: implement os_initcalls and os_exitcalls
Date: Wed, 20 Jan 2021 11:27:09 +0900
Message-Id: <7a16b13b232b2be9daf424dcd4d14ec8c43a5225.1611103406.git.thehajime@gmail.com>
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
Cc: linux-arch@vger.kernel.org, tavi.purdila@gmail.com, Octavian Purdila <tavi@cs.pub.ro>, retrage01@gmail.com, linux-kernel-library@freelists.org, thehajime@gmail.com

From: Octavian Purdila <tavi@cs.pub.ro>

This patch implements the init and exit calls for host code. It uses
the automatic __start_<section> and __stop_<section> variables that
are defined by gcc / ld when using custom sections.

Note that this patch should be merged with "um: move arch/um/os-Linux
dir to tools/um" but for now it is separate to make the review easier.

Signed-off-by: Octavian Purdila <tavi@cs.pub.ro>
---
 arch/um/include/shared/init.h | 14 ++++----------
 arch/um/kernel/reboot.c       |  5 +++++
 arch/um/kernel/um_arch.c      | 11 +++++++++++
 tools/um/uml/util.c           | 26 ++++++++++++++++++++++++++
 4 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/arch/um/include/shared/init.h b/arch/um/include/shared/init.h
index fa2d3138d497..0d6de61c0f37 100644
--- a/arch/um/include/shared/init.h
+++ b/arch/um/include/shared/init.h
@@ -114,19 +114,13 @@ extern struct uml_param __uml_setup_start, __uml_setup_end;
 
 #ifdef __UM_HOST__
 
-#define __define_initcall(level,fn) \
-	static initcall_t __initcall_##fn __used \
-	__attribute__((__section__(".initcall" level ".init"))) = fn
-
-/* Userspace initcalls shouldn't depend on anything in the kernel, so we'll
- * make them run first.
- */
-#define __initcall(fn) __define_initcall("1", fn)
+#undef __uml_exit_call
+#define __uml_exit_call		__used __section(os_exitcalls)
+#define __init_call		__used __section(os_initcalls)
 
+#define __initcall(fn) static initcall_t __initcall_##fn __init_call = fn
 #define __exitcall(fn) static exitcall_t __exitcall_##fn __exit_call = fn
 
-#define __init_call	__used __section(".initcall.init")
-
 #endif
 
 #endif /* _LINUX_UML_INIT_H */
diff --git a/arch/um/kernel/reboot.c b/arch/um/kernel/reboot.c
index 48c0610d506e..5420aec411f4 100644
--- a/arch/um/kernel/reboot.c
+++ b/arch/um/kernel/reboot.c
@@ -35,10 +35,15 @@ static void kill_off_processes(void)
 	read_unlock(&tasklist_lock);
 }
 
+void __weak os_exitcalls(void)
+{
+}
+
 void uml_cleanup(void)
 {
 	kmalloc_ok = 0;
 	do_uml_exitcalls();
+	os_exitcalls();
 	kill_off_processes();
 }
 
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 31d356b1ffd8..dfc6194b5ac7 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -444,3 +444,14 @@ static int init_pm_wake_signal(void)
 
 late_initcall(init_pm_wake_signal);
 #endif
+
+int __weak os_initcalls(void)
+{
+	return 0;
+}
+
+int __init run_os_initcalls(void)
+{
+	return os_initcalls();
+}
+early_initcall(run_os_initcalls);
diff --git a/tools/um/uml/util.c b/tools/um/uml/util.c
index 07327425d06e..8a3382c47f98 100644
--- a/tools/um/uml/util.c
+++ b/tools/um/uml/util.c
@@ -186,3 +186,29 @@ void os_warn(const char *fmt, ...)
 	vfprintf(stderr, fmt, list);
 	va_end(list);
 }
+
+extern void (*__start_os_exitcalls)(void);
+extern void (*__stop_os_exitcalls)(void);
+
+void os_exitcalls(void)
+{
+	exitcall_t *call;
+
+	call = &__stop_os_exitcalls;
+	while (--call >= &__start_os_exitcalls && (*call))
+		(*call)();
+}
+
+extern int (*__start_os_initcalls)(void);
+extern int (*__stop_os_initcalls)(void);
+
+int os_initcalls(void)
+{
+	initcall_t *call;
+
+	call = &__stop_os_initcalls;
+	while (--call >= &__start_os_initcalls && (*call))
+		(*call)();
+
+	return 0;
+}
-- 
2.21.0 (Apple Git-122.2)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

