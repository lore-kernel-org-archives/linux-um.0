Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE86CCD18E
	for <linux-um@archiver.kernel.org>; Tue, 14 Oct 2025 23:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8HBofCLPawa6CE1rvY1ls9D+BkHx547tY3L6YJa+htc=; b=rTeWuT0M2grybwfXNNOjF1/0hR
	JRTt119EJcVuavNF5V83Au22bXfvoaz02GWBtAgs728VbBVlabhzdkuMDsUE1uCAIkNfA2MrysNT/
	2huXRp2B9SGerWJTq3xFuGQPh2xb2jRMmmnaFhwvWLHJOgTi71wkXJdmhldB12ZVd2jXbdQuJ+2hG
	NCIt43cLgARYDIRqc1d482NizlnEI8hNS3mlAbcXGl8qJe+VKRW85UNHO+0U6/sLYlABuhhdmIX4H
	w07HQvFexDPqWgxopvYPLGZp9scSsMJjIOYdL/SPD9Ga6vED1W3kNzLlQSV34DTdPDlQLTJ1jzLus
	qeeeXouQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8oQI-000000002OO-1auj;
	Tue, 14 Oct 2025 23:27:18 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8oQH-000000002Nk-2F3a
	for linux-um@lists.infradead.org;
	Tue, 14 Oct 2025 23:27:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id ECD2B6230B;
	Tue, 14 Oct 2025 23:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B694CC4CEE7;
	Tue, 14 Oct 2025 23:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760484436;
	bh=QGg+cLDwaefAIpaStFsfisZ/bUz9GPM0JcN2ANfbxL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pKdDKOWiCCF0uO5b9ZcYY1BKNr+frW1mUAru6DUz9aXZJTdh6ZWlh5tnRp95mgDfQ
	 RdfvUAJTqnZX1mtiK631WnZGgekKT0nhK6WXDPiqCNtoAsYYNZU2O9AFP1RQgkTv+t
	 f6dVDm/cXoDfYVbTQsj29DLBis4ZYBqIUcVVGfj9DF9PunCEJ/C+ko7w1gTcEw1kSy
	 qD3WijxGv+RiypVFw9Fn14vqwIqKR/vXB4zqgM5KMiJ01EtOk7LEh6KJlB4dbOKbuD
	 E8M5VPBwNRnnqOLqNgkorR3uN7/hb/dh7blUarL6QnXAdyEV+UOAN7pLPsEUxxWIGU
	 IT/smkxEufu2Q==
From: Sasha Levin <sashal@kernel.org>
To: nathan@kernel.org
Cc: Matt.Kelly2@boeing.com,
	akpm@linux-foundation.org,
	andrew.j.oppelt@boeing.com,
	anton.ivanov@cambridgegreys.com,
	ardb@kernel.org,
	arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	chuck.wolber@boeing.com,
	dave.hansen@linux.intel.com,
	dvyukov@google.com,
	hpa@zytor.com,
	jinghao7@illinois.edu,
	johannes@sipsolutions.net,
	jpoimboe@kernel.org,
	justinstitt@google.com,
	kees@kernel.org,
	kent.overstreet@linux.dev,
	linux-arch@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	llvm@lists.linux.dev,
	luto@kernel.org,
	marinov@illinois.edu,
	masahiroy@kernel.org,
	maskray@google.com,
	mathieu.desnoyers@efficios.com,
	matthew.l.weber3@boeing.com,
	mhiramat@kernel.org,
	mingo@redhat.com,
	morbo@google.com,
	ndesaulniers@google.com,
	oberpar@linux.ibm.com,
	paulmck@kernel.org,
	peterz@infradead.org,
	richard@nod.at,
	rostedt@goodmis.org,
	samitolvanen@google.com,
	samuel.sarkisian@boeing.com,
	sashal@kernel.org,
	steven.h.vanderleest@boeing.com,
	tglx@linutronix.de,
	tingxur@illinois.edu,
	tyxu@illinois.edu,
	wentaoz5@illinois.edu,
	x86@kernel.org
Subject: [RFC PATCH 3/4] x86: disable llvm-cov instrumentation
Date: Tue, 14 Oct 2025 19:26:38 -0400
Message-ID: <20251014232639.673260-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014232639.673260-1-sashal@kernel.org>
References: <20250829181007.GA468030@ax162>
 <20251014232639.673260-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Wentao Zhang <wentaoz5@illinois.edu>

Disable instrumentation for arch/x86/crypto/curve25519-x86_64.c. Otherwise
compilation would fail with "error: inline assembly requires more registers
than available".

Similar behavior was reported with gcov as well. See c390c452ebeb ("crypto:
x86/curve25519 - disable gcov").

Signed-off-by: Wentao Zhang <wentaoz5@illinois.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/crypto/Makefile | 1 +
 lib/crypto/Makefile      | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
index 2d30d5d361458..9fac64c39766f 100644
--- a/arch/x86/crypto/Makefile
+++ b/arch/x86/crypto/Makefile
@@ -77,3 +77,4 @@ aria-aesni-avx2-x86_64-y := aria-aesni-avx2-asm_64.o aria_aesni_avx2_glue.o
 
 obj-$(CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64) += aria-gfni-avx512-x86_64.o
 aria-gfni-avx512-x86_64-y := aria-gfni-avx512-asm_64.o aria_gfni_avx512_glue.o
+
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index bded351aeacef..9a8040ea7b626 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -81,8 +81,9 @@ libchacha20poly1305-$(CONFIG_CRYPTO_SELFTESTS)	+= chacha20poly1305-selftest.o
 obj-$(CONFIG_CRYPTO_LIB_CURVE25519) += libcurve25519.o
 libcurve25519-y := curve25519.o
 
-# Disable GCOV in odd or sensitive code
+# Disable GCOV and llvm-cov in odd or sensitive code
 GCOV_PROFILE_curve25519.o := n
+LLVM_COV_PROFILE_curve25519-x86_64.o := n
 
 ifeq ($(CONFIG_ARCH_SUPPORTS_INT128),y)
 libcurve25519-$(CONFIG_CRYPTO_LIB_CURVE25519_GENERIC) += curve25519-hacl64.o
-- 
2.51.0


