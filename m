Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0690EB64DD
	for <linux-um@archiver.kernel.org>; Tue, 27 Jun 2023 03:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7iH1ng0NHTYmYaPMglgNZpV/ZIkk8TarLBJGL9DDqVU=; b=pimAbL73tDw0cG
	V6Nr57VJdLdTIiPyNbo6yePQuaBnE3Qjl1EPZ5dKnZk6BQfQMcq4UZdVrtQAlw0yU7nxTX8CKSWV6
	DtKWRG0LbWv460jiv7HG9p9YnSJ7Rwnb0EJYfBXdD9BLIRFo1i+63CE+518vEDGlAUwlH48aKcdgE
	WlqTVNi00R69YwDChgMY8LAM+Wyok+KnKjCSijjjVs4cyzA9XlaMae+bjFyyp6Eim4CWBQfIkhQgd
	nR6bqHhJuXDKu9x/B2x3wUxhS1MOaT1WM2jqyKgY7Ew60aREW/BnpSb8zhPPvmORaYRktmORIuzEn
	N8qo8RWL6CrlAt+/hvXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qDzEX-00BZ16-1T;
	Tue, 27 Jun 2023 03:19:13 +0000
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qDzBT-00BWBM-2O;
	Tue, 27 Jun 2023 03:16:09 +0000
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5700401acbeso42707387b3.0;
        Mon, 26 Jun 2023 20:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687835763; x=1690427763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOzSOLTncjJXn0AvJQqE6PD7zrtBe8MIuyz5zw7TzDY=;
        b=pYu/np5E02v9D4l9kp2NKvJbLly/W4E/pytzpciEjQbyT6+cb3MtewkIWSZ/wCYqXd
         G1Xr/QkETq+9GbOV2yhW+2wZnwokC/KdlaanhyggpRl1yOJr09K81oiMFpOqkCSKUN1U
         FaF0VsjnMFKldVgjw5dM4Iy6YMJ/sIWl4pMPKU4lAMjDSOWrwT/y3HEK7DZHkwf96llK
         iirmdX85Js3ztXjDiHDLqtShs9EXg3guUWkHRosbVKtQGujpNsiEApphQ37yRcHluKce
         hLpePft/RQblwSLVA6U8/x8zaLVFAB0Ea9ymuNJLOKqGjd9fA49LoIOpslhGIKWxr+Yx
         skeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687835763; x=1690427763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOzSOLTncjJXn0AvJQqE6PD7zrtBe8MIuyz5zw7TzDY=;
        b=XnJzAI87wVXvPPosimMalnhoN1DnBR+/YWedFi2Okga3/wW+3xvr8vOHEtXdRojpOj
         s1E+BS/SfmNFCxZaEuputnd28TgEfu20ltAE9crbIDs2HUPhc2IcoPeRuQgRk0ZhBDv1
         nu/tnI7NPqpzsdwJLG7FIMxCehQ/gJqLOvVkK9g7S04FFDuIQrD4vi6P3xqXUBBnkRSL
         1i2expbgq9kO66sxi/slgX9ShJn1bK1QtI+FcurVPtvG/JwNOYeGyIMfhls28rtkpstn
         nRY4BhFjsglfwdpIPvR5cOf92Cxv37eJDgeZ+fe8afjhT5SAZSZzWdXsHO0eRrpYK//p
         pudQ==
X-Gm-Message-State: AC+VfDwI9glYD+TQdRS9nZzReF/at+tEyrO5DUa4JVzwETQcs+3U9Wsg
	8EYv28oOy9GkNGHMW0aqrnI=
X-Google-Smtp-Source: ACHHUZ4sbsRgQIL7xgoFeCT8hAtH3rltXvvkgvi4T0uDEBiqb265+aHLns97dzgLS2JgA0bF/wvN3w==
X-Received: by 2002:a0d:ddc5:0:b0:576:8a5a:87e5 with SMTP id g188-20020a0dddc5000000b005768a5a87e5mr10382513ywe.26.1687835762791;
        Mon, 26 Jun 2023 20:16:02 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s4-20020a0dd004000000b0057399b3bd26sm1614798ywd.33.2023.06.26.20.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:16:02 -0700 (PDT)
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
	Mike Rapoport <rppt@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH v6 26/33] nios2: Convert __pte_free_tlb() to use ptdescs
Date: Mon, 26 Jun 2023 20:14:24 -0700
Message-Id: <20230627031431.29653-27-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627031431.29653-1-vishal.moola@gmail.com>
References: <20230627031431.29653-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230626_201603_795732_EED00F84 
X-CRM114-Status: GOOD (  10.84  )
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
ptdesc equivalents.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/nios2/include/asm/pgalloc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/nios2/include/asm/pgalloc.h b/arch/nios2/include/asm/pgalloc.h
index ecd1657bb2ce..ce6bb8e74271 100644
--- a/arch/nios2/include/asm/pgalloc.h
+++ b/arch/nios2/include/asm/pgalloc.h
@@ -28,10 +28,10 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 
-#define __pte_free_tlb(tlb, pte, addr)				\
-	do {							\
-		pgtable_pte_page_dtor(pte);			\
-		tlb_remove_page((tlb), (pte));			\
+#define __pte_free_tlb(tlb, pte, addr)					\
+	do {								\
+		pagetable_pte_dtor(page_ptdesc(pte));			\
+		tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 	} while (0)
 
 #endif /* _ASM_NIOS2_PGALLOC_H */
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
