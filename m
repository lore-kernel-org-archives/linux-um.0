Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFE9C2BA1B
	for <linux-um@archiver.kernel.org>; Mon,  9 Oct 2023 12:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vdBDyRqi2mg6DPND43+rsWUuDDuFT6c4QGWlqJLho7Q=; b=V/7etCtH9rW3WR
	IJzO8+IOVb5xSSNLwobLKBx6SitKPHCy7Qv5bpGRUBGO/sMBakZiUXLt69o7gvr9Xfv+FV8pZwCLC
	2tO4E4D5/cTOXOy0sPmsbbBJNfkQfvdg/H+Ac0KPqhHR95f8P/M/FCtRJXa/XJ2KBptCyhhzfagqh
	Sou57Q26GjPoS8uhqpEvN11ii7j165Mlv2/37DSpdOSCqizflch4PENhEwENdhSl2sLCvjc5dq7B6
	01N/d9Bo5C/Pkbr4R0ixq1HPYm1y5nsXJF3Vt+mDL4Kdz7FXB9Vi6avUiJNat+N0ebldBN6F537pv
	OnpEoVW1E5PLY99oTL5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qppar-00AhqK-2G;
	Mon, 09 Oct 2023 12:42:41 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qppaj-00Ahi7-3D;
	Mon, 09 Oct 2023 12:42:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 6E92FCE13AE;
	Mon,  9 Oct 2023 12:42:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD3BC433C8;
	Mon,  9 Oct 2023 12:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696855351;
	bh=ohuZp0WsPxcwHw6R6rlObohasBZPv2zNfsGPMOVNB0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BKSDQENlvCmvcUrtGTpvgpXpECfR89ZihieZKhN8yFEcgvnaQah5u+fu1s9cT4cyh
	 t0XXIrXBr5Wh2tHs5U1wgNNLvlJriRBgYeecMegYSMNkZLiT37eCLJlFIUbu7rxsbG
	 5sr0In6kOsFUzhVpOudgXO5aL4REohZCiaJPgybNzfR2soQZC2ttQ0uYemp5lQ6Wtx
	 vi8oA26zKj5teKiNkX8lGRKZNfEXHLCGSxdgSIRTbQ/cGXWeU3YnKa2qbLlIVXNKLs
	 UbTjRun9wVsuKTpkgtho/Jv5qMGp9UmJAFMvr18c5+F3RNdavwcms6ANinS9j1avAn
	 oEcB4ugnaUyQg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org,
	x86@kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 5/5] kbuild: unify no-compiler-targets and no-sync-config-targets
Date: Mon,  9 Oct 2023 21:42:10 +0900
Message-Id: <20231009124210.1064021-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009124210.1064021-1-masahiroy@kernel.org>
References: <20231009124210.1064021-1-masahiroy@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231009_054234_201944_5FBD8BC4 
X-CRM114-Status: UNSURE (   8.20  )
X-CRM114-Notice: Please train this message.
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

Now that vdso_install does not depend on any in-tree build artifact,
it no longer invokes a compiler, making no-compiler-targets the same
as no-sync-config-targets.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/Makefile b/Makefile
index 2170d56630e8..982b1ad33287 100644
--- a/Makefile
+++ b/Makefile
@@ -277,10 +277,6 @@ no-dot-config-targets := $(clean-targets) \
 			 $(version_h) headers headers_% archheaders archscripts \
 			 %asm-generic kernelversion %src-pkg dt_binding_check \
 			 outputmakefile rustavailable rustfmt rustfmtcheck
-# Installation targets should not require compiler. Unfortunately, vdso_install
-# is an exception where build artifacts may be updated. This must be fixed.
-no-compiler-targets := $(no-dot-config-targets) install dtbs_install \
-			headers_install modules_install modules_sign kernelrelease image_name
 no-sync-config-targets := $(no-dot-config-targets) %install modules_sign kernelrelease \
 			  image_name
 single-targets := %.a %.i %.ko %.lds %.ll %.lst %.mod %.o %.rsi %.s %.symtypes %/
@@ -288,7 +284,6 @@ single-targets := %.a %.i %.ko %.lds %.ll %.lst %.mod %.o %.rsi %.s %.symtypes %
 config-build	:=
 mixed-build	:=
 need-config	:= 1
-need-compiler	:= 1
 may-sync-config	:= 1
 single-build	:=
 
@@ -298,12 +293,6 @@ ifneq ($(filter $(no-dot-config-targets), $(MAKECMDGOALS)),)
 	endif
 endif
 
-ifneq ($(filter $(no-compiler-targets), $(MAKECMDGOALS)),)
-	ifeq ($(filter-out $(no-compiler-targets), $(MAKECMDGOALS)),)
-		need-compiler :=
-	endif
-endif
-
 ifneq ($(filter $(no-sync-config-targets), $(MAKECMDGOALS)),)
 	ifeq ($(filter-out $(no-sync-config-targets), $(MAKECMDGOALS)),)
 		may-sync-config :=
@@ -675,7 +664,7 @@ endif
 
 # Include this also for config targets because some architectures need
 # cc-cross-prefix to determine CROSS_COMPILE.
-ifdef need-compiler
+ifdef may-sync-config
 include $(srctree)/scripts/Makefile.compiler
 endif
 
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
