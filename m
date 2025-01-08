Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C72DE7719A
	for <linux-um@archiver.kernel.org>; Wed,  8 Jan 2025 08:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x40aCfPUIT+7f+SOGlgpQ1mZ5+3GERu3xGzgSvQpPds=; b=FZDK4j3mt6Yavks5qKlIgcq0Qj
	pyWbk2Y7s3NAVFQGke+598lv4uznc61lJy5qirw70/+WmLrQc8IOtboabf4ICSHqRRPXjzXWnBshC
	JgVy7VE83DpV4ZDMOiXYpC3+ld7JeThonIGXMr7+gCV3bR8JnD3z5Qj0er2g5aLni9y4WnkIuVxYo
	UC6VGBbqXHZj5kyDYLgpxCsxzD4bDsYjr6XAE+pD6555WjJ7PnbqhD7Xg4opeRD3oSTVihBPFHL9+
	xyUGknRWUeHQS/lsVpKgTlTgKKS3nYKbpXiMIRc7Q7Xo1iWGs45i4juAbRkK2Pd48je1aui0GQ/3a
	mDtUwPOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVRYs-00000007adp-14ab;
	Wed, 08 Jan 2025 08:37:10 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVQ69-00000007MEK-03dq
	for linux-um@lists.infradead.org;
	Wed, 08 Jan 2025 07:03:27 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2166360285dso245990035ad.1
        for <linux-um@lists.infradead.org>; Tue, 07 Jan 2025 23:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736319804; x=1736924604; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x40aCfPUIT+7f+SOGlgpQ1mZ5+3GERu3xGzgSvQpPds=;
        b=cErJa+dcoSJE/mn/pazulzWYx2uXaXj9Xlj2o9i9WZdxRON7ez0TOFJip6ALSYd/qu
         Cdagq2A/hvRvp08ol/qzWvjJing3yqVfi1JYMzOS+uAiU9ogaoaHME81b9hzPnJXJOGT
         f45zqDCdBnjDkpk8H5hagzryUskT3OMg9nao20IJ2QaUvyFkDODzVHlQQbtWpyZt8SM9
         gs0aIAYCCZ9kVUURemUEgBlMH/4IZOpwuwNw5PMhP0OtYyiYnEnnpGlbLC3i8xL4d2QX
         qz6zHafA8VIu4Wrul7beWcHdX42Cxe390v5vIWt5LMJXgrRP4zSMuuyQXMRfjl5NoPIk
         QQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736319804; x=1736924604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x40aCfPUIT+7f+SOGlgpQ1mZ5+3GERu3xGzgSvQpPds=;
        b=STSlWHQx1xs3RhLjaNYf7Ssr8IXDgR1L3Iz/7iU+VKUpay0GMlqh/w4411c4Vw9q9Q
         x/gOTzJWa8Ly/6SUaO0CwZeHeqfs3j70MdaTlua3+RUu1J/2xpKtHhvVkuOVh6dmYNqa
         wVq5utnqZpEMKgOidDjsLRppTMjYAbn28AUBns7F+D4KhaXQGkasg7qOqX3Tezg/2tjl
         36Ydm63+yQTI2Li1Op2WFWidfR63zlNfraZlRlS/gCjAfOgyJZTdCKy+gTJYRWCm87Zf
         AKu/E4ryFTK8EjThjD0adpGpu+CdfH7UxvE5QfuHfeU9FJq2R+E9Npb5tR+YjrB0MgtS
         Eo+w==
X-Forwarded-Encrypted: i=1; AJvYcCVD+w7zeAhBRIF2a5FyhHPZFCgcEsuu58hykj3Nqb+XChFbEsPnKC4TBvziTGrqBV/Cs6AyCeoVwQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YywZz23jXGz2Zz7YfTEJUU9swqEwNL8/8T70FKUW3FXb+2z2qdD
	CSerK0SWlY3v5X/Ej0Uk19lzowufPxwsUhsqolg4j8Za3VeU3ZPU3f01hEaV/eM=
X-Gm-Gg: ASbGncuoiUi0NRoCfxLX6KFJzpkswt8JzsusNsB9aPDFOuw6Ogu6Gy8lwhxPlQ1Ii6k
	uPluCoAt2a4piBlKL3rFwsuQildyO7TniIyrCbKi/wvYLNMDXtkzpGVwet9LzQaYWGIgM+r4dyK
	23pikdOXGSuip1kNWKZGAephfeknUblypCmhuce2ARuCHtNHROTaecPentyhv8uOYhiX5WYVZth
	OkSG8y8XmGe9eQSSOmPcGKuqgYk4/MjhVHuSKiutGs9Tgz1lbOuFTrLfKuqXP/hEZANaekrFGcb
	2hIuUlhPq1bH0AbDvxjmVMMhZko=
X-Google-Smtp-Source: AGHT+IH8IKObAIjKqBGW3XQDBdiOawtDgYf1Tuj1urKOF9Kp4Be/TSELj5l2Ma8a+iBaK6i0ld/PMQ==
X-Received: by 2002:a17:902:da8e:b0:216:410d:4c67 with SMTP id d9443c01a7336-21a83fb1395mr28350885ad.41.1736319804422;
        Tue, 07 Jan 2025 23:03:24 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca023a3sm320067275ad.250.2025.01.07.23.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 23:03:23 -0800 (PST)
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
Subject: [PATCH v5 16/17] mm: pgtable: move __tlb_remove_table_one() in x86 to generic file
Date: Wed,  8 Jan 2025 14:57:32 +0800
Message-Id: <aab8a449bc67167943fd2cb5aab0a3a23b7b1cd7.1736317725.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1736317725.git.zhengqi.arch@bytedance.com>
References: <cover.1736317725.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_230325_096055_6CE256BC 
X-CRM114-Status: UNSURE (   8.69  )
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

The __tlb_remove_table_one() in x86 does not contain architecture-specific
content, so move it to the generic file.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/x86/include/asm/tlb.h | 19 -------------------
 mm/mmu_gather.c            | 20 ++++++++++++++++++--
 2 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 3858dbf75880e..77f52bc1578a7 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -20,25 +20,6 @@ static inline void tlb_flush(struct mmu_gather *tlb)
 	flush_tlb_mm_range(tlb->mm, start, end, stride_shift, tlb->freed_tables);
 }
 
-#ifdef CONFIG_PT_RECLAIM
-static inline void __tlb_remove_table_one_rcu(struct rcu_head *head)
-{
-	struct ptdesc *ptdesc;
-
-	ptdesc = container_of(head, struct ptdesc, pt_rcu_head);
-	__tlb_remove_table(ptdesc);
-}
-
-static inline void __tlb_remove_table_one(void *table)
-{
-	struct ptdesc *ptdesc;
-
-	ptdesc = table;
-	call_rcu(&ptdesc->pt_rcu_head, __tlb_remove_table_one_rcu);
-}
-#define __tlb_remove_table_one __tlb_remove_table_one
-#endif /* CONFIG_PT_RECLAIM */
-
 static inline void invlpg(unsigned long addr)
 {
 	asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 1e21022bcf339..7aa6f18c500b2 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -311,13 +311,29 @@ static inline void tlb_table_invalidate(struct mmu_gather *tlb)
 	}
 }
 
-#ifndef __tlb_remove_table_one
+#ifdef CONFIG_PT_RECLAIM
+static inline void __tlb_remove_table_one_rcu(struct rcu_head *head)
+{
+	struct ptdesc *ptdesc;
+
+	ptdesc = container_of(head, struct ptdesc, pt_rcu_head);
+	__tlb_remove_table(ptdesc);
+}
+
+static inline void __tlb_remove_table_one(void *table)
+{
+	struct ptdesc *ptdesc;
+
+	ptdesc = table;
+	call_rcu(&ptdesc->pt_rcu_head, __tlb_remove_table_one_rcu);
+}
+#else
 static inline void __tlb_remove_table_one(void *table)
 {
 	tlb_remove_table_sync_one();
 	__tlb_remove_table(table);
 }
-#endif
+#endif /* CONFIG_PT_RECLAIM */
 
 static void tlb_remove_table_one(void *table)
 {
-- 
2.20.1


