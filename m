Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D600C636D3
	for <linux-um@archiver.kernel.org>; Sun, 12 Feb 2023 19:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=bfLgjH2fy0DkkdVekNpHikl862XFnCbp+csEl/8YpA0=; b=D8ECWmIwuxY71N
	9HLU83+43kbalmmaJqaKMPegfWoNXYEQyk2160rpPc2/71FNZsQxdIr9sIsfewaAJ+fvo9/ug6eHk
	8fj6YPTEEgafCoMgtBxMe02H5Aj4lv3ztPF/zCuN2EsvBjCHjIG3hq/VyQCzh6IVX0bm+7bFHikKM
	XyFMhsKTji1inbNXYtMc5jjrqT0GpoAs6vKn4flmCzUgsySM0lDVdRvBxAvXHL7sIutP9TbiiwheK
	jwhn4v2X0sHmk7GFVUzFymTsBtl8JO9pdQ+wTKmeCAUHnHPtnnlX8nd2Tqh/wQ9tyMbjHEDGAA4k9
	1M2HPQtewabmKnhPAfNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRI5C-00CCJd-KK; Sun, 12 Feb 2023 19:32:18 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRI59-00CCIz-76
	for linux-um@lists.infradead.org; Sun, 12 Feb 2023 19:32:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=R1MLzvLe5CV5nU+L2/cOro/VsTN15kpqX/guAqaFprs=; t=1676230332; x=1677439932; 
	b=OYJiVYn7cYf/g+oLsdkIgdEsnxazIWx9PsWAL396c7SchUu+8d4kyXLx4uf41Rh5OdcX4UNKcYY
	Ic9tqQMGTQ6fFUse7x3Bnsb0cvHKORiaZ1Fuh9ji28YbmIzqBQC38vRlgbe5pQcd3UTV0HkG/dUPw
	fb1crusy50nIiMROrNP4V0ubymypUQuCadPl8gk1LBT29WxeaJqkLrwUOvqBSctHVRe3/+vyEFgVU
	/evlThIfBPEOE9cCUL6EtYJI3g1Y9nL8eSuE6xTiebA7mmusk3pOONJ8saDwhbG5GgNVx8L6HgVfU
	WlZS2gn00ozsGzOcfefmKb9U+RCRhvLUSm/w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1pRI51-00AJZL-28;
	Sun, 12 Feb 2023 20:32:07 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] um: add __weak for exported functions
Date: Sun, 12 Feb 2023 20:32:04 +0100
Message-Id: <20230212203204.34cef454b288.I409a7567fcf846cd8f79e7788eb8c8869547463e@changeid>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230212_113215_281000_DAA1D3B7 
X-CRM114-Status: UNSURE (   9.04  )
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

From: Johannes Berg <johannes.berg@intel.com>

If the exported glibc functions don't exist, we get link
failures. Avoid that by adding __weak so they're allowed
to not exist.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/os-Linux/user_syms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/os-Linux/user_syms.c b/arch/um/os-Linux/user_syms.c
index fd575ecbcaec..54722c7f884f 100644
--- a/arch/um/os-Linux/user_syms.c
+++ b/arch/um/os-Linux/user_syms.c
@@ -39,7 +39,7 @@ EXPORT_SYMBOL(printf);
  * good; so the versions of these symbols will always match
  */
 #define EXPORT_SYMBOL_PROTO(sym)       \
-	int sym(void);                  \
+	int sym(void) __weak; \
 	EXPORT_SYMBOL(sym);
 
 extern void readdir64(void) __attribute__((weak));
-- 
2.39.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
