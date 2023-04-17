Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F28B6C77B72
	for <linux-um@archiver.kernel.org>; Mon, 17 Apr 2023 21:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=F7MF8nZvgIEgklRUz+GhsC9bJx9Ptbb8Vo7+f/F8HL8=; b=KjEJ2ujUZxraVa
	a2znnrwga2BihFIGAKCkp7qkDLVnPathBetF+LFsQLUhrdUD0ZDtMnfUJt0go3bMNJmD8d+PZSahS
	SCx93UL/WGCJjV9FJjxvMq8gEH7MEn18P88Q1MKGBoY2L8wX9EFg4uzbUzzJ+MsktptkSAWBVySDF
	GeaiWrYqiyesickJ5Jc5GWcU+y9RF3KrhFNOwXDeVU68ydyXMKM8yKpSOQr1TKprihJI/Bad5GX04
	CbufaK5naIxFW1EPjj5+U6O0RhALQp1FN+QShzK0KUe+ucUAzpaJw2tpZ8OqZOQPi7f5N2TN0yB3b
	2UeaNePxJXbfYnJnZ2Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poWEA-0002Mj-1f;
	Mon, 17 Apr 2023 21:17:34 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poWE2-0002G2-0u;
	Mon, 17 Apr 2023 21:17:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=apg836Gn0N7QExyyhUUGNgc2fd2r3iyoAghRwsUjc2o=; b=pGAjQpaylyS5YQWqUc6OG7YuVt
	HTMnbrI6w4/K5EI0WQa4XQPTmDphh1x4ol9bT0UxX2zuxkITY2RagIjWX+z0A/R+CGly6cZyj2fiX
	Bnw76cgHlE/YOkCeSVpo3GdeNRe1aj4vI5UjrJRzDbjj48Pm/GJYoCD3j1pvHERhhJP3BGVFRii8R
	F2v5OfEEATWjvhwTuvBL+QOiHOTplx283CiraVbVPUsDpFWRYG4iQKv2IV4ao46UqR9bRxN9KfFOu
	jsG9TIM/pKqQCjFpRALMe4wLf2bm0xF/UqqoFlZypHZ3lVtBG6guIcfCqWsZe/fYMyQapwW/HK33s
	zu4NNPgg==;
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1poVqe-00BfsF-CT; Mon, 17 Apr 2023 20:53:20 +0000
Received: by mail-pj1-x102b.google.com with SMTP id g6so10327014pjx.4;
        Mon, 17 Apr 2023 13:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764796; x=1684356796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apg836Gn0N7QExyyhUUGNgc2fd2r3iyoAghRwsUjc2o=;
        b=DU+PC+Lb75+sxyzE8TFBhUq23MhtXNiuA1nw0c/GhsuV5IK3M7l/Hh4azDLq1DRa+j
         fu7HXiEzvV3T+N5Mt1is7DhkrUBl4PJsqFnRPYaX3oFVj8P6Qlk5ZLs6mljyu96mU+sv
         zpquQbUhbrKn4GUU7udC1O03s9ThOPwnMOZQlJkJdwRy8ikjPxI0naLAwtnZbb4WzEoy
         3BNpuQVnvIHEKJKSenAtt9bKOamb6q7fxWlfz+PtLFjOTztncr7nNFnGXeF7WX7UQ2CN
         r/J7luQKDmaqSpU1aG4/YKRgzEf0E8SysEU40ARw1q6PEFiJTtJVgg7dYOEMGKOTGrN2
         xyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764796; x=1684356796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=apg836Gn0N7QExyyhUUGNgc2fd2r3iyoAghRwsUjc2o=;
        b=i7R3ZeE+12HZ2bp7D9OGDqN/3SRF+aWBOs1KBG+w957+NiK2R0SrET7I7MsA1L3R3a
         TMuuLvHAEPh2c7YUC+LfoDSFBqL4hRCAtO6mHM3ikp2Dg/WBIu+XVgDoNexufC8X4pYC
         foj/0giJnQvEH7iNHYDiHAOsI5a02ddWo05zc1vPFn9Itf8fK4uSB1aQjVY0oOz/vtE+
         gqtliGNUOdlJ/ZfMlmKUlkjDNw25oZDcAoSgO5y5/y47wZYIwK8JpRf7VFQApaOGcAIS
         ok/s4qtlnJumzxHbj+kzH+ZBBvYaGoXmk2UrkfxhOP1jnvvvYSB5DbRRNaZzn0oTlgKb
         v37g==
X-Gm-Message-State: AAQBX9e742VXGxoDfAmpPOAKPM12W23+jAm9xm2iIHGap/G89DmLQyEe
	zkgGu5OBkcOMOoHBPCYL71U=
X-Google-Smtp-Source: AKy350ZcoHXe5N321oYs87Q7Ayd5DnxwU4W2BhAi27QaGMsyV7i9NrgOQAsujiVTD54cy1B75qhHjg==
X-Received: by 2002:a17:90b:3b8c:b0:23f:9d83:ad76 with SMTP id pc12-20020a17090b3b8c00b0023f9d83ad76mr12727299pjb.23.1681764795745;
        Mon, 17 Apr 2023 13:53:15 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:53:15 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	xen-devel@lists.xenproject.org,
	kvm@vger.kernel.org,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 22/33] hexagon: Convert __pte_free_tlb() to use ptdescs
Date: Mon, 17 Apr 2023 13:50:37 -0700
Message-Id: <20230417205048.15870-23-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_215316_456593_6CB3ED6A 
X-CRM114-Status: UNSURE (   8.56  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/hexagon/include/asm/pgalloc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/hexagon/include/asm/pgalloc.h b/arch/hexagon/include/asm/pgalloc.h
index f0c47e6a7427..0f8432430e68 100644
--- a/arch/hexagon/include/asm/pgalloc.h
+++ b/arch/hexagon/include/asm/pgalloc.h
@@ -87,10 +87,10 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
 		max_kernel_seg = pmdindex;
 }
 
-#define __pte_free_tlb(tlb, pte, addr)		\
-do {						\
-	pgtable_pte_page_dtor((pte));		\
-	tlb_remove_page((tlb), (pte));		\
+#define __pte_free_tlb(tlb, pte, addr)				\
+do {								\
+	ptdesc_pte_dtor((page_ptdesc(pte)));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #endif
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
