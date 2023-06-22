Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7A0EB64DA
	for <linux-um@archiver.kernel.org>; Thu, 22 Jun 2023 21:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Q9YK12Nsx6ujQfndJjchy/U9wYLDzQsH9o5g0eiiEws=; b=XqOhEtbLbgGWYS
	vozw1mKdZo1nidw75zK7SCE0LPjnDxjS72l/QbLXDzw9D0hHu3xaPBP5YnQsdLwwdmLRVe/u/To6g
	piW+Q7W9TObOnaoomMNK1OqzqQ3Af7NzsJYznyzqqHl7gKCccce2QOGgE8bW2Has63poJtm+3RWdD
	mQ79LFLI3BCbomflhsfcYkw3nT4mBAyiHO9A7CnXdD/rk+/pX7Rn0SvtlaHs73B6F73dyp2V3cawX
	6AKp1GoKtOjkISGQLWGeO/v9G/gchxcxZRzpx4z46WKOap0qdWab1qr9K1JNIBuTN/shIgyjcw3Wg
	r2oKqqXcMpFft9HZu/vQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCRQf-001kjR-1I;
	Thu, 22 Jun 2023 21:01:21 +0000
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCRO4-001i8s-2X;
	Thu, 22 Jun 2023 20:58:43 +0000
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-76547539718so3438685a.2;
        Thu, 22 Jun 2023 13:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687467519; x=1690059519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CuYJ7liBLmFxtlpmCAIL/qtog0vkZLk1dVk72P32nA=;
        b=BLHldLJJqXLpr8GAfoHi79v0sph0w6vN/SuJg9rBXjFWP7vHx2aGmaKx+f9hTGSIek
         StBGUDmlBLLgONen/ouQl25e+2Oh56rCFDCpMgFUEQOkNNTjcxLzf4Qpme/gK6EBGlEV
         uCg8bxuRbLrdLb22VpaeGfLLJwjdPeKaXRkjf+OAYYySwTDsQSI3SAbqeNXGAGljALee
         fcpdhclAhH7b5XES0gNbsvIBabKOZu9Ga/PYBeMD7nv08Dx2WAP2VJoEQ2QraVWTFN45
         Wt/gJDKXfFk6SzeY9rfcZjQwBqyFukcCgFCguNA0XxXJLEGG2f88pPraJdoTC9IQG6ul
         Gb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687467519; x=1690059519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CuYJ7liBLmFxtlpmCAIL/qtog0vkZLk1dVk72P32nA=;
        b=V6ENXU47idwf9FqtdOiLas7OqnTz7zRVa1YiqPlYevsNsb+8VpPUk3xxDBX/58IGLE
         PkVk5YOZ8SG/X+wECQrDa+niSRBxqZan6X1v/eLeoQNCwWN1R6IHYyIpiK7jADdZHbiH
         dOhckCastGcFCc703dOfxrVn8JODvpICjtWM3P+Eiy7uxZfDFH5Xy3TgQi8qVJEGhPM5
         LOjXmQOmK7Y4M4PIQ0xZXScWSelIxFaDFh9SJAmWD3Dc7IOts6UVzexKxhJVb23mGhXv
         L6FRMIR6i/u0/8BJj1krEaVor2d8mj/C31RcT8ApaMqw7thIsuVrJJYd2v49HKFnhhln
         UllA==
X-Gm-Message-State: AC+VfDwWJfw38BpPcMuPAj8eKJwYa/4Oft1yOkCVG3kIE4Tx3N2V7pDX
	KmFnAeDCvUj6BORNoAmn98ty/9AtpzLxew==
X-Google-Smtp-Source: ACHHUZ4KRcOpBQjT0rqr9douhR2m3+ahnRE2h5Kbx3P/xMpW7X3b4hHm7K0gMXBTqIp4OFz3bRB+Jw==
X-Received: by 2002:a05:620a:2cc1:b0:763:d981:d0a0 with SMTP id tc1-20020a05620a2cc100b00763d981d0a0mr4781474qkn.38.1687467519407;
        Thu, 22 Jun 2023 13:58:39 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::36])
        by smtp.googlemail.com with ESMTPSA id d18-20020a5b0c52000000b00bc501a1b062sm1684937ybr.42.2023.06.22.13.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 13:58:39 -0700 (PDT)
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
	Arnd Bergmann <arnd@arndb.de>,
	Guo Ren <guoren@kernel.org>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v5 21/33] csky: Convert __pte_free_tlb() to use ptdescs
Date: Thu, 22 Jun 2023 13:57:33 -0700
Message-Id: <20230622205745.79707-22-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622205745.79707-1-vishal.moola@gmail.com>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230622_135840_869559_F7C138E7 
X-CRM114-Status: GOOD (  10.86  )
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
Acked-by: Guo Ren <guoren@kernel.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/csky/include/asm/pgalloc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
index 7d57e5da0914..9c84c9012e53 100644
--- a/arch/csky/include/asm/pgalloc.h
+++ b/arch/csky/include/asm/pgalloc.h
@@ -63,8 +63,8 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 
 #define __pte_free_tlb(tlb, pte, address)		\
 do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page(tlb, pte);			\
+	pagetable_pte_dtor(page_ptdesc(pte));		\
+	tlb_remove_page_ptdesc(tlb, page_ptdesc(pte));	\
 } while (0)
 
 extern void pagetable_init(void);
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
