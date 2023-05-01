Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C06C77B7C
	for <linux-um@archiver.kernel.org>; Mon,  1 May 2023 20:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pd1jEy6Jr8g04EAUMw2mHxtrTG/oIk2UkAf2T8nrYj8=; b=F+dz0fKJDTIzNB
	0Hx5sqawUFZESjKWs1km8I6JJQt9M2sEmLOB5YSyQ+2X4+XfPcBSQqLxtcDOv4RUnkW5zGxVWI2DR
	ESGx5nzdAKFuZbXGzeFWB+HzQwkr4N2o6KKrLAoFtoxr4UfCfW3WxRrZObD52nUvfqb03xOljwaqt
	D2WlDHDxVchblTSdN2rU8yL/N1LStUZ3k/02cDL6dWg8KR4mdmJ9JpBysm9i8TNJiS5Y68jW1cN9Q
	iclTCv2g+GL4VUUCbkmqP8Pkn5+ONfpQOB0/h8TAcWbz6qxUSFwMeNS8gR5hatI/+XQZ3eWl138Ed
	tN2bC/PdZ9PQA97qfTOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptaJy-00Gu0h-1G;
	Mon, 01 May 2023 20:40:30 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptaJu-00Gtzr-1W;
	Mon, 01 May 2023 20:40:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=M2PCFvKq9JWcIC4Exd9oDYO0v0PQOHyXRap+yEgbOb4=; b=Ji9k8hlGIyVGR0EdTwo8inW2K6
	mNPNQOGrQKOH2ODLJJOS/wVqOFJ30lWsy2HT0w4Pw3cdnXY449BSy3CcHWJQujPI8rjynY0ZDaT8/
	dX3M1p3V+43RW+LUt6ZbD9bXDEE0B5v8w6iQ9FiPbnxEoddKAD7i5F6B+rQ+qVTjKZfW+OKn7z8Oa
	PAgdbs0lKs70Armw9f+7IVPdLlxP267r2FUTyOppLxZs/sCX3veFRNY9zJh9f9JXcSuVH1BWG+/wK
	mLNg8DvbJmLbn/ULVHumhFpHVsR2gcyz61Q7mXKVRDeeSE+xU1VgB91N4acnvfabh828JDfVX74H+
	nvenbH5g==;
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZD2-00Ez6k-2q;
	Mon, 01 May 2023 19:29:22 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1aad5245632so16557125ad.3;
        Mon, 01 May 2023 12:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969355; x=1685561355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2PCFvKq9JWcIC4Exd9oDYO0v0PQOHyXRap+yEgbOb4=;
        b=pbOgq641Q1VbKkWYpSKEOBTaJbK7N+gn3tPQxAnQMHVxsbuYS7d6gCFZWWRyAoJPvd
         QWBoalX7ztTkXy1/S77S44wUsaYiw+c9l0pjoAvj83RwanS2FHVDTD9b5yLt3dvSiRkC
         Y6FbuRkXeTez8mU8JwqFdJ8q3udPbLVyCGPniHNdmE3Bvis2G1N5Cf54GBHK19m19dh2
         ECy1qDfhwNI4K2KlZeZKdUsb//pSuTNjtcr9BAZz+ZE7jjtZb0g8W7o+eLshkW2fWRhk
         rjbBHucvZ06kdc4e0Uijz1mCvV4V1RY1P7Hdmh8XbAUQYZvgzIuSpNmzClPaEZvw/eBL
         VKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969355; x=1685561355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2PCFvKq9JWcIC4Exd9oDYO0v0PQOHyXRap+yEgbOb4=;
        b=XH8SAOaaE4txo6u3FBT+crXU9sozd5iVLmQIIq732z4VhqKSA/vkjJ5F+QVWSsjCIZ
         E55WVeZfhTiAcF963dUQ8MzbytQQsYrc6KZ46NaY9gUaT1SkE2l6d38UFhib9p6kFRP9
         jj6jzqPTptgNVD0GLAHUo3Y4nKMgOEG+zvAMb7SYeTRmNrim9j8DAAmKaWS7DVj4CqBu
         24PZ14V8i6skWxFzY86WtBopYSnjAcNNM8VDRmFVSW3z/DEnKx9eLSZ6vBuNEm/ZSJHN
         bhEBzj9R7Qut8MBoRcGVoqDw41zT7niX/t7FkfZqLEBLkl3wckMGSjw1vySnj2z2UMB8
         Y2dw==
X-Gm-Message-State: AC+VfDxz6Lx+qBxKGgp+u/wGRWNrpsy9FR3FwhdHYw/0G4ynCNV0lWlO
	OtQWtBHD8Ct39EOHWqH0GsQ=
X-Google-Smtp-Source: ACHHUZ5aUwQpmXFq62IOwkeTiJiFUSz6Wt9PaXTxNdRH/kylJwLUJvf08r71LifeGRMo3EYnyRIKBw==
X-Received: by 2002:a17:902:dacb:b0:1a8:d7a:9255 with SMTP id q11-20020a170902dacb00b001a80d7a9255mr17869996plx.54.1682969355424;
        Mon, 01 May 2023 12:29:15 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:29:15 -0700 (PDT)
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
	Jonas Bonn <jonas@southpole.se>
Subject: [PATCH v2 28/34] openrisc: Convert __pte_free_tlb() to use ptdescs
Date: Mon,  1 May 2023 12:28:23 -0700
Message-Id: <20230501192829.17086-29-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501192829.17086-1-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_202919_997350_329F06E9 
X-CRM114-Status: UNSURE (   9.67  )
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
 arch/openrisc/include/asm/pgalloc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/openrisc/include/asm/pgalloc.h b/arch/openrisc/include/asm/pgalloc.h
index b7b2b8d16fad..14e641686281 100644
--- a/arch/openrisc/include/asm/pgalloc.h
+++ b/arch/openrisc/include/asm/pgalloc.h
@@ -66,10 +66,10 @@ extern inline pgd_t *pgd_alloc(struct mm_struct *mm)
 
 extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
 
-#define __pte_free_tlb(tlb, pte, addr)	\
-do {					\
-	pgtable_pte_page_dtor(pte);	\
-	tlb_remove_page((tlb), (pte));	\
+#define __pte_free_tlb(tlb, pte, addr)				\
+do {								\
+	ptdesc_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #endif
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
