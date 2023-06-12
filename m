Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5560DC88CB5
	for <linux-um@archiver.kernel.org>; Mon, 12 Jun 2023 21:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8MYS519P0YnNCexiLRPHuMxx4/Lu6MRrApdPohFpF8M=; b=K3xNZJMSXWUcpK
	+Go98lNNWcCB7mKXL/VB+t1+mPdrhJ/MWYzozXfMl5kt/V+xODGNIw44dHeB2ljGqzzg0yXMPNXV5
	6nLmM0HG2/m1MsQssgo0c4CXDHLLwe6y6+TvmyYrZF7bfdQQ1/0tyuCOwuaNZuvNCF4diLUu8uZUZ
	i03ZNd5I4+5l5hvrpfyS0z78NZeL2s4uwbvi/eUx+hyMMSnup9yMNPzEC881cW2YGttsdLUCsQNZS
	orvbK68d1Kavp0dUa170kaPjQhrFGDWYXbY+UTMHDfTHStxGD24Kk7AHaeJCe4ckog0wZMVCx70gg
	1IOgOhDPxXehX9dGkY1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8olR-005Q90-2N;
	Mon, 12 Jun 2023 21:07:49 +0000
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8ojY-005O0L-1P;
	Mon, 12 Jun 2023 21:05:54 +0000
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-56cf916aaa2so27693147b3.3;
        Mon, 12 Jun 2023 14:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603951; x=1689195951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxwTfn+1WulDyktO0TSvPUm3DeZmyyKIR9rdY3Tk+MA=;
        b=eOGJOp7jJTQ8Qtwco1FoDid2kdNhU5TzJ+8oTbvEbumqL3nQk9f2JlPpUk6+vVBHXw
         bRV5gt25GkskwnqufNjnti+xZOoYZnavni3acnpZrn1jo+MmuLHwqDsH6AdCefai5bKk
         AAXb7bC/rUfzM5Y5JNC2uvXF2EwFePa6CfTpeOCze3Q765zcxWqm7xds3eAw0lRtuTsf
         BcL57/8mkiS9/4+PfEIujQe3OJ/SAHQmhYjUTcU73/gLJF/ExdRrGcc3uAsWdkuXE+Gy
         4wgk7G2Doap3dB0ilCFuRYDRNdtR39NjevfAI+zLdtvH3iP4AClD5Rnj/kfEF228LJIt
         Sr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686603951; x=1689195951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxwTfn+1WulDyktO0TSvPUm3DeZmyyKIR9rdY3Tk+MA=;
        b=QqwaTD0CszIwZ1/u7PvxZgwd1lOhKQmCnBaHEspXxupoPqiagcWC5tIEfdQiVDORtA
         ELBaOhgCl3pQbK1ZyBZc9rEGn5BRJ5LyLjlcuV9yiEv5cI7ybBqSwtQHkzXc9rF+UJrO
         c17x0sv+qUz99yX2FWkBqvt5cmbCgJK6Gn9lL5dRXpkqeht6dh8sVpok4CrQ45RQYXVi
         U5e7racK8SlFxnv0qiB6365zkgNwgEpr7Fq16DppRjCHYmgBo+bhTKPUjBNDoLr425UZ
         3hjqfCgdaAMCgNxPuEHOUrb0vDP/5l/pcCQjuDP6EAw6qoncmP8YyoWalEGILsdc1oAg
         3j3A==
X-Gm-Message-State: AC+VfDzU1rUOCgON2v/1+GGjpgyp560hwQyIrv1/uImTHW4jrL6GEkMX
	CM7zWC4nxi9FZhG2B4KLw6g/HBtClHEbMQ==
X-Google-Smtp-Source: ACHHUZ46bRW6OF4FDY00X+3CElfC+YpfDtCCDJShqSFxuRDw2O4jHQvSGoeDK27CBT1NdKxGixMjGA==
X-Received: by 2002:a0d:cf86:0:b0:559:ed0a:96c4 with SMTP id r128-20020a0dcf86000000b00559ed0a96c4mr10849624ywd.44.1686603951409;
        Mon, 12 Jun 2023 14:05:51 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s125-20020a817783000000b00569eb609458sm2757115ywc.81.2023.06.12.14.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:05:51 -0700 (PDT)
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
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH v4 32/34] sparc: Convert pgtable_pte_page_{ctor, dtor}() to ptdesc equivalents
Date: Mon, 12 Jun 2023 14:04:21 -0700
Message-Id: <20230612210423.18611-33-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612210423.18611-1-vishal.moola@gmail.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_140552_603976_4B3B0C43 
X-CRM114-Status: GOOD (  10.75  )
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
