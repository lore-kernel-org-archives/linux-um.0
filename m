Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FC0C7EE23
	for <linux-um@archiver.kernel.org>; Wed, 31 May 2023 22:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tLvUz69cbjuj26Kga4Fm8Y5FrEFIUaTw6p7D8Rf1KqA=; b=BiAsRRwTM/2swb
	i8Jum6uPJ4RySisPYJH87vkxwuEaAbhuZDNYGU4VNYmR59KCfj4a9IkPAJ7CoXLvX9IuZauVedldS
	7eXrGS8ssQpkPdorcA8eM/OFeFDD+892Afk8ps4gbHStvB4MsbG66la/lL9ldskzfTrTplPemrBw2
	7mnTaOh5lc8Eh0nRREfRiJthDeo+XhnoyvGIh9jw9dOnbvsngd4XXzmh/LK3k/6WE3PwThGyPEizA
	ZSGftPBC9d1bV29ike25ECRTf2tyUGnm0hD/ED1NqTLDFgiDT0S8supOM+JXMGw/gTdC6Loln0MUW
	3rnyPD7vKqCQHsKZWFnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4UZV-001NjD-0A;
	Wed, 31 May 2023 22:45:37 +0000
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4TPV-001A1m-2Z;
	Wed, 31 May 2023 21:31:15 +0000
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-565c3aa9e82so781287b3.2;
        Wed, 31 May 2023 14:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568671; x=1688160671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bX969DJmm0QSNKJIBN0sjsA5M6jg25Ht5D0PDUGbnFg=;
        b=P7FbSxrmAPv3mGtl9KCze7nT8iCFSFWQSZd60mX+cJFZkb27WYcyDR38HUvSUNwOfA
         WyleVMjeIqtLEEwRc2YnbZ7txjSr2kC1Bu6eSjk/V4zQ7iY1ikjarw2unChyDBFaqyHl
         qrkXBVTcGnA2v9yMUpvE/svfRz2vIL9d0Nbx7Bw2sQnHGn9MhsASWeYBsHvbspQGObju
         1ipMDLV38bpj6HIH1n6AHSjFxILtRbDR5cBiuIg4YWigaXfk1Rbe6tGcUyluemp1MpHz
         Go7YaG8Vo7KSrA3KfxzMvgw5BO+v7vQIsvpOcy7enjsShHfHLHc+oYi1vHe+rSK3PBLh
         b6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568671; x=1688160671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bX969DJmm0QSNKJIBN0sjsA5M6jg25Ht5D0PDUGbnFg=;
        b=MmlhL1Y51UcL4wNBgjEu7BiOIw0x6G14rWc8ACLnFpD9a1YNhxeGqrD4m5Z4vzVlwx
         WKI0vYYS7xapd8k8/kqe6YZ437ySiZAmmIgea+doVXZZISavq7uIqHsl2qaeF1SlWQTk
         o5rVguiHekGiyoq/nK+GuZ6q+X43oD1eTIGai25syeEzCC69usMwTvSpt3kt+9bhNXHx
         lUOX3sQqobqfAGhvHEzlG9bcfIZUXJOzG/dNxePAX+eKit7fLWUiu9mgqCLYvjSnfLmH
         GN7cCfhnjabw7M4idwkJEgaOm0XhWmYYVgeRyxYjF978vrRIwUG7CtoegP8fNqrAdxlL
         XeuA==
X-Gm-Message-State: AC+VfDyEgKQs5x8U/6EULS94z8saGaDXcH65mVre5ar2bVbe/sTJdSPj
	wKAkHvoaZ4UhxsJ9iG4X/9I=
X-Google-Smtp-Source: ACHHUZ49VjuEJEQYDlxCOib/9Ri8bRDKMaFSJKO9JbdYMtejkSn38dasbkcATHh4yJ4tcm7dGKQETg==
X-Received: by 2002:a0d:e7c3:0:b0:565:a081:a925 with SMTP id q186-20020a0de7c3000000b00565a081a925mr7102903ywe.29.1685568671501;
        Wed, 31 May 2023 14:31:11 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:31:11 -0700 (PDT)
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
Subject: [PATCH v3 01/34] mm: Add PAGE_TYPE_OP folio functions
Date: Wed, 31 May 2023 14:29:59 -0700
Message-Id: <20230531213032.25338-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_143113_834181_770DB8A8 
X-CRM114-Status: GOOD (  11.00  )
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

No folio equivalents for page type operations have been defined, so
define them for later folio conversions.

Also changes the Page##uname macros to take in const struct page* since
we only read the memory here.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/page-flags.h | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 92a2063a0a23..e99a616b9bcd 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -908,6 +908,8 @@ static inline bool is_page_hwpoison(struct page *page)
 
 #define PageType(page, flag)						\
 	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
+#define folio_test_type(folio, flag)					\
+	((folio->page.page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
 
 static inline int page_type_has_type(unsigned int page_type)
 {
@@ -920,20 +922,34 @@ static inline int page_has_type(struct page *page)
 }
 
 #define PAGE_TYPE_OPS(uname, lname)					\
-static __always_inline int Page##uname(struct page *page)		\
+static __always_inline int Page##uname(const struct page *page)		\
 {									\
 	return PageType(page, PG_##lname);				\
 }									\
+static __always_inline int folio_test_##lname(const struct folio *folio)\
+{									\
+	return folio_test_type(folio, PG_##lname);			\
+}									\
 static __always_inline void __SetPage##uname(struct page *page)		\
 {									\
 	VM_BUG_ON_PAGE(!PageType(page, 0), page);			\
 	page->page_type &= ~PG_##lname;					\
 }									\
+static __always_inline void __folio_set_##lname(struct folio *folio)	\
+{									\
+	VM_BUG_ON_FOLIO(!folio_test_type(folio, 0), folio);		\
+	folio->page.page_type &= ~PG_##lname;				\
+}									\
 static __always_inline void __ClearPage##uname(struct page *page)	\
 {									\
 	VM_BUG_ON_PAGE(!Page##uname(page), page);			\
 	page->page_type |= PG_##lname;					\
-}
+}									\
+static __always_inline void __folio_clear_##lname(struct folio *folio)	\
+{									\
+	VM_BUG_ON_FOLIO(!folio_test_##lname(folio), folio);		\
+	folio->page.page_type |= PG_##lname;				\
+}									\
 
 /*
  * PageBuddy() indicates that the page is free and in the buddy system
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
