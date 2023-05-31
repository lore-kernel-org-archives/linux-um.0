Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B123C7EE23
	for <linux-um@archiver.kernel.org>; Wed, 31 May 2023 21:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wmZx5lkZgWG9LYOkMKxjydwD4uNitHcOHc3oJmIC/4w=; b=j8PfqFlJcgpXc6
	aKaCxdQBfkH8EAE00TrKbq37bB5grpkAL2NxDgpqpyDDqF+FJPRo39Bm/v+hznS2AyiMl5C38vbbb
	dUH8NMPXiOlHtgAMl4E1NE1d5KPNbPY1pwKP0LIZTR2ISZreUBN9N/bevfFrwGVwR4kC3PXd9nndc
	yRz/cUX9KDy8WbFr3KwReozW6VuR53OFg6mzRnYZjF9RLefflERYBXFqLDc08Zds5JiGH9I8+MY6S
	+6IOWuDfTtAcPV65lOz28v6BAUG1XJQOsNbYaxpbbHymEqhXToxeyUmio0M3aBVDMqKAEhZ0eLkmF
	43Ix2hJMJwbCkFKavvlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4TR6-001ArJ-39;
	Wed, 31 May 2023 21:32:52 +0000
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4TQL-001AGH-0Y;
	Wed, 31 May 2023 21:32:06 +0000
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-565ba6aee5fso826267b3.1;
        Wed, 31 May 2023 14:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568725; x=1688160725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1x1J4vur13K6ienQiLVxExje9aLbKUsjVFvIhcqO10=;
        b=R4JOyFF5oGis8NxGU8pSpePc9JPXMsijgUHIihoBFDMX7vxfyfSgK9gS7L9vsvgMnj
         MoFYSUO2hucvt6EXtvpP7cclM0FlcdhnlFMXLdspy+TrRtUW4byNtMBbPaBMOtheTLzo
         JyXpw6dclXVn5TBmIUwO4ll+Dwj2sxioBm1tcLfW7tR6/lFa3tmkjwZ+b2UxBU9kd/xU
         9674/17mKjyw9zKVkY7JTqJdm8j6Ukk6MApKOQVf0MMoClbBMESl6AhiCYUKK1tGclZh
         a/IF0OWr+we0YPVHDLrOdoGrQ5ob2G14WJkmdrRtqm2pP0cB8C0ATsRWLlC+f5L22Z3U
         c7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568725; x=1688160725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1x1J4vur13K6ienQiLVxExje9aLbKUsjVFvIhcqO10=;
        b=J+0AYzVduLdCFaLpJKP8FouR4MU0YsIAOVan+u17fEar7CrkchYHx/raU8rTs+k50K
         qLTd1Bx30J2ZP3Vtv7vn5qg+7DQVSvjRS3hl79F5pWVF8lxytlsBFDERkZexs6kl/cRJ
         rHWs8MSIIwc1Tthk1AstJ/s5/qKm292FhpCuVs4e5ss6zGuMgHPT/R4XH7W92TpdjGJ0
         f0ZcC++t4US34hDh/Qb+KXjKatLtdJ8RFX6bt/V/P1eGFQNLAOMbLaLX7tLRapOZz23g
         jp/FPl8IhlOir6Dm5CQbFHp1btb0p6Ubzm5PWKmYayLMW/XvTbnTatZ1vJAEfsAiW7zq
         Z9eQ==
X-Gm-Message-State: AC+VfDypsRyfP4unw7vJckvG98k7+Oy4dI2AM+bsO+9murpGfUtjY9xl
	WyMqa6/ieW3lAcIpWJZYnv8spDVK6PA7zw==
X-Google-Smtp-Source: ACHHUZ7OmIDubddXjmsfBoe/XagN9Nq+I2v1lq5kjayLp/xLt6wDO/g4P/XIV7x6OHxU5ctdplxcBg==
X-Received: by 2002:a81:d246:0:b0:565:9d27:c5e0 with SMTP id m6-20020a81d246000000b005659d27c5e0mr8010590ywl.2.1685568724694;
        Wed, 31 May 2023 14:32:04 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:32:04 -0700 (PDT)
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
Subject: [PATCH v3 28/34] openrisc: Convert __pte_free_tlb() to use ptdescs
Date: Wed, 31 May 2023 14:30:26 -0700
Message-Id: <20230531213032.25338-29-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_143205_205945_3FF6F246 
X-CRM114-Status: GOOD (  10.18  )
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
index b7b2b8d16fad..c6a73772a546 100644
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
+	pagetable_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #endif
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
