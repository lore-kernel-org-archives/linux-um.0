Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A62606A685
	for <linux-um@archiver.kernel.org>; Wed, 25 Nov 2026 02:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jeQBfGIp;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MOzH5Rru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=tdesGFo2gvb7lstfuQLq+1yzVhj59qUZoNASZ3nLc64=; b=jeQBfGIpbJj7xv
	nyjI5TGegadUqpQGfp64Xq3Atat848e9gNl60d0myLEJBX0Lh2McWngA6LN6MIW1awFi8ORoEpT6g
	UG6She52+WrHq3LNyA+czqbdeK2eoUPEYg+1wzXJUa5p1O20UnPy7NCqz+C8dQvTeFvT31465rmVM
	BtNfGp2F44QwuZNyB3QppfrIml1GlnuwYsr5PiY4Ku/0E2BVRQ2YJjD76cK+n+AofJs1nzPjjkIHh
	uZ1Yyt7aer1H9QqKORh3w3fZxwhe31PIWfEzY15CP5Zo+pMbhxB0MpTZnpO2zrfHMTbxVOzAV9yuS
	nvAI1VBdSOzroGexqONg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW2PR-00000008E08-1yVT;
	Wed, 25 Nov 2026 02:06:57 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW2PP-00000008E02-41Pl
	for linux-um@lists.infradead.org;
	Wed, 25 Nov 2026 02:06:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5A4824004E;
	Wed, 25 Nov 2026 02:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249CD1F000D2;
	Wed, 25 Nov 2026 02:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795572415;
	bh=tdesGFo2gvb7lstfuQLq+1yzVhj59qUZoNASZ3nLc64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MOzH5RrubIHH0xdG1qa6SXAy8I5qToyyikEPfeVC69kcczGmBTHG27KlWgF7AcPmW
	 hOVgpskgrRAwzYrpvmF8wIfgNdsmNo+hQ8nqq7MzOPxsR8SOrVE2XEaxos23b/AoE+
	 kAb4/Vzk8V5qUSfW557O0CaKOut+w8pbnSCMrYLhr5PlgeV+uCwSoXHQgUiNIsvpwR
	 y/wrpNHWmlknXQuRTKfo52SM+TbKLUibkxcbk9vWW1g0BFXQshnibZMCcS9+Yi9jin
	 ZZ9QzPwD+gds3gz6+ZgPw+syb3jV0z99X6dgBmHr4tR2WI52ZVRwepncoPkUH3cE7A
	 XU3ctJ5nBQjkg==
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
	Josh Poimboeuf <jpoimboe@kernel.org>,
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
Subject: [PATCH v3 18/19] gcov: add MC/DC condition coverage support
Date: Tue, 24 Nov 2026 21:06:02 -0500
Message-ID: <20261125020603.3934222-19-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125020603.3934222-1-sashal@kernel.org>
References: <20261125020603.3934222-1-sashal@kernel.org>
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

Signed-off-by: Sasha Levin <sashal@kernel.org>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
---
 kernel/coverage/Kconfig   | 7 +++++--
 kernel/coverage/gcov/fs.c | 3 ++-
 scripts/Makefile.gcov     | 5 +++++
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/coverage/Kconfig b/kernel/coverage/Kconfig
index 173a321741f87..77df4c04945dc 100644
--- a/kernel/coverage/Kconfig
+++ b/kernel/coverage/Kconfig
@@ -108,8 +108,8 @@ config COVERAGE_PROFILE_ALL
 
 config COVERAGE_MCDC
 	bool "Measure modified condition/decision coverage (MC/DC)"
-	depends on LLVM_COV_KERNEL
-	depends on CLANG_VERSION >= 220000 || !WERROR
+	depends on LLVM_COV_KERNEL || (GCOV_KERNEL && CC_HAS_CONDITION_COVERAGE)
+	depends on !(LLVM_COV_KERNEL && CLANG_VERSION < 220000 && WERROR)
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
index fe1b85d54ede0..aa51e76c0e530 100644
--- a/kernel/coverage/gcov/fs.c
+++ b/kernel/coverage/gcov/fs.c
@@ -861,7 +861,8 @@ void gcov_event(enum gcov_action action, struct gcov_info *info)
 }
 
 static const struct coverage_backend gcov_backend = {
-	.name	= "gcov",
+	.name		= "gcov",
+	.features	= IS_ENABLED(CONFIG_COVERAGE_MCDC) ? "mcdc" : NULL,
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


