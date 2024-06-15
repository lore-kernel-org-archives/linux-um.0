Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3BDC27C4F
	for <linux-um@archiver.kernel.org>; Sat, 15 Jun 2024 03:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0EQi9HkpIlR+FQSo1SP2PNs7ehlOfZJYedHndU4kvKE=; b=v/hS2I+KtX7XSP9rDIiCtFEC2r
	bBX9cwk0YVbl82t8CAXqR9TQSd7c3cB67x+Fkxw50kj+BZP5rTCAA0snYmEFdyyOHD60OCE3EB+cu
	3RpeRMbuLuWDy8/7UosJmEnANsigLUtaEDs1FFhpmhJ7vugqaFpX9M34FM09e7ogRDiderYrie9TX
	ccKN85rZsFXtUQzIhrNgfOY3ye0AYpXU5sBccNfjvKgyslHiTW3HY8y1BOKI7Q1azxvv7clkp5Vgp
	Z+qXe1kanUsHLe9nvn6ns03eN4ItlFwWMnDlWhiFcmkxObLBk8ODBZdLcR7ChJeAeDqaq/0mO74JF
	dETIMSUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIKJE-00000004b2s-1qtx;
	Sat, 15 Jun 2024 03:42:32 +0000
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIKJA-00000004b26-3b7O
	for linux-um@lists.infradead.org;
	Sat, 15 Jun 2024 03:42:30 +0000
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-52bc27cfb14so3674050e87.0
        for <linux-um@lists.infradead.org>; Fri, 14 Jun 2024 20:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718422942; x=1719027742; darn=lists.infradead.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EQi9HkpIlR+FQSo1SP2PNs7ehlOfZJYedHndU4kvKE=;
        b=En+kPuhWw6jjhhqiNQxF7h73qLIla6+sgvMMVqaN2PK+eIH0tOl8FVYq8acM6PekjZ
         y1f0cS9UkM6tI9YuLzTjix1UYJuh3RrCz5fcNE3IcOl8dA16kB2bvVq4IBZ9mPC/rbhX
         9ojHRoPY1fseQteEVdLDCIgyp63QsnmR52dCiBeV+bNL5s3xAl41ytiSV4OiAugN8SPs
         qjaB5Sg5oiL10P+KxcKM7FUlzHtwt/jqBD99Dc74Qz6VEVamEoP5shmcGmmKNG8tKAhh
         39M/zD2Gg9Eb5XICDVpBCc7eVSmWy6Od4nG03G5OATiGurF5lMc4WNro5mx0KBSpwXdi
         UhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718422942; x=1719027742;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0EQi9HkpIlR+FQSo1SP2PNs7ehlOfZJYedHndU4kvKE=;
        b=FyXQVXF5T5VSV1cvNn+/Q3sLBMsagetCYFjgUWrY9E3GopNJRLxfaPaF7hmRbcQcC3
         RWWCBh5M5kSRsU+4qe2j+FohNnhT6JsU4wJun0cYVvr+bg4NAI60eGypYCfltG9U5mAc
         JvP32ZJ0TvSneoRWW7MwjEJbDfbAPI+hTbAvvjCXMIXbcnJoUlbtIJRsX1JdG7ooae9F
         VjbnadllhWLA+SROIwYx9p96kXd76rMmKvNHrTSy600dNSSrs1M8SgxL2fXxxZjhU99E
         O4V0RGVW1bY4zqffTxoCRSvF6Ut+4xYvwU3IV7VZS1fYFA1PfO3LVJRvfP74PhWQGr54
         TN/Q==
X-Gm-Message-State: AOJu0Yxdv94L9LAQLlLLh8w725TD3CG+pn6g+GgEL6+Iqs18nJw6tjbL
	TPABUFk9j8xJvxTKaWhWjePpRjP1Cw4+PRYGMJUyc6wquo7qMM5B
X-Google-Smtp-Source: AGHT+IFXbY2RAAO/9MtUrHF1RcQQWz5yTL6fDcPUXxIQ0TuCTPUX1N9PgGQcVraNcnTO3kwwmAgxtg==
X-Received: by 2002:a05:6512:39d1:b0:52c:8449:8f01 with SMTP id 2adb3069b0e04-52ca6e56eedmr4312613e87.12.1718422942115;
        Fri, 14 Jun 2024 20:42:22 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56da3f95sm248290166b.35.2024.06.14.20.42.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Jun 2024 20:42:21 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>,
	Jeff Dike <jdike@linux.intel.com>,
	Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>,
	Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH v2] um/mm: remove redundant assignment of max_low_pfn
Date: Sat, 15 Jun 2024 03:41:50 +0000
Message-Id: <20240615034150.2958-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_204228_925666_4DD96084 
X-CRM114-Status: GOOD (  13.55  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Current calculation of max_low_pfn is introduced in commit af84eab20891
("[PATCH] uml: fix LVM crash"). It is intended to set max_low_pfn to the
same value as max_pfn.

But I am not sure why the max_pfn is set to totalram_pages, which
represents the number of usable pages in system instead of an absolute
page frame number. (The change history stops there.)

While we have already calculate it in setup_physmem(), so not necessary
to do it again.

Also this would help changing totalram_pages accounting, since we plan
to move the accounting into __free_pages_core(). With this change,
totalram_pages may not represent the total usable pages at this point,
since some pages would be deferred initialized.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Jeff Dike <jdike@linux.intel.com>
Cc: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: Alasdair G Kergon <agk@redhat.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Mike Rapoport (IBM) <rppt@kernel.org>
CC: David Hildenbrand <david@redhat.com>

---
v2: remove redundant assignment of max_low_pfn
---
 arch/um/kernel/mem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index ca91accd64fc..a5b4fe2ad931 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -73,7 +73,6 @@ void __init mem_init(void)
 
 	/* this will put all low memory onto the freelists */
 	memblock_free_all();
-	max_low_pfn = totalram_pages();
 	max_pfn = max_low_pfn;
 	kmalloc_ok = 1;
 }
-- 
2.34.1


