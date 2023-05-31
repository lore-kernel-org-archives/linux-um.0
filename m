Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF9DC7EE29
	for <linux-um@archiver.kernel.org>; Wed, 31 May 2023 22:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=n7kSd22/Yuj173kUAI9D3JHWDpX/whpTU/+287lfYLo=; b=N7vosmlxuNPAAJ
	kGhG3T2KxSHipADaaWfvfm5oXbPP13rZFWitR6N8UVtfoup5i/IMYt/W/ZJUxw4KDJetQLbm9cM9g
	477x0Ur6h6ssW+XDMXluHZ9ZB4zXZliSpHkNI0viVCn2b+VnWhe2LIeUCVuq+/5j/MUj+bftBZXwU
	1M286IULpxsjcuXaeg0aT0a7Mgbq5ajgWLV8MtQDkB8eBrX+lbhsoNCrz8nmrGIdDzJ/TfV9+c/GE
	wj1G1uN93onnfHN4aIQkfdkLVYeXzV+eh6p/d/lSR2RIorMTEgu2gr7yKw00DNnoRcVUmIF01iV5n
	axJ1AzjEu3HK8DCjY1xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4UZY-001NnU-2h;
	Wed, 31 May 2023 22:45:40 +0000
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4TPZ-001A1d-2a;
	Wed, 31 May 2023 21:31:19 +0000
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-568ba7abc11so705537b3.3;
        Wed, 31 May 2023 14:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568677; x=1688160677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2bE9CDG9Oxw3pEA2fSuUshC33VMwoQ2Xz6qScjQL3E=;
        b=iYqqA4KZmoroGYhynV/jiNkWzAMHN4TlFNnsupyXM0HztFgnmGpbYhflGvCI4PnTEH
         qsb+x4h+Ra/DHJZpmJ+cDpCt0WFO8DN9RsHpGbhgd8UZD1C59aXCIdDYpdL/DDlqjtME
         QAC1ynKbnXEL2BUoeiDKJEOTEmjHPJwx20Oocm0d9VYWRam4vpslVsanNLIqZtenI7il
         z8Y4AX5Qo3hIFiKRtt14OfPeMVmgXXgQiLO70vbxlL1MgUQYvu/5R1IEb6sabFTUiQkk
         WKmmoKw4Cu+qJUco9/5c4L88Blpl8Ohrj5Udd50ZlUMrgKFkg8PwQhuutxVbJdY53ahQ
         RhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568677; x=1688160677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/2bE9CDG9Oxw3pEA2fSuUshC33VMwoQ2Xz6qScjQL3E=;
        b=Q9vwJEcDNa8gex6yxQxacXeYgqkSjhKP6y0SboP8hsNO2NpjSq6XGFwrWI8/9vBa55
         YGNCFQIZ250vGLqto/nOvT7XW4/vvNUPm5bBs5lQXmb3uqW5IXgoecV1hdYIS3eCzIy9
         Cc/kZNfS9bMGiFtCZS5f1kxV/ZH8HAICncFgexNsGAWoLFtmtHNwNRHYWpARvOCiFj0A
         2DI+tVsuuj5lNeYJfaeWpBaArbvIc9H+M8Alhyrs+zKv8Pz0Ikep2UJwsDQeCS7jgxBa
         slDlZ4XzsgoVZqaEl4LiqRGSE3wgp3K80RN2J0Ptpvv0DEz9YSlYHQeecNWcaJevUUY0
         4EIw==
X-Gm-Message-State: AC+VfDzlKhUGt9FVk04l0kfXclIWRM/pHiApnp995+EY7L02C5a5nwyA
	Hx531gSKfsgfcQKzl9z6JFo=
X-Google-Smtp-Source: ACHHUZ6pTbgk5oakG8rCTNTHmfkc+dDnZpqxrm9LdrARtP0jWcbiwYUD1VVJhesMtUI+Yz5eprOqiQ==
X-Received: by 2002:a0d:d816:0:b0:565:bb04:53fa with SMTP id a22-20020a0dd816000000b00565bb0453famr7385514ywe.10.1685568677391;
        Wed, 31 May 2023 14:31:17 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:31:17 -0700 (PDT)
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
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 04/34] pgtable: Create struct ptdesc
Date: Wed, 31 May 2023 14:30:02 -0700
Message-Id: <20230531213032.25338-5-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_143117_861472_79D61C84 
X-CRM114-Status: GOOD (  11.91  )
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
---
 include/linux/pgtable.h | 52 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index c5a51481bbb9..c997e9878969 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -975,6 +975,58 @@ static inline void ptep_modify_prot_commit(struct vm_area_struct *vma,
 #endif /* __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION */
 #endif /* CONFIG_MMU */
 
+
+/**
+ * struct ptdesc - Memory descriptor for page tables.
+ * @__page_flags: Same as page flags. Unused for page tables.
+ * @pt_list: List of used page tables. Used for s390 and x86.
+ * @_pt_pad_1: Padding that aliases with page's compound head.
+ * @pmd_huge_pte: Protected by ptdesc->ptl, used for THPs.
+ * @_pt_s390_gaddr: Aliases with page's mapping. Used for s390 gmap only.
+ * @pt_mm: Used for x86 pgds.
+ * @pt_frag_refcount: For fragmented page table tracking. Powerpc and s390 only.
+ * @ptl: Lock for the page table.
+ *
+ * This struct overlays struct page for now. Do not modify without a good
+ * understanding of the issues.
+ */
+struct ptdesc {
+	unsigned long __page_flags;
+
+	union {
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
+		unsigned long index;
+	};
+
+#if ALLOC_SPLIT_PTLOCKS
+	spinlock_t *ptl;
+#else
+	spinlock_t ptl;
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
