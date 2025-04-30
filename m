Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84FCAC3ABA9
	for <linux-um@archiver.kernel.org>; Wed, 30 Apr 2025 16:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qmKl86PDI3OM3HN0o5SkGuRii6uWAa4obdvJwLo/eMI=; b=UPrFR1Su9HIhWsy9vL6bFLS3gz
	urs48OxQs5OdD3SoC2AMqJa38vbE5a3tVIsej4XNY7IoTx74AfrCk47fDzRlVCrY2lFM4flbSoKNN
	Lw1j6qi8ZL449wwn1eRMYTppA6gMey3fJ3i3lruSU1uSHyyXXb6mf6jIe31gSwgCJMaswOwBiAHnY
	8a3RySOEhwaB2qJq6ViLGmg5FqXBQiGsdWYs/QKAr0TWMsPUmE8/bfi8+xuUNHPLV+FPZa3YKjlN9
	OYecvtqitXWt5jlOoE6CKPTV3BZBpMTkyO0/FLE4pMKwnqJ1cz347ZJW3/WwypytQQoPabZ/cAKGR
	EYbfksBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA9zV-0000000DO1e-0iEN;
	Wed, 30 Apr 2025 16:08:57 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA9wu-0000000DNgD-0npx
	for linux-um@lists.infradead.org;
	Wed, 30 Apr 2025 16:06:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=qmKl86PDI3OM3HN0o5SkGuRii6uWAa4obdvJwLo/eMI=;
	t=1746029176; x=1747238776; b=t3a+Y1rx6lEYrgKTcMp0Ee4ZtuLqYSAM4ekgWXU3fkuvh4T
	NttDQ8oGYyO1Ihg0OeEdRpU8rosSgo5CgP2neXkCDhAZUENSSvlhHoAl3uxV07MCE850xFPVrupv/
	ba3SKuWiN+yCCHzwn+Lf2QBhcprVJLiXThGxMVGOGv0NXTJqPCAv9f9oIKz1ODWZBjUodg8yTGmUB
	84HWo1bTWkULkA4QyLJa42c7TxmTyn3a07I2NNuPsyON/DM/5jz5SZlIN5L/ZYu3FhaoIXJnFhjSl
	Ez7AqeY2al1ElnU8QKH+NzfrH8Cll5jVaer66XFpBoGGDdzojxC7g+Jl8NPQtbvw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uA9wo-0000000DxyX-1Qsd;
	Wed, 30 Apr 2025 18:06:10 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
	Johannes Berg <johannes@sipsolutions.net>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 2/8] um: Add stub side of SECCOMP/futex based process handling
Date: Wed, 30 Apr 2025 18:04:07 +0200
Message-ID: <20250430160413.3250227-3-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430160413.3250227-1-benjamin@sipsolutions.net>
References: <20250430160413.3250227-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250430_090616_400505_F436C2F8 
X-CRM114-Status: GOOD (  23.79  )
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

This adds the stub side for the new seccomp process management code. In
this case we do register save/restore through the signal handler
mcontext.

Add special code for handling TLS, which for x86_64 means setting the
FS_BASE/GS_BASE registers while for i386 it means calling the
set_thread_area syscall.

Co-authored-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

---

v1:
- Cleanup futex EINTR/EAGAIN handling

RFCv2:
- Add include guards into new architecture specific header file
---
 arch/um/include/shared/common-offsets.h |  2 +
 arch/um/include/shared/skas/stub-data.h | 14 +++++++
 arch/um/kernel/skas/stub.c              | 53 +++++++++++++++++++++++++
 arch/x86/um/shared/sysdep/stub-data.h   | 23 +++++++++++
 arch/x86/um/shared/sysdep/stub.h        |  2 +
 arch/x86/um/shared/sysdep/stub_32.h     | 13 ++++++
 arch/x86/um/shared/sysdep/stub_64.h     | 17 ++++++++
 7 files changed, 124 insertions(+)
 create mode 100644 arch/x86/um/shared/sysdep/stub-data.h

diff --git a/arch/um/include/shared/common-offsets.h b/arch/um/include/shared/common-offsets.h
index 73f3a4792ed8..93e7097a2922 100644
--- a/arch/um/include/shared/common-offsets.h
+++ b/arch/um/include/shared/common-offsets.h
@@ -14,3 +14,5 @@ DEFINE(UM_THREAD_SIZE, THREAD_SIZE);
 
 DEFINE(UM_NSEC_PER_SEC, NSEC_PER_SEC);
 DEFINE(UM_NSEC_PER_USEC, NSEC_PER_USEC);
+
+DEFINE(UM_KERN_GDT_ENTRY_TLS_ENTRIES, GDT_ENTRY_TLS_ENTRIES);
diff --git a/arch/um/include/shared/skas/stub-data.h b/arch/um/include/shared/skas/stub-data.h
index 81a4cace032c..81ac2cd12112 100644
--- a/arch/um/include/shared/skas/stub-data.h
+++ b/arch/um/include/shared/skas/stub-data.h
@@ -11,6 +11,10 @@
 #include <linux/compiler_types.h>
 #include <as-layout.h>
 #include <sysdep/tls.h>
+#include <sysdep/stub-data.h>
+
+#define FUTEX_IN_CHILD 0
+#define FUTEX_IN_KERN 1
 
 struct stub_init_data {
 	unsigned long stub_start;
@@ -52,6 +56,16 @@ struct stub_data {
 	/* 128 leaves enough room for additional fields in the struct */
 	struct stub_syscall syscall_data[(UM_KERN_PAGE_SIZE - 128) / sizeof(struct stub_syscall)] __aligned(16);
 
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
diff --git a/arch/um/kernel/skas/stub.c b/arch/um/kernel/skas/stub.c
index 796fc266d3bb..ec644cd82bbe 100644
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
 	int i;
@@ -57,3 +62,51 @@ stub_syscall_handler(void)
 
 	trap_myself();
 }
+
+#ifdef CONFIG_UML_SECCOMP
+void __section(".__syscall_stub")
+stub_signal_interrupt(int sig, siginfo_t *info, void *p)
+{
+	struct stub_data *d = get_stub_data();
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
+		stub_syscall1(__NR_exit_group, 1);
+
+	/* Try running queued syscalls. */
+	if (syscall_handler(d) < 0 || d->restart_wait) {
+		/* Report SIGSYS if we restart. */
+		d->signal = SIGSYS;
+		d->restart_wait = 0;
+		goto restart_wait;
+	}
+
+	/* Restore arch dependent state that is not part of the mcontext */
+	stub_seccomp_restore_state(&d->arch_data);
+
+	/* Return so that the host modified mcontext is restored. */
+}
+
+void __section(".__syscall_stub")
+stub_signal_restorer(void)
+{
+	/* We must not have anything on the stack when doing rt_sigreturn */
+	stub_syscall0(__NR_rt_sigreturn);
+}
+#endif
diff --git a/arch/x86/um/shared/sysdep/stub-data.h b/arch/x86/um/shared/sysdep/stub-data.h
new file mode 100644
index 000000000000..82b1b7f8ac3d
--- /dev/null
+++ b/arch/x86/um/shared/sysdep/stub-data.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ARCH_STUB_DATA_H
+#define __ARCH_STUB_DATA_H
+
+#ifdef __i386__
+#include <generated/asm-offsets.h>
+#include <asm/ldt.h>
+
+struct stub_data_arch {
+	int sync;
+	struct user_desc tls[UM_KERN_GDT_ENTRY_TLS_ENTRIES];
+};
+#else
+#define STUB_SYNC_FS_BASE (1 << 0)
+#define STUB_SYNC_GS_BASE (1 << 1)
+struct stub_data_arch {
+	int sync;
+	unsigned long fs_base;
+	unsigned long gs_base;
+};
+#endif
+
+#endif /* __ARCH_STUB_DATA_H */
diff --git a/arch/x86/um/shared/sysdep/stub.h b/arch/x86/um/shared/sysdep/stub.h
index dc89f4423454..4fa58f5b4fca 100644
--- a/arch/x86/um/shared/sysdep/stub.h
+++ b/arch/x86/um/shared/sysdep/stub.h
@@ -13,3 +13,5 @@
 
 extern void stub_segv_handler(int, siginfo_t *, void *);
 extern void stub_syscall_handler(void);
+extern void stub_signal_interrupt(int, siginfo_t *, void *);
+extern void stub_signal_restorer(void);
diff --git a/arch/x86/um/shared/sysdep/stub_32.h b/arch/x86/um/shared/sysdep/stub_32.h
index 390988132c0a..df568fc3ceb4 100644
--- a/arch/x86/um/shared/sysdep/stub_32.h
+++ b/arch/x86/um/shared/sysdep/stub_32.h
@@ -131,4 +131,17 @@ static __always_inline void *get_stub_data(void)
 		"call *%%eax ;"						\
 		:: "i" ((1 + STUB_DATA_PAGES) * UM_KERN_PAGE_SIZE),	\
 		   "i" (&fn))
+
+static __always_inline void
+stub_seccomp_restore_state(struct stub_data_arch *arch)
+{
+	for (int i = 0; i < sizeof(arch->tls) / sizeof(arch->tls[0]); i++) {
+		if (arch->sync & (1 << i))
+			stub_syscall1(__NR_set_thread_area,
+				      (unsigned long) &arch->tls[i]);
+	}
+
+	arch->sync = 0;
+}
+
 #endif
diff --git a/arch/x86/um/shared/sysdep/stub_64.h b/arch/x86/um/shared/sysdep/stub_64.h
index 294affbec742..9cfd31afa769 100644
--- a/arch/x86/um/shared/sysdep/stub_64.h
+++ b/arch/x86/um/shared/sysdep/stub_64.h
@@ -10,6 +10,7 @@
 #include <sysdep/ptrace_user.h>
 #include <generated/asm-offsets.h>
 #include <linux/stddef.h>
+#include <asm/prctl.h>
 
 #define STUB_MMAP_NR __NR_mmap
 #define MMAP_OFFSET(o) (o)
@@ -134,4 +135,20 @@ static __always_inline void *get_stub_data(void)
 		"call *%%rax ;"						\
 		:: "i" ((1 + STUB_DATA_PAGES) * UM_KERN_PAGE_SIZE),	\
 		   "i" (&fn))
+
+static __always_inline void
+stub_seccomp_restore_state(struct stub_data_arch *arch)
+{
+	/*
+	 * We could use _writefsbase_u64/_writegsbase_u64 if the host reports
+	 * support in the hwcaps (HWCAP2_FSGSBASE).
+	 */
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
2.49.0


