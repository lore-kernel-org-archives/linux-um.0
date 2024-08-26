Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D9EC5472E
	for <linux-um@archiver.kernel.org>; Mon, 26 Aug 2024 10:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z/OyflIhDj1OPlK2j8cfY/ptojYdSEITrCVMmB0cw4o=; b=0zYtRk6qIWwFll+G4v9GpF5uXx
	naOty4HSxQBkxG9MgvsRFpvMWz0aHP1clj8IK9U2WQoZP2XxNhKDRva3+74xhnlyM1CM+MJkaoGHi
	Vqm/oTtz1Wcc7KxqmZncYNcfXxn4s6CjA4oJch+GcbAY2klU0nvnyJmAb1KAytIJEf8ChQJTTzglF
	RSIADZsbvEYI6SLIcfkaMWqonPP/yeGgZ9tui6B5xypHPJTRCS+qUVJoPOji9Oz98A6ZSvWP4CjaX
	01wxtc6R8iYsQwDLwJ3GdXFNzOhPx+AN6+24kkU5vFPwsXl49zQjuxRxNn0hGdZraz0OdmizeX6Tu
	5d+UIXiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siWlk-00000006syD-21o2;
	Mon, 26 Aug 2024 10:16:16 +0000
Received: from out0-206.mail.aliyun.com ([140.205.0.206])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siWeH-00000006qtk-1WrQ
	for linux-um@lists.infradead.org;
	Mon, 26 Aug 2024 10:08:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1724666908; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Z/OyflIhDj1OPlK2j8cfY/ptojYdSEITrCVMmB0cw4o=;
	b=lnhJFIhABuh1xH5q89+a/vamuWYAZSIcE6Sv0bjj1JHgjp+qebsJeetoWyWTTMaqlO/Ann72PNJxMWqzG2lRdY44q3eCckrr7iHJ7qK6AJ4tvEsFdtlq1ZVR6HlqdM9vSbplzbEQGTh4QlvrvVZAp3da4BG1CiiVfjI5BfkDQDg=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Z2YRsc-_1724666905)
          by smtp.aliyun-inc.com;
          Mon, 26 Aug 2024 18:08:26 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v3 1/7] um: Remove unused kpte_clear_flush macro
Date: Mon, 26 Aug 2024 18:08:09 +0800
Message-Id: <20240826100815.904430-2-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826100815.904430-1-tiwei.btw@antgroup.com>
References: <20240826100815.904430-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_030833_698347_59B0EE29 
X-CRM114-Status: UNSURE (   5.32  )
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

This macro has no users, and __flush_tlb_one doesn't exist either.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/asm/pgtable.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index 5bb397b65efb..83373c9963e7 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -359,11 +359,4 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 	return pte;
 }
 
-/* Clear a kernel PTE and flush it from the TLB */
-#define kpte_clear_flush(ptep, vaddr)		\
-do {						\
-	pte_clear(&init_mm, (vaddr), (ptep));	\
-	__flush_tlb_one((vaddr));		\
-} while (0)
-
 #endif
-- 
2.34.1


