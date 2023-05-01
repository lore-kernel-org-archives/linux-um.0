Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66BAC7EE21
	for <linux-um@archiver.kernel.org>; Mon,  1 May 2023 19:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T0YpAd+GWBlou6Q3ChqBvhbTr5O/R6B+LIYpxgyRnk0=; b=YQpgbBDJBePJDW
	cMoMNSKIXvqxE1Vkgrkn5hfK801vEahg85Unumf77VxV8/BTsOxOcj4xA146qGvZ9tkFbT/M7Ip7I
	/pnyEBjncb8b8KF3hnaj0Pdk0+ab9g+VZyf1w+pgd3CaG2LTJIDx9uJ7JPBnMkzakYi8WBLwDMNqD
	dr3SIrl8lnW/g1z3li+O3wWP8Sz5lf1YSotvCDfTZz3pwzSyF4jgbfMulAMJ4MbCuwnDxDTQVY8nE
	eXZNyP1D74/mVHS1JrpRKVJwJzAlIFigVzUilm1z0p0vG/GKxu2+pyh2sWV4X99QrKmyfEgrXmpLf
	GJzUxgaAxQfEI+i6a6/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZD6-00GhfM-0e;
	Mon, 01 May 2023 19:29:20 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZD0-00GhTH-0F;
	Mon, 01 May 2023 19:29:16 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1aaf91ae451so11836325ad.1;
        Mon, 01 May 2023 12:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969354; x=1685561354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tniPUuVL526Jec1TVIaHRLAUx7OruO8jRIKlA5wqt8Q=;
        b=sCYdFD4O8Had2jReQPDULWIb6jXMWTBVOP1xIsSQDJFrjK4Unzq4xPir2vv9xD60ba
         KhnmERHxh4wjne9PTfzHFe7mUKtGQVGSRxsSTI7oGHQc7fKexIRwy4BhAuhQWGLGw+L4
         jhaBOvefDEjvTltxe1zcg9AOJCenWnwtbQvW8h9UKrmrEmLrYzROLydP0XMIyNyplCDF
         ksvZ9Q2L1rfMSznCSwk+WHikKvzxa7zVAjndA+MUieyvTGKh0Hnkx2VWar6ZLI/SEpj3
         zJ2Emm1btVtqn0B7TpGayRWt9h4mLeUHtWruxn5Hxr1lyas/Ibpq/YOzX0vO1bUnoNNT
         ju/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969354; x=1685561354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tniPUuVL526Jec1TVIaHRLAUx7OruO8jRIKlA5wqt8Q=;
        b=WUw5GmzD+vsvJudzSm+W6UrY5CUP5tISYl9SldgiU5LgrujCjelqXFnh7nZ8iCPcTd
         QNAQ6jag/H1BihZ7CPg89FyTjSFpPcHpPCv9cLwltV4uu/PdOwOruVMvZ+9QSQcWcuGA
         mTlO3rud2WWjrFk1D7a5vWVVypOZwz7/IGXiu0Ac1+wIuaqmGO2y/gzm9Vucpbk1Ocg7
         ahe0UuUVYq4NL3UV1HJD+A8Pj99x46aNJdMKVR1TL0C59VxbUr8w7RjxdbmCOx/qWPYW
         f78kcEaPRQIgvmtL1dxt+3hOsSyieU1dNUA/DrvnrxrKD2T9ubMIZge1ZTV1JRuqBSi4
         PKAQ==
X-Gm-Message-State: AC+VfDwNmb8WVhnlaTX0GF+cl2agsZsY9ZHcwCsr5h8GyD29RoSlGZrx
	RljrE9BIl4RdOG94Ft3qfs4=
X-Google-Smtp-Source: ACHHUZ6fkDxKllaaORZgzXEjR5COvh0uqYIPMfHZHm801Tjdn3OT0QOppKb8hXtDeBwjumbd6cc2Pw==
X-Received: by 2002:a17:902:c411:b0:19c:d309:4612 with SMTP id k17-20020a170902c41100b0019cd3094612mr20785827plk.6.1682969353666;
        Mon, 01 May 2023 12:29:13 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:29:13 -0700 (PDT)
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
Subject: [PATCH v2 27/34] nios2: Convert __pte_free_tlb() to use ptdescs
Date: Mon,  1 May 2023 12:28:22 -0700
Message-Id: <20230501192829.17086-28-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501192829.17086-1-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_122914_135565_88F4FEA8 
X-CRM114-Status: GOOD (  10.75  )
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
