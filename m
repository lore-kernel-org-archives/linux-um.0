Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0562C7EE2D
	for <linux-um@archiver.kernel.org>; Mon,  1 May 2023 19:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ELLR+7DIBuyCj4eYScqdJfAFCR2m2sRumkuz6rsSupc=; b=S+WuBIG1polLwP
	xYVgnGSpToVEt41AbHf31OUkA23dWYgnq2cBaUuepXnu8CSajtIx6kTeMBc0J2OSHB8+39/erOo0q
	HS5UNcA1h0oG+dF0MS3mDtlcf/Fp4os9DvdWH+8hpPlb3D6XbLfXnsczpzasUfkr+2yjHecNBDv0F
	E6xKcGyoAHJsocEcQPSHWkRu43Sw9mOmLwbXhJNCvF5W0/yLIt1nvTnDC+ZVNb2+XlvfOtcxXWH3P
	EHizxSe+2DoC4BAvdx8GeTOvuWdC4uLQ5LH4OAn3Ns6sgTGZCsqTSaKdylsQ+DtKtoGoJtjbqztUu
	ZseANgSqIOFf06tTopMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZDE-00Ghqp-3A;
	Mon, 01 May 2023 19:29:28 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZD9-00Ghgm-2x;
	Mon, 01 May 2023 19:29:25 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1a69f686345so21088495ad.2;
        Mon, 01 May 2023 12:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969361; x=1685561361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSVYEUhM0zGHlDR1yqa5KIpwwPynV1rh1Z3AvIT239o=;
        b=YCg1YMo/xitXPr8EH+7i7/M0wYddD4PRgw+Xim9LG20m92WUdC9kOQT3fMeSkFJ8bz
         2xW9Qv874by/73QMdHiVk+wqz4B7HUYL6Uj2zbe5cOYZkoH3JAXPoFdQlYFWToTwzHn7
         dFfF9W+SZdFlY3dKNimMml0EcpIP5K8qP91gmqtjuJ3sBzpu94RZheVZlyc0ZtXP5Kh9
         Ho0HyuApLfDJnfV0KIWHGVL4xeGycAgKdLMplPIR2oWrmLtc//uxDTAq/yAuqmVSMzMJ
         fvK8MGrkhlBYA+kuhjIoxK7FCwuGLTfgfMGFdrbgTVFBoKNwWCi+6p4VuuSzDnIOEdqU
         o3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969361; x=1685561361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSVYEUhM0zGHlDR1yqa5KIpwwPynV1rh1Z3AvIT239o=;
        b=Ky+HyMZbsO7UKY/vyt/tyrKO2TgxjEIb4mITOEkmq0VlQT28PBMxs8RAHjYmQm8UdI
         6efL8s+gONNNflHFp4Pu8O2mrfsScc2OarJ4NXit947wHfW+oSPMpV/yvcyIqUOgARMi
         IS6Q5LnGBsJF/EpFraj4pD9sRHOkbTWFLV69BX655pQreKWWec8rriNmnf4n0BjJreKo
         HeO+VebZcBRRcwfHAt+s8vwsEsBJtge6dr1R/GIS2Z3X3fsQcaMx/W8MtUwd+ywbpvjJ
         HF9meUKckJmxdCfYSNwGUoE2O7/UnZriXDOux5IFMYzrY7Yk0WE8t16X1mTcMdBHX/F6
         wErQ==
X-Gm-Message-State: AC+VfDzkQLy7G/PkKPDe7r4sbgIYPQ+isl1wM7FOKDfFHpt+Xfe3RMLU
	gWslTYOYIgOFqDzMERuA6lk=
X-Google-Smtp-Source: ACHHUZ6yreaxJl7mf5rX62OpE7ktDECZCzzaxE5NqOb8jR7RBUIdxZHYmi631H3wh4Z5BZGAmm3BhA==
X-Received: by 2002:a17:902:c712:b0:1ab:3ba:d2c1 with SMTP id p18-20020a170902c71200b001ab03bad2c1mr1428915plp.44.1682969360924;
        Mon, 01 May 2023 12:29:20 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:29:20 -0700 (PDT)
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
Subject: [PATCH v2 32/34] sparc: Convert pgtable_pte_page_{ctor, dtor}() to ptdesc equivalents
Date: Mon,  1 May 2023 12:28:27 -0700
Message-Id: <20230501192829.17086-33-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501192829.17086-1-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_122923_970375_9761A3D6 
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

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/sparc/mm/srmmu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 13f027afc875..964938aa7b88 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -355,7 +355,8 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
 		return NULL;
 	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
 	spin_lock(&mm->page_table_lock);
-	if (page_ref_inc_return(page) == 2 && !pgtable_pte_page_ctor(page)) {
+	if (page_ref_inc_return(page) == 2 &&
+			!ptdesc_pte_ctor(page_ptdesc(page))) {
 		page_ref_dec(page);
 		ptep = NULL;
 	}
@@ -371,7 +372,7 @@ void pte_free(struct mm_struct *mm, pgtable_t ptep)
 	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
 	spin_lock(&mm->page_table_lock);
 	if (page_ref_dec_return(page) == 1)
-		pgtable_pte_page_dtor(page);
+		ptdesc_pte_dtor(page_ptdesc(page));
 	spin_unlock(&mm->page_table_lock);
 
 	srmmu_free_nocache(ptep, SRMMU_PTE_TABLE_SIZE);
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
