Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF92E77199
	for <linux-um@archiver.kernel.org>; Wed,  8 Jan 2025 07:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xRYydr57EpvJJkVepk/VS3bq1fMuYMijkZdKL5zejaA=; b=hzzsVtLi5chrdqduaba5zBONVI
	an4m/GlfzkWfVsT0kPWGl7puAMOgtRyPxMjn9DfjMmIGXrH/JtA7xS/4X2Jl9UfZh3fH5iqwf6dPH
	z+4ctxKefbGLxURuvDsvwCqpvglRCc3l2JC0coYXyhBNKAp+Dj4JhEGz5+r1qcdSD/WOK0nYNPVX6
	cauvAzCyUKNU6pscQEJJf8VezCKzPgsgZmtibFgcFJP3F2ohq62XTFg1HreuJAivyUtQLQVlCEdBV
	0dE3MYk6vl04krz3hj9xriaBhQkJMfgYeZgBhZf0vAQu1XD6iYXCvZNvqXzJNhglNr/XyHUubjJ9N
	dUzLh1bQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVQFL-00000007OBR-0DRI;
	Wed, 08 Jan 2025 07:12:55 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVQ48-00000007L10-1EiV
	for linux-um@lists.infradead.org;
	Wed, 08 Jan 2025 07:01:21 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2163dc5155fso239942865ad.0
        for <linux-um@lists.infradead.org>; Tue, 07 Jan 2025 23:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736319680; x=1736924480; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRYydr57EpvJJkVepk/VS3bq1fMuYMijkZdKL5zejaA=;
        b=TBq2iZsuFTlRrrS75227Sh2ZV5KQJz8EyjQIE70O1/1XfO5C7cJnr/lUN63CR4qNwj
         DMk6KzEgzOt60eKc7c6XBO8a5Xe5WtT1ajJB9WMEmrnedayRIL6URr9Uuk15G+t5tiFj
         uSBmMNnKCG40wRiTHpI/dX3yaQIF08clGycbH4pbXgpGhATFNvM9w6ZRWgJ9jpDgaJWC
         9nLJ6QhCn5+1bN7rbfQQ3dnEuIML+dOmseyhjAK6Fssz14fJ3fA2KMe1fcJiEL9QbbE/
         Wgpg0FX4IdH8RTGLrQC7549X2q7xBtCgs4Xipag/gwAQA1qVixdif7SFjs6X4wP9RK4a
         yxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736319680; x=1736924480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRYydr57EpvJJkVepk/VS3bq1fMuYMijkZdKL5zejaA=;
        b=OUvFOLv4avNuGAWWmk/fuse4gF2CkIH47IUn3Gl3wkiZkTzw8Znx4rznI0hI5pwSFY
         CDxrMnEyIm0i4AD0VO7gGO1KUCfjMFCLOaZoJD9UgDbT4CKp6ykWos9InKIb7MiHbf5D
         gyYudQRaw2cnxp8Cpqei4Ro5L24FhWDZDXJoxLGnuyOTnm07KdTLKk/W+bNDkMczMlpD
         HNwT73v21C2phEvBexcT8SVeg5Bw0iljdCFjhzLKh6+lYMBARZ3JvFd+hDzl4sQzZHLK
         vaqShiJ3wNvzLb5wFEJ4dpIqEB4mJmbnk2pJb3r23sf2Wupw0DXO7bWcIkzbNAZFYowG
         sUbw==
X-Forwarded-Encrypted: i=1; AJvYcCUR1e4/TzlGd6Q0qH4YcEzZgdr9ueaQyolZWApgqq5enksi3RYu+YleUIVHwC2F4/Ycv6tBPnl6zw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxxfNkKtn0eWiC42g6WknH/xWJSpkRQwhiOrwaCjqJ9qOrSZ4RU
	gRtzjxfO/5lTaVls8JvkYoaCGqRkF9b/U5YN98CNrgKxAlVV4ZU4gQXAvVvuJ50=
X-Gm-Gg: ASbGncsIs3YPpcW/TEtrwk8syd/DJOKQIZw9VH1pMUuKkLq284BNlpyw/2SyxxcptB/
	RWO3LWisDbNEIM+ZCOzsI0HpoWoKgMID1GdHonfGY6dK+57T+Bh96Igo3WbgFMp3VSTzXYFsVWf
	vAgqbr0domF98Y7JfMBiQz37vI0OoasryoSRRqRxSD4z0rrolEGOPu9bf/7n2m/i0mVkE8euuZ6
	UA8G3q2nsrYyl7xNgi6cCTYMe9PHZLmiu096pSw7zv3QBCIV1b8/EobjigkLBOuO60fusqNqzfH
	GRt8k84Nm+2RoG6fPow/muRJoYI=
X-Google-Smtp-Source: AGHT+IGA+MEO+KKVHOehVcxKdAaP4kVFc+4x/MGW5FidU7ZYZhG+ejtfRbHdQiRj7WdzfqmV0LUjgQ==
X-Received: by 2002:a17:902:d352:b0:215:8847:435c with SMTP id d9443c01a7336-21a83f4b133mr25527805ad.12.1736319679689;
        Tue, 07 Jan 2025 23:01:19 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca023a3sm320067275ad.250.2025.01.07.23.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 23:01:19 -0800 (PST)
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
Subject: [PATCH v5 08/17] arm: pgtable: move pagetable_dtor() to __tlb_remove_table()
Date: Wed,  8 Jan 2025 14:57:24 +0800
Message-Id: <327b4b8990729edd4ce97d9d5acbdaff2d9fa1d1.1736317725.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1736317725.git.zhengqi.arch@bytedance.com>
References: <cover.1736317725.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_230120_346764_67C92734 
X-CRM114-Status: GOOD (  10.03  )
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
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/include/asm/tlb.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index ef79bf1e8563f..59854c6b97bc5 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -26,12 +26,14 @@
 
 #else /* !CONFIG_MMU */
 
-#include <linux/swap.h>
 #include <asm/tlbflush.h>
 
 static inline void __tlb_remove_table(void *_table)
 {
-	free_page_and_swap_cache((struct page *)_table);
+	struct ptdesc *ptdesc = (struct ptdesc *)_table;
+
+	pagetable_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 #include <asm-generic/tlb.h>
@@ -41,7 +43,9 @@ __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long addr)
 {
 	struct ptdesc *ptdesc = page_ptdesc(pte);
 
+#ifndef CONFIG_MMU_GATHER_TABLE_FREE
 	pagetable_dtor(ptdesc);
+#endif
 
 #ifndef CONFIG_ARM_LPAE
 	/*
@@ -61,7 +65,6 @@ __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp, unsigned long addr)
 #ifdef CONFIG_ARM_LPAE
 	struct ptdesc *ptdesc = virt_to_ptdesc(pmdp);
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 #endif
 }
-- 
2.20.1


