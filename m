Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDEFC77B7A
	for <linux-um@archiver.kernel.org>; Wed, 31 May 2023 22:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iMwNam3XuLi7oWTqdHmx9aVbPXFwsMkeSd+3M+aLe3I=; b=ay76k5X3Oz34NG
	qeEvZ1czAt+DKqVXg5pVnsXSrB7agLm4eJgTYatp0nW8Q9Nib9MWwnHudxEStWQlm3jphrUBlzzQ3
	akJCTeaGXtvLy0mPNssIvxU6oZ5kbNOM0cdBQGhVKchFvVvvSSu/ct+mGF+Z83B6TOBZhTbkv30M9
	J5o3sOqSjHkWw0HnI1B6ojGgvdRnfVSIGTUQ184zKydkE+0146Z684V3UJddtS9xWyPoR7sXcEO1K
	bDnnrxjqbXSDFW9xzNoG7Kqgg4E05QgbRsODopF0VM1WkndmcXtRSuBRiEjCBX0TPBbwtNWfR0Hks
	dXaMdNCOX86Kw+bcodTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4UX8-001MKm-2l;
	Wed, 31 May 2023 22:43:10 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4UWd-001LyV-15;
	Wed, 31 May 2023 22:42:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=TzKQXlz5IDfPvgDKTOeCKkz+dXM61NoKgwUhpTupiUw=; b=nYlBIhKoBKeNGaBFCQ2zsePZxF
	TIFWJX63OFyd7y+V88AX49HJVhYkFMTstkM+QKEQClFWF3m/LT3sxblMqAM6UTzMyRC0vf1eFBUdU
	GevY/VlB8S/n0vcCR9gfFCcWg843Vlc52vnIi4tePU3sNm2QcIsWT1dCPuQAMm1jEPheivpmo6MRd
	byVp2o6a3aoh+mYXjpxQipWQ6sdZQxgfljWebP+qndCA7PAKNYPzOGxzCeUK0CFsl+2bVAxKKXaYC
	g7u2ORW9omc9WcsbGnED0JHyWMXkIKcbyKAvPEUswGi6R+WaPoIt7nok5dRrQTFQGIL03GE2G3WpV
	83LWmFKw==;
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4TPm-00FdKd-16;
	Wed, 31 May 2023 21:31:34 +0000
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-568af2f6454so860227b3.1;
        Wed, 31 May 2023 14:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568685; x=1688160685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzKQXlz5IDfPvgDKTOeCKkz+dXM61NoKgwUhpTupiUw=;
        b=hIfmjb5X06SZ3BaD9NYBS6hgA+ayAquIKaVHr2BHnLBOPZKQ/J4ZAsHZVuEaw1F1C0
         DLhGZpjTZZFs02UVgouMcVD7Om43dfavrY/9B0xqLArccnIFv4HyErh7ebqkxAVmYpAt
         c44ATu4lPRNkYKf1axyVO8gXjPrDMUnXOwNjgt4KrmrL4IpwwDNTjXfR8pLFfm5hWJH3
         A3an9It/QF6RuKMl0LJM9Di6sd8T8h9NIoEvAXZjtMgMuUIFQhhIMF5orERUADpDZzUC
         JdcxeDPS4ad7hb6jzXYz7QYZfeE2bjaq1vVtDaxxKS7PVXsoR09l6Ff83vLOpPnhM1WL
         QcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568685; x=1688160685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TzKQXlz5IDfPvgDKTOeCKkz+dXM61NoKgwUhpTupiUw=;
        b=BewIjAFC3e6tz2jaw52oLfHUsoUYUF9aLovhhBO7s3RLGdOTXQ4+hFXqlzJgZNEU5S
         XGCj6q4IhYXv3vymXYAHkwsy2ltJNablrKpnF6IfWqEQVZ7rwK4CJAc9fPz2l48otpjn
         eX+CW0VeIYBNGQxTqIrh+NHzDqqRFcGasc2sTMDwFHISf9ytZq02a5S+jvSEe3zMoxpI
         2QCF48JIgjbU0kuPZFhpVjYXf/yIkTZ0ZiXWB/sqaealOO3FRNYec32AXIMyrMeAYdpN
         tQgKYBxqKCualPp/xtshztG0UF2ffqwIr6SK0vwfjzTLX7o3jxrjoVSg8aKtt6HBqTh/
         YpbA==
X-Gm-Message-State: AC+VfDyblH47I/8PJJDgZWPe4u1Jnp+CygcwNtmC9MQNUHREPBQMOjKF
	of9gzrfnAdp97ZZAEKonPho=
X-Google-Smtp-Source: ACHHUZ4penqUBoef5VZ7RS39HNNXGjV3amJwKYqX+6tsdiojUfn+sW0Rg5ayNGX0C78Cc9bsT/rYzg==
X-Received: by 2002:a81:a113:0:b0:54f:752e:9e60 with SMTP id y19-20020a81a113000000b0054f752e9e60mr6993857ywg.37.1685568685351;
        Wed, 31 May 2023 14:31:25 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:31:25 -0700 (PDT)
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
Subject: [PATCH v3 08/34] mm: Convert ptlock_ptr() to use ptdescs
Date: Wed, 31 May 2023 14:30:06 -0700
Message-Id: <20230531213032.25338-9-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_223132_010180_9E0091C9 
X-CRM114-Status: GOOD (  11.99  )
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
 arch/x86/xen/mmu_pv.c |  2 +-
 include/linux/mm.h    | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index b3b8d289b9ab..f469862e3ef4 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -651,7 +651,7 @@ static spinlock_t *xen_pte_lock(struct page *page, struct mm_struct *mm)
 	spinlock_t *ptl = NULL;
 
 #if USE_SPLIT_PTE_PTLOCKS
-	ptl = ptlock_ptr(page);
+	ptl = ptlock_ptr(page_ptdesc(page));
 	spin_lock_nest_lock(ptl, &mm->page_table_lock);
 #endif
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1fd16ac96036..6f7263fcd821 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2809,9 +2809,9 @@ void __init ptlock_cache_init(void);
 bool ptlock_alloc(struct ptdesc *ptdesc);
 extern void ptlock_free(struct page *page);
 
-static inline spinlock_t *ptlock_ptr(struct page *page)
+static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
 {
-	return page->ptl;
+	return ptdesc->ptl;
 }
 #else /* ALLOC_SPLIT_PTLOCKS */
 static inline void ptlock_cache_init(void)
@@ -2827,15 +2827,15 @@ static inline void ptlock_free(struct page *page)
 {
 }
 
-static inline spinlock_t *ptlock_ptr(struct page *page)
+static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
 {
-	return &page->ptl;
+	return &ptdesc->ptl;
 }
 #endif /* ALLOC_SPLIT_PTLOCKS */
 
 static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 {
-	return ptlock_ptr(pmd_page(*pmd));
+	return ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
 }
 
 static inline bool ptlock_init(struct page *page)
@@ -2850,7 +2850,7 @@ static inline bool ptlock_init(struct page *page)
 	VM_BUG_ON_PAGE(*(unsigned long *)&page->ptl, page);
 	if (!ptlock_alloc(page_ptdesc(page)))
 		return false;
-	spin_lock_init(ptlock_ptr(page));
+	spin_lock_init(ptlock_ptr(page_ptdesc(page)));
 	return true;
 }
 
@@ -2920,7 +2920,7 @@ static inline struct ptdesc *pmd_ptdesc(pmd_t *pmd)
 
 static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 {
-	return ptlock_ptr(ptdesc_page(pmd_ptdesc(pmd)));
+	return ptlock_ptr(pmd_ptdesc(pmd));
 }
 
 static inline bool pmd_ptlock_init(struct page *page)
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
