Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from zeniv-ca.linux.org.uk ([2607:5300:60:148a::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSQuM-003BNJ-Fh
 for linux-um@lists.infradead.org; Mon, 20 Sep 2021 21:33:05 +0000
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mSQuL-005yeL-Lx
 for linux-um@lists.infradead.org; Mon, 20 Sep 2021 21:33:01 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 04/15] um: stop polluting the namespace with registers.h
 contents
Date: Mon, 20 Sep 2021 21:32:50 +0000
Message-Id: <20210920213301.1424730-4-viro@zeniv.linux.org.uk>
In-Reply-To: <20210920213301.1424730-1-viro@zeniv.linux.org.uk>
References: <YUj9S+S4Gd86mM6N@zeniv-ca.linux.org.uk>
 <20210920213301.1424730-1-viro@zeniv.linux.org.uk>
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

Only one extern in there is needed in processor-generic.h, and it's
not needed anywhere else.  So move it over there and get rid of
the include in processor-generic.h, adding includes of registers.h
to the few files that need the declarations in it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/include/asm/processor-generic.h | 2 +-
 arch/um/include/shared/registers.h      | 2 --
 arch/um/kernel/exec.c                   | 1 +
 arch/um/kernel/process.c                | 1 +
 arch/x86/um/os-Linux/registers.c        | 1 +
 arch/x86/um/ptrace_32.c                 | 1 +
 arch/x86/um/ptrace_64.c                 | 1 +
 arch/x86/um/signal.c                    | 1 +
 arch/x86/um/syscalls_64.c               | 1 +
 9 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/asm/processor-generic.h
index b5cf0ed116d9e..5e809b5beffdd 100644
--- a/arch/um/include/asm/processor-generic.h
+++ b/arch/um/include/asm/processor-generic.h
@@ -11,7 +11,6 @@ struct pt_regs;
 struct task_struct;
 
 #include <asm/ptrace.h>
-#include <registers.h>
 #include <sysdep/archsetjmp.h>
 
 #include <linux/prefetch.h>
@@ -105,6 +104,7 @@ extern struct cpuinfo_um boot_cpu_data;
 #define current_cpu_data boot_cpu_data
 #define cache_line_size()	(boot_cpu_data.cache_alignment)
 
+extern unsigned long get_thread_reg(int reg, jmp_buf *buf);
 #define KSTK_REG(tsk, reg) get_thread_reg(reg, &tsk->thread.switch_buf)
 extern unsigned long get_wchan(struct task_struct *p);
 
diff --git a/arch/um/include/shared/registers.h b/arch/um/include/shared/registers.h
index 0c50fa6e8a55b..1e434f0e9477a 100644
--- a/arch/um/include/shared/registers.h
+++ b/arch/um/include/shared/registers.h
@@ -7,7 +7,6 @@
 #define __REGISTERS_H
 
 #include <sysdep/ptrace.h>
-#include <sysdep/archsetjmp.h>
 
 extern int save_i387_registers(int pid, unsigned long *fp_regs);
 extern int restore_i387_registers(int pid, unsigned long *fp_regs);
@@ -19,7 +18,6 @@ extern int save_registers(int pid, struct uml_pt_regs *regs);
 extern int restore_registers(int pid, struct uml_pt_regs *regs);
 extern int init_registers(int pid);
 extern void get_safe_registers(unsigned long *regs, unsigned long *fp_regs);
-extern unsigned long get_thread_reg(int reg, jmp_buf *buf);
 extern int get_fp_registers(int pid, unsigned long *regs);
 extern int put_fp_registers(int pid, unsigned long *regs);
 
diff --git a/arch/um/kernel/exec.c b/arch/um/kernel/exec.c
index 4d84981003419..c85e40c72779f 100644
--- a/arch/um/kernel/exec.c
+++ b/arch/um/kernel/exec.c
@@ -16,6 +16,7 @@
 #include <linux/uaccess.h>
 #include <as-layout.h>
 #include <mem_user.h>
+#include <registers.h>
 #include <skas.h>
 #include <os.h>
 
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 457a38db368b7..a5a430c637ba1 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -31,6 +31,7 @@
 #include <kern_util.h>
 #include <os.h>
 #include <skas.h>
+#include <registers.h>
 #include <linux/time-internal.h>
 
 /*
diff --git a/arch/x86/um/os-Linux/registers.c b/arch/x86/um/os-Linux/registers.c
index 3c423dfcd78bf..df8f4b4bf98b9 100644
--- a/arch/x86/um/os-Linux/registers.c
+++ b/arch/x86/um/os-Linux/registers.c
@@ -15,6 +15,7 @@
 #include <sys/uio.h>
 #include <asm/sigcontext.h>
 #include <linux/elf.h>
+#include <registers.h>
 
 int have_xstate_support;
 
diff --git a/arch/x86/um/ptrace_32.c b/arch/x86/um/ptrace_32.c
index 2497bac560663..0bc4b73a9cdea 100644
--- a/arch/x86/um/ptrace_32.c
+++ b/arch/x86/um/ptrace_32.c
@@ -7,6 +7,7 @@
 #include <linux/sched.h>
 #include <linux/uaccess.h>
 #include <asm/ptrace-abi.h>
+#include <registers.h>
 #include <skas.h>
 
 extern int arch_switch_tls(struct task_struct *to);
diff --git a/arch/x86/um/ptrace_64.c b/arch/x86/um/ptrace_64.c
index 1401899dee9b2..289d0159b041e 100644
--- a/arch/x86/um/ptrace_64.c
+++ b/arch/x86/um/ptrace_64.c
@@ -11,6 +11,7 @@
 #define __FRAME_OFFSETS
 #include <asm/ptrace.h>
 #include <linux/uaccess.h>
+#include <registers.h>
 #include <asm/ptrace-abi.h>
 
 /*
diff --git a/arch/x86/um/signal.c b/arch/x86/um/signal.c
index 7c11c9e5d7eaa..263e1d08f2160 100644
--- a/arch/x86/um/signal.c
+++ b/arch/x86/um/signal.c
@@ -12,6 +12,7 @@
 #include <linux/uaccess.h>
 #include <asm/ucontext.h>
 #include <frame_kern.h>
+#include <registers.h>
 #include <skas.h>
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/um/syscalls_64.c b/arch/x86/um/syscalls_64.c
index ad974f8ddf11b..6a98334e0949d 100644
--- a/arch/x86/um/syscalls_64.c
+++ b/arch/x86/um/syscalls_64.c
@@ -10,6 +10,7 @@
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
 #include <asm/prctl.h> /* XXX This should get the constants from libc */
+#include <registers.h>
 #include <os.h>
 
 long arch_prctl(struct task_struct *task, int option,
-- 
2.11.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

