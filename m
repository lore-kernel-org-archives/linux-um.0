Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB235E77199
	for <linux-um@archiver.kernel.org>; Wed,  8 Jan 2025 07:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SzpcYcAmR7wIjJMr9qjJ0ueu9TAADg8s+gPSbWL3su4=; b=nXSf24yxhOV0TUbhSLYgYmAvKa
	lNoQFutZ2HQfayutfmDFPxMyA3a4AG7NwppTQi4CsOjgXQzhebeTZmOoEA2M/4yHOyiT9sTPEPk5g
	Km5lBlWdBer8gmiK8OhPQGpdk0T6O+BhYgfp1SwM7tpgi66GaWFbQSliu62hS6OLDzzqQxqoDXQyi
	JErXhEvIsDboRw9/dr22XuOEqElDol5999MZCgHE+Sr//6GM5p2f4AWb9po5hcj7uKgp3nUQGW6/O
	vbYuwkZpJu3V9C7+L265eMgZJ2g9k+Or6YJCUz5bnuT55HnukLtvpYIlv1V82xpTVMwttUYQ4xUq0
	4MCv/gOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVQOw-00000007PpG-2zRF;
	Wed, 08 Jan 2025 07:22:50 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVQ5u-00000007M3C-12uI
	for linux-um@lists.infradead.org;
	Wed, 08 Jan 2025 07:03:11 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-21a1e6fd923so29795275ad.1
        for <linux-um@lists.infradead.org>; Tue, 07 Jan 2025 23:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736319790; x=1736924590; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzpcYcAmR7wIjJMr9qjJ0ueu9TAADg8s+gPSbWL3su4=;
        b=cpZQt1oj4EV8/OwQeznF2xs9dUniZGfJ8Xhm/r63STwQ9ARSkmQkPr8gmY0E4p6lLW
         31Al+j8t+YuMBA/JtlUrNAtjXgPodXKxlKiyGPaOJ3OCPRCbRcfvcPLAr39jRGJ5HCgx
         XalP/FWxZP3uwhYGO+e6KZnhj9Hr/294SeLGLl4WLaGbH7/Gjt9yxxrUFMuHPonYK+A+
         0dKSb+7PKwlVrE3JaZ/T6licq3EPFaUv6s6ORpuBHGjWOk/irCWVlKzhOY6++CGsZjzX
         Uq2V5jX+yVJCeEUg55W6ilgdI0tn4gKVQOVgFH2xyK2WGPfO8oqcIAN4W7D/iEFatIUq
         Cl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736319790; x=1736924590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzpcYcAmR7wIjJMr9qjJ0ueu9TAADg8s+gPSbWL3su4=;
        b=CRFzOY8hd26yMro2jbFSNpBjG0LczX03qty06TwvHjJxDaoHMWL+dteyeaqBJu0eMa
         Rd4LLYftwekJhzWc9H08M04y7URHBIJtps+T1PFsQ0pTracKTMWByGz0IafNR6WwMLAH
         v4IW1ifb9qwi+mMgVhl7bgkzjg+1xQrpCvCZsCOU0U6ARW40Woo1caxDM6aXFq8S5Tlf
         1TwpXrFuywS2lkVFpyeQfjcg1WYGOWvStBknwfLLXFtGMEVE3NjVQVO7dslWUGKK0ryw
         DV+PITLsWV6jRvRntogisFm0Qiepl1XTYEHELtMvgD3Cjat/SF4NXZEhQa6Izuz7UJKW
         7VhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWr4pskwdguZ1HeWx0hCrhpM6HsSgdan+6j3zX62W+yqGDv/Q9Za750KagXWtm+iBYvEJgJJhl/4A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy6RLh8rWUwC26+NxNcIVKB2NYmWJvvH7Ynxx4+m8Kn0diMkz0t
	mXjYiLvhK2niBsnux7JLsF14EC6IyrdgvqUF6qOo9VMdFG7he8gbWVyudMBgV+o=
X-Gm-Gg: ASbGncuy617rB6pAHO81vmm+rxfcoH6MZIeeFZGnDQep9/am+dnT2Ub3X24oT1tp7F4
	qEDvg50e1Rkc3v4uEusOv+XN5aZ0p3GHV3vZrBS0jF2G6rf5RlieQ/ZxJpjSpkJqf9BWUx2kV4/
	NNYf3wh3q7LUh2phFYab/KrV+KRS0upbjSawfefqT8Uo1UFnZjSoKehr7rhkTfg7wxeztm28WwR
	E1a8oHLV8pGMje+p7TUjyWvOoInRUZkKduSsvYhgARkLE0cal0HSa7R92Q35K5Iisn1h6t8nUYX
	+jk1l06h12APZS2wowe1fahynNg=
X-Google-Smtp-Source: AGHT+IGLH2wnugoAqXpKOjRMOcNm05e1d3DjACkQOqMsLyNNJS4LCZNqibWg6/9XtyaXTuj3byMh6A==
X-Received: by 2002:a17:902:e74f:b0:216:7cde:523 with SMTP id d9443c01a7336-21a83f6710dmr31869555ad.32.1736319789694;
        Tue, 07 Jan 2025 23:03:09 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca023a3sm320067275ad.250.2025.01.07.23.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 23:03:09 -0800 (PST)
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
Subject: [PATCH v5 15/17] mm: pgtable: completely move pagetable_dtor() to generic tlb_remove_table()
Date: Wed,  8 Jan 2025 14:57:31 +0800
Message-Id: <0c733ac867b287ec08190676496d1decebf49da2.1736317725.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1736317725.git.zhengqi.arch@bytedance.com>
References: <cover.1736317725.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_230310_385487_E07BEC0E 
X-CRM114-Status: GOOD (  13.00  )
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

For the generic tlb_remove_table(), it is implemented in the following two
forms:

1) CONFIG_MMU_GATHER_TABLE_FREE is enabled

tlb_remove_table
--> generic __tlb_remove_table()

2) CONFIG_MMU_GATHER_TABLE_FREE is disabled

tlb_remove_table
--> tlb_remove_page

For case 1), the pagetable_dtor() has already been moved to generic
__tlb_remove_table().

For case 2), now only arm will call tlb_remove_table()/tlb_remove_ptdesc()
when CONFIG_MMU_GATHER_TABLE_FREE is disabled. Let's move pagetable_dtor()
completely to generic tlb_remove_table(), so that the architectures can
follow more easily.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Kevin Brodsky <kevin.brodsky@arm.com>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm/include/asm/tlb.h |  4 ----
 include/asm-generic/tlb.h  | 10 ++++++++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index b8eebdb598631..ea4fbe7b17f6f 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -34,10 +34,6 @@ __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long addr)
 {
 	struct ptdesc *ptdesc = page_ptdesc(pte);
 
-#ifndef CONFIG_MMU_GATHER_TABLE_FREE
-	pagetable_dtor(ptdesc);
-#endif
-
 #ifndef CONFIG_ARM_LPAE
 	/*
 	 * With the classic ARM MMU, a pte page has two corresponding pmd
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 69de47c7ef3c5..53ae7748f555b 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -220,14 +220,20 @@ static inline void __tlb_remove_table(void *table)
 
 extern void tlb_remove_table(struct mmu_gather *tlb, void *table);
 
-#else /* !CONFIG_MMU_GATHER_HAVE_TABLE_FREE */
+#else /* !CONFIG_MMU_GATHER_TABLE_FREE */
 
+static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page);
 /*
  * Without MMU_GATHER_TABLE_FREE the architecture is assumed to have page based
  * page directories and we can use the normal page batching to free them.
  */
-#define tlb_remove_table(tlb, page) tlb_remove_page((tlb), (page))
+static inline void tlb_remove_table(struct mmu_gather *tlb, void *table)
+{
+	struct page *page = (struct page *)table;
 
+	pagetable_dtor(page_ptdesc(page));
+	tlb_remove_page(tlb, page);
+}
 #endif /* CONFIG_MMU_GATHER_TABLE_FREE */
 
 #ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
-- 
2.20.1


