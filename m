Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C97EC16B13
	for <linux-um@archiver.kernel.org>; Mon,  7 Aug 2023 23:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IVucbgOaYclTFw/RStlKACtlpI/ePQbvN6YBu3gVF4A=; b=cXwcmC4aByQRTp
	Dgj8F7oHuPTxEi7uGbPtqTU8wDCKL+TLHtTF0oc1wduCbY3un2BIq1Zq74p/ZvnY5SGPYTfqClq7B
	001PPDKFO7uO4OswYMQJVe3pTSgTeEg+LzG89B2jl1CBPpep72Etrz8lOeLwlXGG0zSBMa7px3ZNg
	Vm4dVnzO7ZQ63YOLKjAlmGov+qtjsud0K589u9V/+zRWm60tKyflobdQZrNQD3Gm1XmjpWbF+FGY2
	wSAoGR0Gu9x9Fdl+njE0bNwL2NUICCMkZbV+7hfaBwgU79gDeeH0aUe8jLDko5uJqCXkGaR/GyYlR
	8bQoOieuPwLgVXkbMOuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9Iy-0015db-3C;
	Mon, 07 Aug 2023 23:06:28 +0000
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9I9-0014c4-0r;
	Mon, 07 Aug 2023 23:05:39 +0000
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-c5ffb6cda23so5463389276.0;
        Mon, 07 Aug 2023 16:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691449536; x=1692054336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dL6AQetgHURU9peF5jMm+1QPkGPdtGd2X/zb9xq5Tzw=;
        b=ipvaU8x/4/BvbPbL1JSP5UKyrvOXFJin5b02qnpk0+g2WqZ4eJ+PO+ktIgA+6wNoSm
         aaVqpEKee+fuDlQKCW2FfgF7SgMBsBqJt3e1nMH+AXWpM2n5M5vJ6ySCVS0SQ6gxdoiI
         D+Vz3KZ0hmlesWiSA/IngK6t1yMsQcmq6H5TLlpCkzZtF+sAfosr9KpkynHtpBKwq7VS
         GLoFH093mbAem14YxFU+jWVsiLanVvmYVX25waYX2eZafZZIUXESTosUd2Oq+mhwT6KE
         DFWO6vdcB84fh2CYUtre/BRV5qGnoLxfl2hREphZC8Q8m4iPBusEVSAtzxRpIAKFC+MO
         xrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449536; x=1692054336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dL6AQetgHURU9peF5jMm+1QPkGPdtGd2X/zb9xq5Tzw=;
        b=Puil7vWSgQbktclILPwMZuJRjaycQmTYs8gXXcbhSRjxRRUmu5T71phvTnMddIQIF7
         OWgQ7mEX+cRDNQyOTh9P/yyhup4W1a6gXATZtrDjWVT13oXvFmH7NMA8t9Eckar5YWDq
         zC/TqikAZsGLNN3PHBtE/18HHjdKjSeSg3MfX+8ylad+onUbTgUM0ufxwlDhi6kVGHYx
         6cysG4A7wxZ06XNzbB083Y1NCMVmx5GTmknEsr/pTF63b08W+1J47jisKCUAwJmIYkWk
         NhMddtRPd6CKT10PNNE3g7IQPxEVzmlVqPaGJtd35dYMqgRC/KTJD4e58jlcc+GKhDtB
         lsWQ==
X-Gm-Message-State: AOJu0Yz2j6CadTkFdKQxrG9SEByz0GAmDIDXOw7/jABEC2hiw8FX7m3c
	DQzD18wqQi5zE2My6dL46Tg=
X-Google-Smtp-Source: AGHT+IEvxj9+7jMT4q6zEzLr5Igqcb/a7jma6HML30e7U0QAJ8Bd3AhAgHjN0UpvuwRaK7JUtc9G0w==
X-Received: by 2002:a25:738b:0:b0:d09:7f94:6ea3 with SMTP id o133-20020a25738b000000b00d097f946ea3mr11456718ybc.65.1691449536455;
        Mon, 07 Aug 2023 16:05:36 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id d190-20020a25cdc7000000b00d3596aca5bcsm2545203ybf.34.2023.08.07.16.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 16:05:36 -0700 (PDT)
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
Subject: [PATCH mm-unstable v9 09/31] mm: Convert pmd_ptlock_free() to use ptdescs
Date: Mon,  7 Aug 2023 16:04:51 -0700
Message-Id: <20230807230513.102486-10-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807230513.102486-1-vishal.moola@gmail.com>
References: <20230807230513.102486-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_160537_315589_8D942678 
X-CRM114-Status: UNSURE (   9.47  )
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

This removes some direct accesses to struct page, working towards
splitting out struct ptdesc from struct page.

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 13947b17f25e..aa6f77c71453 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3001,12 +3001,12 @@ static inline bool pmd_ptlock_init(struct ptdesc *ptdesc)
 	return ptlock_init(ptdesc);
 }
 
-static inline void pmd_ptlock_free(struct page *page)
+static inline void pmd_ptlock_free(struct ptdesc *ptdesc)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	VM_BUG_ON_PAGE(page->pmd_huge_pte, page);
+	VM_BUG_ON_PAGE(ptdesc->pmd_huge_pte, ptdesc_page(ptdesc));
 #endif
-	ptlock_free(page);
+	ptlock_free(ptdesc_page(ptdesc));
 }
 
 #define pmd_huge_pte(mm, pmd) (pmd_ptdesc(pmd)->pmd_huge_pte)
@@ -3019,7 +3019,7 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 }
 
 static inline bool pmd_ptlock_init(struct ptdesc *ptdesc) { return true; }
-static inline void pmd_ptlock_free(struct page *page) {}
+static inline void pmd_ptlock_free(struct ptdesc *ptdesc) {}
 
 #define pmd_huge_pte(mm, pmd) ((mm)->pmd_huge_pte)
 
@@ -3043,7 +3043,7 @@ static inline bool pgtable_pmd_page_ctor(struct page *page)
 
 static inline void pgtable_pmd_page_dtor(struct page *page)
 {
-	pmd_ptlock_free(page);
+	pmd_ptlock_free(page_ptdesc(page));
 	__ClearPageTable(page);
 	dec_lruvec_page_state(page, NR_PAGETABLE);
 }
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
