Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D90D6CCF9EE
	for <linux-um@archiver.kernel.org>; Wed, 25 Sep 2024 20:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JgugQawXpoEtPKzMySq2yhgptRzDx0f88x+TnPEDkSA=; b=AxzvYOY2DG3Scr4wfAWE/2t3zv
	LDmx0sKA1GVrWkUtMDgtypXs7wJ8SMsZ4eodRs3k2u6U3bU71OAYqXyU+gjcFeH4HdmgMWyaHKo7r
	mCQLBQ1XGiudQUipHPyP1GtiUyfDHxxKkMonnUpr+amtM+WUYE26lJvVrc5FjL6o1MYOR4Zg9DE4w
	592OinwulMWwgaLPBur2Wc79ydx+ezxWphAchFD/Wj8fqoMctKiMcq056aFmv8bLLUP50CiA9Vt9S
	fqgFWAQZqfT+C6RLtX9CIBuv3Y7UXbKLDivXG6LOvzzQuZizEO/cxqKmjQqKSjJ29fHehceWe0SG7
	XsCQ6UWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1stYh3-00000006V3C-2NsW;
	Wed, 25 Sep 2024 20:33:01 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1stYh0-00000006V1p-34kg
	for linux-um@lists.infradead.org;
	Wed, 25 Sep 2024 20:33:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JgugQawXpoEtPKzMySq2yhgptRzDx0f88x+TnPEDkSA=;
	t=1727296378; x=1728505978; b=oF7KmVfmnAdnMe3eQCIvmrsk9E1VWqGmOz78I8Af9RHb6PF
	OYynoHjuEGdpSPARZUuIMqdtsH5MklUVJkBzqhqYgYxPmSo1a9MdzgpqGEb95doL/jRM1nmmZpWqz
	Iw6ZcZQGWPczz0TV8n8kfZ8KUg+TZYedUukAJxElncbEg6Za0PQxv1zFTs/HHFIsWlgUSxX5jsW4U
	rR+5/HO2YG08OSsGOlyv8Sx7x4Gh09oVToQy+/GEwOwCxb9eqRXt7gZ2d5gNkB64mIzO0iLZPi8Gg
	nWCESGs79Ga/87wTpoXbjr7M61vZjVZNnPaqSi+ECodIes/QLPYNrqVj8Fe4rYfQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1stYgv-00000001A19-2Cn8;
	Wed, 25 Sep 2024 22:32:53 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
	Johannes Berg <johannes@sipsolutions.net>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC PATCH 4/9] um: Add stub side of SECCOMP/futex based process handling
Date: Wed, 25 Sep 2024 22:32:27 +0200
Message-ID: <20240925203232.565086-5-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240925203232.565086-1-benjamin@sipsolutions.net>
References: <20240925203232.565086-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240925_133258_967749_A22BC890 
X-CRM114-Status: GOOD (  21.38  )
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
mcontext. For the FS_BASE/GS_BASE register we need special handling.

Co-authored-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/include/shared/common-offsets.h |  1 +
 arch/um/include/shared/skas/stub-data.h | 15 +++++++
 arch/um/kernel/skas/stub.c              | 53 +++++++++++++++++++++++++
 arch/x86/um/shared/sysdep/stub-data.h   | 18 +++++++++
 arch/x86/um/shared/sysdep/stub.h        |  2 +
 arch/x86/um/shared/sysdep/stub_32.h     | 13 ++++++
 arch/x86/um/shared/sysdep/stub_64.h     | 14 +++++++
 7 files changed, 116 insertions(+)
 create mode 100644 arch/x86/um/shared/sysdep/stub-data.h

diff --git a/arch/um/include/shared/common-offsets.h b/arch/um/include/shared/common-offsets.h
index 579ed946a3a9..253987fc78ac 100644
--- a/arch/um/include/shared/common-offsets.h
+++ b/arch/um/include/shared/common-offsets.h
@@ -29,3 +29,4 @@ DEFINE(UML_CONFIG_64BIT, CONFIG_64BIT);
 DEFINE(UML_CONFIG_UML_TIME_TRAVEL_SUPPORT, CONFIG_UML_TIME_TRAVEL_SUPPORT);
 #endif
 
+DEFINE(UM_KERN_GDT_ENTRY_TLS_ENTRIES, GDT_ENTRY_TLS_ENTRIES);
diff --git a/arch/um/include/shared/skas/stub-data.h b/arch/um/include/shared/skas/stub-data.h
index 3fbdda727373..1ee1677abeda 100644
--- a/arch/um/include/shared/skas/stub-data.h
+++ b/arch/um/include/shared/skas/stub-data.h
@@ -8,9 +8,14 @@
 #ifndef __STUB_DATA_H
 #define __STUB_DATA_H
 
+#include <linux/kconfig.h>
 #include <linux/compiler_types.h>
 #include <as-layout.h>
 #include <sysdep/tls.h>
+#include <sysdep/stub-data.h>
+
+#define FUTEX_IN_CHILD 0
+#define FUTEX_IN_KERN 1
 
 struct stub_init_data {
 	unsigned long stub_start;
@@ -53,6 +58,16 @@ struct stub_data {
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
index 5d52ffa682dc..2d0cdb701d29 100644
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
@@ -67,3 +72,51 @@ stub_syscall_handler(void)
 
 	trap_myself();
 }
+
+#ifdef CONFIG_UML_SECCOMP
+void __attribute__ ((__section__ (".__syscall_stub")))
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
+		stub_syscall2(__NR_kill, 0, SIGKILL);
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
+void __attribute__ ((__section__ (".__syscall_stub")))
+stub_signal_restorer(void)
+{
+	/* We must not have anything on the stack when doing rt_sigreturn */
+	stub_syscall0(__NR_rt_sigreturn);
+}
+#endif
diff --git a/arch/x86/um/shared/sysdep/stub-data.h b/arch/x86/um/shared/sysdep/stub-data.h
new file mode 100644
index 000000000000..15707798ae6e
--- /dev/null
+++ b/arch/x86/um/shared/sysdep/stub-data.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
index 631a18d0ff44..22d5c67c05fa 100644
--- a/arch/x86/um/shared/sysdep/stub_32.h
+++ b/arch/x86/um/shared/sysdep/stub_32.h
@@ -123,4 +123,17 @@ static __always_inline void *get_stub_data(void)
 
 	return (void *)ret;
 }
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
index 17153dfd780a..648a3bb4b406 100644
--- a/arch/x86/um/shared/sysdep/stub_64.h
+++ b/arch/x86/um/shared/sysdep/stub_64.h
@@ -10,6 +10,7 @@
 #include <sysdep/ptrace_user.h>
 #include <generated/asm-offsets.h>
 #include <linux/stddef.h>
+#include <asm/prctl.h>
 
 #define STUB_MMAP_NR __NR_mmap
 #define MMAP_OFFSET(o) (o)
@@ -126,4 +127,17 @@ static __always_inline void *get_stub_data(void)
 
 	return (void *)ret;
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
2.46.1


