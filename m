Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B22AC433FE
	for <linux-um@archiver.kernel.org>; Tue, 22 Nov 2022 10:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=F1Sy3dXVydh6odnGLgWHWgFtXyh3+3bRKGM89jXFOw4=; b=gQ3dZa+t9+8D58
	+mfHtOHTCYc3b93VxqjQSaZucyfesfWYREcKPfNkdrAgc73hIML21ho5kcUiSFeM10IrwMT7yLO4F
	+GER70yGtpOlYPRLozldIHKNgfnlcFXeqUCGwzj6bIggdzFOjZzRNrTIN+nfpiri0FvoGTE5JjCYK
	puz3PY9k6sNnyhqyDHZA16WD2bYbuNGfHGgmSnLKVBB/lQ2kW+gpULChtF49lIDesVEEtt8IUehDj
	GQzIixD3n10KAYkRXkPw19qn5quu81j4ReI+9cpQwmIUyHr58pshps29w+D3YcST2cvJ2y3NtaIW7
	u2Nn5Z+RfrK+Ec+aArFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQFV-007gAh-NN; Tue, 22 Nov 2022 10:11:29 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQF3-007fef-1Q
	for linux-um@lists.infradead.org; Tue, 22 Nov 2022 10:11:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=wBUw3g+BEgREJ50tuzbsm0z1YB8OYVuRBcANh0RJiVs=;
	t=1669111860; x=1670321460; b=TAi5iXb63LkTUUeLg8rxP5f2ojHEtynpstA2ps9z7fr0W10
	mbyMzPCCcG8DdrwwgWQ1q9xxZmEI1HowU4R3BiDRBxxuCixUVZwe4f4SRjOtqMYQW2McFEVcE2+iS
	9jyfRqzo2ACDvwGuVNY6WlnhFFrII3ZX+CVpxWP0/apMI1nBpemIseW3QyhWOaJYvbhIlBn8na11h
	pxdLGJEZLu2XBdsUR05nIAvKLpYNSx9xd9/ry8yBzMs0SDyib9UtjCYTl2FYDjraf/hqrlVTGa5hC
	dHw2ZVM3qAREJPOgCrPp1cOWzpnEr/0ak5JZIHC7HRPNSUGlWqf0uG5dbPn0zwUA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1oxQEt-006IGn-1y;
	Tue, 22 Nov 2022 11:10:51 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2 23/28] um: Add stub side of SECCOMP/futex based process handling
Date: Tue, 22 Nov 2022 11:07:54 +0100
Message-Id: <20221122100759.208290-24-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122100759.208290-1-benjamin@sipsolutions.net>
References: <20221122100759.208290-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_021101_393511_3C494A88 
X-CRM114-Status: GOOD (  21.63  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Benjamin Berg <benjamin@sipsolutions.net>

This adds the stub side for the new seccomp process management code. In
this case we do register save/restore through the signal handler
mcontext. For the FS_BASE/GS_BASE register we need special handling.

Co-authored-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/include/shared/skas/stub-data.h | 15 +++++++
 arch/um/kernel/skas/clone.c             | 24 +++++++++++
 arch/um/kernel/skas/stub.c              | 54 +++++++++++++++++++++++++
 arch/x86/um/shared/sysdep/stub-data.h   | 12 ++++++
 arch/x86/um/shared/sysdep/stub.h        |  3 ++
 arch/x86/um/shared/sysdep/stub_32.h     |  7 ++++
 arch/x86/um/shared/sysdep/stub_64.h     | 14 +++++++
 7 files changed, 129 insertions(+)
 create mode 100644 arch/x86/um/shared/sysdep/stub-data.h

diff --git a/arch/um/include/shared/skas/stub-data.h b/arch/um/include/shared/skas/stub-data.h
index 821c1e98c051..6a6bc34f70c4 100644
--- a/arch/um/include/shared/skas/stub-data.h
+++ b/arch/um/include/shared/skas/stub-data.h
@@ -8,8 +8,13 @@
 #ifndef __STUB_DATA_H
 #define __STUB_DATA_H
 
+#include <linux/kconfig.h>
 #include <linux/compiler_types.h>
 #include <as-layout.h>
+#include <sysdep/stub-data.h>
+
+#define FUTEX_IN_CHILD 0
+#define FUTEX_IN_KERN 1
 
 #define STUB_NEXT_SYSCALL(s) \
 	((struct stub_syscall *) (((unsigned long) s) + (s)->cmd_len))
@@ -31,6 +36,16 @@ struct stub_data {
 	/* 128 leaves enough room for additional fields in the struct */
 	unsigned char syscall_data[UM_KERN_PAGE_SIZE - 128] __aligned(16);
 
+	/* data shared with signal handler (only used in seccomp mode) */
+	short restart_wait;
+	unsigned int futex;
+	int signal;
+	unsigned short si_offset;
+	unsigned short mctx_offset;
+
+	/* seccomp architecture specific state restore */
+	struct stub_data_arch arch_data;
+
 	/* Stack for our signal handlers and for calling into . */
 	unsigned char sigstack[UM_KERN_PAGE_SIZE] __aligned(UM_KERN_PAGE_SIZE);
 };
diff --git a/arch/um/kernel/skas/clone.c b/arch/um/kernel/skas/clone.c
index 8b6ea9c00133..97728b7dd54d 100644
--- a/arch/um/kernel/skas/clone.c
+++ b/arch/um/kernel/skas/clone.c
@@ -48,3 +48,27 @@ stub_clone_handler(void)
  done:
 	trap_myself();
 }
+
+#ifdef CONFIG_UML_SECCOMP
+void __attribute__ ((__section__ (".__syscall_stub")))
+stub_clone_handler_seccomp(void)
+{
+	struct stub_data *data = get_stub_page() + UM_KERN_PAGE_SIZE;
+	long err;
+
+	/* Use the syscall data as a temporary stack area (bottom half for clone). */
+	err = stub_syscall2(__NR_clone, CLONE_PARENT | CLONE_FILES | SIGCHLD,
+			    (unsigned long) data->syscall_data +
+					    sizeof(data->syscall_data) / 2 -
+					    sizeof(void *));
+	if (err) {
+		data->err = err;
+		goto done;
+	}
+
+	remap_stack_and_trap();
+
+ done:
+	trap_myself();
+}
+#endif
diff --git a/arch/um/kernel/skas/stub.c b/arch/um/kernel/skas/stub.c
index 0a13f5d21d08..4bb90395a12b 100644
--- a/arch/um/kernel/skas/stub.c
+++ b/arch/um/kernel/skas/stub.c
@@ -5,6 +5,11 @@
 
 #include <sysdep/stub.h>
 
+#ifdef CONFIG_UML_SECCOMP
+#include <linux/futex.h>
+#include <errno.h>
+#endif
+
 static __always_inline int syscall_handler(struct stub_data *d)
 {
 	struct stub_syscall *sc;
@@ -45,3 +50,52 @@ stub_syscall_handler(void)
 
 	trap_myself();
 }
+
+#ifdef CONFIG_UML_SECCOMP
+void __attribute__ ((__section__ (".__syscall_stub")))
+stub_signal_interrupt(int sig, siginfo_t *info, void *p)
+{
+	struct stub_data *d = get_stub_page();
+	ucontext_t *uc = p;
+	long res;
+
+	d->signal = sig;
+	d->si_offset = (unsigned long)info - (unsigned long)&d->sigstack[0];
+	d->mctx_offset = (unsigned long)&uc->uc_mcontext - (unsigned long)&d->sigstack[0];
+
+restart_wait:
+	d->futex = FUTEX_IN_KERN;
+	do {
+		res = stub_syscall3(__NR_futex, (unsigned long)&d->futex,
+				    FUTEX_WAKE, 1);
+	} while (res == -EINTR);
+	do {
+		res = stub_syscall4(__NR_futex, (unsigned long)&d->futex,
+				    FUTEX_WAIT, FUTEX_IN_KERN, 0);
+	} while (res == -EINTR || d->futex == FUTEX_IN_KERN);
+
+	if (res < 0 && res != -EAGAIN)
+		stub_syscall2(__NR_kill, 0, SIGKILL);
+
+	/* Try running queued syscalls. */
+	if (syscall_handler(d) < 0 || d->restart_wait) {
+		/* Report SIGTRAP if we restart. */
+		d->signal = SIGTRAP;
+		d->restart_wait = 0;
+		goto restart_wait;
+	}
+
+	/* Return so that the host modified mcontext is restored. */
+}
+
+void __attribute__ ((__section__ (".__syscall_stub")))
+stub_signal_restorer(void)
+{
+	struct stub_data *d = get_stub_page();
+
+	/* Restore arch dependent state that is not part of the mcontext */
+	stub_seccomp_restore_state(&d->arch_data);
+
+	stub_syscall0(__NR_rt_sigreturn);
+}
+#endif
diff --git a/arch/x86/um/shared/sysdep/stub-data.h b/arch/x86/um/shared/sysdep/stub-data.h
new file mode 100644
index 000000000000..b0b6f2a95f0e
--- /dev/null
+++ b/arch/x86/um/shared/sysdep/stub-data.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifdef __i386__
+struct stub_data_arch { };
+#else
+#define STUB_SYNC_FS_BASE (1 << 0)
+#define STUB_SYNC_GS_BASE (1 << 1)
+struct stub_data_arch {
+	int sync;
+	unsigned long fs_base;
+	unsigned long gs_base;
+};
+#endif
diff --git a/arch/x86/um/shared/sysdep/stub.h b/arch/x86/um/shared/sysdep/stub.h
index 579681d12158..eb2e3a24d40b 100644
--- a/arch/x86/um/shared/sysdep/stub.h
+++ b/arch/x86/um/shared/sysdep/stub.h
@@ -14,3 +14,6 @@
 extern void stub_segv_handler(int, siginfo_t *, void *);
 extern void stub_syscall_handler(void);
 extern void stub_clone_handler(void);
+extern void stub_signal_interrupt(int, siginfo_t *, void *);
+extern void stub_signal_restorer(void);
+extern void stub_clone_handler_seccomp(void);
diff --git a/arch/x86/um/shared/sysdep/stub_32.h b/arch/x86/um/shared/sysdep/stub_32.h
index 9531e52b0a3e..c8328a1949ee 100644
--- a/arch/x86/um/shared/sysdep/stub_32.h
+++ b/arch/x86/um/shared/sysdep/stub_32.h
@@ -144,4 +144,11 @@ static __always_inline void *get_stub_page(void)
 
 	return (void *)ret;
 }
+
+static __always_inline void
+stub_seccomp_restore_state(struct stub_data_arch *arch)
+{
+	/* No extra arch specific restore */
+}
+
 #endif
diff --git a/arch/x86/um/shared/sysdep/stub_64.h b/arch/x86/um/shared/sysdep/stub_64.h
index bd2f62530bcc..99c5e54654a7 100644
--- a/arch/x86/um/shared/sysdep/stub_64.h
+++ b/arch/x86/um/shared/sysdep/stub_64.h
@@ -10,6 +10,7 @@
 #include <sysdep/ptrace_user.h>
 #include <generated/asm-offsets.h>
 #include <linux/stddef.h>
+#include <asm/prctl.h>
 
 #define STUB_MMAP_NR __NR_mmap
 #define MMAP_OFFSET(o) (o)
@@ -140,4 +141,17 @@ static __always_inline void *get_stub_page(void)
 
 	return (void *)ret - UM_KERN_PAGE_SIZE;
 }
+
+static __always_inline void
+stub_seccomp_restore_state(struct stub_data_arch *arch)
+{
+	/* TODO: Use _writefsbase_u64/_writegsbase_u64 when possible */
+	if (arch->sync & STUB_SYNC_FS_BASE)
+		stub_syscall2(__NR_arch_prctl, ARCH_SET_FS, arch->fs_base);
+	if (arch->sync & STUB_SYNC_GS_BASE)
+		stub_syscall2(__NR_arch_prctl, ARCH_SET_GS, arch->gs_base);
+
+	arch->sync = 0;
+}
+
 #endif
-- 
2.38.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
