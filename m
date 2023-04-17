Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B6DC77B76
	for <linux-um@archiver.kernel.org>; Mon, 17 Apr 2023 22:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bXra07RGgp9dLJDRgzw43+m0UgmsTNTAKArZRT3gBmA=; b=uPXvRpRGuKJKtg
	bMA76kHuECWNwcZ8i0KT5KqXi0uNIEoF8ZPS02DbR4Ez8CxDp0BNng5HsOD3FNZKzGE70o/4xl25z
	mQRMAUBDodLd1c0MEXoZ4wU30CV98XHOAWVSrOb70E7MeX2ChTVDbbuLn8aMdwpjSaQ4BAgzdNjNV
	3Gra171EyuY2MHTJLQPI1rd+f9u/JeZC9v46hA/MR7ruFcXjhhaZm3yXqiL8viCS8bkGtSCYYksMY
	r/FB+fwnpjRNzS/9p4hfQESxkPuHofxy7bEBcHo1K+xRsC9Jo5qiWkTOKbaomKOy0NTaojcWZlsb4
	s7/3dhFpWGFPI4GWVjWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poWto-000CQ3-0X;
	Mon, 17 Apr 2023 22:00:36 +0000
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poVx3-0000CD-38;
	Mon, 17 Apr 2023 20:59:55 +0000
Received: by mail-qt1-x831.google.com with SMTP id ey8so2494293qtb.3;
        Mon, 17 Apr 2023 13:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681765192; x=1684357192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1imWRfaXT28Tln454VWhUpR4BzNKR6UHESFdZqWEUY0=;
        b=de5Tn3nYEhn4H2I8tjPR7eOdygYzu1ryPtpCxL6t+a13yb7uBhaP5h1On0KDZt0rkA
         IAZSe8JVFupnYlnbz325M8yjyUaT70ZiP6iH6rm0YxNhgvoW6TQHqgr9rxEYBqo2IcRS
         g/gXk9FJAxQ/qXS2U3z8GPJEKEcpDa4qAMwOWS8jt7/58XrKZGDTrJpVep1ChFIRrxRm
         Y1sZaEpezlhHPedgwd2CR/8nPdVt6IFhbamUA10fXNgcZ0QE2TTuFYBsWiMSSzf0BJDg
         MO98m49qxKKVxDsNiA9sXO1g6tq2s9jp5Vkj/QO/0dHCb2enOOpjFa7L45KN9+HLUZpJ
         Vaag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681765192; x=1684357192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1imWRfaXT28Tln454VWhUpR4BzNKR6UHESFdZqWEUY0=;
        b=FyWVkeXSLk0pdYTxKcIM6xwnOD6mMlKW+a5wLLXmRl7EkYhV+qZjnKBuqnVf2LQ7Js
         TS/OTyKjtlEaHh1QEZkAWJnwOQtO5pnHf1dxk24n5eLjzuHMYDzkCjla+J7byjxLq1xo
         l36+uJmY3rIgRGqg1zWSFuoGhpYsgxi9IkRYEi3BjkIW1z99/0tLndSp/7ZxrYkX2I6W
         O0+dvazdm3BurJNJlmmcCXWZ1YwLCZ0uRAlJ0kiL3tWCgreKPJ/JDu4N5fs5tC4qqqeC
         a8d1P1HMhusbPIDpPTf4kcO3mhXlmMWocTtqH5eYZ9R3csUpdqWD6BqbpTUxLxMlJRVh
         rZ6Q==
X-Gm-Message-State: AAQBX9dD5ZZc86jxC9L1uB6PiwIVM7vHz97oloyX5Yz66taFKwdyXPr/
	KVGqPerUncXJIuY4ghDrDs34xvyuQYYiOA==
X-Google-Smtp-Source: AKy350Z5+qBQNd0Z/JNfcMKaitdnDjfxbnOB0qE080qoviMZywL0T3VtP+5OcGBInDjHaerFJSFHYg==
X-Received: by 2002:a17:90a:d142:b0:246:5fbb:43bf with SMTP id t2-20020a17090ad14200b002465fbb43bfmr15902207pjw.4.1681764805699;
        Mon, 17 Apr 2023 13:53:25 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:53:25 -0700 (PDT)
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
Subject: [PATCH 29/33] sh: Convert pte_free_tlb() to use ptdescs
Date: Mon, 17 Apr 2023 13:50:44 -0700
Message-Id: <20230417205048.15870-30-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_135954_011535_FC68154E 
X-CRM114-Status: UNSURE (   9.97  )
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

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/sh/include/asm/pgalloc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
index a9e98233c4d4..30e1823d2347 100644
--- a/arch/sh/include/asm/pgalloc.h
+++ b/arch/sh/include/asm/pgalloc.h
@@ -31,10 +31,10 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
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
