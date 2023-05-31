Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037D1C77B7A
	for <linux-um@archiver.kernel.org>; Wed, 31 May 2023 21:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T8RpUJJ9290U/4lltQGvqQi7HzzdVjQEo1LfNdPN4Fk=; b=XtclWH5ayHdYzF
	aXvXBgvnsoinPpqJUzfW8UhgvfdoxO37Lxp4GpdlndhQ7evHN0UwRgP19zh8h9YZDp/RKYuq8QVvl
	mjOAlNJp6JMoGxW9XJk8aa23JfxHi4x6Ygz1inhhqfs/JisxF27+QGo3FKRCCl9tUvOQFsiMKAhQ3
	t36ZmUzLS0m832ops2foSpmdk55OPTjY3Xh8rtI04SrBm38XWDc00SuSw6rKJ2Sk7i0cqXW9GlU13
	SjQilsMlyBMELZViTvygDt0tsYbdmrh6tdgAvGyVmAlA9PAJ2FcTKF456FnT+wmj6PAtw2CDranox
	w/hWUsAqGETRK4FTHSzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4TmH-001EhW-1y;
	Wed, 31 May 2023 21:54:45 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4TmA-001EaC-1G;
	Wed, 31 May 2023 21:54:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ELrYSGf3rZcM0SKncNLanyoUH1rFlxcI1YjdtaAHWOM=; b=fokKDkKkVVzZ1YSUmvzUfmT+aP
	BbhBWc87xlBGAw3bXrq3Pwi17A6lkc38xMu0tf3pljVVf2o6MPfVha2Quw5dfB3v+Z1CHagvQ6Wlv
	CG2kIYps3yC83IkaSwCZk+H0yv8ZMH68+LtruOTitc/S+W9iKkYtn6YQ8DZVMc29ntymeohdQAu40
	8hC5opnyuFcWcYoAdybIC+WBbJTbUy3TMUL7LXzG8HPRjC+EMOYLlp9exoebwyPk60CxSc/rnTuAn
	evZgLrtd4acQH6oNPxBUxeXfTvI04y+oUjJJLs5D2vZUIKK4e+MNXpKJ5lrA8ASjIXHspCi2n38wK
	A4EcuoVA==;
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
	by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1q4TQD-007fmp-9W; Wed, 31 May 2023 21:32:00 +0000
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5689335d2b6so717127b3.3;
        Wed, 31 May 2023 14:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568715; x=1688160715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELrYSGf3rZcM0SKncNLanyoUH1rFlxcI1YjdtaAHWOM=;
        b=HVGvjPguQLfPfWkiro39nbW+VW4H5uAeLDGXOc+QtDych5ss5NctDwcG9I1c/6SDfz
         APKwygjUx+f7skr0RtKISqSCz+AX9pojhDKoYcMCQyYniYHupBRU0wOHCUoFqOcXQqMh
         s5WPVmf9msAVfThs98QJDhYbBO3Us7PGfZ8s6z4W61niHbKtctIY2nt8en5Qr8xNSORH
         CbV2Bk80OmBOMZ+UG2sJggDfKIMsAz+S52UtEmTBG7rQO3TOu+Ov8Sc+TVK0fDYwDx9u
         QGgal0w97o+Ln3oc2qepS23J75YM3y/Dwt4cq4bO+YUzmRNBHe7fo14HmAPdP2J5Q06p
         Rhjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568715; x=1688160715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELrYSGf3rZcM0SKncNLanyoUH1rFlxcI1YjdtaAHWOM=;
        b=iUajU97cioxPQrH6qtNxdOCAC2ENAKn++sYZSWTuvfiRLSji9Xftl28V/vEAfavxMq
         9tza1q/WjTRv7Sxv6FUKl9jtSV15QLGUsX9hGVe/EwPcYV7dxzuvbdPCUDc0B/LCDsVF
         dhoE5c3EBRiBohFyEOBETRVaNI0AKYxk3UnVu/W61ncjMx95VlePtiSGl0QupPudIs5e
         QdN0LDO5LXPMzgrvmpNlzEu4egza1RWqhNVz5aI6tEun5yfptLi5rtW2FQY7vQrBIs7I
         +80f22/GgmeWGRnsNf1BuQ9VY2XCJ+iBjxcDPlpRVXdCvyz61AKF+xhVQUlOOh4k9ree
         S0xg==
X-Gm-Message-State: AC+VfDwhW2ikxnwgFk2o3epsczBMavHwKWA2MHgDwXANlSY5uJExh/8U
	2+h64RZXOvKJdYO+tLiYW6w=
X-Google-Smtp-Source: ACHHUZ7KZYp2khjpsM/eLpOUxorXRdnAb+nMmuGE16o93fcYthDjjOgaXk5MabZ2W/EzUmWY8vgN2A==
X-Received: by 2002:a81:6f06:0:b0:565:cef7:92d2 with SMTP id k6-20020a816f06000000b00565cef792d2mr6456173ywc.21.1685568714840;
        Wed, 31 May 2023 14:31:54 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:31:54 -0700 (PDT)
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
Subject: [PATCH v3 23/34] hexagon: Convert __pte_free_tlb() to use ptdescs
Date: Wed, 31 May 2023 14:30:21 -0700
Message-Id: <20230531213032.25338-24-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_223157_711131_715DAD09 
X-CRM114-Status: UNSURE (   9.20  )
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
 arch/hexagon/include/asm/pgalloc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/hexagon/include/asm/pgalloc.h b/arch/hexagon/include/asm/pgalloc.h
index f0c47e6a7427..55988625e6fb 100644
--- a/arch/hexagon/include/asm/pgalloc.h
+++ b/arch/hexagon/include/asm/pgalloc.h
@@ -87,10 +87,10 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
 		max_kernel_seg = pmdindex;
 }
 
-#define __pte_free_tlb(tlb, pte, addr)		\
-do {						\
-	pgtable_pte_page_dtor((pte));		\
-	tlb_remove_page((tlb), (pte));		\
+#define __pte_free_tlb(tlb, pte, addr)				\
+do {								\
+	pagetable_pte_dtor((page_ptdesc(pte)));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #endif
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
