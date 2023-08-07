Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647CBC07E8A
	for <linux-um@archiver.kernel.org>; Mon,  7 Aug 2023 23:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=joFJMqbKfKTecfmly+2Vy1wwM1Lf2ySrVvcYwK3f51M=; b=hXfayYxVag5e27
	Lit/jAO6rhi4TaGdOoYfMy/NSC27gKlvW81rQf6bYURlLG5xOgQdZo/OwUqK0PwG2GNGDANB+kcl+
	XDBfuq83Z7pyOLkjCvfoOQ1WOeGNZu5qy70wd1e/OXfLDXoaK7TKLQP5n6ZIEINUBwl9zbRo95KhS
	v65EKU/igXjo9BtDJxS6D9ZlJ5r9geGgXLF/VkPE7J7Zv8/JvC0W1zW3DDaUBgQf1/4aShdiCRrcc
	6Zmt1Xjdx4SGjHd3uubfOhn/8S2rRI7RWSmaywIjZrOkLafLouMLmtVw9I46/o/3YLLwn9s4+ZNHx
	Qa6VWdC74Uga5ywbiYTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9LR-0018QB-2z;
	Mon, 07 Aug 2023 23:09:01 +0000
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9Ip-0015P0-36;
	Mon, 07 Aug 2023 23:06:24 +0000
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a3efebcc24so3748421b6e.1;
        Mon, 07 Aug 2023 16:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691449576; x=1692054376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BaWlDiv5V7gFuBlQl83W1x9C2ZQPjYd5FMjDEEKLfk=;
        b=cpy8Xcl19ScHIaEJohMfnXLz1DqejMUY8L9glfoRJKsJ7GTvGcuQsYlnxy1uVil+vX
         sKLd/jl5n7/nYQY+c94D1q52xLTeGbCjuaSsuOaGb/1E2rdiSHktCUTDo4f7HqbeV+dj
         TPAGwr0CoWyRhx6mzwQflnUob8s/y/rCKdVhSwURC5eFFFvRnN/tn2Qy2PbiuytULAR6
         gF0MKwRWTHX4EnLLnTfGRqqibjjUEq59j99BhXKpF7aj2wSWqBVgMsp2RTnzW+/7J2fC
         DAIl8+bDSwnR/XjlkNOvluV6Us9KQMDrngkUDG9ywXNDgTmwYNXsy+sDpdm8duXtW4+4
         Ov0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449576; x=1692054376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9BaWlDiv5V7gFuBlQl83W1x9C2ZQPjYd5FMjDEEKLfk=;
        b=gZk4XXHETTxceZ5vEJiGmj9I6kjBOs0Xj0LkqJSxHl4MltMBDbu3JdiXOP+HrBK3cm
         9Jm0eapYsV3rwZXZWXQMoGbov/d6u5SO9s6VUrU5iuGfQ6w9TR5CD7BCtSICU3MrDlFa
         q/yMAuJ9lvYZz/cMXCQ8Hh/fx/2BZ0RNmtXWnEwXT5jAgb30jf2ERtjRef+Af3xk0KaD
         iGmmbFSQGPYpYzH9rRQjfOS5QAipga1Ws5A/8iwzpIu2ADG83YzZ375KH5c5zvy8AFjQ
         D+mdtv0xVJBVh7vjemPgvm/1X5HD75/Ghy5flllayVaoA7pnSMwvX3nK391UEVFR4omh
         p0Og==
X-Gm-Message-State: AOJu0YyZdq1URS0jtMNwzgeKk45BsLzsJ1El6xJJ5juGTugynz9FePxx
	wiy52uoEdDEoAlqGsmiJv4E=
X-Google-Smtp-Source: AGHT+IHyrg/p55954UWSWEFSK4VAgtzO3wGDAXzmBNoLynnb9Xv8FQKgcm7kods1XM481PofrT4NJA==
X-Received: by 2002:a05:6808:23d3:b0:3a3:e6eb:9c53 with SMTP id bq19-20020a05680823d300b003a3e6eb9c53mr13630414oib.23.1691449576353;
        Mon, 07 Aug 2023 16:06:16 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id d190-20020a25cdc7000000b00d3596aca5bcsm2545203ybf.34.2023.08.07.16.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 16:06:16 -0700 (PDT)
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
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH mm-unstable v9 28/31] sparc64: Convert various functions to use ptdescs
Date: Mon,  7 Aug 2023 16:05:10 -0700
Message-Id: <20230807230513.102486-29-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807230513.102486-1-vishal.moola@gmail.com>
References: <20230807230513.102486-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_160620_053201_4F18942E 
X-CRM114-Status: GOOD (  11.79  )
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

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/sparc/mm/init_64.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 680ef206565c..f83017992eaa 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2907,14 +2907,15 @@ pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 
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
@@ -2924,10 +2925,10 @@ void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 
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
