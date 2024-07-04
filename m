Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6744BC3271F
	for <linux-um@archiver.kernel.org>; Thu,  4 Jul 2024 19:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bc29Sr6aX8h4cZL+gOhwItaaisczKHkx1TcNYThPy80=; b=OWpraD7FBhU+6cVyscUibFHGA4
	MZjUPlfF7fxPitOfHnrdgqEj6I+3bG9csvpZfOjlc3a6SQao7SaO1LNUSQGWkIxseitoNe+QKWY3X
	oF5IvecYLOpyQgRNDBAKThIBybcSOQVbM85V2AcGSBE4xcDaVWhfuNFoOskOOz9DEHgoBD839p1M7
	smiCiMK31xCPHO2o0OkUqD/xrzwVy3QUu7o83vtOEajaOmNEGsTAH5hvzhCFLb9gltdYMlV7D3q6n
	xfJOTgbexL2NzxGO1JrHpAMholFaSaSoMFYcfRhBCSwAIhaXuRHPqcwZxa1l9kJHXPT5iggllmC/q
	n15/GY+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPRlg-0000000EEEm-0O4T;
	Thu, 04 Jul 2024 19:05:20 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPRlc-0000000EECr-3IQe
	for linux-um@lists.infradead.org;
	Thu, 04 Jul 2024 19:05:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bc29Sr6aX8h4cZL+gOhwItaaisczKHkx1TcNYThPy80=;
	t=1720119916; x=1721329516; b=RGapQ7NYXpfLBxpW3rDe6Gp+5jLIYYR8j01ws50utNDhfyS
	z1qQtvfX/5CyHz8ASLC+5uTNncPTLhZAJnhh8hMoIvR9hrM6feCfSBG16cte7//YdIwfSHpTcNwO/
	GEW9kM5/PbhFVeIBR4T0h4H5D67TmnppeKDs3nNwdvhb9EPrYuNi9t5ewG+Kq2OIfvF33ckA22r+0
	WyffYytRKOIf3NcTgwBarBjtDI261Yoh7ohlGzMieYfo9BDuOtPUhVBrk0kiZQiU4//0XfmOCEaNP
	UJOSCV15sRAqmFYu6WW2s+7LIILOIUh5p2ox5mMBZEUBSokdATZmbOCCvhIMOHlA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sPRla-0000000DrZs-2ElT;
	Thu, 04 Jul 2024 21:05:14 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v8 2/7] um: use execveat to create userspace MMs
Date: Thu,  4 Jul 2024 21:05:01 +0200
Message-ID: <20240704190506.1438493-3-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704190506.1438493-1-benjamin@sipsolutions.net>
References: <20240704190506.1438493-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_120517_220722_11F05A23 
X-CRM114-Status: GOOD (  33.55  )
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

Using clone will not undo features that have been enabled by libc. An
example of this already happening is rseq, which could cause the kernel
to read/write memory of the userspace process. In the future the
standard library might also use mseal by default to protect itself,
which would also thwart our attempts at unmapping everything.

Solve all this by taking a step back and doing an execve into a tiny
static binary that sets up the minimal environment required for the
stub without using any standard library. That way we have a clean
execution environment that is fully under the control of UML.

Note that this changes things a bit as the FDs are not anymore shared
with the kernel. Instead, we explicitly share the FDs for the physical
memory and all existing iomem regions. Doing this is fine, as iomem
regions cannot be added at runtime.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

---

v8:
- Make changes suggested by Johannes Berg

v7:
- Rename stub_elf to stub_exe
- Move into architecture independent directory
- Fix 32 bit issues
- Improve tempfile logic
- Other cleanups

v6:
- Apply fixes pointed out by Tiwei Bie
- Add temporary file fallback as memfd is not always supported
---
 arch/um/include/shared/skas/stub-data.h |  11 ++
 arch/um/kernel/skas/.gitignore          |   2 +
 arch/um/kernel/skas/Makefile            |  33 ++++-
 arch/um/kernel/skas/stub_exe.c          |  88 ++++++++++++
 arch/um/kernel/skas/stub_exe_embed.S    |  11 ++
 arch/um/os-Linux/mem.c                  |   2 +-
 arch/um/os-Linux/skas/process.c         | 181 ++++++++++++++++--------
 7 files changed, 269 insertions(+), 59 deletions(-)
 create mode 100644 arch/um/kernel/skas/.gitignore
 create mode 100644 arch/um/kernel/skas/stub_exe.c
 create mode 100644 arch/um/kernel/skas/stub_exe_embed.S

diff --git a/arch/um/include/shared/skas/stub-data.h b/arch/um/include/shared/skas/stub-data.h
index 2b6b44759dfa..3fbdda727373 100644
--- a/arch/um/include/shared/skas/stub-data.h
+++ b/arch/um/include/shared/skas/stub-data.h
@@ -12,6 +12,17 @@
 #include <as-layout.h>
 #include <sysdep/tls.h>
 
+struct stub_init_data {
+	unsigned long stub_start;
+
+	int stub_code_fd;
+	unsigned long stub_code_offset;
+	int stub_data_fd;
+	unsigned long stub_data_offset;
+
+	unsigned long segv_handler;
+};
+
 #define STUB_NEXT_SYSCALL(s) \
 	((struct stub_syscall *) (((unsigned long) s) + (s)->cmd_len))
 
diff --git a/arch/um/kernel/skas/.gitignore b/arch/um/kernel/skas/.gitignore
new file mode 100644
index 000000000000..c3409ced0f38
--- /dev/null
+++ b/arch/um/kernel/skas/.gitignore
@@ -0,0 +1,2 @@
+stub_exe
+stub_exe.dbg
diff --git a/arch/um/kernel/skas/Makefile b/arch/um/kernel/skas/Makefile
index 6f86d53e3d69..fbb61968055f 100644
--- a/arch/um/kernel/skas/Makefile
+++ b/arch/um/kernel/skas/Makefile
@@ -3,14 +3,43 @@
 # Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
 #
 
-obj-y := stub.o mmu.o process.o syscall.o uaccess.o
+obj-y := stub.o mmu.o process.o syscall.o uaccess.o \
+	 stub_exe_embed.o
+
+# Stub executable
+
+stub_exe_objs-y := stub_exe.o
+
+stub_exe_objs := $(foreach F,$(stub_exe_objs-y),$(obj)/$F)
+
+# Object file containing the ELF executable
+$(obj)/stub_exe_embed.o: $(src)/stub_exe_embed.S $(obj)/stub_exe
+
+$(obj)/stub_exe.dbg: $(stub_exe_objs) FORCE
+	$(call if_changed,stub_exe)
+
+$(obj)/stub_exe: OBJCOPYFLAGS := -S
+$(obj)/stub_exe: $(obj)/stub_exe.dbg FORCE
+	$(call if_changed,objcopy)
+
+quiet_cmd_stub_exe = STUB_EXE $@
+      cmd_stub_exe = $(CC) -nostdlib -o $@ \
+			   $(KBUILD_CFLAGS) $(STUB_EXE_LDFLAGS) \
+			   $(filter %.o,$^)
+
+STUB_EXE_LDFLAGS = -n -static
+
+targets += stub_exe.dbg stub_exe $(stub_exe_objs-y)
+
+# end
 
 # stub.o is in the stub, so it can't be built with profiling
 # GCC hardened also auto-enables -fpic, but we need %ebx so it can't work ->
 # disable it
 
 CFLAGS_stub.o := $(CFLAGS_NO_HARDENING)
-UNPROFILE_OBJS := stub.o
+CFLAGS_stub_exe.o := $(CFLAGS_NO_HARDENING)
+UNPROFILE_OBJS := stub.o stub_exe.o
 KCOV_INSTRUMENT := n
 
 include $(srctree)/arch/um/scripts/Makefile.rules
diff --git a/arch/um/kernel/skas/stub_exe.c b/arch/um/kernel/skas/stub_exe.c
new file mode 100644
index 000000000000..bc6ba2e4d805
--- /dev/null
+++ b/arch/um/kernel/skas/stub_exe.c
@@ -0,0 +1,88 @@
+#include <sys/ptrace.h>
+#include <sys/prctl.h>
+#include <asm/unistd.h>
+#include <sysdep/stub.h>
+#include <stub-data.h>
+
+void _start(void);
+
+noinline static void real_init(void)
+{
+	struct stub_init_data init_data;
+	unsigned long res;
+	struct {
+		void  *ss_sp;
+		int    ss_flags;
+		size_t ss_size;
+	} stack = {
+		.ss_size = STUB_DATA_PAGES * UM_KERN_PAGE_SIZE,
+	};
+	struct {
+		void *sa_handler_;
+		unsigned long sa_flags;
+		void *sa_restorer;
+		unsigned long long sa_mask;
+	} sa = {
+		/* Need to set SA_RESTORER (but the handler never returns) */
+		.sa_flags = SA_ONSTACK | SA_NODEFER | SA_SIGINFO | 0x04000000,
+		/* no need to mask any signals */
+		.sa_mask = 0,
+	};
+
+	/* set a nice name */
+	stub_syscall2(__NR_prctl, PR_SET_NAME, (unsigned long)"uml-userspace");
+
+	/* read information from STDIN and close it */
+	res = stub_syscall3(__NR_read, 0,
+			    (unsigned long)&init_data, sizeof(init_data));
+	if (res != sizeof(init_data))
+		stub_syscall1(__NR_exit, 10);
+
+	stub_syscall1(__NR_close, 0);
+
+	/* map stub code + data */
+	res = stub_syscall6(STUB_MMAP_NR,
+			    init_data.stub_start, UM_KERN_PAGE_SIZE,
+			    PROT_READ | PROT_EXEC, MAP_FIXED | MAP_SHARED,
+			    init_data.stub_code_fd, init_data.stub_code_offset);
+	if (res != init_data.stub_start)
+		stub_syscall1(__NR_exit, 11);
+
+	res = stub_syscall6(STUB_MMAP_NR,
+			    init_data.stub_start + UM_KERN_PAGE_SIZE,
+			    STUB_DATA_PAGES * UM_KERN_PAGE_SIZE,
+			    PROT_READ | PROT_WRITE, MAP_FIXED | MAP_SHARED,
+			    init_data.stub_data_fd, init_data.stub_data_offset);
+	if (res != init_data.stub_start + UM_KERN_PAGE_SIZE)
+		stub_syscall1(__NR_exit, 12);
+
+	/* setup signal stack inside stub data */
+	stack.ss_sp = (void *)init_data.stub_start + UM_KERN_PAGE_SIZE;
+	stub_syscall2(__NR_sigaltstack, (unsigned long)&stack, 0);
+
+	/* register SIGSEGV handler */
+	sa.sa_handler_ = (void *) init_data.segv_handler;
+	res = stub_syscall4(__NR_rt_sigaction, SIGSEGV, (unsigned long)&sa, 0,
+			    sizeof(sa.sa_mask));
+	if (res != 0)
+		stub_syscall1(__NR_exit, 13);
+
+	stub_syscall4(__NR_ptrace, PTRACE_TRACEME, 0, 0, 0);
+
+	stub_syscall2(__NR_kill, stub_syscall0(__NR_getpid), SIGSTOP);
+
+	stub_syscall1(__NR_exit, 14);
+
+	__builtin_unreachable();
+}
+
+void _start(void)
+{
+	char *alloc;
+
+	/* Make enough space for the stub (including space for alignment) */
+	alloc = __builtin_alloca((1 + 2 * STUB_DATA_PAGES - 1) * UM_KERN_PAGE_SIZE);
+	asm volatile("" : "+r,m"(alloc) : : "memory");
+
+	real_init();
+}
diff --git a/arch/um/kernel/skas/stub_exe_embed.S b/arch/um/kernel/skas/stub_exe_embed.S
new file mode 100644
index 000000000000..6d8914fbe8f1
--- /dev/null
+++ b/arch/um/kernel/skas/stub_exe_embed.S
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/init.h>
+#include <linux/linkage.h>
+
+__INITDATA
+
+SYM_DATA_START(stub_exe_start)
+	.incbin "arch/um/kernel/skas/stub_exe"
+SYM_DATA_END_LABEL(stub_exe_start, SYM_L_GLOBAL, stub_exe_end)
+
+__FINIT
diff --git a/arch/um/os-Linux/mem.c b/arch/um/os-Linux/mem.c
index cf44d386f23c..857e3deab293 100644
--- a/arch/um/os-Linux/mem.c
+++ b/arch/um/os-Linux/mem.c
@@ -42,7 +42,7 @@ void kasan_map_memory(void *start, size_t len)
 }
 
 /* Set by make_tempfile() during early boot. */
-static char *tempdir = NULL;
+char *tempdir = NULL;
 
 /* Check if dir is on tmpfs. Return 0 if yes, -1 if no or error. */
 static int __init check_tmpfs(const char *dir)
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index f7088345b3fc..fece51b67689 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -10,8 +10,11 @@
 #include <sched.h>
 #include <errno.h>
 #include <string.h>
+#include <fcntl.h>
+#include <mem_user.h>
 #include <sys/mman.h>
 #include <sys/wait.h>
+#include <sys/stat.h>
 #include <asm/unistd.h>
 #include <as-layout.h>
 #include <init.h>
@@ -189,69 +192,135 @@ static void handle_trap(int pid, struct uml_pt_regs *regs)
 
 extern char __syscall_stub_start[];
 
-/**
- * userspace_tramp() - userspace trampoline
- * @stack:	pointer to the new userspace stack page
- *
- * The userspace trampoline is used to setup a new userspace process in start_userspace() after it was clone()'ed.
- * This function will run on a temporary stack page.
- * It ptrace()'es itself, then
- * Two pages are mapped into the userspace address space:
- * - STUB_CODE (with EXEC), which contains the skas stub code
- * - STUB_DATA (with R/W), which contains a data page that is used to transfer certain data between the UML userspace process and the UML kernel.
- * Also for the userspace process a SIGSEGV handler is installed to catch pagefaults in the userspace process.
- * And last the process stops itself to give control to the UML kernel for this userspace process.
- *
- * Return: Always zero, otherwise the current userspace process is ended with non null exit() call
- */
+static int stub_exe_fd;
+
 static int userspace_tramp(void *stack)
 {
-	struct sigaction sa;
-	void *addr;
-	int fd;
+	char *const argv[] = { "uml-userspace", NULL };
+	int pipe_fds[2];
 	unsigned long long offset;
-	unsigned long segv_handler = STUB_CODE +
-				     (unsigned long) stub_segv_handler -
-				     (unsigned long) __syscall_stub_start;
-
-	ptrace(PTRACE_TRACEME, 0, 0, 0);
-
-	signal(SIGTERM, SIG_DFL);
-	signal(SIGWINCH, SIG_IGN);
-
-	fd = phys_mapping(uml_to_phys(__syscall_stub_start), &offset);
-	addr = mmap64((void *) STUB_CODE, UM_KERN_PAGE_SIZE,
-		      PROT_EXEC, MAP_FIXED | MAP_PRIVATE, fd, offset);
-	if (addr == MAP_FAILED) {
-		os_info("mapping mmap stub at 0x%lx failed, errno = %d\n",
-			STUB_CODE, errno);
-		exit(1);
+	struct stub_init_data init_data = {
+		.stub_start = STUB_START,
+		.segv_handler = STUB_CODE +
+				(unsigned long) stub_segv_handler -
+				(unsigned long) __syscall_stub_start,
+	};
+	struct iomem_region *iomem;
+	int ret;
+
+	init_data.stub_code_fd = phys_mapping(uml_to_phys(__syscall_stub_start),
+					      &offset);
+	init_data.stub_code_offset = MMAP_OFFSET(offset);
+
+	init_data.stub_data_fd = phys_mapping(uml_to_phys(stack), &offset);
+	init_data.stub_data_offset = MMAP_OFFSET(offset);
+
+	/* Set CLOEXEC on all FDs and then unset on all memory related FDs */
+	close_range(0, ~0U, CLOSE_RANGE_CLOEXEC);
+
+	fcntl(init_data.stub_data_fd, F_SETFD, 0);
+	for (iomem = iomem_regions; iomem; iomem = iomem->next)
+		fcntl(iomem->fd, F_SETFD, 0);
+
+	/* Create a pipe for init_data (no CLOEXEC) and dup2 to STDIN */
+	if (pipe2(pipe_fds, 0))
+		exit(2);
+
+	close(0);
+	if (dup2(pipe_fds[0], 0) < 0) {
+		close(pipe_fds[0]);
+		close(pipe_fds[1]);
+		exit(3);
 	}
+	close(pipe_fds[0]);
+
+	/* Write init_data and close write side */
+	ret = write(pipe_fds[1], &init_data, sizeof(init_data));
+	close(pipe_fds[1]);
+
+	if (ret != sizeof(init_data))
+		exit(4);
+
+	execveat(stub_exe_fd, "", argv, NULL, AT_EMPTY_PATH);
 
-	fd = phys_mapping(uml_to_phys(stack), &offset);
-	addr = mmap((void *) STUB_DATA,
-		    STUB_DATA_PAGES * UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE,
-		    MAP_FIXED | MAP_SHARED, fd, offset);
-	if (addr == MAP_FAILED) {
-		os_info("mapping segfault stack at 0x%lx failed, errno = %d\n",
-			STUB_DATA, errno);
-		exit(1);
+	exit(5);
+}
+
+extern char stub_exe_start[];
+extern char stub_exe_end[];
+
+extern char *tempdir;
+
+#define STUB_EXE_NAME_TEMPLATE "/uml-userspace-XXXXXX"
+
+#ifndef MFD_EXEC
+#define MFD_EXEC 0x0010U
+#endif
+
+static int __init init_stub_exe_fd(void)
+{
+	size_t written = 0;
+	char *tmpfile = NULL;
+
+	stub_exe_fd = memfd_create("uml-userspace",
+				   MFD_EXEC | MFD_CLOEXEC | MFD_ALLOW_SEALING);
+
+	if (stub_exe_fd < 0) {
+		printk(UM_KERN_INFO "Could not create executable memfd, using temporary file!");
+
+		tmpfile = malloc(strlen(tempdir) +
+				  strlen(STUB_EXE_NAME_TEMPLATE) + 1);
+		if (tmpfile == NULL)
+			panic("Failed to allocate memory for stub binary name");
+
+		strcpy(tmpfile, tempdir);
+		strcat(tmpfile, STUB_EXE_NAME_TEMPLATE);
+
+		stub_exe_fd = mkstemp(tmpfile);
+		if (stub_exe_fd < 0)
+			panic("Could not create temporary file for stub binary: %d",
+			      -errno);
 	}
 
-	set_sigstack((void *) STUB_DATA, STUB_DATA_PAGES * UM_KERN_PAGE_SIZE);
-	sigemptyset(&sa.sa_mask);
-	sa.sa_flags = SA_ONSTACK | SA_NODEFER | SA_SIGINFO;
-	sa.sa_sigaction = (void *) segv_handler;
-	sa.sa_restorer = NULL;
-	if (sigaction(SIGSEGV, &sa, NULL) < 0) {
-		os_info("%s - setting SIGSEGV handler failed - errno = %d\n",
-			__func__, errno);
-		exit(1);
+	while (written < stub_exe_end - stub_exe_start) {
+		ssize_t res = write(stub_exe_fd, stub_exe_start + written,
+				    stub_exe_end - stub_exe_start - written);
+		if (res < 0) {
+			if (errno == EINTR)
+				continue;
+
+			if (tmpfile)
+				unlink(tmpfile);
+			panic("Failed write stub binary: %d", -errno);
+		}
+
+		written += res;
+	}
+
+	if (!tmpfile) {
+		fcntl(stub_exe_fd, F_ADD_SEALS,
+		      F_SEAL_WRITE | F_SEAL_SHRINK | F_SEAL_GROW | F_SEAL_SEAL);
+	} else {
+		if (fchmod(stub_exe_fd, 00500) < 0) {
+			unlink(tmpfile);
+			panic("Could not make stub binary executable: %d",
+			      -errno);
+		}
+
+		close(stub_exe_fd);
+		stub_exe_fd = open(tmpfile, O_RDONLY | O_CLOEXEC | O_NOFOLLOW);
+		if (stub_exe_fd < 0) {
+			unlink(tmpfile);
+			panic("Could not reopen stub binary: %d", -errno);
+		}
+
+		unlink(tmpfile);
+		free(tmpfile);
 	}
 
-	kill(os_getpid(), SIGSTOP);
 	return 0;
 }
+__initcall(init_stub_exe_fd);
 
 int userspace_pid[NR_CPUS];
 
@@ -270,7 +339,7 @@ int start_userspace(unsigned long stub_stack)
 {
 	void *stack;
 	unsigned long sp;
-	int pid, status, n, flags, err;
+	int pid, status, n, err;
 
 	/* setup a temporary stack page */
 	stack = mmap(NULL, UM_KERN_PAGE_SIZE,
@@ -286,10 +355,10 @@ int start_userspace(unsigned long stub_stack)
 	/* set stack pointer to the end of the stack page, so it can grow downwards */
 	sp = (unsigned long)stack + UM_KERN_PAGE_SIZE;
 
-	flags = CLONE_FILES | SIGCHLD;
-
 	/* clone into new userspace process */
-	pid = clone(userspace_tramp, (void *) sp, flags, (void *) stub_stack);
+	pid = clone(userspace_tramp, (void *) sp,
+		    CLONE_VFORK | CLONE_VM | SIGCHLD,
+		    (void *)stub_stack);
 	if (pid < 0) {
 		err = -errno;
 		printk(UM_KERN_ERR "%s : clone failed, errno = %d\n",
-- 
2.45.2


