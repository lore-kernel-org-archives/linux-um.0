Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CF8D2E03C
	for <linux-um@archiver.kernel.org>; Wed, 23 Oct 2024 09:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=c751E8ZLE5uvwTmcxLe/rRrYKSTRyFf+15vLKKMiUNA=; b=oa7qEnQqLP4xoDq2cviTX2PPYk
	tmsyf1UoehADd/VebJO+IQa8Xrs5raDjF77dxapAVKGnOAqd3yAxMLLv8bG/YbJnR5rJOTNa+6PQO
	IQ2945LT4XfC23eLS96R2H0H0rky6WeijFofnfI6qo1thQeNrS6XxO42Q0/ljW4vVl5dPByZWLA0l
	0KeW71NeVhnOAs82H5sZqEfqTF2SCw6QxCOdnP4irQbkC9wRuzMhLL3z/szH+5Um28rjzaO0o5Fq9
	6+YpIDpAnKwb3EdvOJwVRL2op21osPm4MhsurDLDwZ+NkcyzxM2n/GUqansch07nDGYeRVofpRFGa
	PEXW1bZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Y9a-0000000DtqN-1a0g;
	Wed, 23 Oct 2024 09:59:46 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Xkx-0000000DoqF-3IQ4
	for linux-um@lists.infradead.org;
	Wed, 23 Oct 2024 09:34:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=c751E8ZLE5uvwTmcxLe/rRrYKSTRyFf+15vLKKMiUNA=; t=1729676059; x=1730885659; 
	b=wo6EjKBbOmWuQDOm5NLLlYulHcoc16L2D4YG4w9newm3J5grw4SI5EJEHdRMzRQfN/2EMk5Jpbz
	Z9It90mgASd7op0qf4yodXMOrqdkdJtE1TFkO90ORhS7rHl8LE+WPwOowKEZ+Hw2OttI/JYIHlfeh
	jp9tYDEeDOpswX4+Z8FTEP5mISH1oYpki512L3gvelEq5Ko9aq6gVHDPcFpCVEzI5PqvvlJsKNZQz
	JqdhC7JDsoztJn/mlHq8ANS8pMs8AsTTc/OwtgzpZmvScQ+GsI8+WEROPqXKIJwv2LK08NDJpVz25
	1ZU+nv2cH+xLI+/v0CzxfwsrPtuaGrp8PF0w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1t3Xku-00000002ahN-193S;
	Wed, 23 Oct 2024 11:34:16 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v4] um: switch to regset API and depend on XSTATE
Date: Wed, 23 Oct 2024 11:34:09 +0200
Message-ID: <20241023093409.4081296-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_023420_196277_D3112D9E 
X-CRM114-Status: GOOD (  33.08  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Benjamin Berg <benjamin.berg@intel.com>

The PTRACE_GETREGSET API has now existed since Linux 2.6.33. The XSAVE
CPU feature should also be sufficiently common to be able to rely on it.

With this, define our internal FP state to be the hosts XSAVE data. Add
discovery for the hosts XSAVE size and place the FP registers at the end
of task_struct so that we can adjust the size at runtime.

Next we can implement the regset API on top and update the signal
handling as well as ptrace APIs to use them. Also switch coredump
creation to use the regset API and finally set HAVE_ARCH_TRACEHOOK.

This considerably improves the signal frames. Previously they might not
have contained all the registers (i386) and also did not have the
sizes and magic values set to the correct values to permit userspace to
decode the frame.

As a side effect, this will permit UML to run on hosts with newer CPU
extensions (such as AMX) that need even more register state.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

---

v4:
* fix FP register initialization when duplicating tasks

v3:
* Fix FP register initialization, thanks to Johannes Berg

v2:
* Fix unmap size of detection code, thanks to Johannes Berg
* Small formatting changes

v1:
* Use a fixed mmap'ed buffer for size discovery
* Add forgotten enum definition for signal.c
* Fix FPX register size using sizeof()
* Also set magic1 and xstate_size to the expected values
---
 arch/um/Kconfig                         |   2 +
 arch/um/include/asm/processor-generic.h |   4 +-
 arch/um/kernel/process.c                |  15 --
 arch/um/kernel/um_arch.c                |   2 +
 arch/um/os-Linux/registers.c            |  11 +-
 arch/x86/um/Makefile                    |   2 +-
 arch/x86/um/asm/elf.h                   |   2 +
 arch/x86/um/asm/ptrace.h                |  10 +
 arch/x86/um/os-Linux/registers.c        | 145 +++--------
 arch/x86/um/ptrace.c                    | 267 ++++++++++++++++++++
 arch/x86/um/ptrace_32.c                 |  88 ++-----
 arch/x86/um/ptrace_64.c                 |  37 +--
 arch/x86/um/shared/sysdep/ptrace.h      |   8 +-
 arch/x86/um/shared/sysdep/ptrace_32.h   |   4 -
 arch/x86/um/shared/sysdep/ptrace_64.h   |   4 -
 arch/x86/um/shared/sysdep/ptrace_user.h |   6 -
 arch/x86/um/signal.c                    | 322 ++++++++----------------
 arch/x86/um/user-offsets.c              |   8 -
 18 files changed, 464 insertions(+), 473 deletions(-)
 create mode 100644 arch/x86/um/ptrace.c

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 5dc702ad9e7a..a9876bdb5bf9 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -5,6 +5,7 @@ menu "UML-specific options"
 config UML
 	bool
 	default y
+	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
@@ -32,6 +33,7 @@ config UML
 	select HAVE_ARCH_VMAP_STACK
 	select HAVE_RUST
 	select ARCH_HAS_UBSAN
+	select HAVE_ARCH_TRACEHOOK
 
 config MMU
 	bool
diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/asm/processor-generic.h
index 02e759a4a435..5d6356eafffe 100644
--- a/arch/um/include/asm/processor-generic.h
+++ b/arch/um/include/asm/processor-generic.h
@@ -20,7 +20,6 @@ struct task_struct;
 struct mm_struct;
 
 struct thread_struct {
-	struct pt_regs regs;
 	struct pt_regs *segv_regs;
 	struct task_struct *prev_sched;
 	struct arch_thread arch;
@@ -31,6 +30,9 @@ struct thread_struct {
 			void *arg;
 		} thread;
 	} request;
+
+	/* Contains variable sized FP registers */
+	struct pt_regs regs;
 };
 
 #define INIT_THREAD \
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index d45c79f82d7c..f6ed31223ba9 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -287,18 +287,3 @@ unsigned long __get_wchan(struct task_struct *p)
 
 	return 0;
 }
-
-int elf_core_copy_task_fpregs(struct task_struct *t, elf_fpregset_t *fpu)
-{
-#ifdef CONFIG_X86_32
-	extern int have_fpx_regs;
-
-	/* FIXME: A plain copy does not work on i386 with have_fpx_regs */
-	if (have_fpx_regs)
-		return 0;
-#endif
-	memcpy(fpu, &t->thread.regs.regs.fp, sizeof(*fpu));
-
-	return 1;
-}
-
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 6d755a37d5c4..ec17576ce9fc 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -402,6 +402,8 @@ int __init linux_main(int argc, char **argv, char **envp)
 		os_info("Kernel virtual memory size shrunk to %lu bytes\n",
 			virtmem_size);
 
+	arch_task_struct_size = sizeof(struct task_struct) + host_fp_size;
+
 	os_flush_stdout();
 
 	return start_uml();
diff --git a/arch/um/os-Linux/registers.c b/arch/um/os-Linux/registers.c
index bd80b921add0..d7ca148807b2 100644
--- a/arch/um/os-Linux/registers.c
+++ b/arch/um/os-Linux/registers.c
@@ -10,11 +10,12 @@
 #include <sysdep/ptrace.h>
 #include <sysdep/ptrace_user.h>
 #include <registers.h>
+#include <stdlib.h>
 
 /* This is set once at boot time and not changed thereafter */
 
 static unsigned long exec_regs[MAX_REG_NR];
-static unsigned long exec_fp_regs[FP_SIZE];
+static unsigned long *exec_fp_regs;
 
 int init_pid_registers(int pid)
 {
@@ -24,7 +25,11 @@ int init_pid_registers(int pid)
 	if (err < 0)
 		return -errno;
 
-	arch_init_registers(pid);
+	err = arch_init_registers(pid);
+	if (err < 0)
+		return err;
+
+	exec_fp_regs = malloc(host_fp_size);
 	get_fp_registers(pid, exec_fp_regs);
 	return 0;
 }
@@ -34,5 +39,5 @@ void get_safe_registers(unsigned long *regs, unsigned long *fp_regs)
 	memcpy(regs, exec_regs, sizeof(exec_regs));
 
 	if (fp_regs)
-		memcpy(fp_regs, exec_fp_regs, sizeof(exec_fp_regs));
+		memcpy(fp_regs, exec_fp_regs, host_fp_size);
 }
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index 36e67fc97c22..b42c31cd2390 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -10,7 +10,7 @@ else
 endif
 
 obj-y = bugs_$(BITS).o delay.o fault.o \
-	ptrace_$(BITS).o ptrace_user.o setjmp_$(BITS).o signal.o \
+	ptrace.o ptrace_$(BITS).o ptrace_user.o setjmp_$(BITS).o signal.o \
 	stub_segv.o \
 	sys_call_table_$(BITS).o sysrq_$(BITS).o tls_$(BITS).o \
 	mem_$(BITS).o subarch.o os-Linux/
diff --git a/arch/x86/um/asm/elf.h b/arch/x86/um/asm/elf.h
index 6052200fe925..62ed5d68a978 100644
--- a/arch/x86/um/asm/elf.h
+++ b/arch/x86/um/asm/elf.h
@@ -8,6 +8,8 @@
 #include <asm/user.h>
 #include <skas.h>
 
+#define CORE_DUMP_USE_REGSET
+
 #ifdef CONFIG_X86_32
 
 #define R_386_NONE	0
diff --git a/arch/x86/um/asm/ptrace.h b/arch/x86/um/asm/ptrace.h
index 2fef3da55533..2641d28d115c 100644
--- a/arch/x86/um/asm/ptrace.h
+++ b/arch/x86/um/asm/ptrace.h
@@ -2,6 +2,16 @@
 #ifndef __UM_X86_PTRACE_H
 #define __UM_X86_PTRACE_H
 
+/* This is here because signal.c needs the REGSET_FP_LEGACY definition */
+enum {
+	REGSET_GENERAL,
+#ifdef CONFIG_X86_32
+	REGSET_FP_LEGACY,
+#endif
+	REGSET_FP,
+	REGSET_XSTATE,
+};
+
 #include <linux/compiler.h>
 #ifndef CONFIG_X86_32
 #define __FRAME_OFFSETS /* Needed to get the R* macros */
diff --git a/arch/x86/um/os-Linux/registers.c b/arch/x86/um/os-Linux/registers.c
index f8e5516d9708..76eaeb93928c 100644
--- a/arch/x86/um/os-Linux/registers.c
+++ b/arch/x86/um/os-Linux/registers.c
@@ -16,133 +16,58 @@
 #include <asm/sigcontext.h>
 #include <linux/elf.h>
 #include <registers.h>
+#include <sys/mman.h>
 
-static int have_xstate_support;
+unsigned long host_fp_size;
 
-static int save_i387_registers(int pid, unsigned long *fp_regs)
-{
-	if (ptrace(PTRACE_GETFPREGS, pid, 0, fp_regs) < 0)
-		return -errno;
-	return 0;
-}
-
-static int save_fp_registers(int pid, unsigned long *fp_regs)
+int get_fp_registers(int pid, unsigned long *regs)
 {
-#ifdef PTRACE_GETREGSET
-	struct iovec iov;
+	struct iovec iov = {
+		.iov_base = regs,
+		.iov_len = host_fp_size,
+	};
 
-	if (have_xstate_support) {
-		iov.iov_base = fp_regs;
-		iov.iov_len = FP_SIZE * sizeof(unsigned long);
-		if (ptrace(PTRACE_GETREGSET, pid, NT_X86_XSTATE, &iov) < 0)
-			return -errno;
-		return 0;
-	} else
-#endif
-		return save_i387_registers(pid, fp_regs);
-}
-
-static int restore_i387_registers(int pid, unsigned long *fp_regs)
-{
-	if (ptrace(PTRACE_SETFPREGS, pid, 0, fp_regs) < 0)
+	if (ptrace(PTRACE_GETREGSET, pid, NT_X86_XSTATE, &iov) < 0)
 		return -errno;
 	return 0;
 }
 
-static int restore_fp_registers(int pid, unsigned long *fp_regs)
-{
-#ifdef PTRACE_SETREGSET
-	struct iovec iov;
-	if (have_xstate_support) {
-		iov.iov_base = fp_regs;
-		iov.iov_len = FP_SIZE * sizeof(unsigned long);
-		if (ptrace(PTRACE_SETREGSET, pid, NT_X86_XSTATE, &iov) < 0)
-			return -errno;
-		return 0;
-	} else
-#endif
-		return restore_i387_registers(pid, fp_regs);
-}
-
-#ifdef __i386__
-int have_fpx_regs = 1;
-static int save_fpx_registers(int pid, unsigned long *fp_regs)
+int put_fp_registers(int pid, unsigned long *regs)
 {
-	if (ptrace(PTRACE_GETFPXREGS, pid, 0, fp_regs) < 0)
-		return -errno;
-	return 0;
-}
+	struct iovec iov = {
+		.iov_base = regs,
+		.iov_len = host_fp_size,
+	};
 
-static int restore_fpx_registers(int pid, unsigned long *fp_regs)
-{
-	if (ptrace(PTRACE_SETFPXREGS, pid, 0, fp_regs) < 0)
+	if (ptrace(PTRACE_SETREGSET, pid, NT_X86_XSTATE, &iov) < 0)
 		return -errno;
 	return 0;
 }
 
-int get_fp_registers(int pid, unsigned long *regs)
-{
-	if (have_fpx_regs)
-		return save_fpx_registers(pid, regs);
-	else
-		return save_fp_registers(pid, regs);
-}
-
-int put_fp_registers(int pid, unsigned long *regs)
-{
-	if (have_fpx_regs)
-		return restore_fpx_registers(pid, regs);
-	else
-		return restore_fp_registers(pid, regs);
-}
-
-void arch_init_registers(int pid)
-{
-	struct user_fpxregs_struct fpx_regs;
-	int err;
-
-	err = ptrace(PTRACE_GETFPXREGS, pid, 0, &fpx_regs);
-	if (!err)
-		return;
-
-	if (errno != EIO)
-		panic("check_ptrace : PTRACE_GETFPXREGS failed, errno = %d",
-		      errno);
-
-	have_fpx_regs = 0;
-}
-#else
-
-int get_fp_registers(int pid, unsigned long *regs)
+int arch_init_registers(int pid)
 {
-	return save_fp_registers(pid, regs);
+	struct iovec iov = {
+		/* Just use plenty of space, it does not cost us anything */
+		.iov_len = 2 * 1024 * 1024,
+	};
+	int ret;
+
+	iov.iov_base = mmap(NULL, iov.iov_len, PROT_WRITE | PROT_READ,
+			    MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	if (iov.iov_base == MAP_FAILED)
+		return -ENOMEM;
+
+	/* GDB has x86_xsave_length, which uses x86_cpuid_count */
+	ret = ptrace(PTRACE_GETREGSET, pid, NT_X86_XSTATE, &iov);
+	if (ret)
+		ret = -errno;
+	munmap(iov.iov_base, 2 * 1024 * 1024);
+
+	host_fp_size = iov.iov_len;
+
+	return ret;
 }
 
-int put_fp_registers(int pid, unsigned long *regs)
-{
-	return restore_fp_registers(pid, regs);
-}
-
-void arch_init_registers(int pid)
-{
-#ifdef PTRACE_GETREGSET
-	void * fp_regs;
-	struct iovec iov;
-
-	fp_regs = malloc(FP_SIZE * sizeof(unsigned long));
-	if(fp_regs == NULL)
-		return;
-
-	iov.iov_base = fp_regs;
-	iov.iov_len = FP_SIZE * sizeof(unsigned long);
-	if (ptrace(PTRACE_GETREGSET, pid, NT_X86_XSTATE, &iov) == 0)
-		have_xstate_support = 1;
-
-	free(fp_regs);
-#endif
-}
-#endif
-
 unsigned long get_thread_reg(int reg, jmp_buf *buf)
 {
 	switch (reg) {
diff --git a/arch/x86/um/ptrace.c b/arch/x86/um/ptrace.c
new file mode 100644
index 000000000000..54d924bc45ce
--- /dev/null
+++ b/arch/x86/um/ptrace.c
@@ -0,0 +1,267 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/sched.h>
+#include <linux/elf.h>
+#include <linux/regset.h>
+#include <asm/user32.h>
+#include <asm/sigcontext.h>
+
+#ifdef CONFIG_X86_32
+/*
+ * FPU tag word conversions.
+ */
+
+static inline unsigned short twd_i387_to_fxsr(unsigned short twd)
+{
+	unsigned int tmp; /* to avoid 16 bit prefixes in the code */
+
+	/* Transform each pair of bits into 01 (valid) or 00 (empty) */
+	tmp = ~twd;
+	tmp = (tmp | (tmp>>1)) & 0x5555; /* 0V0V0V0V0V0V0V0V */
+	/* and move the valid bits to the lower byte. */
+	tmp = (tmp | (tmp >> 1)) & 0x3333; /* 00VV00VV00VV00VV */
+	tmp = (tmp | (tmp >> 2)) & 0x0f0f; /* 0000VVVV0000VVVV */
+	tmp = (tmp | (tmp >> 4)) & 0x00ff; /* 00000000VVVVVVVV */
+	return tmp;
+}
+
+static inline unsigned long twd_fxsr_to_i387(struct user_fxsr_struct *fxsave)
+{
+	struct _fpxreg *st = NULL;
+	unsigned long twd = (unsigned long) fxsave->twd;
+	unsigned long tag;
+	unsigned long ret = 0xffff0000;
+	int i;
+
+#define FPREG_ADDR(f, n)	((char *)&(f)->st_space + (n) * 16)
+
+	for (i = 0; i < 8; i++) {
+		if (twd & 0x1) {
+			st = (struct _fpxreg *) FPREG_ADDR(fxsave, i);
+
+			switch (st->exponent & 0x7fff) {
+			case 0x7fff:
+				tag = 2;		/* Special */
+				break;
+			case 0x0000:
+				if (!st->significand[0] &&
+				    !st->significand[1] &&
+				    !st->significand[2] &&
+				    !st->significand[3]) {
+					tag = 1;	/* Zero */
+				} else {
+					tag = 2;	/* Special */
+				}
+				break;
+			default:
+				if (st->significand[3] & 0x8000)
+					tag = 0;	/* Valid */
+				else
+					tag = 2;	/* Special */
+				break;
+			}
+		} else {
+			tag = 3;			/* Empty */
+		}
+		ret |= (tag << (2 * i));
+		twd = twd >> 1;
+	}
+	return ret;
+}
+
+/* Get/set the old 32bit i387 registers (pre-FPX) */
+static int fpregs_legacy_get(struct task_struct *target,
+			     const struct user_regset *regset,
+			     struct membuf to)
+{
+	struct user_fxsr_struct *fxsave = (void *)target->thread.regs.regs.fp;
+	int i;
+
+	membuf_store(&to, (unsigned long)fxsave->cwd | 0xffff0000ul);
+	membuf_store(&to, (unsigned long)fxsave->swd | 0xffff0000ul);
+	membuf_store(&to, twd_fxsr_to_i387(fxsave));
+	membuf_store(&to, fxsave->fip);
+	membuf_store(&to, fxsave->fcs | ((unsigned long)fxsave->fop << 16));
+	membuf_store(&to, fxsave->foo);
+	membuf_store(&to, fxsave->fos);
+
+	for (i = 0; i < 8; i++)
+		membuf_write(&to, (void *)fxsave->st_space + i * 16, 10);
+
+	return 0;
+}
+
+static int fpregs_legacy_set(struct task_struct *target,
+			     const struct user_regset *regset,
+			     unsigned int pos, unsigned int count,
+			     const void *kbuf, const void __user *ubuf)
+{
+	struct user_fxsr_struct *fxsave = (void *)target->thread.regs.regs.fp;
+	const struct user_i387_struct *from;
+	struct user_i387_struct buf;
+	int i;
+
+	if (ubuf) {
+		if (copy_from_user(&buf, ubuf, sizeof(buf)))
+			return -EFAULT;
+		from = &buf;
+	} else {
+		from = kbuf;
+	}
+
+	fxsave->cwd = (unsigned short)(from->cwd & 0xffff);
+	fxsave->swd = (unsigned short)(from->swd & 0xffff);
+	fxsave->twd = twd_i387_to_fxsr((unsigned short)(from->twd & 0xffff));
+	fxsave->fip = from->fip;
+	fxsave->fop = (unsigned short)((from->fcs & 0xffff0000ul) >> 16);
+	fxsave->fcs = (from->fcs & 0xffff);
+	fxsave->foo = from->foo;
+	fxsave->fos = from->fos;
+
+	for (i = 0; i < 8; i++) {
+		memcpy((void *)fxsave->st_space + i * 16,
+		       (void *)from->st_space + i * 10, 10);
+	}
+
+	return 0;
+}
+#endif
+
+static int genregs_get(struct task_struct *target,
+		       const struct user_regset *regset,
+		       struct membuf to)
+{
+	int reg;
+
+	for (reg = 0; to.left; reg++)
+		membuf_store(&to, getreg(target, reg * sizeof(unsigned long)));
+	return 0;
+}
+
+static int genregs_set(struct task_struct *target,
+		       const struct user_regset *regset,
+		       unsigned int pos, unsigned int count,
+		       const void *kbuf, const void __user *ubuf)
+{
+	int ret = 0;
+
+	if (kbuf) {
+		const unsigned long *k = kbuf;
+
+		while (count >= sizeof(*k) && !ret) {
+			ret = putreg(target, pos, *k++);
+			count -= sizeof(*k);
+			pos += sizeof(*k);
+		}
+	} else {
+		const unsigned long  __user *u = ubuf;
+
+		while (count >= sizeof(*u) && !ret) {
+			unsigned long word;
+
+			ret = __get_user(word, u++);
+			if (ret)
+				break;
+			ret = putreg(target, pos, word);
+			count -= sizeof(*u);
+			pos += sizeof(*u);
+		}
+	}
+	return ret;
+}
+
+static int generic_fpregs_active(struct task_struct *target, const struct user_regset *regset)
+{
+	return regset->n;
+}
+
+static int generic_fpregs_get(struct task_struct *target,
+			      const struct user_regset *regset,
+			      struct membuf to)
+{
+	void *fpregs = task_pt_regs(target)->regs.fp;
+
+	membuf_write(&to, fpregs, regset->size * regset->n);
+	return 0;
+}
+
+static int generic_fpregs_set(struct task_struct *target,
+			      const struct user_regset *regset,
+			      unsigned int pos, unsigned int count,
+			      const void *kbuf, const void __user *ubuf)
+{
+	void *fpregs = task_pt_regs(target)->regs.fp;
+
+	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				  fpregs, 0, regset->size * regset->n);
+}
+
+static struct user_regset uml_regsets[] __ro_after_init = {
+	[REGSET_GENERAL] = {
+		.core_note_type	= NT_PRSTATUS,
+		.n		= sizeof(struct user_regs_struct) / sizeof(long),
+		.size		= sizeof(long),
+		.align		= sizeof(long),
+		.regset_get	= genregs_get,
+		.set		= genregs_set
+	},
+#ifdef CONFIG_X86_32
+	/* Old FP registers, they are needed in signal frames */
+	[REGSET_FP_LEGACY] = {
+		.core_note_type	= NT_PRFPREG,
+		.n		= sizeof(struct user_i387_ia32_struct) / sizeof(long),
+		.size		= sizeof(long),
+		.align		= sizeof(long),
+		.active		= generic_fpregs_active,
+		.regset_get	= fpregs_legacy_get,
+		.set		= fpregs_legacy_set,
+	},
+#endif
+	[REGSET_FP] = {
+#ifdef CONFIG_X86_32
+		.core_note_type	= NT_PRXFPREG,
+		.n		= sizeof(struct user32_fxsr_struct) / sizeof(long),
+#else
+		.core_note_type	= NT_PRFPREG,
+		.n		= sizeof(struct user_i387_struct) / sizeof(long),
+#endif
+		.size		= sizeof(long),
+		.align		= sizeof(long),
+		.active		= generic_fpregs_active,
+		.regset_get	= generic_fpregs_get,
+		.set		= generic_fpregs_set,
+	},
+	[REGSET_XSTATE] = {
+		.core_note_type	= NT_X86_XSTATE,
+		.size		= sizeof(long),
+		.align		= sizeof(long),
+		.active		= generic_fpregs_active,
+		.regset_get	= generic_fpregs_get,
+		.set		= generic_fpregs_set,
+	},
+	/* TODO: Add TLS regset for 32bit */
+};
+
+const struct user_regset_view user_uml_view = {
+#ifdef CONFIG_X86_32
+	.name = "i386", .e_machine = EM_386,
+#else
+	.name = "x86_64", .e_machine = EM_X86_64,
+#endif
+	.regsets = uml_regsets, .n = ARRAY_SIZE(uml_regsets)
+};
+
+const struct user_regset_view *
+task_user_regset_view(struct task_struct *tsk)
+{
+	return &user_uml_view;
+}
+
+static int __init init_regset_xstate_info(void)
+{
+	uml_regsets[REGSET_XSTATE].n =
+		host_fp_size / uml_regsets[REGSET_XSTATE].size;
+
+	return 0;
+}
+arch_initcall(init_regset_xstate_info);
diff --git a/arch/x86/um/ptrace_32.c b/arch/x86/um/ptrace_32.c
index b8b85a52eb6f..3af3cb821524 100644
--- a/arch/x86/um/ptrace_32.c
+++ b/arch/x86/um/ptrace_32.c
@@ -6,6 +6,7 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/uaccess.h>
+#include <linux/regset.h>
 #include <asm/ptrace-abi.h>
 #include <registers.h>
 #include <skas.h>
@@ -168,69 +169,6 @@ int peek_user(struct task_struct *child, long addr, long data)
 	return put_user(tmp, (unsigned long __user *) data);
 }
 
-/* FIXME: Do the required conversions instead of erroring out */
-extern int have_fpx_regs;
-
-static int get_fpregs(struct user_i387_struct __user *buf, struct task_struct *child)
-{
-	int n;
-
-	if (have_fpx_regs)
-		return -EINVAL;
-
-	n = copy_to_user(buf, &child->thread.regs.regs.fp,
-			 sizeof(struct user_i387_struct));
-	if(n > 0)
-		return -EFAULT;
-
-	return n;
-}
-
-static int set_fpregs(struct user_i387_struct __user *buf, struct task_struct *child)
-{
-	int n;
-
-	if (have_fpx_regs)
-		return -EINVAL;
-
-	n = copy_from_user(&child->thread.regs.regs.fp, buf,
-			   sizeof(struct user_i387_struct));
-	if (n > 0)
-		return -EFAULT;
-
-	return 0;
-}
-
-static int get_fpxregs(struct user_fxsr_struct __user *buf, struct task_struct *child)
-{
-	int n;
-
-	if (!have_fpx_regs)
-		return -EINVAL;
-
-	n = copy_to_user(buf, &child->thread.regs.regs.fp,
-			 sizeof(struct user_fxsr_struct));
-	if(n > 0)
-		return -EFAULT;
-
-	return n;
-}
-
-static int set_fpxregs(struct user_fxsr_struct __user *buf, struct task_struct *child)
-{
-	int n;
-
-	if (!have_fpx_regs)
-		return -EINVAL;
-
-	n = copy_from_user(&child->thread.regs.regs.fp, buf,
-			   sizeof(struct user_fxsr_struct));
-	if (n > 0)
-		return -EFAULT;
-
-	return 0;
-}
-
 long subarch_ptrace(struct task_struct *child, long request,
 		    unsigned long addr, unsigned long data)
 {
@@ -238,17 +176,25 @@ long subarch_ptrace(struct task_struct *child, long request,
 	void __user *datap = (void __user *) data;
 	switch (request) {
 	case PTRACE_GETFPREGS: /* Get the child FPU state. */
-		ret = get_fpregs(datap, child);
-		break;
+		return copy_regset_to_user(child, task_user_regset_view(child),
+					   REGSET_FP_LEGACY,
+					   0, sizeof(struct user_i387_struct),
+					   datap);
 	case PTRACE_SETFPREGS: /* Set the child FPU state. */
-		ret = set_fpregs(datap, child);
-		break;
+		return copy_regset_from_user(child, task_user_regset_view(child),
+					     REGSET_FP_LEGACY,
+					     0, sizeof(struct user_i387_struct),
+					     datap);
 	case PTRACE_GETFPXREGS: /* Get the child FPU state. */
-		ret = get_fpxregs(datap, child);
-		break;
+		return copy_regset_to_user(child, task_user_regset_view(child),
+					   REGSET_FP,
+					   0, sizeof(struct user_fxsr_struct),
+					   datap);
 	case PTRACE_SETFPXREGS: /* Set the child FPU state. */
-		ret = set_fpxregs(datap, child);
-		break;
+		return copy_regset_from_user(child, task_user_regset_view(child),
+					     REGSET_FP,
+					     0, sizeof(struct user_fxsr_struct),
+					     datap);
 	default:
 		ret = -EIO;
 	}
diff --git a/arch/x86/um/ptrace_64.c b/arch/x86/um/ptrace_64.c
index f8bbad29cd0b..e0d4120a45c8 100644
--- a/arch/x86/um/ptrace_64.c
+++ b/arch/x86/um/ptrace_64.c
@@ -8,6 +8,7 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/errno.h>
+#include <linux/regset.h>
 #define __FRAME_OFFSETS
 #include <asm/ptrace.h>
 #include <linux/uaccess.h>
@@ -188,30 +189,6 @@ int peek_user(struct task_struct *child, long addr, long data)
 	return put_user(tmp, (unsigned long *) data);
 }
 
-static int get_fpregs(struct user_i387_struct __user *buf, struct task_struct *child)
-{
-	int n;
-
-	n = copy_to_user(buf, &child->thread.regs.regs.fp,
-			 sizeof(struct user_i387_struct));
-	if (n > 0)
-		return -EFAULT;
-
-	return n;
-}
-
-static int set_fpregs(struct user_i387_struct __user *buf, struct task_struct *child)
-{
-	int n;
-
-	n = copy_from_user(&child->thread.regs.regs.fp, buf,
-			   sizeof(struct user_i387_struct));
-	if (n > 0)
-		return -EFAULT;
-
-	return 0;
-}
-
 long subarch_ptrace(struct task_struct *child, long request,
 		    unsigned long addr, unsigned long data)
 {
@@ -220,11 +197,15 @@ long subarch_ptrace(struct task_struct *child, long request,
 
 	switch (request) {
 	case PTRACE_GETFPREGS: /* Get the child FPU state. */
-		ret = get_fpregs(datap, child);
-		break;
+		return copy_regset_to_user(child, task_user_regset_view(child),
+					   REGSET_FP,
+					   0, sizeof(struct user_i387_struct),
+					   datap);
 	case PTRACE_SETFPREGS: /* Set the child FPU state. */
-		ret = set_fpregs(datap, child);
-		break;
+		return copy_regset_from_user(child, task_user_regset_view(child),
+					     REGSET_FP,
+					     0, sizeof(struct user_i387_struct),
+					     datap);
 	case PTRACE_ARCH_PRCTL:
 		/* XXX Calls ptrace on the host - needs some SMP thinking */
 		ret = arch_prctl(child, data, (void __user *) addr);
diff --git a/arch/x86/um/shared/sysdep/ptrace.h b/arch/x86/um/shared/sysdep/ptrace.h
index 6ca4ecabc55b..2dd4ca6713f8 100644
--- a/arch/x86/um/shared/sysdep/ptrace.h
+++ b/arch/x86/um/shared/sysdep/ptrace.h
@@ -56,12 +56,16 @@ struct syscall_args {
 				     UPT_SYSCALL_ARG5(r),	 \
 				     UPT_SYSCALL_ARG6(r) } } )
 
+extern unsigned long host_fp_size;
+
 struct uml_pt_regs {
 	unsigned long gp[MAX_REG_NR];
-	unsigned long fp[MAX_FP_NR];
 	struct faultinfo faultinfo;
 	long syscall;
 	int is_user;
+
+	/* Dynamically sized FP registers (holds an XSTATE) */
+	unsigned long fp[];
 };
 
 #define EMPTY_UML_PT_REGS { }
@@ -72,4 +76,6 @@ struct uml_pt_regs {
 
 extern int user_context(unsigned long sp);
 
+extern int arch_init_registers(int pid);
+
 #endif /* __SYSDEP_X86_PTRACE_H */
diff --git a/arch/x86/um/shared/sysdep/ptrace_32.h b/arch/x86/um/shared/sysdep/ptrace_32.h
index 0c4989842fbe..2392470cac4d 100644
--- a/arch/x86/um/shared/sysdep/ptrace_32.h
+++ b/arch/x86/um/shared/sysdep/ptrace_32.h
@@ -6,8 +6,6 @@
 #ifndef __SYSDEP_I386_PTRACE_H
 #define __SYSDEP_I386_PTRACE_H
 
-#define MAX_FP_NR HOST_FPX_SIZE
-
 #define UPT_SYSCALL_ARG1(r) UPT_BX(r)
 #define UPT_SYSCALL_ARG2(r) UPT_CX(r)
 #define UPT_SYSCALL_ARG3(r) UPT_DX(r)
@@ -15,6 +13,4 @@
 #define UPT_SYSCALL_ARG5(r) UPT_DI(r)
 #define UPT_SYSCALL_ARG6(r) UPT_BP(r)
 
-extern void arch_init_registers(int pid);
-
 #endif
diff --git a/arch/x86/um/shared/sysdep/ptrace_64.h b/arch/x86/um/shared/sysdep/ptrace_64.h
index 0dc223aa1c2d..e73573ac871f 100644
--- a/arch/x86/um/shared/sysdep/ptrace_64.h
+++ b/arch/x86/um/shared/sysdep/ptrace_64.h
@@ -8,8 +8,6 @@
 #ifndef __SYSDEP_X86_64_PTRACE_H
 #define __SYSDEP_X86_64_PTRACE_H
 
-#define MAX_FP_NR HOST_FP_SIZE
-
 #define REGS_R8(r) ((r)[HOST_R8])
 #define REGS_R9(r) ((r)[HOST_R9])
 #define REGS_R10(r) ((r)[HOST_R10])
@@ -57,6 +55,4 @@
 #define UPT_SYSCALL_ARG5(r) UPT_R8(r)
 #define UPT_SYSCALL_ARG6(r) UPT_R9(r)
 
-extern void arch_init_registers(int pid);
-
 #endif
diff --git a/arch/x86/um/shared/sysdep/ptrace_user.h b/arch/x86/um/shared/sysdep/ptrace_user.h
index 1d1a824fa652..98da23120538 100644
--- a/arch/x86/um/shared/sysdep/ptrace_user.h
+++ b/arch/x86/um/shared/sysdep/ptrace_user.h
@@ -11,12 +11,6 @@
 #define REGS_IP_INDEX HOST_IP
 #define REGS_SP_INDEX HOST_SP
 
-#ifdef __i386__
-#define FP_SIZE ((HOST_FPX_SIZE > HOST_FP_SIZE) ? HOST_FPX_SIZE : HOST_FP_SIZE)
-#else
-#define FP_SIZE HOST_FP_SIZE
-#endif
-
 /*
  * glibc before 2.27 does not include PTRACE_SYSEMU_SINGLESTEP in its enum,
  * ensure we have a definition by (re-)defining it here.
diff --git a/arch/x86/um/signal.c b/arch/x86/um/signal.c
index fa78c74e00cb..94b2b2bbae31 100644
--- a/arch/x86/um/signal.c
+++ b/arch/x86/um/signal.c
@@ -16,145 +16,24 @@
 #include <registers.h>
 #include <skas.h>
 
-#ifdef CONFIG_X86_32
-
-/*
- * FPU tag word conversions.
- */
-
-static inline unsigned short twd_i387_to_fxsr(unsigned short twd)
-{
-	unsigned int tmp; /* to avoid 16 bit prefixes in the code */
-
-	/* Transform each pair of bits into 01 (valid) or 00 (empty) */
-	tmp = ~twd;
-	tmp = (tmp | (tmp>>1)) & 0x5555; /* 0V0V0V0V0V0V0V0V */
-	/* and move the valid bits to the lower byte. */
-	tmp = (tmp | (tmp >> 1)) & 0x3333; /* 00VV00VV00VV00VV */
-	tmp = (tmp | (tmp >> 2)) & 0x0f0f; /* 0000VVVV0000VVVV */
-	tmp = (tmp | (tmp >> 4)) & 0x00ff; /* 00000000VVVVVVVV */
-	return tmp;
-}
-
-static inline unsigned long twd_fxsr_to_i387(struct user_fxsr_struct *fxsave)
-{
-	struct _fpxreg *st = NULL;
-	unsigned long twd = (unsigned long) fxsave->twd;
-	unsigned long tag;
-	unsigned long ret = 0xffff0000;
-	int i;
-
-#define FPREG_ADDR(f, n)	((char *)&(f)->st_space + (n) * 16)
-
-	for (i = 0; i < 8; i++) {
-		if (twd & 0x1) {
-			st = (struct _fpxreg *) FPREG_ADDR(fxsave, i);
-
-			switch (st->exponent & 0x7fff) {
-			case 0x7fff:
-				tag = 2;		/* Special */
-				break;
-			case 0x0000:
-				if ( !st->significand[0] &&
-				     !st->significand[1] &&
-				     !st->significand[2] &&
-				     !st->significand[3] ) {
-					tag = 1;	/* Zero */
-				} else {
-					tag = 2;	/* Special */
-				}
-				break;
-			default:
-				if (st->significand[3] & 0x8000) {
-					tag = 0;	/* Valid */
-				} else {
-					tag = 2;	/* Special */
-				}
-				break;
-			}
-		} else {
-			tag = 3;			/* Empty */
-		}
-		ret |= (tag << (2 * i));
-		twd = twd >> 1;
-	}
-	return ret;
-}
-
-static int convert_fxsr_to_user(struct _fpstate __user *buf,
-				struct user_fxsr_struct *fxsave)
-{
-	unsigned long env[7];
-	struct _fpreg __user *to;
-	struct _fpxreg *from;
-	int i;
-
-	env[0] = (unsigned long)fxsave->cwd | 0xffff0000ul;
-	env[1] = (unsigned long)fxsave->swd | 0xffff0000ul;
-	env[2] = twd_fxsr_to_i387(fxsave);
-	env[3] = fxsave->fip;
-	env[4] = fxsave->fcs | ((unsigned long)fxsave->fop << 16);
-	env[5] = fxsave->foo;
-	env[6] = fxsave->fos;
-
-	if (__copy_to_user(buf, env, 7 * sizeof(unsigned long)))
-		return 1;
-
-	to = &buf->_st[0];
-	from = (struct _fpxreg *) &fxsave->st_space[0];
-	for (i = 0; i < 8; i++, to++, from++) {
-		unsigned long __user *t = (unsigned long __user *)to;
-		unsigned long *f = (unsigned long *)from;
-
-		if (__put_user(*f, t) ||
-				__put_user(*(f + 1), t + 1) ||
-				__put_user(from->exponent, &to->exponent))
-			return 1;
-	}
-	return 0;
-}
-
-static int convert_fxsr_from_user(struct user_fxsr_struct *fxsave,
-				  struct _fpstate __user *buf)
-{
-	unsigned long env[7];
-	struct _fpxreg *to;
-	struct _fpreg __user *from;
-	int i;
-
-	if (copy_from_user( env, buf, 7 * sizeof(long)))
-		return 1;
-
-	fxsave->cwd = (unsigned short)(env[0] & 0xffff);
-	fxsave->swd = (unsigned short)(env[1] & 0xffff);
-	fxsave->twd = twd_i387_to_fxsr((unsigned short)(env[2] & 0xffff));
-	fxsave->fip = env[3];
-	fxsave->fop = (unsigned short)((env[4] & 0xffff0000ul) >> 16);
-	fxsave->fcs = (env[4] & 0xffff);
-	fxsave->foo = env[5];
-	fxsave->fos = env[6];
-
-	to = (struct _fpxreg *) &fxsave->st_space[0];
-	from = &buf->_st[0];
-	for (i = 0; i < 8; i++, to++, from++) {
-		unsigned long *t = (unsigned long *)to;
-		unsigned long __user *f = (unsigned long __user *)from;
-
-		if (__get_user(*t, f) ||
-		    __get_user(*(t + 1), f + 1) ||
-		    __get_user(to->exponent, &from->exponent))
-			return 1;
-	}
-	return 0;
-}
-
-extern int have_fpx_regs;
+#include <linux/regset.h>
+#include <asm/sigframe.h>
 
+#ifdef CONFIG_X86_32
+struct _xstate_64 {
+	struct _fpstate_64		fpstate;
+	struct _header			xstate_hdr;
+	struct _ymmh_state		ymmh;
+	/* New processor state extensions go here: */
+};
+#else
+#define _xstate_64 _xstate
 #endif
 
 static int copy_sc_from_user(struct pt_regs *regs,
 			     struct sigcontext __user *from)
 {
+	struct _xstate_64 __user *from_fp64;
 	struct sigcontext sc;
 	int err;
 
@@ -203,31 +82,26 @@ static int copy_sc_from_user(struct pt_regs *regs,
 #undef GETREG
 
 #ifdef CONFIG_X86_32
-	if (have_fpx_regs) {
-		struct user_fxsr_struct *fpx;
-		fpx = (void *)&regs->regs.fp;
-
-		err = convert_fxsr_from_user(fpx, (void *)sc.fpstate);
-		if (err)
-			return 1;
-	} else {
-		BUILD_BUG_ON(sizeof(regs->regs.fp) > sizeof(struct _fpstate));
-		err = copy_from_user(regs->regs.fp, (void *)sc.fpstate,
-				     sizeof(regs->regs.fp));
-		if (err)
-			return 1;
-	}
+	from_fp64 = ((void *)sc.fpstate) + offsetof(struct _fpstate_32, _fxsr_env);
 #else
-	{
-		/* FIXME: Save/restore extended state (past the 16 YMM regs) */
-		BUILD_BUG_ON(sizeof(regs->regs.fp) < sizeof(struct _xstate));
+	from_fp64 = (void *)sc.fpstate;
+#endif
 
-		err = copy_from_user(regs->regs.fp, (void *)sc.fpstate,
-				     sizeof(struct _xstate));
-		if (err)
-			return 1;
-	}
+	err = copy_from_user(regs->regs.fp, from_fp64, host_fp_size);
+	if (err)
+		return 1;
+
+#ifdef CONFIG_X86_32
+	/* Data is duplicated and this copy is the important one */
+	err = copy_regset_from_user(current,
+				    task_user_regset_view(current),
+				    REGSET_FP_LEGACY, 0,
+				    sizeof(struct user_i387_struct),
+				    (void *)sc.fpstate);
+	if (err < 0)
+		return err;
 #endif
+
 	return 0;
 }
 
@@ -235,6 +109,7 @@ static int copy_sc_to_user(struct sigcontext __user *to,
 			   struct _xstate __user *to_fp, struct pt_regs *regs,
 			   unsigned long mask)
 {
+	struct _xstate_64 __user *to_fp64;
 	struct sigcontext sc;
 	struct faultinfo * fi = &current->thread.arch.faultinfo;
 	int err;
@@ -286,36 +161,44 @@ static int copy_sc_to_user(struct sigcontext __user *to,
 		return 1;
 
 #ifdef CONFIG_X86_32
-	if (have_fpx_regs) {
-		struct user_fxsr_struct *fpx;
-
-		fpx = (void *)&regs->regs.fp;
+	err = copy_regset_to_user(current,
+				  task_user_regset_view(current),
+				  REGSET_FP_LEGACY, 0,
+				  sizeof(struct _fpstate_32), to_fp);
+	if (err < 0)
+		return err;
 
-		err = convert_fxsr_to_user(&to_fp->fpstate, fpx);
-		if (err)
-			return 1;
+	__put_user(X86_FXSR_MAGIC, &to_fp->fpstate.magic);
 
-		err |= __put_user(fpx->swd, &to_fp->fpstate.status);
-		err |= __put_user(X86_FXSR_MAGIC, &to_fp->fpstate.magic);
-		if (err)
-			return 1;
-
-	} else {
-		if (copy_to_user(to_fp, regs->regs.fp, sizeof(regs->regs.fp)))
-			return 1;
-
-		/* Need to fill in the sw_reserved bits ... */
-		BUILD_BUG_ON(offsetof(typeof(*to_fp),
-				      fpstate.sw_reserved.magic1) >=
-			     sizeof(struct _fpstate));
-		__put_user(0, &to_fp->fpstate.sw_reserved.magic1);
-		__put_user(sizeof(struct _fpstate),
-			   &to_fp->fpstate.sw_reserved.extended_size);
-	}
+	BUILD_BUG_ON(offsetof(struct _xstate, xstate_hdr) !=
+		     offsetof(struct _xstate_64, xstate_hdr) +
+			offsetof(struct _fpstate_32, _fxsr_env));
+	to_fp64 = (void *)to_fp + offsetof(struct _fpstate_32, _fxsr_env);
 #else
-	if (copy_to_user(to_fp, regs->regs.fp, sizeof(struct _xstate)))
+	to_fp64 = to_fp;
+#endif /* CONFIG_X86_32 */
+
+	if (copy_to_user(to_fp64, regs->regs.fp, host_fp_size))
 		return 1;
+
+	/*
+	 * Put magic/size values for userspace. We do not bother to verify them
+	 * later on, however, userspace needs them should it try to read the
+	 * XSTATE data. And ptrace does not fill in these parts.
+	 */
+	BUILD_BUG_ON(sizeof(int) != FP_XSTATE_MAGIC2_SIZE);
+#ifdef CONFIG_X86_32
+	__put_user(offsetof(struct _fpstate_32, _fxsr_env) +
+		   host_fp_size + FP_XSTATE_MAGIC2_SIZE,
+		   &to_fp64->fpstate.sw_reserved.extended_size);
+#else
+	__put_user(host_fp_size + FP_XSTATE_MAGIC2_SIZE,
+		   &to_fp64->fpstate.sw_reserved.extended_size);
 #endif
+	__put_user(host_fp_size, &to_fp64->fpstate.sw_reserved.xstate_size);
+
+	__put_user(FP_XSTATE_MAGIC1, &to_fp64->fpstate.sw_reserved.magic1);
+	__put_user(FP_XSTATE_MAGIC2, (int *)((void *)to_fp64 + host_fp_size));
 
 	return 0;
 }
@@ -333,34 +216,15 @@ static int copy_ucontext_to_user(struct ucontext __user *uc,
 	return err;
 }
 
-struct sigframe
-{
-	char __user *pretcode;
-	int sig;
-	struct sigcontext sc;
-	struct _xstate fpstate;
-	unsigned long extramask[_NSIG_WORDS-1];
-	char retcode[8];
-};
-
-struct rt_sigframe
-{
-	char __user *pretcode;
-	int sig;
-	struct siginfo __user *pinfo;
-	void __user *puc;
-	struct siginfo info;
-	struct ucontext uc;
-	struct _xstate fpstate;
-	char retcode[8];
-};
-
 int setup_signal_stack_sc(unsigned long stack_top, struct ksignal *ksig,
 			  struct pt_regs *regs, sigset_t *mask)
 {
+	size_t math_size = offsetof(struct _fpstate_32, _fxsr_env) +
+			   host_fp_size + FP_XSTATE_MAGIC2_SIZE;
 	struct sigframe __user *frame;
 	void __user *restorer;
 	int err = 0, sig = ksig->sig;
+	unsigned long fp_to;
 
 	/* This is the same calculation as i386 - ((sp + 4) & 15) == 0 */
 	stack_top = ((stack_top + 4) & -16UL) - 4;
@@ -368,13 +232,21 @@ int setup_signal_stack_sc(unsigned long stack_top, struct ksignal *ksig,
 	if (!access_ok(frame, sizeof(*frame)))
 		return 1;
 
+	/* Add required space for math frame */
+	frame = (struct sigframe __user *)((unsigned long)frame - math_size);
+
 	restorer = frame->retcode;
 	if (ksig->ka.sa.sa_flags & SA_RESTORER)
 		restorer = ksig->ka.sa.sa_restorer;
 
-	err |= __put_user(restorer, &frame->pretcode);
+	err |= __put_user(restorer, (void **)&frame->pretcode);
 	err |= __put_user(sig, &frame->sig);
-	err |= copy_sc_to_user(&frame->sc, &frame->fpstate, regs, mask->sig[0]);
+
+	fp_to = (unsigned long)frame + sizeof(*frame);
+
+	err |= copy_sc_to_user(&frame->sc,
+			       (struct _xstate __user *)fp_to,
+			       regs, mask->sig[0]);
 	if (_NSIG_WORDS > 1)
 		err |= __copy_to_user(&frame->extramask, &mask->sig[1],
 				      sizeof(frame->extramask));
@@ -404,26 +276,35 @@ int setup_signal_stack_sc(unsigned long stack_top, struct ksignal *ksig,
 int setup_signal_stack_si(unsigned long stack_top, struct ksignal *ksig,
 			  struct pt_regs *regs, sigset_t *mask)
 {
+	size_t math_size = offsetof(struct _fpstate_32, _fxsr_env) +
+			   host_fp_size + FP_XSTATE_MAGIC2_SIZE;
 	struct rt_sigframe __user *frame;
 	void __user *restorer;
 	int err = 0, sig = ksig->sig;
+	unsigned long fp_to;
 
 	stack_top &= -8UL;
 	frame = (struct rt_sigframe __user *) stack_top - 1;
 	if (!access_ok(frame, sizeof(*frame)))
 		return 1;
 
+	/* Add required space for math frame */
+	frame = (struct rt_sigframe __user *)((unsigned long)frame - math_size);
+
 	restorer = frame->retcode;
 	if (ksig->ka.sa.sa_flags & SA_RESTORER)
 		restorer = ksig->ka.sa.sa_restorer;
 
-	err |= __put_user(restorer, &frame->pretcode);
+	err |= __put_user(restorer, (void **)&frame->pretcode);
 	err |= __put_user(sig, &frame->sig);
-	err |= __put_user(&frame->info, &frame->pinfo);
-	err |= __put_user(&frame->uc, &frame->puc);
+	err |= __put_user(&frame->info, (void **)&frame->pinfo);
+	err |= __put_user(&frame->uc, (void **)&frame->puc);
 	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
-	err |= copy_ucontext_to_user(&frame->uc, &frame->fpstate, mask,
-					PT_REGS_SP(regs));
+
+	fp_to = (unsigned long)frame + sizeof(*frame);
+
+	err |= copy_ucontext_to_user(&frame->uc, (struct _xstate __user *)fp_to,
+				     mask, PT_REGS_SP(regs));
 
 	/*
 	 * This is movl $,%eax ; int $0x80
@@ -475,27 +356,24 @@ SYSCALL_DEFINE0(sigreturn)
 
 #else
 
-struct rt_sigframe
-{
-	char __user *pretcode;
-	struct ucontext uc;
-	struct siginfo info;
-	struct _xstate fpstate;
-};
-
 int setup_signal_stack_si(unsigned long stack_top, struct ksignal *ksig,
 			  struct pt_regs *regs, sigset_t *set)
 {
+	unsigned long math_size = host_fp_size + FP_XSTATE_MAGIC2_SIZE;
 	struct rt_sigframe __user *frame;
 	int err = 0, sig = ksig->sig;
 	unsigned long fp_to;
 
 	frame = (struct rt_sigframe __user *)
 		round_down(stack_top - sizeof(struct rt_sigframe), 16);
+
+	/* Add required space for math frame */
+	frame = (struct rt_sigframe __user *)((unsigned long)frame - math_size);
+
 	/* Subtract 128 for a red zone and 8 for proper alignment */
 	frame = (struct rt_sigframe __user *) ((unsigned long) frame - 128 - 8);
 
-	if (!access_ok(frame, sizeof(*frame)))
+	if (!access_ok(frame, sizeof(*frame) + math_size))
 		goto out;
 
 	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
@@ -508,10 +386,12 @@ int setup_signal_stack_si(unsigned long stack_top, struct ksignal *ksig,
 	err |= __put_user(0, &frame->uc.uc_flags);
 	err |= __put_user(0, &frame->uc.uc_link);
 	err |= __save_altstack(&frame->uc.uc_stack, PT_REGS_SP(regs));
-	err |= copy_sc_to_user(&frame->uc.uc_mcontext, &frame->fpstate, regs,
-			       set->sig[0]);
 
-	fp_to = (unsigned long)&frame->fpstate;
+	fp_to = (unsigned long)frame + sizeof(*frame);
+
+	err |= copy_sc_to_user(&frame->uc.uc_mcontext,
+			       (struct _xstate __user *)fp_to,
+			       regs, set->sig[0]);
 
 	err |= __put_user(fp_to, &frame->uc.uc_mcontext.fpstate);
 	if (sizeof(*set) == 16) {
diff --git a/arch/x86/um/user-offsets.c b/arch/x86/um/user-offsets.c
index 1c77d9946199..d6e1cd9956bf 100644
--- a/arch/x86/um/user-offsets.c
+++ b/arch/x86/um/user-offsets.c
@@ -20,9 +20,6 @@ void foo(void);
 void foo(void)
 {
 #ifdef __i386__
-	DEFINE_LONGS(HOST_FP_SIZE, sizeof(struct user_fpregs_struct));
-	DEFINE_LONGS(HOST_FPX_SIZE, sizeof(struct user_fpxregs_struct));
-
 	DEFINE(HOST_IP, EIP);
 	DEFINE(HOST_SP, UESP);
 	DEFINE(HOST_EFLAGS, EFL);
@@ -41,11 +38,6 @@ void foo(void)
 	DEFINE(HOST_GS, GS);
 	DEFINE(HOST_ORIG_AX, ORIG_EAX);
 #else
-#ifdef FP_XSTATE_MAGIC1
-	DEFINE_LONGS(HOST_FP_SIZE, 2696);
-#else
-	DEFINE(HOST_FP_SIZE, sizeof(struct _fpstate) / sizeof(unsigned long));
-#endif
 	DEFINE_LONGS(HOST_BX, RBX);
 	DEFINE_LONGS(HOST_CX, RCX);
 	DEFINE_LONGS(HOST_DI, RDI);
-- 
2.47.0


