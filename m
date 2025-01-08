Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7004DE77188
	for <linux-um@archiver.kernel.org>; Wed,  8 Jan 2025 07:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/cYfjcYM2i48jLO7NuvQJ4j04U6+7fBnrQjgIuvbLyg=; b=EPdzP3vRgCFV5Jpoy/655yNsn0
	3wWXzrr+M43bmkXW8Ek6LQ+RLhMdqjSAa7wiKS6wMUp5Gtc6Lmw76owk4V5MTVUdwZnB5FFTzK7me
	R/JUJYQ7zlLc0iT/EbDQx9JNfCDt1nkWsPr5S7kbvTYO1R6fAL0VVySyqBiYfy9PIvXZ/BY//+LeF
	19b4IwlRs9s0uLfWyW3Dx5LVv3C1aMoZOQt9eiCLvcp7JluHyrEaNodPIzQ+OpiEBg2xraTYI6O1P
	3LDmEFbtautekx0ITBHS14YWoNZ89aAuCcfH2mgDXj9kmIj8nOCl6lKAtEbl1vwAjUSUFGnlWerZn
	uaLrNOKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVQ77-00000007MdX-0drw;
	Wed, 08 Jan 2025 07:04:25 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVQ3A-00000007KRU-2Ikg
	for linux-um@lists.infradead.org;
	Wed, 08 Jan 2025 07:00:22 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-21680814d42so205539985ad.2
        for <linux-um@lists.infradead.org>; Tue, 07 Jan 2025 23:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736319619; x=1736924419; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cYfjcYM2i48jLO7NuvQJ4j04U6+7fBnrQjgIuvbLyg=;
        b=EvFA5bWY7evvq9nqRl5b/k9Yfbj6mHqEfVEGf8I2GSmOAhJme1wmQ+LbKfUb132Tfh
         +MPU154SxaHiRgy396WRoMt3T2GfHjLQov6RGtPfZ2ay0PzaOpdUSiQMeTaMdaOUXRLY
         bhjXNvGMrw3TdUFLOfrdUOmUEUY4Qsh/3f+P6Q6+PuF6h6AmVRhCODUp6UljajUOk2Nx
         xH0emf+15+Qe5uYJ6SNWi7b8FpQxA2yJXnUBVpNY498mmJf4h8oiJMVeKaqoatzvJq5Q
         /uylYUJ9/CB1VzHg3bc6s9ZJSWB4/SsvpoUCZy9yv1zUbtl5bsD8ZH97ZD/aOVwDKH4K
         TEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736319619; x=1736924419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/cYfjcYM2i48jLO7NuvQJ4j04U6+7fBnrQjgIuvbLyg=;
        b=kfy82+y12VZlJA+S4l/uKj9ilGmjJKdPxmzDgzyAVeC7+izGAUBGczE6r7OxcpgmrN
         XQPJ6uyp6YH5iAPBFbAsK/YjDmFAkUzcPgcZ9C5oduLSbUcfVrR6ATsdDR3YRxbe1Ys0
         d2ERdywfMJiP+s8Yj+v4wDFsMKNkM6iWqkmXqaqtF2IKhcg0PiJL+J16rByJGHpRZt5Y
         3vviorWbU44D83r00zF2Hw1o9oQChlWlBDfYnKl3yD+9mcR3zNv/ZtVGAxdrdqGH+wtZ
         JeaxQV/jGqN1Sbw7EMX09Bg9QM7LeQYbPvGrIhR/GNctX+yf6fHgC9e9lofv1ppSswb7
         QU/w==
X-Forwarded-Encrypted: i=1; AJvYcCV+02xUKVnbF0d8I32BWk8V+XCLfvdhFNFb3ptT9oOpLpN4bjs/g+xaMgz0fAD2TGA19D/Pm7/vCA==@lists.infradead.org
X-Gm-Message-State: AOJu0YysSzugll2tRr7B4nWxOxBo3i1DD8V88KJE+fUA6N0pvZq0xBb/
	03VZzmKrhfgWlpLbvlQuD3QOQi8uNrOknR5LSPDIuYoXgfEcZGqEPyLVbZfMD7I=
X-Gm-Gg: ASbGncs8BaSufLoiwWBilr7JF/PN/+RmY2Ec4a0qkAFNOE/9/W3/x3l3PPFaYqCUXUw
	JSeqg6LL5/zuC56rrS6itf9/Y7EwyFg+4RZjmiC1/X5f/O+rl52xjAtFzNeuyqEqFR1xrCDSeK1
	IqkBoQs3U2FxwQ+Ocx0lO/fISJW9X1B1HuQfmYItnyCbvyXzpq05ML5GLyMLPV5BJEvIeSB3Tda
	XSXyvhYa3gQFHhnRlR/WlKEsaC8oX48aySaHOOLCy2gkL3y0IKydSW5zd/ctMOSSem/hwEd8MV2
	uu7pdqRHCrS8WYHAIUlFaR8atlI=
X-Google-Smtp-Source: AGHT+IExFPt1bVFS1B+HfK/rni8xCakw0mpYmNpiHCGWtvviMVtfvk5MaDovSIdy5xSOdSeWSopXEQ==
X-Received: by 2002:a17:903:2311:b0:210:fce4:11ec with SMTP id d9443c01a7336-21a83f42687mr30246255ad.1.1736319619595;
        Tue, 07 Jan 2025 23:00:19 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca023a3sm320067275ad.250.2025.01.07.23.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 23:00:19 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
	alex@ghiti.fr,
	andreas@gaisler.com,
	palmer@dabbelt.com,
	tglx@linutronix.de,
	david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	yuzhao@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	lorenzo.stoakes@oracle.com,
	akpm@linux-foundation.org,
	rientjes@google.com,
	vishal.moola@gmail.com,
	arnd@arndb.de,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	dave.hansen@linux.intel.com,
	rppt@kernel.org,
	ryan.roberts@arm.com
Cc: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-arch@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v5 04/17] mm: pgtable: add statistics for P4D level page table
Date: Wed,  8 Jan 2025 14:57:20 +0800
Message-Id: <d55fe3c286305aae84457da9e1066df99b3de125.1736317725.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1736317725.git.zhengqi.arch@bytedance.com>
References: <cover.1736317725.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_230020_594575_1B86D4C0 
X-CRM114-Status: GOOD (  12.16  )
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

Like other levels of page tables, add statistics for P4D level page table.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/riscv/include/asm/pgalloc.h |  6 +++++-
 arch/x86/mm/pgtable.c            |  3 +++
 include/asm-generic/pgalloc.h    |  2 ++
 include/linux/mm.h               | 16 ++++++++++++++++
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index 551d614d3369c..3466fbe2e508d 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -108,8 +108,12 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
 				  unsigned long addr)
 {
-	if (pgtable_l5_enabled)
+	if (pgtable_l5_enabled) {
+		struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
+
+		pagetable_p4d_dtor(ptdesc);
 		riscv_tlb_remove_ptdesc(tlb, virt_to_ptdesc(p4d));
+	}
 }
 #endif /* __PAGETABLE_PMD_FOLDED */
 
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 69a357b15974a..3d6e84da45b24 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -94,6 +94,9 @@ void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
 #if CONFIG_PGTABLE_LEVELS > 4
 void ___p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d)
 {
+	struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
+
+	pagetable_p4d_dtor(ptdesc);
 	paravirt_release_p4d(__pa(p4d) >> PAGE_SHIFT);
 	paravirt_tlb_remove_table(tlb, virt_to_page(p4d));
 }
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 59131629ac9cc..bb482eeca0c3e 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -230,6 +230,7 @@ static inline p4d_t *__p4d_alloc_one_noprof(struct mm_struct *mm, unsigned long
 	if (!ptdesc)
 		return NULL;
 
+	pagetable_p4d_ctor(ptdesc);
 	return ptdesc_address(ptdesc);
 }
 #define __p4d_alloc_one(...)	alloc_hooks(__p4d_alloc_one_noprof(__VA_ARGS__))
@@ -247,6 +248,7 @@ static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)
 	struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
 
 	BUG_ON((unsigned long)p4d & (PAGE_SIZE-1));
+	pagetable_p4d_dtor(ptdesc);
 	pagetable_free(ptdesc);
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c49bc7b764535..5d82f42ddd5cc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3175,6 +3175,22 @@ static inline void pagetable_pud_dtor(struct ptdesc *ptdesc)
 	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
 }
 
+static inline void pagetable_p4d_ctor(struct ptdesc *ptdesc)
+{
+	struct folio *folio = ptdesc_folio(ptdesc);
+
+	__folio_set_pgtable(folio);
+	lruvec_stat_add_folio(folio, NR_PAGETABLE);
+}
+
+static inline void pagetable_p4d_dtor(struct ptdesc *ptdesc)
+{
+	struct folio *folio = ptdesc_folio(ptdesc);
+
+	__folio_clear_pgtable(folio);
+	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
+}
+
 extern void __init pagecache_init(void);
 extern void free_initmem(void);
 
-- 
2.20.1


