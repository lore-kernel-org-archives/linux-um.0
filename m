Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A8AC04FE2
	for <linux-um@archiver.kernel.org>; Mon,  7 Aug 2023 23:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U3IAFI9aTn6VcoU+9DDfxlNg8a2vsWkeY911SfZb9Bs=; b=4Rga9H6VN6g1cb
	1tHJoqzVshp9jTJZFG2BbRw7aZQC+6W+IQz8EJncp1BL77jED6OXtTUgmi+J387E8zpz9/oigecy4
	76u0iAhkbRHp0F3MJzHrMQW3Y+xLzQXitsCgXdgySartEhdlDfmup7W1QQe6m2Vh6KzMlSlkvLr9R
	2f5yMhxCsCzRnLi4ya24j5FKdOTgwY9BxPn6p73F0XFHqhEoo6L1kr8T2wdyOptrTkq6I3sXknl+9
	FdWGHlTKksQrR92SkS5/rg4cwLkSrl6jX6HzBnYptYUa7nqQCkDfkDZdK71tDX52jC9SESyfyrdUC
	/aPObOZrj6cBN9zbfV6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9K9-0016ly-03;
	Mon, 07 Aug 2023 23:07:41 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9IS-0014yY-1e;
	Mon, 07 Aug 2023 23:05:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=djDHSA50q7R+UyBiZfR1OlHjGJmDs73q9nwlLjbVi90=; b=ptwPCIizGah9u5NJLjAhzGlGB/
	joOVGsrFl+1UJiVcXrIp1zyJsDT5wS/NU7OjEU7ovNcpuNdIuXPAYftIUjid7bXlbqbRq877wDbNe
	F3louGdNy0cXofkFpmQb2tdi5kDan3xLOQY1jd+FlcegE3/rwF+X4qu2YX0u7hx1VC2t+X8loqVIJ
	tN+1dMJK2lfi720J+6M0sDf/+QItFU41YFEU1iuASV7JXkPnLyRaVl5W/XgfLq3BlXet2Xkv/ygGA
	k8kDiUf4eN1ExdWgCTJtEHJVGGkVYfn3WKLoWd9mSG6lbYa1Z0DgvkihSK9OQwPcqymvhzfajJ5Pk
	pk8mbJZQ==;
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9IP-004DOw-0d;
	Mon, 07 Aug 2023 23:05:55 +0000
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-585fd99ed8bso87274827b3.1;
        Mon, 07 Aug 2023 16:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691449548; x=1692054348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djDHSA50q7R+UyBiZfR1OlHjGJmDs73q9nwlLjbVi90=;
        b=A70KAiN4sx+tlFlhyX9BkgJstVMLVR3VqHlhU0rx7I/q1gK7xadYJiksKbuvoZ1TCU
         vtYAPdjYMcohI4FUcCDaUSvo3KExkCCd8i4ZAJlLsd7GGEFa35HZ6ueu66zMG9Pjessv
         IfHL3oLMSZbSj2Xq1C5vYTgwWzjwrMyTCzKH7w07IcqqBjGPHvlKkPkr5yx2TrtnD3V5
         vilM5UK235QUkkDj7spFvnAsyD47IB2DFcBmstKvpCiE4ENrGAtmtfggM5j3FhO6Urma
         yNzpPXlABiRMwP18oUglZegWP3XimvmMFaP4ALUxkyZmGiszwVYNBF+f3K+ck5Grr2Wp
         NJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449548; x=1692054348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djDHSA50q7R+UyBiZfR1OlHjGJmDs73q9nwlLjbVi90=;
        b=FG7vtayl8hlec6bJoxOoTifEtP3r3UvQS0DW4JuhLfyO2Tgbdz0Or5SJGLbX94xeCp
         kgO0FxDDNsYGqv8y9o9HaRkoYShLtrtmRJ6G4DpHlnl+ijjBVoz+Gi59uWGTORkSsEdB
         Vdi6H5iNHxxrTk049+5Cxgp0gkBFkoTOuYcbjUt3VX5m99FJLzvesas9MvDMxtDwXJzh
         CHSsQj5fu8ufFSTLgBHQJ38mGkyxtspdKf/axk6IWrPCOm1gOhTWXyUSASqENFRP0Xq7
         ohNUcdEBGywZI+y+6c8bx7snxEGliqvQ64ZwVe69SP58lj0Y1CknZbxGu49FS1CdT9Rf
         KzUg==
X-Gm-Message-State: AOJu0Yx1So5wHdeO7wKYYePhaelHGZDIfFA9lNygcerh95ricjTNCU3n
	Sib/ctxRYuGjJEzKRRlxmwQ=
X-Google-Smtp-Source: AGHT+IGTzP73V6D5bA3Obfkv2DqAOxUsUVIIigLLB5NQKEC9VyMSvyrKel3HyW7I0Mz7ccDZUXFbIA==
X-Received: by 2002:a25:d8c4:0:b0:d05:2616:3363 with SMTP id p187-20020a25d8c4000000b00d0526163363mr9753736ybg.26.1691449548551;
        Mon, 07 Aug 2023 16:05:48 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id d190-20020a25cdc7000000b00d3596aca5bcsm2545203ybf.34.2023.08.07.16.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 16:05:48 -0700 (PDT)
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
Subject: [PATCH mm-unstable v9 15/31] mm: remove page table members from struct page
Date: Mon,  7 Aug 2023 16:04:57 -0700
Message-Id: <20230807230513.102486-16-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807230513.102486-1-vishal.moola@gmail.com>
References: <20230807230513.102486-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_000553_462164_40846012 
X-CRM114-Status: GOOD (  10.19  )
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

The page table members are now split out into their own ptdesc struct.
Remove them from struct page.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/mm_types.h | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index ea34b22b4cbf..f5ba5b0bc836 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -141,24 +141,6 @@ struct page {
 		struct {	/* Tail pages of compound page */
 			unsigned long compound_head;	/* Bit zero is set */
 		};
-		struct {	/* Page table pages */
-			unsigned long _pt_pad_1;	/* compound_head */
-			pgtable_t pmd_huge_pte; /* protected by page->ptl */
-			/*
-			 * A PTE page table page might be freed by use of
-			 * rcu_head: which overlays those two fields above.
-			 */
-			unsigned long _pt_pad_2;	/* mapping */
-			union {
-				struct mm_struct *pt_mm; /* x86 pgds only */
-				atomic_t pt_frag_refcount; /* powerpc */
-			};
-#if ALLOC_SPLIT_PTLOCKS
-			spinlock_t *ptl;
-#else
-			spinlock_t ptl;
-#endif
-		};
 		struct {	/* ZONE_DEVICE pages */
 			/** @pgmap: Points to the hosting device page map. */
 			struct dev_pagemap *pgmap;
@@ -454,10 +436,7 @@ struct ptdesc {
 TABLE_MATCH(flags, __page_flags);
 TABLE_MATCH(compound_head, pt_list);
 TABLE_MATCH(compound_head, _pt_pad_1);
-TABLE_MATCH(pmd_huge_pte, pmd_huge_pte);
 TABLE_MATCH(mapping, __page_mapping);
-TABLE_MATCH(pt_mm, pt_mm);
-TABLE_MATCH(ptl, ptl);
 TABLE_MATCH(rcu_head, pt_rcu_head);
 TABLE_MATCH(page_type, __page_type);
 TABLE_MATCH(_refcount, _refcount);
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
