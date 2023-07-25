Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08406C04E69
	for <linux-um@archiver.kernel.org>; Tue, 25 Jul 2023 04:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Q9YK12Nsx6ujQfndJjchy/U9wYLDzQsH9o5g0eiiEws=; b=EPZoHFfX//bwHk
	u3yfY6B/okDp8Jwz1Z8XZiSVRSWExGgwDJO8bqpeCYLAOPQckqioZLdv8GPIcYaq1QecjMQgoALcP
	wL2F7zOFwm9+0QpJyw/LCQIJbSgh0dDoxAttXigI2GPnSSGm4oXM4AYrX9n2fitGA6llASDs803TP
	TTO47qs/RKKUlkpk8fTufIB9s5fyJV6cQBvG5Gm2F892n9WxZH9mlGofSlzT0V/aDze+wCjeLOna0
	pH5zJ9fUZJOomdqAYqgOpewKrAxxaQtfClgYOtPqPRV3aMFQjTb3l5TxOijxxNTLc0GFGSAm3iVqD
	Yb473UxjVL5w6z30EcXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qO9ar-0069dy-2H;
	Tue, 25 Jul 2023 04:24:17 +0000
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qO9YS-0067Zp-1i;
	Tue, 25 Jul 2023 04:21:49 +0000
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d066d72eb12so4536291276.1;
        Mon, 24 Jul 2023 21:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690258908; x=1690863708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CuYJ7liBLmFxtlpmCAIL/qtog0vkZLk1dVk72P32nA=;
        b=isSLzJlVCcu3DqkromZhEI/qWyA5zzmxG1x9IbP6194I1DKOByM/hDEPdxe0FV3MLw
         d6Rw+lHZ9WlgptdvBWiFzGMaM6KUoRlGp3xu2jda8iMy45KiL59BtGKHYho8dHuVUxG+
         hJLuMObqibUKBJwga6VwRPSAoh79vGoLNGxF2cxBKo1aHJdauK67/yOhDfLuLDKzblyJ
         F0wgtxLKGut1KlZ4xgsSxueuM+T0O4hKbp6cFWk4PiHYX5rGa1VxC3c5t+U93CbfreQA
         BhDLct+PPc5ibyvQ9RmPu/T+BvIQhbpSiLzGAmfokkxsUZTkKg3EAjaoANJECHoNxZLs
         xbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690258908; x=1690863708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CuYJ7liBLmFxtlpmCAIL/qtog0vkZLk1dVk72P32nA=;
        b=bfkdpflWwBjdszwXHrr9djGs5T3Gd3rnvP2MHeVT7n4bz2gbxCMUSjwE6dnnRrXZmM
         qyG31hrRLzjZTV7o1ZqWu8HiRR3/iVChGswprOyRUqJF5zlgtd7PHaA1aofn+HFlWNVB
         8soSE8UPD7bHiX8Yc8jUDr34fWiutIknhUEK+DjnrBfuZWDyd4HTtZdLiYkBuPbi0V2U
         G4jqdkU0QRFlMtsEenYYjon0qunAEiW5iGj4LunXcwhVJw40qopmiz9QKmrN9xiPt7H6
         K3m2bNDDOsX7iLyMJ4cyO0/tEj0YScrJt4KsMXcO7Ol1NQdz2YxgR8jis+D2QjR8Bd+E
         KZcw==
X-Gm-Message-State: ABy/qLZHafkdcd5sNzPjh/dLuYsThUYLtF82P5QnJFxtDf+VDpdOVEox
	C6Y/YtTeisvHHTDD+DTYAc4=
X-Google-Smtp-Source: APBJJlE3eJKl34GJI9esPlRffLNepF5AyEOkc7MEH4MKJMttiyYPB1pXgCmUyzmySa6Xjpm5Cuhodw==
X-Received: by 2002:a25:b08a:0:b0:d07:1a89:2e73 with SMTP id f10-20020a25b08a000000b00d071a892e73mr1367996ybj.28.1690258907697;
        Mon, 24 Jul 2023 21:21:47 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id h9-20020a25b189000000b00d0db687ef48sm1175540ybj.61.2023.07.24.21.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 21:21:47 -0700 (PDT)
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
Subject: [PATCH mm-unstable v7 19/31] csky: Convert __pte_free_tlb() to use ptdescs
Date: Mon, 24 Jul 2023 21:20:39 -0700
Message-Id: <20230725042051.36691-20-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230725042051.36691-1-vishal.moola@gmail.com>
References: <20230725042051.36691-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_212148_621460_31FB45AB 
X-CRM114-Status: GOOD (  10.95  )
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
