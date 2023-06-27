Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DC3C05052
	for <linux-um@archiver.kernel.org>; Tue, 27 Jun 2023 03:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aVIT+a1zpmO0q7obE2JdwCRkdZXu0Ydc12eZXmawPrY=; b=KCLVIAaRqBazlC
	lfwuSWUopbfp2kpweWtcBoD8BP9Z75gsoj2vSoGkGmKfnnlFeqzaTK3vLsVr66B3t+xkImozhg+g8
	lLc54tYkHdXdkwqGvwPJqYAREwYggsDBNPF/X9Q2eDVp4FJlHyMqZQbzj0OTCptPrOiZDpcOkRJQI
	foaxv66pbfYh4fn9XmVdMQ9BjaHQmE8iFkE7Dj8PvjQq3Ft8BKsU0rtEk+m+oNft6nRvKbMh+i4yE
	rmd01necLaHp9rx8MuixR9D846YowWkEiT/9zl0R4oEePXB0RcVOXZ1Wm9rjJFhVuM4PAGIyE4Sjt
	QHtikV76C2bpNMrA+51g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qDzAz-00BVe9-0j;
	Tue, 27 Jun 2023 03:15:33 +0000
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qDzAh-00BVME-1n;
	Tue, 27 Jun 2023 03:15:17 +0000
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5703cb4bcb4so32844777b3.3;
        Mon, 26 Jun 2023 20:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687835714; x=1690427714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g10wkISUfh+NWh/zmhT9FX+m3ZttfvdTUqPKBonJP24=;
        b=YbS6It5/jG4gj9GV1WnqlWfE48J9CdnxNvOxOEYb2jkpFBwkcijgogv5/2FTyBYSJu
         izIlhC4BKNDwS5s1e4kK9kflroiGbN+V3CM6t7L2EFgtcSkg+ReKLemBNYF5Y3oVXg4d
         FUK6TJROlYVwfl34r2gL5piZl88lZtnh5mJi4W6rFRki4guA/8D+KKFrkkfHcSu1EJOJ
         fncA5E4mKOaGZV6UHnLSf+mughQQ2/sG6vdU9OT//BnRvDPbrV7dVSZuLKiGxg9g4JB4
         L4rqAG2yhTX1HWLW8k7KKi4wHWH5luhyXPrJQJ+E2hOyRozoqBZDlMJstEk3Y4X/0/Xj
         8nVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687835714; x=1690427714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g10wkISUfh+NWh/zmhT9FX+m3ZttfvdTUqPKBonJP24=;
        b=jkSBu6tAt5MGqFxHgmKW0g0q928zlGUYTa0uM6P+w4L/aa1Pi5UAB9+0X6VGVl2Qpn
         EKSgZE3PDd1uckhSGXNmiFvPbgulX2ZE0rCWG2Mkl9q/o/zVswxUzR4ujrkN6JHd07EO
         vtA1LEfW7llpAFAFpd7HOesoL1IrKnycz0NXmSn/fMGWCqo4RIh+h8KftjNraZMpOKP0
         7fr/qGwb4xHVIXbE1lKFyILR0U4sfpenTNsWRsw5z2xUklFMW09brqiKH5c13pqjRuB/
         8w+ruI42bV0owzhNQw99CixFXSYTeiDqRkaxW0srXi6qLRrP1UTfE0vl64qymBPDO79I
         zWFw==
X-Gm-Message-State: AC+VfDzFB5cpWafvqwu1qMSmJR517nzsWk7Fu+QmIqiSbgIRX7ZAUHbp
	fy0Ak6aWlVmQQuj3OPkw47E=
X-Google-Smtp-Source: ACHHUZ4trddfgXzjmNYnvfIX3UyOWVfVwt64/0k1X+1Ib62f54dPN/U9UUyskS0pcHiYwtqCWDYcTQ==
X-Received: by 2002:a81:4e44:0:b0:56f:ff55:2b74 with SMTP id c65-20020a814e44000000b0056fff552b74mr21585770ywb.37.1687835714203;
        Mon, 26 Jun 2023 20:15:14 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s4-20020a0dd004000000b0057399b3bd26sm1614798ywd.33.2023.06.26.20.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:15:13 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	xen-devel@lists.xenproject.org,
	kvm@vger.kernel.org,
	Hugh Dickins <hughd@google.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v6 03/33] pgtable: Create struct ptdesc
Date: Mon, 26 Jun 2023 20:14:01 -0700
Message-Id: <20230627031431.29653-4-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627031431.29653-1-vishal.moola@gmail.com>
References: <20230627031431.29653-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230626_201515_633807_7ED2F0C6 
X-CRM114-Status: GOOD (  12.24  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Currently, page table information is stored within struct page. As part
of simplifying struct page, create struct ptdesc for page table
information.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/pgtable.h | 68 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 5063b482e34f..d46cb709ce08 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -987,6 +987,74 @@ static inline void ptep_modify_prot_commit(struct vm_area_struct *vma,
 #endif /* __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION */
 #endif /* CONFIG_MMU */
 
+
+/**
+ * struct ptdesc -    Memory descriptor for page tables.
+ * @__page_flags:     Same as page flags. Unused for page tables.
+ * @pt_rcu_head:      For freeing page table pages.
+ * @pt_list:          List of used page tables. Used for s390 and x86.
+ * @_pt_pad_1:        Padding that aliases with page's compound head.
+ * @pmd_huge_pte:     Protected by ptdesc->ptl, used for THPs.
+ * @_pt_s390_gaddr:   Aliases with page's mapping. Used for s390 gmap only.
+ * @pt_mm:            Used for x86 pgds.
+ * @pt_frag_refcount: For fragmented page table tracking. Powerpc and s390 only.
+ * @ptl:              Lock for the page table.
+ * @__page_type:      Same as page->page_type. Unused for page tables.
+ * @_refcount:        Same as page refcount. Used for s390 page tables.
+ * @pt_memcg_data:    Memcg data. Tracked for page tables here.
+ *
+ * This struct overlays struct page for now. Do not modify without a good
+ * understanding of the issues.
+ */
+struct ptdesc {
+	unsigned long __page_flags;
+
+	union {
+		struct rcu_head pt_rcu_head;
+		struct list_head pt_list;
+		struct {
+			unsigned long _pt_pad_1;
+			pgtable_t pmd_huge_pte;
+		};
+	};
+	unsigned long _pt_s390_gaddr;
+
+	union {
+		struct mm_struct *pt_mm;
+		atomic_t pt_frag_refcount;
+	};
+
+	union {
+		unsigned long _pt_pad_2;
+#if ALLOC_SPLIT_PTLOCKS
+		spinlock_t *ptl;
+#else
+		spinlock_t ptl;
+#endif
+	};
+	unsigned int __page_type;
+	atomic_t _refcount;
+#ifdef CONFIG_MEMCG
+	unsigned long pt_memcg_data;
+#endif
+};
+
+#define TABLE_MATCH(pg, pt)						\
+	static_assert(offsetof(struct page, pg) == offsetof(struct ptdesc, pt))
+TABLE_MATCH(flags, __page_flags);
+TABLE_MATCH(compound_head, pt_list);
+TABLE_MATCH(compound_head, _pt_pad_1);
+TABLE_MATCH(pmd_huge_pte, pmd_huge_pte);
+TABLE_MATCH(mapping, _pt_s390_gaddr);
+TABLE_MATCH(pt_mm, pt_mm);
+TABLE_MATCH(ptl, ptl);
+TABLE_MATCH(rcu_head, pt_rcu_head);
+#ifdef CONFIG_MEMCG
+TABLE_MATCH(memcg_data, pt_memcg_data);
+#endif
+#undef TABLE_MATCH
+static_assert(sizeof(struct ptdesc) <= sizeof(struct page));
+
 /*
  * No-op macros that just return the current protection value. Defined here
  * because these macros can be used even if CONFIG_MMU is not defined.
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
