Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1B8C0015E
	for <linux-um@archiver.kernel.org>; Tue, 27 Jun 2023 03:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s+Ye2mLLXaoC3d4E+fcQCpSKAefOyxQhXybE9M4iEHE=; b=NYZtZj/orz+syA
	l9OfDgnnTEzOLtrJbWItkE4PdMaL2XdyJr51R2yjdT0TQDgDUwXr4yv5Gv+o4kAosGJGWL0hbdBPk
	m2Xask2W4D+3lQDevs3bhCBlrLDsIVOiMBLit/DocB+hHmEGMz+PYXOB0kXvZNuNKbS7Mby93I7+k
	8tet2qTqUqUOPTD55XZ9Jht+9zOMNOwtzI9QJv1xW70BIi3G4aFVBI5rTQjWXsajTg0tKfNxPAa2n
	TSmzBUVr2KRsbbwSObzVNKv9qOK0sWViFe1QaVYzwGH0E9PPoIcvTVsdsA2hlIipFIqB3sJ3IXKiT
	XGvvY3KYeogljh7NOoyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qDzEl-00BZJ2-1p;
	Tue, 27 Jun 2023 03:19:27 +0000
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qDzBe-00BWNR-1x;
	Tue, 27 Jun 2023 03:16:19 +0000
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-57040e313c5so62559967b3.0;
        Mon, 26 Jun 2023 20:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687835773; x=1690427773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ES9RfFz84BcV9KH4Nk3AfkjPOEvVVRdPbPMSiTejLcw=;
        b=dLHeJwfXKaTxpO4c0sQBm93zd4wQrUxFt2CjFz5qWQ7T65DNPYbc5uKxnR+eK0IL7t
         R2V9BA+60dIzn1DRHNiAM8OyrAJAml6DoS1l2PV4PYnoH4WUW9ywNy9TDf3yz7ME+vFq
         NLGTD2cyLj0S/PJY2GAWd4utoHoRGPP+jS/tnomFzM8g/lVPns4ABJt0M6rzW8rsiL9B
         m29bDYcQGdb38WDxMbx9Hk40CYhBq3UtQSCa5gjYXZKOF2lc/8CEcIQNZ6Wo9PGTUZtN
         IYAVdG9F0aChBdAkISeJXlJPZbPB7Nf1GhV5RWEzzuTieYJGBF1MgcwOgT5miNq4avun
         mLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687835773; x=1690427773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ES9RfFz84BcV9KH4Nk3AfkjPOEvVVRdPbPMSiTejLcw=;
        b=lTif0xfzrfY27G11HXFqB2CMlu9E6sQ3yiwEYQ++LALmWz3qFGNbBvdTbHdY/Qo+ig
         /ocriQpvV9yFNhMXbKn1lhlwKbRpRQFpCjVt7DExN+ey2e2CR+gq9JZsc8E67k5uxJjq
         U4t61UHIeybuye004pjtf0SmcaOqJmgx+CgaeL7hXM9iXJf+wFbV75X1ba7VBGr+561u
         NwGX8aE1fI0KWbtyS8PA1spETgeDI84UjJTTmJSZpBkczqtFr7ETzagjL8r2HOMyCf5m
         RnAEZlwEo3tqtCh98VBRn62hBEq+2Vo9kSE24MeITq57q1Oxlg0OJksM7vm76uhiKUM1
         4Qxw==
X-Gm-Message-State: AC+VfDzuoCCGHKLg1mRj5dx46yBFZf5LbrPvlxR+O8qhEnoD6Je4Ju1+
	itlnpBvCaSIlGNPcdctC2HA=
X-Google-Smtp-Source: ACHHUZ7mviCb8EMix7g2GoIipUtqwtEpnZ4nIwFH1XOniyUWELa3iqb5sNl3hiYnjR+jSDWsaWi7Kw==
X-Received: by 2002:a0d:cbcb:0:b0:56c:e5a3:3e09 with SMTP id n194-20020a0dcbcb000000b0056ce5a33e09mr43279069ywd.15.1687835773500;
        Mon, 26 Jun 2023 20:16:13 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s4-20020a0dd004000000b0057399b3bd26sm1614798ywd.33.2023.06.26.20.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:16:13 -0700 (PDT)
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
Subject: [PATCH v6 31/33] sparc: Convert pgtable_pte_page_{ctor, dtor}() to ptdesc equivalents
Date: Mon, 26 Jun 2023 20:14:29 -0700
Message-Id: <20230627031431.29653-32-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627031431.29653-1-vishal.moola@gmail.com>
References: <20230627031431.29653-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230626_201614_694013_18D32FF1 
X-CRM114-Status: GOOD (  11.14  )
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
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
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
