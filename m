Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07D0C8300C
	for <linux-um@archiver.kernel.org>; Thu,  8 Jun 2023 14:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MpqQwT6lYbte2huW9CvSApBGIFuYZ3gACLF4SliQlkQ=; b=dSPOzX3I+m8TOu
	0HijRZiqBxzMD71IblqHwjg7JSApzO9H3sLuYvHGSUKQ1hugimGU53NfDbrQbrZPWbD2V4+vphVWH
	S2z2dfwjxB9ivigBweTg81i0Qx2YAHdGeVbZCxf85PCqcO6qAsGKcgTkfn6hF481aBWlo+52FqkSs
	F+ZnEYqKWBPp0Wb3Z7icOB9oF9v2ZQwLNDdEx6Z6f0aD/ZKVns39xRs90pzZILzcsTV9Qgxp+73UT
	/mI8NMUXjeS2GviFOuI9BKbJrZXFEtDrghR4hDldvs3RsA8iPJgjLKGOxCsO86v/lz/TMaaWzQBEK
	OTfyjkqo5axIkNfGL4Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7GZQ-009cL9-1b;
	Thu, 08 Jun 2023 14:25:00 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7GZM-009cIB-1J
	for linux-um@lists.infradead.org;
	Thu, 08 Jun 2023 14:24:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 06F4363CDC;
	Thu,  8 Jun 2023 14:24:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32260C433D2;
	Thu,  8 Jun 2023 14:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686234295;
	bh=W7P3iG4O3YjGApyRwNtiWKX5Kq+VmGX8uTvW8Ums99c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ntFv6gYKlgbdRwOlDg1ZciYIhnPhN2Yth0zSMBh1rlXZK4/QWKEvGYg1VqYJU7Q7Y
	 7kPowQgOC8uSdSuIVTPw8oBH0M1YSfJjTwNZPmE3GP7hQP++wMeo+yIOFshXSfOxWM
	 kmEdw4koner4TpL3XNp9u65JUDy2+93IeydEtbqQ6qHjVK+wsFMWA8O6UX3h4NtYdx
	 NHVPrlm87C9dMQoa0JsB8wSfS0xHgoDuGdYQKSt4dq7x2V5PMg5WMimbx42hWDuqHX
	 ibVrSlp+cCQLo4yDl8Ecy3T+AR9+MhywHQsT3hKNrWQiJ0Gz/6hniiRPANFG6WcLxk
	 Fh0DE3EZ2xB+Q==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-um@lists.infradead.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v7 11/11] linux/export.h: rename 'sec' argument to 'license'
Date: Thu,  8 Jun 2023 23:24:28 +0900
Message-Id: <20230608142428.256985-12-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230608142428.256985-1-masahiroy@kernel.org>
References: <20230608142428.256985-1-masahiroy@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230608_072456_523533_B4385213 
X-CRM114-Status: GOOD (  12.07  )
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
.export_symbol.

'sec' does not make sense any more. Rename it to 'license'.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v7:
 - New patch

 include/linux/export.h | 8 ++++----
 include/linux/pm.h     | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/export.h b/include/linux/export.h
index fed2e5717461..b411fdb88720 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -46,11 +46,11 @@ extern struct module __this_module;
  * be reused in other execution contexts such as the UEFI stub or the
  * decompressor.
  */
-#define __EXPORT_SYMBOL(sym, sec, ns)
+#define __EXPORT_SYMBOL(sym, license, ns)
 
 #elif defined(__GENKSYMS__)
 
-#define __EXPORT_SYMBOL(sym, sec, ns)	__GENKSYMS_EXPORT_SYMBOL(sym)
+#define __EXPORT_SYMBOL(sym, license, ns)	__GENKSYMS_EXPORT_SYMBOL(sym)
 
 #elif defined(__ASSEMBLY__)
 
@@ -67,9 +67,9 @@ extern struct module __this_module;
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
