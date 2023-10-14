Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA84CDB483
	for <linux-um@archiver.kernel.org>; Sat, 14 Oct 2023 10:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V/qfxoZuK+XRkOBDK+r7OTHQ4Nif5910pvG5gQZkXcs=; b=mJSHXJyV1nW6nm
	YwhVU53pSfwdHhLx2or8yQZIaronb7nBOF+6PgvSUmT6HS8TH3Cq1JWiv7swbzvgaSBbT0vDeAc1l
	Ae8wxhITqQ1Aqj9enZdxjnvyHTNt4IPKhPHIjZjh2Sq25y1DI4Rn0ntRyMtL+99MB+GRpWHLQSOf7
	rkWIwyPZxjjtJRuV9wIe3o1ocRyXnOkXPJVGlojASgmso1yuc52vgV8G3z8hHchi61V0IbazKtjqQ
	U4WjqRO0o7/OM8U2qrjAzhS0IvKfFwnm10tdJHgCSfgfpgprTNNiui6rXdUhZq4nl3panzDROTxkD
	NcL+ztUo43rYTLHACpXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qrcIL-005FPu-0e;
	Sat, 14 Oct 2023 10:54:57 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qrcIH-005FOH-1W;
	Sat, 14 Oct 2023 10:54:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DD5DD60686;
	Sat, 14 Oct 2023 10:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F994C433CD;
	Sat, 14 Oct 2023 10:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697280892;
	bh=OoujLaw6rocLtMAHQyTp6llYUxnsAujLu8prfeuatAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UtecYPhaN4aqgCnBJW7qTsSPlBxit9sARXDoPhSf1Kk/GmGEQL1VeSFxnbFYXGR18
	 u+p7kw1QNI0C9x3aIg2T/wSAIadl7XRd5hUY0wLRsExPzb0guUueXGu9RkQVaBhvRV
	 zphn5f2Wt3FAYsybHa2AMZv/ooCqs+ueq6ulGcgEEPjUxXVBPK9HHTpxYvk6TQncWR
	 +j34lmP2hzWulD6XT6fQSpG1bGA9yQR8qCHpoe/n2KA7XHY5nA52+jl/L4LOKE4CIK
	 /xfhPoGdoZ1roeUF2VxKtsLaCHpbzU6AkM6N/KfVO/gqL0XnoThuJVRWM+k4R6By6U
	 WdcHO6wmtsxKg==
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
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 2/2] kbuild: unify no-compiler-targets and no-sync-config-targets
Date: Sat, 14 Oct 2023 19:54:36 +0900
Message-Id: <20231014105436.2119702-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231014105436.2119702-1-masahiroy@kernel.org>
References: <20231014105436.2119702-1-masahiroy@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231014_035453_550135_98332B03 
X-CRM114-Status: UNSURE (   7.90  )
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
it no longer needs a compiler, making no-compiler-targets the same
as no-sync-config-targets.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - Revive need-compiler flag

 Makefile | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 1ae5d5180f20..fed9a6cc3665 100644
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
 
@@ -298,18 +293,14 @@ ifneq ($(filter $(no-dot-config-targets), $(MAKECMDGOALS)),)
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
 	endif
 endif
 
+need-compiler := $(may-sync-config)
+
 ifneq ($(KBUILD_EXTMOD),)
 	may-sync-config :=
 endif
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
