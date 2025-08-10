Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837C3C87FCA
	for <linux-um@archiver.kernel.org>; Sun, 10 Aug 2025 05:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uLSAZKc65C9rkSXpEwQXimN17KS5t738kD/ThmzTdvw=; b=ddBG1fN4zL/LchyYXJ7UjuxvAY
	yhv4AKyfEZ63i1TWXK/GJq+VorQnDHQ6RVpTlrn4tRAUaPM4/PDqraDLz6xbcIPsl14aOFB+jfr9Z
	3uXLDMc6YMMOYkDasIDs+PEFF0u9ji5qVcwo01dX2s5+vL3OKJjvlT0sepbERFLMqfdJ9EGzIZv/r
	d4CcKmQwyzX1d+AR9hQ++BhoYgyaL50RXKCRI08Zj56BIvVcUOTPwh5s29ikln6wuyVlob0CST0nk
	zuOz0ej/yc9Q5RIQMMDtQR2FdQCdeqtnZWgdT4U1cNBtEb74N2D6Ktx/8XNMH4j2e+QZyUZ4OytFZ
	uLUZEX4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukyyX-00000005IJt-3Lw4;
	Sun, 10 Aug 2025 05:52:09 +0000
Received: from out-171.mta0.migadu.com ([2001:41d0:1004:224b::ab])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukyyU-00000005IJ1-0T1z
	for linux-um@lists.infradead.org;
	Sun, 10 Aug 2025 05:52:07 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754805121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uLSAZKc65C9rkSXpEwQXimN17KS5t738kD/ThmzTdvw=;
	b=NuvDoYpVC6GiDVJH2FqPfYWx3LWJQCHjcjBKhZIRwf6v6xEwfN7JDyYVA0IUEC3mNtFCE5
	siSXP95bweGMREdGX3FduJTx+dyJzaRJ++unYefCSFmslFTTkcU9SrsXVoewchqNUALOLy
	f4eo3zPBNaDB6vBDJfsJ4H/u8Tt1u64=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	benjamin@sipsolutions.net,
	arnd@arndb.de,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH v2 01/10] um: Stop tracking virtual CPUs via mm_cpumask()
Date: Sun, 10 Aug 2025 13:51:27 +0800
Message-Id: <20250810055136.897712-2-tiwei.bie@linux.dev>
In-Reply-To: <20250810055136.897712-1-tiwei.bie@linux.dev>
References: <20250810055136.897712-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250809_225206_759200_7AE04D4A 
X-CRM114-Status: UNSURE (   6.45  )
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


