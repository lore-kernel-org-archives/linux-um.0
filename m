Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 662DBC04FE0
	for <linux-um@archiver.kernel.org>; Mon,  7 Aug 2023 23:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=stg53Nvfx4C73cTOcFIx3i2dOdJPkQxtHXpljPBwbck=; b=lMRxqq3K4/23j5
	2wnzsLhp6vFjQyh9ChVV26HsPbyrnmENJUvEJQpT186DOP15g+Ll3NeJuTlOu+FWHb/iDBLOwED2/
	AtJdaaQBz6BJNnBYFR96NWNLi9k5l16Qa3DR19zWF8LJRielvs70clQv1DjQxfMviHMuLONP7UMkg
	w1X/OrxZRzHvu5uwoJ1utuUMPvyTHgtqwPgiAttJskKNxPn/mPy+vKkaS3KR7Q/cOsD8nBXQKW2CK
	dReQg1Enj9FFv1SjD9ux85s93YkYXGrJ1/Okx5Zvfu9nKJohU3lkpuBGKatR5wau1jKGssOxqeEjo
	Z3jIksYtJkSljTVGHq2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9LJ-0018Ef-2v;
	Mon, 07 Aug 2023 23:08:53 +0000
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9Il-0015Md-13;
	Mon, 07 Aug 2023 23:06:18 +0000
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d4d0ddc15feso2348223276.1;
        Mon, 07 Aug 2023 16:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691449574; x=1692054374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuJFa6mAGFwbCAvFBsdWEeQAHJIQ94yaq1s2El5pO5M=;
        b=sRCgndxFhKIflL3dRUOciVixuY3um2CsOH9mqCT4RfpcBNQLoC/2xIlVP2BC0LrRXg
         d0Mfnrp8G1Gq70+B6oCgBqzc+N7zHH9xY0+av47l7B8CO6Tt+n9pMVSoswf5Jzx8/yzy
         NzCNQAVK/Lkid61qiT1qq4e/dSW3T9N7fVh6BXy/whyNG/50NiRv4160ULtNDt7ZAJ8u
         ZEinV12wAdQdY0FHQSDiTfa7/P6pGvAR+Q1UWR0j31w4+0ktiAC1WT1q41QbYEtl/+hQ
         cKdjsvUfk2w2q52f0mVtR4dPNDq1UHAYwd2r0wZzmsP36I/aPnhCen/ej73PJ82E0WBs
         UQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449574; x=1692054374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SuJFa6mAGFwbCAvFBsdWEeQAHJIQ94yaq1s2El5pO5M=;
        b=b0I5cCaeyJdCpd1oDFytJaJ8SJcDdXp93cSfec7K97r9sC7Ebgfg3Td1CH7mt+wn7H
         nah2v7vqWATumwFUUin0Csjv5ZdduSZ3wWtNsjL5r0kvEmMkiOVFGroBn9vbc0VXF+vz
         IrDB6V3AJuAU/ETctocX1duh2yVjnYF9/Lokhgd8vDfhSNgJ2FQdSQf5aAaQ5hziLOwt
         K41YGuGBybQFrw+DN6aK8KHMwQLALovi+3U0mLC5fsahR6xvEQqNvFS+8GByduHLEy8b
         EYO/Cm8arsVPS08TKTk/l+h9c3OJdc7l6R5mSPpviCj+QLzE7esSl9garcEt5X3sIPE5
         +cuw==
X-Gm-Message-State: AOJu0YwJWalxoylKDxivVx+EMoR/DYK2gWakhc2RxMFQu+O9UxAcEOnM
	mKWaSnjkRxmmd1JEHThaans=
X-Google-Smtp-Source: AGHT+IHDPhUgl52q/fREvy7LWtCvyksQLzlkWI4tWrtb//A8NgqAG/s+XL1YOkSBACmJ6FF0msS3mA==
X-Received: by 2002:a25:4081:0:b0:d4c:82ff:7bde with SMTP id n123-20020a254081000000b00d4c82ff7bdemr6684894yba.63.1691449574044;
        Mon, 07 Aug 2023 16:06:14 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id d190-20020a25cdc7000000b00d3596aca5bcsm2545203ybf.34.2023.08.07.16.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 16:06:13 -0700 (PDT)
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
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH mm-unstable v9 27/31] sh: Convert pte_free_tlb() to use ptdescs
Date: Mon,  7 Aug 2023 16:05:09 -0700
Message-Id: <20230807230513.102486-28-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807230513.102486-1-vishal.moola@gmail.com>
References: <20230807230513.102486-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_160615_427050_4039FEC2 
X-CRM114-Status: GOOD (  10.32  )
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

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/sh/include/asm/pgalloc.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
index a9e98233c4d4..5d8577ab1591 100644
--- a/arch/sh/include/asm/pgalloc.h
+++ b/arch/sh/include/asm/pgalloc.h
@@ -2,6 +2,7 @@
 #ifndef __ASM_SH_PGALLOC_H
 #define __ASM_SH_PGALLOC_H
 
+#include <linux/mm.h>
 #include <asm/page.h>
 
 #define __HAVE_ARCH_PMD_ALLOC_ONE
@@ -31,10 +32,10 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 	set_pmd(pmd, __pmd((unsigned long)page_address(pte)));
 }
 
-#define __pte_free_tlb(tlb,pte,addr)			\
-do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page((tlb), (pte));			\
+#define __pte_free_tlb(tlb, pte, addr)				\
+do {								\
+	pagetable_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #endif /* __ASM_SH_PGALLOC_H */
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
