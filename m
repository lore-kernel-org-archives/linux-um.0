Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D81DC25B76
	for <linux-um@archiver.kernel.org>; Tue, 25 Jul 2023 04:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rE/AuJkwTDv5MQTWX7K8TPV1mOu+3EFvcb8c3CDflXs=; b=sPZSNFXkqnzEEd
	eNBLuLtAy7R4HaYVr/LKs4/uNmMquiODuJwGIwPrLuGIsjcc4ZEo997cKO5z436/CnwPJCUHgEDlQ
	B2UjN3qF61+A8PbLYFILcS9sW/RTgLyrwzc03tipEXoRLjVGNgjUVgAUSvtz4vcXOTaNy4iz6o5wb
	Ky3SG0F/Xyb9Q/NV9d0NjUFLHOL51e9Y9lnq20uMS8NKPSVxm5l+AIvBgRRMbB5ix9L0eq0w/NOuM
	R3Hu/hckhk200JrCxuEGq9YByMD6nBt7fbBw+nv/i9ZlVZY+YrQVbZQhFRE7PNpYZ2FqvV10RIz2f
	4AuFC3KxFVHQ46T2T5+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qO9YW-0067eN-2n;
	Tue, 25 Jul 2023 04:21:52 +0000
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qO9Xv-00672j-37;
	Tue, 25 Jul 2023 04:21:17 +0000
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-c5f98fc4237so4296906276.2;
        Mon, 24 Jul 2023 21:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690258875; x=1690863675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUMUqbW/uAIHfn0G4toP3JCuPKsaNgXF+JjYaBSaBaw=;
        b=p9s9prTX9rn/wpC0IRJR9+orYvMKxIQqYiO/2qc1ucIOxNaOErt5vfdpNKxEU6T/vv
         +2unp610u7/KZK91WoTQLcBH/VtkD3XUQxHC44CLkqpLaHmHFzgBPOO6uWyO/3jX9Xgf
         76GcUW4UU7BHeMr+SY/V25wW6PaanozuCo4EhC7wsdhYIlQKIrWatw16Z/wgKznB+Orn
         ruoMSNrGoRWxyM/OJxGteQSORJl7RZHeZVq6QR7pMySplhmG3+tZ02+FH1KXAFJgXdGU
         XCaHvNOv6BykhfTtnLqNaZvGHZmQ1vFu3nRlDk8gtK37Li+LTW7MffEEWNWOsyB37y52
         60nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690258875; x=1690863675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IUMUqbW/uAIHfn0G4toP3JCuPKsaNgXF+JjYaBSaBaw=;
        b=NB2Jk4Wk1KLoTxhL8n4eKprNG0atglerqVZOfBhXHqX7uhbAkYdyuSHkpsxhWDQZCI
         9yg84sOLDw0Ea7qW8xWyijsapxbVkv7dqF4db5ecvnb9KsXzZ0DnDHUN9BILcBxELTfN
         l8LU8Sd4GD7dQoEwmquQdbr74mlJ51yNxlswbeXBkwTW5MFzxQz9jIwv4U279c8sSr9G
         2O/eATBKkal4LQiUQi0++XYogdu3GVhZ5c9kjkq1j+HimWJljk1fO4nYLOmEDgsdEW2D
         teRkr2o8s6LacRuN4YdEXA/AES+wgZYat7tubDs01lcojnlJCaxr186AS4I1KLIzo0tD
         679A==
X-Gm-Message-State: ABy/qLZ4AA6Ln1l+UAg3aclhJXfxRgxoCBlBhVFhpW7sm+GqklAzHMor
	lq22ICRMJWiVydLQiuHio1r14UNTMZuiLA==
X-Google-Smtp-Source: APBJJlEMSP0J8OF6O819F/tTFVo5KNWedtuWn+u3qsGgdRhWZk0PUYcaZVFlVCsLViSNb2GRnqh20Q==
X-Received: by 2002:a25:6b45:0:b0:d10:68c5:233e with SMTP id o5-20020a256b45000000b00d1068c5233emr4343866ybm.60.1690258875202;
        Mon, 24 Jul 2023 21:21:15 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id h9-20020a25b189000000b00d0db687ef48sm1175540ybj.61.2023.07.24.21.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 21:21:14 -0700 (PDT)
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
Subject: [PATCH mm-unstable v7 04/31] mm: Convert pmd_pgtable_page() callers to use pmd_ptdesc()
Date: Mon, 24 Jul 2023 21:20:24 -0700
Message-Id: <20230725042051.36691-5-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230725042051.36691-1-vishal.moola@gmail.com>
References: <20230725042051.36691-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_212116_006129_C81673C8 
X-CRM114-Status: GOOD (  10.63  )
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

Converts internal pmd_pgtable_page() callers to use pmd_ptdesc(). This
removes some direct accesses to struct page, working towards splitting
out struct ptdesc from struct page.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/mm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3fda0ad41cf2..bf552a106e4a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2971,7 +2971,7 @@ static inline struct ptdesc *pmd_ptdesc(pmd_t *pmd)
 
 static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 {
-	return ptlock_ptr(pmd_pgtable_page(pmd));
+	return ptlock_ptr(ptdesc_page(pmd_ptdesc(pmd)));
 }
 
 static inline bool pmd_ptlock_init(struct page *page)
@@ -2990,7 +2990,7 @@ static inline void pmd_ptlock_free(struct page *page)
 	ptlock_free(page);
 }
 
-#define pmd_huge_pte(mm, pmd) (pmd_pgtable_page(pmd)->pmd_huge_pte)
+#define pmd_huge_pte(mm, pmd) (pmd_ptdesc(pmd)->pmd_huge_pte)
 
 #else
 
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
