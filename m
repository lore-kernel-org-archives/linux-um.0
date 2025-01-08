Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01158E77188
	for <linux-um@archiver.kernel.org>; Wed,  8 Jan 2025 07:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qK7UmD8A9xmARwj2p/zsqM766rIMmkR9OD65YlbhPf0=; b=jX3eKyd1PIGKb7ZB+Xiw0GhzS4
	pU2upPvqqlbSubJ35SDgSfasuBxTnsw4bdTVzoBHNDSeFTh1pEAiTtlLI0jvy7w76hRWah5EbQX7k
	p4DnFJkshHTbWSmf5y+KQQTsxeafhqtubrcsQNlit2moenvsSXpSjK/8Zd3+OPxLwqqPyKIbRgeey
	VqHNBcNTWeAquBU2SSkTA4t0x9NWutBv6T5VF6zdY42gqez9mNp8Sc6UP3eJFMbSrrWfV/ugjAJs1
	DDc6vj62zL6D2dB6Od+eKm+Ks9lfAkXJpMIbBB6fhVZAr0amEVl4xc5d4nKiRrvQtDJbVMa/StyJN
	PydULQnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVQ4Y-00000007LFO-3AFQ;
	Wed, 08 Jan 2025 07:01:46 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVQ2O-00000007K5u-0QVQ
	for linux-um@lists.infradead.org;
	Wed, 08 Jan 2025 06:59:34 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-219f8263ae0so193705375ad.0
        for <linux-um@lists.infradead.org>; Tue, 07 Jan 2025 22:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736319571; x=1736924371; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qK7UmD8A9xmARwj2p/zsqM766rIMmkR9OD65YlbhPf0=;
        b=EjlrNq/BlD0easHKXgB6/vpEQoBhukUF7fi/XACzB5bQ0G+Jjqi2uPKqMk/j/ooepz
         XtfjU1DNlGAH/0K8qwEZv1XGhK4Y44KP8QSZgPjF3JI4/TFb41nXne3ugv2G+6j2BGnT
         RapFM7zO4JBmkaQB2ZTURjesoM+WKKlpfDVbKSgNw+ZQBOPvCFVyOx3AUr9MFXRDc39h
         39Oa3chvs9PjkTy9E//sjPGO1x8ncdU5Nq4WqnlSjO5/azZh5mbm4T+iz2tYEEi+DeP/
         H/g2DJyn4aYtjcgCqry4/M7FTzqKaNsvO/dxD5gqiOQ/myGpB48xjII146k0CnWoVzhs
         xSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736319571; x=1736924371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qK7UmD8A9xmARwj2p/zsqM766rIMmkR9OD65YlbhPf0=;
        b=vYk9AYU0BU3tj6732NEm9tNpZtWMOISRsVuQzmb4H8HyCGXt5bt3opQAl8YNw2OeCY
         6EAY1hpBtrs87HMCZs1z9iXIVNYt5yYl1cELHGeTJqN9YsD/ws9W5fvuEZpPusrTuwxX
         lBN4ogFNMUXFHMjHf/yc9xFwEcDOu32uXQuI9Sh7NPm/NUkEB+xKbOtw139pAPmatrAw
         TE1kEbGL0Vt3Y6RRiAZ3C60DVdf901FE2lu7Qq+dwNt8y0RhtrgplJKcENAZo3oIciYb
         37iZrls6kPbumlMGmO+63rJ4wLIyisEnV1BTq5E6wniYtpH42IXKAXHFy6Bl8NbxnF24
         UuMg==
X-Forwarded-Encrypted: i=1; AJvYcCWnlO67dhBavf6Mf1Ixag5BoADqC/tBV98eDCSvQVIAkMBzSEptVYJ8kAUb0YPN2jU2aNzajqL4RA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwVzCpwVXhjk7bkzAr0LSG+9hK8SCZ6ayTIOAuJow0F3KMLr0Mz
	UScQbcxNs2J2jBv/pD9aKTIqPFD23e8S5JXDQNbzcxOgV0Csu/I9TMqWhXOcipg=
X-Gm-Gg: ASbGnctr2sZnQUi8vcM860lx4ihG2bw4VcvT4e4Yg1og4s+ooyPAPWD7Jd3fVdWDJx2
	2LPwevzbiaYnuzA468qt4sBDwpwKVloMKAAlIKwh3xbX1vHmRvIi2J+3EV8abTbnxa5PeSkPFhN
	KpjuGVpxM7jGMOteFNOq/5wbPtQEK/6BA/7HWEgIxsjwY1WgX2FggKQLtiM8bgcZDWzK7OZdT2h
	GESe5dL2y8WdfSm4R+kwsTmLTV56a8TRFRH9aPm2TXGrrY2EI1w7+5TvILMxsIPYYzwh/D4RDtF
	TRMXDMzuWy4rahddHXlyO35dX6I=
X-Google-Smtp-Source: AGHT+IHPv/02/1SYwL+5wvpHkGRfZSWRMZ218tgsJxwry8Gh8x8rNq2cUbRiuSy0SgfT7Mb+CNVIfg==
X-Received: by 2002:a17:903:186:b0:216:34e5:6e49 with SMTP id d9443c01a7336-21a84001250mr22590365ad.57.1736319571238;
        Tue, 07 Jan 2025 22:59:31 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca023a3sm320067275ad.250.2025.01.07.22.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 22:59:30 -0800 (PST)
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
Subject: [PATCH v5 01/17] Revert "mm: pgtable: make ptlock be freed by RCU"
Date: Wed,  8 Jan 2025 14:57:17 +0800
Message-Id: <366002e0af83f0d5cad3f356db036cb6447492f7.1736317725.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1736317725.git.zhengqi.arch@bytedance.com>
References: <cover.1736317725.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_225932_165991_4166584C 
X-CRM114-Status: GOOD (  11.41  )
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

This reverts commit 2f3443770437e49abc39af26962d293851cbab6d.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 include/linux/mm.h       |  2 +-
 include/linux/mm_types.h |  9 +--------
 mm/memory.c              | 22 ++++++----------------
 3 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d61b9c7a3a7b0..c49bc7b764535 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2925,7 +2925,7 @@ void ptlock_free(struct ptdesc *ptdesc);
 
 static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
 {
-	return &(ptdesc->ptl->ptl);
+	return ptdesc->ptl;
 }
 #else /* ALLOC_SPLIT_PTLOCKS */
 static inline void ptlock_cache_init(void)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 90ab8293d714a..6b27db7f94963 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -434,13 +434,6 @@ FOLIO_MATCH(flags, _flags_2a);
 FOLIO_MATCH(compound_head, _head_2a);
 #undef FOLIO_MATCH
 
-#if ALLOC_SPLIT_PTLOCKS
-struct pt_lock {
-	spinlock_t ptl;
-	struct rcu_head rcu;
-};
-#endif
-
 /**
  * struct ptdesc -    Memory descriptor for page tables.
  * @__page_flags:     Same as page flags. Powerpc only.
@@ -489,7 +482,7 @@ struct ptdesc {
 	union {
 		unsigned long _pt_pad_2;
 #if ALLOC_SPLIT_PTLOCKS
-		struct pt_lock *ptl;
+		spinlock_t *ptl;
 #else
 		spinlock_t ptl;
 #endif
diff --git a/mm/memory.c b/mm/memory.c
index b9b05c3f93f11..9423967b24180 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -7034,34 +7034,24 @@ static struct kmem_cache *page_ptl_cachep;
 
 void __init ptlock_cache_init(void)
 {
-	page_ptl_cachep = kmem_cache_create("page->ptl", sizeof(struct pt_lock), 0,
+	page_ptl_cachep = kmem_cache_create("page->ptl", sizeof(spinlock_t), 0,
 			SLAB_PANIC, NULL);
 }
 
 bool ptlock_alloc(struct ptdesc *ptdesc)
 {
-	struct pt_lock *pt_lock;
+	spinlock_t *ptl;
 
-	pt_lock = kmem_cache_alloc(page_ptl_cachep, GFP_KERNEL);
-	if (!pt_lock)
+	ptl = kmem_cache_alloc(page_ptl_cachep, GFP_KERNEL);
+	if (!ptl)
 		return false;
-	ptdesc->ptl = pt_lock;
+	ptdesc->ptl = ptl;
 	return true;
 }
 
-static void ptlock_free_rcu(struct rcu_head *head)
-{
-	struct pt_lock *pt_lock;
-
-	pt_lock = container_of(head, struct pt_lock, rcu);
-	kmem_cache_free(page_ptl_cachep, pt_lock);
-}
-
 void ptlock_free(struct ptdesc *ptdesc)
 {
-	struct pt_lock *pt_lock = ptdesc->ptl;
-
-	call_rcu(&pt_lock->rcu, ptlock_free_rcu);
+	kmem_cache_free(page_ptl_cachep, ptdesc->ptl);
 }
 #endif
 
-- 
2.20.1


