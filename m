Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76AF3E7718F
	for <linux-um@archiver.kernel.org>; Mon, 30 Dec 2024 10:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0nJ0bdEaVLB0+13gaCQHdoBfFkuXXT3Pqta7GOjv8Bo=; b=hMjxH1fEh8ifdo1y8fZcrVHu2y
	r4EUxs9nqO6rztf2yGSJmq9UQ2aUk3m4K8DhbKqFg87y9yMH6IwWOFI31HI30A+2KhJagTzR3GtX9
	R7XtJXR0LPPfwVeiRWQ4r0QDy1uIqlpWw0F/ha/hvGKSQD3V5xcqFiMkOg8VFruEZM9n4IecjcIAd
	Exw+yTInkQblJJEO4IjMDmopHQ3a0XA5wTQ54IVzQTl4borEfIacGlsXveb89FnivAcVs8RDABd/b
	ByCBVNDqEASdCkRHTfExoLeCsiHW+8/NCJw0CaNGGwRbr2OsXqmp6TN98VUtuSThhiKY1ae0tJfT9
	XejeOM5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tSCyJ-0000000522I-2OeK;
	Mon, 30 Dec 2024 10:26:03 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tSBnF-00000004sgS-1Coj
	for linux-um@lists.infradead.org;
	Mon, 30 Dec 2024 09:10:35 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-21661be2c2dso104542445ad.1
        for <linux-um@lists.infradead.org>; Mon, 30 Dec 2024 01:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735549833; x=1736154633; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nJ0bdEaVLB0+13gaCQHdoBfFkuXXT3Pqta7GOjv8Bo=;
        b=iaz5IacyshM3wFaDDXJlKc1lZ3YcFOQXUWOhLQ6Uo0yVAVs6V0oJ4r6cguxnspzU33
         FSQecGhkmqXOxHUXKht20hqJf9QLhNk2tDdzGTC1D/QXWkZw8GOwk5vm42EdKIdxYe0P
         2bhVRyYY6XBOr4/ZDquKHIqN2qaarP5lBhq6w5eFuUElU8ZetBc+KstlYvXWv/XBQMy+
         Xn+t6YG6LhnTQfc6E8ViIIH2oQoqly9vVNE7CWRUQAfoxrbgUvzzcONpTYRZ2t44+Bh+
         RU/6afxWx5wZtR0O/zO/Bn81+3DclvGREhnW01O5C78FH0dVXm0P+a+Od7AFId/agATQ
         dodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735549833; x=1736154633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nJ0bdEaVLB0+13gaCQHdoBfFkuXXT3Pqta7GOjv8Bo=;
        b=LfdWRcpHpHpMxhRJOkjsd9txZkb03f9CoJT4uz8WyqhY8p/tjFHxPeD+tHXhZ8fyAE
         jIgtcSFvMKHn0sevEO7JATvRFtf6gOkhK4SvgQ03hwtYjFPQ8ysTF4D+l4t6j3beZIgp
         PAQtL57tBhw5P56BLdd/Bws+CwlEtk7JXt2VDrBaA7R2kX9qoLIOi3HHWSK+16sn0cY3
         uJR7Cr0whV+9fGFvAQ8Gwf8g+Z1yqdwpp+CYDQiue0siG3K9DZk0G5xVFduby2Fdt6PA
         W+NiCKmoJcTYCdqJz3TTH7fFqIoVan02ilMmnZgXA2OFEMFvQSMol4wWuDWU6UswhqS9
         Emzw==
X-Forwarded-Encrypted: i=1; AJvYcCU8R+VnhrmRLfmU+Y99rHsCxYjdgwgW61qclWlUwYtobybI9Gq/QiYXpw4dBUoIReglEuiiMKP3Ug==@lists.infradead.org
X-Gm-Message-State: AOJu0YyJQv1EMdQd5UmTsAi5rmWM9Ky0iQO/jGwHFbpXx9x0pK6sYwcx
	kGofr1wY+vn5KjPolHTbMcXXupRXgCn6407nl4IQZcsVkXX2CmG1i70sNdGJyGw=
X-Gm-Gg: ASbGncvDstWDqjhwHPsd9KgrVVgUiL6psBdimXVvQmcrg7/TgVN5dgxiUIHGFRT6wRH
	ytLa4pUth1CW9LwG/9PvCMOmGEcqz4KoqlDXX4ycHbRuEe2KrOMNo3pwC9eFEowZz7ij7Df1KYi
	R1rhSYK2Wk9q6r7JVwlUlMYipkLwEIHcakIDIckFoLpiuZnKU1WPdnKojghuZWmw+r7EaabGFTg
	2xqWmzmOa3h47WHxd9AAdJLWi5RAqXGKSxYAWEwG1gpMD1MlZ5vI6k77MMSeCprtJTsXtr8Qv3F
	wE9pui8AMSZAFwidEO8kUw==
X-Google-Smtp-Source: AGHT+IGwnjGmNRtsc6wvIZAIM8FV7PRxiURIME1KaVRQ0EplG8wu3sXxm46oGULh37KJjV0x+YOVDQ==
X-Received: by 2002:a05:6a00:2181:b0:725:8c0f:6fa3 with SMTP id d2e1a72fcca58-72abdebb85dmr42631070b3a.22.1735549832564;
        Mon, 30 Dec 2024 01:10:32 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba72f7csm17057841a12.4.2024.12.30.01.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 01:10:32 -0800 (PST)
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
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 09/15] arm64: pgtable: move pagetable_dtor() to __tlb_remove_table()
Date: Mon, 30 Dec 2024 17:07:44 +0800
Message-Id: <df71d1bd87ace445383b8ae62087ae14e35eac3b.1735549103.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1735549103.git.zhengqi.arch@bytedance.com>
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241230_011033_361633_4CCEA930 
X-CRM114-Status: UNSURE (   9.71  )
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


