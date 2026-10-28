Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C4D60A2606
	for <linux-um@archiver.kernel.org>; Wed, 28 Oct 2026 12:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dhudtRlC;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oLRqsRQc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=06P3NBYjMCtOrztfs1wSnGlXZi7V2R3u1OzmTPpiQ+w=; b=dhudtRlC31/xAO
	YX85kBmwE3GWnWTPQKJJ3nSzl/luYaeEpe7I2GdqRJzAuxLG1BCUasKzXAwwvbn0BjRnwLPimUZok
	KWx487k+Ii7R/QKRh+l/tdJpKpTftPUxSYf0xAbhdra0mEPbA2JMZKcyqwh4Gzk0faHAjflwePIPz
	tb2SrrljKGEEEMlF8Jsefk3XnKrrs+U7sXkDRBnop7v+XrzEG0c6/sA1nwoWTQ9U7k+ujLArzWo8+
	Gs42ipRSAbXg6+qvrBw9QYUmacOCsIQAmwDMG7v8hzKp3jn4MRQwofN6wdqFM0CYEksGzD0cgOon2
	oUDBIx3H4Cr6EqdlKSQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM2LW-00000006ur6-3sx8;
	Wed, 28 Oct 2026 12:01:34 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM2LV-00000006uqt-34Td
	for linux-um@lists.infradead.org;
	Wed, 28 Oct 2026 12:01:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3C32943E97;
	Wed, 28 Oct 2026 12:01:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12C81F031E2;
	Wed, 28 Oct 2026 12:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793188893;
	bh=06P3NBYjMCtOrztfs1wSnGlXZi7V2R3u1OzmTPpiQ+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oLRqsRQcwlbnosapGQ949rNbWgQONbmo9cTZV4Y6jsPad+EJuOLSxE6rlyMXvrVcq
	 lZsM0Z6XRbnyYUrxHN+JRqqhwNiGDcorB2MR9uZ47HNnn+nGfX7388O226XDWi2vY2
	 Jrp4vePmcn6pZpspdgFmwg2tl5ypHdP8MV339iwPZ/BGemrU5Foyo2oN69Ft+COI7Z
	 TvRhYZPlGgfWEDnI/0Rj72VMApTrnQvuBv3dpaXPeUDzhoOjc51UPQqTr1e92IkiZa
	 Maqu0WlvgCN6f01Ylxs8RxIZDuGaBY5GTyC1gE7jB2Wb0NfYzreDNf/FDw1D+RLrcs
	 o4lNryOnLls0w==
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
Subject: [RFC PATCH 19/20] gcov: add MC/DC condition coverage support
Date: Wed, 28 Oct 2026 07:59:43 -0400
Message-ID: <20261028120034.871983-20-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028120034.871983-1-sashal@kernel.org>
References: <20261028120034.871983-1-sashal@kernel.org>
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

Add -fcondition-coverage and -Wno-error=coverage-too-many-conditions to
the gcov compiler flags when enabled. Both flags are gated on the config
option to avoid Clang warnings about unknown options.

Also add -fcondition-coverage to CFLAGS_REMOVE in the x86 UML vDSO
Makefile to prevent instrumentation of userspace vDSO code.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/um/vdso/Makefile | 4 ++--
 kernel/coverage/Kconfig   | 7 +++++--
 kernel/coverage/gcov/fs.c | 5 +++--
 scripts/Makefile.gcov     | 3 +++
 4 files changed, 13 insertions(+), 6 deletions(-)

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
index fab3da51305bb..5990e366db994 100644
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
 	  Decisions that the compiler can't instrument produce build warnings
 	  and are not measured.
 
+	  With gcov this requires GCC 14 or later, and the data is shown by
+	  "gcov --conditions".
+
 	  If unsure, say N.
 
 config LLVM_COV_MCDC_MAX_CONDITIONS
diff --git a/kernel/coverage/gcov/fs.c b/kernel/coverage/gcov/fs.c
index 23d366dcfc2f7..dfaccc01e06f3 100644
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
index 1620b81398eaa..b00dd40f2167d 100644
--- a/scripts/Makefile.gcov
+++ b/scripts/Makefile.gcov
@@ -19,4 +19,7 @@ CFLAGS_COVERAGE	+= $(call try-run,\
 	cmp -s "$$TMP.ubase" "$$TMP.utest",\
 	-fprofile-update=prefer-atomic)
 endif
+ifdef CONFIG_COVERAGE_MCDC
+CFLAGS_COVERAGE	+= -fcondition-coverage -Wno-error=coverage-too-many-conditions
+endif
 export CFLAGS_COVERAGE
-- 
2.53.0


