Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3649E7718F
	for <linux-um@archiver.kernel.org>; Mon, 30 Dec 2024 09:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Uxx1VFA8X6F1Vml9+szJuo78n9B3sJITH2LTRfnVDm8=; b=pAiSx6dZAQZhn2niot6JJvBqkq
	OrtKdZ8RW4bb8YqgBrASg4xHl2dclBx49V1tVuMS/KN0iAcgjuFqW1GRAw3pLVuYp0jSBsviD18eZ
	5Vdg/S+33CGh/TdATOhDSQwa2y2kdLrwEMh58eSdjG0X0msXxZeHmr94sGjQcLjPFtWV/sBkZWkHs
	wMkafmUk+l+tfHHnwnV+mBp9CZNUlA3wSfqldbu7KyN2zTG3eBzlr8gx17JDmAhV07mJvVorCka6z
	c1PL5IkRLZN0to0A69mYejyjfrkRCtIAyko8suEYuwF672f7v3UlnDPPzntj6/UXZ+JQIYSGaXHSP
	h2EQHE/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tSC5O-00000004w52-1WX6;
	Mon, 30 Dec 2024 09:29:18 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tSBoR-00000004tNX-2AQj
	for linux-um@lists.infradead.org;
	Mon, 30 Dec 2024 09:11:49 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2163bd70069so13728035ad.0
        for <linux-um@lists.infradead.org>; Mon, 30 Dec 2024 01:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735549907; x=1736154707; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uxx1VFA8X6F1Vml9+szJuo78n9B3sJITH2LTRfnVDm8=;
        b=QmjmkGTD7KR3YTnAt4mUsgzmxCuVMGGpjvjUV7QYePBNVDFxYBEEAC3ipN2st9TYAP
         PUMzbiKVK6JT9P0NBDZOK949nvfIM7Vrt3p2TWj52vkxGJ8DH3fQXzK2CNWxlhejf8J7
         EcqIUgzC0CI+Ycu/S2+ZPHTH5pcClEV8lbllrVtIFd/tddUTD2PY12w4Opoy0K3C7cmA
         PklAXu9RMdERoB8wJ6ZiDoxzIu28MacxmHXL6TkpUvHO2uhUiGaosJESi198cs5UBD7x
         gyQsTZRSam7OOEAHDrB5UGM92je+mSf34MsZ1501k6QyGBHt46aXUNliBonQljjyAlcE
         APPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735549907; x=1736154707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uxx1VFA8X6F1Vml9+szJuo78n9B3sJITH2LTRfnVDm8=;
        b=XCoGoqbYeli2KtqP4Bc0VjaifEHG1wjiE49vfbpRuUlbnmXmplJHDenS4VNQZznFhd
         NjM1+4Ab1omulStj4M4CpphiMGTUvzKXsR1qZSQ+ztHSpGG6LIK0m6IbqhNRabvblU+w
         6xTc0Ppx7fYmEQ56wg9JLt+FUU/Zksesnl53eGdZP+5awndAFguYFIZqqGUfYN3qwxo1
         1YQdhupdDWyHvCoB2vzvrKEW1ctoAX1W1sxmWLCJ44cYO7R4wTqxblFJioCs/G1KAuyQ
         IH5elWOoOD9U+apw8/+Zqk35yjH1YFDW//UqoHYUkLpc41WPUwXAvnI4cA8Rtn7/e9D9
         NUHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOyo+Z3xzpss1QMqF8VqsL0SNSIbwRoxxcov2EOo5r1XNfC7SQrqi4jVXMYTqYAQ9piD2ywVMv/A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy3MnZoRwSRmguR9cv6gD+xytg38iLBMYnc8wAO4hL4z4Ju/v/o
	t81gSou95PoElbUBgFA6kQDLTaqXL/4OKBDb4q8286l0FeGAHgb9dTJe34V+DEo=
X-Gm-Gg: ASbGnctuJWlux7qfmYPfbAewZAdxumAnF42S3pJ9DO7cVUXOGSOQl2jrpghnDH4McSn
	N/tjzbbAhjkFswEZV9pqQ7xenQ5kusT8pTFFJR5aFaBGAcEIYQFDU1fjARyZBL511lxdZrUkELD
	gzYx7SMHFv84psF93HA5WOm28px6rAodl+y8GQNi9Wb67otxihHdUSYGY3ytyN3eMmFZYHp+IMb
	1+7dKJQfdHT7xaFE8k8F0yPAUtLTWanF76Yz+4gN5KO8MBgw4VuXx/eCMdO/QHw7cJkheL4sn+Z
	X7Q15dZET9coRY+IIJiH5A==
X-Google-Smtp-Source: AGHT+IH6enLQBRxhPiyC+b4rbFoH6ZPXIb+9j2XLkfNoZdfNkkGtY/WgMqtF7HfldrPWQopcc9iyNw==
X-Received: by 2002:a05:6a20:4308:b0:1e0:c8d9:3382 with SMTP id adf61e73a8af0-1e5e0847084mr55644198637.45.1735549906952;
        Mon, 30 Dec 2024 01:11:46 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba72f7csm17057841a12.4.2024.12.30.01.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 01:11:46 -0800 (PST)
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
Subject: [PATCH v4 15/15] mm: pgtable: introduce generic pagetable_dtor_free()
Date: Mon, 30 Dec 2024 17:07:50 +0800
Message-Id: <cb5700c21d0eed9eb50bac385be1fb6cdef7e530.1735549103.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1735549103.git.zhengqi.arch@bytedance.com>
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241230_011147_558555_5D29483A 
X-CRM114-Status: UNSURE (   8.97  )
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

The pte_free(), pmd_free(), __pud_free() and __p4d_free() in
asm-generic/pgalloc.h and the generic __tlb_remove_table() are basically
the same, so let's introduce pagetable_dtor_free() to deduplicate them.

In addition, the pagetable_dtor_free() in s390 does the same thing, so
let's s390 also calls generic pagetable_dtor_free().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/s390/mm/pgalloc.c        |  6 ------
 include/asm-generic/pgalloc.h | 12 ++++--------
 include/asm-generic/tlb.h     |  3 +--
 include/linux/mm.h            |  6 ++++++
 4 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 3e002dea6278f..a4e7619020931 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -180,12 +180,6 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 	return table;
 }
 
-static void pagetable_dtor_free(struct ptdesc *ptdesc)
-{
-	pagetable_dtor(ptdesc);
-	pagetable_free(ptdesc);
-}
-
 void page_table_free(struct mm_struct *mm, unsigned long *table)
 {
 	struct ptdesc *ptdesc = virt_to_ptdesc(table);
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 4afb346eae255..e3977ddca15e4 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -109,8 +109,7 @@ static inline void pte_free(struct mm_struct *mm, struct page *pte_page)
 {
 	struct ptdesc *ptdesc = page_ptdesc(pte_page);
 
-	pagetable_dtor(ptdesc);
-	pagetable_free(ptdesc);
+	pagetable_dtor_free(ptdesc);
 }
 
 
@@ -153,8 +152,7 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 	struct ptdesc *ptdesc = virt_to_ptdesc(pmd);
 
 	BUG_ON((unsigned long)pmd & (PAGE_SIZE-1));
-	pagetable_dtor(ptdesc);
-	pagetable_free(ptdesc);
+	pagetable_dtor_free(ptdesc);
 }
 #endif
 
@@ -202,8 +200,7 @@ static inline void __pud_free(struct mm_struct *mm, pud_t *pud)
 	struct ptdesc *ptdesc = virt_to_ptdesc(pud);
 
 	BUG_ON((unsigned long)pud & (PAGE_SIZE-1));
-	pagetable_dtor(ptdesc);
-	pagetable_free(ptdesc);
+	pagetable_dtor_free(ptdesc);
 }
 
 #ifndef __HAVE_ARCH_PUD_FREE
@@ -248,8 +245,7 @@ static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)
 	struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
 
 	BUG_ON((unsigned long)p4d & (PAGE_SIZE-1));
-	pagetable_dtor(ptdesc);
-	pagetable_free(ptdesc);
+	pagetable_dtor_free(ptdesc);
 }
 
 #ifndef __HAVE_ARCH_P4D_FREE
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 69de47c7ef3c5..a96d4b440f3da 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -213,8 +213,7 @@ static inline void __tlb_remove_table(void *table)
 {
 	struct ptdesc *ptdesc = (struct ptdesc *)table;
 
-	pagetable_dtor(ptdesc);
-	pagetable_free(ptdesc);
+	pagetable_dtor_free(ptdesc);
 }
 #endif
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index cad11fa10c192..94078c488e904 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3001,6 +3001,12 @@ static inline void pagetable_dtor(struct ptdesc *ptdesc)
 	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
 }
 
+static inline void pagetable_dtor_free(struct ptdesc *ptdesc)
+{
+	pagetable_dtor(ptdesc);
+	pagetable_free(ptdesc);
+}
+
 static inline bool pagetable_pte_ctor(struct ptdesc *ptdesc)
 {
 	struct folio *folio = ptdesc_folio(ptdesc);
-- 
2.20.1


