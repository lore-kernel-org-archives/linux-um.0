Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8280E77188
	for <linux-um@archiver.kernel.org>; Wed,  8 Jan 2025 07:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s3ajwCEJzuBWHLhfIS3uOIg9mbtSga1CIaOnP3nLDr0=; b=CzJA3kkLq7VvL07rYBHGnpt9ck
	2Lk6fKdt7Tnlvjm+B/+6SqRwy/Qbp9pQM2vSLwXKgNsnV13nrNHSShcfrElJSwahkErHjOC/uTBE+
	gCz0kS8kKxEwnKub0MhsTndUgl22mICai6Obgu4ANBgUnsjaKX1bIKssBuewIzYNaWdXfTRc9DOhS
	2gaL037B6P9LSoTiXwZNSkFwq8mQx6i+72PCb3el2cKQLLVuauwI8KnRb6VwRahYsl0CG5v/RkcVl
	wN9tEMbvs/tgnFbuD44rkVVhJXIarf34aSl4+qtiVU2fYnGYoZOy9/PxJipiSwYEXnQVaHup7fikW
	hnSCr9NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVQ9S-00000007NLQ-1gyt;
	Wed, 08 Jan 2025 07:06:50 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVQ3P-00000007Ka7-2JTk
	for linux-um@lists.infradead.org;
	Wed, 08 Jan 2025 07:00:37 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-216728b1836so222418405ad.0
        for <linux-um@lists.infradead.org>; Tue, 07 Jan 2025 23:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736319635; x=1736924435; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3ajwCEJzuBWHLhfIS3uOIg9mbtSga1CIaOnP3nLDr0=;
        b=ju9kYTopMw8dsauRMtnGr8xmeKLaGGx9D1RT1aTwC2f1AkJX2xPT+G5sKNCnhOea9C
         pSSVjZtHeNt8Sp0pFwxwsDf3YYWaM4pd4mUXQJxvNv+3mdCY86YqcyV4Dr4+BZiHwXJZ
         uce1tNWku7HNd32ElgTnaO7+RlKgQg9uJBbZEmXfHxtd7KCT5kjfJT9QJ0hZo7wPglWn
         fQuLjNhnwqo6o7zbirL1U+L7HxaqogLpPCyubMHoE9PLpEnHToe0InszX1GP3Om7iq5A
         NSQX4/kYpjOtHczLaGy1+l48le2NNDX4CYM36jsI5DFn+AkUexAaktxwTknqUwj2sFEA
         f2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736319635; x=1736924435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3ajwCEJzuBWHLhfIS3uOIg9mbtSga1CIaOnP3nLDr0=;
        b=skQFrR6tqPXCpRa42vGVyjIfPhF8EdpvjKaxGXFdzPMGLPBVz3WcXJMtBdCp6zsGqR
         e8NupTslkmtRXZzfSQMIexrT0BOnl8ctPxUkQG4p1TiG5y2V/m4vuMeYAwBpAvKN8Zq9
         mHy5UWG7UYUgRBzTCb2RzepZdG2+sHbuCC4riudBof99cuonHs9QOFlYJo/TBd1mScSD
         sgxIdY4cZxEtvyHvUorWfFhTeTJuI5wx9ddwdVqMBeoWw8pAps4COXoWQZRLFlnc2mEy
         UFjbE1c6xHtthphmzdvwBy8caZrEz4iQO2p6K7EPdiViVdC2MoGV1tFuj1tgZVI3hau/
         6oIg==
X-Forwarded-Encrypted: i=1; AJvYcCV4BEZ1ZNo1PrlqUxxz8yUc17T4nGbN00Nzc/sA/gQGsBe0ZOMj3t329U2c+GNQYOpg9jGt2jHCKQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwiuME9eGdHRz+l+wj3h1lS6s8IrD9jcKQn9Xwu2qMFR1Qujl5k
	FHVR3HCR0IvyYnq1rywz9ZEfRdZrTCa0kYQp3sw4EWyP+C8XwWcoE1/WWv/OpwA=
X-Gm-Gg: ASbGncsH9F5Cs75IrVFjZ6956gItEo1a31b9cFWn3WWmRI9fHTJ65IlvlHruoUGiUYj
	AnnS86b1LZR+A1PI+LqNWifr9IjwJPVCIkrHhmssekBar0otCLumoKdP+7esJOzkDxeS07FR5F2
	60BRZSE/J5UiOhib93RX42d7jl1qx01wuWLX+k+MO5dAKMWa35lHMCiZJl8P7LwyBuCqBqgEolQ
	HloG8AgmXg/V0uuiEVzkKueX2l5Rj2zCpCeEY5KoeSq9a8ttwmZsdZ5qLIxSGJFFjWJGmLQqZjY
	2GXREEcCeTmuQPcWeGRwFDFnpXY=
X-Google-Smtp-Source: AGHT+IFQatZJEh1vMaYN2M2lTtxd4TB3DgwS5fDlIHVUeP0cQjVCzCSP2sGAFE7qJT7hKS5hKn1bKA==
X-Received: by 2002:a17:902:d4d2:b0:215:9642:4d6d with SMTP id d9443c01a7336-21a83f55157mr23731385ad.17.1736319635015;
        Tue, 07 Jan 2025 23:00:35 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca023a3sm320067275ad.250.2025.01.07.23.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 23:00:34 -0800 (PST)
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
Subject: [PATCH v5 05/17] arm64: pgtable: use mmu gather to free p4d level page table
Date: Wed,  8 Jan 2025 14:57:21 +0800
Message-Id: <3fd48525397b34a64f7c0eb76746da30814dc941.1736317725.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1736317725.git.zhengqi.arch@bytedance.com>
References: <cover.1736317725.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_230035_623835_06A086FF 
X-CRM114-Status: UNSURE (   8.96  )
X-CRM114-Notice: Please train this message.
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

Like other levels of page tables, also use mmu gather mechanism to free
p4d level page table.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/asm/pgalloc.h |  1 -
 arch/arm64/include/asm/tlb.h     | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 2965f5a7e39e3..1b4509d3382c6 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -85,7 +85,6 @@ static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgdp, p4d_t *p4dp)
 	__pgd_populate(pgdp, __pa(p4dp), pgdval);
 }
 
-#define __p4d_free_tlb(tlb, p4d, addr)  p4d_free((tlb)->mm, p4d)
 #else
 static inline void __pgd_populate(pgd_t *pgdp, phys_addr_t p4dp, pgdval_t prot)
 {
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index a947c6e784ed2..445282cde9afb 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -111,4 +111,18 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
 }
 #endif
 
+#if CONFIG_PGTABLE_LEVELS > 4
+static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4dp,
+				  unsigned long addr)
+{
+	struct ptdesc *ptdesc = virt_to_ptdesc(p4dp);
+
+	if (!pgtable_l5_enabled())
+		return;
+
+	pagetable_p4d_dtor(ptdesc);
+	tlb_remove_ptdesc(tlb, ptdesc);
+}
+#endif
+
 #endif
-- 
2.20.1


