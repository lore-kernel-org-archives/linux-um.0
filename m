Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD28C19778
	for <linux-um@archiver.kernel.org>; Mon, 24 Feb 2025 18:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OYIQ1cj8WbAHYfA+mXDcUA0ipKeO3/0z5mYsCZU0z6M=; b=OsvPo0iu9vvTkWevbKFNzvnWOL
	nk7+z2/rXW6Ezrs1WPlWS9OHF29AwY0uuNZpSRlQUgZ5RL1+m1l+biIHb7eHcYyWxKFY6+p2aw8QM
	PrTK7sVtIaUHQnwajcT1JPROb3pBEbbFzaPGKQ9J2wC2hhPXDxP+qlW78+FiuQdrNmJ5XRU9OHkET
	FCCJL5w3tCm368nS8pVBxBUlgS+CiQkBNkLLXXGBeYNS5IXOSleAFRgqFuUeV23K9Zg4XVmfCQGRd
	Fj30K5FLUaDbNribmDkKsZDzF2NtJOQOQp6eXsoy6+xaH9a7vWglbcstbrSUkwpDca8yBX3nuaxeV
	ifKPw8gA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmd8S-0000000EnNr-1m1V;
	Mon, 24 Feb 2025 18:24:56 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmd2x-0000000EmBO-1kMy
	for linux-um@lists.infradead.org;
	Mon, 24 Feb 2025 18:19:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=OYIQ1cj8WbAHYfA+mXDcUA0ipKeO3/0z5mYsCZU0z6M=;
	t=1740421155; x=1741630755; b=lwK9SkjgsitPjrwEQ0nk4Y1YhSofR9be6ryPqr5lU+xvVgo
	29LTY38RA6Ddc2dm7hofeBbYZaaK9fTmwf9JLJ0xKF8aD9BVsEcmz6HXERcaa6XUv+ye7kHfmEAeX
	LwHxoORW7skvFFCXWxCukw+hjXqlJxLBcj6Z3aiLhaqnPvqcN7vC/Erlg1hdTqIPtvX+V9Xn4Ywee
	u/NRaXTCp9kgHswumfRXvsWa7ZN5/+FGDCgUvSnKwHdCMzGuACVdqe+cKjGarKwWKhN9vDJyUombj
	DdTufOiRbT/lrrrtApNyWC2s69ip1L0ZCrr8SIDG+SY355vdoqLdJnU/rWB5VYUw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tmd2v-00000008tWp-1NFv;
	Mon, 24 Feb 2025 19:19:13 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 8/9] um: pass FD for memory operations when needed
Date: Mon, 24 Feb 2025 19:18:26 +0100
Message-ID: <20250224181827.647129-9-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224181827.647129-1-benjamin@sipsolutions.net>
References: <20250224181827.647129-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_101915_755886_EABA47F8 
X-CRM114-Status: GOOD (  36.88  )
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

Instead of always sharing the FDs with the userspace process, only hand
over the FDs needed for mmap when required. The idea is that userspace
might be able to force the stub into executing an mmap syscall, however,
it will not be able to manipulate the control flow sufficiently to have
access to an FD that would allow mapping arbitrary memory.

Security wise, we need to be sure that only the expected syscalls are
executed after the kernel sends FDs through the socket. This is
currently not the case, as userspace can trivially jump to the
rt_sigreturn syscall instruction to execute any syscall that the stub is
permitted to do. With this, it can trick the kernel to send the FD,
which in turn allows userspace to freely map any physical memory.

As such, this is currently *not* secure. However, in principle the
approach should be fine with a more strict SECCOMP filter and a careful
review of the stub control flow (as userspace can prepare a stack). With
some care, it is likely possible to extend the security model to SMP if
desired.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

---

v1:
* Add startup and runtime checks for close_range
---
 arch/um/include/shared/skas/mm_id.h     |  11 +++
 arch/um/include/shared/skas/stub-data.h |   1 +
 arch/um/kernel/skas/mmu.c               |   3 +
 arch/um/kernel/skas/stub.c              |  87 ++++++++++++++--
 arch/um/kernel/skas/stub_exe.c          |  40 +++++---
 arch/um/os-Linux/skas/mem.c             |  66 ++++++++++++-
 arch/um/os-Linux/skas/process.c         | 126 +++++++++++++++++-------
 arch/um/os-Linux/start_up.c             |  10 +-
 8 files changed, 284 insertions(+), 60 deletions(-)

diff --git a/arch/um/include/shared/skas/mm_id.h b/arch/um/include/shared/skas/mm_id.h
index 0654c57bb28e..f2d4c383c958 100644
--- a/arch/um/include/shared/skas/mm_id.h
+++ b/arch/um/include/shared/skas/mm_id.h
@@ -6,10 +6,21 @@
 #ifndef __MM_ID_H
 #define __MM_ID_H
 
+#ifdef CONFIG_UML_SECCOMP
+#define STUB_MAX_FDS 4
+#else
+#define STUB_MAX_FDS 0
+#endif
+
 struct mm_id {
 	int pid;
 	unsigned long stack;
 	int syscall_data_len;
+
+	/* Only used with SECCOMP mode */
+	int sock;
+	int syscall_fd_num;
+	int syscall_fd_map[STUB_MAX_FDS];
 };
 
 void __switch_mm(struct mm_id *mm_idp);
diff --git a/arch/um/include/shared/skas/stub-data.h b/arch/um/include/shared/skas/stub-data.h
index 675f1a0a1390..c261a77a32f6 100644
--- a/arch/um/include/shared/skas/stub-data.h
+++ b/arch/um/include/shared/skas/stub-data.h
@@ -12,6 +12,7 @@
 #include <as-layout.h>
 #include <sysdep/tls.h>
 #include <sysdep/stub-data.h>
+#include <mm_id.h>
 
 #define FUTEX_IN_CHILD 0
 #define FUTEX_IN_KERN 1
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index 0abc509e3f4c..b31d27e7810e 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -78,6 +78,9 @@ void destroy_context(struct mm_struct *mm)
 		mmu->id.pid = -1;
 	}
 
+	if (using_seccomp && mmu->id.sock)
+		os_close_file(mmu->id.sock);
+
 	free_pages(mmu->id.stack, ilog2(STUB_DATA_PAGES));
 
 	guard(spinlock_irqsave)(&mm_list_lock);
diff --git a/arch/um/kernel/skas/stub.c b/arch/um/kernel/skas/stub.c
index ec644cd82bbe..e92aefe06da8 100644
--- a/arch/um/kernel/skas/stub.c
+++ b/arch/um/kernel/skas/stub.c
@@ -7,24 +7,54 @@
 
 #ifdef CONFIG_UML_SECCOMP
 #include <linux/futex.h>
+#include <sys/socket.h>
 #include <errno.h>
 #endif
 
-static __always_inline int syscall_handler(struct stub_data *d)
+/*
+ * Known security issues
+ *
+ * Userspace can jump to this address to execute *any* syscall that is
+ * permitted by the stub. As we will return afterwards, it can do
+ * whatever it likes, including:
+ * - Tricking the kernel into handing out the memory FD
+ * - Using this memory FD to read/write all physical memory
+ * - Running in parallel to the kernel processing a syscall
+ *   (possibly creating data races?)
+ * - Blocking e.g. SIGALRM to avoid time based scheduling
+ *
+ * To avoid this, the permitted location for each syscall needs to be
+ * checked for in the SECCOMP filter (which is reasonably simple). Also,
+ * more care will need to go into considerations how the code might be
+ * tricked by using a prepared stack (or even modifying the stack from
+ * another thread in case SMP support is added).
+ *
+ * As for the SIGALRM, the best counter measure will be to check in the
+ * kernel that the process is reporting back the SIGALRM in a timely
+ * fashion.
+ */
+static __always_inline int syscall_handler(int fd_map[STUB_MAX_FDS])
 {
+	struct stub_data *d = get_stub_data();
 	int i;
 	unsigned long res;
+	int fd;
 
 	for (i = 0; i < d->syscall_data_len; i++) {
 		struct stub_syscall *sc = &d->syscall_data[i];
 
 		switch (sc->syscall) {
 		case STUB_SYSCALL_MMAP:
+			if (fd_map)
+				fd = fd_map[sc->mem.fd];
+			else
+				fd = sc->mem.fd;
+
 			res = stub_syscall6(STUB_MMAP_NR,
 					    sc->mem.addr, sc->mem.length,
 					    sc->mem.prot,
 					    MAP_SHARED | MAP_FIXED,
-					    sc->mem.fd, sc->mem.offset);
+					    fd, sc->mem.offset);
 			if (res != sc->mem.addr) {
 				d->err = res;
 				d->syscall_data_len = i;
@@ -56,9 +86,7 @@ static __always_inline int syscall_handler(struct stub_data *d)
 void __section(".__syscall_stub")
 stub_syscall_handler(void)
 {
-	struct stub_data *d = get_stub_data();
-
-	syscall_handler(d);
+	syscall_handler(NULL);
 
 	trap_myself();
 }
@@ -68,7 +96,25 @@ void __section(".__syscall_stub")
 stub_signal_interrupt(int sig, siginfo_t *info, void *p)
 {
 	struct stub_data *d = get_stub_data();
+	char rcv_data;
+	union {
+		char data[CMSG_SPACE(sizeof(int) * STUB_MAX_FDS)];
+		struct cmsghdr align;
+	} ctrl = {};
+	struct iovec iov = {
+		.iov_base = &rcv_data,
+		.iov_len = 1,
+	};
+	struct msghdr msghdr = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_control = &ctrl,
+		.msg_controllen = sizeof(ctrl),
+	};
 	ucontext_t *uc = p;
+	struct cmsghdr *fd_msg;
+	int *fd_map;
+	int num_fds;
 	long res;
 
 	d->signal = sig;
@@ -81,6 +127,7 @@ stub_signal_interrupt(int sig, siginfo_t *info, void *p)
 		res = stub_syscall3(__NR_futex, (unsigned long)&d->futex,
 				    FUTEX_WAKE, 1);
 	} while (res == -EINTR);
+
 	do {
 		res = stub_syscall4(__NR_futex, (unsigned long)&d->futex,
 				    FUTEX_WAIT, FUTEX_IN_KERN, 0);
@@ -89,11 +136,37 @@ stub_signal_interrupt(int sig, siginfo_t *info, void *p)
 	if (res < 0 && res != -EAGAIN)
 		stub_syscall1(__NR_exit_group, 1);
 
-	/* Try running queued syscalls. */
-	if (syscall_handler(d) < 0 || d->restart_wait) {
+	if (d->syscall_data_len) {
+		/* Read passed FDs (if any) */
+		do {
+			res = stub_syscall3(__NR_recvmsg, 0, (unsigned long)&msghdr, 0);
+		} while (res == -EINTR);
+
+		/* We should never have a receive error (other than -EAGAIN) */
+		if (res < 0 && res != -EAGAIN)
+			stub_syscall1(__NR_exit_group, 1);
+
+		/* Receive the FDs */
+		num_fds = 0;
+		fd_msg = msghdr.msg_control;
+		fd_map = (void *)&CMSG_DATA(fd_msg);
+		if (res == iov.iov_len && msghdr.msg_controllen > sizeof(struct cmsghdr))
+			num_fds = (fd_msg->cmsg_len - CMSG_LEN(0)) / sizeof(int);
+
+		/* Try running queued syscalls. */
+		res = syscall_handler(fd_map);
+
+		while (num_fds)
+			stub_syscall2(__NR_close, fd_map[--num_fds], 0);
+	} else {
+		res = 0;
+	}
+
+	if (res < 0 || d->restart_wait) {
 		/* Report SIGSYS if we restart. */
 		d->signal = SIGSYS;
 		d->restart_wait = 0;
+
 		goto restart_wait;
 	}
 
diff --git a/arch/um/kernel/skas/stub_exe.c b/arch/um/kernel/skas/stub_exe.c
index f40f2332b676..cbafaa684e66 100644
--- a/arch/um/kernel/skas/stub_exe.c
+++ b/arch/um/kernel/skas/stub_exe.c
@@ -1,5 +1,6 @@
 #include <sys/ptrace.h>
 #include <sys/prctl.h>
+#include <sys/fcntl.h>
 #include <asm/unistd.h>
 #include <sysdep/stub.h>
 #include <stub-data.h>
@@ -45,7 +46,11 @@ noinline static void real_init(void)
 	if (res != sizeof(init_data))
 		stub_syscall1(__NR_exit, 10);
 
-	stub_syscall1(__NR_close, 0);
+	/* In SECCOMP mode, FD 0 is a socket and is later used for FD passing */
+	if (!init_data.seccomp)
+		stub_syscall1(__NR_close, 0);
+	else
+		stub_syscall3(__NR_fcntl, 0, F_SETFL, O_NONBLOCK);
 
 	/* map stub code + data */
 	res = stub_syscall6(STUB_MMAP_NR,
@@ -63,6 +68,13 @@ noinline static void real_init(void)
 	if (res != init_data.stub_start + UM_KERN_PAGE_SIZE)
 		stub_syscall1(__NR_exit, 12);
 
+	/* In SECCOMP mode, we only need the signalling FD from now on */
+	if (init_data.seccomp) {
+		res = stub_syscall3(__NR_close_range, 1, ~0U, 0);
+		if (res != 0)
+			stub_syscall1(__NR_exit, 13);
+	}
+
 	/* setup signal stack inside stub data */
 	stack.ss_sp = (void *)init_data.stub_start + UM_KERN_PAGE_SIZE;
 	stub_syscall2(__NR_sigaltstack, (unsigned long)&stack, 0);
@@ -77,7 +89,7 @@ noinline static void real_init(void)
 		res = stub_syscall4(__NR_rt_sigaction, SIGSEGV,
 				    (unsigned long)&sa, 0, sizeof(sa.sa_mask));
 		if (res != 0)
-			stub_syscall1(__NR_exit, 13);
+			stub_syscall1(__NR_exit, 14);
 	} else {
 		/* SECCOMP mode uses rt_sigreturn, need to mask all signals */
 		sa.sa_mask = ~0ULL;
@@ -85,32 +97,32 @@ noinline static void real_init(void)
 		res = stub_syscall4(__NR_rt_sigaction, SIGSEGV,
 				    (unsigned long)&sa, 0, sizeof(sa.sa_mask));
 		if (res != 0)
-			stub_syscall1(__NR_exit, 14);
+			stub_syscall1(__NR_exit, 15);
 
 		res = stub_syscall4(__NR_rt_sigaction, SIGSYS,
 				    (unsigned long)&sa, 0, sizeof(sa.sa_mask));
 		if (res != 0)
-			stub_syscall1(__NR_exit, 15);
+			stub_syscall1(__NR_exit, 16);
 
 		res = stub_syscall4(__NR_rt_sigaction, SIGALRM,
 				    (unsigned long)&sa, 0, sizeof(sa.sa_mask));
 		if (res != 0)
-			stub_syscall1(__NR_exit, 16);
+			stub_syscall1(__NR_exit, 17);
 
 		res = stub_syscall4(__NR_rt_sigaction, SIGTRAP,
 				    (unsigned long)&sa, 0, sizeof(sa.sa_mask));
 		if (res != 0)
-			stub_syscall1(__NR_exit, 17);
+			stub_syscall1(__NR_exit, 18);
 
 		res = stub_syscall4(__NR_rt_sigaction, SIGILL,
 				    (unsigned long)&sa, 0, sizeof(sa.sa_mask));
 		if (res != 0)
-			stub_syscall1(__NR_exit, 18);
+			stub_syscall1(__NR_exit, 19);
 
 		res = stub_syscall4(__NR_rt_sigaction, SIGFPE,
 				    (unsigned long)&sa, 0, sizeof(sa.sa_mask));
 		if (res != 0)
-			stub_syscall1(__NR_exit, 19);
+			stub_syscall1(__NR_exit, 20);
 	}
 
 	/*
@@ -153,8 +165,12 @@ noinline static void real_init(void)
 			BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
 				 offsetof(struct seccomp_data, nr)),
 
-			/* [10-14] Check against permitted syscalls */
+			/* [10-16] Check against permitted syscalls */
 			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_futex,
+				 7, 0),
+			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K,__NR_recvmsg,
+				 6, 0),
+			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K,__NR_close,
 				 5, 0),
 			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, STUB_MMAP_NR,
 				 4, 0),
@@ -170,10 +186,10 @@ noinline static void real_init(void)
 			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_rt_sigreturn,
 				 1, 0),
 
-			/* [15] Not one of the permitted syscalls */
+			/* [17] Not one of the permitted syscalls */
 			BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_KILL_PROCESS),
 
-			/* [16] Permitted call for the stub */
+			/* [18] Permitted call for the stub */
 			BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW),
 		};
 		struct sock_fprog prog = {
@@ -184,7 +200,7 @@ noinline static void real_init(void)
 		if (stub_syscall3(__NR_seccomp, SECCOMP_SET_MODE_FILTER,
 				  SECCOMP_FILTER_FLAG_TSYNC,
 				  (unsigned long)&prog) != 0)
-			stub_syscall1(__NR_exit, 20);
+			stub_syscall1(__NR_exit, 21);
 
 		/* Fall through, the exit syscall will cause SIGSYS */
 	} else {
diff --git a/arch/um/os-Linux/skas/mem.c b/arch/um/os-Linux/skas/mem.c
index 31bf3a52047a..8b9921ac3ef8 100644
--- a/arch/um/os-Linux/skas/mem.c
+++ b/arch/um/os-Linux/skas/mem.c
@@ -43,6 +43,16 @@ void syscall_stub_dump_error(struct mm_id *mm_idp)
 
 	print_hex_dump(UM_KERN_ERR, "    syscall data: ", 0,
 		       16, 4, sc, sizeof(*sc), 0);
+
+	if (using_seccomp) {
+		printk(UM_KERN_ERR "%s: FD map num: %d", __func__,
+		       mm_idp->syscall_fd_num);
+		print_hex_dump(UM_KERN_ERR,
+				"    FD map: ", 0, 16,
+				sizeof(mm_idp->syscall_fd_map[0]),
+				mm_idp->syscall_fd_map,
+				sizeof(mm_idp->syscall_fd_map), 0);
+	}
 }
 
 static inline unsigned long *check_init_stack(struct mm_id * mm_idp,
@@ -118,6 +128,9 @@ static inline long do_syscall_stub(struct mm_id *mm_idp)
 		mm_idp->syscall_data_len = 0;
 	}
 
+	if (using_seccomp)
+		mm_idp->syscall_fd_num = 0;
+
 	return mm_idp->syscall_data_len;
 }
 
@@ -180,6 +193,44 @@ static struct stub_syscall *syscall_stub_get_previous(struct mm_id *mm_idp,
 	return NULL;
 }
 
+static int get_stub_fd(struct mm_id *mm_idp, int fd)
+{
+	int i;
+
+	/* Find an FD slot (or flush and use first) */
+	if (!using_seccomp)
+		return fd;
+
+	/* Already crashed, value does not matter */
+	if (mm_idp->syscall_data_len < 0)
+		return 0;
+
+	/* Find existing FD in map if we can allocate another syscall */
+	if (mm_idp->syscall_data_len <
+	    ARRAY_SIZE(((struct stub_data *)NULL)->syscall_data)) {
+		for (i = 0; i < mm_idp->syscall_fd_num; i++) {
+			if (mm_idp->syscall_fd_map[i] == fd)
+				return i;
+		}
+
+		if (mm_idp->syscall_fd_num < STUB_MAX_FDS) {
+			i = mm_idp->syscall_fd_num;
+			mm_idp->syscall_fd_map[i] = fd;
+
+			mm_idp->syscall_fd_num++;
+
+			return i;
+		}
+	}
+
+	/* FD map full or no syscall space available, continue after flush */
+	do_syscall_stub(mm_idp);
+	mm_idp->syscall_fd_map[0] = fd;
+	mm_idp->syscall_fd_num = 1;
+
+	return 0;
+}
+
 int map(struct mm_id *mm_idp, unsigned long virt, unsigned long len, int prot,
 	int phys_fd, unsigned long long offset)
 {
@@ -187,12 +238,21 @@ int map(struct mm_id *mm_idp, unsigned long virt, unsigned long len, int prot,
 
 	/* Compress with previous syscall if that is possible */
 	sc = syscall_stub_get_previous(mm_idp, STUB_SYSCALL_MMAP, virt);
-	if (sc && sc->mem.prot == prot && sc->mem.fd == phys_fd &&
+	if (sc && sc->mem.prot == prot &&
 	    sc->mem.offset == MMAP_OFFSET(offset - sc->mem.length)) {
-		sc->mem.length += len;
-		return 0;
+		int prev_fd = sc->mem.fd;
+
+		if (using_seccomp)
+			prev_fd = mm_idp->syscall_fd_map[sc->mem.fd];
+
+		if (phys_fd == prev_fd) {
+			sc->mem.length += len;
+			return 0;
+		}
 	}
 
+	phys_fd = get_stub_fd(mm_idp, phys_fd);
+
 	sc = syscall_stub_alloc(mm_idp);
 	sc->syscall = STUB_SYSCALL_MMAP;
 	sc->mem.addr = virt;
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index ecb2278caca6..5f9ee31e2220 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -16,6 +16,7 @@
 #include <sys/mman.h>
 #include <sys/wait.h>
 #include <sys/stat.h>
+#include <sys/socket.h>
 #include <asm/unistd.h>
 #include <as-layout.h>
 #include <init.h>
@@ -153,7 +154,39 @@ void wait_stub_done_seccomp(struct mm_id *mm_idp, int running, int wait_sigsys)
 	int ret;
 
 	do {
+		const char byte = 0;
+		struct iovec iov = {
+			.iov_base = (void *)&byte,
+			.iov_len = sizeof(byte),
+		};
+		union {
+			char data[CMSG_SPACE(sizeof(mm_idp->syscall_fd_map))];
+			struct cmsghdr align;
+		} ctrl;
+		struct msghdr msgh = {
+			.msg_iov = &iov,
+			.msg_iovlen = 1,
+		};
+
 		if (!running) {
+			if (mm_idp->syscall_fd_num) {
+				unsigned int fds_size =
+					sizeof(int) * mm_idp->syscall_fd_num;
+				struct cmsghdr *cmsg;
+
+				msgh.msg_control = ctrl.data;
+				msgh.msg_controllen = CMSG_SPACE(fds_size);
+				cmsg = CMSG_FIRSTHDR(&msgh);
+				cmsg->cmsg_level = SOL_SOCKET;
+				cmsg->cmsg_type = SCM_RIGHTS;
+				cmsg->cmsg_len = CMSG_LEN(fds_size);
+				memcpy(CMSG_DATA(cmsg), mm_idp->syscall_fd_map,
+				       fds_size);
+
+				CATCH_EINTR(syscall(__NR_sendmsg, mm_idp->sock,
+						&msgh, 0));
+			}
+
 			data->signal = 0;
 			data->futex = FUTEX_IN_CHILD;
 			CATCH_EINTR(syscall(__NR_futex, &data->futex,
@@ -248,14 +281,20 @@ extern char __syscall_stub_start[];
 
 static int stub_exe_fd;
 
+struct tramp_data {
+	struct stub_data *stub_data;
+	/* 0 is inherited, 1 is the kernel side */
+	int sockpair[2];
+};
+
 #ifndef CLOSE_RANGE_CLOEXEC
 #define CLOSE_RANGE_CLOEXEC	(1U << 2)
 #endif
 
-static int userspace_tramp(void *stack)
+static int userspace_tramp(void *data)
 {
+	struct tramp_data *tramp_data = data;
 	char *const argv[] = { "uml-userspace", NULL };
-	int pipe_fds[2];
 	unsigned long long offset;
 	struct stub_init_data init_data = {
 		.seccomp = using_seccomp,
@@ -282,7 +321,8 @@ static int userspace_tramp(void *stack)
 					      &offset);
 	init_data.stub_code_offset = MMAP_OFFSET(offset);
 
-	init_data.stub_data_fd = phys_mapping(uml_to_phys(stack), &offset);
+	init_data.stub_data_fd = phys_mapping(uml_to_phys(tramp_data->stub_data),
+					      &offset);
 	init_data.stub_data_offset = MMAP_OFFSET(offset);
 
 	/*
@@ -293,20 +333,21 @@ static int userspace_tramp(void *stack)
 	syscall(__NR_close_range, 0, ~0U, CLOSE_RANGE_CLOEXEC);
 
 	fcntl(init_data.stub_data_fd, F_SETFD, 0);
-	for (iomem = iomem_regions; iomem; iomem = iomem->next)
-		fcntl(iomem->fd, F_SETFD, 0);
 
-	/* Create a pipe for init_data (no CLOEXEC) and dup2 to STDIN */
-	if (pipe(pipe_fds))
-		exit(2);
+	/* In SECCOMP mode, these FDs are passed when needed */
+	if (!using_seccomp) {
+		for (iomem = iomem_regions; iomem; iomem = iomem->next)
+			fcntl(iomem->fd, F_SETFD, 0);
+	}
 
-	if (dup2(pipe_fds[0], 0) < 0)
+	/* dup2 signaling FD/socket to STDIN */
+	if (dup2(tramp_data->sockpair[0], 0) < 0)
 		exit(3);
-	close(pipe_fds[0]);
+	close(tramp_data->sockpair[0]);
 
 	/* Write init_data and close write side */
-	ret = write(pipe_fds[1], &init_data, sizeof(init_data));
-	close(pipe_fds[1]);
+	ret = write(tramp_data->sockpair[1], &init_data, sizeof(init_data));
+	close(tramp_data->sockpair[1]);
 
 	if (ret != sizeof(init_data))
 		exit(4);
@@ -401,7 +442,7 @@ int userspace_pid[NR_CPUS];
 
 /**
  * start_userspace() - prepare a new userspace process
- * @stub_stack:	pointer to the stub stack.
+ * @mm_id: The corresponding struct mm_id
  *
  * Setups a new temporary stack page that is used while userspace_tramp() runs
  * Clones the kernel process into a new userspace process, with FDs only.
@@ -413,9 +454,12 @@ int userspace_pid[NR_CPUS];
 int start_userspace(struct mm_id *mm_id)
 {
 	struct stub_data *proc_data = (void *)mm_id->stack;
+	struct tramp_data tramp_data = {
+		.stub_data = proc_data,
+	};
 	void *stack;
 	unsigned long sp;
-	int pid, status, n, err;
+	int status, n, err;
 
 	/* setup a temporary stack page */
 	stack = mmap(NULL, UM_KERN_PAGE_SIZE,
@@ -431,25 +475,32 @@ int start_userspace(struct mm_id *mm_id)
 	/* set stack pointer to the end of the stack page, so it can grow downwards */
 	sp = (unsigned long)stack + UM_KERN_PAGE_SIZE;
 
+	/* socket pair for init data and SECCOMP FD passing (no CLOEXEC here) */
+	if (socketpair(AF_UNIX, SOCK_STREAM, 0, tramp_data.sockpair)) {
+		err = -errno;
+		printk(UM_KERN_ERR "%s : socketpair failed, errno = %d\n",
+		       __func__, errno);
+		return err;
+	}
+
 	if (using_seccomp)
 		proc_data->futex = FUTEX_IN_CHILD;
 
-	/* clone into new userspace process */
-	pid = clone(userspace_tramp, (void *) sp,
+	mm_id->pid = clone(userspace_tramp, (void *) sp,
 		    CLONE_VFORK | CLONE_VM | SIGCHLD,
-		    (void *)mm_id->stack);
-	if (pid < 0) {
+		    (void *)&tramp_data);
+	if (mm_id->pid < 0) {
 		err = -errno;
 		printk(UM_KERN_ERR "%s : clone failed, errno = %d\n",
 		       __func__, errno);
-		return err;
+		goto out_close;
 	}
 
 	if (using_seccomp) {
 		wait_stub_done_seccomp(mm_id, 1, 1);
 	} else {
 		do {
-			CATCH_EINTR(n = waitpid(pid, &status,
+			CATCH_EINTR(n = waitpid(mm_id->pid, &status,
 						WUNTRACED | __WALL));
 			if (n < 0) {
 				err = -errno;
@@ -466,7 +517,7 @@ int start_userspace(struct mm_id *mm_id)
 			goto out_kill;
 		}
 
-		if (ptrace(PTRACE_SETOPTIONS, pid, NULL,
+		if (ptrace(PTRACE_SETOPTIONS, mm_id->pid, NULL,
 			   (void *) PTRACE_O_TRACESYSGOOD) < 0) {
 			err = -errno;
 			printk(UM_KERN_ERR "%s : PTRACE_SETOPTIONS failed, errno = %d\n",
@@ -482,12 +533,22 @@ int start_userspace(struct mm_id *mm_id)
 		goto out_kill;
 	}
 
-	mm_id->pid = pid;
+	close(tramp_data.sockpair[0]);
+	if (using_seccomp)
+		mm_id->sock = tramp_data.sockpair[1];
+	else
+		close(tramp_data.sockpair[1]);
+
+	return 0;
 
-	return pid;
+out_kill:
+	os_kill_ptraced_process(mm_id->pid, 1);
+out_close:
+	close(tramp_data.sockpair[0]);
+	close(tramp_data.sockpair[1]);
+
+	mm_id->pid = -1;
 
- out_kill:
-	os_kill_ptraced_process(pid, 1);
 	return err;
 }
 
@@ -550,17 +611,8 @@ void userspace(struct uml_pt_regs *regs)
 
 			/* Mark pending syscalls for flushing */
 			proc_data->syscall_data_len = mm_id->syscall_data_len;
-			mm_id->syscall_data_len = 0;
 
-			proc_data->signal = 0;
-			proc_data->futex = FUTEX_IN_CHILD;
-			CATCH_EINTR(syscall(__NR_futex, &proc_data->futex,
-					    FUTEX_WAKE, 1, NULL, NULL, 0));
-			do {
-				ret = syscall(__NR_futex, &proc_data->futex,
-					      FUTEX_WAIT, FUTEX_IN_CHILD, NULL, NULL, 0);
-			} while ((ret == -1 && errno == EINTR) ||
-				 proc_data->futex == FUTEX_IN_CHILD);
+			wait_stub_done_seccomp(mm_id, 0, 0);
 
 			sig = proc_data->signal;
 
@@ -568,9 +620,13 @@ void userspace(struct uml_pt_regs *regs)
 				printk(UM_KERN_ERR "%s - Error flushing stub syscalls",
 				       __func__);
 				syscall_stub_dump_error(mm_id);
+				mm_id->syscall_data_len = proc_data->err;
 				fatal_sigsegv();
 			}
 
+			mm_id->syscall_data_len = 0;
+			mm_id->syscall_fd_num = 0;
+
 			ret = get_stub_state(regs, proc_data, NULL);
 			if (ret) {
 				printk(UM_KERN_ERR "%s - failed to get regs: %d",
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index ab202ad430f6..693fb0c27bcf 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -285,6 +285,10 @@ static bool __init init_seccomp(void)
 		};
 		struct sigaction sa;
 
+		/* close_range is needed for the stub */
+		if (stub_syscall3(__NR_close_range, 1, ~0U, 0))
+			exit(1);
+
 		set_sigstack(seccomp_test_stub_data->sigstack,
 			     sizeof(seccomp_test_stub_data->sigstack));
 
@@ -292,17 +296,17 @@ static bool __init init_seccomp(void)
 		sa.sa_sigaction = (void *) sigsys_handler;
 		sa.sa_restorer = NULL;
 		if (sigaction(SIGSYS, &sa, NULL) < 0)
-			exit(1);
+			exit(2);
 
 		prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
 		if (syscall(__NR_seccomp, SECCOMP_SET_MODE_FILTER,
 			    SECCOMP_FILTER_FLAG_TSYNC, &prog) != 0)
-			exit(2);
+			exit(3);
 
 		sleep(0);
 
 		/* Never reached. */
-		exit(3);
+		exit(4);
 	}
 
 	if (pid < 0)
-- 
2.48.1


