Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iN8QI-0001ln-DI
 for linux-um@lists.infradead.org; Wed, 23 Oct 2019 04:39:05 +0000
Received: by mail-pf1-x442.google.com with SMTP id 205so12090613pfw.2
 for <linux-um@lists.infradead.org>; Tue, 22 Oct 2019 21:39:02 -0700 (PDT)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC PATCH 12/47] lkl: initialization and cleanup
Date: Wed, 23 Oct 2019 13:37:46 +0900
Message-Id: <baa229d7f3a52537aba84ee1c54e7c15ff2f7036.1571798507.git.thehajime@gmail.com>
In-Reply-To: <cover.1571798507.git.thehajime@gmail.com>
References: <cover.1571798507.git.thehajime@gmail.com>
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
Cc: Octavian Purdila <tavi.purdila@gmail.com>, Hajime Tazaki <thehajime@gmail.com>, Patrick Collins <pscollins@google.com>, Michael Zimmermann <sigmaepsilon92@gmail.com>, Akira Moroo <retrage01@gmail.com>, Yuan Liu <liuyuan@google.com>

From: Octavian Purdila <tavi.purdila@gmail.com>

Add the lkl_start_kernel and lkl_sys_halt APIs that start and
respectively stops the Linux kernel.

lkl_start_kernel creates a separate threads that will run the initial
and idle kernel thread. It waits for the kernel to complete
initialization before returning, to avoid races with system calls
issues by the host application.

During the setup phase, we create "/init" in initial ramfs root
filesystem to avoid mounting the "real" rootfs since ramfs is good
enough for now.

lkl_stop_kernel will shutdown the kernel, terminate all threads and
free all host resources used by the kernel before returning.

This patch also introduces idle CPU handling since it is closely
related to the shutdown process. A host semaphore is used to wait for
new interrupts when the kernel switches the CPU to idle to avoid
wasting host CPU cycles. When the kernel is shutdown we terminate the
idle thread at the first CPU idle event.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Michael Zimmermann <sigmaepsilon92@gmail.com>
Signed-off-by: Patrick Collins <pscollins@google.com>
Signed-off-by: Yuan Liu <liuyuan@google.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 arch/um/lkl/include/asm/setup.h |   7 ++
 arch/um/lkl/kernel/setup.c      | 193 ++++++++++++++++++++++++++++++++
 2 files changed, 200 insertions(+)
 create mode 100644 arch/um/lkl/include/asm/setup.h
 create mode 100644 arch/um/lkl/kernel/setup.c

diff --git a/arch/um/lkl/include/asm/setup.h b/arch/um/lkl/include/asm/setup.h
new file mode 100644
index 000000000000..b40955208cc6
--- /dev/null
+++ b/arch/um/lkl/include/asm/setup.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_LKL_SETUP_H
+#define _ASM_LKL_SETUP_H
+
+#define COMMAND_LINE_SIZE 4096
+
+#endif
diff --git a/arch/um/lkl/kernel/setup.c b/arch/um/lkl/kernel/setup.c
new file mode 100644
index 000000000000..1bf973d36307
--- /dev/null
+++ b/arch/um/lkl/kernel/setup.c
@@ -0,0 +1,193 @@
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
+#include <asm/host_ops.h>
+#include <asm/irq.h>
+#include <asm/unistd.h>
+#include <asm/syscalls.h>
+#include <asm/cpu.h>
+
+struct lkl_host_operations *lkl_ops;
+static char cmd_line[COMMAND_LINE_SIZE];
+static void *init_sem;
+static int is_running;
+void (*pm_power_off)(void) = NULL;
+static unsigned long mem_size = 64 * 1024 * 1024;
+
+static long lkl_panic_blink(int state)
+{
+	lkl_ops->panic();
+	return 0;
+}
+
+static int __init setup_mem_size(char *str)
+{
+	mem_size = memparse(str, NULL);
+	return 0;
+}
+early_param("mem", setup_mem_size);
+
+void __init setup_arch(char **cl)
+{
+	*cl = cmd_line;
+	panic_blink = lkl_panic_blink;
+	parse_early_param();
+	bootmem_init(mem_size);
+}
+
+static void __init lkl_run_kernel(void *arg)
+{
+	threads_init();
+	lkl_cpu_get();
+	start_kernel();
+}
+
+int __init lkl_start_kernel(struct lkl_host_operations *ops, const char *fmt,
+			    ...)
+{
+	va_list ap;
+	int ret;
+
+	lkl_ops = ops;
+
+	va_start(ap, fmt);
+	ret = vsnprintf(boot_command_line, COMMAND_LINE_SIZE, fmt, ap);
+	va_end(ap);
+
+	if (ops->virtio_devices)
+		strscpy(boot_command_line + ret, ops->virtio_devices,
+			COMMAND_LINE_SIZE - ret);
+
+	memcpy(cmd_line, boot_command_line, COMMAND_LINE_SIZE);
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
+	current_thread_info()->tid = lkl_ops->thread_self();
+	lkl_cpu_change_owner(current_thread_info()->tid);
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
+void machine_halt(void)
+{
+	lkl_cpu_shutdown();
+}
+
+void machine_power_off(void)
+{
+	machine_halt();
+}
+
+void machine_restart(char *unused)
+{
+	machine_halt();
+}
+
+long lkl_sys_halt(void)
+{
+	long err;
+	long params[6] = {
+		LINUX_REBOOT_MAGIC1,
+		LINUX_REBOOT_MAGIC2,
+		LINUX_REBOOT_CMD_RESTART,
+	};
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
+	lkl_ops->thread_join(current_thread_info()->tid);
+
+	return 0;
+}
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
+	init_pid_ns.child_reaper = NULL;
+
+	syscalls_init();
+
+	lkl_ops->sem_up(init_sem);
+	lkl_ops->thread_exit();
+
+	return 0;
+}
+
+/* skip mounting the "real" rootfs. ramfs is good enough. */
+static int __init fs_setup(void)
+{
+	int fd;
+
+	fd = sys_open("/init", O_CREAT, 0700);
+	WARN_ON(fd < 0);
+	sys_close(fd);
+
+	register_binfmt(&lkl_run_init_binfmt);
+
+	return 0;
+}
+late_initcall(fs_setup);
-- 
2.20.1 (Apple Git-117)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

