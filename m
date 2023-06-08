Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11BFC7EE29
	for <linux-um@archiver.kernel.org>; Thu,  8 Jun 2023 14:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uvzsWWBLE3FGktRNDH2+cKbCbZhAxgP5xLFgEFU2drU=; b=RIemeb1KsjDUB7
	O74AbjXL3gLhKVtLO21FGeGkXqmZgvzBWGPd8z8yLoM+2ClMQt1mlJ1X9lf6+laLH92tVN0iXE345
	JI3kEm+lxTwfr6z0z74oHAJ1uiEmWnW2dBYCPZDKHBjPtNdLieVOw46lLnUXIWqcTXh8oUyvynh2Q
	rlr3GuzVmpFYlLLhEnVk9Rwa/ipjITd531p8V1Hr1813BUz4wnIV2cRGDNKx2wdLVEg2Aa/WB4Wni
	TPSAFMwKVvhjCPWKkuuMHIWnlKD3dlQ7N5wOinvpBbhn7WL5S1zttZ8SxRsP9R7cWCtuQ9FOjE/p7
	iPUfwyrW3ke7ms/s6zlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7GZC-009cBk-1s;
	Thu, 08 Jun 2023 14:24:46 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7GZA-009cAS-1l
	for linux-um@lists.infradead.org;
	Thu, 08 Jun 2023 14:24:45 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2289864E1D;
	Thu,  8 Jun 2023 14:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452D2C433D2;
	Thu,  8 Jun 2023 14:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686234283;
	bh=zr+yJCwaIX4mMIACmjYkguIW6MMvumzYzdZSlBPO+AQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cKuOBnr9Iq/1ae8awIyi/rOQLVs36xIlGEDNSNCiE6fBszHLVJvysXTelpQ5LsXAW
	 MtquvFidmwc2giAJVjsa0GgMwyk9V5vR669ZCsa4Rc30HYQwzLfbn2+BRfYcl21i8z
	 yjvG/0wjaNEVXQcb0QLmCy5NVbCBcxJ/Vkk7FhTkKOnr2CULRqZuRSkMWSgepQPZt3
	 JGhrSSoHWzF4vTDpC7kyT9H7xUaFGxj+a/YGjV7Lrh8Nxd0x14wx9UvTOP/JQ4x11M
	 XFBkU26jb/qTgPwi5mRmv6/GWfilsfZ6hbCM2gp2kL96h4YwPRQfWWPan8NjBlg9R3
	 uXek3TDhjeBWA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-um@lists.infradead.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v7 04/11] ia64,export.h: replace EXPORT_DATA_SYMBOL* with EXPORT_SYMBOL*
Date: Thu,  8 Jun 2023 23:24:21 +0900
Message-Id: <20230608142428.256985-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230608142428.256985-1-masahiroy@kernel.org>
References: <20230608142428.256985-1-masahiroy@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230608_072444_624491_88B64F7F 
X-CRM114-Status: UNSURE (   9.48  )
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

With the previous refactoring, you can always use EXPORT_SYMBOL*.

Replace two instances in ia64, then remove EXPORT_DATA_SYMBOL*.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

 arch/ia64/kernel/head.S      | 2 +-
 arch/ia64/kernel/ivt.S       | 2 +-
 include/asm-generic/export.h | 3 ---
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/ia64/kernel/head.S b/arch/ia64/kernel/head.S
index f22469f1c1fc..c096500590e9 100644
--- a/arch/ia64/kernel/head.S
+++ b/arch/ia64/kernel/head.S
@@ -170,7 +170,7 @@ RestRR:											\
 	__PAGE_ALIGNED_DATA
 
 	.global empty_zero_page
-EXPORT_DATA_SYMBOL_GPL(empty_zero_page)
+EXPORT_SYMBOL_GPL(empty_zero_page)
 empty_zero_page:
 	.skip PAGE_SIZE
 
diff --git a/arch/ia64/kernel/ivt.S b/arch/ia64/kernel/ivt.S
index d6d4229b28db..7a418e324d30 100644
--- a/arch/ia64/kernel/ivt.S
+++ b/arch/ia64/kernel/ivt.S
@@ -87,7 +87,7 @@
 
 	.align 32768	// align on 32KB boundary
 	.global ia64_ivt
-	EXPORT_DATA_SYMBOL(ia64_ivt)
+	EXPORT_SYMBOL(ia64_ivt)
 ia64_ivt:
 /////////////////////////////////////////////////////////////////////////////////////////
 // 0x0000 Entry 0 (size 64 bundles) VHPT Translation (8,20,47)
diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
index 0ae9f38a904c..570cd4da7210 100644
--- a/include/asm-generic/export.h
+++ b/include/asm-generic/export.h
@@ -8,7 +8,4 @@
  */
 #include <linux/export.h>
 
-#define EXPORT_DATA_SYMBOL(name)	EXPORT_SYMBOL(name)
-#define EXPORT_DATA_SYMBOL_GPL(name)	EXPORT_SYMBOL_GPL(name)
-
 #endif
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
