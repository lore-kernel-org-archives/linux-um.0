Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49102E7718B
	for <linux-um@archiver.kernel.org>; Mon, 23 Dec 2024 09:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0nJ0bdEaVLB0+13gaCQHdoBfFkuXXT3Pqta7GOjv8Bo=; b=wys76D61sNrcqHg4Uxt/ayVS0T
	qC98sOr1ZxbUEghpC9C9Zdi8a8Tw+gfsLO+3wIy9kcEBEhobm4syxWmfvDHp8oGRqRgisfCAMBT3h
	0Vdl5kulivd19qP/origdYUlW4MY1ilBaxNWXY3bHcgIg3W4Usj5BrARvx83Sc0mWIIAQ8mzDWxZn
	HcfA6nDrI5k1J8CiL2Z3viWl7k9Atn/p/6XynNVUwAYAxtbzsC87p2PY1swrI5msKsXlhwIrN6/5i
	xx7AnCdKxavPX1FycMSVTpUJl+wJtZL4oBsrU94BT2ChasxscREtel8stqofFTz9/lsVcS5E//lMZ
	WAjFBOiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tPf7i-00000009jDB-2ouo;
	Mon, 23 Dec 2024 09:53:14 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tPezi-00000009gwy-2TrS
	for linux-um@lists.infradead.org;
	Mon, 23 Dec 2024 09:45:01 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-728f1e66418so3210247b3a.2
        for <linux-um@lists.infradead.org>; Mon, 23 Dec 2024 01:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734947098; x=1735551898; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nJ0bdEaVLB0+13gaCQHdoBfFkuXXT3Pqta7GOjv8Bo=;
        b=S3at9zfz3yUNjlkjUPKzJaN+AAsKK1Vjgg9/OZxOi6o6ncGXF71uYtR1xjjE4iIlRM
         jCyJY4/7RZftYZlSP+Pu+NLnygsyt5CnpCsauB7PeSR42NaK+x3Ug6U32tjyLztSjgOP
         IjPHyvUv/dndwIhRKLqP/H+dypNNYwJVxSw6+YFpgfZKrzxuUPLEQz1CQJUjnusysbqd
         CsHV2BqsPnYri9kZQRgJyocOawSVNiVIxXvA8l/UumDNxo5dj6SbiuNVFO3WsEYbeW0y
         p9HHclfdzzShjjOQ6EB/FeaCn0ZxvCWL5jLZsFs8vD6TO48Sf14PVWSCnzoQ/OYdfOP8
         3hMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734947098; x=1735551898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nJ0bdEaVLB0+13gaCQHdoBfFkuXXT3Pqta7GOjv8Bo=;
        b=j6V+UjLjPn9gp0onZxLpNMTHSKssTcJtPdQm9n4V6NJO4MUH3sjPMwerh5IfwFZztp
         MTFq4ZI8uZKalXJFRnPQ5B0vCuPxW2DSXLEwZhmGrGtCR0NQp+ja7cqV+CuMf7J8A4rc
         pN2px3cLGhEWU+ldvwQk2HiOFstgRpPm+j0yrZI8VsaJIruihDnOF+EZVob1y5LqL+xq
         ANqUwU+7xw6J8jKjgxnBISZbNvAIRpp9fy1oHubNXHh0ZY77JVyijP2TLTXu0wT4c5S4
         Sp/x6Zi9tUzIe3iXPcalXOK4ERYIM0DhUBaJxbgkHEYmzaQdSFhz1rZI9z0GLsd2PWpj
         Dvog==
X-Forwarded-Encrypted: i=1; AJvYcCX+o3WeTMhQhAv61EgSyUG9tDnxuIgIr+U4dGsPoYdixrSm4Y1Q3PhTZE9EXw2h3B0DM2kxFY5dQA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw6yuHokhPek+4boPb/bohqMWQadu5Kjow98wJFl8h6Q+x6fXHv
	cY9Nlm7cyHPIXCE2X1cJVY2UJnypfnaZ7zldLlpp1XD0iWmuCJ3t/DM0AePRjnQ=
X-Gm-Gg: ASbGnctVaGjucdMzvEAsAJGFRXpM8RmhJAFOO0lEbMHZcAP5fQ+tHs2PZI5cTeYxKVX
	RknWgnkWC1kLU95TGRk55/UoBsaoteizdBPdlfHQP0f6cX+LPw53EaOEsjw70GyxH3baRGECf2E
	G3ylfzX6htWJNv1iygkzdUFxnkC891aNHHNAGgSY34tnyo5LMDSfm1yp4Ak3gkDR88MKEQAhyux
	FEcZtjPaNa2b+T/qDczWZPMPmT94qFuF7M85nl2LHWdSaO4L5IRx4RveqaUP+NzsPA8kVhGNdcq
	ndPtlu3vXYZakaQfOdScOg==
X-Google-Smtp-Source: AGHT+IH27a1l8kT42WYYi2KTFhW6smXjjCcrkYYj/EF7HLDGUXcMfllZ3ayHCCSFU+IsHMUxZvkRwQ==
X-Received: by 2002:a05:6a21:6f87:b0:1db:c20f:2c4d with SMTP id adf61e73a8af0-1e5e044b1c1mr19165305637.2.1734947098042;
        Mon, 23 Dec 2024 01:44:58 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8486c6sm7468309b3a.85.2024.12.23.01.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:44:57 -0800 (PST)
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
Subject: [PATCH v3 09/17] arm64: pgtable: move pagetable_dtor() to __tlb_remove_table()
Date: Mon, 23 Dec 2024 17:40:55 +0800
Message-Id: <df71d1bd87ace445383b8ae62087ae14e35eac3b.1734945104.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1734945104.git.zhengqi.arch@bytedance.com>
References: <cover.1734945104.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241223_014458_645141_77622CC9 
X-CRM114-Status: UNSURE (   9.52  )
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

Move pagetable_dtor() to __tlb_remove_table(), so that ptlock and page
table pages can be freed together (regardless of whether RCU is used).
This prevents the use-after-free problem where the ptlock is freed
immediately but the page table pages is freed later via RCU.

Page tables shouldn't have swap cache, so use pagetable_free() instead of
free_page_and_swap_cache() to free page table pages.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/asm/tlb.h | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 408d0f36a8a8f..93591a80b5bfb 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -9,11 +9,13 @@
 #define __ASM_TLB_H
 
 #include <linux/pagemap.h>
-#include <linux/swap.h>
 
 static inline void __tlb_remove_table(void *_table)
 {
-	free_page_and_swap_cache((struct page *)_table);
+	struct ptdesc *ptdesc = (struct ptdesc *)_table;
+
+	pagetable_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 #define tlb_flush tlb_flush
@@ -82,7 +84,6 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 {
 	struct ptdesc *ptdesc = page_ptdesc(pte);
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 }
 
@@ -92,7 +93,6 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 {
 	struct ptdesc *ptdesc = virt_to_ptdesc(pmdp);
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 }
 #endif
@@ -106,7 +106,6 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
 	if (!pgtable_l4_enabled())
 		return;
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 }
 #endif
@@ -120,7 +119,6 @@ static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4dp,
 	if (!pgtable_l5_enabled())
 		return;
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 }
 #endif
-- 
2.20.1


