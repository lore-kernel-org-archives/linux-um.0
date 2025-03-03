Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C4C4C282C6
	for <linux-um@archiver.kernel.org>; Mon,  3 Mar 2025 07:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wKqMp2ldkM6onLRqmB7AQD5dXslJ0Fc9YwwNhjL6y0w=; b=kQ46hz3rDOXyBq1tvTEDR9Vn1A
	zzLQg8nk1czfS+BtrbQJPYe7lk0uCL/2hU2dRMlgI3zV6W4+Dt+525iM1h0R0M9nnozjIkyc1DCA9
	F/oA4P8G+VtFsXv8ruWswnrz0L8ZOtHiqlNdHbYNZ2pld7ehQk0/RWC+DNMtKcna3YMVEfeRvRuIO
	KhOGQasGyE5pFCyH3eZGvmMKkGMZDILwnSGCSKcrCSqH/ceNY9aC8zxoPhGttzptIML3c5uTcIqiz
	OoHcUXqecSxG6BarfkXMab9eoZcI0X2yMvGqn6vUHG4e+v/JULTui9rCjRBPwnf5i4RBf4fTvomWJ
	kX1TWJxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tp0CI-0000000HQgJ-02X5;
	Mon, 03 Mar 2025 07:26:42 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tp0CE-0000000HQfC-3Ubk
	for linux-um@lists.infradead.org;
	Mon, 03 Mar 2025 07:26:40 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2fce3b01efcso5800430a91.3
        for <linux-um@lists.infradead.org>; Sun, 02 Mar 2025 23:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740986797; x=1741591597; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKqMp2ldkM6onLRqmB7AQD5dXslJ0Fc9YwwNhjL6y0w=;
        b=B8JuW/eGYGlfUmv7lK81h32ZStWhTWWYmWgnwbLb6+smAkOtXG4I/9Z3cHXgYth3UF
         8FotqAIOwLsDq1zok75sKp8+h38GsVe3Kbdez5LcX6G9zVazybTuY4Gkv3o+L3M4Nfor
         oAcPlbgzyF+ToMRF2YLJtdArv8JZ3IpUmDJ2z/IxLbFHmcZ15CEmHnrx8Sre6pQMBm2z
         c/ynetBv+1A9D8jQ7Kvly9ihJm+DgBKqc4AmUZeSkh84PjlK+dofosLyAqXISq2+1WoS
         oruw8BrGxpPn277NwRFlRp8zNioqbMsI80CMTr8IIlZ4GHuL6U8Zh9c/8jVv/aXVGQX2
         Yf3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740986797; x=1741591597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKqMp2ldkM6onLRqmB7AQD5dXslJ0Fc9YwwNhjL6y0w=;
        b=pz7UiriJmVSurw0SosOnKT0kNdPrEF2vagVZzTV35IjYs5fWAfE0Ayu+ZIlZlvHL7I
         qMPSk+ZktyCYRTSov5Ul+z6oc58bEnpaua7dkL+Q0VWloy0J0sdz5eCrnI4qVh+7i0Na
         PdwiR+ltcur/UMR7GD79xm1fnfjHbQuUTSxdEA9E4YHVCzQHFwlOfUw0wP/w47jfudFb
         IvZeophujguGu7tzaXZiqjVBene/Nwnq0aSFFn4a1jl+NGt9cJMgEjDRcGQS8ANGRPca
         3JSI5V0OROrNx3ZP1yutUPO5EuhCNnpynEh71EDAYoZyx35bxjB4xVvYzhcQSxpnVriF
         dCxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWJ1VQQgxFEkwqplpelOV+Ba9hxX6Lss+fBx52WBFeraSGwCMKHbcJ43UX0i8ugfE6gCwyI3mG1A==@lists.infradead.org
X-Gm-Message-State: AOJu0YyqQizRR1V9yHQ8TU4cOj9ATyeAgGBP4+pjg5i3G6fHJKtEIDUA
	Dqiw59T+rJikAheRa7FIo84Y13fcR5wVfVCosgPjsVyhWjbZxfCclAFLOya4DLY=
X-Gm-Gg: ASbGncvYdt3otxnXo8R2qOYuufDgkc12e0heVRUwa+xkaUO8k+8tHwYguAik0rzFYSv
	i1RuFtgoZFTjtFcX4VxEbQEOCHvsRyMV2M/CoeRxkY+xKgbl7q2nWqxmGCfzPfr6IGQcI62SqPI
	FtE57b2t2LttNwjtiMeHZJnprAD1H1i9sgV/ceiTwmOlu4oqjMElqX7WPzGqUrdhJ0zsrvcE8GR
	3LQKpH+hK0PPsdpkCVpXDiAqGs9TgBhNetHORo8bpyr1T1csm/BnNgcCJLXhXqJvWTdE858ksKD
	sw8hKwi9x8yfUA5lyes7qeQ7Z9j2rLEnrwR5xK4FQXvC7YuMXuxEwUPtV4/OV553KlWdsmS8LON
	iCaw3Kg==
X-Google-Smtp-Source: AGHT+IHY/mguPL5YJZdh+hkpdyJ3sc0BaAvd1rDPiW9eR/qaACJ5BQlxWj/zL9j3Gfy9PeYzz+4/5A==
X-Received: by 2002:a17:90a:f948:b0:2fe:d766:ad87 with SMTP id 98e67ed59e1d1-2fed766af9cmr12568619a91.7.1740986796693;
        Sun, 02 Mar 2025 23:26:36 -0800 (PST)
Received: from G7HT0H2MK4.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fea676c06asm8211638a91.16.2025.03.02.23.26.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 02 Mar 2025 23:26:35 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	kevin.brodsky@arm.com,
	riel@surriel.com,
	vishal.moola@gmail.com,
	david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	willy@infradead.org,
	yuzhao@google.com,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	arnd@arndb.de,
	dave.hansen@linux.intel.com,
	rppt@kernel.org,
	alexghiti@rivosinc.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 3/6 update] mm: pgtable: convert some architectures to use tlb_remove_ptdesc()
Date: Mon,  3 Mar 2025 15:26:03 +0800
Message-ID: <20250303072603.45423-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <19db3e8673b67bad2f1df1ab37f1c89d99eacfea.1740454179.git.zhengqi.arch@bytedance.com>
References: <19db3e8673b67bad2f1df1ab37f1c89d99eacfea.1740454179.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250302_232639_032267_BE6E7465 
X-CRM114-Status: GOOD (  10.77  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Now, the nine architectures of csky, hexagon, loongarch, m68k, mips,
nios2, openrisc, sh and um do not select CONFIG_MMU_GATHER_RCU_TABLE_FREE,
and just call pagetable_dtor() + tlb_remove_page_ptdesc() (the wrapper of
tlb_remove_page()). This is the same as the implementation of
tlb_remove_{ptdesc|table}() under !CONFIG_MMU_GATHER_TABLE_FREE, so
convert these architectures to use tlb_remove_ptdesc().

The ultimate goal is to make the architecture only use tlb_remove_ptdesc()
or tlb_remove_table() for page table pages.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
---
Changes in v2 update:
 - remove the do { ... } while construct. (Geert Uytterhoeven)
 - collect the Reviewed-by and Acked-by.

 arch/csky/include/asm/pgalloc.h      |  7 ++-----
 arch/hexagon/include/asm/pgalloc.h   |  7 ++-----
 arch/loongarch/include/asm/pgalloc.h |  7 ++-----
 arch/m68k/include/asm/sun3_pgalloc.h |  7 ++-----
 arch/mips/include/asm/pgalloc.h      |  7 ++-----
 arch/nios2/include/asm/pgalloc.h     |  7 ++-----
 arch/openrisc/include/asm/pgalloc.h  |  7 ++-----
 arch/sh/include/asm/pgalloc.h        |  7 ++-----
 arch/um/include/asm/pgalloc.h        | 21 ++++++---------------
 9 files changed, 22 insertions(+), 55 deletions(-)

diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
index bf8400c28b5a3..11055c5749686 100644
--- a/arch/csky/include/asm/pgalloc.h
+++ b/arch/csky/include/asm/pgalloc.h
@@ -61,11 +61,8 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 	return ret;
 }
 
-#define __pte_free_tlb(tlb, pte, address)		\
-do {							\
-	pagetable_dtor(page_ptdesc(pte));		\
-	tlb_remove_page_ptdesc(tlb, page_ptdesc(pte));	\
-} while (0)
+#define __pte_free_tlb(tlb, pte, address)	\
+	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
 
 extern void pagetable_init(void);
 extern void mmu_init(unsigned long min_pfn, unsigned long max_pfn);
diff --git a/arch/hexagon/include/asm/pgalloc.h b/arch/hexagon/include/asm/pgalloc.h
index 1ee5f5f157ca7..937a11ef4c33c 100644
--- a/arch/hexagon/include/asm/pgalloc.h
+++ b/arch/hexagon/include/asm/pgalloc.h
@@ -87,10 +87,7 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
 		max_kernel_seg = pmdindex;
 }
 
-#define __pte_free_tlb(tlb, pte, addr)				\
-do {								\
-	pagetable_dtor((page_ptdesc(pte)));			\
-	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
-} while (0)
+#define __pte_free_tlb(tlb, pte, addr)	\
+	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
 
 #endif
diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
index 7211dff8c969e..73629c1b8328e 100644
--- a/arch/loongarch/include/asm/pgalloc.h
+++ b/arch/loongarch/include/asm/pgalloc.h
@@ -55,11 +55,8 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 	return pte;
 }
 
-#define __pte_free_tlb(tlb, pte, address)			\
-do {								\
-	pagetable_dtor(page_ptdesc(pte));			\
-	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));	\
-} while (0)
+#define __pte_free_tlb(tlb, pte, address)	\
+	tlb_remove_ptdesc((tlb), page_ptdesc(pte));
 
 #ifndef __PAGETABLE_PMD_FOLDED
 
diff --git a/arch/m68k/include/asm/sun3_pgalloc.h b/arch/m68k/include/asm/sun3_pgalloc.h
index 80afc3a187249..1e21c758b774e 100644
--- a/arch/m68k/include/asm/sun3_pgalloc.h
+++ b/arch/m68k/include/asm/sun3_pgalloc.h
@@ -17,11 +17,8 @@
 
 extern const char bad_pmd_string[];
 
-#define __pte_free_tlb(tlb, pte, addr)				\
-do {								\
-	pagetable_dtor(page_ptdesc(pte));			\
-	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));	\
-} while (0)
+#define __pte_free_tlb(tlb, pte, addr)	\
+	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
 
 static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd, pte_t *pte)
 {
diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index 26c7a6ede983c..bbca420c96d3c 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -48,11 +48,8 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 extern void pgd_init(void *addr);
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 
-#define __pte_free_tlb(tlb, pte, address)			\
-do {								\
-	pagetable_dtor(page_ptdesc(pte));			\
-	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));	\
-} while (0)
+#define __pte_free_tlb(tlb, pte, address)	\
+	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
 
 #ifndef __PAGETABLE_PMD_FOLDED
 
diff --git a/arch/nios2/include/asm/pgalloc.h b/arch/nios2/include/asm/pgalloc.h
index 12a536b7bfbd4..db122b093a8be 100644
--- a/arch/nios2/include/asm/pgalloc.h
+++ b/arch/nios2/include/asm/pgalloc.h
@@ -28,10 +28,7 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 
-#define __pte_free_tlb(tlb, pte, addr)					\
-	do {								\
-		pagetable_dtor(page_ptdesc(pte));			\
-		tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
-	} while (0)
+#define __pte_free_tlb(tlb, pte, addr)	\
+	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
 
 #endif /* _ASM_NIOS2_PGALLOC_H */
diff --git a/arch/openrisc/include/asm/pgalloc.h b/arch/openrisc/include/asm/pgalloc.h
index 3372f4e6ab4b5..3f110931d8f6e 100644
--- a/arch/openrisc/include/asm/pgalloc.h
+++ b/arch/openrisc/include/asm/pgalloc.h
@@ -64,10 +64,7 @@ extern inline pgd_t *pgd_alloc(struct mm_struct *mm)
 
 extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
 
-#define __pte_free_tlb(tlb, pte, addr)				\
-do {								\
-	pagetable_dtor(page_ptdesc(pte));			\
-	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
-} while (0)
+#define __pte_free_tlb(tlb, pte, addr)	\
+	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
 
 #endif
diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
index 96d938fdf2244..6fe7123d38fa9 100644
--- a/arch/sh/include/asm/pgalloc.h
+++ b/arch/sh/include/asm/pgalloc.h
@@ -32,10 +32,7 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 	set_pmd(pmd, __pmd((unsigned long)page_address(pte)));
 }
 
-#define __pte_free_tlb(tlb, pte, addr)				\
-do {								\
-	pagetable_dtor(page_ptdesc(pte));			\
-	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
-} while (0)
+#define __pte_free_tlb(tlb, pte, addr)	\
+	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
 
 #endif /* __ASM_SH_PGALLOC_H */
diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.h
index f0af23c3aeb2b..826ec44b58cdb 100644
--- a/arch/um/include/asm/pgalloc.h
+++ b/arch/um/include/asm/pgalloc.h
@@ -25,27 +25,18 @@
  */
 extern pgd_t *pgd_alloc(struct mm_struct *);
 
-#define __pte_free_tlb(tlb, pte, address)			\
-do {								\
-	pagetable_dtor(page_ptdesc(pte));			\
-	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
-} while (0)
+#define __pte_free_tlb(tlb, pte, address)	\
+	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
 
 #if CONFIG_PGTABLE_LEVELS > 2
 
-#define __pmd_free_tlb(tlb, pmd, address)			\
-do {								\
-	pagetable_dtor(virt_to_ptdesc(pmd));			\
-	tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pmd));	\
-} while (0)
+#define __pmd_free_tlb(tlb, pmd, address)	\
+	tlb_remove_ptdesc((tlb), virt_to_ptdesc(pmd))
 
 #if CONFIG_PGTABLE_LEVELS > 3
 
-#define __pud_free_tlb(tlb, pud, address)			\
-do {								\
-	pagetable_dtor(virt_to_ptdesc(pud));		\
-	tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pud));	\
-} while (0)
+#define __pud_free_tlb(tlb, pud, address)	\
+	tlb_remove_ptdesc((tlb), virt_to_ptdesc(pud))
 
 #endif
 #endif
-- 
2.20.1


