Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C387C19F4E
	for <linux-um@archiver.kernel.org>; Tue, 23 Apr 2024 12:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JMolFlkCz8q8s1KumAu1v9zZDtOAnzDuDDhti01QMmI=; b=MaDZyCjY4lqtEw37nwv/RPemlN
	VLgi7iPlHJYddxCDGEgNPHJi5MEuTk+6sEeAmaUcYpD1vxVKblxs83z8uyY9oBXFxzX3X3HRhuYto
	nu7DNx+oycwGu7GjAH0sBKrtmoCDcTyc/wLk/I7qnfQw+Cz9yKwcJTwy37APMucOE8BJNgLEHDT2F
	L5gBgZ65XbQmqUXRqz0p6kUXsgADwzueqgAdDtGQ+FtP2ym6O7Dt+dLGKUgxhlr0+ZHt9GFINFEY0
	xaiRCeKVI9ExIYGOXsMKj7/IXPAmr1OLHb8+IrJm65YKPIhPlI/jo64dkcU7jJCGbSApmKeVRmoCE
	Sy/yUPAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzFk4-0000000HY1x-2tiv;
	Tue, 23 Apr 2024 12:59:24 +0000
Received: from out0-196.mail.aliyun.com ([140.205.0.196])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzFjt-0000000HXuW-0Moh
	for linux-um@lists.infradead.org;
	Tue, 23 Apr 2024 12:59:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1713877148; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=JMolFlkCz8q8s1KumAu1v9zZDtOAnzDuDDhti01QMmI=;
	b=M0Y2biDILt4icf5DtECdUNt0S9ORTZUiW9oEV4tGi703v87SzGWDJii7lgngLHU7UBznU8qXb3Zf3ZPwikHF58GbYbN3xk8Tkb9Npw+Z7thgC6xyApxfotbW+fL+o5KokwSLw8BIimX+zKQFDjWMMhb7LnYqauKhvoonvMfGVws=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047187;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.XJXNjSO_1713877147;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XJXNjSO_1713877147)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 20:59:07 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 2/7] um: Fix the -Wmissing-prototypes warning for __switch_mm
Date: Tue, 23 Apr 2024 20:58:53 +0800
Message-Id: <20240423125858.137709-3-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423125858.137709-1-tiwei.btw@antgroup.com>
References: <20240423125858.137709-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240423_055914_783885_D8561624 
X-CRM114-Status: UNSURE (   9.17  )
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

The __switch_mm function is defined in the user code, and is called
by the kernel code. It should be declared in a shared header.

Fixes: 4dc706c2f292 ("um: take um_mmu.h to asm/mmu.h, clean asm/mmu_context.h a bit")
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/asm/mmu.h           | 2 --
 arch/um/include/shared/skas/mm_id.h | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/include/asm/mmu.h b/arch/um/include/asm/mmu.h
index a7555e43ed14..f2923c767bb9 100644
--- a/arch/um/include/asm/mmu.h
+++ b/arch/um/include/asm/mmu.h
@@ -14,8 +14,6 @@ typedef struct mm_context {
 	struct uml_arch_mm_context arch;
 } mm_context_t;
 
-extern void __switch_mm(struct mm_id * mm_idp);
-
 /* Avoid tangled inclusion with asm/ldt.h */
 extern long init_new_ldt(struct mm_context *to_mm, struct mm_context *from_mm);
 extern void free_ldt(struct mm_context *mm);
diff --git a/arch/um/include/shared/skas/mm_id.h b/arch/um/include/shared/skas/mm_id.h
index e82e203f5f41..92dbf727e384 100644
--- a/arch/um/include/shared/skas/mm_id.h
+++ b/arch/um/include/shared/skas/mm_id.h
@@ -15,4 +15,6 @@ struct mm_id {
 	int kill;
 };
 
+void __switch_mm(struct mm_id *mm_idp);
+
 #endif
-- 
2.34.1


