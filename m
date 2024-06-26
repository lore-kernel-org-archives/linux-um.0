Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEEBCC30659
	for <linux-um@archiver.kernel.org>; Wed, 26 Jun 2024 13:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/7KCT0AY2i+G33rBmORtMeptGnTnxnNxzae2F8Aq6vM=; b=j/WPIE6AR1RKKT0+ih7vuNJtBp
	X5DcqXVGS9Q6YZ9u0oeNnDFlVU9D81iE7RjkuuSXM3OuMK6ORzvmLC0rfezL0LzI1Wa5GiajpY/OJ
	ctE6p15EkitwvuXwdJgtZN3ovPXjFd4tDmL/7W0V1RU5IPCkonmJBbnjpMBBsQD8oMVoQJu9R6jOn
	4H0LlTyikz3kUcsAWzU2FWIYQEgW2w1NMb/ab4tNwKp6MijljMLmbos0X7/M5pSjRLR7+iWetjxix
	K1d02qftCBq4NDCLp2jtZNr7OnkLD8jW9nJ1vJoh+mwimXYJVkEqGPv/XdG/jy8Jy76shHMBEAiiJ
	x5nltfOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMT88-000000074gY-2QkR;
	Wed, 26 Jun 2024 13:56:12 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMT82-000000074dg-02PS
	for linux-um@lists.infradead.org;
	Wed, 26 Jun 2024 13:56:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/7KCT0AY2i+G33rBmORtMeptGnTnxnNxzae2F8Aq6vM=;
	t=1719410165; x=1720619765; b=xhZRiobw91m/7JbCxSHTqVvJbNTY1FdA5y84kvVp0eoXu2x
	EFCMpWD5/hUOHxRq8cPUl4vCp2MUL1ulmfNPU/32MSMQ4cQStO9HrzzQNhGjBs3hAlrLsxRsXMmA3
	i/Uba8I7svySVKNuTs3hVPX35zPn0/TD2YAumMqCq6IEX37tKSHSGuX1kACkKf4+PxK+N6NcAEb2U
	l1M1eppZm3fhBJsCWRt5PgorGw9+ThrfEc6uD5ypxtW0sVueVs+UwiuPfXp1i7tFZTdXgyBGShCxz
	mUC/c15fA9LcN65A7snuD3fmLBboUP7pOdQJ/iSCeFupxSweO3PPEUbGRvH/1bMg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sMT7z-00000003rXd-3F2v;
	Wed, 26 Jun 2024 15:56:04 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v6 3/7] um: use execveat to create userspace MMs
Date: Wed, 26 Jun 2024 15:53:46 +0200
Message-ID: <20240626135350.493110-4-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626135350.493110-1-benjamin@sipsolutions.net>
References: <20240626135350.493110-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_065606_244072_AEED981F 
X-CRM114-Status: GOOD (  31.88  )
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

v6:
- Apply fixes pointed out by Tiwei Bie
- Add temporary file fallback as memfd is not always supported
---
 arch/um/include/shared/skas/stub-data.h |  11 ++
 arch/um/os-Linux/skas/process.c         | 171 ++++++++++++++++--------
 arch/x86/um/.gitignore                  |   2 +
 arch/x86/um/Makefile                    |  32 ++++-
 arch/x86/um/stub_elf.c                  |  86 ++++++++++++
 arch/x86/um/stub_elf_embed.S            |  11 ++
 6 files changed, 255 insertions(+), 58 deletions(-)
 create mode 100644 arch/x86/um/.gitignore
 create mode 100644 arch/x86/um/stub_elf.c
 create mode 100644 arch/x86/um/stub_elf_embed.S

diff --git a/arch/um/include/shared/skas/stub-data.h b/arch/um/include/shared/skas/stub-data.h
index 5e3ade3fb38b..83d210f59956 100644
--- a/arch/um/include/shared/skas/stub-data.h
+++ b/arch/um/include/shared/skas/stub-data.h
@@ -8,6 +8,17 @@
 #ifndef __STUB_DATA_H
 #define __STUB_DATA_H
 
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
 struct stub_data {
 	unsigned long offset;
 	int fd;
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 41a288dcfc34..1ba117325bc2 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -23,6 +23,9 @@
 #include <skas.h>
 #include <sysdep/stub.h>
 #include <linux/threads.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <mem_user.h>
 #include "../internal.h"
 
 int is_skas_winch(int pid, int fd, void *data)
@@ -188,69 +191,125 @@ static void handle_trap(int pid, struct uml_pt_regs *regs)
 
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
+static int stub_exec_fd;
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
+	execveat(stub_exec_fd, "", argv, NULL, AT_EMPTY_PATH);
+
+	close(0);
+
+	exit(5);
+}
+
+extern char stub_elf_start[];
+extern char stub_elf_end[];
 
-	fd = phys_mapping(uml_to_phys(stack), &offset);
-	addr = mmap((void *) STUB_DATA,
-		    STUB_DATA_PAGES * UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE,
-		    MAP_FIXED | MAP_SHARED, fd, offset);
-	if (addr == MAP_FAILED) {
-		os_info("mapping segfault stack at 0x%lx failed, errno = %d\n",
-			STUB_DATA, errno);
-		exit(1);
+static int __init init_stub_exec_fd(void)
+{
+	size_t len = 0;
+	int res;
+	char tmpfile[] = "/tmp/uml-userspace-XXXXXX";
+
+	stub_exec_fd = memfd_create("uml-userspace",
+				    MFD_EXEC | MFD_CLOEXEC | MFD_ALLOW_SEALING);
+
+	if (stub_exec_fd < 0) {
+		printk(UM_KERN_INFO "Could not create executable memfd, using temporary file!");
+
+		stub_exec_fd = mkostemp(tmpfile, O_CLOEXEC);
+		if (stub_exec_fd < 0)
+			panic("Could not create temporary file for stub binary: %d",
+			      errno);
+	} else {
+		tmpfile[0] = '\0';
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
+	while (len < stub_elf_end - stub_elf_start) {
+		res = write(stub_exec_fd, stub_elf_start + len,
+			    stub_elf_end - stub_elf_start - len);
+		if (res < 0) {
+			if (errno == EINTR)
+				continue;
+
+			if (tmpfile[0])
+				unlink(tmpfile);
+			panic("%s: Failed write to memfd: %d", __func__, errno);
+		}
+
+		len += res;
+	}
+
+	if (!tmpfile[0]) {
+		fcntl(stub_exec_fd, F_ADD_SEALS,
+		      F_SEAL_WRITE | F_SEAL_SHRINK | F_SEAL_GROW | F_SEAL_SEAL);
+	} else {
+		/* Only executable by us */
+		if (fchmod(stub_exec_fd, 00100) < 0) {
+			unlink(tmpfile);
+			panic("Could not make stub binary excutable: %d",
+			      errno);
+		}
+
+		close(stub_exec_fd);
+		stub_exec_fd = open(tmpfile, O_CLOEXEC);
+		if (stub_exec_fd < 0) {
+			unlink(tmpfile);
+			panic("Could not reopen stub binary: %d",
+			      errno);
+		}
+
+		unlink(tmpfile);
 	}
 
-	kill(os_getpid(), SIGSTOP);
 	return 0;
 }
+__initcall(init_stub_exec_fd);
 
 int userspace_pid[NR_CPUS];
 int kill_userspace_mm[NR_CPUS];
@@ -270,7 +329,7 @@ int start_userspace(unsigned long stub_stack)
 {
 	void *stack;
 	unsigned long sp;
-	int pid, status, n, flags, err;
+	int pid, status, n, err;
 
 	/* setup a temporary stack page */
 	stack = mmap(NULL, UM_KERN_PAGE_SIZE,
@@ -286,10 +345,10 @@ int start_userspace(unsigned long stub_stack)
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
diff --git a/arch/x86/um/.gitignore b/arch/x86/um/.gitignore
new file mode 100644
index 000000000000..91f9df29d1c3
--- /dev/null
+++ b/arch/x86/um/.gitignore
@@ -0,0 +1,2 @@
+stub_elf
+stub_elf.dbg
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index 8bc72a51b257..6e8b59498b64 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -11,10 +11,37 @@ endif
 
 obj-y = bugs_$(BITS).o delay.o fault.o ldt.o \
 	ptrace_$(BITS).o ptrace_user.o setjmp_$(BITS).o signal.o \
-	stub_$(BITS).o stub_segv.o \
+	stub_$(BITS).o stub_segv.o stub_elf_embed.o \
 	sys_call_table_$(BITS).o sysrq_$(BITS).o tls_$(BITS).o \
 	mem_$(BITS).o subarch.o os-Linux/
 
+# Stub executable
+
+stub_elf_objs-y := stub_elf.o
+
+stub_elf_objs := $(foreach F,$(stub_elf_objs-y),$(obj)/$F)
+
+# Object file containing the ELF executable
+$(obj)/stub_elf_embed.o: $(src)/stub_elf_embed.S $(obj)/stub_elf
+
+$(obj)/stub_elf.dbg: $(stub_elf_objs) FORCE
+	$(call if_changed,stub_elf)
+
+$(obj)/stub_elf: OBJCOPYFLAGS := -S
+$(obj)/stub_elf: $(obj)/stub_elf.dbg FORCE
+	$(call if_changed,objcopy)
+
+quiet_cmd_stub_elf = STUB_ELF $@
+      cmd_stub_elf = $(CC) -nostdlib -o $@ \
+			    $(CC_FLAGS_LTO) $(STUB_ELF_LDFLAGS) \
+			    $(filter %.o,$^)
+
+STUB_ELF_LDFLAGS = -n -static
+
+targets += stub_elf.dbg stub_elf $(stub_elf_objs-y)
+
+# end
+
 ifeq ($(CONFIG_X86_32),y)
 
 obj-y += syscalls_32.o
@@ -46,7 +73,8 @@ targets += user-offsets.s
 include/generated/user_constants.h: $(obj)/user-offsets.s FORCE
 	$(call filechk,offsets,__USER_CONSTANT_H__)
 
-UNPROFILE_OBJS := stub_segv.o
+UNPROFILE_OBJS := stub_segv.o stub_elf.o
 CFLAGS_stub_segv.o := $(CFLAGS_NO_HARDENING)
+CFLAGS_stub_elf.o := $(CFLAGS_NO_HARDENING)
 
 include $(srctree)/arch/um/scripts/Makefile.rules
diff --git a/arch/x86/um/stub_elf.c b/arch/x86/um/stub_elf.c
new file mode 100644
index 000000000000..2bf1a717065d
--- /dev/null
+++ b/arch/x86/um/stub_elf.c
@@ -0,0 +1,86 @@
+#include <sys/ptrace.h>
+#include <sys/prctl.h>
+#include <asm/unistd.h>
+#include <sysdep/stub.h>
+#include <stub-data.h>
+
+void _start(void);
+
+static void real_init(void)
+{
+	struct stub_init_data init_data;
+	unsigned long res;
+	struct {
+		void  *ss_sp;
+		int    ss_flags;
+		size_t ss_size;
+	} stack;
+	struct {
+		void *sa_handler_;
+		unsigned long sa_flags;
+		void *sa_restorer;
+		unsigned long sa_mask;
+	} sa = {};
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
+	stack.ss_flags = 0;
+	stack.ss_size = STUB_DATA_PAGES * UM_KERN_PAGE_SIZE;
+	stack.ss_sp = (void *)init_data.stub_start + UM_KERN_PAGE_SIZE;
+	stub_syscall2(__NR_sigaltstack, (unsigned long)&stack, 0);
+
+	/* register SIGSEGV handler (SA_RESTORER, the handler never returns) */
+	sa.sa_flags = SA_ONSTACK | SA_NODEFER | SA_SIGINFO | 0x04000000;
+	sa.sa_handler_ = (void *) init_data.segv_handler;
+	sa.sa_restorer = NULL;
+	sa.sa_mask = 0L; /* No need to mask anything */
+	res = stub_syscall4(__NR_rt_sigaction, SIGSEGV, (unsigned long)&sa, 0,
+			    sizeof(sa.sa_mask));
+	if (res < 0)
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
+	/* bump the stack pointer as the stub is mapped into our stack */
+	alloc = __builtin_alloca((1 + STUB_DATA_PAGES) * UM_KERN_PAGE_SIZE);
+	asm volatile("" : "+r,m"(alloc) : : "memory");
+
+	real_init();
+}
diff --git a/arch/x86/um/stub_elf_embed.S b/arch/x86/um/stub_elf_embed.S
new file mode 100644
index 000000000000..e39321b4c313
--- /dev/null
+++ b/arch/x86/um/stub_elf_embed.S
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/init.h>
+#include <linux/linkage.h>
+
+__INITDATA
+
+SYM_DATA_START(stub_elf_start)
+	.incbin "arch/x86/um/stub_elf"
+SYM_DATA_END_LABEL(stub_elf_start, SYM_L_GLOBAL, stub_elf_end)
+
+__FINIT
-- 
2.45.2


