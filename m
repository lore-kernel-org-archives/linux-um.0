Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48ADC77B72
	for <linux-um@archiver.kernel.org>; Mon, 17 Apr 2023 21:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T0YpAd+GWBlou6Q3ChqBvhbTr5O/R6B+LIYpxgyRnk0=; b=EUYgj2Xr/biaot
	jhMXVeNwgxTJYIflyB0yaKyL839L+acPNJvfklxZX/d01b+JoFujpemGzgtHj8bZH3BJQY7Nr/qR6
	C6EFvdeJ/rtpn+8C4Q/PuY5RhUvJ/V0xrkaEycel8yOKZ+aKBlEo/ZIquBdki8SQdm4Pou/E/ahO0
	68tnihM2wY4drnh3u2Bmd86yN7EfU0wUUDaRZ6n1oPOq6omP7cHwdE0pHmh0g+unw7v34QSgvD7Oz
	6c9GpbE6YAwTyC9fdU1tZY5hLdh2OeqaCAZXAAeGSDMba/66zsiupEbyTj76OxdpazeQ8SlCyjsS5
	QbskJghXezY005CBmFwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poWrX-000BN3-0q;
	Mon, 17 Apr 2023 21:58:15 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poWrR-000BJ6-2h;
	Mon, 17 Apr 2023 21:58:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=tniPUuVL526Jec1TVIaHRLAUx7OruO8jRIKlA5wqt8Q=; b=agMFP0jn9o/JtrrM73fqDAb4ba
	qPu3OpVWAKgXDNHSmVH1vdtMSkHM3WqqAOnEvidS6ItjASsFQecR3Y4w6FnROUEa+LDWz6pqmhR5J
	Nr05PO+XwdU1bkeF+AiUl/zdGqO3AfvVT68JTTKFZ90T57pOwzYKt1wjcPs2uNYYgBGWQdN203995
	bARiyKhF1FxMtLZodqZowajdRu3KqcDq3t2WfOaszpTq/sQON+zJjFYNRL2w0vs5ux5hpiU16FqOE
	Jh6zB93E+LzhZsNCIc/eQehDWD1iX8JmOQwbK0a3iilvHZFqfyUlyiuOj31YojsOzDSOUtev+6Mtw
	MAcfsMjA==;
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poVxG-00HST6-2N;
	Mon, 17 Apr 2023 21:00:08 +0000
Received: by mail-oi1-x232.google.com with SMTP id ec6so10951338oib.8;
        Mon, 17 Apr 2023 14:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681765204; x=1684357204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tniPUuVL526Jec1TVIaHRLAUx7OruO8jRIKlA5wqt8Q=;
        b=FUhYQI9DFkI/FtzipQqpmRkt4QWRxpl9DjnaSfjHBMdR3jvmkV2E4q8O7mvM3ZAfiY
         fCjd60ZQDqgW2+p+T4Yn5c0+hLXcj+tNhNfvYwGrewK7V+Pb1rCqwyzaRpyRq7DkzJiC
         M8g3/JmXaDfymr8B0qrgpknFqDraiwpvkc6KPfaJ7LuclaAh8cn2EVmIlD4oXucCNBry
         RA2dM1nPTX0Zj+69ijrWjHozNf9XfRI8lngcBDoEWlzBJhd+oE5T1THDeTpiER7db826
         mQ+txpT6Opaw/AijW6IB4QG0uF45bL/ivD4KL/rX6g81yJDMXNcYFQynyD8+TS24gLvD
         dq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681765204; x=1684357204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tniPUuVL526Jec1TVIaHRLAUx7OruO8jRIKlA5wqt8Q=;
        b=jgjegiGyJjTOdbNGoxpJWKvwLlkF/kQGwetRnYoj5YtjKY6+ehKbY1fYdVKI0weuWj
         favgERT03Z/s5StetCMnG6CuzgoOGF2Wu+2iCU3rg9l5d/uMR0gdFIQrQGHipcKgjncG
         hZ6/o6QEkvH0VjRkLoUOVaG6wDVq+OR5Bt+LvCp7vV75oErCtBat9QtLc4W9dcz5xaja
         H3RDakWOHjd+I7kZwVF2piTvEsc0CODoOwvHyHDVgP77Xx2cxesC78wp5o1nXu2WEqZp
         hm3ev3EhK7a0PGwWrnnnvidJH0hu8nyH1lK+LJk/lBH2vqan/AIQ//RfZz/pgiDX1Y8t
         xQUA==
X-Gm-Message-State: AAQBX9cbLx4PeUda1bNA6Ty3nafBACF+kiq+OMfaHRM/dRwTeyJ2RTrZ
	4l2sCzJSowJkS386GQ7XOWQzEBk7WLUGzw==
X-Google-Smtp-Source: AKy350YG/84D/pba4O2jep64IWrC+mjA+ueyHqImP8NgwjI0qVBUMRNq8Z2uYJzIP+ywt0PW/sWA2w==
X-Received: by 2002:a17:90a:8048:b0:247:78c0:125e with SMTP id e8-20020a17090a804800b0024778c0125emr8083390pjw.15.1681764801496;
        Mon, 17 Apr 2023 13:53:21 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:53:21 -0700 (PDT)
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
Subject: [PATCH 26/33] nios2: Convert __pte_free_tlb() to use ptdescs
Date: Mon, 17 Apr 2023 13:50:41 -0700
Message-Id: <20230417205048.15870-27-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_220006_896703_B9E99DC9 
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

Part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/nios2/include/asm/pgalloc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/nios2/include/asm/pgalloc.h b/arch/nios2/include/asm/pgalloc.h
index ecd1657bb2ce..ed868f4c0ca9 100644
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
+		ptdesc_pte_dtor(page_ptdesc(pte));			\
+		tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 	} while (0)
 
 #endif /* _ASM_NIOS2_PGALLOC_H */
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
