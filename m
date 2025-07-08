Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62F2C83F0F
	for <linux-um@archiver.kernel.org>; Tue,  8 Jul 2025 09:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xPI/XtKDt29DUO242RKrOheIJMmYdwAzsux+8PBoE/k=; b=Npa/N/Szneiv5U8CRRJ44pGkV9
	dx6qS9dkICBF4PpgE061IgzmSSCfC+C9UuDd5NkAoqoNkcrLLAF3+iA3m9OE/0D7pNhkVZRXolBnd
	FDpBjz3Gt4Fsfoig0ZzMCOebAhDuQYPcKFhXXdBg5SGqnz82CvdXrv9hHoIwvE+QxGeu+G6crh1/g
	+6+O+KOpNQFPDkmClvZN1jFts0R1pgbtDoVX2A4Mr3r06bo8CLcvgXyudo5528CUzCW2/87ClRhg8
	1fshRxtxPVNq4gG1Jm56l7oo6vTLgcX+/1xLhKKHcFtnDSl1O/tsaRPmWORz1SLcOQiGtyck+Gg5s
	14aGSZpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ4v4-00000004vWv-1bRK;
	Tue, 08 Jul 2025 09:47:22 +0000
Received: from out-179.mta1.migadu.com ([2001:41d0:203:375::b3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ4Fh-00000004qMo-1bgR
	for linux-um@lists.infradead.org;
	Tue, 08 Jul 2025 09:04:38 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751965474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xPI/XtKDt29DUO242RKrOheIJMmYdwAzsux+8PBoE/k=;
	b=Fi+UAev7saeKUxjwAdxJd6MsDMFUSiB7Kc6gFogYxwpaCKpzzt0qvKh/G37RABuU72mCQR
	luh0ZzsvzkKriAubTVewnk6VA2yFkUwAmpN+TtjADfC+fHaHdexjf/IR/jkDa/HyY6paGt
	bd5qhYW7r39+Ui8G8APLvZzi7DsueHg=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH 2/4] um: Make mm_list and mm_list_lock static
Date: Tue,  8 Jul 2025 17:04:01 +0800
Message-Id: <20250708090403.1067440-3-tiwei.bie@linux.dev>
In-Reply-To: <20250708090403.1067440-1-tiwei.bie@linux.dev>
References: <20250708090403.1067440-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250708_020437_575668_22CA3297 
X-CRM114-Status: UNSURE (   7.85  )
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

They are only used within mmu.c. Make them static.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/skas/mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index 849fafa4b54f..afe9a2f251ef 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -20,8 +20,8 @@
 /* Ensure the stub_data struct covers the allocated area */
 static_assert(sizeof(struct stub_data) == STUB_DATA_PAGES * UM_KERN_PAGE_SIZE);
 
-spinlock_t mm_list_lock;
-struct list_head mm_list;
+static spinlock_t mm_list_lock;
+static struct list_head mm_list;
 
 int init_new_context(struct task_struct *task, struct mm_struct *mm)
 {
-- 
2.34.1


