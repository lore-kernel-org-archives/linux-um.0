Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2763FC77B78
	for <linux-um@archiver.kernel.org>; Mon, 17 Apr 2023 22:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=e3GbtwNkOG2JavcqUkO730QrCuPAjP1Tl0M3WXn46HY=; b=aU/GuwuwaH/X17
	0pD4uIA+XlX4MPbbWEl70XBRj7zGXWlw1IpiHdLrzrka6c9FxMTR6AVCwJO4dcTuobUVgunB9TZV7
	9Xo3u3hdn9yz35DLprBKxGlVI8xhObLUfn1ZXSIDDfLhrIP8Vxh4aa8lebe4iSUmcLTwLCZcj5Kzu
	CcXnrI9hVQnkX4+pNDvh6RQgWVQzzF2jUknplZV0q1OfFiq1rMcB6f9JfO6Rm+ekWngr8EAny5go1
	jtQtGsTsJHMYMCi8ebp65XcxHMmg8iXfAnnx+lX5d8JZSIxJC3/AJL/RCdKnUnHUm4QN2ZVyHSKaG
	NPy5P/cyl4S6CEXdj2Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poWtf-000CHN-2E;
	Mon, 17 Apr 2023 22:00:27 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poVqP-00Ha1W-2h;
	Mon, 17 Apr 2023 20:53:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=seoMdP0S43tB5tHiAJsyEn/McuL6oTkl/wxfiJ8zej0=; b=eAGDHn/PIvCMAbe9ms55PjUopH
	uO9z5NAnd/Vp3BbmOPrVxM28Krp0mF3nuvZAT3nBTSPYOf56PQuG+ikjSdevlhnV1u6Nv9rhu1Yfn
	sse9XfSBNk9K6BYdqLr1MRv+/W4t3gswsgcMZh4Pw0aV28AkZaF7V4LmH/4o5yRvd0Cwv5ehdk0Xi
	pzhIalIWCL+VDo/wity8iI54K10+lpeUzlEf0vHOiIHHtmY6LFbk6ooWqNc7Qq7hVU85QI//zX0Da
	Sm98ZwSBvfcfG61nVZxgRyGQyth+/ckN7y75Q2hCXDdmP/3ziE4G326okBHBMP0cUqgPHoCfZE7lk
	dpdn9wRA==;
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1poVqL-00BfmA-Sc; Mon, 17 Apr 2023 20:53:00 +0000
Received: by mail-pj1-x102f.google.com with SMTP id z11-20020a17090abd8b00b0024721c47ceaso14039503pjr.3;
        Mon, 17 Apr 2023 13:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764774; x=1684356774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seoMdP0S43tB5tHiAJsyEn/McuL6oTkl/wxfiJ8zej0=;
        b=m9/ZIcz+Tqctc8DsupfPgmRFjJ+xGEJ5QFcDJn618MR0YPogH6sfzkHf8JHJze9cJp
         x5NQYQBUB4f261Rif3c3u/e/lVyrkb7fkfJolfOwhFk6XOwO7D63t/TQQqs9S95k9Ae8
         FKQXzDTaphWXYOHY2MRQP+XNQ8wh3L+YHkBgztA18oGJHjweyg/A/nWWIx5QMqDpAEPB
         X0wu3GkIqgBlm9RuBmiAr6UEFrV7LCwD9Gy8HkrUbR2REAIxrVGyinkjPCtpi11n6vo5
         ARCTsKi2jOZHutSbPq4tlksgdP3OAZq4N0EqMo6MlYwn+u6KLBtMzuBeO5yqTZEreTX6
         9o+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764774; x=1684356774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=seoMdP0S43tB5tHiAJsyEn/McuL6oTkl/wxfiJ8zej0=;
        b=X+PVWvVrtfGqgbwVD7vboxcLrI6cMbKqEGaQHtMmgfVAC5UMuCMsTRkqmkYo2MfoPf
         0zn9mWapR5h3LxaPE2F5ZulZh6jt/b/n7elXkj33bFotJUDmFKXXLtnrmesVXqauM3yk
         +6XqaUUXilPkxdmuJKQ48T60PKxKPDhlVTS1QrlIoZXdkteEVnWZtfYVVFLvC8RgySLb
         wOCaGUytiez0QfTnCM8CkugbNN6YULbKiRHSVbLKR+rRHquZd9FkAV0jbkcoS0Ogdc3M
         s7wwyutMackyXbRGVE0ZbYT8sAOxit+AVraSRyC1QSDuq6cmHzXE3FoEL+GL3laGtcMN
         23dQ==
X-Gm-Message-State: AAQBX9d2aN0kPO8tIEnjc8uo+UqaQL8nV6eaL/Ldam5kh/gxEPQwjCkt
	UTOfMYRlkAltMOSoG5oRfj0=
X-Google-Smtp-Source: AKy350aUejw0DeO6puoaXC3R5n6x3DzcxqacgAq+Qj51dxkW8glMsrCpGOXbLfdvjTORWF+TApg9qw==
X-Received: by 2002:a05:6a20:b21:b0:eb:8d47:332a with SMTP id x33-20020a056a200b2100b000eb8d47332amr14024065pzf.36.1681764773709;
        Mon, 17 Apr 2023 13:52:53 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:52:53 -0700 (PDT)
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
Subject: [PATCH 06/33] mm: Convert ptlock_alloc() to use ptdescs
Date: Mon, 17 Apr 2023 13:50:21 -0700
Message-Id: <20230417205048.15870-7-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_215257_990244_1D8E6632 
X-CRM114-Status: GOOD (  10.73  )
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

This removes some direct accesses to struct page, working towards
splitting out struct ptdesc from struct page.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm.h | 6 +++---
 mm/memory.c        | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 069187e84e35..17dc6e37ea03 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2786,7 +2786,7 @@ static inline void ptdesc_clear(void *x)
 #if USE_SPLIT_PTE_PTLOCKS
 #if ALLOC_SPLIT_PTLOCKS
 void __init ptlock_cache_init(void);
-extern bool ptlock_alloc(struct page *page);
+bool ptlock_alloc(struct ptdesc *ptdesc);
 extern void ptlock_free(struct page *page);
 
 static inline spinlock_t *ptlock_ptr(struct page *page)
@@ -2798,7 +2798,7 @@ static inline void ptlock_cache_init(void)
 {
 }
 
-static inline bool ptlock_alloc(struct page *page)
+static inline bool ptlock_alloc(struct ptdesc *ptdesc)
 {
 	return true;
 }
@@ -2828,7 +2828,7 @@ static inline bool ptlock_init(struct page *page)
 	 * slab code uses page->slab_cache, which share storage with page->ptl.
 	 */
 	VM_BUG_ON_PAGE(*(unsigned long *)&page->ptl, page);
-	if (!ptlock_alloc(page))
+	if (!ptlock_alloc(page_ptdesc(page)))
 		return false;
 	spin_lock_init(ptlock_ptr(page));
 	return true;
diff --git a/mm/memory.c b/mm/memory.c
index d4d7df041b6f..37d408ac1b8d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5926,14 +5926,14 @@ void __init ptlock_cache_init(void)
 			SLAB_PANIC, NULL);
 }
 
-bool ptlock_alloc(struct page *page)
+bool ptlock_alloc(struct ptdesc *ptdesc)
 {
 	spinlock_t *ptl;
 
 	ptl = kmem_cache_alloc(page_ptl_cachep, GFP_KERNEL);
 	if (!ptl)
 		return false;
-	page->ptl = ptl;
+	ptdesc->ptl = ptl;
 	return true;
 }
 
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
