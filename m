Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC37DE7718B
	for <linux-um@archiver.kernel.org>; Mon, 23 Dec 2024 09:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VAJKsDdGNb+ALwQvMYs9Oz9Vq8VGrLJsA8GxB+kZmZc=; b=BhaIBufAeYRTA42usDS5QICVtu
	Vh1jtr89N7g2WeKDC8vK+pE5BcY7FCy9jTRVqLkhnXabkU06Y5/uppn/zjouTmmMQIqFiyDhM4pX+
	6S7BE1XA9RvnAWOm+LGg/f04J8Q7ExQm5ljxpGdMZVJld5A63ZNZp1KJdlMDNdQ96eYcnQpvBNYPF
	811PD4KehFMz0SNMe9cBJczAw83omPTr8K053FIZ+s2hrK8BgicM5l8dDMEK6Csn4Eo6a/9W+A+jh
	p0lXnlUrrkAJaw1Zvw6greXAaQOvSxkLm/ndni/KUsbV328c/pKjva+5kZ6tSsgGc7MLeZ7n7ZGPa
	hijf/m+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tPfDb-00000009k3x-1Xkt;
	Mon, 23 Dec 2024 09:59:19 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tPf0k-00000009hWq-39H3
	for linux-um@lists.infradead.org;
	Mon, 23 Dec 2024 09:46:04 +0000
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-728e729562fso3164698b3a.0
        for <linux-um@lists.infradead.org>; Mon, 23 Dec 2024 01:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734947162; x=1735551962; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAJKsDdGNb+ALwQvMYs9Oz9Vq8VGrLJsA8GxB+kZmZc=;
        b=hTtSLAP5sAPY0TF89JKr3Rb2m5Xr6h4ihoj9/EC79sNLnuyRgZkm4qjmVV8G/3rG4E
         8so3/CdL78cmmycHIETwLNKHqdlbVS22UFokPJWJPytUII3Nn3BtdsZVJHVRpZoBgfL7
         a22akR0Ll/MlRBmQZFibM8Aw7lsgF5BQbb4n2CS6QwKAG2RHk5IneY7Im1bdIUanhrGX
         Ndvw+mUpt/NHZV1Nkw/CbqasqywKqC29jcGP57q7FlJGMbxGBCAse54oMiYST5PL+zbD
         Dkdr+oA7FiEUeYce51l0yaMn98ow0mLH4wvphuDoTaoNBHQlBy+YXAY6taBBi9BkcbHx
         hYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734947162; x=1735551962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAJKsDdGNb+ALwQvMYs9Oz9Vq8VGrLJsA8GxB+kZmZc=;
        b=st1DjCdHFwRJOBecgX7/F4ou8gdNPWBkq9q34ZVYPOp0dYpGqubnT+WCrXU2F/ggTS
         fAGnZPov1RMrVuTre4ZjOsQTXMNp8TkNKVX193FoGg8t4EuQOL3y0hG0ZUMN2WOjBxqi
         t5amyBC7RgcqNC7qZe4rFGArjUh/EGfSpbLF6mQKSSy5hU7mk+0TdswVEsFi1WbMWrfP
         9UX3fv6hOabjlO75KY2l68XvMI1TLp7xzrfb+5LRVAVBvWuECwMi+uyuw58tXv6f6Ld9
         6EvfqtfJAig6ebo7655W0H2fHuWUDUPMAX7Tx0PsyhDOHEtm3ZfAFwbe7vEF1Rx4wh7y
         wOmA==
X-Forwarded-Encrypted: i=1; AJvYcCXz+QuyDCfgm3rE6+FA11Ile3psTSALOQhUWd8IAeA8Nok+911Tm3FvJaQL+9SgGsRZfAextqVMzA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwBrtcMCuFoN9vyph9bPIqwYNAkvhXE/ibfa/fDN9CNGiA44Bs3
	DhE0a12AyyLTTegurl5HPLpdlCvMga+iXIQzKfype+dEjlZGcoLkLZbiXMuI8wo=
X-Gm-Gg: ASbGncvtIwZRYYs3LrjpEQ9Zfa3peki6M+RXEm+yRKJXqyJGuLkJFeMvfGBP33E2JWW
	SDmO+duoGQFUrRq2MXYk9Qxx9JhrT6OZhmOgDkalSi2kS5lYhLO/gdZ91920I7MovyoQYHCqG+x
	CQuuYshn+69+vtQhoQse8AYWklAfmxx/HFYPTzYZnXqii22HSoGnWbPCew9so5wHhTSnDhFdJdg
	xqNc2MZQpIEk/skVCfX1FrvvUMN2GsrSB36ARoif+LwmrXKqGn34gk7noMvSHt2jpHAfoIZ/1Z8
	OVLxC3rjhReFMJdpKUiQfg==
X-Google-Smtp-Source: AGHT+IEiKQiNoCztX+vEmXJ78+SVJHcoRjQcReSYKDpgexw8hG6RQW+fGx0o5GN+OmUz8JwpFgmgkg==
X-Received: by 2002:a05:6a20:c88f:b0:1d5:10d6:92b9 with SMTP id adf61e73a8af0-1e5e07f88demr18787949637.30.1734947161832;
        Mon, 23 Dec 2024 01:46:01 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8486c6sm7468309b3a.85.2024.12.23.01.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:46:01 -0800 (PST)
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
Subject: [PATCH v3 14/17] mm: pgtable: move __tlb_remove_table_one() in x86 to generic file
Date: Mon, 23 Dec 2024 17:41:00 +0800
Message-Id: <286e9777dd266dc610de20120fae453b84d3a868.1734945104.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1734945104.git.zhengqi.arch@bytedance.com>
References: <cover.1734945104.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241223_014602_796631_7DF39D6A 
X-CRM114-Status: UNSURE (   8.24  )
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


