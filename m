Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CAEC04FE0
	for <linux-um@archiver.kernel.org>; Mon, 31 Jul 2023 17:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rE/AuJkwTDv5MQTWX7K8TPV1mOu+3EFvcb8c3CDflXs=; b=uqNWoJA9pHr35V
	ENRM2VoCb15z3MI+tZgJmh3SdMgnePLPkrNnPkWeOTKLCBrCZ4RiudZJJWep3ETKOXaSLg4Jr2lWt
	KBebeP8oUiA5gCUcz2JNpv/jfAnw/3B4qIXIJpjdHLkNn9MpwjHGgCEXXPXJI9ASz+mFAVSjqD37v
	7hKvFvIvQZbOZu1vTLNCou0/0uPnJQuMQeLE5ngnMb8qShnymNE5gk0h2NLWjc4I2qi5rqHX8WT9/
	00CoEQJZ0BuANxbpjghmOuy5drwVcy3Jnhlrp1kvWeTP+y+PmL/pZjP+CWcHHs/4yw1F5oo+1+C6F
	F2ZmHBZQiwoaQJ0S88fA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWJn-00Gkcl-1Q;
	Mon, 31 Jul 2023 17:04:27 +0000
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWJA-00GjzC-2K;
	Mon, 31 Jul 2023 17:03:51 +0000
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-3492e8fb906so568295ab.3;
        Mon, 31 Jul 2023 10:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690823026; x=1691427826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUMUqbW/uAIHfn0G4toP3JCuPKsaNgXF+JjYaBSaBaw=;
        b=LO7IgtMfV7D/5pieeNhzhX7jbefImFR1TuQgjSMNALZjO7jWhqLJ0NYlGohhp9vNEp
         P7qjRmM9tu3EiZV8IpnwyOsR5oR0G2xN8+6lkb99Xp3Pq2LKGQ1pnDBT3xTub9FDUFeD
         NiuludkMelWGqpPq5Si9scPBohunGQ7wjCbjn1MG6IHkoKqu0G6KIfhUmk1zbCODarzf
         JF+LluYmZmW6+nXXKHPD8kZWEQzzXdWA4gTgt31gpJPirIvHnT+QXlpNT9xuTR/Ob7I2
         6KYVvpK8cyw965ouTwB0qJzxRQ+l2kkvuwks4w7hfsZgPcLfFUXNyqFPQAdsNQn7UH4p
         LAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690823026; x=1691427826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IUMUqbW/uAIHfn0G4toP3JCuPKsaNgXF+JjYaBSaBaw=;
        b=SfMzd3quCUETFcAOXjKvHmsjw1RDsNSyZGWQoH9oQdians0CTWiwsHmsuWTn5RO5CK
         VZ4wQO0sPp/LaTnJ7TjdWgM3cNxXDwqaZmvxuLlmLfKP+7nHsR0Z3IoFwwQPbDiyby2d
         lVidzZqfHDXnDuqj7Iv5fv6HTyrAnCof6g0MNbGWnsSWeUF0mWpXWF8Ky7oW4YUZZ8D8
         314by0uT8QcD/GhamP/5gAXBANZrzYDpkBnlWhIWT/5jQQMUCE0XyBgdfNFH3TKOJoZ6
         RjRuQkw675KwcBr5PrQAJb4J5XyvkLojgqLo8MBCRqK43sMKGkRORMc9qdRrD4UcCYxb
         xjHw==
X-Gm-Message-State: ABy/qLZz5/SHFxZEARtCHT/x3yEUisTCJObIxLld5Pm8/dQK2T6jZoZS
	3LdVI3CQIW0C2dSdFlOaRmcclh0k2Y2QMg==
X-Google-Smtp-Source: APBJJlEWqZXE1sICWadhT2wO43hXTa2FHUgzTzYXN3XbSpmzVLjVyMFNIil8bQaSo4X4bLn1gewpKQ==
X-Received: by 2002:a05:6e02:924:b0:349:2498:ed90 with SMTP id o4-20020a056e02092400b003492498ed90mr1956382ilt.30.1690823025849;
        Mon, 31 Jul 2023 10:03:45 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id x31-20020a25ac9f000000b00c832ad2e2eesm2511833ybi.60.2023.07.31.10.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 10:03:45 -0700 (PDT)
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
Subject: [PATCH mm-unstable v8 04/31] mm: Convert pmd_pgtable_page() callers to use pmd_ptdesc()
Date: Mon, 31 Jul 2023 10:03:05 -0700
Message-Id: <20230731170332.69404-5-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731170332.69404-1-vishal.moola@gmail.com>
References: <20230731170332.69404-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_100348_787549_8C85B22F 
X-CRM114-Status: GOOD (  10.98  )
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

Converts internal pmd_pgtable_page() callers to use pmd_ptdesc(). This
removes some direct accesses to struct page, working towards splitting
out struct ptdesc from struct page.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/mm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3fda0ad41cf2..bf552a106e4a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2971,7 +2971,7 @@ static inline struct ptdesc *pmd_ptdesc(pmd_t *pmd)
 
 static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 {
-	return ptlock_ptr(pmd_pgtable_page(pmd));
+	return ptlock_ptr(ptdesc_page(pmd_ptdesc(pmd)));
 }
 
 static inline bool pmd_ptlock_init(struct page *page)
@@ -2990,7 +2990,7 @@ static inline void pmd_ptlock_free(struct page *page)
 	ptlock_free(page);
 }
 
-#define pmd_huge_pte(mm, pmd) (pmd_pgtable_page(pmd)->pmd_huge_pte)
+#define pmd_huge_pte(mm, pmd) (pmd_ptdesc(pmd)->pmd_huge_pte)
 
 #else
 
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
