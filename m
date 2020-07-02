Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqzuP-0005QG-0O
 for linux-um@lists.infradead.org; Thu, 02 Jul 2020 14:09:49 +0000
Received: by mail-pl1-x644.google.com with SMTP id j4so11366980plk.3
 for <linux-um@lists.infradead.org>; Thu, 02 Jul 2020 07:09:48 -0700 (PDT)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v5 14/21] um: nommu: initialization and cleanup
Date: Thu,  2 Jul 2020 23:07:08 +0900
Message-Id: <9463433f1d147f7a951435cab573052c01b8b3c0.1593697069.git.thehajime@gmail.com>
In-Reply-To: <cover.1593697069.git.thehajime@gmail.com>
References: <cover.1593697069.git.thehajime@gmail.com>
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
To: linux-um@lists.infradead.org
Cc: Octavian Purdila <tavi.purdila@gmail.com>, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org, Hajime Tazaki <thehajime@gmail.com>, Akira Moroo <retrage01@gmail.com>

Add the lkl_start_kernel and lkl_sys_halt APIs that start and
respectively stops the Linux kernel.

lkl_start_kernel creates a separate threads that will run the initial
and idle kernel thread. It waits for the kernel to complete
initialization before returning, to avoid races with system calls
issues by the host application.

During the setup phase, we create "/init" in initial ramfs root
filesystem to avoid mounting the "real" rootfs since ramfs is good
enough for now.

lkl_sys_halt will shutdown the kernel, terminate all threads and
free all host resources used by the kernel before returning.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 arch/um/nommu/include/uapi/asm/host_ops.h |  14 ++
 arch/um/nommu/um/setup.c                  | 161 ++++++++++++++++++++++
 tools/um/uml/process.c                    |   2 +
 3 files changed, 177 insertions(+)
 create mode 100644 arch/um/nommu/um/setup.c

diff --git a/arch/um/nommu/include/uapi/asm/host_ops.h b/arch/um/nommu/include/uapi/asm/host_ops.h
index 133877c857a1..0811494c080c 100644
--- a/arch/um/nommu/include/uapi/asm/host_ops.h
+++ b/arch/um/nommu/include/uapi/asm/host_ops.h
@@ -16,6 +16,7 @@ struct lkl_jmp_buf {
  * These operations must be provided by a host library or by the application
  * itself.
  * @print - optional operation that receives console messages
+ * @panic - called during a kernel panic
  *
  * @sem_alloc - allocate a host semaphore an initialize it to count
  * @sem_free - free a host semaphore
@@ -65,6 +66,7 @@ struct lkl_jmp_buf {
  */
 struct lkl_host_operations {
 	void (*print)(const char *str, int len);
+	void (*panic)(void);
 
 	struct lkl_sem *(*sem_alloc)(int count);
 	void (*sem_free)(struct lkl_sem *sem);
@@ -96,6 +98,18 @@ struct lkl_host_operations {
 	void (*mem_free)(void *mem);
 };
 
+/**
+ * lkl_start_kernel - registers the host operations and starts the kernel
+ *
+ * The function returns only after the kernel is shutdown with lkl_sys_halt.
+ *
+ * @lkl_ops - pointer to host operations
+ * @cmd_line - format for command line string that is going to be used to
+ * generate the Linux kernel command line
+ */
+int lkl_start_kernel(struct lkl_host_operations *ops,
+		     const char *fmt, ...);
+
 void lkl_bug(const char *fmt, ...);
 
 #endif
diff --git a/arch/um/nommu/um/setup.c b/arch/um/nommu/um/setup.c
new file mode 100644
index 000000000000..25aa003792d4
--- /dev/null
+++ b/arch/um/nommu/um/setup.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/binfmts.h>
+#include <linux/init.h>
+#include <linux/init_task.h>
+#include <linux/personality.h>
+#include <linux/reboot.h>
+#include <linux/fs.h>
+#include <linux/start_kernel.h>
+#include <linux/syscalls.h>
+#include <linux/tick.h>
+#include <linux/kernel.h>
+#include <linux/console.h>
+#include <asm/host_ops.h>
+#include <asm/irq.h>
+#include <asm/unistd.h>
+#include <asm/syscalls.h>
+#include <asm/cpu.h>
+#include <os.h>
+#include <as-layout.h>
+
+
+static void *init_sem;
+static int is_running;
+
+
+struct lkl_host_operations *lkl_ops;
+
+long lkl_panic_blink(int state)
+{
+	lkl_ops->panic();
+	return 0;
+}
+
+static void __init *lkl_run_kernel(void *arg)
+{
+
+	panic_blink = lkl_panic_blink;
+
+	threads_init();
+	lkl_cpu_get();
+	start_kernel();
+
+	return NULL;
+}
+
+int __init lkl_start_kernel(struct lkl_host_operations *ops,
+			    const char *fmt, ...)
+{
+	int ret;
+
+	lkl_ops = ops;
+
+	init_sem = lkl_ops->sem_alloc(0);
+	if (!init_sem)
+		return -ENOMEM;
+
+	ret = lkl_cpu_init();
+	if (ret)
+		goto out_free_init_sem;
+
+	ret = lkl_ops->thread_create(lkl_run_kernel, NULL);
+	if (!ret) {
+		ret = -ENOMEM;
+		goto out_free_init_sem;
+	}
+
+	lkl_ops->sem_down(init_sem);
+	lkl_ops->sem_free(init_sem);
+	current_thread_info()->task->thread.arch.tid = lkl_ops->thread_self();
+	lkl_cpu_change_owner(current_thread_info()->task->thread.arch.tid);
+
+	lkl_cpu_put();
+	is_running = 1;
+
+	return 0;
+
+out_free_init_sem:
+	lkl_ops->sem_free(init_sem);
+
+	return ret;
+}
+
+int lkl_is_running(void)
+{
+	return is_running;
+}
+
+
+long lkl_sys_halt(void)
+{
+	long err;
+	long params[6] = {LINUX_REBOOT_MAGIC1,
+		LINUX_REBOOT_MAGIC2, LINUX_REBOOT_CMD_RESTART, };
+
+	err = lkl_syscall(__NR_reboot, params);
+	if (err < 0)
+		return err;
+
+	is_running = false;
+
+	lkl_cpu_wait_shutdown();
+
+	syscalls_cleanup();
+	threads_cleanup();
+	/* Shutdown the clockevents source. */
+	tick_suspend_local();
+	free_mem();
+	lkl_ops->thread_join(current_thread_info()->task->thread.arch.tid);
+
+	return 0;
+}
+
+
+static int lkl_run_init(struct linux_binprm *bprm);
+
+static struct linux_binfmt lkl_run_init_binfmt = {
+	.module		= THIS_MODULE,
+	.load_binary	= lkl_run_init,
+};
+
+static int lkl_run_init(struct linux_binprm *bprm)
+{
+	int ret;
+
+	if (strcmp("/init", bprm->filename) != 0)
+		return -EINVAL;
+
+	ret = flush_old_exec(bprm);
+	if (ret)
+		return ret;
+	set_personality(PER_LINUX);
+	setup_new_exec(bprm);
+	install_exec_creds(bprm);
+
+	set_binfmt(&lkl_run_init_binfmt);
+
+	init_pid_ns.child_reaper = 0;
+
+	syscalls_init();
+
+	lkl_ops->sem_up(init_sem);
+	lkl_ops->thread_exit();
+
+	return 0;
+}
+
+
+/* skip mounting the "real" rootfs. ramfs is good enough. */
+static int __init fs_setup(void)
+{
+	int fd;
+
+	fd = ksys_open("/init", O_CREAT, 0700);
+	WARN_ON(fd < 0);
+	ksys_close(fd);
+
+	register_binfmt(&lkl_run_init_binfmt);
+
+	return 0;
+}
+late_initcall(fs_setup);
diff --git a/tools/um/uml/process.c b/tools/um/uml/process.c
index e52dd37ddadc..c39d914e80ac 100644
--- a/tools/um/uml/process.c
+++ b/tools/um/uml/process.c
@@ -114,6 +114,8 @@ void os_kill_process(int pid, int reap_child)
 
 void os_kill_ptraced_process(int pid, int reap_child)
 {
+	if (pid == 0)
+		return;
 	kill(pid, SIGKILL);
 	ptrace(PTRACE_KILL, pid);
 	ptrace(PTRACE_CONT, pid);
-- 
2.21.0 (Apple Git-122.2)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

