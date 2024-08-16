Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3C2C531DC
	for <linux-um@archiver.kernel.org>; Fri, 16 Aug 2024 10:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jo0r7PE2P21mYE53WxHNzNjxHnLxdNhP0Cu28IOO4aU=; b=N9VJ0QAnketuw+OPZZppjRslx+
	wzhUaEA1PxqRXRvxF13aiCNDGDMiH6XdYfDjt7ItIQObHzSLjv0VhQYy5f70BVe+TDVmb6oy10u1n
	XNBwcdv8TPhxUyc1pxZZlouZkyCzgAU05qrdchJpgk8xQ6E4XJWQBnEXMEgvcS1h1VGVWyATcsZ4j
	1yDcG6PcquzyYD5zptaP2PldSD9fT11Osw/XhbX6h0NfBkYbe5dVoXnQn6IHA9qb5Pf/zlwMM2BPl
	+hsxx6OvWTgtzI/gyro72MBw0PubrLa6syjIfiHeso9ILNDe/dVc/pWHkbZt0GdLoPFIlxAWw4LtL
	HajOvI/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1setkl-0000000CWOb-04Qe;
	Fri, 16 Aug 2024 10:00:15 +0000
Received: from out0-201.mail.aliyun.com ([140.205.0.201])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1setke-0000000CWK7-0lpb
	for linux-um@lists.infradead.org;
	Fri, 16 Aug 2024 10:00:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1723802404; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=jo0r7PE2P21mYE53WxHNzNjxHnLxdNhP0Cu28IOO4aU=;
	b=xPi7Vj3jFV1eOeindJKlymWpzZI37w83WwzgR3pLdce5jDJfkIVu7ggVyjhKa6SQ73yn2wO+kld85ZQcIPlHPmHZ7KJlZ4Edck+JUfb6T47Go1cbhLHvRMGODiZwujbsEaUWc7F9mdV+6YoH5h8uUcxdanMgimLNuvPaGswBxA8=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.YtmFE5W_1723802403)
          by smtp.aliyun-inc.com;
          Fri, 16 Aug 2024 18:00:03 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 2/6] um: Remove the redundant newpage check in update_pte_range
Date: Fri, 16 Aug 2024 17:59:49 +0800
Message-Id: <20240816095953.638401-3-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816095953.638401-1-tiwei.btw@antgroup.com>
References: <20240816095953.638401-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240816_030008_755520_62E0532D 
X-CRM114-Status: UNSURE (   7.15  )
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

The two checks have been identical since commit ef714f15027c ("um:
remove force_flush_all from fork_handler"). And the inner one isn't
necessary anymore.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/tlb.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 44c6fc697f3a..548af31d4111 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -82,16 +82,12 @@ static inline int update_pte_range(pmd_t *pmd, unsigned long addr,
 			(x ? UM_PROT_EXEC : 0));
 		if (pte_newpage(*pte)) {
 			if (pte_present(*pte)) {
-				if (pte_newpage(*pte)) {
-					__u64 offset;
-					unsigned long phys =
-						pte_val(*pte) & PAGE_MASK;
-					int fd =  phys_mapping(phys, &offset);
-
-					ret = ops->mmap(ops->mm_idp, addr,
-							PAGE_SIZE, prot, fd,
-							offset);
-				}
+				__u64 offset;
+				unsigned long phys = pte_val(*pte) & PAGE_MASK;
+				int fd = phys_mapping(phys, &offset);
+
+				ret = ops->mmap(ops->mm_idp, addr, PAGE_SIZE,
+						prot, fd, offset);
 			} else
 				ret = ops->unmap(ops->mm_idp, addr, PAGE_SIZE);
 		} else if (pte_newprot(*pte))
-- 
2.34.1


