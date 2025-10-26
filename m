Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A3ACCF9E9
	for <linux-um@archiver.kernel.org>; Sun, 26 Oct 2025 23:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HuBaBi7MEC/x8qwN/VRdjZ+F8E3nmLbiMXBqyR8TCKc=; b=uR/nR72xHQ+RLVvAYEqzdnNxP8
	utxkuzRKQ9TYeV1p7jyTQUTF+brhk+hHkM/JjhyiWrYouD6oFKb+5j62e4uH1gCwxbYt//Re+qyjT
	w/2M3Jg0x5OLiG4YvLlAUkCw/2bcsci+GKB2BrK1SiSCTYHxADExDJdorHIWZdWwHdIrSEiIyp+v+
	GcMSfQMytPyK6ksomtcwrYMNHHwtD/dVeif79eUc/AdhZh0fdwRBQ2G8J3863lFPsqawxj1pbu6Vl
	tzOyC4EUBeJd3i1hcY5OD0mLIB1asxLZOY2qYx0pvMJErd9DTq6OlW/+piMVA18dwjic0XiDGXrMn
	V2Xp5Leg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDAeT-0000000CsKl-1yVv;
	Sun, 26 Oct 2025 23:59:57 +0000
Received: from out-178.mta0.migadu.com ([2001:41d0:1004:224b::b2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDAeQ-0000000CsGz-2MgM
	for linux-um@lists.infradead.org;
	Sun, 26 Oct 2025 23:59:56 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761523180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HuBaBi7MEC/x8qwN/VRdjZ+F8E3nmLbiMXBqyR8TCKc=;
	b=xVdnhYyY6g8UdvMJGTMiPXk+LrCML947MycZUCF1xAmZuxWQ5nejKFG4tCrxZvMhZIazti
	+bGXAEQqRiOK2o0/wLLB7hjiBwemlGYEZhWqQhpo8heeFMswQkWRSZ39R8oaU1Gb+92pCT
	auEtGsDxj5BZIJPFwRMG13rYJMnd3aQ=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH 1/3] um: Use PAGE_ALIGN() for address alignment
Date: Mon, 27 Oct 2025 07:59:10 +0800
Message-Id: <20251026235912.1654016-2-tiwei.bie@linux.dev>
In-Reply-To: <20251026235912.1654016-1-tiwei.bie@linux.dev>
References: <20251026235912.1654016-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251026_165954_739814_0BCAD586 
X-CRM114-Status: UNSURE (   8.04  )
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
index cfbbbf8500c3..4bba77a28454 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -298,10 +298,7 @@ static unsigned long __init get_top_address(char **envp)
 			top_addr = (unsigned long) envp[i];
 	}
 
-	top_addr &= ~(UM_KERN_PAGE_SIZE - 1);
-	top_addr += UM_KERN_PAGE_SIZE;
-
-	return top_addr;
+	return PAGE_ALIGN(top_addr + 1);
 }
 
 int __init linux_main(int argc, char **argv, char **envp)
@@ -369,8 +366,8 @@ int __init linux_main(int argc, char **argv, char **envp)
 
 	setup_machinename(init_utsname()->machine);
 
-	physmem_size = (physmem_size + PAGE_SIZE - 1) & PAGE_MASK;
-	iomem_size = (iomem_size + PAGE_SIZE - 1) & PAGE_MASK;
+	physmem_size = PAGE_ALIGN(physmem_size);
+	iomem_size = PAGE_ALIGN(iomem_size);
 
 	max_physmem = TASK_SIZE - uml_physmem - iomem_size - MIN_VMALLOC;
 	if (physmem_size > max_physmem) {
-- 
2.34.1


