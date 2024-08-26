Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103A9C5321D
	for <linux-um@archiver.kernel.org>; Mon, 26 Aug 2024 10:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jo0r7PE2P21mYE53WxHNzNjxHnLxdNhP0Cu28IOO4aU=; b=vvV9xFX7FzcZaRDfIJBjzw5X1X
	i8qaEw2jqu7wOZvmcn8uCRs0Rji7ZQgiraH3nsi5d3Y7bQ+1O9UgrhbpXlPVa747fdkkLTsSkfT5R
	lBi6SxwQij8FxqD3OgP7zAh74ZMgJ+GwphrvvbHwpOawU/k2QDNXEjNaAVXUaJp8Tch4VHL+JvP1U
	kZTnRUsUhVA5NNrzgzp3mPAY5hZFrTEUH8kwMpEheKs/nlCpzDT1wWtURgJCyFEprZCMdyVRDGBzQ
	1Gce1xg52s9KXBLdCmkG+er+SGlij6Ka245mAzBydSv/6UbDCcpQykbpBcb4j83tw8AwUtC6sIQA5
	kn4jXi0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siWlk-00000006sy5-0ex6;
	Mon, 26 Aug 2024 10:16:16 +0000
Received: from out0-195.mail.aliyun.com ([140.205.0.195])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siWeH-00000006qtP-0oWY
	for linux-um@lists.infradead.org;
	Mon, 26 Aug 2024 10:08:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1724666907; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=jo0r7PE2P21mYE53WxHNzNjxHnLxdNhP0Cu28IOO4aU=;
	b=Mos3FWdfI3XuyKQUNYQfnq2Q0a5U8o6tkzKEqvacbqoV0AtYLlr7zQQXRSvpQRZnAHNXvg6TAaste7UbIaH/11nuXHTpXL19twW83LNioPfzPLy6farIgUbjacbmbjjN2ibLYoFMJh/6WLjoF/JJyZEPR7Er1EzQ+ZCdiVRNajc=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Z2YRscp_1724666906)
          by smtp.aliyun-inc.com;
          Mon, 26 Aug 2024 18:08:27 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v3 2/7] um: Remove the redundant newpage check in update_pte_range
Date: Mon, 26 Aug 2024 18:08:10 +0800
Message-Id: <20240826100815.904430-3-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826100815.904430-1-tiwei.btw@antgroup.com>
References: <20240826100815.904430-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_030833_692447_9ABE37E6 
X-CRM114-Status: UNSURE (   7.16  )
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


