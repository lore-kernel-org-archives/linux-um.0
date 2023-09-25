Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B40CD54BF
	for <linux-um@archiver.kernel.org>; Mon, 25 Sep 2023 19:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=LCmc3WnDbMZdaIrbKBgFRjkyPKAdRwpxKwrxGWS7ZJs=; b=0x7oPHlRJ/oYgA
	zaT4sEMeOg5/x68g4J3TsGL41wMQp0Jb0mY0q0/PWApKBl7JvWDiDKUUq/k8iWu31gSS9eXv18VPe
	qLt4KQh7NSobOmRoyBlYKifIhZy3/xuo3bAm+BiIEZMi8pJDwQQjX2rifMCxEtn/wzmsq55vEj/W4
	BX6Acj3imLxipJJx7wP0PJZueuLZlo0dOs+7I14T7V//KVpIrwHhxyUQNguWoJMqkE8ofJcXvpYuz
	iKH5/ZqwH7E4fMk3Z22N0KQ6s9ygGUCra5l3hdu5ZeDPu8z30RZRT16majBFqikrfiZ/2j+tM9NNt
	Dq7ZNDF98WmX1KrANh9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qkrHL-00EubO-0S;
	Mon, 25 Sep 2023 19:29:59 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qkrHH-00Eub2-2v
	for linux-um@lists.infradead.org;
	Mon, 25 Sep 2023 19:29:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=d9RpQyHJ0A2RmD4B2VlJOeZYf+/M9M/ld+5v37MpUyc=; t=1695670193; x=1696879793; 
	b=PtRrWMcJ18lcS9XU3/1oRQv7jCiIcqx2pA3SFMUUSTqvVFbSqmLD1TJi0Rlq9vllkoV9PDodw13
	jBhDDuqfdtnqlSc3vuvPkSISzeIVt75eHVMrq/b9qSxWpBHJrNcf7Bk/TyqAkJ2RKYTciz8KmRxOc
	dQ1o2z+9w3wTxZIYgsIZ9BWnKVE2R5WAJFC+kHHJkmrk2jfEbkADo51EvrkYf+nTYf0ZFaeBzl3UH
	ArACHxpX7+6256oKntM6pfHtt6ifR323F8lwC7c+2Z4iex2oK/ppfcAMp/Yj0hV293KX5NV+daDHH
	gQQvzUmD5gBbyu5h7fACWQd+x4Hb1HNmsXbg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qkrHC-003zeY-1D;
	Mon, 25 Sep 2023 21:29:50 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] um: mmu: remove stub_pages
Date: Mon, 25 Sep 2023 21:29:48 +0200
Message-ID: <20230925212947.5282dbcce46a.I6664f7569847ae3b61cf3ed4fbee087b5108fac6@changeid>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230925_122955_963821_2459626D 
X-CRM114-Status: UNSURE (   8.72  )
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

I removed all the users of this some time ago, but
evidently forgot the pointers. Remove them from the
data structure too.

Fixes: bfc58e2b98e9 ("um: remove process stub VMA")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/asm/mmu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/um/include/asm/mmu.h b/arch/um/include/asm/mmu.h
index 5b072aba5b65..a7555e43ed14 100644
--- a/arch/um/include/asm/mmu.h
+++ b/arch/um/include/asm/mmu.h
@@ -12,7 +12,6 @@
 typedef struct mm_context {
 	struct mm_id id;
 	struct uml_arch_mm_context arch;
-	struct page *stub_pages[2];
 } mm_context_t;
 
 extern void __switch_mm(struct mm_id * mm_idp);
-- 
2.41.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
