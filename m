Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDEEAC43458
	for <linux-um@archiver.kernel.org>; Fri, 10 Jul 2026 20:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n7rWVvgV3uvDQnachgCKO9gIdalZXrgrsCv3l41RcBw=; b=HOMgmS1gyR7TTcwTzY/GCXC2LU
	SSS/wK3lbCdz4vLOZgS23K4ZXBZLtum8micdQ4h6PrDbnAAf2daV8GubwhdLGXrGyH8yiGKF8p3AP
	/mXxmGun0dAM7zDf0nP2/OgxvXZkowu5tXzCW8lNPUDp/7k2zOBjphwBET+He6yakHQNUUQQl6hQM
	lz9DFz2QAAD7M6SwU4GhArhLZYxYnGvU38REZx3Okb0umxjfV7DfhyVN3ZcCf9sjaK1mYhd6KsDWx
	Rikcphzw9+3ex75yQorSHkoSDfwNCqnIBqqXS0F/wZa7PC9katgZ3u/wiGoa+Df2fpVaFNDXX2IGc
	IFzCzDzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiIEY-00000005jkP-2TPM;
	Fri, 10 Jul 2026 20:54:06 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiIEV-00000005jhe-3gJB
	for linux-um@lists.infradead.org;
	Fri, 10 Jul 2026 20:54:05 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2cad4170e8eso15638535ad.3
        for <linux-um@lists.infradead.org>; Fri, 10 Jul 2026 13:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783716843; x=1784321643; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n7rWVvgV3uvDQnachgCKO9gIdalZXrgrsCv3l41RcBw=;
        b=D8NhoPpnIhpkKIL1P9vqxx1GkS+7vLvidwNsuWkODH7Noy5LtBVPGKZaYBJTS4xRh2
         amf8COmEKpL5QfPYUE6/9OvNGdH7+ukZJ/D46pPnnuyvC+5mK1L2i5gZOzqT+qm9appz
         tP+uZctvCvG7v3xhL6hTZ4cFoylaTANB5SGjwaDNO9EtR9KqUFf3hazdTcfPqs2wpXO+
         CIl8lxPXuBcEPcHM+R06/LRj0mMFErRtzAFpu88ip3TZ7F8G8g1c2N/vzk0AcYhgmsEh
         0wFu+WpvYI9LD1H4NwN/LpgBAKpEMvZ3RqsM/FJjury5e1mXjW0cvS310mhTL0PWAA3E
         3WnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783716843; x=1784321643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n7rWVvgV3uvDQnachgCKO9gIdalZXrgrsCv3l41RcBw=;
        b=QoGXyhO392KjBrgml1j28fCQ1vTeoN9CL7b1lElrZ1YqU5wfRW8E4hlcqrokM11fze
         jEuZ7Q74vG0IlQGhRP2ZOw4KIozB8pTBLgPac4Z7kcJQqh3dIxvbHDtgzdKCabyDVSzi
         iOFp2VfWzRMAzkBXX87Q5Ot4Fst6peId7Cg7sd9EPbolzfjlNhLlSHMHA1iqLUQd+8MQ
         Hb71P69TivOLsqvHOh/p0M+tMkSDy/Rf9HxbW4PIMwFRXsRW5EXCLNwnwruC+eW5AtK2
         XbRCazWcFFAEXp30PH3hhuzCA6ADRKbeTwR8YxOLqZssBssKB60w0EVAXukmXJN5atr5
         4BcA==
X-Forwarded-Encrypted: i=1; AHgh+RqY0Bkq6LV9AJ42JKEqJ5oXLPqcpV56GhDD9s97yjrCX4QnbH/2VwjtC54K1hiQg9WPve1nAfGwnA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzWBqdXbL/71qcCafDPLj8EZLOKf0kh2BPMo4rIZLajMphpR81Q
	8WvvYYkLGNBqDGdS8B0eHfBCrgOBtdeG5rLkvt5bSNKHCiMwoPOn5FZy
X-Gm-Gg: AfdE7ck+hzZNWdSNIJE05OZXAGvA/8jWBB5PXeDtIbyuVcgVsuEam5rdqVcs/0l7Pb1
	FxHDBi5Ziv/b8LtmBRhMLYdrUacZVBT046fw7WtcoP3l4aCwGVnvoQQlPslkdSolrioiPPZU7DK
	32aze9vvHj8ajaazfjUZXViDtfJB4JIMSEnm3bo4eotdhcjx/vnL+e8SQztJqA1KtOOWxuCQDvx
	Vj1JSyG8L+0SZ26fBYrAH4rW3rZO6QRjr3wMxF6iMxFPtnVF/QtkoM+yTJ1WUzMn3lhRh7YIAhn
	UopKrHuVfgREQ1lQIOEkCszRvfspftlqs6/eDyp6fmjZJ6OjxdFLkncDjkkyV6gx/cG6/JnFYKT
	6XvQFY3D4FSUAGtiXSufJhVhWK2Gk1RQOVTs5QgwE1/t4QyhkHYuZwpNqM2ZRjXkfAGWlBlgQMb
	TBywF+SuPU7y3/cWVM/1gzZk94baX9s0Tk5CzY/MnvJLLQrLBeAtsgTq0=
X-Received: by 2002:a05:6a20:a109:b0:3c0:9c18:d5a6 with SMTP id adf61e73a8af0-3c1110784f4mr529762637.67.1783716842812;
        Fri, 10 Jul 2026 13:54:02 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3119c2a7bb5sm21724371eec.25.2026.07.10.13.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 13:54:02 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Cong Wang <cwang@multikernel.io>
Subject: [RFC PATCH 5/6] um: install guest mappings via pidfd_mmap() in both modes
Date: Fri, 10 Jul 2026 13:53:23 -0700
Message-ID: <20260710205324.1343217-6-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205324.1343217-1-xiyou.wangcong@gmail.com>
References: <20260710205324.1343217-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260710_135403_960389_B190AC41 
X-CRM114-Status: GOOD (  34.84  )
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

From: Cong Wang <cwang@multikernel.io>

Route both seccomp and ptrace (SKAS0) map()/unmap() through
pidfd_mmap()/pidfd_munmap(): the monitor resolves the physmem fd in its
own fd table and installs the mapping into the stub's mm directly, so the
stub never executes mmap/munmap itself in either mode.

Neither mode drives the stub to execute syscalls anymore, so the whole
stub-syscall batcher and the seccomp-only SCM_RIGHTS fd-passing become
dead code and are removed. The seccomp model's inherent risks are not
addressed by pidfd_mmap() (a malicious guest can still block SIGALRM to
dodge scheduling), so that note is preserved in stub.c.

This is an RFC demonstration of pidfd_mmap()'s reach; it assumes a host
kernel that provides the syscall and does not add a fallback for older
hosts intentionally.

Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 arch/um/include/shared/os.h             |   4 -
 arch/um/include/shared/skas/mm_id.h     |   7 -
 arch/um/include/shared/skas/stub-data.h |  28 ---
 arch/um/kernel/skas/mmu.c               |   5 -
 arch/um/kernel/skas/stub.c              | 151 ++----------
 arch/um/kernel/skas/stub_exe.c          |  16 +-
 arch/um/os-Linux/skas/mem.c             | 295 ++----------------------
 arch/um/os-Linux/skas/process.c         |  86 +------
 arch/um/os-Linux/start_up.c             |   8 +-
 9 files changed, 67 insertions(+), 533 deletions(-)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index b26e94292fc1..c6917583ca64 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -280,10 +280,6 @@ extern long long os_persistent_clock_emulation(void);
 extern long long os_nsecs(void);
 
 /* skas/mem.c */
-int syscall_stub_flush(struct mm_id *mm_idp);
-struct stub_syscall *syscall_stub_alloc(struct mm_id *mm_idp);
-void syscall_stub_dump_error(struct mm_id *mm_idp);
-
 int map(struct mm_id *mm_idp, unsigned long virt,
 	unsigned long len, int prot, int phys_fd,
 	unsigned long long offset);
diff --git a/arch/um/include/shared/skas/mm_id.h b/arch/um/include/shared/skas/mm_id.h
index cec97189f12b..0f74e1728a1e 100644
--- a/arch/um/include/shared/skas/mm_id.h
+++ b/arch/um/include/shared/skas/mm_id.h
@@ -8,18 +8,11 @@
 
 #include <linux/compiler_types.h>
 
-#define STUB_MAX_FDS 4
-
 struct mm_id {
 	int pid;
 	unsigned long stack;
-	int syscall_data_len;
 
-	/* Only used with SECCOMP mode */
 	int stub_pidfd;		/* pidfd to the stub, or -1 */
-	int sock;
-	int syscall_fd_num;
-	int syscall_fd_map[STUB_MAX_FDS];
 };
 
 struct mutex *__get_turnstile(struct mm_id *mm_id);
diff --git a/arch/um/include/shared/skas/stub-data.h b/arch/um/include/shared/skas/stub-data.h
index 27db38e95df9..eaa208bcdaff 100644
--- a/arch/um/include/shared/skas/stub-data.h
+++ b/arch/um/include/shared/skas/stub-data.h
@@ -31,36 +31,8 @@ struct stub_init_data {
 	unsigned long signal_restorer;
 };
 
-#define STUB_NEXT_SYSCALL(s) \
-	((struct stub_syscall *) (((unsigned long) s) + (s)->cmd_len))
-
-enum stub_syscall_type {
-	STUB_SYSCALL_UNSET = 0,
-	STUB_SYSCALL_MMAP,
-	STUB_SYSCALL_MUNMAP,
-};
-
-struct stub_syscall {
-	struct {
-		unsigned long addr;
-		unsigned long length;
-		unsigned long offset;
-		int fd;
-		int prot;
-	} mem;
-
-	enum stub_syscall_type syscall;
-};
-
 struct stub_data {
-	long err;
-
-	int syscall_data_len;
-	/* 128 leaves enough room for additional fields in the struct */
-	struct stub_syscall syscall_data[(UM_KERN_PAGE_SIZE - 128) / sizeof(struct stub_syscall)] __aligned(16);
-
 	/* data shared with signal handler (only used in seccomp mode) */
-	short restart_wait;
 	unsigned int futex;
 	int signal;
 	unsigned short si_offset;
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index 441dcf94ec9c..b2c9cf023789 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -55,8 +55,6 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 
 	new_id->stack = stack;
 	new_id->stub_pidfd = -1;
-	new_id->syscall_data_len = 0;
-	new_id->syscall_fd_num = 0;
 
 	scoped_guard(spinlock_irqsave, &mm_list_lock) {
 		/* Insert into list, used for lookups when the child dies */
@@ -109,9 +107,6 @@ void destroy_context(struct mm_struct *mm)
 		mmu->id.stub_pidfd = -1;
 	}
 
-	if (using_seccomp && mmu->id.sock)
-		os_close_file(mmu->id.sock);
-
 	free_pages(mmu->id.stack, ilog2(STUB_DATA_PAGES));
 }
 
diff --git a/arch/um/kernel/skas/stub.c b/arch/um/kernel/skas/stub.c
index e09216a20cb5..08443f2eb09d 100644
--- a/arch/um/kernel/skas/stub.c
+++ b/arch/um/kernel/skas/stub.c
@@ -6,119 +6,46 @@
 #include <sysdep/stub.h>
 
 #include <linux/futex.h>
-#include <sys/socket.h>
 #include <errno.h>
 
 /*
- * Known security issues
+ * Known security issues (SECCOMP userspace)
  *
- * Userspace can jump to this address to execute *any* syscall that is
- * permitted by the stub. As we will return afterwards, it can do
- * whatever it likes, including:
- * - Tricking the kernel into handing out the memory FD
- * - Using this memory FD to read/write all physical memory
- * - Running in parallel to the kernel processing a syscall
- *   (possibly creating data races?)
- * - Blocking e.g. SIGALRM to avoid time based scheduling
+ * The stub shares its address space with the untrusted guest application.
+ * Installing guest mappings via pidfd_mmap() closed some earlier holes --
+ * the stub no longer holds the physmem fd and no longer executes mmap/munmap
+ * on the guest's behalf (both are rejected by the SECCOMP filter) -- but the
+ * following are inherent to the model and remain unaddressed:
  *
- * To avoid this, the permitted location for each syscall needs to be
- * checked for in the SECCOMP filter (which is reasonably simple). Also,
- * more care will need to go into considerations how the code might be
- * tricked by using a prepared stack (or even modifying the stack from
- * another thread in case SMP support is added).
- *
- * As for the SIGALRM, the best counter measure will be to check in the
- * kernel that the process is reporting back the SIGALRM in a timely
- * fashion.
+ * - A malicious guest can influence the stub's signal state (e.g. via a
+ *   prepared stack restored on rt_sigreturn) and block SIGALRM to avoid
+ *   time-based scheduling. The intended counter measure is for the monitor
+ *   to check that the process reports SIGALRM back in a timely fashion; that
+ *   is not yet implemented.
+ * - The permitted location of each syscall the stub does issue must be
+ *   pinned down in the SECCOMP filter, and more care is needed around a
+ *   prepared stack (or the stack being modified from another thread should
+ *   SMP support be added).
  */
-static __always_inline int syscall_handler(int fd_map[STUB_MAX_FDS])
-{
-	struct stub_data *d = get_stub_data();
-	int i;
-	unsigned long res;
-	int fd;
-
-	for (i = 0; i < d->syscall_data_len; i++) {
-		struct stub_syscall *sc = &d->syscall_data[i];
-
-		switch (sc->syscall) {
-		case STUB_SYSCALL_MMAP:
-			if (fd_map)
-				fd = fd_map[sc->mem.fd];
-			else
-				fd = sc->mem.fd;
-
-			res = stub_syscall6(STUB_MMAP_NR,
-					    sc->mem.addr, sc->mem.length,
-					    sc->mem.prot,
-					    MAP_SHARED | MAP_FIXED,
-					    fd, sc->mem.offset);
-			if (res != sc->mem.addr) {
-				d->err = res;
-				d->syscall_data_len = i;
-				return -1;
-			}
-			break;
-		case STUB_SYSCALL_MUNMAP:
-			res = stub_syscall2(__NR_munmap,
-					    sc->mem.addr, sc->mem.length);
-			if (res) {
-				d->err = res;
-				d->syscall_data_len = i;
-				return -1;
-			}
-			break;
-		default:
-			d->err = -95; /* EOPNOTSUPP */
-			d->syscall_data_len = i;
-			return -1;
-		}
-	}
-
-	d->err = 0;
-	d->syscall_data_len = 0;
-
-	return 0;
-}
-
-void __section(".__syscall_stub")
-stub_syscall_handler(void)
-{
-	syscall_handler(NULL);
-
-	trap_myself();
-}
 
 void __section(".__syscall_stub")
 stub_signal_interrupt(int sig, siginfo_t *info, void *p)
 {
 	struct stub_data *d = get_stub_data();
-	char rcv_data;
-	union {
-		char data[CMSG_SPACE(sizeof(int) * STUB_MAX_FDS)];
-		struct cmsghdr align;
-	} ctrl = {};
-	struct iovec iov = {
-		.iov_base = &rcv_data,
-		.iov_len = 1,
-	};
-	struct msghdr msghdr = {
-		.msg_iov = &iov,
-		.msg_iovlen = 1,
-		.msg_control = &ctrl,
-		.msg_controllen = sizeof(ctrl),
-	};
 	ucontext_t *uc = p;
-	struct cmsghdr *fd_msg;
-	int *fd_map;
-	int num_fds;
 	long res;
 
 	d->signal = sig;
 	d->si_offset = (unsigned long)info - (unsigned long)&d->sigstack[0];
 	d->mctx_offset = (unsigned long)&uc->uc_mcontext - (unsigned long)&d->sigstack[0];
 
-restart_wait:
+	/*
+	 * Hand the guest trap to the monitor and block until it resumes us:
+	 * wake the monitor (FUTEX_WAKE) and FUTEX_WAIT until it is done. In
+	 * seccomp mode the monitor installs any address-space changes itself
+	 * via pidfd_mmap(), so the stub no longer executes syscalls on its
+	 * behalf and never receives an fd.
+	 */
 	d->futex = FUTEX_IN_KERN;
 	do {
 		res = stub_syscall3(__NR_futex, (unsigned long)&d->futex,
@@ -133,40 +60,6 @@ stub_signal_interrupt(int sig, siginfo_t *info, void *p)
 	if (res < 0 && res != -EAGAIN)
 		stub_syscall1(__NR_exit_group, 1);
 
-	if (d->syscall_data_len) {
-		/* Read passed FDs (if any) */
-		do {
-			res = stub_syscall3(__NR_recvmsg, 0, (unsigned long)&msghdr, 0);
-		} while (res == -EINTR);
-
-		/* We should never have a receive error (other than -EAGAIN) */
-		if (res < 0 && res != -EAGAIN)
-			stub_syscall1(__NR_exit_group, 1);
-
-		/* Receive the FDs */
-		num_fds = 0;
-		fd_msg = msghdr.msg_control;
-		fd_map = (void *)CMSG_DATA(fd_msg);
-		if (res == iov.iov_len && msghdr.msg_controllen > sizeof(struct cmsghdr))
-			num_fds = (fd_msg->cmsg_len - CMSG_LEN(0)) / sizeof(int);
-
-		/* Try running queued syscalls. */
-		res = syscall_handler(fd_map);
-
-		while (num_fds)
-			stub_syscall2(__NR_close, fd_map[--num_fds], 0);
-	} else {
-		res = 0;
-	}
-
-	if (res < 0 || d->restart_wait) {
-		/* Report SIGSYS if we restart. */
-		d->signal = SIGSYS;
-		d->restart_wait = 0;
-
-		goto restart_wait;
-	}
-
 	/* Restore arch dependent state that is not part of the mcontext */
 	stub_seccomp_restore_state(&d->arch_data);
 
diff --git a/arch/um/kernel/skas/stub_exe.c b/arch/um/kernel/skas/stub_exe.c
index a88274449168..af1d011be0a4 100644
--- a/arch/um/kernel/skas/stub_exe.c
+++ b/arch/um/kernel/skas/stub_exe.c
@@ -166,15 +166,13 @@ noinline static void real_init(void)
 				 offsetof(struct seccomp_data, nr)),
 
 			/*
-			 * [10-14] Check against permitted syscalls. mmap and
-			 * munmap are deliberately absent: in seccomp mode the
-			 * monitor installs all guest mappings via pidfd_mmap(),
-			 * so a stub that attempts mmap/munmap hits the KILL at
-			 * [15].
+			 * [10-13] Check against permitted syscalls. mmap, munmap
+			 * and recvmsg are deliberately absent: in seccomp mode
+			 * the monitor installs all guest mappings via
+			 * pidfd_mmap() and no longer passes fds to the stub, so a
+			 * stub that attempts mmap/munmap hits the KILL at [14].
 			 */
 			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_futex,
-				 5, 0),
-			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_recvmsg,
 				 4, 0),
 			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_close,
 				 3, 0),
@@ -188,10 +186,10 @@ noinline static void real_init(void)
 			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_rt_sigreturn,
 				 1, 0),
 
-			/* [15] Not one of the permitted syscalls */
+			/* [14] Not one of the permitted syscalls */
 			BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_KILL_PROCESS),
 
-			/* [16] Permitted call for the stub */
+			/* [15] Permitted call for the stub */
 			BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW),
 		};
 		struct sock_fprog prog = {
diff --git a/arch/um/os-Linux/skas/mem.c b/arch/um/os-Linux/skas/mem.c
index f751a1ea1c4c..9330f97f8beb 100644
--- a/arch/um/os-Linux/skas/mem.c
+++ b/arch/um/os-Linux/skas/mem.c
@@ -22,287 +22,34 @@
 #include <sysdep/stub.h>
 #include "../internal.h"
 
-extern char __syscall_stub_start[];
-
-void syscall_stub_dump_error(struct mm_id *mm_idp)
-{
-	struct stub_data *proc_data = (void *)mm_idp->stack;
-	struct stub_syscall *sc;
-
-	if (proc_data->syscall_data_len < 0 ||
-	    proc_data->syscall_data_len >= ARRAY_SIZE(proc_data->syscall_data))
-		panic("Syscall data was corrupted by stub (len is: %d, expected maximum: %d)!",
-			proc_data->syscall_data_len,
-			mm_idp->syscall_data_len);
-
-	sc = &proc_data->syscall_data[proc_data->syscall_data_len];
-
-	printk(UM_KERN_ERR "%s : length = %d, last offset = %d",
-		__func__, mm_idp->syscall_data_len,
-		proc_data->syscall_data_len);
-	printk(UM_KERN_ERR "%s : stub syscall type %d failed, return value = 0x%lx\n",
-		__func__, sc->syscall, proc_data->err);
-
-	print_hex_dump(UM_KERN_ERR, "    syscall data: ", 0,
-		       16, 4, sc, sizeof(*sc), 0);
-
-	if (using_seccomp) {
-		printk(UM_KERN_ERR "%s: FD map num: %d", __func__,
-		       mm_idp->syscall_fd_num);
-		print_hex_dump(UM_KERN_ERR,
-				"    FD map: ", 0, 16,
-				sizeof(mm_idp->syscall_fd_map[0]),
-				mm_idp->syscall_fd_map,
-				sizeof(mm_idp->syscall_fd_map), 0);
-	}
-}
-
-static inline unsigned long *check_init_stack(struct mm_id * mm_idp,
-					      unsigned long *stack)
-{
-	if (stack == NULL) {
-		stack = (unsigned long *) mm_idp->stack + 2;
-		*stack = 0;
-	}
-	return stack;
-}
-
-static unsigned long syscall_regs[MAX_REG_NR];
-
-static int __init init_syscall_regs(void)
-{
-	get_safe_registers(syscall_regs, NULL);
-
-	syscall_regs[REGS_IP_INDEX] = STUB_CODE +
-		((unsigned long) stub_syscall_handler -
-		 (unsigned long) __syscall_stub_start);
-	syscall_regs[REGS_SP_INDEX] = STUB_DATA +
-		offsetof(struct stub_data, sigstack) +
-		sizeof(((struct stub_data *) 0)->sigstack) -
-		sizeof(void *);
-
-	return 0;
-}
-
-__initcall(init_syscall_regs);
-
-static inline long do_syscall_stub(struct mm_id *mm_idp)
-{
-	struct stub_data *proc_data = (void *)mm_idp->stack;
-	int n, i;
-	int err, pid = mm_idp->pid;
-
-	/* Inform process how much we have filled in. */
-	proc_data->syscall_data_len = mm_idp->syscall_data_len;
-
-	if (using_seccomp) {
-		proc_data->restart_wait = 1;
-		wait_stub_done_seccomp(mm_idp, 0, 1);
-	} else {
-		n = ptrace_setregs(pid, syscall_regs);
-		if (n < 0) {
-			printk(UM_KERN_ERR "Registers -\n");
-			for (i = 0; i < MAX_REG_NR; i++)
-				printk(UM_KERN_ERR "\t%d\t0x%lx\n", i, syscall_regs[i]);
-			panic("%s : PTRACE_SETREGS failed, errno = %d\n",
-			      __func__, -n);
-		}
-
-		err = ptrace(PTRACE_CONT, pid, 0, 0);
-		if (err)
-			panic("Failed to continue stub, pid = %d, errno = %d\n",
-			      pid, errno);
-
-		wait_stub_done(pid);
-	}
-
-	/*
-	 * proc_data->err will be negative if there was an (unexpected) error.
-	 * In that case, syscall_data_len points to the last executed syscall,
-	 * otherwise it will be zero (but we do not need to rely on that).
-	 */
-	if (proc_data->err < 0) {
-		syscall_stub_dump_error(mm_idp);
-
-		/* Store error code in case someone tries to add more syscalls */
-		mm_idp->syscall_data_len = proc_data->err;
-	} else {
-		mm_idp->syscall_data_len = 0;
-	}
-
-	if (using_seccomp)
-		mm_idp->syscall_fd_num = 0;
-
-	return mm_idp->syscall_data_len;
-}
-
-int syscall_stub_flush(struct mm_id *mm_idp)
-{
-	int res;
-
-	if (mm_idp->syscall_data_len == 0)
-		return 0;
-
-	/* If an error happened already, report it and reset the state. */
-	if (mm_idp->syscall_data_len < 0) {
-		res = mm_idp->syscall_data_len;
-		mm_idp->syscall_data_len = 0;
-		return res;
-	}
-
-	res = do_syscall_stub(mm_idp);
-	mm_idp->syscall_data_len = 0;
-
-	return res;
-}
-
-struct stub_syscall *syscall_stub_alloc(struct mm_id *mm_idp)
-{
-	struct stub_syscall *sc;
-	struct stub_data *proc_data = (struct stub_data *) mm_idp->stack;
-
-	if (mm_idp->syscall_data_len > 0 &&
-	    mm_idp->syscall_data_len == ARRAY_SIZE(proc_data->syscall_data))
-		do_syscall_stub(mm_idp);
-
-	if (mm_idp->syscall_data_len < 0) {
-		/* Return dummy to retain error state. */
-		sc = &proc_data->syscall_data[0];
-	} else {
-		sc = &proc_data->syscall_data[mm_idp->syscall_data_len];
-		mm_idp->syscall_data_len += 1;
-	}
-	memset(sc, 0, sizeof(*sc));
-
-	return sc;
-}
-
-static struct stub_syscall *syscall_stub_get_previous(struct mm_id *mm_idp,
-						      int syscall_type,
-						      unsigned long virt)
-{
-	if (mm_idp->syscall_data_len > 0) {
-		struct stub_data *proc_data = (void *) mm_idp->stack;
-		struct stub_syscall *sc;
-
-		sc = &proc_data->syscall_data[mm_idp->syscall_data_len - 1];
-
-		if (sc->syscall == syscall_type &&
-		    sc->mem.addr + sc->mem.length == virt)
-			return sc;
-	}
-
-	return NULL;
-}
-
-static int get_stub_fd(struct mm_id *mm_idp, int fd)
-{
-	int i;
-
-	/* Find an FD slot (or flush and use first) */
-	if (!using_seccomp)
-		return fd;
-
-	/* Already crashed, value does not matter */
-	if (mm_idp->syscall_data_len < 0)
-		return 0;
-
-	/* Find existing FD in map if we can allocate another syscall */
-	if (mm_idp->syscall_data_len <
-	    ARRAY_SIZE(((struct stub_data *)NULL)->syscall_data)) {
-		for (i = 0; i < mm_idp->syscall_fd_num; i++) {
-			if (mm_idp->syscall_fd_map[i] == fd)
-				return i;
-		}
-
-		if (mm_idp->syscall_fd_num < STUB_MAX_FDS) {
-			i = mm_idp->syscall_fd_num;
-			mm_idp->syscall_fd_map[i] = fd;
-
-			mm_idp->syscall_fd_num++;
-
-			return i;
-		}
-	}
-
-	/* FD map full or no syscall space available, continue after flush */
-	do_syscall_stub(mm_idp);
-	mm_idp->syscall_fd_map[0] = fd;
-	mm_idp->syscall_fd_num = 1;
-
-	return 0;
-}
-
+/*
+ * Install (map) or remove (unmap) a guest mapping in the stub's address space.
+ * Both seccomp and ptrace modes now go through pidfd_mmap()/pidfd_munmap():
+ * the monitor resolves the physmem fd in its own fd table and installs the
+ * mapping into the stub's mm directly, so the stub never has to execute
+ * mmap/munmap itself. This makes the ptrace stub-syscall batcher unnecessary
+ * for memory management and shows the primitive works uniformly across modes.
+ */
 int map(struct mm_id *mm_idp, unsigned long virt, unsigned long len, int prot,
 	int phys_fd, unsigned long long offset)
 {
-	struct stub_syscall *sc;
-
-	if (using_seccomp) {
-		struct pidfd_mmap_args args = {
-			.size	= sizeof(args),
-			.addr	= virt,
-			.len	= len,
-			.prot	= prot,
-			.flags	= MAP_SHARED | MAP_FIXED,
-			.pgoff	= offset >> UM_KERN_PAGE_SHIFT,
-			.fd	= phys_fd,
-		};
-		long res = syscall(__NR_pidfd_mmap, mm_idp->stub_pidfd, &args, 0);
-
-		return res < 0 ? -errno : 0;
-	}
+	struct pidfd_mmap_args args = {
+		.size	= sizeof(args),
+		.addr	= virt,
+		.len	= len,
+		.prot	= prot,
+		.flags	= MAP_SHARED | MAP_FIXED,
+		.pgoff	= offset >> UM_KERN_PAGE_SHIFT,
+		.fd	= phys_fd,
+	};
+	long res = syscall(__NR_pidfd_mmap, mm_idp->stub_pidfd, &args, 0);
 
-	/* Compress with previous syscall if that is possible */
-	sc = syscall_stub_get_previous(mm_idp, STUB_SYSCALL_MMAP, virt);
-	if (sc && sc->mem.prot == prot &&
-	    sc->mem.offset == MMAP_OFFSET(offset - sc->mem.length)) {
-		int prev_fd = sc->mem.fd;
-
-		if (using_seccomp)
-			prev_fd = mm_idp->syscall_fd_map[sc->mem.fd];
-
-		if (phys_fd == prev_fd) {
-			sc->mem.length += len;
-			return 0;
-		}
-	}
-
-	phys_fd = get_stub_fd(mm_idp, phys_fd);
-
-	sc = syscall_stub_alloc(mm_idp);
-	sc->syscall = STUB_SYSCALL_MMAP;
-	sc->mem.addr = virt;
-	sc->mem.length = len;
-	sc->mem.prot = prot;
-	sc->mem.fd = phys_fd;
-	sc->mem.offset = MMAP_OFFSET(offset);
-
-	return 0;
+	return res < 0 ? -errno : 0;
 }
 
 int unmap(struct mm_id *mm_idp, unsigned long addr, unsigned long len)
 {
-	struct stub_syscall *sc;
-
-	if (using_seccomp) {
-		long res = syscall(__NR_pidfd_munmap, mm_idp->stub_pidfd,
-				   addr, len);
-
-		return res < 0 ? -errno : 0;
-	}
-
-	/* Compress with previous syscall if that is possible */
-	sc = syscall_stub_get_previous(mm_idp, STUB_SYSCALL_MUNMAP, addr);
-	if (sc) {
-		sc->mem.length += len;
-		return 0;
-	}
-
-	sc = syscall_stub_alloc(mm_idp);
-	sc->syscall = STUB_SYSCALL_MUNMAP;
-	sc->mem.addr = addr;
-	sc->mem.length = len;
+	long res = syscall(__NR_pidfd_munmap, mm_idp->stub_pidfd, addr, len);
 
-	return 0;
+	return res < 0 ? -errno : 0;
 }
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 3dd97ca7999a..cd6e40451576 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -157,39 +157,7 @@ void wait_stub_done_seccomp(struct mm_id *mm_idp, int running, int wait_sigsys)
 	int ret;
 
 	do {
-		const char byte = 0;
-		struct iovec iov = {
-			.iov_base = (void *)&byte,
-			.iov_len = sizeof(byte),
-		};
-		union {
-			char data[CMSG_SPACE(sizeof(mm_idp->syscall_fd_map))];
-			struct cmsghdr align;
-		} ctrl;
-		struct msghdr msgh = {
-			.msg_iov = &iov,
-			.msg_iovlen = 1,
-		};
-
 		if (!running) {
-			if (mm_idp->syscall_fd_num) {
-				unsigned int fds_size =
-					sizeof(int) * mm_idp->syscall_fd_num;
-				struct cmsghdr *cmsg;
-
-				msgh.msg_control = ctrl.data;
-				msgh.msg_controllen = CMSG_SPACE(fds_size);
-				cmsg = CMSG_FIRSTHDR(&msgh);
-				cmsg->cmsg_level = SOL_SOCKET;
-				cmsg->cmsg_type = SCM_RIGHTS;
-				cmsg->cmsg_len = CMSG_LEN(fds_size);
-				memcpy(CMSG_DATA(cmsg), mm_idp->syscall_fd_map,
-				       fds_size);
-
-				CATCH_EINTR(syscall(__NR_sendmsg, mm_idp->sock,
-						&msgh, 0));
-			}
-
 			data->signal = 0;
 			data->futex = FUTEX_IN_CHILD;
 			CATCH_EINTR(syscall(__NR_futex, &data->futex,
@@ -482,15 +450,13 @@ int start_userspace(struct mm_id *mm_id)
 		proc_data->futex = FUTEX_IN_CHILD;
 
 	/*
-	 * In SECCOMP mode, acquire a pidfd to the stub via CLONE_PIDFD (it is
-	 * returned through the legacy-clone parent_tid argument). The monitor
-	 * installs guest mappings into the stub's mm directly via pidfd_mmap(),
-	 * so the stub itself never needs the mmap capability. The ptrace mode
-	 * does not use it and drives the stub directly.
+	 * Acquire a pidfd to the stub via CLONE_PIDFD (it is returned through
+	 * the legacy-clone parent_tid argument). The monitor installs guest
+	 * mappings into the stub's mm directly via pidfd_mmap() in both seccomp
+	 * and ptrace modes, so it needs the pidfd regardless of mode.
 	 */
 	mm_id->pid = clone(userspace_tramp, (void *) sp,
-		    CLONE_VFORK | CLONE_VM | (using_seccomp ? CLONE_PIDFD : 0) |
-		    SIGCHLD,
+		    CLONE_VFORK | CLONE_VM | CLONE_PIDFD | SIGCHLD,
 		    (void *)&tramp_data, &stub_pidfd);
 	if (mm_id->pid < 0) {
 		err = -errno;
@@ -498,8 +464,7 @@ int start_userspace(struct mm_id *mm_id)
 		       __func__, errno);
 		goto out_close;
 	}
-	if (using_seccomp)
-		mm_id->stub_pidfd = stub_pidfd;
+	mm_id->stub_pidfd = stub_pidfd;
 
 	if (using_seccomp) {
 		wait_stub_done_seccomp(mm_id, 1, 1);
@@ -539,10 +504,7 @@ int start_userspace(struct mm_id *mm_id)
 	}
 
 	close(tramp_data.sockpair[0]);
-	if (using_seccomp)
-		mm_id->sock = tramp_data.sockpair[1];
-	else
-		close(tramp_data.sockpair[1]);
+	close(tramp_data.sockpair[1]);
 
 	return 0;
 
@@ -620,28 +582,15 @@ void userspace(struct uml_pt_regs *regs)
 				fatal_sigsegv();
 			}
 
-			/* Must have been reset by the syscall caller */
-			if (proc_data->restart_wait != 0)
-				panic("Programming error: Flag to only run syscalls in child was not cleared!");
-
-			/* Mark pending syscalls for flushing */
-			proc_data->syscall_data_len = mm_id->syscall_data_len;
-
+			/*
+			 * SECCOMP mode no longer batches stub syscalls (mmap is
+			 * installed by the monitor via pidfd_mmap()); this only
+			 * relays the guest trap to the monitor.
+			 */
 			wait_stub_done_seccomp(mm_id, 0, 0);
 
 			sig = proc_data->signal;
 
-			if (sig == SIGTRAP && proc_data->err != 0) {
-				printk(UM_KERN_ERR "%s - Error flushing stub syscalls",
-				       __func__);
-				syscall_stub_dump_error(mm_id);
-				mm_id->syscall_data_len = proc_data->err;
-				fatal_sigsegv();
-			}
-
-			mm_id->syscall_data_len = 0;
-			mm_id->syscall_fd_num = 0;
-
 			err = get_stub_state(regs, proc_data, NULL);
 			if (err) {
 				printk(UM_KERN_ERR "%s - failed to get regs: %d",
@@ -667,17 +616,6 @@ void userspace(struct uml_pt_regs *regs)
 		} else {
 			int pid = mm_id->pid;
 
-			/* Flush out any pending syscalls */
-			err = syscall_stub_flush(mm_id);
-			if (err) {
-				if (err == -ENOMEM)
-					report_enomem();
-
-				printk(UM_KERN_ERR "%s - Error flushing stub syscalls: %d",
-					__func__, -err);
-				fatal_sigsegv();
-			}
-
 			/*
 			 * This can legitimately fail if the process loads a
 			 * bogus value into a segment register.  It will
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 054ac03bbf5e..518107622a2d 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -311,9 +311,11 @@ static bool __init init_seccomp(void)
 				      PROT_READ | PROT_WRITE,
 				      MAP_SHARED | MAP_ANON, 0, 0);
 
-	/* Use the syscall data area as stack, we just need something */
-	sp = (unsigned long)&seccomp_test_stub_data->syscall_data +
-	     sizeof(seccomp_test_stub_data->syscall_data) -
+	/*
+	 * We just need some valid stack; use the first page of the shared
+	 * stub_data region (sigstack occupies the following page).
+	 */
+	sp = (unsigned long)&seccomp_test_stub_data->sigstack[0] -
 	     sizeof(void *);
 	pid = clone(seccomp_helper, (void *)sp, CLONE_VFORK | CLONE_VM, NULL);
 
-- 
2.43.0


