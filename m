Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEEECE79D1
	for <linux-um@archiver.kernel.org>; Wed, 20 Sep 2023 12:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=NKhUVXyLg15hONZoPF6mArKuPc3HSrSAYN/s8HCihR0=; b=DDJo9HmJ4iZ/s7
	NfW6wx23J9cm1+547Lhb4bkx7tTmCYhl8YH7GvHWKUn6MylUHNcnfNhBDOPNwzQiUzojwMPLM2QD0
	2lyrRgHebchrKe9eN+hKOxzqroRBqwOxyqlWHuacvYMewkpCqvpFt7o19WS2rq0roP1nQgioHm9ZJ
	8S6vt1hvwsrrCE45it8JIk3SkgRgrpLHkhEdzTzmeRcZxpBj8PoF7FG+AB+uOv/V4+722snBpSGhY
	uHwhjNymiRhDOCW/SOAXamQuBDUwdBO9E+sd/GaHb8ZsTvkWcg3MNohQPTu5Me7Ana4cNROjt3VPw
	JvXzFXWsNL4YzyfPEg5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiwNG-0031wO-2d;
	Wed, 20 Sep 2023 12:32:10 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiwNE-0031vI-1z
	for linux-um@lists.infradead.org;
	Wed, 20 Sep 2023 12:32:10 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qiwNC-002Vr9-Uh; Wed, 20 Sep 2023 12:32:07 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qiwN9-00HFKA-6Z; Wed, 20 Sep 2023 13:32:05 +0100
From: anton.ivanov@cambridgegreys.com
To: linux-um@lists.infradead.org
Cc: johannes@sipsolutions.net,
	richard@nod.at,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [PATCH] um: Enable preemption in UML
Date: Wed, 20 Sep 2023 13:31:15 +0100
Message-Id: <20230920123115.4106721-1-anton.ivanov@cambridgegreys.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230920_053208_651090_8155EF02 
X-CRM114-Status: GOOD (  14.54  )
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

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Preemption requires saving/restoring FPU state. This patch
adds support for it using GCC intrinsics.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/Kconfig                         |  1 -
 arch/um/Makefile                        |  3 +-
 arch/um/include/asm/fpu/api.h           |  4 +-
 arch/um/include/asm/processor-generic.h |  1 +
 arch/um/kernel/Makefile                 |  2 +-
 arch/um/kernel/fpu.c                    | 49 +++++++++++++++++++++++++
 6 files changed, 55 insertions(+), 5 deletions(-)
 create mode 100644 arch/um/kernel/fpu.c

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index b5e179360534..603f5fd82293 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -11,7 +11,6 @@ config UML
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_STRNCPY_FROM_USER
 	select ARCH_HAS_STRNLEN_USER
-	select ARCH_NO_PREEMPT
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_KASAN if X86_64
 	select HAVE_ARCH_KASAN_VMALLOC if HAVE_ARCH_KASAN
diff --git a/arch/um/Makefile b/arch/um/Makefile
index 82f05f250634..35a059baadeb 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -61,7 +61,8 @@ KBUILD_CFLAGS += $(CFLAGS) $(CFLAGS-y) -D__arch_um__ \
 	$(ARCH_INCLUDE) $(MODE_INCLUDE) -Dvmap=kernel_vmap	\
 	-Dlongjmp=kernel_longjmp -Dsetjmp=kernel_setjmp \
 	-Din6addr_loopback=kernel_in6addr_loopback \
-	-Din6addr_any=kernel_in6addr_any -Dstrrchr=kernel_strrchr
+	-Din6addr_any=kernel_in6addr_any -Dstrrchr=kernel_strrchr \
+	-mxsave
 
 KBUILD_RUSTFLAGS += -Crelocation-model=pie
 
diff --git a/arch/um/include/asm/fpu/api.h b/arch/um/include/asm/fpu/api.h
index 71bfd9ef3938..0094624ae9b4 100644
--- a/arch/um/include/asm/fpu/api.h
+++ b/arch/um/include/asm/fpu/api.h
@@ -8,8 +8,8 @@
  * of x86 optimized copy, xor, etc routines into the
  * UML code tree. */
 
-#define kernel_fpu_begin() (void)0
-#define kernel_fpu_end() (void)0
+void kernel_fpu_begin(void);
+void kernel_fpu_end(void);
 
 static inline bool irq_fpu_usable(void)
 {
diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/asm/processor-generic.h
index 7414154b8e9a..1c3287f1a444 100644
--- a/arch/um/include/asm/processor-generic.h
+++ b/arch/um/include/asm/processor-generic.h
@@ -44,6 +44,7 @@ struct thread_struct {
 			} cb;
 		} u;
 	} request;
+    u8 fpu[512] __aligned(16); /* Intel docs require xsave/xrestore area to be aligned to 16 bytes */
 };
 
 #define INIT_THREAD \
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index 811188be954c..5d9fbaa544be 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -16,7 +16,7 @@ extra-y := vmlinux.lds
 
 obj-y = config.o exec.o exitcode.o irq.o ksyms.o mem.o \
 	physmem.o process.o ptrace.o reboot.o sigio.o \
-	signal.o sysrq.o time.o tlb.o trap.o \
+	signal.o sysrq.o time.o tlb.o trap.o fpu.o\
 	um_arch.o umid.o maccess.o kmsg_dump.o capflags.o skas/
 obj-y += load_file.o
 
diff --git a/arch/um/kernel/fpu.c b/arch/um/kernel/fpu.c
new file mode 100644
index 000000000000..4142a08c474d
--- /dev/null
+++ b/arch/um/kernel/fpu.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Cambridge Greys Ltd
+ * Copyright (C) 2023 Red Hat Inc
+ */
+
+#include <linux/cpu.h>
+#include <linux/init.h>
+#include <asm/fpu/api.h>
+
+/*
+ * The critical section between kernel_fpu_begin() and kernel_fpu_end()
+ * is non-reentrant. It is the caller's responsibility to avoid reentrance.
+ */
+
+static DEFINE_PER_CPU(bool, in_kernel_fpu);
+
+void kernel_fpu_begin(void)
+{
+	preempt_disable();
+
+	WARN_ON(this_cpu_read(in_kernel_fpu));
+
+	this_cpu_write(in_kernel_fpu, true);
+
+#ifdef CONFIG_64BIT
+	__builtin_ia32_fxsave64(&current->thread.fpu);
+#else
+	__builtin_ia32_fxsave(&current->thread.fpu);
+#endif
+}
+
+EXPORT_SYMBOL_GPL(kernel_fpu_begin);
+
+void kernel_fpu_end(void)
+{
+	WARN_ON(!this_cpu_read(in_kernel_fpu));
+
+#ifdef CONFIG_64BIT
+	__builtin_ia32_fxrstor64(&current->thread.fpu);
+#else
+	__builtin_ia32_fxrstor(&current->thread.fpu);
+#endif
+	this_cpu_write(in_kernel_fpu, false);
+
+	preempt_enable();
+}
+EXPORT_SYMBOL_GPL(kernel_fpu_end);
+
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
