Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526DFEB64DA
	for <linux-um@archiver.kernel.org>; Thu, 22 Jun 2023 21:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7ad8amYvZsePfvXywWgG8TUbn/SxCAFzV0Jv+QGgwkM=; b=yALK46ndq0kLS1
	QWolKTwLWzIQk07ij3pchi31hux8bX/egHt/HvE4S50aOkEhyanc/ODVUOi8tL0/mpFX3vl2lldRJ
	aF7V65KoTs/dTnEdWdXwKJMGIhciR3XCZcGGr1hqm1kPjJDFFP9wWm0Q7NZTeUBwwSonLwk8nIP/K
	f7cvk8FEBRv6Jqiu6J5sLg2xLqOdB5A1Pe2MtzoKuDwAVFLvIomw+87+pUwia3pQCWgDW9bsmN8+K
	TY/FJgbo16lQiwGl+mG7+bykHb6j1l4/5hcBGLz1z2f6jsea4RBIIaQEoR3gip9ggT3t/nG5aalSx
	/OOPSvlWCXE4f4HVq52g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCRRw-001ly2-0o;
	Thu, 22 Jun 2023 21:02:40 +0000
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCRON-001iUO-2A;
	Thu, 22 Jun 2023 20:59:01 +0000
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-bd0a359ca35so6103026276.3;
        Thu, 22 Jun 2023 13:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687467539; x=1690059539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2x+E7/HO6cxS1FKNHsH+YAjV99GeoJ7wX0XOkEEtc8g=;
        b=YrTQVBS1aaA3+7mVapNSFssjb2+AQ4IJNUOZvGKIi0FFDtk+PI4lWjji8UMW0kBniw
         NnyjjbhzJwR9iWxQ73lOHY6xUHgKO2FQSJubgoxvZQoc6uqJluiv8iO+GgjzyRPTTUNL
         H+9Lt9/vRpqFrdhngSNsPgL94g8nz/f64RVJUcVyBqSkPnGnipXpH3S7tTsIQsIL/Sfj
         /1Ey+dh+UNfiOBDZVuuR0MUQqWyu0BLKscPyo1/sCfwSnYduy/XWfVP10dsKPKfMX/jd
         CyoAvKAcNWnuFLqmsDX4R/ZAToeYgRboOEEoeu7mlCBRRzYoIoPibXR4stY18tIHtLmi
         9aNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687467539; x=1690059539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2x+E7/HO6cxS1FKNHsH+YAjV99GeoJ7wX0XOkEEtc8g=;
        b=ITccLnpo82uJfyPJtWSs4GyANpdXkDQnpEVmmqc9N2q9X4fL2vMxx1HyjfK3QpY6p6
         MlGtnvBARs+wKJIU+H2sbZ9C1SHGid9x7bY+f/vpA88Y9OxJymNzLo4c29aHoUpL0kD8
         SKbbB55rHJiPSwnVuOIIEk9j93bIGE5MPuug1kYvfL+vJH95XQOE38n+7ifQL0sIanDg
         p9OV98DPkKCR+Vt8dc+JOwJHs9HtdJ+Jf+daeH2r8enbTffDzIGV8xq8rOQr5MkXYyAA
         7bn7lxrVCa8DOl0mGDOhGKEv4HMnFC1uUVM7jnn1gbdyY9dazPy/kiTTRkkMvH/ZA15E
         LvSg==
X-Gm-Message-State: AC+VfDzukRDkVjZwrcHru89HPXW3NTyKfngn8XzIpIcty5xNoCXYJvOe
	E20QoKtJXM8dwgNdqR1qAf8=
X-Google-Smtp-Source: ACHHUZ7RSJK82blK0n8uMP8fjUDg81SPK6py6Hg2BA1/I5Xa80rVzDG2S/aTt1mnsQBJvwPYu3STMQ==
X-Received: by 2002:a25:2102:0:b0:bc8:914b:c83a with SMTP id h2-20020a252102000000b00bc8914bc83amr11442005ybh.22.1687467538676;
        Thu, 22 Jun 2023 13:58:58 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::36])
        by smtp.googlemail.com with ESMTPSA id d18-20020a5b0c52000000b00bc501a1b062sm1684937ybr.42.2023.06.22.13.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 13:58:58 -0700 (PDT)
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
Subject: [PATCH v5 30/33] sparc64: Convert various functions to use ptdescs
Date: Thu, 22 Jun 2023 13:57:42 -0700
Message-Id: <20230622205745.79707-31-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622205745.79707-1-vishal.moola@gmail.com>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230622_135859_741268_058E161B 
X-CRM114-Status: GOOD (  12.01  )
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
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
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
