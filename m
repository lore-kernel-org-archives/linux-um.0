Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20B5E7718B
	for <linux-um@archiver.kernel.org>; Mon, 23 Dec 2024 10:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t6vBY23hDAeU19z0pXyQ9vuAeZavJyfGUN8npoqwlxU=; b=hjdU+vFGlb2U49uuOX6ACEaRtD
	2Kccrb61K19xoBPEuvfAt/VwVyX4B5gtFWvcVRhRSpGjgGp/2aNXuuxL3bFxrRUVNgUvsvX89320c
	7RgzEGayD8/Bkw78gHcRuOH9j51zR+/7QggMKP4dafVS4eHTIQv4toxT0+aaA/xr61kBNYPBQnswb
	kYCZiV1NF2l0ZOzqRJtUDmukEpuYGaQryJ4Iwem1na6bttHvJhb1sPNyk1Yn6AX0zsUXDBwHTgAz5
	T5E4/9ylkuIvPJDk6eHYb9EkUEyyuMHWGYUr1NxdCrPcHox2ODHk7vM7us27Dqg20ccRXWKRriOS0
	FnArKM8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tPg1k-00000009oeG-26zu;
	Mon, 23 Dec 2024 10:51:08 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tPeyg-00000009gKX-2mCf
	for linux-um@lists.infradead.org;
	Mon, 23 Dec 2024 09:43:55 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-7242f559a9fso4801207b3a.1
        for <linux-um@lists.infradead.org>; Mon, 23 Dec 2024 01:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734947034; x=1735551834; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6vBY23hDAeU19z0pXyQ9vuAeZavJyfGUN8npoqwlxU=;
        b=FRuwHpDTAKgAjS7NJ778RZgmtB7x56W2wOl+DX5SC8EvaSzgeqPusu9GErCFFMc1JE
         oxGS7UfPZp7MhqO/IELTzKMAOepmFdkK6Im0IjT1tvjTVxfMsiKqD7gIrPJlimlshiPB
         sADVnFpNQZrGRQUV/z2JE3WwcMVkEWV9T+CE7Q+i//OfstTWaz+2lL8XXCSOd1xEbQvL
         3vg8gFJa3QgDlvug+whSDaoDLvw0S/AVQ2Txyaj0hEosbWAv3okWZOA7qTiciItYxIQL
         E61XMEDcMaxfDOmKR/yisPhaiyvGlR16WEQ1A6eBMmmXBSwcVw4rtpR1REe66h+Nj8dF
         WSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734947034; x=1735551834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6vBY23hDAeU19z0pXyQ9vuAeZavJyfGUN8npoqwlxU=;
        b=va2CiPCedn1wmXPlF8VpF1DnbwcrLxnt+3hx8ZK8KCNNjWmY25s/rKRIEV01sswj+/
         HqpDT1Z9dzRU+FZDP5GXvLfiZZAJ+uvtHJ1eS9ezetTd//2nC5rqmpahrgVtF9Ghxuc3
         KpYaiU0g86hiNxF2YAsEbn9UEDbUFKQcDrsShaoii5Rt4XV5mVR39TVRCE01SusoS2CF
         baS9TMWTjMtFv2diIpDAUvxxe4Bj/2I3fNL+lmIyJdZhDj56ZTa6gQ7dUyNm5s7GSDYi
         TAWjSysq+KOC55l8VoUKufhjsKwRiJVNhYnqGpUv1fd27OIhL3PoW323suZEbK6n5Mbf
         plDg==
X-Forwarded-Encrypted: i=1; AJvYcCXDujT8WV40oywr6utddGPZMUqIZTswpvDXT+AM9u3FKTr5WLOr+pIBK1BjYdk0FV4BqdBL44ffOg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwLQd/OJk+sjDhVN70SeSr/z+zX0U+ZQQ5VE7ldTz4aDP86O/19
	evMsY3tYPUVlFmphQxGoEGvQbmV8+SGRurCYhL3k+QeNxcsDSu77eyurxBw3m1Y=
X-Gm-Gg: ASbGncvutNqSvisigY9bv43hjqNyboJ8ys9nJcQ5TzXJGZhvfjGxLzzQC4Kq5HRm7LG
	iNbQ7GuSIHK4r0G6b20zr9Guk8mLfOsnj1XPn32bxi7ys5a/CIJxXGPmXLFnfDgXfVhZf5Yv0Rh
	9kX2zMKwfKSIfSIphxr+/z/iDH21ggQ08BgypnXvJWFSmkTNyTOFRoE+3k7PEcdAS8zsPKGoHMl
	BurI6QrPshsUhyyZYIQ6d7Z60Rh+9eLwBgDOMjhQVTQZJPmgCTyopkugaP/d921XXjKXDAsP8sf
	zwiHkellSyohex1mTBVc4A==
X-Google-Smtp-Source: AGHT+IGO0+mWINscMdGqF/L7XDe6Dv/dfGXrIYILRYMXJn04aY3ZCG1rf5V2YGuLlSic6wG5VWjqsA==
X-Received: by 2002:a05:6a00:4090:b0:72a:a7a4:b4cd with SMTP id d2e1a72fcca58-72abdeb85b1mr18289604b3a.21.1734947034102;
        Mon, 23 Dec 2024 01:43:54 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8486c6sm7468309b3a.85.2024.12.23.01.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:43:53 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
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
Subject: [PATCH v3 04/17] mm: pgtable: add statistics for P4D level page table
Date: Mon, 23 Dec 2024 17:40:50 +0800
Message-Id: <2fa644e37ab917292f5c342e40fa805aa91afbbd.1734945104.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1734945104.git.zhengqi.arch@bytedance.com>
References: <cover.1734945104.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241223_014354_714409_C289CE6C 
X-CRM114-Status: GOOD (  11.70  )
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


