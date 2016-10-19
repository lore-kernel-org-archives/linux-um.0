Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kyle Huey <me@kylehuey.com>
Subject: [PATCH v7 4/6] x86/syscalls/32: Wire up arch_prctl on x86-32
Date: Tue, 18 Oct 2016 19:03:31 -0700
Message-Id: <20161019020333.3766-5-khuey@kylehuey.com>
In-Reply-To: <20161019020333.3766-1-khuey@kylehuey.com>
References: <20161019020333.3766-1-khuey@kylehuey.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>, Dmitry Safonov <dsafonov@virtuozzo.com>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hook up arch_prctl to call do_arch_prctl on x86-32, and in 32 bit compat
mode on x86-64. This allows us to have arch_prctls that are not specific to
64 bits.

On UML, simply stub out this syscall.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
---
 arch/x86/entry/syscalls/syscall_32.tbl | 1 +
 arch/x86/kernel/process_32.c           | 7 +++++++
 arch/x86/kernel/process_64.c           | 7 +++++++
 arch/x86/um/Makefile                   | 2 +-
 arch/x86/um/syscalls_32.c              | 7 +++++++
 include/linux/compat.h                 | 2 ++
 6 files changed, 25 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/um/syscalls_32.c

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index ff6ef7b..804456f 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -391,3 +391,4 @@
 382	i386	pkey_free		sys_pkey_free
 #383	i386	pkey_get		sys_pkey_get
 #384	i386	pkey_set		sys_pkey_set
+385	i386	arch_prctl		sys_arch_prctl			compat_sys_arch_prctl
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index bd7be8e..95d3adc 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -35,6 +35,7 @@
 #include <linux/uaccess.h>
 #include <linux/io.h>
 #include <linux/kdebug.h>
+#include <linux/syscalls.h>
 
 #include <asm/pgtable.h>
 #include <asm/ldt.h>
@@ -54,6 +55,7 @@
 #include <asm/debugreg.h>
 #include <asm/switch_to.h>
 #include <asm/vm86.h>
+#include <asm/proto.h>
 
 void __show_regs(struct pt_regs *regs, int all)
 {
@@ -301,3 +303,8 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 
 	return prev_p;
 }
+
+SYSCALL_DEFINE2(arch_prctl, int, code, unsigned long, arg2)
+{
+	return do_arch_prctl_common(current, code, arg2);
+}
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index bf75d26..3a2a84d 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -626,6 +626,13 @@ SYSCALL_DEFINE2(arch_prctl, int, code, unsigned long, arg2)
 	return ret;
 }
 
+#ifdef CONFIG_IA32_EMULATION
+COMPAT_SYSCALL_DEFINE2(arch_prctl, int, code, unsigned long, arg2)
+{
+	return do_arch_prctl_common(current, code, arg2);
+}
+#endif
+
 unsigned long KSTK_ESP(struct task_struct *task)
 {
 	return task_pt_regs(task)->sp;
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index e7e7055..69f0827 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -16,7 +16,7 @@ obj-y = bug.o bugs_$(BITS).o delay.o fault.o ldt.o \
 
 ifeq ($(CONFIG_X86_32),y)
 
-obj-y += checksum_32.o
+obj-y += checksum_32.o syscalls_32.o
 obj-$(CONFIG_ELF_CORE) += elfcore.o
 
 subarch-y = ../lib/string_32.o ../lib/atomic64_32.o ../lib/atomic64_cx8_32.o
diff --git a/arch/x86/um/syscalls_32.c b/arch/x86/um/syscalls_32.c
new file mode 100644
index 0000000..ccf0598
--- /dev/null
+++ b/arch/x86/um/syscalls_32.c
@@ -0,0 +1,7 @@
+#include <linux/syscalls.h>
+#include <os.h>
+
+SYSCALL_DEFINE2(arch_prctl, int, code, unsigned long, arg2)
+{
+	return -EINVAL;
+}
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 6360939..500cdb3 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -721,6 +721,8 @@ asmlinkage long compat_sys_sched_rr_get_interval(compat_pid_t pid,
 asmlinkage long compat_sys_fanotify_mark(int, unsigned int, __u32, __u32,
 					    int, const char __user *);
 
+asmlinkage long compat_sys_arch_prctl(int, unsigned long);
+
 /*
  * For most but not all architectures, "am I in a compat syscall?" and
  * "am I a compat task?" are the same question.  For architectures on which
-- 
2.10.1


