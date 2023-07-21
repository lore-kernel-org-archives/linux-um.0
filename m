Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43ADEB64DC
	for <linux-um@archiver.kernel.org>; Fri, 21 Jul 2023 13:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nHIWvQwizODAkD804BO4HNucym3wy3DYjA3xXloKwyk=; b=VET8EW/mNhODkr
	6+XLj4SpSpJmmZT163ZF5aRc3QPYE07q9gCdOYtpdOuo2kLSHTlX0Y3qu7p86sUrthUNBznM4+pHT
	vKU9CzuZZB7yFOf7bYoGGRbcArsDO5NY+q6KBOBGcKI1NyfZZzoF2uBquYS07mQRE0ejAgFfeU+E5
	2NXi3w7+ykpV8MSWTVOIcxP8nuPSCSvg6tqNvsK18PdleURKdplIN8t4r8MDSOMy8qgR748T18WkX
	Am0w2VniQavPguxb9X7yjR2/hRirJqNlvh6p4VkM6FobLQxPYAQfryM+wZYlu8lYcJ9iE+mr4esyt
	wNvV8JhXZGRl/ea5iVMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qMqSL-00EBCh-1x;
	Fri, 21 Jul 2023 13:46:05 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qMqSI-00EBBQ-0n
	for linux-um@lists.infradead.org;
	Fri, 21 Jul 2023 13:46:03 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 616BC61934;
	Fri, 21 Jul 2023 13:46:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664BAC433CC;
	Fri, 21 Jul 2023 13:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689947160;
	bh=7/8un7O0KbffM2Qk+6DZGKZkr/Uh/KXBMa5+rJ58feo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ry7vFJvp9lNVxfPbd1yKD9O3pf/xY0X8oj/sjYZZxkZOGwXmmCsHFnCs2sh9wZ75W
	 al6oCVkkwa41ZHvej0bfpAPg8v9tHWPGQS8k/qaGlIv/RIZu/3HbRNcF1orKpgrH3z
	 O51xW4dpN38f4BWnSRX+njUmECTN2RHeKwX26op1OWPfq38aLZVag4JwnI4w/zhwGZ
	 WnLJiYcs9F2UW69HNMM4+/VKenS2ysU3bNSsASrWYcZZMXAPmD6oGIGaVjOrld9ASH
	 lv9i2JWgWqSmMAhxk3k50WYI93Q4xQWaLkMEq7TOh4BXrUOEMHzrNTg4DRayDrUW5Y
	 sGSS3QEu8D9TQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/2] UML: use obj-y to descend into arch/um/*/
Date: Fri, 21 Jul 2023 22:45:48 +0900
Message-Id: <20230721134548.3438376-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230721134548.3438376-1-masahiroy@kernel.org>
References: <20230721134548.3438376-1-masahiroy@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230721_064602_323108_22068A82 
X-CRM114-Status: GOOD (  10.71  )
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

I like to use obj-y in as many places as possible.

Change the core-y to obj-y. It fixes the single build issue. [1]

[1]: https://lore.kernel.org/linux-kbuild/d57ba55f-20a3-b836-783d-b49c8a161b6e@kernel.org/T/#m7bc402e1e038f00ebcf2e92ed7fcb8a52fc1ea44

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

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
