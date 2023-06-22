Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA57EB64DC
	for <linux-um@archiver.kernel.org>; Thu, 22 Jun 2023 21:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pDOvlXoX4dKAjzZz3kguE4iLNhiDzS6Xu4AC3imhvHc=; b=BEQteTqBj3CxDA
	fhcLwCUZ3/kTXbymD13dwGDaklYyONRUxe9iml2rTtCpQ8sizXwOd2fxyMWNvKIXZfwoI/+Gw7Jc4
	+A16Ua+PQdDN5kuPFKFMPab3lE/TGaZKb8VhBum1XAcU5xpXkKVPpiDdkRnYcfGNYSRtkMVRcD/c2
	Xz79PLWP4fnEqsUsMpkxPUFUMPOTaP0ZKv+MKkhJ36ec/Bsv0Z6aJMVhuXQctVlaTROrkfjN9RkbD
	KDaJ4POmSe4zm3lUHRFpndHbFBCoKW5se3iKvY/dFBQunQDA1TDgevGfZUc7OzNdb5xu17HTHLTrP
	QTYNIM/kcD4JZfKtU02Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCRSG-001mH0-2c;
	Thu, 22 Jun 2023 21:03:00 +0000
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCROT-001ia8-1e;
	Thu, 22 Jun 2023 20:59:08 +0000
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-4753de0807dso1171547e0c.2;
        Thu, 22 Jun 2023 13:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687467543; x=1690059543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRfRtQSkmDpdaHgWU+x8J8rVDSFtmuGYMRjnXDV0vQY=;
        b=JIPmtJWZzsFuYAbPd3iclg33SdIOk6GD+7bRoJGsXkLCA1qQrwoboYccPvVKSwty8z
         /qB14KJSfGNtyZY8gC2KXxRSZzLDqLeIztRDYfuoehM6XT+tgKnz6817MlJhyGs2y+Ff
         nzC5sPDHJyAHEqzN9xTnBixLp+PW75W3jhf77P4PsuZDMkZ6OcWV4Xi+Rqew178LHkOZ
         sutRPAF9NDYk2/4a4fGlPwKxe3Z/pKSq61jE0ZBiyKHaHi8RSPhHJpH4MRgs4uLl46tG
         QM0pvqokM6W0xltWNxHmZb4kL6K9Vi53nErkSfWOsX8epBIiO3LuoRLa0NZXa1LOWk1D
         I+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687467543; x=1690059543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRfRtQSkmDpdaHgWU+x8J8rVDSFtmuGYMRjnXDV0vQY=;
        b=FFQVaOiMXIbAXtP+6KKVb2qohDbRucRIB8K6wIP+khiN8Lj2WznVW4ei32/JWALc9A
         XtpG2akuq2/qW1Pb60Pgx7+ncW1ogSnJ8U1t0QqL314V5xcpRimddrNQtV6++JzQgxSE
         cSwkfd8v1AaXHB48W8JC6EoEzPmMc3IacYFhfvJyolpengoPlo7lw493qoT1VPK7EEz7
         0ENOsYL5OvjjuMIa9z1hV/q0kFiGS6+iO72NoMZ2Vce3moFXcPFf1IAls0qGvSwrHBAk
         Q+b9fwmLOFpI9JtwlR8LcPiDSbvZW9CUF1zyQ10LHHuYL6MU1qg7ntsuNxTf7xbGrJnv
         VNSg==
X-Gm-Message-State: AC+VfDx6kClPfjJPJeEB8QqKkE/XYuAtA8UlpDQEkQv0nnctJtYGqmqN
	OBaVm0v+PPfX1oHedoQy1UI=
X-Google-Smtp-Source: ACHHUZ4B8dweYtEIi2rY8Mw0qtzsz5NxOVUlUIQPQfiDh4wzrLYoG70uIa1HADP+PMU/T07FaShgdg==
X-Received: by 2002:a67:d087:0:b0:438:d4bd:f1f2 with SMTP id s7-20020a67d087000000b00438d4bdf1f2mr9462119vsi.22.1687467543144;
        Thu, 22 Jun 2023 13:59:03 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::36])
        by smtp.googlemail.com with ESMTPSA id d18-20020a5b0c52000000b00bc501a1b062sm1684937ybr.42.2023.06.22.13.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 13:59:02 -0700 (PDT)
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
	Richard Weinberger <richard@nod.at>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v5 32/33] um: Convert {pmd, pte}_free_tlb() to use ptdescs
Date: Thu, 22 Jun 2023 13:57:44 -0700
Message-Id: <20230622205745.79707-33-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622205745.79707-1-vishal.moola@gmail.com>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230622_135905_597318_782508B4 
X-CRM114-Status: UNSURE (   8.86  )
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
ptdesc equivalents. Also cleans up some spacing issues.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/um/include/asm/pgalloc.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.h
index 8ec7cd46dd96..de5e31c64793 100644
--- a/arch/um/include/asm/pgalloc.h
+++ b/arch/um/include/asm/pgalloc.h
@@ -25,19 +25,19 @@
  */
 extern pgd_t *pgd_alloc(struct mm_struct *);
 
-#define __pte_free_tlb(tlb,pte, address)		\
-do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page((tlb),(pte));			\
+#define __pte_free_tlb(tlb, pte, address)			\
+do {								\
+	pagetable_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #ifdef CONFIG_3_LEVEL_PGTABLES
 
-#define __pmd_free_tlb(tlb, pmd, address)		\
-do {							\
-	pgtable_pmd_page_dtor(virt_to_page(pmd));	\
-	tlb_remove_page((tlb),virt_to_page(pmd));	\
-} while (0)						\
+#define __pmd_free_tlb(tlb, pmd, address)			\
+do {								\
+	pagetable_pmd_dtor(virt_to_ptdesc(pmd));			\
+	tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pmd));	\
+} while (0)
 
 #endif
 
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
