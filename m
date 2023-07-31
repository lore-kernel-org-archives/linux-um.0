Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605C6C001DC
	for <linux-um@archiver.kernel.org>; Mon, 31 Jul 2023 17:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fA/EAI6/oAvT74H9tW5OodmO95UT1t9YQfztAX1rYNM=; b=DD4CPRUn77b+pe
	YIEnrclTFT8VQZ756s8VhzMzZ9lQy69QFpm3srXSWxmOiyLIVEcNmizqI+YobVoJVOo0qt49Wa0zF
	36oY5g9mpwT6suNlrxn8tV+tgz36qCj4HWe0WC+DzTdf7pQM5Nir+H6Nz408eVK1TQ8jWHed+KCzj
	OZZ0NRRaJv1Zf8okX3e5bkctr8lIGwiI2i3OCeplOJIqTV6abgsh+jweCr2LwJ4LsUBBVgAkhmnd0
	qdPvMQGaCowdSzyfObXZNMqsHV+N7h1NomQoip8bwGUztDz3ElrDJLIAelpnJ1JIgfZ7hv5d4Jj6C
	SskRnkY89lzB6oqcvNXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWOO-00Go74-09;
	Mon, 31 Jul 2023 17:09:12 +0000
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWJr-00GkhT-1n;
	Mon, 31 Jul 2023 17:04:34 +0000
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a425ef874dso3603595b6e.0;
        Mon, 31 Jul 2023 10:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690823070; x=1691427870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wtNkjiFE1rjq7ZRDFNmpMqdu/3EA/QyC8BNR6xlaRk=;
        b=jDHhLXZJRXD/xeYPjUKANAGx7mWI4rG2vR3tiNn5nmibHzSYtMioLibanq9BMakzzx
         Dc40uVduQvHfbEsvbNTufmD3fXRl+TcWbOzDp0kgO7QuCTykCE1j+HK6n3jb1sqe57XF
         7xsPytJhE4yGGkRfFmDQz1HzLuGW2ZTo/1EAyxe33p/FghCyp57Hsm7Uzya8S5xLQJaT
         ueIYolohxESLEyhmxK2PHze+l/eyVpSLM0kum/QRULVrKh/GfSQvLlze6Gzlo9GlB5fo
         iazuqOSyOZnJfKQ3WX+zpbxyRMiNA23MCvyV70vvY+gHhKrbl8nHkjOrciNugWyCFGqp
         7t9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690823070; x=1691427870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3wtNkjiFE1rjq7ZRDFNmpMqdu/3EA/QyC8BNR6xlaRk=;
        b=UARidbOo6gcNphYiMu6x/qL1BsoIIKUHVw2u3v1R/3PfzadFa8RnA/sO/RRnFsxkXw
         p1+zVXEuS98ui3c1quUaWWyfOB7p8kT1/KaFnen8je3sfgq9xtf6zkR3fHchfQ5AnM0h
         EluK3miSXWDHnbhiqvg9zEVruktBGBA9lkRzkV4Z6opqmCEWauQst3X7XA0ORNgLfLui
         UY3xbdCQKQvUVmKsq93DqbVQdvjxstG7yd78n+VlqVyu5Pn2GE/5fOLTbksoXFnsbq94
         eiPs4HGR+unN3867zapm73EHNSZHmMugloA6IHEBPnaOnDHRzwd9RbkPKL9FRWpQt0LL
         bV5Q==
X-Gm-Message-State: ABy/qLbmpwL2Z3nLXN4WYPTp28iNKRUzTmZ5OF3ngnP58hmzUtvAxQPd
	uPj8X33EAJz6gEi8vajgexU=
X-Google-Smtp-Source: APBJJlGObInRwlJ0AwNAJnouNbrDrDtHWtXxAKPp84WJFWn9NE838Pa2gI3Dgeu+TYrNO6dbsPWj8A==
X-Received: by 2002:aca:2b03:0:b0:3a7:1443:f4e4 with SMTP id i3-20020aca2b03000000b003a71443f4e4mr5616696oik.44.1690823070647;
        Mon, 31 Jul 2023 10:04:30 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id x31-20020a25ac9f000000b00c832ad2e2eesm2511833ybi.60.2023.07.31.10.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 10:04:30 -0700 (PDT)
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
Subject: [PATCH mm-unstable v8 26/31] riscv: Convert alloc_{pmd, pte}_late() to use ptdescs
Date: Mon, 31 Jul 2023 10:03:27 -0700
Message-Id: <20230731170332.69404-27-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731170332.69404-1-vishal.moola@gmail.com>
References: <20230731170332.69404-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_100431_631274_E1991AB3 
X-CRM114-Status: GOOD (  12.59  )
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

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
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
