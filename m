Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1BAE7718D
	for <linux-um@archiver.kernel.org>; Mon, 23 Dec 2024 09:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B/tJ15+vmer/NbqXoUznjybhQp/MgC6GOdT/GuQUXpM=; b=OVEHtfYtZ1zuUm8BoMwyUyl8Qo
	2qu+WiQX5EzyOIZYmGNV5cywKYDqF3ZT3rrAS2FEXJ3i95Se8wxOjH8nkm9crn766U0IRl8rZ9wtI
	/mgIAo3mmXR0YgGj6gycxb3w5rSo8VtZRC5sHSzkTa18USqNg6uhmGugjEkTJI75s3vvNYFB2SkIO
	UUJ2CHrIl2tExfq5ouosP3lhYVKsaqdF+5mi6v+HDzCixGez3ogoannzLdT4FG/HhEQNSu29S/F+y
	VFHKCdgyHZDhkbkeKe1TzpIjNM3cRWDKlBW27S3EDnbgvObdzrFs3cznlGTPZUa+cwRgpW5k0STAw
	86/cEX2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tPf0O-00000009hIV-0wZl;
	Mon, 23 Dec 2024 09:45:40 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tPeyH-00000009g9o-1Ny8
	for linux-um@lists.infradead.org;
	Mon, 23 Dec 2024 09:43:30 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-725f4623df7so3743661b3a.2
        for <linux-um@lists.infradead.org>; Mon, 23 Dec 2024 01:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734947009; x=1735551809; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/tJ15+vmer/NbqXoUznjybhQp/MgC6GOdT/GuQUXpM=;
        b=VY3XOzHwLvx6Xf7W1z+BGyRQXEuw2kIxzA6nwdtUvWhxV1/4eJWcv9c200FLpgIiRr
         yX587j8rvDds4waM/KQr8jLfs6Ywk1kwf6TVdec6zB+7hnK3DKDeDYSL0IQs5zJQXPBc
         ywWxVCi+uX+xpoLhp7kVlsqvJBeSkDRjMmfFm9QD52hKRiyQsj7buF8QCwBg5d7Q19pL
         15vGfuIVB9S63saaxU2AKg5KLZMyhNi/rWOdYvZRpMAlSZ7fQn5RKQKgjaikC3Yvssd5
         Y9CoePAOVXr78Wp3JDD7PtgdvigEU6i6f/fJij/S/66ogzdeNWg0KEsSFdZQHIjwA7wm
         8cJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734947009; x=1735551809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/tJ15+vmer/NbqXoUznjybhQp/MgC6GOdT/GuQUXpM=;
        b=stUF/qyIlT+IvqokmRjYR2r6wnVfFOtXT6hi2LbAUyTKWLYWqktP9DMM/qcaGE7wnZ
         tYV3bRyaze4/LThNSi9j+xMDAkxE0HqO6XtlVPBxJ1gGRWtj5NTIF+Tz/V4ptjyZPq1K
         s/Pau5/JTSmg+1++vh03YZvMhYvG6Hv2n8HA2o6d49ndlTJu32vS8yMYE0LVC6TUOw4S
         iLNs8qO9EBdL/J6sK41QCSKgoTQo0HJPRIkIJVo5hQxHhpdhQcpb1chHX6BRa2C664xp
         1bARqJEbqw0Q94VPMUomcm8U8fx5rTx8HbhCVyLmnDKnENRO7LpKbf8KATcRhtdmu5rb
         fEPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAMIivvIczmyYIL2H3oQy9fJn6D91ZSIAUWKTtyD6U67NAJS6pNkBrIW4sPRoowPfZscL6VJ89Xw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz+jB0QF3Zv1c9jronyUCN9mkUMVI3IyeILh0ifnv7iKaLRxxAb
	HDGk2cSBchSupcOT40jHm0qRaCxWGF8WuvASI8NoFvPplVxBfj3vjQw084etD8M=
X-Gm-Gg: ASbGncthrRzFuPccnZvaWMNYTF+QdFficPVD0W2I7zRSvBZWFRTvG+3DEcNX/l27m3y
	tIWIBxJ+NAgpW8wjRjdUk8sbhTwcVmf1Am1JtcZVG2ZvhmhiAdYOQOOIOSLzqQcIbeQDWuQBJ4h
	E348o85LpGqWhRcPAA7kC8Lk3+l9Ak1ps+TwezUFcdq6z+yKPkf419uUz+GYinEGwPb99gelGCY
	Z+0v2RjUOrOUu7RyYMRIwUF9SqjorMGkdnZAY+rLtkCHzhZS0wNNBQPrtRABaJcnC85X3zpV6cC
	sVAjhhZlxw8TlJvpoLOP5g==
X-Google-Smtp-Source: AGHT+IGn0WgNlH4n6jFU+xV15Lu8l6dnMV2FFWuW4zvXTMVJTCCaTT+ZxewqFKpQcJgKvmYU0RJrVw==
X-Received: by 2002:a05:6a00:35ca:b0:724:f86e:e3d9 with SMTP id d2e1a72fcca58-72abdecbdb4mr16058641b3a.14.1734947008718;
        Mon, 23 Dec 2024 01:43:28 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8486c6sm7468309b3a.85.2024.12.23.01.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:43:28 -0800 (PST)
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
Subject: [PATCH v3 02/17] riscv: mm: Skip pgtable level check in {pud,p4d}_alloc_one
Date: Mon, 23 Dec 2024 17:40:48 +0800
Message-Id: <84ddf857508b98a195a790bc6ff6ab8849b44633.1734945104.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1734945104.git.zhengqi.arch@bytedance.com>
References: <cover.1734945104.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241223_014329_374913_8A690B04 
X-CRM114-Status: GOOD (  10.67  )
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

From: Kevin Brodsky <kevin.brodsky@arm.com>

{pmd,pud,p4d}_alloc_one() is never called if the corresponding page
table level is folded, as {pmd,pud,p4d}_alloc() already does the
required check. We can therefore remove the runtime page table level
checks in {pud,p4d}_alloc_one. The PUD helper becomes equivalent to
the generic version, so we remove it altogether.

This is consistent with the way arm64 and x86 handle this situation
(runtime check in p4d_free() only).

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/riscv/include/asm/pgalloc.h | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index f52264304f772..8ad0bbe838a24 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -12,7 +12,6 @@
 #include <asm/tlb.h>
 
 #ifdef CONFIG_MMU
-#define __HAVE_ARCH_PUD_ALLOC_ONE
 #define __HAVE_ARCH_PUD_FREE
 #include <asm-generic/pgalloc.h>
 
@@ -88,15 +87,6 @@ static inline void pgd_populate_safe(struct mm_struct *mm, pgd_t *pgd,
 	}
 }
 
-#define pud_alloc_one pud_alloc_one
-static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
-{
-	if (pgtable_l4_enabled)
-		return __pud_alloc_one(mm, addr);
-
-	return NULL;
-}
-
 #define pud_free pud_free
 static inline void pud_free(struct mm_struct *mm, pud_t *pud)
 {
@@ -118,15 +108,11 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 #define p4d_alloc_one p4d_alloc_one
 static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	if (pgtable_l5_enabled) {
-		gfp_t gfp = GFP_PGTABLE_USER;
-
-		if (mm == &init_mm)
-			gfp = GFP_PGTABLE_KERNEL;
-		return (p4d_t *)get_zeroed_page(gfp);
-	}
+	gfp_t gfp = GFP_PGTABLE_USER;
 
-	return NULL;
+	if (mm == &init_mm)
+		gfp = GFP_PGTABLE_KERNEL;
+	return (p4d_t *)get_zeroed_page(gfp);
 }
 
 static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)
-- 
2.20.1


