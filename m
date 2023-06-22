Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3003AC0015E
	for <linux-um@archiver.kernel.org>; Thu, 22 Jun 2023 21:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=f3V4MWKtpCG9LC/FU6TIEA22zkSE/+Wi4J52B4oLUQE=; b=zRRHhG1ocom0Nd
	SkziDqHbs0DaLq0+cNBjb2a6+q21fnjNzSgW8eUccE+kxMhk6khfivo0oDpVi2934OkM+doCJQoc2
	Oo98D4YPS4OwjXPNIOgabINY1aln7OHA6hSXl4a+qd2aprYKRZfcl1nEg4SkxG9YLms9X9MFnxLwr
	mZRJCa+g6bkY82mhqFiL11wOa1C4nFb+0UGrcedFFYmjzNwcJDUhfr7i6YlXgI0IObOUJCKftV+/R
	bbLsqv6Vwmg5tPudKSsbfcBUsvQWjcBQVybN9c60mgnxItwS9ouVYmPQ3cVdfuG2vP0xdIhE82Ywr
	McxT9+XToxTjhTaRP1rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCRRZ-001ldB-1Q;
	Thu, 22 Jun 2023 21:02:17 +0000
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCROJ-001iPW-0Z;
	Thu, 22 Jun 2023 20:58:57 +0000
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-763ddc4259dso176607385a.3;
        Thu, 22 Jun 2023 13:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687467534; x=1690059534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VT4pshsioiI3cvxCaccwxS3QnyiZywL9n+n1KwplTM=;
        b=TppJif0BHo6hnPlcQL9KC8WSGCLNYWnZ5TWCUGNi9Yse0euGomuzrLUl2hHWg+xOcN
         AtrgkmMfCUjy9KLBFfUuEG2s0Ihpe5FTyr5metIKFf6zbktuYMraC91YUKi/KWfbgyVG
         lvJTabP9ygpBud7nE/7yiG7FvQtoPgmdiRSK2sy5kuq4cEPaMRzkmi7ezbneoKdvpKLs
         RzOr7Yyw6OYIFnxYXzw+JpXxuwUJk+Gv++J63O8G6cjfEEYoESBKv3QgdI5Gny8Js2Dl
         u397T8c8ML9be3fyfcRz9z/KIcbHqeskiUObgkxyvqYvJ9bImtnagHyVKviaetoXJ3oC
         RmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687467534; x=1690059534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0VT4pshsioiI3cvxCaccwxS3QnyiZywL9n+n1KwplTM=;
        b=P5O/yU6cy4PvuNPlfOaFo58Slw6sQGsScplKmukkXX+Xiq2KjIHRlarKQoNGNL5mKV
         f3PlZ88Ypa3SpmscrJtLAXxnqAVZgQuvPhmFa9N0Pv8/epaw+XuLXsYI2M1JpJ6UVoA6
         GT0DnE32u/Az7nqh4uyR7xHDjDACS+8r1iYCt1Im5+pwhWXAvKNzPsGvpL31vqb4Wuvo
         QTfZtvYpf4X0xGOvRGEcyHjuODeD0IiGk3p3x6ioKzU4pu20P/tiyr2LX+BSpI1AA3xX
         dTIo/iaDyVNuN5ljI9ILa/pUzsFuChQq3+VV2NUi6YnUFwN/NN+uqVVMHKB4i7MCsQW2
         rwkw==
X-Gm-Message-State: AC+VfDxYcSmJQfRSXxlI30PsNOx/zktBIdH9E1jNENEDEcgm5MqaXBt2
	bo9Zz2MNa6Qe53s+PpdlvhE=
X-Google-Smtp-Source: ACHHUZ4bdUBNX+PQFkV86pN6qHx4P8fCpAOyeLEg1MMh49m7gk0ETU/OT0t4ehwniJxuP5YNErTIxg==
X-Received: by 2002:a05:620a:2455:b0:763:de2c:1a8a with SMTP id h21-20020a05620a245500b00763de2c1a8amr6902545qkn.57.1687467534343;
        Thu, 22 Jun 2023 13:58:54 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::36])
        by smtp.googlemail.com with ESMTPSA id d18-20020a5b0c52000000b00bc501a1b062sm1684937ybr.42.2023.06.22.13.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 13:58:54 -0700 (PDT)
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
Subject: [PATCH v5 28/33] riscv: Convert alloc_{pmd, pte}_late() to use ptdescs
Date: Thu, 22 Jun 2023 13:57:40 -0700
Message-Id: <20230622205745.79707-29-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622205745.79707-1-vishal.moola@gmail.com>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230622_135855_224189_FE868E8B 
X-CRM114-Status: GOOD (  11.93  )
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
index 4b95d8999120..efff9c752fcf 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -354,12 +354,10 @@ static inline phys_addr_t __init alloc_pte_fixmap(uintptr_t va)
 
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
@@ -437,12 +435,10 @@ static phys_addr_t __init alloc_pmd_fixmap(uintptr_t va)
 
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
