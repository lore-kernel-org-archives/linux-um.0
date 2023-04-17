Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 932C0C77B76
	for <linux-um@archiver.kernel.org>; Mon, 17 Apr 2023 22:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pvW+g+ioo4mmoBfI/E1Gr4WTK9Y3nZqsYwSVyhXnM0Q=; b=TzevKsKD43ET6/
	OWknq/yzi92pY+ms+C26bED35cPPUgT6K4NLaAYBk/b/obxktqu6p/eXrEPc74JgEuthJ7Q7qsPM6
	QdU2R+Ma8lIJmHEH02v06C1mkv8FYNCua4DyjImyxt83Ua5++K2yeA+HryFV+omyK6oZmSvgQbdfl
	XtvjuaVEadpIDkibcFb1/90/X5dAZuqEJEm2Wo1FHYdizm8Qp7t8T7+eBjLsD1zuw4rExDumGo98/
	wrle9eYwJTXruZ/Jy1yGpK+6Sd6siS67ZYEY1GLnXWL8MV7SaI2UrXHKk9h8oBMWtbiSIBOQp8mDx
	kOBym/U0Q4AdGEVdmExw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poX88-000FO1-2s;
	Mon, 17 Apr 2023 22:15:24 +0000
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poVyJ-0000P4-1P;
	Mon, 17 Apr 2023 21:01:12 +0000
Received: by mail-qt1-x82f.google.com with SMTP id fv6so13262420qtb.9;
        Mon, 17 Apr 2023 14:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681765269; x=1684357269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WInZHFLF0E37CPvH/fyQuQmpONrFi7mPGahLu3Z9gNY=;
        b=rz8nUHeoHENh+Oxb/dP+2Xs0GB1ndrTEGV/Kpzs6qYqKCASiyVRVormYiKrXMNCdQq
         hnLLPYCLCCiPAy0G1PPyb3sPc+JZXH3REkTt58jOxtxIVILAjhPyF+htkLpX6yRFjgnW
         rkWBSZKfT9sHFMg7i0zJaRi4AHyV+5ed6k6RukI1HVQbBnLlCVu8K+DpjMqHZe30ab3r
         GX0gYaHSNqQKs6qzTg0FHq20dbGG5U9Ib5dS7HtnjObhQA12Xubyv1c1Y4oa6fUqP4nx
         cXML3cenr0TVuLrQqdmICoawChTOkCuYU3jZ07xrVHVmfXynD9/NZ1iNL+Je7SSUGsfQ
         7YMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681765269; x=1684357269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WInZHFLF0E37CPvH/fyQuQmpONrFi7mPGahLu3Z9gNY=;
        b=kcZQfQm0jmDtdvBzcQPJvFU8PIGRvR6IWdJ76Z8MTMQXJPQWg8fjRT43hrBdDF57H3
         BfmoUQR7ROtrbW00qnS3Esy8B4zwFQLi3TyCeg2r2Wnd/4LCtycbYZi0daS34JwSkyps
         ZOjkkmgOGTIPX7Nn8MCNHlXrG0pp5y6AU14P+HRt5XS2BwdfQVsCVoxxZp6iVG5C+k4p
         T5vXr4b1DN+WMU4s8tE7nEkDvKPVUi2heVx4xqkpkW8kuPjnDx5RDR8QIAuHo7MVCfpO
         y2RGs+axPsd7AH1l8Tw6C+EU6EJAf2v/wPIQYGhiLaRCBAciCuMdcGoN5IxukPw06x05
         cimg==
X-Gm-Message-State: AAQBX9d3MpC5Ekl79sWBR21hVB2bQjEWXWiMDot9ocONxWSu2RDGJgQO
	ui3qbFwUFXDRLRUPqhAg6mkXalSVFzn5Xw==
X-Google-Smtp-Source: AKy350Ym3GSROxWd30N3vnOcQ+scJJk4j2bn57g6f2y/wdjBz5ko3J6EyTomKSlBO1Xk2XiBoSAe7w==
X-Received: by 2002:a17:90a:5315:b0:23f:81c0:eadd with SMTP id x21-20020a17090a531500b0023f81c0eaddmr15717621pjh.47.1681764794292;
        Mon, 17 Apr 2023 13:53:14 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:53:14 -0700 (PDT)
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
Subject: [PATCH 21/33] csky: Convert __pte_free_tlb() to use ptdescs
Date: Mon, 17 Apr 2023 13:50:36 -0700
Message-Id: <20230417205048.15870-22-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_140111_481674_35537B64 
X-CRM114-Status: GOOD (  10.43  )
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
 arch/csky/include/asm/pgalloc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
index 7d57e5da0914..af26f1191b43 100644
--- a/arch/csky/include/asm/pgalloc.h
+++ b/arch/csky/include/asm/pgalloc.h
@@ -63,8 +63,8 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 
 #define __pte_free_tlb(tlb, pte, address)		\
 do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page(tlb, pte);			\
+	ptdesc_pte_dtor(page_ptdesc(pte));		\
+	tlb_remove_page_ptdesc(tlb, page_ptdesc(pte));	\
 } while (0)
 
 extern void pagetable_init(void);
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
