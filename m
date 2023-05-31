Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2603AC7EE29
	for <linux-um@archiver.kernel.org>; Wed, 31 May 2023 21:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YwWOb6ZcnQN2hdUSNpZx+x7NoUdVPmOk318ZtSNJj6Q=; b=zztLK9KstuW2BV
	KxwujPioLPPvEvDWxAlrPfxc90MaHbD8oZKTk58O2deUOh9ngyPC7a0abukaA/nldiB+XL4xDr5Jb
	jIz/zi6x9mjkjGI4uecv2/fMrJVpcM9b+qEdB4TKqpanJEU6VIIK5/Erge6YeOB9ovIh55DkYt1O9
	LJjMqL5fk1clnGMEp4iuMoVl7qCCoCBERXj7cC1ASxnPRitl7SSZlOd5vdXWUT7t1GA28tN927G70
	084AxHjJePBOg+AlR6Zei3amZ3nunvOCymm9BUKCQM9HhX00+Z+Ng7MSxLhS/pRBVyWmu312tvQuw
	D/wQ+pkm3GNnTIUYWuKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4TmE-001Eek-24;
	Wed, 31 May 2023 21:54:42 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4Tm9-001EaC-2H;
	Wed, 31 May 2023 21:54:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=QSGr1AIBRcRb+Ur7L3hOWyc2qTqn+mhf5/YLNQmZcmA=; b=FfFNIjRI/lpD/m/N6+LmFS1jrz
	aUcn6Bt5uSWKfkH4PXh8OJnlsxIXza7ZA2nxjUzWwFrJKoVDjsKH2NNNVMIfkvedF+3/0bJuLOt0I
	PxYCZwcVoXJmUpCAAzxQDzy9lKxUVDbOXJTnXn1fG3sT7rujEyZoc+FQ4rajxaahGKeFpX/t3HkiR
	zdxDA2WtRpN7XW/cmLOfkpWVERT0xtDyPyld3NLaFI4XyBjCB0re6GlHh15i1IOp5BQ1rh6k8p/+s
	5s5XLYGFGpX1JjOed/IcqnnRDsefD5I9tleNwhUwW2hoKVoluZxEFOdshe84TokYJaFL3Z10pILOS
	sU4p+aDg==;
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
	by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1q4TQJ-007fiw-9i; Wed, 31 May 2023 21:32:05 +0000
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-565bd368e19so800567b3.1;
        Wed, 31 May 2023 14:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568723; x=1688160723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSGr1AIBRcRb+Ur7L3hOWyc2qTqn+mhf5/YLNQmZcmA=;
        b=P+sFLMkiyDDyXlnEG12Vca4wXTlsNP1tjr5mpQ3xYowZkV29Gi4DHzR6qoKyncOySw
         jnRT0Uzpd7rJ5SnFzozOgbTxqzpBvgdV5deGMByJA1EX8U9bDlcdVF5nVlhFFf1pyZ0O
         KrWMXXKGFgo38kAOB8ncfn/SPFyRIIMw4Td8wl18EIsvccYdq2AsnvZ0dkbvnVIaV8oQ
         lw4pGC9Zhdztp77vkJB22l9Fos3IjWhzJKFNlsAyyHAnjGjJYghL1MXToen9jCOsOslF
         dBNcDAuc1Cy34XA+B9s+UNYDNSEGNOwzJVHJrEoMCND5EfDLqD8QbuDF0jEbofHqgPPQ
         P6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568723; x=1688160723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSGr1AIBRcRb+Ur7L3hOWyc2qTqn+mhf5/YLNQmZcmA=;
        b=lj0b5GHsz+zFxGttkshw9IUYX3D85n8m9nYSmRcskCdUfcJBNrKHSD2Yu3q6I4WBBY
         EcilMgE8NvUHknDpwfzQ2kIRsILe7oKpA9HvAbBbfXe/uFilJc0nz4url0NQoK7zOJ73
         ysLMPcw2I+uKAfdK+W01Oa8fGjcDBDNJ8zqt75i6r81EgBmrI3Wb8pL3AqM9DIPY4NOG
         AvBiAczsdn8SHPCKmVHRwH7PXd3+Mc5ngezmlUgk7ogTDY+0mvCpGTR+Ww6YgzX/yRTE
         NFL78yZA95Jbe3nl/skd4FF9+JI/Kz5VsJhkfFpWEY1xC3MN/yITKfA6gUpQ13aJPcZ5
         OtoQ==
X-Gm-Message-State: AC+VfDwRU/adshp++LhS7HJ4UgjmULJkLm59KInIYDwOeGxVB9UqZNjJ
	CHJ6kCApV88fBSJZTkFcab3AGxC2me1bVw==
X-Google-Smtp-Source: ACHHUZ6lpvw1UsG9eqv+xSZaIjITC9PhoF1JcriZ34z9zriWEJuaLEkcr/e1lknRm4p3R1WVQNwsxA==
X-Received: by 2002:a81:4ed2:0:b0:561:7ec:cf90 with SMTP id c201-20020a814ed2000000b0056107eccf90mr7025257ywb.42.1685568722698;
        Wed, 31 May 2023 14:32:02 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:32:02 -0700 (PDT)
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
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH v3 27/34] nios2: Convert __pte_free_tlb() to use ptdescs
Date: Wed, 31 May 2023 14:30:25 -0700
Message-Id: <20230531213032.25338-28-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_223203_354618_4664D9DB 
X-CRM114-Status: UNSURE (   9.81  )
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

Part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/nios2/include/asm/pgalloc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/nios2/include/asm/pgalloc.h b/arch/nios2/include/asm/pgalloc.h
index ecd1657bb2ce..ce6bb8e74271 100644
--- a/arch/nios2/include/asm/pgalloc.h
+++ b/arch/nios2/include/asm/pgalloc.h
@@ -28,10 +28,10 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 
-#define __pte_free_tlb(tlb, pte, addr)				\
-	do {							\
-		pgtable_pte_page_dtor(pte);			\
-		tlb_remove_page((tlb), (pte));			\
+#define __pte_free_tlb(tlb, pte, addr)					\
+	do {								\
+		pagetable_pte_dtor(page_ptdesc(pte));			\
+		tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 	} while (0)
 
 #endif /* _ASM_NIOS2_PGALLOC_H */
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
