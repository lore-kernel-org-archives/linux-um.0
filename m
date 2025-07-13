Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5CDC83F1D
	for <linux-um@archiver.kernel.org>; Sun, 13 Jul 2025 17:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uLSAZKc65C9rkSXpEwQXimN17KS5t738kD/ThmzTdvw=; b=xwQQyP4t1jL/OsrTileWecXoIz
	agSDwd2gGxY7TBSR33+xoqUt58pDUDmMLyOq1rfv6hNaiyEb0f5uSFLNeA5/4KO7hvRHGRoeIVI+Z
	5yG9JzMe2FoBWvotYsRcN4MoPddAwH8T/5tNp3YUG3WE9PHlFbIsAE+HoH4dEAA2y1+B+jKYyq3Y2
	m0lnofpMVcyeJV70RX5jFpTKQaQmkQzUaT+JDnQjQBLcuDCSxGHO1RVUEW1W21HB9EvaxaTxIMJnk
	3ykrKNP1HSJYeuyzqN9mUf/M0YN8jr+OJK7iEFh5m5JedCoDFhH/PBXian5xaCrTFqowOiwP8/1bk
	VLyS430Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ub0Ux-00000000RV5-1Azu;
	Sun, 13 Jul 2025 17:28:23 +0000
Received: from out-186.mta1.migadu.com ([2001:41d0:203:375::ba])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ub0Uu-00000000RKu-3VlB
	for linux-um@lists.infradead.org;
	Sun, 13 Jul 2025 17:28:22 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752427559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uLSAZKc65C9rkSXpEwQXimN17KS5t738kD/ThmzTdvw=;
	b=AScwEQ4GPiyltyokJcSDieDTuOlICPzicJhcpl5OtHP2icIdrXtRH0st66B/7zyQ6DUmmt
	XbQZeQBtnT5k/HIsLLx/5jkH3HfHLXEJmMGEiWwQ6egbEBehUIiS0VYuu+C7yA0rz4syzy
	FreHuKi8rDBP2Bk7AWNK9yTl6mS7AqM=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [RFC PATCH 1/4] um: Stop tracking virtual CPUs via mm_cpumask()
Date: Mon, 14 Jul 2025 01:25:33 +0800
Message-Id: <20250713172536.404809-2-tiwei.bie@linux.dev>
In-Reply-To: <20250713172536.404809-1-tiwei.bie@linux.dev>
References: <20250713172536.404809-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250713_102821_031302_3A924FCE 
X-CRM114-Status: UNSURE (   6.50  )
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

In UML, each user address space is represented as a separate stub
process on the host. Therefore, user address spaces do not require
TLB management on UML virtual CPUs, and it's unnecessary to track
which virtual CPUs they have executed on.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/asm/mmu_context.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_context.h
index 0bbb24868557..c727e56ba116 100644
--- a/arch/um/include/asm/mmu_context.h
+++ b/arch/um/include/asm/mmu_context.h
@@ -13,20 +13,9 @@
 #include <asm/mm_hooks.h>
 #include <asm/mmu.h>
 
-#define activate_mm activate_mm
-static inline void activate_mm(struct mm_struct *old, struct mm_struct *new)
-{
-}
-
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, 
 			     struct task_struct *tsk)
 {
-	unsigned cpu = smp_processor_id();
-
-	if (prev != next) {
-		cpumask_clear_cpu(cpu, mm_cpumask(prev));
-		cpumask_set_cpu(cpu, mm_cpumask(next));
-	}
 }
 
 #define init_new_context init_new_context
-- 
2.34.1


