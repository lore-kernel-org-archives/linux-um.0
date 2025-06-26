Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BD4C7EE30
	for <linux-um@archiver.kernel.org>; Thu, 26 Jun 2025 21:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p6xSR9jIAu7KHvk7pNgzOJ6ZFzIEeDLQ7Kri/B1ytnU=; b=pDmiWhbbng21PvB9rvhRDz8txA
	gzjHlRXvnl45PzwnniK2FWDlJ9QJgC9a+2Q2dQs1Zj8hOTwEStnLQzp7eBXOjd5FHomKdNUicybQN
	le387dmBUYT0o5N0ZG8rpr1sYgUtNxCv8KMJYwMWQViIpHMVyJtXZZnyUqV05Z8EoI0qb6lbPjg4N
	2BmL566vzoxMla3q6+M5RtLyyqOgDbnxmBY18G9GFq6cDsiw2sam4osSl48MbB58rpkQ/BrwZLh83
	8VAO3CTTFyfDIZLqvgl1bXaDNbe5ZdCFckO7IFCh+L0cZE9eOqhkUtK3wXhUM+STKTDuivJSNjzRi
	YHEfM57A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUuBL-0000000CqJs-40Jt;
	Thu, 26 Jun 2025 21:30:55 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUskg-0000000Cfhi-2aBj
	for linux-um@lists.infradead.org;
	Thu, 26 Jun 2025 19:59:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=p6xSR9jIAu7KHvk7pNgzOJ6ZFzIEeDLQ7Kri/B1ytnU=;
	t=1750967958; x=1752177558; b=tbUiIGCuNBajM/5TJaULXIfxDhXdlbGUBTAqlX3zyjTqgJQ
	kzhGPZA4jT9O7Oae5UMeyCkUz+R5b1PUkqbC0h+F5e9Qj59pN02BacBHeQ4jze37rfQHIM0P0DDkH
	2Fu2yWYG68A8DjB9RNrnoB2pmwdNrEYy7IlQcEmAMreadLkrwF4ng9126n6EGx9amVmoJf5OUFzza
	7RamIDSIh8G68aPsjCfAe1fR8RDqfplpXXiBKomK2hefXCAv13wPUNXBCvPEfD3XWeeLl6FK1DWA5
	h2Qi6WrQLcUN9oFQDXXNiO5eUEBeWGy3hlctxDwWRNkdW9n7nseJhbsjBr5xx0Fw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uUskd-0000000C0lZ-2l8E;
	Thu, 26 Jun 2025 21:59:16 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: kunit-dev@googlegroups.com,
	linux-um@lists.infradead.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC 2/2] um: add a mcontext FP register handling test
Date: Thu, 26 Jun 2025 21:57:14 +0200
Message-ID: <20250626195714.2123694-3-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250626195714.2123694-1-benjamin@sipsolutions.net>
References: <20250626195714.2123694-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_125918_655965_059FF229 
X-CRM114-Status: GOOD (  18.51  )
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

This tests checks whether floating point registers are properly saved
into the signal context and restored again. The test works by having a
known value at the top of the FP register stack and in the first xmm
register. Then SIGUSR1 is triggered and both of these registers are
modified by changing the values in the mcontext.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/x86/um/Makefile                     |   2 +
 arch/x86/um/tests/Makefile               |  12 +++
 arch/x86/um/tests/registers.c            |  22 +++++
 arch/x86/um/tests/test-fp-save-restore.c | 118 +++++++++++++++++++++++
 4 files changed, 154 insertions(+)
 create mode 100644 arch/x86/um/tests/Makefile
 create mode 100644 arch/x86/um/tests/registers.c
 create mode 100644 arch/x86/um/tests/test-fp-save-restore.c

diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index b42c31cd2390..410f5526f1f4 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -15,6 +15,8 @@ obj-y = bugs_$(BITS).o delay.o fault.o \
 	sys_call_table_$(BITS).o sysrq_$(BITS).o tls_$(BITS).o \
 	mem_$(BITS).o subarch.o os-Linux/
 
+obj-y += tests/
+
 ifeq ($(CONFIG_X86_32),y)
 
 obj-y += syscalls_32.o
diff --git a/arch/x86/um/tests/Makefile b/arch/x86/um/tests/Makefile
new file mode 100644
index 000000000000..c3a868b078f3
--- /dev/null
+++ b/arch/x86/um/tests/Makefile
@@ -0,0 +1,12 @@
+include $(srctree)/init/Makefile.nolibc
+
+ccflags-y := -I$(obj)
+
+um-tests-y += registers.o
+
+userprogs += test-fp-save-restore
+test-fp-save-restore-userccflags := -static $(NOLIBC_USERCFLAGS) -msse
+
+obj-$(CONFIG_KUNIT_UAPI) += um-tests.o
+
+$(obj)/registers.o: $(obj)/test-fp-save-restore
diff --git a/arch/x86/um/tests/registers.c b/arch/x86/um/tests/registers.c
new file mode 100644
index 000000000000..2c4e55da043c
--- /dev/null
+++ b/arch/x86/um/tests/registers.c
@@ -0,0 +1,22 @@
+#include <kunit/test.h>
+#include <kunit/test-bug.h>
+#include <kunit/uapi.h>
+
+static void test_mcontext(struct kunit *test)
+{
+	KUNIT_UAPI_EMBED_BLOB(test_fp_save_restore, "test-fp-save-restore");
+
+	kunit_uapi_run_kselftest(test, &test_fp_save_restore);
+}
+
+static struct kunit_case register_test_cases[] = {
+	KUNIT_CASE(test_mcontext),
+	{}
+};
+
+static struct kunit_suite register_test_suite = {
+	.name = "um_registers",
+	.test_cases = register_test_cases,
+};
+
+kunit_test_suites(&register_test_suite);
diff --git a/arch/x86/um/tests/test-fp-save-restore.c b/arch/x86/um/tests/test-fp-save-restore.c
new file mode 100644
index 000000000000..28a32ca374fe
--- /dev/null
+++ b/arch/x86/um/tests/test-fp-save-restore.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test FP register handling in userspace mcontext.
+ *
+ * Copyright (C) 2025 Intel Corporation
+ */
+
+#include <math.h>
+#include <signal.h>
+#include <types.h>
+#include <unistd.h>
+#include <string.h>
+#include <sys.h>
+#include <asm/sigcontext.h>
+#include <asm/ucontext.h>
+
+#include "../../../tools/testing/selftests/kselftest.h"
+
+#define ST0_EXP_ADD 10
+
+static void sighandler(int sig, siginfo_t *info, void *p)
+{
+	struct ucontext *uc = p;
+	struct _fpstate *fpstate = (void *)uc->uc_mcontext.fpstate;
+
+	ksft_print_msg("sighandler: extended_size: %d, xstate_size: %d\n",
+		       fpstate->sw_reserved.extended_size,
+		       fpstate->sw_reserved.xstate_size);
+
+#ifdef __i386__
+	fpstate->_st[0].exponent += ST0_EXP_ADD;
+	fpstate->_xmm[1].element[0] |= 0x01010101;
+	fpstate->_xmm[1].element[1] |= 0x01010101;
+	fpstate->_xmm[1].element[2] |= 0x01010101;
+	fpstate->_xmm[1].element[3] |= 0x01010101;
+#else
+	/* Hacky way of modifying the exponent without breaking aliasing */
+	fpstate->st_space[2] += ST0_EXP_ADD;
+	fpstate->xmm_space[4] |= 0x01010101;
+	fpstate->xmm_space[5] |= 0x01010101;
+	fpstate->xmm_space[6] |= 0x01010101;
+	fpstate->xmm_space[7] |= 0x01010101;
+#endif
+}
+
+static int test_mcontext(int xmm_should_change)
+{
+	double num = 0.5;
+	uint32_t sse[4] = {0x11223344, 0x55667788, 0x99aabbcc, 0xddeeff00 };
+	long ret;
+	int xmm_manipulated;
+
+	ksft_print_msg("pre-signal:  %d / 100, %08x %08x %08x %08x\n", (int) (100*num), sse[0], sse[1], sse[2], sse[3]);
+	/*
+	 * This does kill(getpid(), SIGUSR1); with "num" being passed in AND
+	 * out of the floating point stack. We can therefore modify num by
+	 * changing st[0] when handling the signal.
+	 */
+#ifdef __i386__
+	asm volatile (
+		"movups %1, %%xmm1;"
+		"int $0x80;"
+		"movups %%xmm1, %1;"
+		: "=t" (num), "=m" (sse), "=a" (ret)
+		: "0" (num), "2" (__NR_kill), "b" (getpid()), "c" (SIGUSR1) :
+		"xmm1", "memory");
+#else
+	asm volatile (
+		"movups %1, %%xmm1;"
+		"syscall;"
+		"movups %%xmm1, %1;"
+		: "=t" (num), "=m"(sse), "=a" (ret)
+		: "0" (num), "2" (__NR_kill), "D" (getpid()), "S" (SIGUSR1)
+		: "r11", "rcx", "xmm1", "memory");
+#endif
+	if (sse[0] == 0x11223344 || sse[1] == 0x55667788 || sse[2] == 0x99aabbcc || sse[3] == 0xddeeff00)
+		xmm_manipulated = 0;
+	else if (sse[0] == 0x11233345 || sse[1] == 0x55677789 || sse[2] == 0x99abbbcd || sse[3] == 0xddefff01)
+		xmm_manipulated = 1;
+	else
+		xmm_manipulated = 2;
+
+	ksft_print_msg("post-signal: %d / 100, %08x %08x %08x %08x (should change: %d, changed: %d)\n",
+		       (int) (100 * num), sse[0], sse[1], sse[2], sse[3], xmm_should_change, xmm_manipulated);
+
+	if (num != (1 << (ST0_EXP_ADD - 1))) {
+		ksft_print_msg("floating point register was not manipulated\n");
+		return 1;
+	}
+
+	if (xmm_manipulated != xmm_should_change) {
+		ksft_print_msg("xmm/sse had unexpected value!\n");
+		return 1;
+	}
+
+	return 0;
+}
+
+int main(void)
+{
+	struct sigaction sa = {
+		.sa_flags = SA_SIGINFO,
+		.sa_handler = (void (*)(int))sighandler,
+	};
+
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	if (sys_sigaction(SIGUSR1, &sa, NULL) < 0)
+		ksft_exit_fail_msg("Failed to register sigaction: %d\n", errno);
+
+	if (!test_mcontext(1))
+		ksft_test_result_pass("mcontext\n");
+	else
+		ksft_test_result_fail("mcontext failed!\n");
+
+	ksft_finished();
+}
-- 
2.50.0


