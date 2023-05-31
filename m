Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B66C77B7A
	for <linux-um@archiver.kernel.org>; Wed, 31 May 2023 21:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8MYS519P0YnNCexiLRPHuMxx4/Lu6MRrApdPohFpF8M=; b=bndx/xikn3YLLz
	89ENoBsgIPsyukyvYcOlTU7wcSKThuAb1wtxbaU0/EvswWqHFQv2IMxzpy+NEFKrrnowx6F1ceHjL
	yav+g0A9U2L7xiCL1PARcngbt4gPpGeMNAh9j7ARGx9bozOgWY7yBHR68f+gTgA6wMlTI4NrtTDXa
	OKWu3qnXJSTvXMG1yfOqdTlG6C17PwagPk4re7SbUxN2hzSiGNgH5fmOQXsxsjiI6a3dL8+8UmH4o
	2iFTrFCYA0c8vfmlO97BK2g++3d81QduHRBs68n4qKslFZFe2TiomL3+gB2nwgaNYnSre3rwPDTIh
	MBUnzj0gUganzET//QWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4TmC-001Ed3-1N;
	Wed, 31 May 2023 21:54:40 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4Tm9-001EaC-1A;
	Wed, 31 May 2023 21:54:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=jxwTfn+1WulDyktO0TSvPUm3DeZmyyKIR9rdY3Tk+MA=; b=WkaLE29OEknCP+2zJSwOUE1Ben
	WqcdArB/rolvSd7gwB4q4cLdk5L/4+7+jc1eDfehYSASIy4lygwppQro8uE0jSYwLdzEj83RccCrs
	ZGitlm/zR950M3buAG3CG5f2Oo2mCvbsVJZA1tHRBL3XLyl9cQTZXwEbL/L0D5ScU3O0ZRgM2btk2
	aftGfjBEdK9CDLGYqEWIQ9LkXDqj8MIRjkYzed4uBum0MN/SUtChs0TBuNMSdRR56eTOkokKAn6b3
	4+rdQFpYThnuPhT7Ik7+sUl9sUvyMzDxShB4+rExfslOyijoj8bYrqIzKHiPEX9nZ34u4O2TJs+k+
	j3mnTqrQ==;
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
	by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1q4TQT-007fj0-28; Wed, 31 May 2023 21:32:15 +0000
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-565e6beb7aaso742817b3.2;
        Wed, 31 May 2023 14:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568732; x=1688160732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxwTfn+1WulDyktO0TSvPUm3DeZmyyKIR9rdY3Tk+MA=;
        b=L4jsN9kH5t72hj91BgcxrEjxGpFvV+qs5I3bkyZBlk1og0Opgec9qEsIK7FrraEHx2
         1n1HXytspMZRcqAu6IErIg00HRKEQlSU5ge+vaCFc1Gqlt4Qy7JKfOaB6sQJmWGwoAk1
         ee2W8IRVTtbl/idUF0z1LRlcPjUT7a6tY+VOsk0Iu1C+hZh22D5V07hzjpJteBVx3v1W
         ZI/MBAiirrh/1wAfUDPooe/ZARW8FaFD8bCYxc4nZtEdbMeu9sESBKz6utwpFa1EL+di
         5AtPWE2kRx/FV4woLekgALaQYhp02WG5GHPy9VCjhu9orzHIF3v5vTBp+/fCu2h+nW96
         ROmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568732; x=1688160732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxwTfn+1WulDyktO0TSvPUm3DeZmyyKIR9rdY3Tk+MA=;
        b=B6nXa1XsAFL7KidyZw45p+ATuz1cXM3L5Z/WEoJi5kqkQ18hLe8Mzdn8QxoILyR8HN
         wntO63aD0TKE7ox7KdezXt2J4I2KQzPLKRxbO7vo4pq6f4FBivkeUUAGENKmqFWhPrtI
         4e3TPpCXmUXJG0Vvct7kzosiWM2e+fCNr5P2DJRYHvxzH0hQLtpg1mJGi5UEw0d91srN
         9UbOg44d8LtGLJhJzo45o3H+rJp4m5DGb6pV91SoZyzPmxuasj28/kvWZXgrF8vMru7H
         7/ju4sEEgDEdUS2WAgrHlWR2x/d1ffBkFM/LsugYAVTy7r8S+3WPmbDM0s/vgDxgYJGd
         GjbQ==
X-Gm-Message-State: AC+VfDxZRpmZHKN+rIHRzFwMazZfWL8FG6GmT0Cn3lhJTOE0VYhyN1lD
	RbbXN+EzhfdQdDzGR3PVHkw=
X-Google-Smtp-Source: ACHHUZ7+/nVY5dy5ww7MvRpp2ZVq2XpqSkLFoFJGuLgsQ62NeKnra3AVED33Ph7R+tcYIq7VRl7QLw==
X-Received: by 2002:a0d:eb83:0:b0:561:3fb7:1333 with SMTP id u125-20020a0deb83000000b005613fb71333mr7209246ywe.43.1685568732564;
        Wed, 31 May 2023 14:32:12 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:32:12 -0700 (PDT)
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
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH v3 32/34] sparc: Convert pgtable_pte_page_{ctor, dtor}() to ptdesc equivalents
Date: Wed, 31 May 2023 14:30:30 -0700
Message-Id: <20230531213032.25338-33-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_223213_141893_EC8A756A 
X-CRM114-Status: GOOD (  10.36  )
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
