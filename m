Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79D1C77B7C
	for <linux-um@archiver.kernel.org>; Mon,  1 May 2023 20:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pvW+g+ioo4mmoBfI/E1Gr4WTK9Y3nZqsYwSVyhXnM0Q=; b=F5secKR2kHFAfR
	DVqNBmoH4klELlAjm8gFmUlrRzEwXL4QbgiaeOg2pN3/CsAENtO/iJbwCm94tZl+9LHoAJ6xr7d82
	BkNV1QJBbF56bnx8kLbdybYr74Zq/0vRTweKXeJdD6ZtJYqqFyk2lVFjz0NIDLktMR0a5sarg7qvo
	axJsH3q/euh2zkJuh/T2/1eQcMN37Uf1681H2VWajH/pog0cMrUdJmBncmRhNwQrcqw1bDDYy3NNh
	aVDGM/HN8PN8CSFDu6BkPNJOT21sswh1roHhwc3I9PCnFVxrpp12xlU9RZaOVp/wdX11Tvjy6D20X
	aGw/lN/TjkXFwgYCpN2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptaAN-00GsGy-1f;
	Mon, 01 May 2023 20:30:35 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZCu-00GhTH-2Q;
	Mon, 01 May 2023 19:29:09 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1aaf91ae451so11834705ad.1;
        Mon, 01 May 2023 12:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969346; x=1685561346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WInZHFLF0E37CPvH/fyQuQmpONrFi7mPGahLu3Z9gNY=;
        b=q4na0YpY6+HIdR7eCjpOfgl3pLZKXaYPSEQBquag8z/68f0H1ARrXFU5GHdi9YxK8/
         rB/VLGJXy6D4ZufE/2LOOEwnretxgWAB++ZlGVRxVIYCoUOlMN8apcsmkHtbQevtOOJx
         LNKiQlcElPDsuGjD80MSn3zT41r1jijBtepWy2itQQP8kPb/qbuR3Nu9du37XsuFat5b
         tY9vSCaH65FZJZYGzqq6Sev5FEiEarceFI+PkCB4zysu+TPDmYzeupQ3qWrtewRiW+Ef
         pPbEC2E+2Gu9odmO4zWHfrgw5vSTXCdgYdvlBNlEJqZMmLFOH+elBEgtadEGjmhbbSeV
         twkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969346; x=1685561346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WInZHFLF0E37CPvH/fyQuQmpONrFi7mPGahLu3Z9gNY=;
        b=crjoxIci0xLMthZsUNKHL1U1iapNHeiu5SN+rz1jhp3+LCpcGp9JlAoA+T+Xtz7DXV
         +8wdBuQaQ0qYG2Kad5jc005qQjKRAo85PKu0GeWYz2q+ec/7J3zT+qLJAYWH4322Zt44
         FfAP+nKD96JbNeISeCSu7uXOYpofqeIEIUVsn1VEfIwXg+ynavRRNHyP9tWvv4virf8n
         ND5vPhPgh4/Fuko903iGhs+ib0100WcwXvQ1xrjUzjd/XN6nnAjqNuVDUmVzH5nmWo/6
         PJVnZ2wbVabRUq0EL3RRjPC/tzhS/46Jizr7frtshKwRJCr/pQbbUssft31A7FKX7f4Z
         FnEg==
X-Gm-Message-State: AC+VfDyZyUrlR3kFZezyBk9dKKXqPQrCTPScXnksbSPhzg5ckFIpKeCc
	LkyCtAxoxbsK0TVtt3vJY6U=
X-Google-Smtp-Source: ACHHUZ4G7uSDpj0Az+Rf76NPdw6reyXbUYX/RD5L7uNUC8eMCewkmfrtYB+I6yNLHyDYyReDKoyXCw==
X-Received: by 2002:a17:902:c947:b0:1ab:8f4:af21 with SMTP id i7-20020a170902c94700b001ab08f4af21mr235908pla.42.1682969345737;
        Mon, 01 May 2023 12:29:05 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:29:05 -0700 (PDT)
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
Subject: [PATCH v2 22/34] csky: Convert __pte_free_tlb() to use ptdescs
Date: Mon,  1 May 2023 12:28:17 -0700
Message-Id: <20230501192829.17086-23-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501192829.17086-1-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_122908_788851_7F5BB7AF 
X-CRM114-Status: GOOD (  10.93  )
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
