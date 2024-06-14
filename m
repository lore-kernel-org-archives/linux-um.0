Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F2BC27C4F
	for <linux-um@archiver.kernel.org>; Fri, 14 Jun 2024 01:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=81aIsgobNOX9lGY3lQYPJwa0GXwQ1l53XgFLCaHxOCs=; b=OHaVuVu6IUs1P1F4hD780AuoMV
	XOWIIdqC1q07P3XlCHmpFzlNClkHqyvBx4lS0MsJuPDyvq6eNW6v9IK+mYVkthT+dKjJCo7zy4s/q
	EoSqI2EJCsh2VNp4vitWLngB27th0CEiGartZ8G0iLVUqRsvvbRDqo5ZMWMGaeM6c/CfKD3+5ec5P
	e5TNa4Py22qgt9DBm2gJVyXQYNMbdVBZH2BvRQHU6WtV6ZfSyFnwcdICXxD074HGusfv1HV9twxzm
	IVl9C6TVKz/Ef2yqETLaHNcwdwXr7mRoH3YReXz7/OyXtmwaGJlJ1+uAdMEcTRmtVh6EIDtjOarGT
	+BT2e+SQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHwDL-000000013cp-232x;
	Fri, 14 Jun 2024 01:58:51 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHwDI-000000013cI-3RHz
	for linux-um@lists.infradead.org;
	Fri, 14 Jun 2024 01:58:50 +0000
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a6266ffdba8so193714766b.1
        for <linux-um@lists.infradead.org>; Thu, 13 Jun 2024 18:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718330325; x=1718935125; darn=lists.infradead.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81aIsgobNOX9lGY3lQYPJwa0GXwQ1l53XgFLCaHxOCs=;
        b=Hn4V93mCSRHemQwRbieX/3R0rhpSLsaha3umXC0uD8qAQP5O7F/mQf/D48YqGC8qVj
         x2B62SZZp5tcmPqRZ9wzy1Eu0DqGghxmO2GWyk+pCqOyHlRdOLQmqRUwUg9f44JR2D0o
         m6U37YnpznaxLXXTh3n0SWnIh0Uc8SnzLHi7lA+nMXWdGYFscokCV0jEzt8wCIkAwYsB
         u4ZizqLiRYRVuCyTFNoq1x1bE/ZUoNeCxWTd1GpaySOY2IvPmPNeZR7kVNVWyVdMcn6F
         g7prFQv2ZsarKdFq/8FRACu7SUoTLxFD/RAtBqrHhDKBqVLRtBJj5cT1vu+Br9c59nCi
         FiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718330325; x=1718935125;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81aIsgobNOX9lGY3lQYPJwa0GXwQ1l53XgFLCaHxOCs=;
        b=OdofTIcETIslbpHFyx6imm4usTVU/mJzCJrq7LqoDkP5ZT49knJQ8TX2ESlJVl7CuI
         G8JAZHWvxaPd7HPjCNKwWAini3mY7FB4yQ/Jt0Hu7QP1TQ5RuCJzmifjXg9WFs4q1kzV
         nZnh6DOSIPLAwIKCz2jt/zje8+mwefRaydZ6WEQgIcTmoOyWEWTSg5o01RNMO+tLov0D
         Vihsu0iYKxx9X4YOpf4gEXPBoMzF+IKm/GCVwZEHTEvdmZY+W9Q9dy9Gsb3YR9b0t45m
         AV/IUOkV4KzjNManvjVq0cEdvkpjHwuDbF4Jna0gtUgaoAG6JNXbyJPXrLZT7qxb/rN0
         WE/A==
X-Gm-Message-State: AOJu0YxzfbpB5erB42fQyH/qGAjFc+22GyW9Th3JOICXsTWzqKREqc42
	NkViERLMHEVAZXiy9slVGXaJp4kZD49+c9HjomNAGJxbu46u4WeJ
X-Google-Smtp-Source: AGHT+IEjN80RhUHlpF+p1QRk26HikTS997ayD02/GzCfvSoPpEYpKZCjshnlsIGmITHOtdgg84G2Ig==
X-Received: by 2002:a17:906:ad0:b0:a5c:ec01:f0 with SMTP id a640c23a62f3a-a6f60de26c8mr77029266b.70.1718330324790;
        Thu, 13 Jun 2024 18:58:44 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ed0ea4sm128453966b.116.2024.06.13.18.58.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2024 18:58:44 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>,
	Jason Lunz <lunz@falooley.org>,
	Jeff Dike <jdike@linux.intel.com>,
	Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>,
	Alasdair G Kergon <agk@redhat.com>,
	Jens Axboe <jens.axboe@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH] um/mm: get max_low_pfn from memblock
Date: Fri, 14 Jun 2024 01:58:40 +0000
Message-Id: <20240614015840.12632-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240613_185848_884808_25CEEB14 
X-CRM114-Status: GOOD (  14.52  )
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

While we can get the maximum page frame number from memblock, this looks
more reasonable than setting to totalram_pages.

Also this would help changing totalram_pages accounting, since we plan
to move the accounting into __free_pages_core(). With this change,
totalram_pages may not represent the total usable pages at this point,
since some pages would be deferred initialized.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Jason Lunz <lunz@falooley.org>
CC: Jeff Dike <jdike@linux.intel.com>
Cc: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: Alasdair G Kergon <agk@redhat.com>
Cc: Jens Axboe <jens.axboe@oracle.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Mike Rapoport (IBM) <rppt@kernel.org>
CC: David Hildenbrand <david@redhat.com>

---
A simple UML bootup test looks good.
---
 arch/um/kernel/mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index ca91accd64fc..ca682879e28f 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -73,7 +73,7 @@ void __init mem_init(void)
 
 	/* this will put all low memory onto the freelists */
 	memblock_free_all();
-	max_low_pfn = totalram_pages();
+	max_low_pfn = PFN_DOWN(memblock_end_of_DRAM());
 	max_pfn = max_low_pfn;
 	kmalloc_ok = 1;
 }
-- 
2.34.1


