Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812BFE77188
	for <linux-um@archiver.kernel.org>; Mon, 30 Dec 2024 09:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mHzGZQny5JmimEm0kycepUlCOKttN6NXbKtm7VNKgbw=; b=2vWfPRV6zbHcPe6S7n8DxVpZSs
	QHF+HwZ6vy34rxARgNIIf2HWub+PEhaJSUvJumYjZpRgrjqeoyBpLYPeQ9m3j13oDVbkWUNi8urKa
	NABVL/q2QSwvZuKUpeTVGliKbivIcG+ACdAN+96DUmkBkqchBQ5+IVNqMJLiSc5lVkkEhdBzASOyf
	gz3kN5FYddv9fpU+HD1OJCac/F+dxY8w0ysE/IbUU7C7uvuGY7TD9CtEEfcteCXKrxp8Wiq3KSoT4
	aj4+TDAzc7SJm7PGnDi2fNsYa4CV/sCjJoE5QB4v+uLX82+j0Algi3LKYDLQPkOZWlxVhfFtqGDcr
	ZXedZrLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tSBnr-00000004t2O-09u0;
	Mon, 30 Dec 2024 09:11:11 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tSBlp-00000004rop-3lBm
	for linux-um@lists.infradead.org;
	Mon, 30 Dec 2024 09:09:07 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-219f8263ae0so75611415ad.0
        for <linux-um@lists.infradead.org>; Mon, 30 Dec 2024 01:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735549745; x=1736154545; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHzGZQny5JmimEm0kycepUlCOKttN6NXbKtm7VNKgbw=;
        b=N7RcsAuDAM4a7WSV1cJSzeZfGXCFRs6T7aMtHOFprOJy3yu62D6cCPw8aARjp5mDmG
         z0nG8uDfoVIEacuIi+fze2vPj3jw3Ct/Y7JFcQkzIwJ+iRdfYxPgik58hdsVZ+ouBAr9
         D3R0WzoCAA0PfTMspCJmfi2XA21JYaKG3bSXxmZ30Lyr7YjppCN1Gd3iiGZltwKbWYla
         dM8nqZ6GoHnbDtYl+gWT5ZFIvWUd8ZncwcDAK32/LO6Gwr6VVAskUOvePgg7SbaTilOY
         3r/5gEnldw5PBYA5ZHu0K5iMslTripP0i+u/Z5/yYQBJiPm7BKZSxdCBUHQYxubIOk2u
         sldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735549745; x=1736154545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mHzGZQny5JmimEm0kycepUlCOKttN6NXbKtm7VNKgbw=;
        b=d69jr6wZgtDkk5OjAlLgkNhb7OMggeBDWTUJOvRQDcH1sUvNtfWqpMNx8Am3GvXn/C
         TjwBgpgmeUXglrX5tXKmNejd0q4DFECPvzUKTnQjBTSnIj5EFTQgO836dVeGhju72my4
         DY/GQqi3IxjKXnh6d6KU+J7puXVYGWS7Ilpd5R1/QzzyZEHfVIDVXWeIEGxS21lIMa5n
         L3HuhutMirnAzWbq0PH5hqh0oVRvusza5Vc4P1+rdpZ0lKz2J71gc8WUyoR61kHxWQzt
         wE+5Kms0OolA6/c2/FAH5jiLm9prxQD9OiWZhr+Qv/AAqTsG72QAioo8Hc0IHGQcMhB+
         cmNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWff8l5jD+UP7vKTSe8/3DIfOB3fSNZfNpo0m8TfqqRmgJXwL8PbgST9L6U2zaappoCcFBmd+GPDA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxsF3iwaXSRUUyEPz0+YORVK4veDZQilC3yFR4/l/Ib2Cee9glx
	8mGoELEKgOzAfY81pwl7eVgXUBuf37toj157y/IeZOOaE47cJPwKYHou7Fzvz30=
X-Gm-Gg: ASbGncuAAj9xYlAvnNyOZuoV5o7XHYOQoAcd8CDU+lvnqVwLtgyQJqdwsTBMSdGh0dq
	+NRwnczAz3eMqEBD1jJeWNbAh5w/BzuWYxkqs5dT0tJv1cSlGj4tvdAKphvfTfPnkuD3/KIllvh
	h2odhib1oavk3OyG68ACjBgJwyYZvnBVfpXLMsZVQcwsKeH7fuiQJqbiMQ452/hSDasMsyniNJ7
	jfErTGpDC5ja0Lsrgr1boeVBnIZSRQW7YN5lGnm/e7liuzt8y9FJnnwJP+yXGd9eAUI775UPsxj
	smah0CcKu4LnQbZpM0udnQ==
X-Google-Smtp-Source: AGHT+IEdmvGR6U/qwRYH5ruA02a+sFRctKWchidIfEBAoumo12DzBepIE5K3QuQVJJ60xG/AvigJ4Q==
X-Received: by 2002:a05:6a20:a127:b0:1db:ddba:8795 with SMTP id adf61e73a8af0-1e5e08028cfmr53967973637.36.1735549745320;
        Mon, 30 Dec 2024 01:09:05 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba72f7csm17057841a12.4.2024.12.30.01.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 01:09:04 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
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
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v4 02/15] riscv: mm: Skip pgtable level check in {pud,p4d}_alloc_one
Date: Mon, 30 Dec 2024 17:07:37 +0800
Message-Id: <84ddf857508b98a195a790bc6ff6ab8849b44633.1735549103.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1735549103.git.zhengqi.arch@bytedance.com>
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241230_010905_951706_81CD8FF7 
X-CRM114-Status: GOOD (  10.86  )
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
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
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


