Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D93CCF9E0
	for <linux-um@archiver.kernel.org>; Mon, 27 Oct 2025 05:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FxS7WrzPthHseSwVk1g/bvJSy7E65J9mW8IbUJo4L2E=; b=FCnsacQQ4XKFV9iAsih73FemYH
	KC7MDBcqDAwk6Nex6vPf25R1dnEGzdvYdnjRjIK4hXe7NRFIUU4Bm9Ty1Yvi7dcvoRMmg8BwOJnbw
	M87xFLF3uEXBUHZQDLKqZ55P2tRs6L10QC60sEZ6woWfJyjIciQIwnEEEyMdG7/inu7b1WblMDzQ5
	pGFjnfI3f2QTH1icycC2KfLcrd/BBj0d4LeZG+r5p3I188czdY+P5JleVC4vHPXziKBS1V6B+ZXCy
	E3dufSZJyHdxbdaaQHwt7r63iU7i5zEJlhCpWaBaPvceT/GuF8AkUD4LPwHIUJUzqTlVbtiaPUCHu
	Nlb+0JZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDG3T-0000000D8mP-0z5M;
	Mon, 27 Oct 2025 05:46:07 +0000
Received: from out-177.mta1.migadu.com ([95.215.58.177])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDG3N-0000000D8kX-3Lrs
	for linux-um@lists.infradead.org;
	Mon, 27 Oct 2025 05:46:04 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761543959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FxS7WrzPthHseSwVk1g/bvJSy7E65J9mW8IbUJo4L2E=;
	b=P/eh915Hr0m51FcHAmcgUNPt+K8fbvP3ogMYtyImtOrYM1OkueqXXfXUmnzk45cAEva5AV
	x4dYz3ZTvvAZszkb6wWEZORLCMHTZfJ34cvQcgK8/Ar30q1efCttTBeEEQupAUGk9nJik1
	Yjy7I7eHbaNWHlZFFTEWJ3S5e1NoqBk=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH v2 2/4] um: Use PAGE_ALIGN() for address alignment
Date: Mon, 27 Oct 2025 13:45:17 +0800
Message-Id: <20251027054519.1996090-3-tiwei.bie@linux.dev>
In-Reply-To: <20251027054519.1996090-1-tiwei.bie@linux.dev>
References: <20251027054519.1996090-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251026_224602_096450_8B40FC9D 
X-CRM114-Status: UNSURE (   8.12  )
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

Use PAGE_ALIGN() instead of open-coded calculations.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/um_arch.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 5b982031e5ae..c54d5ed91bb8 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -296,10 +296,7 @@ static unsigned long __init get_top_address(char **envp)
 			top_addr = (unsigned long) envp[i];
 	}
 
-	top_addr &= ~(UM_KERN_PAGE_SIZE - 1);
-	top_addr += UM_KERN_PAGE_SIZE;
-
-	return top_addr;
+	return PAGE_ALIGN(top_addr + 1);
 }
 
 int __init linux_main(int argc, char **argv, char **envp)
@@ -368,8 +365,8 @@ int __init linux_main(int argc, char **argv, char **envp)
 
 	setup_machinename(init_utsname()->machine);
 
-	physmem_size = (physmem_size + PAGE_SIZE - 1) & PAGE_MASK;
-	iomem_size = (iomem_size + PAGE_SIZE - 1) & PAGE_MASK;
+	physmem_size = PAGE_ALIGN(physmem_size);
+	iomem_size = PAGE_ALIGN(iomem_size);
 
 	max_physmem = TASK_SIZE - uml_physmem - iomem_size - MIN_VMALLOC;
 	if (physmem_size > max_physmem) {
-- 
2.34.1


