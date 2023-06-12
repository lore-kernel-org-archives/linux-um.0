Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E37C88CB2
	for <linux-um@archiver.kernel.org>; Mon, 12 Jun 2023 21:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g+7H1qfIYf1fNGxI3Phvl1pS+jb8CrSRV05JjQa8MlM=; b=wv5ksyEhTBke9I
	z/yd4cr/lMVDVXquGCRUC0HNSUwvlVYvMj6gflul3+Ystj2yZhA6sinWHeqhpkB+825p55ymqXZaO
	itl3/46C6Sl8pjPrMUg6+1Tiyj5SWXpXMn//et2svONQNxXYmz237jz2wxXHkTkBS8izGIZNzKTWs
	ryrHbT2ZePe5T/HyO/Soi7ia2wJtRWGTrCiUgfWgB9LsP5mpHKnbrIZUcHMoAAje9d0IPvfthgBML
	Vp5+euP9zZ7Ccvn9FHNhHFrWEutnBvGdeeuy3o3qaSHqL/WpXd5U40zXQjBEaaytzkLgVtIEoshBV
	s5gcMwm57MnnYyCzncBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8olx-005Qp5-1i;
	Mon, 12 Jun 2023 21:08:21 +0000
Received: from casper.infradead.org ([90.155.50.34])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8ojh-005OBC-0S;
	Mon, 12 Jun 2023 21:06:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=cQ/uV998f7GBK3U8fEwXlOSI96PW+5wzkUNMHiphdSU=; b=WDcxvj4JBQ3yWt92tkTHp0Zk1C
	7HMkzLXUTcdqgtIFQYYm6NibATJ8ZQrKayzhIAkI3yH2tTZA7kjMNSdSVZzav0Zn7JETM5krZ3FWg
	JrxsFKBDj0yWly0Tl4/wggODP1sTLo9YDreQSsWShoTxuZHVASZNRFm/zM6n7heUhFJ0xjiMlLVUY
	j9MkvxlBu858zPoHwaKF9Q8kiNvwShcwloz4BaLSlQDxDUmwL/Rs/rFl6biNfttl6m/QJgDfPaay3
	ZEfbyON+ym20WFId37/myRIVdmPDXwhWpdeCC6ub8hObU3jn6zsMaJ5oN2YXC6K9H13VPRsK9DOn4
	YLpUnVMg==;
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
	by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1q8ojc-0034R5-9R; Mon, 12 Jun 2023 21:05:59 +0000
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1a670ac3650so1761321fac.1;
        Mon, 12 Jun 2023 14:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603953; x=1689195953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQ/uV998f7GBK3U8fEwXlOSI96PW+5wzkUNMHiphdSU=;
        b=Tn4mHghr2z50QboRcFFwBXnQDC7dmOVTmd7q6odwa9ofCDQNfilhaBNviFDHX8SrYA
         fagx19tWV5xnG2unDu30AzBD8hFIWArocnuzCUa1K7AMS5VYUgKKhDVTLptGD0WPUw8/
         ZX9JliY6gx8+hXM3OztwRe71m1A+kx2eLC7qxtJVOpdoP5HVloTMtr0/abQT4yyYQOzs
         IVhZgoGgAdf28rfS5OorktySibfeqB5FLW0b+HoIsUsy+Q3Hv3TNg2zjbv2EGrbvSAhn
         +UJqDlCblQUHBUCUqLriRDZ3qurN8WXPOHGnwhy4vkGIt3E2YX1KhqR56pPwBtbb673W
         dPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686603953; x=1689195953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQ/uV998f7GBK3U8fEwXlOSI96PW+5wzkUNMHiphdSU=;
        b=ha15z9bB4WlV6DRWjiWKGIMrC8rPdeb5I0JSfEHGeht5bjzHivJD/W1ymoC3XL0pPc
         ww2bSEgBQ198EFQkus0jCIQrsI2Nmr1vkhqMHiXNGzpfPseY3k4vmBuBE/Y0GcAix7vV
         IF/8p2VenVTcqklnCs/HONHuISaKouBrO96AQt6LstruHn6n0Qzt4qr67ukK1xkcyvTZ
         nPr61//0KB6omgfx2fBxWI1TDC4Nc0KJUypvoYQ9nOTdICeCanHkCTIJYqNHArTlaxC9
         aoRGALYH8qGmRMcGix4HT8pjQSd6G6C0CHPpkU54f+wKnw3I28kKlR6tG9AhjIHHVhJ1
         LOEQ==
X-Gm-Message-State: AC+VfDz54DQJJnNYX7Cpf/UGzjhfnVuzce+R25rg6gLO6aJ+4lByuPvC
	umtEAsXROsirPW89Vsvlzvw=
X-Google-Smtp-Source: ACHHUZ4ThTH5LM1afe2PTTFtQ0ZfGkzFFO1FbLLwGaoZUh9UZKP9YYPXqsENj3drsF2z7+M8WUTgQg==
X-Received: by 2002:a05:6870:2207:b0:19f:5701:8c47 with SMTP id i7-20020a056870220700b0019f57018c47mr6429537oaf.9.1686603953383;
        Mon, 12 Jun 2023 14:05:53 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s125-20020a817783000000b00569eb609458sm2757115ywc.81.2023.06.12.14.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:05:53 -0700 (PDT)
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
	Richard Weinberger <richard@nod.at>
Subject: [PATCH v4 33/34] um: Convert {pmd, pte}_free_tlb() to use ptdescs
Date: Mon, 12 Jun 2023 14:04:22 -0700
Message-Id: <20230612210423.18611-34-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612210423.18611-1-vishal.moola@gmail.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_220556_340184_451B7285 
X-CRM114-Status: UNSURE (   8.61  )
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
