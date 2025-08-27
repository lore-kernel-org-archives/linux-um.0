Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF68CA0FF7
	for <linux-um@archiver.kernel.org>; Wed, 27 Aug 2025 00:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/5Rya+Gi6QjQkA4vrw0G7aYifLN/Ov6WOyx29bWPJI8=; b=v+ZCuwzk6xYLhyC30H7/Afr5Di
	jEJZeVNv/w50J1yJm/9xToYtMsMbfWzFXigGnFL5+g+kWIwgajovdmb9APbbajFxRA77OZ2uinA+3
	bhz6E4y5m8DJH56cSIRzogg53glN/u6uldloK5pZGnMDoP4XdqKzpnxbP34SWde58oYnemhMI4UEz
	OcoNdLyBd3q6J4y5Ct/R+kHYuznsTTGiZ2dreafD/qgAgh11BE44D4cD9FfWBG6v61AHcWzEqW3eW
	uIzAcUIoG94KK+33gsUeIlWdCWZj4bdDAvCcOeWcrSnimZ4jdo467yJJhdA5H8d30Lvsks0YvbqKg
	zzwI08qA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ur4Tv-0000000DTUM-3yls;
	Wed, 27 Aug 2025 00:57:43 +0000
Received: from out-170.mta1.migadu.com ([95.215.58.170])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ur4Tt-0000000DTQV-2nGd
	for linux-um@lists.infradead.org;
	Wed, 27 Aug 2025 00:57:43 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756256259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/5Rya+Gi6QjQkA4vrw0G7aYifLN/Ov6WOyx29bWPJI8=;
	b=kaMGsOIBlB/cpgWM20gKKQjW3jkO+5Q8717Bz67qEAl6OmdqAiIID4q5MSpE0tVbjXRDXx
	gNqkh+S3TM8GmOU48uQgvjU03IuI3ueiIDir+PtOg3CFfkIBjFYgtekpiU8ip0wtVNo63D
	FWpUNO3ref1nyICWg8B1Ocw8asuFwMI=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH v2 6/7] um: Remove outdated comment about STUB_DATA_PAGES
Date: Wed, 27 Aug 2025 08:57:02 +0800
Message-Id: <20250827005703.3847636-7-tiwei.bie@linux.dev>
In-Reply-To: <20250827005703.3847636-1-tiwei.bie@linux.dev>
References: <20250827005703.3847636-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250826_175741_853195_E0A2DB51 
X-CRM114-Status: UNSURE (   8.73  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Tiwei Bie <tiwei.btw@antgroup.com>

STUB_DATA_PAGES is no longer required to be a power of two since
commit 91f0a0c5cc5b ("um: Calculate stub data address relative to
stub code"). Remove the outdated comment.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/shared/as-layout.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/include/shared/as-layout.h b/arch/um/include/shared/as-layout.h
index 2f9bfd99460a..eacf18ec9d0c 100644
--- a/arch/um/include/shared/as-layout.h
+++ b/arch/um/include/shared/as-layout.h
@@ -23,7 +23,7 @@
 #define STUB_START stub_start
 #define STUB_CODE STUB_START
 #define STUB_DATA (STUB_CODE + UM_KERN_PAGE_SIZE)
-#define STUB_DATA_PAGES 2 /* must be a power of two */
+#define STUB_DATA_PAGES 2
 #define STUB_END (STUB_DATA + STUB_DATA_PAGES * UM_KERN_PAGE_SIZE)
 
 #ifndef __ASSEMBLER__
-- 
2.34.1


