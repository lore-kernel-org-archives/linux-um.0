Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8945EB3643
	for <linux-um@archiver.kernel.org>; Mon,  2 Mar 2026 23:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FkptubsbMN2kFGRFA+VsroS0jif2I3YZfw/zNCflvo0=; b=3LKmnCzbJ3uald4rprVeGj0GQm
	1RoPwJRAbflTwpPaXS6HBu55QbmdZkJ+sMT75KRIRY7meIBXcKehkplgbJBWXpYk3gWe7tWkQF4mJ
	5F5i64avwwKp1gutsyR/qFkVFmYj4Zy9XDqCbsFQ4vPXdKJ0NjCC7T4B7JEcjqlh4ZHhNVdD63WhQ
	wfhYKsoOAalSkCbdrqAgiYMi49ho7RHikGBbcoe+zL9QUSDEDH0sL/kymzrIMA9McSst/c3Wh908Z
	ro7cEm8qcpDX0KGpT79BjW6u4ZpsHcy8Ib5pOxe8dLaOeDB4p3Ak2g0rrioxEmZftNGaPdVjrWqjw
	jwmj7ijQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxD4V-0000000EEQb-0tod;
	Mon, 02 Mar 2026 23:53:07 +0000
Received: from out28-196.mail.aliyun.com ([115.124.28.196])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxD4R-0000000EEPF-1a0s
	for linux-um@lists.infradead.org;
	Mon, 02 Mar 2026 23:53:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1772495576; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=FkptubsbMN2kFGRFA+VsroS0jif2I3YZfw/zNCflvo0=;
	b=CmPSXlDUasvr5YZhw/BRybVLQgF5du/5IlSytgaYETgm4Cm6lBzNcPdlVYnZ5Wh+bnKOPfMqn5/6NwlXoRHWsqJHqrd2AgUMb0Nd7VqtQX8VaUOx6Q2cmeWClD4cVZ6iHBRo2aY9f7kBvHX8Fojy4+w446Zo1T2ESMJdNlVN18g=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.gj968m8_1772495573 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 03 Mar 2026 07:52:53 +0800
From: Tiwei Bie <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	Tiwei Bie <tiwei.btw@antgroup.com>
Subject: [PATCH 1/2] um: Fix potential race condition in TLB sync
Date: Tue,  3 Mar 2026 07:52:23 +0800
Message-Id: <20260302235224.1915380-2-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302235224.1915380-1-tiwei.btw@antgroup.com>
References: <20260302235224.1915380-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_155303_917275_3BBB3E4F 
X-CRM114-Status: UNSURE (   8.45  )
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

During the TLB sync, we need to traverse and modify the page table,
so we should hold the page table lock. Since full SMP support for
threads within the same process is still missing, let's disable the
split page table lock for simplicity.

Fixes: 1e4ee5135d81 ("um: Add initial SMP support")
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/tlb.c | 1 +
 mm/Kconfig           | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 39608cccf2c6..5386ab2d0da5 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -165,6 +165,7 @@ int um_tlb_sync(struct mm_struct *mm)
 	unsigned long addr, next;
 	int ret = 0;
 
+	guard(spinlock_irqsave)(&mm->page_table_lock);
 	guard(spinlock_irqsave)(&mm->context.sync_tlb_lock);
 
 	if (mm->context.sync_tlb_range_to == 0)
diff --git a/mm/Kconfig b/mm/Kconfig
index ebd8ea353687..befa8909ae29 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -572,6 +572,7 @@ config SPLIT_PTE_PTLOCKS
 	depends on !ARM || CPU_CACHE_VIPT
 	depends on !PARISC || PA20
 	depends on !SPARC32
+	depends on !UML
 
 config ARCH_ENABLE_SPLIT_PMD_PTLOCK
 	bool
-- 
2.34.1


