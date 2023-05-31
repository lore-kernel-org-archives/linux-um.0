Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB45BC7EE23
	for <linux-um@archiver.kernel.org>; Wed, 31 May 2023 22:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lVNfS77E6AqYF8239Sq9NIYPBBvpi2B3E3/1sMAzJP0=; b=y3i4FvwIxT06Pl
	94REl8QNyUbw/QXfAjR7EfUPFt1qZUhv6nO3c4X5C1/0kvoo7K9sLGvzAjFJjnCZfOLnrsDwT9HMz
	70sTUm7hw0MJvlMX+QxP763R+2qkA5XuAIXeFzEIH5UfekLUTqgFDSPmpMXRcveknpF/cYRsxRvLi
	qwz8k1EpEbF5TCn+SjHQdlN5r6x+1E4MEtoKJG5SUIOYpANsNSQbJFzylr9fdoE7eVABbiVBXWoWR
	sn9+ZcjnDMkZ3Vkm22FxFUbhXX3cxliIFUgM7H+XvxLNKF7riDWZv+EHZyHUZw4n7jCaMNLoSZELT
	aIKTBIE3o48ENkKqMb9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4UUL-001L7E-2n;
	Wed, 31 May 2023 22:40:17 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4UUJ-001L64-1L;
	Wed, 31 May 2023 22:40:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=twP3X2a+WodLh3389MnIMBhN0jbH10mGEhh4PvePsM0=; b=fNazAsdt1g4WZblEmVAtPfHS0P
	f/RyjrEJM84P11YoFaUiVzIaqMHoUw09VPz/DImLLgpltQBT1+oUHNZFVtdckw6jBLqEsQK5iuo5q
	dM1CTa3kaU1Yr5FvNaCDfV5vmNHx1JC+ihz3p34rQD5JNSHjyZPLJ1skyzbqKbKHfaykjqLXKDhq+
	V41/3gMBWP5/fLV67RVzFRDHWsorn2FuclQTYhmXZMgfFc2BEZzx2TIKCr405pGuyyddlTV8b3iBp
	wsCiBK8wOBIDdVK8QVf0qiAx8dScgslifBcOuBLY318RjKRXZtfAZdMzhDmcPXELiCCY8FIKtpAto
	7gtWjxJQ==;
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4TQA-00FdQL-1F;
	Wed, 31 May 2023 21:32:08 +0000
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-565bdae581eso790537b3.2;
        Wed, 31 May 2023 14:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568713; x=1688160713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twP3X2a+WodLh3389MnIMBhN0jbH10mGEhh4PvePsM0=;
        b=PfN/YuXqEhOYfWlhCizTVYhB0yTtEnGBcp1Rf+NGxnIYb5NMfNjpOJp7si8Gqd9u2Z
         fVUf7A/NR+jmOjDUmFOcEU9lVtXwdNmW/KajF2dl5HDRHfmf/W944R+zyeedwYfvy537
         14PZNj7A3uugHcuLzifkUVqBMDywmdqymi8GehMXhWnbSeCktA8GuayP2Gw4BIeku+KV
         EWgr5cqL7Y75WorTm+eBQ331vxvi6DIr56AVXpyFUK5xmnNLyeer0KWpXh+3ggToS823
         Egfk0bra3X4pY1o6khSRW89GKMQyeeVJx3oX9CNStxK0FHLZpfrALdAzG2hgMTcdbX0M
         +9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568713; x=1688160713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twP3X2a+WodLh3389MnIMBhN0jbH10mGEhh4PvePsM0=;
        b=d9ewWTdEuPG9OJemyh/jfNlbgRDGoIKb4E9cuZm3ngwLm0rDTxWLILTrw/Lz8qaCUc
         jfvPaLI5Ksi0ZortTGSY3Ky3WHj5UXuq2CAQLh2nx1QpB2TfIN/AcpC6QFkwJxKXiu5i
         JZ5MbQMZ9q7KHT+OpzF2KfsUZB4faRN7kdFS2pidnaz+yoqDZWwqu6za3/Lx4wr/s+cH
         VBDIpi7otRi01CQpkzPdGeoEShorTazNOKqgGwoJ/Sc4pxuHfcjrA4Rv55VdKQvsy0xb
         9HqmQrCNsml/7pNOUS8aWeaKVGT3PoTnj15yTjBVaKz1xSZ02+p84B3aVnFxWVW9g8PH
         9KAw==
X-Gm-Message-State: AC+VfDxdPPhnvhftJb5KgwWBOxu5PNR2eJNe//OHaNdaU7YZmCAdb/MX
	gTmkkxS82MX67DHslmINMjI=
X-Google-Smtp-Source: ACHHUZ7FD6AVojP8YF17yPS22sW4VLLKSMzYdsUMVLL7wG9gS5evh1bJZ6trRixkrytBmJNTyQ8JCA==
X-Received: by 2002:a0d:d684:0:b0:566:386b:75fc with SMTP id y126-20020a0dd684000000b00566386b75fcmr7598602ywd.18.1685568712866;
        Wed, 31 May 2023 14:31:52 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:31:52 -0700 (PDT)
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
Subject: [PATCH v3 22/34] csky: Convert __pte_free_tlb() to use ptdescs
Date: Wed, 31 May 2023 14:30:20 -0700
Message-Id: <20230531213032.25338-23-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_223157_848020_0DCF117B 
X-CRM114-Status: GOOD (  11.33  )
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
