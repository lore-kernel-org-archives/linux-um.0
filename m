Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F755C77B73
	for <linux-um@archiver.kernel.org>; Wed, 31 May 2023 21:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lqoH6PswgDxG43HuBDtx1JTKoO3KYYehmLDvDyk2h3s=; b=ZRk23aK4IKI6Wo
	1mcCfdPbMgyeOAzf8KtQVLh0GO5NTt1vXKQHEB9rc/rLs4Pilrxv1y1DdBiTt8Q+yZSir7EmT/ocz
	38oT9HwRcppweLrqXlbjj4ZoHflMlvBvS7tkNMDfzXzX6O6cd/7LwveIQyty31aznmySwqbxOewEn
	iUfCURrmPI4IVOHg6PpKG5MFnTUprAHP9j3YH46D+bHgaxR9ITy4zjwiNfvzX0JFTrJMNZyRMerqG
	AXkgcKf8vxQqfahlaHNJ6WxWcc63Lf6+o3gjwSAtU1D+z03dPaE9faJ9LxXC1+llK4GGQO64V0qnZ
	Q6+e4f9PRLshONmiyV1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4TRn-001BIm-35;
	Wed, 31 May 2023 21:33:35 +0000
Received: from mail-yw1-f174.google.com ([209.85.128.174])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4TQR-001AUj-12;
	Wed, 31 May 2023 21:32:12 +0000
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-565a63087e9so751367b3.2;
        Wed, 31 May 2023 14:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568729; x=1688160729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=viYddHqy4Zdgp0J9O3iaWpIktRFOpc+3TNsEHN2SX9A=;
        b=hVqCB7aFrL5Nthi8pAlbjPvcInjFZt1qHkddABmx8gtVThNjktDfpfcNDFDlw5CG2+
         3xRmURAs/k2Nz9kNjLGLhiem3PMoX9/E6HDghH1XQlgENBdym8j3RSqFBZDSSy/b34yh
         AE2QmRwS6oPUlHWjPpeT/6u7AJu6WV2M048WkEp+vu4WP+h6zxRkbzSalddZaQ9VOuvn
         LGPsCzdTJ+5x5K0wsh8kq5o2Vj7pKu44k/mXiACQfaNUMTBzpYonaoHUeQuALtzvZCNz
         9M8tSd6AM43Q88HJNwRerrYrxc+HBnHCgqChwQ1i4KI3ds/XwizMZlg5u8MI061tV0gV
         yEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568729; x=1688160729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=viYddHqy4Zdgp0J9O3iaWpIktRFOpc+3TNsEHN2SX9A=;
        b=X9KdwCoyaDOxKqWh+0okspf0cnZMJuvcSaEY6D0DKrmckiOTII19aZ21TR776MCgMp
         Xf/xQgrZhG6AHd/cf3lgb1XhC2i0mjjWGpX5Wgt5BW9owRAN2VQkW47vHVJuqYbqC4ag
         1sIWPHFQk/viO3Y87H4HDzRB5FwJIqQm7v2UkLeMrmchmfhln4e8HWWMUdYs1YAhdVDX
         +qlMYimPnhcsBYeH2usQ1PmYZWt6uHk7dcyy5wtdp44vNhHvWQ/6iJJP+YfoOAFP+dNP
         nuwK/pMfc/Q3W3LiJPs9QuQ4pYAZvIIppkV91XwNy/AJc4ryv46xiZTb+iV+B9pR1fj8
         b1MA==
X-Gm-Message-State: AC+VfDznBRRzJHiN7qIUNUJyx3tjHNnj1KXJGxv6BpfBebVJgW9uKePg
	pUedwznpop3JpuPz/u0nyd8=
X-Google-Smtp-Source: ACHHUZ7dIRO2Itz1UIyUgFPRBSeGYhHu2aqfX+t+ZClzgP9Es2W2C4cR0F0LltUImCNhGQXKVAT26w==
X-Received: by 2002:a81:48ce:0:b0:565:62eb:db6 with SMTP id v197-20020a8148ce000000b0056562eb0db6mr28101ywa.42.1685568728711;
        Wed, 31 May 2023 14:32:08 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:32:08 -0700 (PDT)
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
	Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v3 30/34] sh: Convert pte_free_tlb() to use ptdescs
Date: Wed, 31 May 2023 14:30:28 -0700
Message-Id: <20230531213032.25338-31-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_143211_359803_231B304B 
X-CRM114-Status: GOOD (  10.82  )
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
