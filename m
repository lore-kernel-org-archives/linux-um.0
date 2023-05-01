Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912A0C77B7C
	for <linux-um@archiver.kernel.org>; Mon,  1 May 2023 20:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=renTDN7coSpOlYEz9cWp2cHtvXLuZY+XpV0aBc9hOG4=; b=kPH+TsS0urKKdp
	I9uBOTQMlPXjslob/l0/VDQp8Y9XscAXceZORismWpDzR7yoTnbgP7NlDAguFNPGHhP/12Uezcr9L
	LVhN+9TZhiyxFpokvEgbPPDa2H++VHH0ZIR83PRiGSQJngPteUTUGYxyHYlGCQtNo2734T773S+t6
	y38MqrAxExX/y8qMPo+zVyLVll2GPoiADIfOt0C0C0FqbZlufaMaDIP1LQL0e5fMBfGyHfaF+4ko5
	RCpC8WRcLBBgn2pq2lZGe+vQpMmBWcZAqcQSJKjRhqQFAb9S+Hv3WvRIYruEi9gkQPPdDThbXqRlo
	vFy68CNWcihz+zIKC1hQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptaK4-00Gu4i-0e;
	Mon, 01 May 2023 20:40:36 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptaK0-00Gu2N-2S;
	Mon, 01 May 2023 20:40:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Qr6GrFg3nf2tpOD8Orpodgx1J1bZoReYY/j4MOttH8M=; b=eHhIo9WoVbDnEuY1SnnFDlV2uq
	QZswqhqJW25/28evZhl2DQnoU5Lb0xEwp3XC4dkF1oIK6qG0FRV9bQlW7BakoWne6+h7Rt5o13HLU
	PvjmOg92HXK42ELa8/hQvJqrx77AVaI3JTk7pW96ieRjNrSEi7Fz1CCd6Eomp99pnKVnsXLaDgKoC
	/eFnm8q38wpIAnk0fdDSAg3agDxzELz329YjfAbq9eLovAUYrsOVdehZGNjVvMpEggoFvDYRZLXQr
	C/TaAY/JidvcEX49oFZFNTjsRyScDKS8gCR8CxJzJA3uuZI9yZS5SOz8+3wojlmbZ4bLeiCshtn+Z
	QZkpnDhg==;
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZCo-00Ez0V-0a;
	Mon, 01 May 2023 19:29:06 +0000
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63b51fd2972so1993273b3a.3;
        Mon, 01 May 2023 12:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969327; x=1685561327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qr6GrFg3nf2tpOD8Orpodgx1J1bZoReYY/j4MOttH8M=;
        b=UIGt4Rxs2HkrsHutpAYaiWsjpykN6YUUd9E7lUyM0xl9pxC5slr+PivAMCf0kJWRtN
         +uixoPZwp4Vkl4YHEUToQjjzNjvIathQteky2ye14eE7NbHDFgUdPJKRNVXQAhEugOmA
         SnKo0+DWLOVbHHUZvAiFOaLnHaj2/1PYZhJmFGNiABpmjR+0nby25eJKrDAKj84VfLsp
         mCPKXur9uRrX02YRe2GBv91KFh4j6FQNTVZMtFBm8+b26dYihW/DQX+FZ7CAta9Gp4QP
         rZEIiymi83HRxeSWeuBi69l3Fo9OQWMSSxYcww0ZzqBAzl9SsUUSi153JEf/pt3dBwk3
         OFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969327; x=1685561327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qr6GrFg3nf2tpOD8Orpodgx1J1bZoReYY/j4MOttH8M=;
        b=LKHS8yfKeDzgEtBI5T2jU3uqgQn2rmEKj2B8LUjL4R5sG3lOmkgWmy/MM5JOmBIWG2
         zwBW47mGM872/vgnE3h1e/tvNcckGDS/6PQGFdNctkpGsjdRJ58dXYmeL00CqBW7n1C2
         x+iCw/Ewyj7xemrGKuY4+E/Uewhv5mZ435ja3INLKDVmUJiX8QCForcd0ainTtd4DDT9
         muEf/mZaWQmQUdhBzEshhWOdfOFP6fxMEgcdw2sdMhMJzaRlGxhHYIxPz1gRPBe3e75u
         SghxTzbpQ1mrB1JW/phEkP4wo+W38hR1HMW0eNDGY/vbUYfwUY7hNyfFqoQRanGnV+pn
         WBIQ==
X-Gm-Message-State: AC+VfDy9uWE393lcDkRVnF2LLOF6aXs36iJMXnsGJIo0zWs2uxVAm90f
	TOxblBErxsCL8V7bQzU2j70=
X-Google-Smtp-Source: ACHHUZ7U6exPykPvKxCgekHmX9KTHTAx49eIcN0vG+aTw+3qX+uTyRXMYpekTZ9RZqGTjPxZ9ZewtA==
X-Received: by 2002:a17:902:ecca:b0:1a6:4127:857 with SMTP id a10-20020a170902ecca00b001a641270857mr17426348plh.5.1682969326811;
        Mon, 01 May 2023 12:28:46 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:28:46 -0700 (PDT)
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
Subject: [PATCH v2 09/34] mm: Convert pmd_ptlock_init() to use ptdescs
Date: Mon,  1 May 2023 12:28:04 -0700
Message-Id: <20230501192829.17086-10-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501192829.17086-1-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_202902_853334_55571ECB 
X-CRM114-Status: GOOD (  10.47  )
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
 include/linux/mm.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 49fdc1199bd4..044c9f874b47 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2903,12 +2903,12 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return ptlock_ptr(pmd_ptdesc(pmd));
 }
 
-static inline bool pmd_ptlock_init(struct page *page)
+static inline bool pmd_ptlock_init(struct ptdesc *ptdesc)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	page->pmd_huge_pte = NULL;
+	ptdesc->pmd_huge_pte = NULL;
 #endif
-	return ptlock_init(page);
+	return ptlock_init(ptdesc_page(ptdesc));
 }
 
 static inline void pmd_ptlock_free(struct page *page)
@@ -2928,7 +2928,7 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return &mm->page_table_lock;
 }
 
-static inline bool pmd_ptlock_init(struct page *page) { return true; }
+static inline bool pmd_ptlock_init(struct ptdesc *ptdesc) { return true; }
 static inline void pmd_ptlock_free(struct page *page) {}
 
 #define pmd_huge_pte(mm, pmd) ((mm)->pmd_huge_pte)
@@ -2944,7 +2944,7 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
 
 static inline bool pgtable_pmd_page_ctor(struct page *page)
 {
-	if (!pmd_ptlock_init(page))
+	if (!pmd_ptlock_init(page_ptdesc(page)))
 		return false;
 	__SetPageTable(page);
 	inc_lruvec_page_state(page, NR_PAGETABLE);
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
