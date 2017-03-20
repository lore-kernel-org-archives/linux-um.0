Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kyle Huey <me@kylehuey.com>
Subject: [PATCH v16 06/10] x86/syscalls/32: Wire up arch_prctl on x86-32
Date: Mon, 20 Mar 2017 01:16:24 -0700
Message-Id: <20170320081628.18952-7-khuey@kylehuey.com>
In-Reply-To: <20170320081628.18952-1-khuey@kylehuey.com>
References: <20170320081628.18952-1-khuey@kylehuey.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <andi@firstfloor.org>, Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hook up arch_prctl to call do_arch_prctl() on x86-32, and in 32 bit compat
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
index 9ba050fe47f3..0af59fa789ea 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -390,3 +390,4 @@
 381	i386	pkey_alloc		sys_pkey_alloc
 382	i386	pkey_free		sys_pkey_free
 383	i386	statx			sys_statx
+384	i386	arch_prctl		sys_arch_prctl			compat_sys_arch_prctl
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 4c818f8bc135..ff40e74c9181 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -37,6 +37,7 @@
 #include <linux/uaccess.h>
 #include <linux/io.h>
 #include <linux/kdebug.h>
+#include <linux/syscalls.h>
 
 #include <asm/pgtable.h>
 #include <asm/ldt.h>
@@ -56,6 +57,7 @@
 #include <asm/switch_to.h>
 #include <asm/vm86.h>
 #include <asm/intel_rdt.h>
+#include <asm/proto.h>
 
 void __show_regs(struct pt_regs *regs, int all)
 {
@@ -304,3 +306,8 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 
 	return prev_p;
 }
+
+SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
+{
+	return do_arch_prctl_common(current, option, arg2);
+}
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index d81b0a60a45c..ea1a6180bf39 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -635,6 +635,13 @@ SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
 	return ret;
 }
 
+#ifdef CONFIG_IA32_EMULATION
+COMPAT_SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
+{
+	return do_arch_prctl_common(current, option, arg2);
+}
+#endif
+
 unsigned long KSTK_ESP(struct task_struct *task)
 {
 	return task_pt_regs(task)->sp;
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index e7e7055a8658..69f0827d5f53 100644
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
index 000000000000..627d68836b16
--- /dev/null
+++ b/arch/x86/um/syscalls_32.c
@@ -0,0 +1,7 @@
+#include <linux/syscalls.h>
+#include <os.h>
+
+SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
+{
+	return -EINVAL;
+}
diff --git a/include/linux/compat.h b/include/linux/compat.h
index aef47be2a5c1..af9dbc44fd92 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -723,6 +723,8 @@ asmlinkage long compat_sys_sched_rr_get_interval(compat_pid_t pid,
 asmlinkage long compat_sys_fanotify_mark(int, unsigned int, __u32, __u32,
 					    int, const char __user *);
 
+asmlinkage long compat_sys_arch_prctl(int option, unsigned long arg2);
+
 /*
  * For most but not all architectures, "am I in a compat syscall?" and
  * "am I a compat task?" are the same question.  For architectures on which
-- 
2.11.0


