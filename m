Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC79C27C41
	for <linux-um@archiver.kernel.org>; Mon,  7 Aug 2023 23:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EjQFH2WRphN0WEB6E0YTgbInaO0jH45uUomsUuEqeZI=; b=fgH4zWZlb4yKu4
	iMzuR8asUW/IB9aEX9Vd1Ibmgon3g1CTIIzhmql+Cr39fxnxAx+/Uv/1ynzHc5Y3F1zuCavT64CAI
	88VLNtEx6tmz+Hnlne2LUvnWlAwvkZ3yzx9JfFv2jxSF0Ig4mvHRsrxEN5JvxXw5EakTocCZOj3eV
	WU69tCyfom127TNr/uG+BbNW87nsyaRiPqLZmqIohPdtz9C/7tMSvGR+98H9mJbDjNU+vcGsGj5Ib
	F1jLSb0JD1uzlPgzDb2KgUZ5H2ndQuZ3czhTAO1KeQ0XvxQRfVWlaXyhTQnIjA215PDgSUBbYugfM
	lVLHkItYMMiFzzvc1EBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9LF-00188J-1P;
	Mon, 07 Aug 2023 23:08:49 +0000
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9Ii-0015JT-2W;
	Mon, 07 Aug 2023 23:06:17 +0000
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-cfcebc33d04so5106581276.2;
        Mon, 07 Aug 2023 16:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691449572; x=1692054372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpbBCMkwg1WbsmcEnKHREFultw/IY4tG3Jsqz6w0a8E=;
        b=nS5J1UYk8f9msjmOJfcwkB8RnOSNZv60DefW2TDIHuOlvS9npGk8oT2LZd+SySl8sv
         g+gjV1veIOE2SNGvcFOMJ1pPimwLTZ7+pvFQ4bVBKr+eOsPpBFIPNto8klZeZdDlbFxo
         wkyNcA7u+kweH04q+BG4NvsUNaK7E9zibuZ01wwXmu5qj90Fw+mY1pf3xcSZWMeZa7wK
         aGRqh9CjWX7iCRUWp+ZrbhBol1e4MCC8JBlzqolLSWyg74wpF8elWEgkI2Vj4oenaGhD
         isx7MJZrX54CbrhbHsj99pEt0PqmBmGh9HnsD2DaWM5Gm6veS11IW5m9dzOKe44sU/M/
         md6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449572; x=1692054372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NpbBCMkwg1WbsmcEnKHREFultw/IY4tG3Jsqz6w0a8E=;
        b=dSPN7RLAcZ8mEHRPGEQJF4Fx0N6SuHloHXir/Wto7rQ0yBPsawJBmgcx7xMg3s6NKO
         vSyeAExLYvhAcuELx7L7+7W42hczFq4nbC2+knVby6+xa3ypxd8fpxjNs21i1zrXm0nP
         vMVYy/2BPwTAjVr8twxaaNq3y8nV6I5WF2TeNJsZ04Nj6yFDtWwAbj1fhegVYh4FSBRl
         dEe4NNFI0UtxN63WwfYmk8pe99sGQ0ho3xFZ30iLabtjpwS8T51yW3RgTsXEHpGwAalK
         slZu5qkK64ewpAXD2lFf9SthKaT2FwROdrAuJedmAFQdp5sChCrEHmBxYWuZ05NkK5BO
         rSog==
X-Gm-Message-State: AOJu0YxQhmFdq9kYgDf0SuP2XvfQ04G6ZY/wU4z4sHiEcsH/07a0N75/
	5JTkDAFycocVN8Z6jpKwCns=
X-Google-Smtp-Source: AGHT+IHFLqgFAthROKM1yjg8aTn4QAXhjx425iARLy/TVdE1z6PZIG9RjSxWoTmqjhSqLQZr0gTMYg==
X-Received: by 2002:a25:d24d:0:b0:d0a:127e:7478 with SMTP id j74-20020a25d24d000000b00d0a127e7478mr9478817ybg.44.1691449571835;
        Mon, 07 Aug 2023 16:06:11 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id d190-20020a25cdc7000000b00d3596aca5bcsm2545203ybf.34.2023.08.07.16.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 16:06:11 -0700 (PDT)
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
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH mm-unstable v9 26/31] riscv: Convert alloc_{pmd, pte}_late() to use ptdescs
Date: Mon,  7 Aug 2023 16:05:08 -0700
Message-Id: <20230807230513.102486-27-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807230513.102486-1-vishal.moola@gmail.com>
References: <20230807230513.102486-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_160613_019153_75A6AB0F 
X-CRM114-Status: GOOD (  12.10  )
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

Some of the functions use the *get*page*() helper functions. Convert
these to use pagetable_alloc() and ptdesc_address() instead to help
standardize page tables further.

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/riscv/include/asm/pgalloc.h |  8 ++++----
 arch/riscv/mm/init.c             | 16 ++++++----------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index 59dc12b5b7e8..d169a4f41a2e 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -153,10 +153,10 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 
 #endif /* __PAGETABLE_PMD_FOLDED */
 
-#define __pte_free_tlb(tlb, pte, buf)   \
-do {                                    \
-	pgtable_pte_page_dtor(pte);     \
-	tlb_remove_page((tlb), pte);    \
+#define __pte_free_tlb(tlb, pte, buf)			\
+do {							\
+	pagetable_pte_dtor(page_ptdesc(pte));		\
+	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));\
 } while (0)
 #endif /* CONFIG_MMU */
 
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 9ce504737d18..430a3d05a841 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -353,12 +353,10 @@ static inline phys_addr_t __init alloc_pte_fixmap(uintptr_t va)
 
 static phys_addr_t __init alloc_pte_late(uintptr_t va)
 {
-	unsigned long vaddr;
-
-	vaddr = __get_free_page(GFP_KERNEL);
-	BUG_ON(!vaddr || !pgtable_pte_page_ctor(virt_to_page((void *)vaddr)));
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL & ~__GFP_HIGHMEM, 0);
 
-	return __pa(vaddr);
+	BUG_ON(!ptdesc || !pagetable_pte_ctor(ptdesc));
+	return __pa((pte_t *)ptdesc_address(ptdesc));
 }
 
 static void __init create_pte_mapping(pte_t *ptep,
@@ -436,12 +434,10 @@ static phys_addr_t __init alloc_pmd_fixmap(uintptr_t va)
 
 static phys_addr_t __init alloc_pmd_late(uintptr_t va)
 {
-	unsigned long vaddr;
-
-	vaddr = __get_free_page(GFP_KERNEL);
-	BUG_ON(!vaddr || !pgtable_pmd_page_ctor(virt_to_page((void *)vaddr)));
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL & ~__GFP_HIGHMEM, 0);
 
-	return __pa(vaddr);
+	BUG_ON(!ptdesc || !pagetable_pmd_ctor(ptdesc));
+	return __pa((pmd_t *)ptdesc_address(ptdesc));
 }
 
 static void __init create_pmd_mapping(pmd_t *pmdp,
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
