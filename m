Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC039C77B73
	for <linux-um@archiver.kernel.org>; Mon,  1 May 2023 20:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ba6HlIvULSbA/krbMwXIzjKeu835tuc5GGdJmJu/+/0=; b=YnruKVOX3vXgy8
	o5W6gL4taoWVk8EezI+Dw2ikPdS6ZkU4Aza73Vj/z5rvTLc9AqgsfTMI/y5Yg/3HWS4Vesq7YHR55
	Go3VCquxpfg1aSCiwaTBKhUFH88zhyOEsi3nUe+FSBS3pCR9ARYhYf5aQTOmu34/1iPccDrP8ytbD
	odzUa9Nw4B0FaEQEkcySIChy4S1yeOSp9rij/4i+8+axbTdYhguIjosBGERq1W2/h+h6PcReiQkYV
	tObPGA0AnvOnmGMVSj/nsYJKfH/0itGyKxbCZjn3XuRuG7CEluV8p+XuX/FTgCMUJt4gkdO2WEt2R
	cZyhmYYYL2b3IPsldhQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptaKB-00GuD1-1U;
	Mon, 01 May 2023 20:40:43 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptaK6-00Gu62-1G;
	Mon, 01 May 2023 20:40:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=B0Od9Inc5y6h3dSbsHmdGR20xSLs7HxIKZ/fFcl7OHg=; b=Z/EqDqOL6QBL9G5oboeFvVGM50
	Ncp3dQHt9Bqhw/cmd9GA3dCaCUo3PTAiYYENMw+p2L0ivTClZeu2Qv2pmrEjcTvVA+0jZ1gkxsHDI
	Sz0+BYMwd8SIbBeg1rQaFrBqPkRBMas7+KZ+ILmtZxNi5ZpS4oK6U5sDm28hxrAQeR1Q6SkyF46Xl
	FnRU1o8zuo3ofwoVYe6G1FbY+BBfimMGtr8U8AR8287QAQkvwpSsumraWQNTYAlEUD6aGEpG4btSu
	VWc238yiEfe4HLnixOMyCmbPdB99s2g7T1MIWHttVkYIZjrEMq2N0f79g80//GPoKQbOWFicOzZek
	lthZ+6hg==;
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZCV-00Eyyu-2u;
	Mon, 01 May 2023 19:28:46 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63f273b219eso2047907b3a.1;
        Mon, 01 May 2023 12:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969320; x=1685561320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0Od9Inc5y6h3dSbsHmdGR20xSLs7HxIKZ/fFcl7OHg=;
        b=BSfSX498+nRsOwkOZCv/c3TfiIzHvFrBHqOPXzZnUzdOTpraA1SFYJQ7S9OlNSy+oo
         SgKJwDZ3qC6C//XEAcYljRcEjgHnyeaNoyhEAyOx7Ys6/3k09Ik8CgCQWIiXukHyuWI8
         JqooqMgdLQ1gpcR/L/mcYK+KZEjEg+InGInQqZs8g+xQwi3fiMtnPj+o8uf54dHCG0nD
         x8PpX8tpE3nfYMsr6vBPGSrBk7IqcdW9rAQJxVfKMF33+mjDorfNig4J/P1XioZbWwxD
         uXByeI5tsaD8qrYP2W7mncKrp6aQydR1tjw1T6sz0jLjo8cvDXE3/58iahOtRXOU+sGT
         jXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969320; x=1685561320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0Od9Inc5y6h3dSbsHmdGR20xSLs7HxIKZ/fFcl7OHg=;
        b=ZkDYCetij0LBFAy7VQLShTxaJ56u6GXoapb/LjlRjktqgWPOoC1z+rCVXGbTpWBecy
         HEPb6CF8y95qpj+S3lDkzGOdWVr57wlUq+9f0E2CUsikebXI4CBZTNM31mVbOof/MOdR
         zHJHd6QLftdoLG3D+PMd61I3EFRH/wG1fLWM2uVnkXN54r65Lziojb1VAuHOoO+f1Bh8
         I37Wkmogl9l76eUb8T9Ey84jj2CmBFPnUs9Hka/3NMwT7LBl9Qxa1cEY7XMbShcoyj50
         igSjFDQHchlKZMXAIj6KGMjon5oCef8Ftt++8rXzB0WVOWSUaJY96WpDua2sNEAg56Cr
         55/A==
X-Gm-Message-State: AC+VfDxzTFBLLWeTEAfy+r7Xec5nIx0CnuP5JShkcecKmi6xJIFUG/fT
	6L6Ox9vmk5CxXiOA5tVWlPfdIu/6JCnGKCXm
X-Google-Smtp-Source: ACHHUZ5c/2Ko6MMnlJILdIHFSiqsi7woH2pp9LXJUwyBETBH//ZWHg6e+tUlm1aX3nzTckKQE2QL/Q==
X-Received: by 2002:a17:902:d2cf:b0:1aa:ffe1:de13 with SMTP id n15-20020a170902d2cf00b001aaffe1de13mr2810716plc.5.1682969320162;
        Mon, 01 May 2023 12:28:40 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:28:39 -0700 (PDT)
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
Subject: [PATCH v2 04/34] pgtable: Create struct ptdesc
Date: Mon,  1 May 2023 12:27:59 -0700
Message-Id: <20230501192829.17086-5-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501192829.17086-1-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_202844_293587_7C7855C8 
X-CRM114-Status: GOOD (  11.56  )
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
index 023918666dd4..5e0f51308724 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -989,6 +989,58 @@ static inline void ptep_modify_prot_commit(struct vm_area_struct *vma,
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
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
