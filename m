Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5E3EB64DD
	for <linux-um@archiver.kernel.org>; Thu, 22 Jun 2023 21:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rd6SzqbgPmQ9JRJb99PrMGl+xaEon9qjBqwDoSTvyOo=; b=oH3h8UeiJLmLh7
	dNqY5WRD4Ycsd/SUsA0QcTRJ65Owf7OzmRnXBvUEpxLX49cwQ3+uZ9GX5kqxnDdzjdAPopV9PolUp
	IShaX5WaiqbUruN/P2rJr61m3n839dWnitg+rqM/Gu8BV2VFKw9Si6Y5RtgibGuSkbQEQgGDP3W3s
	AUU9UXDcwVoaAPsNh8kDbkTYefIlgTugDegOeRyvsUn6jxEU5SiBljZj/GoyvRb4VaL0DoC1qaE5U
	xgmfjG+DMOYOJQdTrQMO5EWfDAC2iL7Purx/nLrh4CHnJk7TAm46/jCgqbkIi5498qHM7zADOnc/O
	Kb/1kpGxXfhw9mp+DEOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCRRF-001lIq-1S;
	Thu, 22 Jun 2023 21:01:57 +0000
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCROF-001iKi-08;
	Thu, 22 Jun 2023 20:58:52 +0000
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-7653bd3ff2fso79938685a.3;
        Thu, 22 Jun 2023 13:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687467530; x=1690059530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSsj72OOim1moFehILf4IJ+e4eXIj/xtfG6kDsakLCY=;
        b=F65orfGp6lPWpCrD9sAMHQjbb/7dPkBeEZwnbqaqoaG+jHKHFKOpyv5U+mRswUePBl
         O+w6mgJQE0929R7HfQnempO9NwPEm6qT8tc34OERTuMiOZXiohUbt3LRN+VbVJEKUKkc
         tcmSj8t+FV4PGg1S/0RDnwUBY8C4sUVvlY/c/d4jqvMe/jl29yqPCuiM1limtTye3/Mt
         Xl+0XJrX90O7Fe0pzMoOa3o991eJyDuyXmsTPhqv2ERTFkUraPYZpwk4UgntXrYBzy7x
         tG0gCzAga9PV8hPLOnhqVRtX7sCVqxvHBH7A5BvtHK+faRxZPp8TVFIuHWDaefij0y+Q
         y3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687467530; x=1690059530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSsj72OOim1moFehILf4IJ+e4eXIj/xtfG6kDsakLCY=;
        b=fgcs/e5b1ZLw63+AeVwmxOtmAp6aqrpQHHHa6YKf+8wd6xEEVJddzBJmOPOLtPNhRS
         Hw4uQSPqbDUvF4PhoWpCZu7g45lzfSH5u2Zjk6zH93Bo2IlPUDalJEoWWTbLChOCm8bq
         zfxhA/zMdB9JWD/wQhGZGghpG6MSo0T6Ik5tlAnqPWFn/Prw2LO8THK6c4wDAGSbocg0
         7Y5k9qK2rWqBpNA1hEEwINNkpWhCk9cFRTMHA1IIhXXMmra0OLYjaFCxaNxZe94t9oz3
         jukG8jWDCNnxE6BBKamXVE001lsIqCttlryZNZhfv5fL+kEOWV9xjRKwg7SSb0UtugLv
         jLAg==
X-Gm-Message-State: AC+VfDxWoZ8tCzup7QWnT0mFci8FAHQYBb5hCGFsDdmoWzlNTdnJAjxj
	3Mbhh8Bb3v+TVtW5BzThW/M=
X-Google-Smtp-Source: ACHHUZ7lI8iuHKQsEsdck4SAEFHmt9QQs6haysqfy7wOJRfjq9Goxv7w27b3gm3WMVCksX2Z3AB04Q==
X-Received: by 2002:a05:620a:84c:b0:762:883a:f5a6 with SMTP id u12-20020a05620a084c00b00762883af5a6mr11201137qku.41.1687467529856;
        Thu, 22 Jun 2023 13:58:49 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::36])
        by smtp.googlemail.com with ESMTPSA id d18-20020a5b0c52000000b00bc501a1b062sm1684937ybr.42.2023.06.22.13.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 13:58:49 -0700 (PDT)
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
	Dinh Nguyen <dinguyen@kernel.org>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v5 26/33] nios2: Convert __pte_free_tlb() to use ptdescs
Date: Thu, 22 Jun 2023 13:57:38 -0700
Message-Id: <20230622205745.79707-27-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622205745.79707-1-vishal.moola@gmail.com>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230622_135851_154935_F076A907 
X-CRM114-Status: GOOD (  10.46  )
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
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/nios2/include/asm/pgalloc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/nios2/include/asm/pgalloc.h b/arch/nios2/include/asm/pgalloc.h
index ecd1657bb2ce..ce6bb8e74271 100644
--- a/arch/nios2/include/asm/pgalloc.h
+++ b/arch/nios2/include/asm/pgalloc.h
@@ -28,10 +28,10 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 
-#define __pte_free_tlb(tlb, pte, addr)				\
-	do {							\
-		pgtable_pte_page_dtor(pte);			\
-		tlb_remove_page((tlb), (pte));			\
+#define __pte_free_tlb(tlb, pte, addr)					\
+	do {								\
+		pagetable_pte_dtor(page_ptdesc(pte));			\
+		tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 	} while (0)
 
 #endif /* _ASM_NIOS2_PGALLOC_H */
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
