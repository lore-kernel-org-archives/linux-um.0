Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15422C531DE
	for <linux-um@archiver.kernel.org>; Fri, 16 Aug 2024 10:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z/OyflIhDj1OPlK2j8cfY/ptojYdSEITrCVMmB0cw4o=; b=GW7N4goDqcDFDht8h7kNVvH1sm
	Nv8NTdER77jq2NNoFyY6AwGmF4bHUQ7Gs2IADDKJbN4j8iPYofzsIGzpmleYqY9GSayUkldurk82m
	5rgQrCJkgUTKyHhF45yDUgGMm7w0x28WxQY3iFGxhEgIoL8cChoV2QhjIfoG5ZrtMOP2K90+JW/wc
	A5Mvk386DvrbHn4uCPyJzA4TBa3v5HfpQ8M7Vk06Xj6nCsbTR817Q+P2cDrDK4A6Vtd+FvA4dICv9
	5gzwoc4FqyN9Ey+OkUvC0SL3l5Cfn5bS1R4hLJnV6Hvl7NqpCkFUaWkjMR5v9PuQrILsIUfQDGRRl
	CP+omE/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1setki-0000000CWMy-13H6;
	Fri, 16 Aug 2024 10:00:12 +0000
Received: from out0-198.mail.aliyun.com ([140.205.0.198])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1setke-0000000CWK8-0i9M
	for linux-um@lists.infradead.org;
	Fri, 16 Aug 2024 10:00:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1723802404; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Z/OyflIhDj1OPlK2j8cfY/ptojYdSEITrCVMmB0cw4o=;
	b=adjnjQ68S4z7BtDLveJKwG0T6BpaEDnpobmx9AqsYXfBJLfpUO6/Kf8BHfuyPXCpqPWbtjEa7DPy/bVEogp9KaKFnHVcBFCO3O4FpYTcMr+pW9/I5xYo+EIaJ2JNdC5CeablQNmjAo1CouoagD+SYbuFO7NO9t5S1Tlbjyjk2bY=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.YtmFE3v_1723802403)
          by smtp.aliyun-inc.com;
          Fri, 16 Aug 2024 18:00:03 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 1/6] um: Remove unused kpte_clear_flush macro
Date: Fri, 16 Aug 2024 17:59:48 +0800
Message-Id: <20240816095953.638401-2-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816095953.638401-1-tiwei.btw@antgroup.com>
References: <20240816095953.638401-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240816_030008_728621_9460BB75 
X-CRM114-Status: UNSURE (   5.30  )
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


