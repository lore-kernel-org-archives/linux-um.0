Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7752FC5320D
	for <linux-um@archiver.kernel.org>; Fri, 16 Aug 2024 01:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LWI9UQJ/pky4HAg7t6kPtQh05UbFRBIY+bNweOhhjQc=; b=i+WZilc09efHSORDlHM9rI97Au
	DdXTkhvq2zE+zJIKuO67q1JxQ54ku5woRlV6DdQI57+6cdQbY/gGyMOtE05ewskXWKRnW3C4imNkD
	vkdrn1URmNOB8lzEvs/NZftMbwWNUo51cszYllWJs947ZvfdbnsEyDPhku08/SHkwOChlIxA8jO9z
	pD6hvQe4klXv8jCXnbqZEsoyFsi/ddg2yZLy1GzVliuh0Le1lcCcbVw1//CCOOczlIH/CESW+trNG
	s/NeHG1SWXh90miDkjfkwSe/1iSRAxWtEXi86doxCglcANq47DRyHdaygJz6F9xVZWcS0ryw3hxCH
	FhGRGrCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1semBJ-0000000BWgx-0kNk;
	Fri, 16 Aug 2024 01:55:09 +0000
Received: from out0-206.mail.aliyun.com ([140.205.0.206])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1semBC-0000000BWbR-0c32
	for linux-um@lists.infradead.org;
	Fri, 16 Aug 2024 01:55:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1723773296; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=LWI9UQJ/pky4HAg7t6kPtQh05UbFRBIY+bNweOhhjQc=;
	b=NJH1t7O8VxQTDqPbKGwX94et9TaKcjJ/0koytHy/obbIYpuzTaUUjfgH8QvvHD4eBB8bQ2lb9uqU0zZkwyZYuFb/Wv0vQ/ro6bvaRCUmtEw3Xt/TeZJ8kHAaK0zQGEZVC/my8R926O4X9LBZWxVEzIS7EkP8oRxdSKO0Vhkq7hQ=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.YtEBojH_1723773296)
          by smtp.aliyun-inc.com;
          Fri, 16 Aug 2024 09:54:56 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 2/6] um: Remove the redundant newpage check in update_pte_range
Date: Fri, 16 Aug 2024 09:54:43 +0800
Message-Id: <20240816015447.320394-3-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816015447.320394-1-tiwei.btw@antgroup.com>
References: <20240816015447.320394-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240815_185502_622878_7BB0F5FE 
X-CRM114-Status: UNSURE (   7.01  )
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
 arch/um/kernel/tlb.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 44c6fc697f3a..dddbc473baa7 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -82,16 +82,13 @@ static inline int update_pte_range(pmd_t *pmd, unsigned long addr,
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
+				ret = ops->mmap(ops->mm_idp, addr,
+						PAGE_SIZE, prot, fd,
+						offset);
 			} else
 				ret = ops->unmap(ops->mm_idp, addr, PAGE_SIZE);
 		} else if (pte_newprot(*pte))
-- 
2.34.1


