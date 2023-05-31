Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7162AC77B7A
	for <linux-um@archiver.kernel.org>; Wed, 31 May 2023 22:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lMMVTAKj3AkBVKK9gC+WAOGvYKfxrzIH97uSZlPB+Wg=; b=rnJEZcoYzzhyDg
	Hsv0ytRdssrcfI6eSZPzcgZ/sU5Dnh/yg3exFhH2NVYg7dWCXIiqcB7y3S2rnqFt0IUop+UwThcEs
	4Me6npXFbUAacFaCBpxQVt2mZ0CredLCU0XcRPNAko90RqXSzAJxKUmk3/q3lOA4XXgHXplq616Sf
	LscQj9TD1KvG2358tsAGvVz8VjvoNkowtrh4VIt+QcGDUZi4g/uMqsxkbXhTyQFQNW6ztx1TOafWa
	meSEwa1iI72XcKRx7sCj6xR8Hxuw3cw/O+AGisecnx7KiZqbTisLVTvXNb9i2ByVst7dDprJGP0VY
	5wXKgxZVeiS23w2g0OFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4UWa-001LxA-2i;
	Wed, 31 May 2023 22:42:36 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4UWY-001Luv-0S;
	Wed, 31 May 2023 22:42:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=27lyfpZ04FD2UDRY/I33l74zvzgaqoXO3tIGNjTPBPg=; b=mbhvq4bE+06axOU1mjpKw2SslU
	iFgH4sYQP0bjfQhTBXr7uwBp3iBl0Pqw/7a2UhjHwyZOkqeDGbrBUZTVSD+pp/qaNs+UvMKIb7OEv
	R+NzxC0ndTtrBUcoNAfhCDP+Il7ovV5E8MqZfRr7JPZ7dpEXiN3QkCffZ6n+A+3RG5rSRDVeldZcP
	O6REQFmDpetGB7ugpKcJR63A4i4HdpZsmIuyVjCjMJYYwjaAt5REWPPFQUTGvduPOXN/mPcKq2zyp
	JtaFVqTme36/L1yXgR4Yugn21Ll5c3OkiircsNSGX54R49aLameYJo+IBDQtqVjLbcrpD+KBkxzPS
	09q6+YoA==;
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4TPm-00FdKQ-1R;
	Wed, 31 May 2023 21:31:43 +0000
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-565cd2fc9acso950627b3.0;
        Wed, 31 May 2023 14:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568683; x=1688160683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27lyfpZ04FD2UDRY/I33l74zvzgaqoXO3tIGNjTPBPg=;
        b=ekb2h5vYZpG+cwgCVg4fQK7EHYCXZwnN3tICBhvbAXV/qaJ4duvuh8+ArMRtJnIp/1
         3RGo21yGJSysDJalslm0N3KJ+xBemufNmCM4QUS+AlLps3g1asXmgD446fAwgWFlRe+6
         a7aoyacEmBOwDL/dieiMjv/UIxc7tBtkwjPRg8HdgpDriWcSnd2JpyypDy8aN9IwIMR1
         dAM+p/G53wM0julinDJp886bQVRAOW6SvsbsPDW7Xp4BxlToFfeY++p5U7tcCmWgdlyl
         aRBYNbpeHC4ndh8fG8DxUBYpHsoQ7lFfl1tkv5LwqehXHAbOBlEVGGEVzchpWOIR1fN9
         uokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568683; x=1688160683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27lyfpZ04FD2UDRY/I33l74zvzgaqoXO3tIGNjTPBPg=;
        b=fKDRUmbZGg3+8jVSWkQu2+lUvWMBUcpFNa2na1j5JA+Vn5trw64N/hllT+kdU+n8F6
         4CK9fh649nz6pTE2qMrE85VhYs0igyqtdF/c/2lD9s3vDlvcL1DK+degtM6kIm1ibiXL
         CHFZbrszCkWQkSM8g95dHOFDa4XLXCvYFEiA0IP2K2M3qptpGL2K+CtjtzfAkaULu1YI
         hJ07Qx50lIsV1c18p8SpJBfA2LFSGIeAED3fhLyH6LFrrkxOcn5Qp3mt3SVfI+mTXHil
         Quaw0KdfLoXHpvuvVPYlt0cEsiwyqvpBWJzJisGVPUilzljDjE+fWFqiw0l3IX+YU25g
         bQEw==
X-Gm-Message-State: AC+VfDwAB/SVX9H6l/42Q1J50LPxhx0VEDGCka+i0Mr/C78M6InMepB4
	0+KWgxNyNdwk/HXJXutrdeQ=
X-Google-Smtp-Source: ACHHUZ6dr8MPeM7AL/jHaXXQ52piABkpCgdGqBTW+dyh+LgB10RRsXu3Y1HlJGFoY/78HDuWSu9FGg==
X-Received: by 2002:a0d:d741:0:b0:565:dff1:d1e2 with SMTP id z62-20020a0dd741000000b00565dff1d1e2mr7923571ywd.18.1685568683472;
        Wed, 31 May 2023 14:31:23 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:31:23 -0700 (PDT)
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
Subject: [PATCH v3 07/34] mm: Convert ptlock_alloc() to use ptdescs
Date: Wed, 31 May 2023 14:30:05 -0700
Message-Id: <20230531213032.25338-8-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_223132_158408_0D50B389 
X-CRM114-Status: GOOD (  12.26  )
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
index 3a9c40e90dd7..1fd16ac96036 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2806,7 +2806,7 @@ static inline void pagetable_clear(void *x)
 #if USE_SPLIT_PTE_PTLOCKS
 #if ALLOC_SPLIT_PTLOCKS
 void __init ptlock_cache_init(void);
-extern bool ptlock_alloc(struct page *page);
+bool ptlock_alloc(struct ptdesc *ptdesc);
 extern void ptlock_free(struct page *page);
 
 static inline spinlock_t *ptlock_ptr(struct page *page)
@@ -2818,7 +2818,7 @@ static inline void ptlock_cache_init(void)
 {
 }
 
-static inline bool ptlock_alloc(struct page *page)
+static inline bool ptlock_alloc(struct ptdesc *ptdesc)
 {
 	return true;
 }
@@ -2848,7 +2848,7 @@ static inline bool ptlock_init(struct page *page)
 	 * slab code uses page->slab_cache, which share storage with page->ptl.
 	 */
 	VM_BUG_ON_PAGE(*(unsigned long *)&page->ptl, page);
-	if (!ptlock_alloc(page))
+	if (!ptlock_alloc(page_ptdesc(page)))
 		return false;
 	spin_lock_init(ptlock_ptr(page));
 	return true;
diff --git a/mm/memory.c b/mm/memory.c
index 8358f3b853f2..8d37dd302f2f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5938,14 +5938,14 @@ void __init ptlock_cache_init(void)
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
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
