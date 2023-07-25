Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D3CC05052
	for <linux-um@archiver.kernel.org>; Tue, 25 Jul 2023 04:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=muCHaq/XOEguiB8i+G1wsIfby4WiPAA7HzoO2bm4syI=; b=Lrst3w+1V/UiUh
	Wdfq+2hGMmdCN2t/4w7yPO1+KUUqb3QDFKmsPXuXuM4hWVNQDWF2lXpSZ/analQIRfN1OKy4jxWZt
	T1opbnoSc4RpCTgHI2dboRtP0ZlSUsjLpxJQ/hylUsF3Gq3T4JNkZWX01XP5zHvP0KQfpKE6DBKYT
	G1S5JQev11jtyjo5rB+yAabRFMSZ0h0StJpI7a1fNcEGRjhwyH2nW/XZpic7X9AVfzXuuYea8A5ub
	IoA5T0LO0txrxs/pADjAZRVl6TLCGmV0vt2tGnVgadRIRJf5NDYq4mgXJW8NRQKbxMF+WnleaCyu/
	VE+YoFYQrrIz8AYSpnFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qO9c2-006AlE-0O;
	Tue, 25 Jul 2023 04:25:30 +0000
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qO9Yl-0067sZ-1S;
	Tue, 25 Jul 2023 04:22:08 +0000
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-ca3cc52ee62so5589360276.0;
        Mon, 24 Jul 2023 21:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690258926; x=1690863726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9EaWELDe99nUon5K3Z+iJo2yPeaFSzyCnD+eyoagSI=;
        b=qNSUsqiVKVB0ESH5eMh2318rltbeTzVNrLxONrPQx/nleyciLPoBJAEyvEQiA5s1Tn
         685R6sAh2RRkBOJ+dHhwwHaTsDfn1Dq0fhp7maY379FRtPvlZFAioZBWPPk7fa1Wkq01
         qN75vY9UJqWiLkOixY4L6XdTPAaqKlrcR9SWRLlUZxoXjG975sFhxm21WZutHmQKl3h2
         OQ9WcHoISTJ2OjIGWYQNx9W6xFSNLrPRAFCGXfmCK8TcPNzYvmKngSTkC45cBTIzIEjY
         73sY0YERl7Ohg+xplAh/xTNZowvdAeC+fipfIzPvDIC0nmap4j6fccJNDYEXWoxWM6gV
         WCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690258926; x=1690863726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9EaWELDe99nUon5K3Z+iJo2yPeaFSzyCnD+eyoagSI=;
        b=H4tBnuwgwBiO5YCoIzZqTBuLc85/9WkwNiSxl0Su3AB4IT2C0brqvvDZARTRGJ3fPa
         w134VcJilPZcgw56rUP2nqg8jRCOudqAfMjPg8ERhmnTrLj5S5HTfpBrNRRNgHGMa7vG
         E4rTiVmlenpWTooBcNp0hz2ieltcwf7EIoyj7MFwaSSFoG6xDPnB/Rbt0Jgl63uaot9b
         vZloH+ttuWcxybQiT7RYbCJRD4OfLGv2TkT7ydPI/W3UYtQTMyNxDVYeXKXL9jyA3vts
         Ju6Gkqlj4e0e7EuM8z8WflCg4tOZDCaiienw0limzWriGw6Wk/tMFQqtAw1vPSSlpNYV
         GGqA==
X-Gm-Message-State: ABy/qLZF7JErYtukAQYY03gbeSD2k6cOwIDV29d0gmUFYuocYISjHg5a
	SFCAo9g9j7kpzjzbKV34kwY=
X-Google-Smtp-Source: APBJJlEYsYvwES4yIHo2kt7NPKD5Twgr2oGLJnzn9f7qzh6ZvPXJtQdH1+pOAmNJT4cd1ABpvr+wDQ==
X-Received: by 2002:a5b:88e:0:b0:d0e:3831:fa2b with SMTP id e14-20020a5b088e000000b00d0e3831fa2bmr4772882ybq.62.1690258926669;
        Mon, 24 Jul 2023 21:22:06 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id h9-20020a25b189000000b00d0db687ef48sm1175540ybj.61.2023.07.24.21.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 21:22:06 -0700 (PDT)
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
Subject: [PATCH mm-unstable v7 28/31] sparc64: Convert various functions to use ptdescs
Date: Mon, 24 Jul 2023 21:20:48 -0700
Message-Id: <20230725042051.36691-29-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230725042051.36691-1-vishal.moola@gmail.com>
References: <20230725042051.36691-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_212207_524718_2212ACC3 
X-CRM114-Status: GOOD (  12.31  )
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
index 0d7fd793924c..9a63a3e08e40 100644
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
