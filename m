Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kyle Huey <me@kylehuey.com>
Subject: [PATCH v16 02/10] x86/arch_prctl: Rename 'code' argument to 'option'
Date: Mon, 20 Mar 2017 01:16:20 -0700
Message-Id: <20170320081628.18952-3-khuey@kylehuey.com>
In-Reply-To: <20170320081628.18952-1-khuey@kylehuey.com>
References: <20170320081628.18952-1-khuey@kylehuey.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <andi@firstfloor.org>, Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

arch_prctl arbitrarily changed prctl's 'option' to 'code'. Now that we're
adding additional options, fix that.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
---
 arch/um/include/shared/os.h  |  4 ++--
 arch/x86/include/asm/proto.h |  2 +-
 arch/x86/kernel/process_64.c |  8 ++++----
 arch/x86/um/asm/ptrace.h     |  2 +-
 arch/x86/um/os-Linux/prctl.c |  4 ++--
 arch/x86/um/syscalls_64.c    | 13 +++++++------
 6 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index de5d572225f3..32e41c4ef6d3 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -302,8 +302,8 @@ extern int ignore_sigio_fd(int fd);
 extern void maybe_sigio_broken(int fd, int read);
 extern void sigio_broken(int fd, int read);
 
-/* sys-x86_64/prctl.c */
-extern int os_arch_prctl(int pid, int code, unsigned long *addr);
+/* prctl.c */
+extern int os_arch_prctl(int pid, int option, unsigned long *addr);
 
 /* tty.c */
 extern int get_pty(void);
diff --git a/arch/x86/include/asm/proto.h b/arch/x86/include/asm/proto.h
index 9b9b30b19441..91675a960391 100644
--- a/arch/x86/include/asm/proto.h
+++ b/arch/x86/include/asm/proto.h
@@ -30,6 +30,6 @@ void x86_report_nx(void);
 
 extern int reboot_force;
 
-long do_arch_prctl(struct task_struct *task, int code, unsigned long addr);
+long do_arch_prctl(struct task_struct *task, int option, unsigned long addr);
 
 #endif /* _ASM_X86_PROTO_H */
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index d6b784a5520d..4377cfe8e449 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -547,13 +547,13 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
 }
 #endif
 
-long do_arch_prctl(struct task_struct *task, int code, unsigned long addr)
+long do_arch_prctl(struct task_struct *task, int option, unsigned long addr)
 {
 	int ret = 0;
 	int doit = task == current;
 	int cpu;
 
-	switch (code) {
+	switch (option) {
 	case ARCH_SET_GS:
 		if (addr >= TASK_SIZE_MAX)
 			return -EPERM;
@@ -621,9 +621,9 @@ long do_arch_prctl(struct task_struct *task, int code, unsigned long addr)
 	return ret;
 }
 
-long sys_arch_prctl(int code, unsigned long addr)
+long sys_arch_prctl(int option, unsigned long addr)
 {
-	return do_arch_prctl(current, code, addr);
+	return do_arch_prctl(current, option, addr);
 }
 
 unsigned long KSTK_ESP(struct task_struct *task)
diff --git a/arch/x86/um/asm/ptrace.h b/arch/x86/um/asm/ptrace.h
index e59eef20647b..b291ca5cf66b 100644
--- a/arch/x86/um/asm/ptrace.h
+++ b/arch/x86/um/asm/ptrace.h
@@ -78,7 +78,7 @@ static inline int ptrace_set_thread_area(struct task_struct *child, int idx,
         return -ENOSYS;
 }
 
-extern long arch_prctl(struct task_struct *task, int code,
+extern long arch_prctl(struct task_struct *task, int option,
 		       unsigned long __user *addr);
 
 #endif
diff --git a/arch/x86/um/os-Linux/prctl.c b/arch/x86/um/os-Linux/prctl.c
index 96eb2bd28832..0a6e16a35b77 100644
--- a/arch/x86/um/os-Linux/prctl.c
+++ b/arch/x86/um/os-Linux/prctl.c
@@ -6,7 +6,7 @@
 #include <sys/ptrace.h>
 #include <asm/ptrace.h>
 
-int os_arch_prctl(int pid, int code, unsigned long *addr)
+int os_arch_prctl(int pid, int option, unsigned long *addr)
 {
-        return ptrace(PTRACE_ARCH_PRCTL, pid, (unsigned long) addr, code);
+	return ptrace(PTRACE_ARCH_PRCTL, pid, (unsigned long) addr, option);
 }
diff --git a/arch/x86/um/syscalls_64.c b/arch/x86/um/syscalls_64.c
index 10d907098c26..3c2dd8768992 100644
--- a/arch/x86/um/syscalls_64.c
+++ b/arch/x86/um/syscalls_64.c
@@ -11,7 +11,8 @@
 #include <asm/prctl.h> /* XXX This should get the constants from libc */
 #include <os.h>
 
-long arch_prctl(struct task_struct *task, int code, unsigned long __user *addr)
+long arch_prctl(struct task_struct *task, int option
+		unsigned long __user *addr)
 {
 	unsigned long *ptr = addr, tmp;
 	long ret;
@@ -30,7 +31,7 @@ long arch_prctl(struct task_struct *task, int code, unsigned long __user *addr)
 	 * arch_prctl is run on the host, then the registers are read
 	 * back.
 	 */
-	switch (code) {
+	switch (option) {
 	case ARCH_SET_FS:
 	case ARCH_SET_GS:
 		ret = restore_registers(pid, &current->thread.regs.regs);
@@ -50,11 +51,11 @@ long arch_prctl(struct task_struct *task, int code, unsigned long __user *addr)
 		ptr = &tmp;
 	}
 
-	ret = os_arch_prctl(pid, code, ptr);
+	ret = os_arch_prctl(pid, option, ptr);
 	if (ret)
 		return ret;
 
-	switch (code) {
+	switch (option) {
 	case ARCH_SET_FS:
 		current->thread.arch.fs = (unsigned long) ptr;
 		ret = save_registers(pid, &current->thread.regs.regs);
@@ -73,9 +74,9 @@ long arch_prctl(struct task_struct *task, int code, unsigned long __user *addr)
 	return ret;
 }
 
-long sys_arch_prctl(int code, unsigned long addr)
+long sys_arch_prctl(int option, unsigned long addr)
 {
-	return arch_prctl(current, code, (unsigned long __user *) addr);
+	return arch_prctl(current, option, (unsigned long __user *) addr);
 }
 
 void arch_switch_to(struct task_struct *to)
-- 
2.11.0


