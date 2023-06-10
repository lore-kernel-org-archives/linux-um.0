Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1892BC7EE2E
	for <linux-um@archiver.kernel.org>; Sat, 10 Jun 2023 09:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tjSTFsWK4Rm2hpg4He2HOxeu1w3YLo22PuBZ+6hGAXs=; b=bmdK4Q3ulWPxFx
	eqGUZYkunOOxWKoXxRvQJT86jVCHdjO3JAAr4GaBQB35D82jWMwr7MXHd6VHi7GTGj3DjVVAjkXRW
	cXfyNPEH7ne8h2zx1chSz5CKPbpVAO55fBusI8GBuLgGC4or0tkAqbP/1LmIDBkTQbKAZqFKTFlj8
	7vNzys7YoP759NJLe+8i6lbfYmH12Mv5ku7eRa4QXazF5/8n6Q1eATuT6iv3zwgo8F0lJw91OdYKA
	rMJ8vFsGFUq0yHnh9ov1otpZ/neuxdHEAeiGqu11fXx93SxOjXlED9UoCo6LvZGScxcsmlfn14wy6
	b36q86WVS148VF6yDSxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7ufg-00FcrU-2O;
	Sat, 10 Jun 2023 09:14:08 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7ufd-00Fcps-24
	for linux-um@lists.infradead.org;
	Sat, 10 Jun 2023 09:14:06 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3340361EFC;
	Sat, 10 Jun 2023 09:14:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48329C433EF;
	Sat, 10 Jun 2023 09:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686388444;
	bh=xcoBBS4j2RIAWnyNGP0DVmJUBsQUOVbHeiB3BEvgdeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k5AyddC6WuJ2wCTIZvBnbcNAvKQ008GAVGl9rorjCUXw9Mslqnt50+r6RzzE7rq4Q
	 g0n5U82WFmlYSudoCvrhx99mRsHWbaIFy6SshHVyHZ+euh64J/Nj6qrDXxb7CIqx15
	 X0YlOH/uv10l9arls+EbM8wTnML3hStVenUMAOmbPztsR+zaR9RrYkuUBqiEybN5xL
	 jRTEX9pjEjF6hXPh0EvWooDO5IIaWyj1hpFAKtOuM+3hVPyT7JyLJTimDYpZHLKiio
	 0hfl/OtpmdwMHVuDW6Gwe++oD4+UbUeDq9Z0m0/UAU+h/vvjKYmIl2vJjph7Inl5kx
	 +l4dG9CQGI2bw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-um@lists.infradead.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v8 11/11] linux/export.h: rename 'sec' argument to 'license'
Date: Sat, 10 Jun 2023 18:13:20 +0900
Message-Id: <20230610091320.1054554-12-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230610091320.1054554-1-masahiroy@kernel.org>
References: <20230610091320.1054554-1-masahiroy@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230610_021405_754923_EE68D124 
X-CRM114-Status: GOOD (  11.65  )
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

Now, EXPORT_SYMBOL() is populated in two stages. In the first stage,
all of EXPORT_SYMBOL/EXPORT_SYMBOL_GPL go into the same section,
'.export_symbol'.

'sec' does not make sense any more. Rename it to 'license'.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

(no changes since v7)

Changes in v7:
 - New patch

 include/linux/export.h | 8 ++++----
 include/linux/pm.h     | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/export.h b/include/linux/export.h
index 8a9b72386fff..427f5517217f 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -51,11 +51,11 @@ extern struct module __this_module;
  * be reused in other execution contexts such as the UEFI stub or the
  * decompressor.
  */
-#define __EXPORT_SYMBOL(sym, sec, ns)
+#define __EXPORT_SYMBOL(sym, license, ns)
 
 #elif defined(__GENKSYMS__)
 
-#define __EXPORT_SYMBOL(sym, sec, ns)	__GENKSYMS_EXPORT_SYMBOL(sym)
+#define __EXPORT_SYMBOL(sym, license, ns)	__GENKSYMS_EXPORT_SYMBOL(sym)
 
 #elif defined(__ASSEMBLY__)
 
@@ -72,9 +72,9 @@ extern struct module __this_module;
 #endif /* CONFIG_MODULES */
 
 #ifdef DEFAULT_SYMBOL_NAMESPACE
-#define _EXPORT_SYMBOL(sym, sec)	__EXPORT_SYMBOL(sym, sec, __stringify(DEFAULT_SYMBOL_NAMESPACE))
+#define _EXPORT_SYMBOL(sym, license)	__EXPORT_SYMBOL(sym, license, __stringify(DEFAULT_SYMBOL_NAMESPACE))
 #else
-#define _EXPORT_SYMBOL(sym, sec)	__EXPORT_SYMBOL(sym, sec, "")
+#define _EXPORT_SYMBOL(sym, license)	__EXPORT_SYMBOL(sym, license, "")
 #endif
 
 #define EXPORT_SYMBOL(sym)		_EXPORT_SYMBOL(sym,)
diff --git a/include/linux/pm.h b/include/linux/pm.h
index aabb6bd8f89e..1810d776e84a 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -375,14 +375,14 @@ const struct dev_pm_ops name = { \
 }
 
 #ifdef CONFIG_PM
-#define _EXPORT_DEV_PM_OPS(name, sec, ns)				\
+#define _EXPORT_DEV_PM_OPS(name, license, ns)				\
 	const struct dev_pm_ops name;					\
-	__EXPORT_SYMBOL(name, sec, ns);					\
+	__EXPORT_SYMBOL(name, license, ns);				\
 	const struct dev_pm_ops name
 #define EXPORT_PM_FN_GPL(name)		EXPORT_SYMBOL_GPL(name)
 #define EXPORT_PM_FN_NS_GPL(name, ns)	EXPORT_SYMBOL_NS_GPL(name, ns)
 #else
-#define _EXPORT_DEV_PM_OPS(name, sec, ns)				\
+#define _EXPORT_DEV_PM_OPS(name, license, ns)				\
 	static __maybe_unused const struct dev_pm_ops __static_##name
 #define EXPORT_PM_FN_GPL(name)
 #define EXPORT_PM_FN_NS_GPL(name, ns)
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
