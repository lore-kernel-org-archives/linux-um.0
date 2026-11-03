Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3D16082BF0
	for <linux-um@archiver.kernel.org>; Tue,  3 Nov 2026 01:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=EYuTAtW+;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PQsuSs5S
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=0+mSBXLNAA0dwXnlKGB4VzBTQaYn7txRakynf3QsRrI=; b=EYuTAtW+djTrv6
	3MjSN0tvZSCkOxl/v+CZXCIAubcVP/hlqdU4DrJvmXXjHXx3I2Am3UvP15ZSAxeGVieMUUWgNjvJ4
	14pTwRO8lK7Iz3zQQOaK2fhyCarsX68IFOEf7C+cWtTcGx8Hzt0CEX251QSg7gDmvxdu2aAVCNUPN
	UrAvTSkxRiIYKwonzHDtErtqkXrIwHdA2CLRr7zFyg9ft3FdVlhaBoyowjhorZwwbS5jv+3391T/S
	kUUzk7DVyfM2t9rBkU3EOns8C2aRjg8UD9eBDnKpvYtWE0sL07YeTgaMJOE9qW4P6gpevtN7K+lFI
	cPLUVExfl6Vzt2EqvKlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO3iD-00000000p8g-1kJu;
	Tue, 03 Nov 2026 01:53:21 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO3iC-00000000p8Y-1fC3
	for linux-um@lists.infradead.org;
	Tue, 03 Nov 2026 01:53:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A870E417F9;
	Tue,  3 Nov 2026 01:53:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093F41F00A1C;
	Tue,  3 Nov 2026 01:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793670799;
	bh=0+mSBXLNAA0dwXnlKGB4VzBTQaYn7txRakynf3QsRrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PQsuSs5Slt57uw2KiTg6p4IuEa6Ftql8y0WZ7NtYUqc9vQkDT6kH6yQipP/KsjGc0
	 Ut8f/YMCuEP/FOq7hIL2TW/FDdDrPf0IgH5nlFRRyWD085o5fQ+DUUzH7F41fdwsX1
	 HenktnIQU5lFIFkHCly1le05TUVhh2DZvy8vbOwfbRnTqb9Aqh6dLhXGnSFPb/RHYX
	 AioF/jLDPY+MCwbZAhr9sz8nhzegq76YTza92QO0PNnFUBwodcKT+b3eVM8mO4+G3l
	 wvOw5yRDQigt0zvDAbW8z+alJXSJtfDNuNlGVlm+GH1/aev489EPbP04Csf1bxkztu
	 qXhoNMfPZNM5A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Chuck Wolber <chuck@wolber.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Justin Stitt <justinstitt@google.com>,
	kasan-dev@googlegroups.com,
	linux-kbuild@vger.kernel.org,
	linux-um@lists.infradead.org,
	llvm@lists.linux.dev,
	Marco Elver <elver@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nsc@kernel.org>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Thomas Gleixner <tglx@kernel.org>,
	x86@kernel.org
Subject: [PATCH v2 19/20] gcov: add MC/DC condition coverage support
Date: Mon,  2 Nov 2026 20:52:37 -0500
Message-ID: <20261103015238.3780910-20-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103015238.3780910-1-sashal@kernel.org>
References: <20261103015238.3780910-1-sashal@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Support CONFIG_COVERAGE_MCDC with gcov, using GCC's MC/DC condition
coverage instrumentation (-fcondition-coverage), which is available
since GCC 14. The data is shown by "gcov --conditions".

Add -fcondition-coverage to the gcov compiler flags when enabled, and
disable the warnings about decisions it leaves out, as is done for
Clang. Both are gated on the config option to avoid Clang warnings
about unknown options.

Also add -fcondition-coverage to CFLAGS_REMOVE in the x86 UML vDSO
Makefile to prevent instrumentation of userspace vDSO code.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/um/vdso/Makefile | 4 ++--
 kernel/coverage/Kconfig   | 7 +++++--
 kernel/coverage/gcov/fs.c | 5 +++--
 scripts/Makefile.gcov     | 5 +++++
 4 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index 7664cbedbe30f..adfc57c1a726d 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -42,8 +42,8 @@ $(vobjs): KBUILD_CFLAGS += $(CFL)
 #
 # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
 #
-CFLAGS_REMOVE_vdso-note.o = -pg -fprofile-arcs -ftest-coverage
-CFLAGS_REMOVE_um_vdso.o = -pg -fprofile-arcs -ftest-coverage
+CFLAGS_REMOVE_vdso-note.o = -pg -fprofile-arcs -ftest-coverage -fcondition-coverage
+CFLAGS_REMOVE_um_vdso.o = -pg -fprofile-arcs -ftest-coverage -fcondition-coverage
 
 #
 # The DSO images are built using a special linker script.
diff --git a/kernel/coverage/Kconfig b/kernel/coverage/Kconfig
index 8d9d5f063aea6..3429bc902c934 100644
--- a/kernel/coverage/Kconfig
+++ b/kernel/coverage/Kconfig
@@ -108,8 +108,8 @@ config COVERAGE_PROFILE_ALL
 
 config COVERAGE_MCDC
 	bool "Measure modified condition/decision coverage (MC/DC)"
-	depends on LLVM_COV_KERNEL
-	depends on CLANG_VERSION >= 220000 || !WERROR
+	depends on LLVM_COV_KERNEL || (GCOV_KERNEL && CC_HAS_CONDITION_COVERAGE)
+	depends on !LLVM_COV_KERNEL || CLANG_VERSION >= 220000 || !WERROR
 	help
 	  MC/DC verifies that each condition of a boolean decision has been
 	  shown to independently affect the outcome of the decision. It is
@@ -119,6 +119,9 @@ config COVERAGE_MCDC
 	  Decisions that the compiler can't instrument are not measured, and
 	  only get branch coverage.
 
+	  With gcov this requires GCC 14 or later, and the data is shown by
+	  "gcov --conditions".
+
 	  If unsure, say N.
 
 config LLVM_COV_MCDC_MAX_CONDITIONS
diff --git a/kernel/coverage/gcov/fs.c b/kernel/coverage/gcov/fs.c
index a761cfb837414..689b8b9a0d16a 100644
--- a/kernel/coverage/gcov/fs.c
+++ b/kernel/coverage/gcov/fs.c
@@ -866,8 +866,9 @@ void gcov_event(enum gcov_action action, struct gcov_info *info)
 }
 
 static const struct coverage_backend gcov_backend = {
-	.name	= "gcov",
-	.reset	= gcov_reset_all,
+	.name		= "gcov",
+	.features	= IS_ENABLED(CONFIG_COVERAGE_MCDC) ? "mcdc" : NULL,
+	.reset		= gcov_reset_all,
 };
 
 /* Create debugfs entries. */
diff --git a/scripts/Makefile.gcov b/scripts/Makefile.gcov
index 1cfe04d89b0a2..977c8ee023f68 100644
--- a/scripts/Makefile.gcov
+++ b/scripts/Makefile.gcov
@@ -18,4 +18,9 @@ CFLAGS_COVERAGE	+= $(call try-run,\
 	cmp -s "$$TMP.ubase" "$$TMP.utest",\
 	-fprofile-update=prefer-atomic)
 endif
+ifdef CONFIG_COVERAGE_MCDC
+CFLAGS_COVERAGE	+= -fcondition-coverage
+# As for Clang: KCFLAGS=-Wcoverage-too-many-conditions lists what's left out.
+KBUILD_CFLAGS	+= -Wno-coverage-too-many-conditions
+endif
 export CFLAGS_COVERAGE
-- 
2.53.0


