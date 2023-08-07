Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF4AC2FC14
	for <linux-um@archiver.kernel.org>; Mon,  7 Aug 2023 23:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yGa4J7MsrX/sJ3I6fk2s3hgtzeCx3I+P/nhr8uLfLNw=; b=3cKLaVAKdov5pg
	DybwiqzdGq+T/uSUnX+rwBlrITvOg3012sQHMUek4v1Yom3Uo/xdlh4bYQrOAXStnitRrLAFL2T7v
	7eA9wrQL41NGJ0mkgg1yMg6E4ahL4Vfi46Us3M1sbyI3NcvUxy45xp899ls6W/hhIXtCXoDCcYbfQ
	mSyQxeEkdl5atNvzBlCAT1VVjoUhoBLJDrvLoxqGbgPWOJx1QeBtbBKFgs81UAjzs+8yiEzdTxWxU
	FUZ/Ztd5Sqk6ShjttPFice6X7TK0AT1YVrVHmxA3RBzZ3sGw4qbbRBB2w1CORKWwDxtEMhzim8yDo
	yhq455Nd03srsVK2TVVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9LQ-0018ON-23;
	Mon, 07 Aug 2023 23:09:00 +0000
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9Ir-0015Ub-2m;
	Mon, 07 Aug 2023 23:06:25 +0000
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d44c2ca78ceso4742225276.0;
        Mon, 07 Aug 2023 16:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691449580; x=1692054380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9QlLO1dPeyZnWI5hHw1TuJlTK1nfQVgIvIYX0JocUU=;
        b=ZmZBlK2BE47dPXTqc8IQ1uTKCUobrHijjQnotS76WbJUUgCGVOPFVEmsLAOFQve7Mq
         8k04A5/AuFSS607BBJG/Nd5XpAmnH5zPypJPEnlo7r978iqN52fpsMDyDxOev3Z41hLb
         CpvzpxqdWGHuM0xgZvYoYbOi2GTwb0pfPUe0oyJziB36Q6lozhNOIAq2JTvWjnhFdQ2U
         4BFxzsH5/HG/XXl5/YPVavhDi3L4gvkLB1NxxGw9654yYac9diJlEe3+5Z8y0K4G8C7u
         mJwXJ96QObfNW/oMJd7PgnIP4//NNbVjGeiAj0SJF/1wFKYAbBETcCfRmwi4qkbVDTFa
         RY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449580; x=1692054380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9QlLO1dPeyZnWI5hHw1TuJlTK1nfQVgIvIYX0JocUU=;
        b=Dwt3x3mr9cvFPz/Dr1pp90QRO5HhmQyQaRgleHsM+IuWAbEy60QMh9Ywsas9WNgLaD
         OxoUkhqVvZya4og+skp67m4jY2XgJnnQVhqdpGN0rpmIjg3ZeA5VQDl7tRJmxmMg/6S0
         XBtO01P7dHDkdAzcnPjuQMYQW6vAaTHZCa3rUyvohT2Pvx+s3kwymJNj9WKYWdA7gBgF
         uoyeh9FFjv9is7BRNkDAfCHAxxWp7GZhgZ12fJLaMUY6weusDBVIGpHi6SoVdbkb5h9Z
         Q5jLqqHCGSq9VLHtIiiWaCba7xue0WZQLiGsv515y1L1sSz1VRsLdgN0Vkx+OIupF83k
         Ch9g==
X-Gm-Message-State: AOJu0YwTdrSh0djFqIhEy66TTE0hnd2Iy8G+IU9TOU+q4vFQ+oA7vslE
	wCGATLRhMCHRB/lkUiia5fM=
X-Google-Smtp-Source: AGHT+IFhMlpHJ+7onf6BYxf2ZEVLLZTaCynnVlAbd/4Vka+RTYiQ5OXzXPwOq0O9emhI9trC6wG3Sw==
X-Received: by 2002:a5b:f8c:0:b0:d0b:7e30:6d17 with SMTP id q12-20020a5b0f8c000000b00d0b7e306d17mr8498276ybh.14.1691449580620;
        Mon, 07 Aug 2023 16:06:20 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id d190-20020a25cdc7000000b00d3596aca5bcsm2545203ybf.34.2023.08.07.16.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 16:06:20 -0700 (PDT)
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
	Richard Weinberger <richard@nod.at>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH mm-unstable v9 30/31] um: Convert {pmd, pte}_free_tlb() to use ptdescs
Date: Mon,  7 Aug 2023 16:05:12 -0700
Message-Id: <20230807230513.102486-31-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807230513.102486-1-vishal.moola@gmail.com>
References: <20230807230513.102486-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_160622_127580_EDE5B5D5 
X-CRM114-Status: UNSURE (   9.51  )
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
ptdesc equivalents. Also cleans up some spacing issues.

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/um/include/asm/pgalloc.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.h
index 8ec7cd46dd96..de5e31c64793 100644
--- a/arch/um/include/asm/pgalloc.h
+++ b/arch/um/include/asm/pgalloc.h
@@ -25,19 +25,19 @@
  */
 extern pgd_t *pgd_alloc(struct mm_struct *);
 
-#define __pte_free_tlb(tlb,pte, address)		\
-do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page((tlb),(pte));			\
+#define __pte_free_tlb(tlb, pte, address)			\
+do {								\
+	pagetable_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #ifdef CONFIG_3_LEVEL_PGTABLES
 
-#define __pmd_free_tlb(tlb, pmd, address)		\
-do {							\
-	pgtable_pmd_page_dtor(virt_to_page(pmd));	\
-	tlb_remove_page((tlb),virt_to_page(pmd));	\
-} while (0)						\
+#define __pmd_free_tlb(tlb, pmd, address)			\
+do {								\
+	pagetable_pmd_dtor(virt_to_ptdesc(pmd));			\
+	tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pmd));	\
+} while (0)
 
 #endif
 
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
