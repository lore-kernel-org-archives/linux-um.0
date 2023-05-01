Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3CD4C7EE24
	for <linux-um@archiver.kernel.org>; Mon,  1 May 2023 19:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PDeRVgx6VdrDwiu/6fZNvPKw1Fpnr8ytlHai/7+HsnM=; b=KtQIPIxsnTmu85
	40lv/z0kBAeElheLz7dc7j4vmpHh+pa8Rqxxl+y+u63cfyV+jXpuJSjl+0NT8hvdsX8Jn9QFRu4MB
	eEfAygh0xMZdPSGgPo9ccv+acAUcGgxpFWSEWNSLzgf9VVNE8VpwLsyv4Sxq/kaaLhs0bDrmUbvaG
	kudvGDK7Wc6oh7PfMyfDc9bKJItDE2M1LMr80HAZopeZBqt3TR2ZzSEFsLfQJAN7B+ObmaG5au4f2
	JKSxpISZYo2KeHur1WY760iKV67ybKG/+m5pV/K9h5fJ5oDZO8DU8BqFfJfv0UZ9pW/HAdxxVsC5p
	s8QBJI8bqhWGmkrobPsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZDB-00Ghlq-0d;
	Mon, 01 May 2023 19:29:25 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZD6-00Ghds-0K;
	Mon, 01 May 2023 19:29:21 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64115eef620so29041066b3a.1;
        Mon, 01 May 2023 12:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969358; x=1685561358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aCjEZJk/he0B507v8WHbAo+ayyw9u0whNe5hSh1Qc0=;
        b=AK+jJQIndwyipvZ3j74RRrDCnGWb55RfRTFZCAj1QjfEP6JtcEnkxab8VHfUxlnJqD
         nzyDIYAX6jvOrQqc9g/TswPCkcqNA0B0b+SVKLMEmNApHkelPozzZarkoTrP2UobldQU
         E6NqDV1CfueV3wQaPICMNftiMflroUHircwtbGv3hyeRwqO/KqZCxi3BNAP0dk8lYID7
         5OwqBACQpi+nvrf0goZMdOfhVuRwRiXsUHvkFH+vRl0eIOaoeix6IqEc2ZJsYZWlONhr
         qoO4S8rXijotpMJHxa1FWYbjKdY7R5WGEGDzLNmBq3rOIwjAHcvHuIBKVpOdfgv+tSJ1
         RDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969358; x=1685561358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5aCjEZJk/he0B507v8WHbAo+ayyw9u0whNe5hSh1Qc0=;
        b=DA4GE2xDsY/lrcu8pgRXfbsBIZWkAGUDrgO4ROXnNJZ4ASUDHTutLLiedJcJRm5BJQ
         Ioixop2g5BQf5d/AxyNhPhomKRZmnmL2npEvjjsNh8Xi8XzgeM8ZBmprGeuFdzzuzb8j
         WxefTFvvfFJQbkSuQvL/7JZcDH5mKSxCda3j2SYf+tdkRPr/RpsOkfFpyy8eYr6WUH8Q
         k4v5xQMLz6xInJFlxh4s5f11M1Ww4+VE1uLLREVcyK/BkJ4TDcjK6TYgwtM/L7Sgfan9
         IdHugEM1U/iESF/ulBtG/7jgvzZtSv/sy/j+JQldstdw8LFGJUqI1Yo6tnUp+gKHE2rp
         Ce4Q==
X-Gm-Message-State: AC+VfDxV4S3WVYsN1kfZf1AojcDUxW3z4u36FKY0vIZlVE/43npBUyw0
	Kb4xmaBVmpPPjscVAkYhZgg=
X-Google-Smtp-Source: ACHHUZ6t8R71ld5pjw9YJiJ63m1PjvmCLBjw2ONvK02V0vikRtqecj56I+goZm4GypngOeaNmv5J/w==
X-Received: by 2002:a17:903:2307:b0:19a:96ea:3850 with SMTP id d7-20020a170903230700b0019a96ea3850mr18111173plh.17.1682969358236;
        Mon, 01 May 2023 12:29:18 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:29:17 -0700 (PDT)
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
Subject: [PATCH v2 30/34] sh: Convert pte_free_tlb() to use ptdescs
Date: Mon,  1 May 2023 12:28:25 -0700
Message-Id: <20230501192829.17086-31-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501192829.17086-1-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_122920_166405_06D923AA 
X-CRM114-Status: GOOD (  10.40  )
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
index a9e98233c4d4..ce2ba99dbd84 100644
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
+	ptdesc_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #endif /* __ASM_SH_PGALLOC_H */
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
