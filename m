Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78FCC77B72
	for <linux-um@archiver.kernel.org>; Mon, 17 Apr 2023 21:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fi02z95z5nCoIXvhwiu0Sj5grGEpybJY65pcJRsREFI=; b=uckvfY6blUq9tl
	vvAYSd4NNdi3dnt/eTmr4hz5l8XumxfEu68jrqJ0hzrLNe2SUB3PLzFULv5c3S8L04aPbK432cxhN
	k1Uxz8WwuiR3rha3EfCvQcFkSYa4+R7QcnIK5SmFm+PeDB6L4ne+2e7pd2M5qDLPXNA8lgx5+Jufq
	+QDV3ELaf7poqFsjTf/bEDXTPfuUyrydkPYVVd/d9zj5JsXYdLce8ZMDX7/fiD7nK/Mwmue6W4/IQ
	Avfh0n4/hlkRqF7uCoFEIXvKsc0hWJLCFfIJXoqRtJluweeGRKEV8Qsc/A1YbU8bL6Uns2E21VGfi
	wSzOjzGEpGo5PXUPMY/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poWnq-0009xI-1I;
	Mon, 17 Apr 2023 21:54:26 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poWnn-0009vJ-1Q;
	Mon, 17 Apr 2023 21:54:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ds3IS9TWlY4iXOF1Vygr3Q/N2fJxO0/Dzlxnv3cq6/0=; b=Eqm6lHxRDJypZBwXzPeBpkZkzT
	Zml7bs5+hlIlP2bfM1AjRqMClql7MX5z+uCaoxS6EkFci+SD/Pcyzu5wHAK6TQ1dPjkWFTcFgCQDC
	b17RjB57ZgMqRjWhwN1GxBdYT8G/VjXwLOCVjHUxev5+RxF9hRwa3u32Yoc/aYndN33aTqlTBIv3S
	SjFyKk4/qy5Ptt0oAyyiQt0UN+Cpa8DPmObxJgoCWws5LJg8ue7B0ADe2t7pBuyG2JSHMhnqn0th2
	evXpChCZ3jfAjiK/bxUvtKfK4Pe3sY2WUPVOsC768FjuYxRMdOvFgCTcUPvFPuKlf76HDeM24sZEL
	sDP8qwAQ==;
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poVqL-00HS3j-0M;
	Mon, 17 Apr 2023 20:54:56 +0000
Received: by mail-pl1-x62b.google.com with SMTP id lh8so14359530plb.1;
        Mon, 17 Apr 2023 13:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764769; x=1684356769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ds3IS9TWlY4iXOF1Vygr3Q/N2fJxO0/Dzlxnv3cq6/0=;
        b=hr7pEt7A7XcPfK4WHrNDJyXTyW/f522/QxHB9K2NM6BmG8KnIlcSk7Prak06XFsubX
         Sjsu1MPagS5Ajy0wM6nwYZFly4hHrr9DYIrVTEdELHRdfsGo64oEk7qD+41S/NMObi8y
         l8A2tz8IWZ1X+Du4Mg5V1agW+uGCUPtQdgx1HioQtiEf01hZXw902OFYpkixEmc4936W
         rbvY3hq0N/ZSHnXC+KGydT6+ZrTUjCaNrxKIoD5OlWamJ5QPi1l2Tt7uz8xTA1Fp0QB2
         97/hz5zZCcVfwzgfNZP+zBkRfPzWu3gB3ojY6/LKA9XIpl4tn1OEejbLEhRl9E9QH4p3
         YC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764769; x=1684356769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ds3IS9TWlY4iXOF1Vygr3Q/N2fJxO0/Dzlxnv3cq6/0=;
        b=OsOpHEx+Q/fBThnmUBLXbMLV1seib0GqSwtDKGqyQFSUQoaMLFoCFm8hixDPGa+MEi
         I299aLy6wBeliZxZJixlhHUdNdM6C3vdTvc0GbHjNVTaKu1bcqya53LYGRf3dLXCFd5Z
         +ckGaHDNNIWEvPoB1bo6bqIZoHYVUsc3xYWqmdVrMn6DXzj3Aiz0oHK1zCcvzDji/uAv
         DNUQs30L1PoL4Cg51l2BsD0cg3m0E6M89HY1R212a8hbKIH4mPAmLm65DV590eQuKpGu
         K2Bu++VP0Mn5gdQX70k5YthN8roCSE5dlcPwb0Uf+ixj36PDdPYxDP7T42Aclr16LsN6
         T8oA==
X-Gm-Message-State: AAQBX9dGPd8Oze/F/C2NNGaXGuTJmlVBvZTcAGGAlX1h06XguVM/5LI1
	B5jNu45Vp956wzMZiPzblKw=
X-Google-Smtp-Source: AKy350bKOtS2RU5+UPauyBEeUGcMLqfRctd5dndnPm3bZbQM5N2yHnkL/dVsnC5V83h9pYCSEFQOHw==
X-Received: by 2002:a05:6a20:6595:b0:eb:ad6a:ccf4 with SMTP id p21-20020a056a20659500b000ebad6accf4mr15296929pzh.18.1681764769281;
        Mon, 17 Apr 2023 13:52:49 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:52:49 -0700 (PDT)
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
Subject: [PATCH 03/33] pgtable: Create struct ptdesc
Date: Mon, 17 Apr 2023 13:50:18 -0700
Message-Id: <20230417205048.15870-4-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_215303_015810_8661ECDE 
X-CRM114-Status: UNSURE (   9.58  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Currently, page table information is stored within struct page. As part
of simplifying struct page, create struct ptdesc for page table
information.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/pgtable.h | 50 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 023918666dd4..7cc6ea057ee9 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -47,6 +47,56 @@
 #define pmd_pgtable(pmd) pmd_page(pmd)
 #endif
 
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
+TABLE_MATCH(mapping, _pt_s390_gaddr);
+TABLE_MATCH(pmd_huge_pte, pmd_huge_pte);
+TABLE_MATCH(pt_mm, pt_mm);
+TABLE_MATCH(ptl, ptl);
+#undef TABLE_MATCH
+static_assert(sizeof(struct ptdesc) <= sizeof(struct page));
+
 /*
  * A page table page can be thought of an array like this: pXd_t[PTRS_PER_PxD]
  *
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
