Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D61FC7EE2F
	for <linux-um@archiver.kernel.org>; Mon, 12 Jun 2023 21:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uhd9F4X78q6P1Gv1Gu3phYYo7qmwqDh6qFvJSFGJc6g=; b=xGkFGbKVL3laxb
	NG0d9j7KM2VPzQmO2KYA1gUL0ex0MFgiuiN2mrwFTrWQ+bAa4E20f2CmjioTP4rhKM1+GdYT18fOz
	gLFYdhrzAI722wC0K6ZTwvWGOwc/KO3AOadgIdMVhsImed92KgC48B2StJRBtGDRnjyYtb9znf0eM
	CI65AdbQWxlXP66vExkETDAdkV/JVYbpQHm4qSgn0qRDZaFqZGh4H0DrnE88Oua0dzT2oTOzPZwEa
	hJa9N0g5HZiwtXki16z7/NBwZAm8wgkSI/A4KnppC8pQjKwTL5tMrhHu4QsbDm3K4rLKT4d1u8ejL
	SoqrFz83Wfb+64hBnUwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8olJ-005Pxq-0k;
	Mon, 12 Jun 2023 21:07:41 +0000
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8ojW-005Nxk-0p;
	Mon, 12 Jun 2023 21:05:51 +0000
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-56ce372ac00so20238447b3.2;
        Mon, 12 Jun 2023 14:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603949; x=1689195949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6EpXhLB/ZnHGYzIKEyphwqiyS9zUDTms38NuP0TFmY=;
        b=HZjqN37hCOK48cvGmZP3MyXHPsSWerODKITkESa+8okEvm66QeHMRWeJrMA+h9zAy/
         b08e3G4t5lsUUKbLUtaHE2GPHfm2Y6f2xgW3YiErhjVlP8jaPnDQQDBBPDgWToXRn7mW
         PpzBiVyA5JSxI70xxYGR2PwmojuW4ejIHH6298KzStJQkqMFOYKQH99Y1J/uWKo9ZDSM
         eRMw42CLQFJ3ndhOIFwgLE2rhtWcbpTrYEwDV/LXUoaY8xrQBL0kpr9KnDHMQo57XMNA
         dJaliHJT5dELYDcW6j8kH/iUc98Tn/GD3Nr/eiXjSdRocwfmdaU0ArfMHM4wLvGwtdMu
         leiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686603949; x=1689195949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6EpXhLB/ZnHGYzIKEyphwqiyS9zUDTms38NuP0TFmY=;
        b=cdbUaWWTXoASCYowOay2APn7sdWwQKzApR2hLEwYb7RTZ4oGsOTvYVusApyc4vmBOz
         sejnZTqZ7rKlYrdrRlW9q4B5IlKg4TFIt0740+O6HOjw0SunPPIaZLBmWklVBEIccUDS
         g1jDEtui4+K2jx9tTHdlSqPWhrlteGDHILZk26VlA0K7uRGTi6Gke1KETsm9KYHbPWm1
         5aV8fOv4BkLvJUWXSg5nZfBK6Lj1esBowoR9Y7IpvtT6w8m6sXAukt/zSMrneL3g5sno
         xPmUtT18AOjoAZ4EIYb72irMmjxThLcORA1beuQFYbLbde9xW8728iCzNDZdK0O5KP/N
         GKew==
X-Gm-Message-State: AC+VfDwRNr0euG56MFG9Z+mJ2ON8rdFZALJ2HyFHLMtMzCLaC2qnHFM5
	Zy99orQQIcU8oMRWXw/A2co=
X-Google-Smtp-Source: ACHHUZ45RyLy6yl6Drr+w1zJryROJeWNSP67xpIchmrzxG/I82VOblMbJJSkZ2edvv8Qj+2hZ+73Vw==
X-Received: by 2002:a81:7bd6:0:b0:565:d517:e714 with SMTP id w205-20020a817bd6000000b00565d517e714mr7606123ywc.25.1686603949233;
        Mon, 12 Jun 2023 14:05:49 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s125-20020a817783000000b00569eb609458sm2757115ywc.81.2023.06.12.14.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:05:48 -0700 (PDT)
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
Subject: [PATCH v4 31/34] sparc64: Convert various functions to use ptdescs
Date: Mon, 12 Jun 2023 14:04:20 -0700
Message-Id: <20230612210423.18611-32-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612210423.18611-1-vishal.moola@gmail.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_140550_388786_7B023B85 
X-CRM114-Status: GOOD (  12.00  )
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

As part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents, convert various page table functions to use ptdescs.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/sparc/mm/init_64.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 04f9db0c3111..105915cd2eee 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2893,14 +2893,15 @@ pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 
 pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
-	struct page *page = alloc_page(GFP_KERNEL | __GFP_ZERO);
-	if (!page)
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL | __GFP_ZERO, 0);
+
+	if (!ptdesc)
 		return NULL;
-	if (!pgtable_pte_page_ctor(page)) {
-		__free_page(page);
+	if (!pagetable_pte_ctor(ptdesc)) {
+		pagetable_free(ptdesc);
 		return NULL;
 	}
-	return (pte_t *) page_address(page);
+	return ptdesc_address(ptdesc);
 }
 
 void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
@@ -2910,10 +2911,10 @@ void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 
 static void __pte_free(pgtable_t pte)
 {
-	struct page *page = virt_to_page(pte);
+	struct ptdesc *ptdesc = virt_to_ptdesc(pte);
 
-	pgtable_pte_page_dtor(page);
-	__free_page(page);
+	pagetable_pte_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 void pte_free(struct mm_struct *mm, pgtable_t pte)
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
