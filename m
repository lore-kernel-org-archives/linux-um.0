Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0116C001DE
	for <linux-um@archiver.kernel.org>; Mon,  7 Aug 2023 23:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GfyNUnHFwm/7cLQjFcLNiTMjTP/ToqbNI98f1WfvEMU=; b=pQY81snKeC8egJ
	KQFcLIWO6xPFYZPcCIEE1Qq0d+b2Su5kTkIK5JhwrfkQc14ig30i4IjT0/2IkWxdLEUDdV6eKs/JE
	eOt7p87zvCKJ+3S1Dwlypa5AdrWRLnLL3QQHAGdbfxcIumrkPBJ1krzjfEJ0XnO/lzEl8oSJAJqQr
	0QZAqGoBpwO39pEkXAc2swazIUZXgIWc+aPMLMpi9yT2oEOxs7hFEbaGBqHGs7IclcOQD0xEGC+Im
	suhafw2EbNnIOI1W3jQWE/hZvmGs2CZb45UbMKI3UzCHSDvD9D0+hwuIJ5h+wAUofdG+tglxZUBzt
	TJgDvd+bup1qr2AP0gdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9I2-0014VV-32;
	Mon, 07 Aug 2023 23:05:30 +0000
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9Hv-0014Nv-2A;
	Mon, 07 Aug 2023 23:05:25 +0000
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d45caf42d73so3390117276.2;
        Mon, 07 Aug 2023 16:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691449520; x=1692054320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fjhesd7+rMkDZLOr6Kc4cG8956dLxCQQb+ozfQX3UQ=;
        b=OAmqT2YppB9CjfKzA6MbkbWQuHnOV3YDebJzEzMnvrYaEBnGvyiGDdIgN+UFddYCO/
         oWD9ALjnIUimu69EOXrUSOl0V3EQ3lBA7Y1MYmMc666cwORz5NLJr1mYNrQUbkaEMEWb
         UevlkxC+fhWM5pG0rXCbCmrqQYjTZk13aOAK39qUeW68Z9nV/2KJzWOSzi4xEeDeVL48
         AtQrP4AvQ44B2EZwMOx7Ik4iUJ1TvzBS0XzBfxhLsaCN0UqBFIO7A8RIwj+QqN3o+IuJ
         Kl4ISRZis5dwTBUexOURKgSzbeO3folaxRuVtH/QGDwOd5SIJ+mmY1APEfvTznAxJRIC
         w6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449520; x=1692054320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fjhesd7+rMkDZLOr6Kc4cG8956dLxCQQb+ozfQX3UQ=;
        b=D0HFApmWCRXewhkdOtiI17t/R1ggSIBwZNuelmPxGsu2tYvIm68wzHNMExMSStj4DI
         Qb1yNXUCmLWl8MHAIFhT7p2A58rlsZq61rHh6BgDaIVHQL5nV73Dma+oMpuFLs9c61Xh
         Mk/zlya4zTbPJ47P/iwAWkbWh5YT5x3q+Lh8yF5aohUDxGtAFlNNtHYRVl5o3F9DdeO+
         lwQ8YdCSdsJpWv1udfRPJEQE5yJfqQi/dGr7FXSst2Eik/dmHikC3W58AF9/UUiaO3Sc
         ubInJQvc/SOorJKGtTwItPL4jTzSE3HFn6nX+3RkNYVhNYaZ7+r5adfjkN+83BC5Co1m
         ybbA==
X-Gm-Message-State: AOJu0Yy4Xpf4EFowoxBnSPPLM/cDzLyOU6531wy+9rbiYFt0kL9I5krK
	nb2r//+yvqRNTnYMjRHofMY=
X-Google-Smtp-Source: AGHT+IEx2gi8PNow/7jZZuthXFdwcQBm4qVvrwXdHrr7o3CRr4bjoCnJoA9HiZN+Tg0Khw5JdZ/TIA==
X-Received: by 2002:a25:6088:0:b0:d2c:32cb:c631 with SMTP id u130-20020a256088000000b00d2c32cbc631mr5682581ybb.27.1691449520366;
        Mon, 07 Aug 2023 16:05:20 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id d190-20020a25cdc7000000b00d3596aca5bcsm2545203ybf.34.2023.08.07.16.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 16:05:20 -0700 (PDT)
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
Subject: [PATCH mm-unstable v9 01/31] mm: Add PAGE_TYPE_OP folio functions
Date: Mon,  7 Aug 2023 16:04:43 -0700
Message-Id: <20230807230513.102486-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807230513.102486-1-vishal.moola@gmail.com>
References: <20230807230513.102486-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_160523_731246_7B8CB315 
X-CRM114-Status: GOOD (  10.52  )
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

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
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
