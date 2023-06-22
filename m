Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50905EB64DA
	for <linux-um@archiver.kernel.org>; Thu, 22 Jun 2023 20:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7ll/b7RdM8ZO09s46n7XRTOjlf8S9fqCqdu34KLkXzI=; b=mWfWXLUOR3RB5J
	4oiE67UFCPpoR1WLmtS45jDOMkLuuvxi5FG1eqiQIs8pmJSn3CCQ5rWz3Vwb1nW9lFeCoRsRBlqgk
	i+PoOuI5u8Qf2SPUoARjN2TA1a4kLoYpQbMX4IbWTtjYfUZiQpl0RiiSNrYQZwH4iTxPrIx8nx+FJ
	qfx2x/li/gm9u88EYHb2JRURjE4oji6H/5LotG5J1L236H5AKCuUzKE8djMB+kaqu+/HLWF3h2j1w
	YkYnbNQpjXpKL0vdml8OTKh0fxUSC7KFehUjb1RN0PP/4bzmVuIxYMlXq/+1RvFeNde5s/DwHUERV
	BqVBb3hYHfoNKu0fI40Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCRNb-001hgB-2l;
	Thu, 22 Jun 2023 20:58:11 +0000
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCRNP-001hUt-2c;
	Thu, 22 Jun 2023 20:58:02 +0000
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-570114e1feaso85138087b3.3;
        Thu, 22 Jun 2023 13:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687467478; x=1690059478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXYENedStYVsFXpaqy8X3+wmlabVR1q8JHyD5+dxFj0=;
        b=oWqJsihW3Mww2gXtWCx6NN1vPsnSmScA0KqTPfHOB2L1LHk/oZiCduo6ehbRGsj3u1
         3K4TZcf4ipLxkr2vI99P6IIjGRev7x1HMuDNE81bxWMzhRU6uyioFzTZTsBBM3X8iluN
         tBK6Y8stl1G/1qCE5N0GQ3Qa+8Pmm+N03Nm44USTvnLt7V5LvALEjdohUoDqU7kxuZLt
         IgowLw0bUJXUmFP7v8RMzC0EWbABefmvZCJB+fh5ayxmmTYy0RtnueLq29qEPJSsxOpa
         bu8Ei1mTrJukofeSyNP/F3QTQ4sGlZhg7IWdEGo85alo6ycJggU6oX8hiEo/eX8VwR76
         IyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687467478; x=1690059478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXYENedStYVsFXpaqy8X3+wmlabVR1q8JHyD5+dxFj0=;
        b=YRya3L5unngWuogqjzbDZTyIVqncGm/NaMXB4X8nN2F3dXluHftx+CKdUrc9FdDk0x
         zNiU6qhee/7rmjbj/8qe5pXT+9UyR2QfNAtDJrEtfP/BQqUeqMnfLPk2YCyEGdIeQdpr
         5ruXf+bOQWMmWTOKiYq7niNQTNYxocSIp2TXSAMlk4ReTxYcGeu1OzK5xy73+K4NyVpO
         h4YSBXKBaXZ/e9RNqQANkzHgFlmRePY+KT5EkyEMFKlkNt7B1AQcgUYpwpgDP/fSWNuZ
         kUziMkcoJV23hgz70mU2732UuFI2FBEtAfUa/ni9KiR008mqjmzm4Heol5lXaO8cUGlW
         SDeA==
X-Gm-Message-State: AC+VfDwhUEYyguC7FSSNjnTFtPh4TUY9he/D74vg0Ml5AuvqB7AzMMiQ
	YJfAe9JVPUmg6BSyW7SeNLo=
X-Google-Smtp-Source: ACHHUZ6Iv2PzBVPKZ2hNXXGWhZAWkMVnsSNpndVsfJ1BDlCBJeA25OFgV2XyKC6amBhVDhSuupua4g==
X-Received: by 2002:a25:2fce:0:b0:bac:2a78:aaa7 with SMTP id v197-20020a252fce000000b00bac2a78aaa7mr16148309ybv.54.1687467478063;
        Thu, 22 Jun 2023 13:57:58 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::36])
        by smtp.googlemail.com with ESMTPSA id d18-20020a5b0c52000000b00bc501a1b062sm1684937ybr.42.2023.06.22.13.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 13:57:57 -0700 (PDT)
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
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v5 01/33] mm: Add PAGE_TYPE_OP folio functions
Date: Thu, 22 Jun 2023 13:57:13 -0700
Message-Id: <20230622205745.79707-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622205745.79707-1-vishal.moola@gmail.com>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230622_135759_854573_63F0EAA6 
X-CRM114-Status: GOOD (  10.37  )
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
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/page-flags.h | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 92a2063a0a23..9218028caf33 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -908,6 +908,8 @@ static inline bool is_page_hwpoison(struct page *page)
 
 #define PageType(page, flag)						\
 	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
+#define folio_test_type(folio, flag)					\
+	((folio->page.page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
 
 static inline int page_type_has_type(unsigned int page_type)
 {
@@ -919,27 +921,41 @@ static inline int page_has_type(struct page *page)
 	return page_type_has_type(page->page_type);
 }
 
-#define PAGE_TYPE_OPS(uname, lname)					\
-static __always_inline int Page##uname(struct page *page)		\
+#define PAGE_TYPE_OPS(uname, lname, fname)				\
+static __always_inline int Page##uname(const struct page *page)		\
 {									\
 	return PageType(page, PG_##lname);				\
 }									\
+static __always_inline int folio_test_##fname(const struct folio *folio)\
+{									\
+	return folio_test_type(folio, PG_##lname);			\
+}									\
 static __always_inline void __SetPage##uname(struct page *page)		\
 {									\
 	VM_BUG_ON_PAGE(!PageType(page, 0), page);			\
 	page->page_type &= ~PG_##lname;					\
 }									\
+static __always_inline void __folio_set_##fname(struct folio *folio)	\
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
+static __always_inline void __folio_clear_##fname(struct folio *folio)	\
+{									\
+	VM_BUG_ON_FOLIO(!folio_test_##fname(folio), folio);		\
+	folio->page.page_type |= PG_##lname;				\
+}									\
 
 /*
  * PageBuddy() indicates that the page is free and in the buddy system
  * (see mm/page_alloc.c).
  */
-PAGE_TYPE_OPS(Buddy, buddy)
+PAGE_TYPE_OPS(Buddy, buddy, buddy)
 
 /*
  * PageOffline() indicates that the page is logically offline although the
@@ -963,7 +979,7 @@ PAGE_TYPE_OPS(Buddy, buddy)
  * pages should check PageOffline() and synchronize with such drivers using
  * page_offline_freeze()/page_offline_thaw().
  */
-PAGE_TYPE_OPS(Offline, offline)
+PAGE_TYPE_OPS(Offline, offline, offline)
 
 extern void page_offline_freeze(void);
 extern void page_offline_thaw(void);
@@ -973,12 +989,12 @@ extern void page_offline_end(void);
 /*
  * Marks pages in use as page tables.
  */
-PAGE_TYPE_OPS(Table, table)
+PAGE_TYPE_OPS(Table, table, pgtable)
 
 /*
  * Marks guardpages used with debug_pagealloc.
  */
-PAGE_TYPE_OPS(Guard, guard)
+PAGE_TYPE_OPS(Guard, guard, guard)
 
 extern bool is_free_buddy_page(struct page *page);
 
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
