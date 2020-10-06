Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPjWY-0008I3-Vg
 for linux-um@lists.infradead.org; Tue, 06 Oct 2020 09:44:47 +0000
Received: by mail-pl1-x641.google.com with SMTP id m15so951679pls.8
 for <linux-um@lists.infradead.org>; Tue, 06 Oct 2020 02:44:46 -0700 (PDT)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v7 02/21] um: add os init and exit calls
Date: Tue,  6 Oct 2020 18:44:11 +0900
Message-Id: <184f5b2c6a0c399edf519d27989519a35ab90700.1601960644.git.thehajime@gmail.com>
In-Reply-To: <cover.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
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
Cc: tavi.purdila@gmail.com, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org, Octavian Purdila <tavi@cs.pub.ro>, retrage01@gmail.com

From: Octavian Purdila <tavi@cs.pub.ro>

These calls are added in preparation for moving some of the code from
the kernel to the host build.

Signed-off-by: Octavian Purdila <tavi@cs.pub.ro>
---
 arch/um/include/shared/init.h | 14 ++++----------
 arch/um/kernel/reboot.c       |  5 +++++
 arch/um/kernel/um_arch.c      | 11 +++++++++++
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/um/include/shared/init.h b/arch/um/include/shared/init.h
index c66de434a983..d09308330ca5 100644
--- a/arch/um/include/shared/init.h
+++ b/arch/um/include/shared/init.h
@@ -109,19 +109,13 @@ extern struct uml_param __uml_setup_start, __uml_setup_end;
 
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
 
-#define __init_call	__used __section(.initcall.init)
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
index 00141e70de56..e2cb76c03b25 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -377,3 +377,14 @@ void *text_poke(void *addr, const void *opcode, size_t len)
 void text_poke_sync(void)
 {
 }
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
-- 
2.21.0 (Apple Git-122.2)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

