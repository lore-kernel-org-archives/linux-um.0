Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7A5C41513
	for <linux-um@archiver.kernel.org>; Fri, 21 Jul 2023 17:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IayIu1Ev9Tskyphs/beyziSunaqDanCDLXzSxFzJmVY=; b=L5INUzvdyupS3V
	xeX4M7dsb+WW2BKkBxCKkAoO8nxqMD/kscqk3s81GyWF2zJXBo7FvcIjGq1x03akOfzA0u0lIdw1s
	uY/Wb4AYRzjC3hanlefsqPUwNdEkzcmNje4WiLi0Tlc7Pybjh3jFla4Wqg2vKH0sC88Q1ReXJA5fh
	Vcg56X/BHxO/K112oHUJGET13l5KrQG0tZDgYAtFj9jH0IuWkrB8EujpK98mMbvZLDHd12piHKS8T
	kg25sNJnclK8oqx1PukGpm98VRjVzvajdl+xA4Uf1VRGfmKw+A86bceE/bAmeap+g7UA+UF2y95ct
	Rb5/+KGpX0Uf+5H5Y/Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qMtme-00Ejxw-0H;
	Fri, 21 Jul 2023 17:19:16 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qMtmb-00Ejx4-1h
	for linux-um@lists.infradead.org;
	Fri, 21 Jul 2023 17:19:14 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9088361D5A;
	Fri, 21 Jul 2023 17:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9483CC433C9;
	Fri, 21 Jul 2023 17:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689959952;
	bh=ZR06M3d0gZKRb4qFO1k4EYXqLJ5GJPGsvI0z3w1cJFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rvNmnzl1Nwu+J/6xOdGaUdPqmOhwTHqfFaC3Xk7KzAE4rMXToL7/R3DzDEgIEkiyo
	 dortXv3BM//zgrIWSD06NieLEU6/Y6fYZ7qT1yqPpIqEgPeqF4NsGop3fc+INGGQCs
	 Y4gp+mQLcdjuI+ap/hA+6Is0i7ARKR2QuICuuoTZ0JuJTbqdwbkoXS94rGeihsiblC
	 b3nnNopcsvLnmco09z4Lw0nobnNtlC4yXVxtwv1ngJtdx4EDkgU0EP55zt/l/BrRiK
	 GzdA82oPy0L/zobquahYfr/Cn6YtJsm0JV+glig0tVHHxC3BSRNj5HcR9Dt2dmyDUY
	 RyMakPBm5ZESw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 2/2] UML: use obj-y to descend into arch/um/*/
Date: Sat, 22 Jul 2023 02:18:57 +0900
Message-Id: <20230721171857.3612639-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230721171857.3612639-1-masahiroy@kernel.org>
References: <20230721171857.3612639-1-masahiroy@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230721_101913_606353_ACEE1737 
X-CRM114-Status: GOOD (  11.12  )
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

The single build rule does not work with the core-y syntax. [1]

Use the standard obj-y syntax.

[1]: https://lore.kernel.org/linux-kbuild/d57ba55f-20a3-b836-783d-b49c8a161b6e@kernel.org/T/#m7bc402e1e038f00ebcf2e92ed7fcb8a52fc1ea44

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - Rephase the commit log

 arch/um/Kbuild   | 2 ++
 arch/um/Makefile | 4 ----
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/um/Kbuild b/arch/um/Kbuild
index a4e40e534e6a..6cf0c1e5927b 100644
--- a/arch/um/Kbuild
+++ b/arch/um/Kbuild
@@ -1 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+obj-y += kernel/ drivers/ os-Linux/
diff --git a/arch/um/Makefile b/arch/um/Makefile
index 1735a562453d..82f05f250634 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -22,10 +22,6 @@ ARCH_DIR := arch/um
 # features.
 SHELL := /bin/bash
 
-core-y			+= $(ARCH_DIR)/kernel/		\
-			   $(ARCH_DIR)/drivers/		\
-			   $(ARCH_DIR)/os-Linux/
-
 MODE_INCLUDE	+= -I$(srctree)/$(ARCH_DIR)/include/shared/skas
 
 HEADER_ARCH 	:= $(SUBARCH)
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
