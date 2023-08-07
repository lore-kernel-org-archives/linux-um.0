Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264E8C001B0
	for <linux-um@archiver.kernel.org>; Mon,  7 Aug 2023 23:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CO+zPKxPYD4feosxlTAZYJg8Wyo9OZ2ybTJt4U/00ew=; b=p/Hh54O+uee45t
	fyKkaZLQ4Nsh7cwffpwwJwJa/MWsBUR1Ntcg80j+ei+0YOrO4FQlAj/DC47mlyApd9DiB56CUsdec
	O71G5+UTYN7KfjBCRWsYMvvG+rzhuivDRBF7NmzPn6LGO8tpCzamz7aaMv3fS38ZV2r/vmDct+J+/
	rEgZSctdH5MJc94xIR3k4OuLYOOkKTqvbxXnGGOMS5dux7kyPRhs5K6FXl82vhvgtkJxiv557lEvL
	v3F17S6L14w/72bvTbrSFr5mAmv2Kj+WJd1+3j4e/l+BC5AvJR1shQoz6TQtAu/ii7V4OVgFllooQ
	OSDTIkz9In9O9bqMjPnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9I6-0014Zf-2Y;
	Mon, 07 Aug 2023 23:05:34 +0000
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9Hw-0014Og-2Z;
	Mon, 07 Aug 2023 23:05:26 +0000
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-584243f84eeso57998547b3.0;
        Mon, 07 Aug 2023 16:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691449522; x=1692054322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a34f21esV50lWBersDNDqmppsx1/6ilmHOTavl/xl8o=;
        b=oFwky5a0u6RDMZneanUwrrMHlk718vp357up6yt/zwnqVYFChL1rvBLlof3lNCzIMa
         fNsEK2lTF1AVBptjZ1CNiCZUzihavKETKYN9gVvYQI6adZVOr5WVilhYnG1hRIdUadMS
         rZHYG0cY0MgC9spT/xtrGp0Z9RSAR89ub11+qTFSD/NHXR1SOhgGi5SO3dghfFZLOejg
         KputLo/y59tBrGZ+oHkk/Miwz+ltthb0+dR9j85/GLscklo1srlDZt2wotLowv37n6A5
         LO+9uJnrNQ6hj9u600MpE0S2h1+9c+75UpIga0Og5F4xShPF0bPK2EhAmwZTlcxr2oZQ
         4pBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449522; x=1692054322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a34f21esV50lWBersDNDqmppsx1/6ilmHOTavl/xl8o=;
        b=Oqe7nLmHfP+S+CcnNmx8igdBiWTbc558csMx53kVECei0fCFg1w4Vu5O6fLQ46dOjX
         5Jo7n1A1mmhjusVCES6+pvyptGufV7QfhBCpllF9m1T7co7k3MAEW0qjwusyinONEPFH
         DevyV3Oecek1SjQ0UIM0tTGOcibOawxWwpxU+NCDTDipEEUQCDTS1EHxx5oY1sAHoGN1
         4vYZr+fZ2eMftwy/1pITntLropvWtkoQ6y+ch5dRiEB++dRB+u6oMNDkAM0oNGrK1n9P
         qJ1k+SDoGRzMdI8lRwszNhhMUnKfcCOZFn4AY393sp1v/DOp0CRnwjOR6jIhpaZVg2Jo
         GQyg==
X-Gm-Message-State: AOJu0YwEOz+C6JCpOtJfWw5KVhTL18OM0KpYa4CbfoSaGYO/I54D9FsE
	vua2m6h0bz/fQP0NAxWKZmI=
X-Google-Smtp-Source: AGHT+IHp9NHIhzlo/URxP7pkQYxSTPvQNJLHOzpXCbXbudXygK+XnGEho5KZf1Qzac+pXhrvkYZIBg==
X-Received: by 2002:a25:320c:0:b0:d4b:64ac:a4f7 with SMTP id y12-20020a25320c000000b00d4b64aca4f7mr9519366yby.62.1691449522393;
        Mon, 07 Aug 2023 16:05:22 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id d190-20020a25cdc7000000b00d3596aca5bcsm2545203ybf.34.2023.08.07.16.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 16:05:22 -0700 (PDT)
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
Subject: [PATCH mm-unstable v9 02/31] pgtable: create struct ptdesc
Date: Mon,  7 Aug 2023 16:04:44 -0700
Message-Id: <20230807230513.102486-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807230513.102486-1-vishal.moola@gmail.com>
References: <20230807230513.102486-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_160524_838184_7437C591 
X-CRM114-Status: GOOD (  10.90  )
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

Currently, page table information is stored within struct page.  As part
of simplifying struct page, create struct ptdesc for page table
information.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/mm_types.h | 70 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 18c8c3d793b0..cb47438ae17f 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -397,6 +397,76 @@ FOLIO_MATCH(flags, _flags_2);
 FOLIO_MATCH(compound_head, _head_2);
 #undef FOLIO_MATCH
 
+/**
+ * struct ptdesc -    Memory descriptor for page tables.
+ * @__page_flags:     Same as page flags. Unused for page tables.
+ * @pt_rcu_head:      For freeing page table pages.
+ * @pt_list:          List of used page tables. Used for s390 and x86.
+ * @_pt_pad_1:        Padding that aliases with page's compound head.
+ * @pmd_huge_pte:     Protected by ptdesc->ptl, used for THPs.
+ * @__page_mapping:   Aliases with page->mapping. Unused for page tables.
+ * @pt_mm:            Used for x86 pgds.
+ * @pt_frag_refcount: For fragmented page table tracking. Powerpc and s390 only.
+ * @_pt_pad_2:        Padding to ensure proper alignment.
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
+	unsigned long __page_mapping;
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
+TABLE_MATCH(mapping, __page_mapping);
+TABLE_MATCH(pt_mm, pt_mm);
+TABLE_MATCH(ptl, ptl);
+TABLE_MATCH(rcu_head, pt_rcu_head);
+TABLE_MATCH(page_type, __page_type);
+TABLE_MATCH(_refcount, _refcount);
+#ifdef CONFIG_MEMCG
+TABLE_MATCH(memcg_data, pt_memcg_data);
+#endif
+#undef TABLE_MATCH
+static_assert(sizeof(struct ptdesc) <= sizeof(struct page));
+
 /*
  * Used for sizing the vmemmap region on some architectures
  */
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
