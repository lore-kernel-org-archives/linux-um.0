Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7422CE77199
	for <linux-um@archiver.kernel.org>; Wed,  8 Jan 2025 07:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WgpljFzcR37DW+k0izImY02NXJU+2N4CamZhPf6BMmU=; b=0SX/Nr1WbEw3VpZ1ifBcUBjUfo
	bP1b16VeHhoP9cK3Ct/hbIucsbQR3l25o/wAJ+/WpnVhBA5xnqFf73EH3b0ahTOLLS5hQEeacTmF9
	1MjGL7Bt9FedL+98SRdqwuTUrLEDTzBSR/00ZvyvZ3+WhJ+IjglBmu0qnX1SqZZsENQ9I5R/4yBxO
	AFVKN9evSMawc/ZqRne9am6UDaK9pTPHik6ww8xIrJHB2pZAXTtHgPezfmiceRZzjzJZadraKLrhb
	GGoIqmnsE3t8d35nfNYF2qz1tKbKXaNpRp4BLclsE0htCpAVzOY9NWF6s9Exye3PzNqC9ZDuPikHQ
	jZQ9mmQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVQ5n-00000007LvI-10iJ;
	Wed, 08 Jan 2025 07:03:03 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVQ2d-00000007KCf-1I7E
	for linux-um@lists.infradead.org;
	Wed, 08 Jan 2025 06:59:48 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2167141dfa1so9476775ad.1
        for <linux-um@lists.infradead.org>; Tue, 07 Jan 2025 22:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736319586; x=1736924386; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgpljFzcR37DW+k0izImY02NXJU+2N4CamZhPf6BMmU=;
        b=B58FyfQZGYZOmITEUN+oNjzWx14zqXglokbQNkjFG3gAmn3i95AxYh2JfGMMh+5uqC
         NBeiw1Dmj54U2hpYZbvlB6Ymj2A2uRM4Hnk0kQzm6x/nh1WEvqBAIZGLPY3hUsY0PMpN
         1/U+m/VbQ+uspzYGCpdX30NtL17ExXEYpLfJuU8tCv71EnKmQiuUVedMWfKDf1mBjHP+
         kYQdon2UgMiMo6Kudlc39s3ywUsTCVYAwnAmhZT1hWNL40gnUaofuy0gNZCbox7/m5TZ
         kZuUrZtfoRvN0XnHVGxB6bDFGlurAOQpUBdON7snYWXG37d5SKFoOKLqh5EWdTWgRRjg
         H2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736319586; x=1736924386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgpljFzcR37DW+k0izImY02NXJU+2N4CamZhPf6BMmU=;
        b=GJvcCXP5w4b+Ktxljk249JS0+yv03K0ihoYPpRH/dymXMC7VZRy8j7Kzf4CODV+Te+
         Hm//O1L9V/IszZFth5I7KZ/Zd2mntmZdLOxPExvkGenGnZvDK2KG/nvOBNdaFvQ7JE9X
         Svx9VgtuRTflk3/lYaiA2gJaSpF44vA+/sMSwNKyZw5Z8z1Qruq6SF/W6lqFpOL5+fLY
         KM1rhiL2AhjvPiOuBeJJpgx41jUS/9lQg8r/o2ASGB3yalU0/qulwMUYKQmCliqnmkMW
         fSrxqUpYcKG8x4uY0In/cqR4m9cdgPaoyTySWKFCpU8LGjVexxn9QVnMqX+XjSBLzA/1
         qFLw==
X-Forwarded-Encrypted: i=1; AJvYcCU+fmKH3cgd5h5ZyT5A7t2vURES0LmMQ6o+hZy2zyxZGpFgtgm1pID4ugG5HU4B1t+Vkupfa6Y1Zw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxHQontOTJhM9nNJ1fXfq3VfQfH6tEFFERd8JNh4h1c+cwLnwt8
	Pm1tya52EElzqw+sn9P+KEtmTES7HHRPG3SAgF5k/b/iGnZP/jhWeSRbn4jLUPI=
X-Gm-Gg: ASbGncu3uP151rDHVW0uYRtc7xYH/f+fukdyGjZF+rRSfCImKRrEkDgT61rYyg2ZXyS
	jnGdsvDTerp60pwB0ynbpdF9A2tUZoaiKWWDSyEG09wqwesrXFCoCgkt/YoilnMDrMnD3eI+KBW
	Z+aeKDP7yCxjkYbmc7ZmXXjClZZikGQcb+l26bG5vhwPB/FQtWWbt/gEDo2ojhI+4ap0OjAYF1t
	a88zSN6pHBC9sAcR7xEeFA3YEjVEejXGzREHdTmUkoiMyWEDH1qQVq4xyuFHqkSdxvaKjh6FNAj
	dsSUEEbCRLbMxb0hqIkPeyVatWs=
X-Google-Smtp-Source: AGHT+IEXmx6aGyXUatDDUSC3BIwwvJRBe2xxgGmNdG6bwRG2a4u7PgHO01+qr8GDOf9tBGHx3RRkKg==
X-Received: by 2002:a17:902:fc4d:b0:216:5db1:5dc1 with SMTP id d9443c01a7336-21a83bb9991mr32206305ad.1.1736319586298;
        Tue, 07 Jan 2025 22:59:46 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca023a3sm320067275ad.250.2025.01.07.22.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 22:59:45 -0800 (PST)
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
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v5 02/17] riscv: mm: Skip pgtable level check in {pud,p4d}_alloc_one
Date: Wed,  8 Jan 2025 14:57:18 +0800
Message-Id: <93a1c6bddc0ded9f1a9f15658c1e4af5c93d1194.1736317725.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1736317725.git.zhengqi.arch@bytedance.com>
References: <cover.1736317725.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_225947_340941_53878FFF 
X-CRM114-Status: GOOD (  11.02  )
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
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
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


