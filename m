Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C42C7EE2E
	for <linux-um@archiver.kernel.org>; Mon, 12 Jun 2023 21:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oC94pQ/Xeh8fNrIt/hqOXoo5oHReu23YSQ733SGLXb0=; b=tcrdVghR+8/Pcr
	30+uzvsgvR6KKNSw/d9G7h5pHahuyYwGf8Hl7dP5v5oOGRcMGIdpzKTZ7aZiR287dDTsAyK/Pw8Uw
	10N0ihcA4XdSckIHcv+txeqKN1qwoyzSz92MuxbOxyMvYU+IV0Tvk1Z8HXFQofh5gmA36zQo21aNv
	AB13Ws9W/I4OhDQC41o2TQ2wj6mKk7op3dxmicluIFnOmI9VnFROpnFuK3PnMAJyWUrSopunymaWX
	k1oEi1/p6qBuGOiUj20dkhW5W4gvoI9Y5+UUdiAqZ0yur3cVt4Er5wuN4Srn5jdOEPxtZNXqkBjix
	ARRif4uQgyQBtZaS90Tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8pZu-005cHj-04;
	Mon, 12 Jun 2023 21:59:58 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8pZr-005cGA-0S;
	Mon, 12 Jun 2023 21:59:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=CVa9cggtOHSUJO/ogR1wMW2sjtZWNjmDdrC369SVqz0=; b=FrztOtAX17oXVKoIldzRQa/Dvh
	ORNDIsYrkXIOQ6gl+PNmUxa9t/lXe6Jo9/9WW4VHm0VbvfFPnNibyrrgWVvcKNq2jg6UIM+Cc2Ddl
	Twj5LNvY8myo+ODnf1k8wHFG982CxxN4BFBmRy+CkogdlCPMT5VlGarX5RHa5G2CmTTlg/sxjeW72
	YfAdIo5awfYLMmnV3J+rd1BP5LJ+KGPLXIjit8ymNSnEIBzEYPSlRcbd+RREpLyCpCTGdlgGGOIyZ
	ajh5aXlGQRhVpu+StQ742Pxt+SjzWu5YMyYcJnzatDLZZQqq7wUbRiuEkGjlMMe2i7EKsH6wX+q2D
	0HpMJSGg==;
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8oir-0090bX-0e;
	Mon, 12 Jun 2023 21:05:20 +0000
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-56d5492850dso1959227b3.0;
        Mon, 12 Jun 2023 14:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603904; x=1689195904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVa9cggtOHSUJO/ogR1wMW2sjtZWNjmDdrC369SVqz0=;
        b=LGp0peHnuaxYbTi1TrslUjQMitjh+h/buXXjte+rmzMq8EerSk6fzj/9MIVxfmxSpM
         Omqu6nYebae8kl4QHV1G7ATHJ83nT9wNtbqIHtA4KnlPAvi/4+5X0WEOsthQhJoYwmhG
         x7qZZcT6GxEhvCZo0gV9yDh1XejrVy2crvGhXSgjUWCF1D9y073Dss7gKb2gKwKJeIqg
         gITOZuL6QQ3v0Ru0LyolXLQ7MXgbRP8zVbSmn+AuXiGssqL0cYBREi8V1ugxeRNuLvvw
         6oKvVZRZlVRzitWHyvf0O6G2XA5TATPVxsClJqIqIlKCoZg9JlGxlBuUR1XF5sExgOF1
         +mLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686603904; x=1689195904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVa9cggtOHSUJO/ogR1wMW2sjtZWNjmDdrC369SVqz0=;
        b=j1SC9CEmYARNlX11nMN2tKh2MrYEUp0jLgP0WxZMDExgV9psnVsI1yR9SICI0K6VSe
         p4GpAVRGM+x15UFmBwEgtCdmcQ+xezAYb3b7qoJbAm8p6/OB52TtLTkeNADZSll70N5E
         sAkG3UqPWNUlbW4QQzyo0/kKt46DvqjVxQXD3BVjCHhOn7jKgU+BAxLR7+n51igI1Ae5
         F4JZv39JNc3UKg7NWzohLItrs99lt9D5bqRHthCURx1ZIV1v400guCMMimrgimTWGQj+
         NKvuireTfEEPQ+swIHge7KBTtwQYISBWjDN1qWhCphk30OcWKP3uw+wmEakriFOUfQVc
         FUpQ==
X-Gm-Message-State: AC+VfDxVgsLLIC/YRqNLTZojqqlmfNV1N9gFx3bzyugM0zczBtT1IuG5
	1uoIWzsezMADP63C4VOFHgY=
X-Google-Smtp-Source: ACHHUZ4LesFNmga2zNafYd025bzkWSSIKRSwmwCXoFtNtSsfVvER7X6NaAl79hSVn0sQ3cUacFJw5w==
X-Received: by 2002:a0d:eb83:0:b0:56d:7c4:8be8 with SMTP id u125-20020a0deb83000000b0056d07c48be8mr6827241ywe.16.1686603904409;
        Mon, 12 Jun 2023 14:05:04 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s125-20020a817783000000b00569eb609458sm2757115ywc.81.2023.06.12.14.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:05:04 -0700 (PDT)
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
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v4 09/34] mm: Convert pmd_ptlock_init() to use ptdescs
Date: Mon, 12 Jun 2023 14:03:58 -0700
Message-Id: <20230612210423.18611-10-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612210423.18611-1-vishal.moola@gmail.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_220512_480587_34CBBD18 
X-CRM114-Status: GOOD (  10.19  )
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
index bb934d51390f..daecf1db6cf1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2942,12 +2942,12 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
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
@@ -2967,7 +2967,7 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return &mm->page_table_lock;
 }
 
-static inline bool pmd_ptlock_init(struct page *page) { return true; }
+static inline bool pmd_ptlock_init(struct ptdesc *ptdesc) { return true; }
 static inline void pmd_ptlock_free(struct page *page) {}
 
 #define pmd_huge_pte(mm, pmd) ((mm)->pmd_huge_pte)
@@ -2983,7 +2983,7 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
 
 static inline bool pgtable_pmd_page_ctor(struct page *page)
 {
-	if (!pmd_ptlock_init(page))
+	if (!pmd_ptlock_init(page_ptdesc(page)))
 		return false;
 	__SetPageTable(page);
 	inc_lruvec_page_state(page, NR_PAGETABLE);
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
