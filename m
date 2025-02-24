Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C8AC021BF
	for <linux-um@archiver.kernel.org>; Mon, 24 Feb 2025 18:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3t3E/X9R1TV6g8RmvlCjerKXDGlytj+zAXPQbIl2DUI=; b=DaSgOoARw55t8j3cWVXQmtSFHD
	WEFJcGamrRFo4wWzdUvQek12FAU1lG2tf8B4xzXWTR0cIF00W1fYOtaOMpPAg5kzrZq9gErU5Mt0x
	XEhh0EOm5FambXJiere+WXdnx6dc1tZV5ZIjE09EoXlfBveDj3V0gpAcx6hphcBxQ0vbmfHsUa0uc
	PZcqP65Vl4EFDINB21rFEkseMef86K60mky7Ex2Wfg3G069clovVKunjeOb7v7LYK6JFb25kP08W8
	kMIsoBjqPXhsmuGZVFMpK9AZm3tJyInO/VriSSzadkNuie/d0EhazlsX6cnW79lt/X2sTm64hDEbh
	/AAwcuog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmd8R-0000000EnMJ-1dXk;
	Mon, 24 Feb 2025 18:24:55 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmd2u-0000000EmAK-0rxm
	for linux-um@lists.infradead.org;
	Mon, 24 Feb 2025 18:19:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=3t3E/X9R1TV6g8RmvlCjerKXDGlytj+zAXPQbIl2DUI=;
	t=1740421152; x=1741630752; b=Bpk6NiyJEEJvuXe/8n5u3at/jXivZnoCQIvLRSfjGbzLVi3
	IBVsDQi3FfFP1UQhBaJah7KeN3r6CgUjPvTbPmrLOxzvgySfMykYX8rtwjHaE3K4UAGuEFxBmqw37
	scfijWFg+RObrX8xSejcdUlSGB8E9r+xXTHa9396LvGbOAG/UFOqOM9GN7TxfoJOuMzwW2SJ41s7l
	jNLsx85aIV/3AAqZmPaOo98sTYaUttWDugHIT6FnHIMCnkiu/hFtF6BON6KX6NizGlaBEkTMNJi+O
	3wKIZodMVMWbQEl+neCfuW/JFacn7Gz55B/dfj+z3uUIFH6hxQRazIJ+EftFm8Ww==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tmd2m-00000008tWp-3rK3;
	Mon, 24 Feb 2025 19:19:05 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
	Johannes Berg <johannes@sipsolutions.net>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 3/9] um: Add stub side of SECCOMP/futex based process handling
Date: Mon, 24 Feb 2025 19:18:21 +0100
Message-ID: <20250224181827.647129-4-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224181827.647129-1-benjamin@sipsolutions.net>
References: <20250224181827.647129-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_101912_432450_24E5643A 
X-CRM114-Status: GOOD (  23.56  )
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
2.48.1


