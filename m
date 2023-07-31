Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DB9C001E0
	for <linux-um@archiver.kernel.org>; Mon, 31 Jul 2023 17:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Q9YK12Nsx6ujQfndJjchy/U9wYLDzQsH9o5g0eiiEws=; b=X8PHAOVjo/ZRGp
	iWV+W6qpv/9TpoyQA0SvIDiVOzepG1RxlKCKnIL/XnL6XC4KFbqTNwaAxZO9Myjgu0tWdltRYOW5L
	lfC03T9W4wrRB8IdRPdepI7sJ6nE2TQ5LcG/wZPLGLDspy/4F/Vtp5PrIsrawozravdOFJK3XfEXY
	F4CbrzXTkpzicCCq2saj8CuAJN1oCZpV3FZpMl9yxhl8ZXm+76FOJ7KeQFMKSl06miyV2bF+OB76i
	KC9TIw4xXtVpllp+3oL7H4TTEDIawg8N647BDid9Ktg0iIBrIZael8ncqqt/VDnQKnfGsAQ5zk4C9
	nmJf96/bGv0HaNQ5TYWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWMv-00Gn1E-0z;
	Mon, 31 Jul 2023 17:07:41 +0000
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWJd-00GkS1-0F;
	Mon, 31 Jul 2023 17:04:19 +0000
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-ca4a6e11f55so3743860276.1;
        Mon, 31 Jul 2023 10:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690823056; x=1691427856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CuYJ7liBLmFxtlpmCAIL/qtog0vkZLk1dVk72P32nA=;
        b=VD/5YQf9dWYT3s+XLCXcwwiIVAHAp/pIe7AMdOvpExYmK5HjPOWTZu09sLOfQMxAfC
         OXuPdz7Tj/gRexFEV/+v0Lea9a4mnAUKnOzN7P73JNN0+oqdEeWVHp/XrVyDKMN3Sqzq
         XyvfOK4vNNg4SIqEO+DbR5HnEigDlCQMi9XWjP33h/pZyUUMJf9cJEbHTYSdJe7xIVgq
         5L6GenpajpPmM3TvCUDFhBdcux4f7GetW1kVA2GoYO0OMNWSzyNz+zkHnzCWEOnqLDpJ
         MBPlFqECJSKW8b/LiB8vJt+wWDGPekjS3XxHyTLS29uaM77UixmV7cvi9KvK+lFaz9YU
         pXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690823056; x=1691427856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CuYJ7liBLmFxtlpmCAIL/qtog0vkZLk1dVk72P32nA=;
        b=Lj5loSWxYMm0pgtMcToxttYiHx4nBfR0/2pGOAgdA9mm2uu7/58ZW1PKyea+oKcBH+
         Tc0vaf7YH0BpoIgujGsUJUYqS6TVdO2ttN4cHvFtEDV+vqcUgI3G9+LZLmcM6Cg3ZY8y
         uP2+OdEdIp914yYgGpOyciEBK4X/f4xNTFyM5a3bmDpwvdoUqpVVwUGgVofZutGhlxR3
         NQ3yzYUNRB3lrIsBnlIuLsUJx0fgBb+G3UX6j6CiTiHzltbW53waq2Bp9bxmJ/Bdeoa4
         ga09a9JtSx2m2I0fDydGG2y9WOGBDaWo325KgyAjPGCfLt2o8ULdijcszwpzeJTsEWQ/
         z1Eg==
X-Gm-Message-State: ABy/qLbfj0DETpIHZAsutPsMlelAFH79rXB0bP5a0cZv2z82+3jGXqOJ
	xbX5fpjkGYKyenHwkdVcYtY=
X-Google-Smtp-Source: APBJJlFHDXc0WViYFSb3R2hW52w3IhQItZ8A+xKJNI719Lf54J20Rc3nckyX4WKCIAYzzN+QzoVnBw==
X-Received: by 2002:a25:734c:0:b0:d11:61da:3a58 with SMTP id o73-20020a25734c000000b00d1161da3a58mr7589775ybc.54.1690823056172;
        Mon, 31 Jul 2023 10:04:16 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id x31-20020a25ac9f000000b00c832ad2e2eesm2511833ybi.60.2023.07.31.10.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 10:04:15 -0700 (PDT)
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
	Guo Ren <guoren@kernel.org>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH mm-unstable v8 19/31] csky: Convert __pte_free_tlb() to use ptdescs
Date: Mon, 31 Jul 2023 10:03:20 -0700
Message-Id: <20230731170332.69404-20-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731170332.69404-1-vishal.moola@gmail.com>
References: <20230731170332.69404-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_100417_157164_1CF1F26F 
X-CRM114-Status: GOOD (  11.30  )
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
Acked-by: Guo Ren <guoren@kernel.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/csky/include/asm/pgalloc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
index 7d57e5da0914..9c84c9012e53 100644
--- a/arch/csky/include/asm/pgalloc.h
+++ b/arch/csky/include/asm/pgalloc.h
@@ -63,8 +63,8 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 
 #define __pte_free_tlb(tlb, pte, address)		\
 do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page(tlb, pte);			\
+	pagetable_pte_dtor(page_ptdesc(pte));		\
+	tlb_remove_page_ptdesc(tlb, page_ptdesc(pte));	\
 } while (0)
 
 extern void pagetable_init(void);
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
