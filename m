Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE80C77B72
	for <linux-um@archiver.kernel.org>; Mon, 17 Apr 2023 22:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pd1jEy6Jr8g04EAUMw2mHxtrTG/oIk2UkAf2T8nrYj8=; b=izcoX+Bx2bKA+l
	Xwp0YFDO7tcfUHYqkaNM5RpdfIQ2hf8dj5SqLhs4kxwkmliPWjxyf9aUunfSz6tkppH1yVItBMyvW
	XYIPzcVxMAhxcgluC9VmurT8xw7h4OByd8nn8DLyMWbBsWYCluIFYEeFJP/LrPQw4MNPGA1BE5hG/
	S/wkG7z0MYZZXOZg5gat8ZhnWoZR/hT5WALzorESR62P8P+SGuFmC5QOf1rDs2q/4jCmbuQBhK1XI
	8JT0QV/l3Ov3RhQUM0m+2uowPuXk0GO/ebyc4ln7a08865CDwB6tGnjZ+XRWH+ZkXoPUn2MA6ow8r
	LKoQ1UP70WAgn78NWnGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poWvQ-000DRd-2E;
	Mon, 17 Apr 2023 22:02:16 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poWvK-000DMb-0e;
	Mon, 17 Apr 2023 22:02:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=M2PCFvKq9JWcIC4Exd9oDYO0v0PQOHyXRap+yEgbOb4=; b=MD+4HyR+p+eWmldPWs5vX95T33
	iXBYGCZ+MwXl93jmScwEtHnjqAb/iv4VkkG7dH9gw2VhSyJfO1itxmgKDJQrJ51F+8TJUx5ZYC7rA
	UutJ/ebMnp8Xvc9h5bSDqZJrpBAhdBdMxF5cjzKpuLz5AiRNyBFIIRfIdx/WV8xhgP/sZ68CLcGd1
	YcUBpbb8G5CCjmew64dnyu/nn6mm2VXpTkfa86A9XsS0zJosC/o1NMF9/EVdt8FiuvWK0zKH7LTOK
	8hBZzQC6LPBnGbV5759afskeQWXyMxtGYH72LO0RT30TXfR6DI+7yrs/7R4eTtKcrEEJDW+UND7wi
	ZlUQm8oA==;
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poVxD-00HSSZ-0w;
	Mon, 17 Apr 2023 21:00:05 +0000
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-32ad8ca1e69so11883525ab.3;
        Mon, 17 Apr 2023 14:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681765199; x=1684357199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2PCFvKq9JWcIC4Exd9oDYO0v0PQOHyXRap+yEgbOb4=;
        b=DfDlPpudX++HgzZ5kNwnoUVk8DomOavOP+600QZKCbyrI2h042rZ0aSVeOQ+Lf5CwG
         EoXN560+AyEwOD5chaExWKrZ69kHi7hzDKxY1d399B9hhUjOT9lVDRkmITTjHzPrzkfO
         KaKO6BxdOVywwHToaG58B+NZEOVM74ildi6nu15iyMztZGSn+XakcdldcZ1O3P6lZEt3
         3j5t3b5dhmzwUWRhcIifH5plRuG+JSBxT4W2D/1bUFQolJbQhosyQWKAlZ8yErjzAvYo
         +/6C8f3b5Ema8U/UwvRhtXi9Vd0siBd88XINCpwZA/v6JSBwqeYG0EY5gXlh13P1fznk
         RXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681765199; x=1684357199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2PCFvKq9JWcIC4Exd9oDYO0v0PQOHyXRap+yEgbOb4=;
        b=jg1hfxqIg4eqTGcBi3XES3KX0a/7OWy+wbfPzZnZE9MUatL3zvXx5M3Bv6bWNiTdS7
         FWXWvQIJc6xr3k3BgGH4++lIt/BLIOCHbL/xWTvGndpSrWwqxz0aDRKQywoDKucIPaTG
         p6gifhlLg0dL5exfEhgEXvhNOUtaVI5dr14FsQKEVsAcJkO3j3aShiH52+HvkCJWEhK4
         DNmXNANDtp6SCVtjJ1NebK1q5LdU443CjijYIuz6ZYebWc6PT6Hp0vEextCCpkXFV+Vj
         ywD7FrSQhzgzrgQzUphsgPcZW33UBmgKerfCNJpD6TTXcyTH4YHXYuoNfaLskPLHcUdb
         lR5g==
X-Gm-Message-State: AAQBX9e1rF80DwJNtyyp/SGG+Txgxo3+jlgJRVf7J9fQZQ+nAOchXvc5
	IVjgJqw+pgLyCqk9mFFO11h7n+rCF1isMg==
X-Google-Smtp-Source: AKy350ZH2s2lfJdxSYj+T2S9Ef0UoYzkgLYY3eeGq1S7Q2hAbd0lFGX52BFTYQkOd2khPVGSck6LXA==
X-Received: by 2002:a17:90a:e28f:b0:247:4200:7432 with SMTP id d15-20020a17090ae28f00b0024742007432mr11696070pjz.40.1681764802858;
        Mon, 17 Apr 2023 13:53:22 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:53:22 -0700 (PDT)
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
Subject: [PATCH 27/33] openrisc: Convert __pte_free_tlb() to use ptdescs
Date: Mon, 17 Apr 2023 13:50:42 -0700
Message-Id: <20230417205048.15870-28-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_220003_858416_CBAE502F 
X-CRM114-Status: UNSURE (   9.17  )
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
