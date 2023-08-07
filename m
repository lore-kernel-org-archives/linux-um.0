Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C966C25B75
	for <linux-um@archiver.kernel.org>; Mon,  7 Aug 2023 23:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ol8zwkIvBJj7YreT+0AM966/PiMpb82MHOOZq7ljM88=; b=fUHqe3W985sb8v
	Ad/p0zt4A0GZhrquZmZo3uAVCy73fV98sK0G9RqzlFEGerIx3MSyqJQZ4FR/dLnbKiaCEAAq7+/Tx
	L1TFGo9v0F/ORpd2Jo3uM5DcBbVe5SH/pVoiQyLpFopx0xd/ohufyu2hw+ZFp7RyZ3napL/6ravVz
	xaAwAYTaYKj3abhTE501KMgh/GqnjGclRJfL5caicwkq5dgji4sQwV/UXnWXpsRrl245GDEgDveDy
	HeevlGDMF/29IJvQp6Do+x6jbzVo35aeC4gA+E3HOv35DEqmOPMYYeSdZwld+les21qt1DRh4jlX1
	YL7Y0sLJSM0WWFTPCnAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9LL-0018H6-30;
	Mon, 07 Aug 2023 23:08:55 +0000
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9Ip-0015Rc-1O;
	Mon, 07 Aug 2023 23:06:24 +0000
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d45caf42d73so3390555276.2;
        Mon, 07 Aug 2023 16:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691449578; x=1692054378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yb5+fiX/YSPgeVruPImZCslC+7XzLtSDmAZ+KnCCvCw=;
        b=LURal4KqklmU9AiCOifU5Mxc6WM+IybZMw4f+H9b+ehsvWfF2rdEGUCUpHED/xgeP0
         03+is7BherE6vDUPF9cInwhZZ6O6FVEP73Sri7+CBG0/7jN64G4bgtBq56ZrcLUBIxxT
         uSfx8fFqjmiqF0MtkULVgc1gjFJH4lOvkwRfZt9wzMVRnizjKRrxJwuFQ2mIfEo7cHgy
         UR2ZIO+mIWR9RWU4d+HJedZnPKiZaDv8i4STB2D6+pQaLcMt/pvWXKdhAwPxBTPHyGDc
         YUL8XwwyvOUHrQNxNKfZS8WVqZrgPXs80ZLFz3I7kRgWNiGS07HTyMzLuT9V1dLH0d1v
         g2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449578; x=1692054378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yb5+fiX/YSPgeVruPImZCslC+7XzLtSDmAZ+KnCCvCw=;
        b=gcGBUBIte2VmSW+1BuTIItmvKxeFjhkIhXTyYMXEg7ZzJ20AItTW6bmyTzvnsGhtE7
         zcNLXLfjmE5RhF0fmAPNq1hu11jgaiBbCQNXgjNzDLjcuzfczMygagmsCpOlGSprIT/8
         RfDEbW4NHJtstM/Q69avd/fzq+zZqLKsWjNJSqGnA4m/gRqFheIB0MxcOf2eSC5OK4/N
         Ec0NlksgxI0QPQ6saNt+FpBlkZkwecS+Hp7BnNXzdCIYlwS2q5P6+9mCIlWH/dFHxKxF
         pk1e8Q1nBQvcwZYtCPUSTE6uUzCPMJIGGpp9k9YRNrn/5WSqpLN376QlzS1tIZgkHsKO
         lEhg==
X-Gm-Message-State: AOJu0Yzr01whqdKGvcGR3STqfS27ITSlZZw3L9T3cabL29eWJ9slahbk
	BksyCLW8VnZy2v2Y16MlIWo=
X-Google-Smtp-Source: AGHT+IHSK0JHQfLZYNqZB3BuP0bNBVURutz2ITpQB4n2EhlNMl4NfRND8wevRJ4hRdMY0+rsbG2z6w==
X-Received: by 2002:a25:ac04:0:b0:d0a:8269:e5d9 with SMTP id w4-20020a25ac04000000b00d0a8269e5d9mr9659872ybi.60.1691449578542;
        Mon, 07 Aug 2023 16:06:18 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id d190-20020a25cdc7000000b00d3596aca5bcsm2545203ybf.34.2023.08.07.16.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 16:06:18 -0700 (PDT)
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
	Hugh Dickins <hughd@google.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH mm-unstable v9 29/31] sparc: Convert pgtable_pte_page_{ctor, dtor}() to ptdesc equivalents
Date: Mon,  7 Aug 2023 16:05:11 -0700
Message-Id: <20230807230513.102486-30-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807230513.102486-1-vishal.moola@gmail.com>
References: <20230807230513.102486-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_160619_530634_7366DB10 
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

Part of the conversions to replace pgtable pte constructor/destructors with
ptdesc equivalents.

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/sparc/mm/srmmu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 13f027afc875..8393faa3e596 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -355,7 +355,8 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
 		return NULL;
 	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
 	spin_lock(&mm->page_table_lock);
-	if (page_ref_inc_return(page) == 2 && !pgtable_pte_page_ctor(page)) {
+	if (page_ref_inc_return(page) == 2 &&
+			!pagetable_pte_ctor(page_ptdesc(page))) {
 		page_ref_dec(page);
 		ptep = NULL;
 	}
@@ -371,7 +372,7 @@ void pte_free(struct mm_struct *mm, pgtable_t ptep)
 	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
 	spin_lock(&mm->page_table_lock);
 	if (page_ref_dec_return(page) == 1)
-		pgtable_pte_page_dtor(page);
+		pagetable_pte_dtor(page_ptdesc(page));
 	spin_unlock(&mm->page_table_lock);
 
 	srmmu_free_nocache(ptep, SRMMU_PTE_TABLE_SIZE);
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
