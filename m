Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1402BC77B72
	for <linux-um@archiver.kernel.org>; Mon, 17 Apr 2023 21:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ELLR+7DIBuyCj4eYScqdJfAFCR2m2sRumkuz6rsSupc=; b=WvCQpqTKldLqjO
	Z5uBjDrxUwL7gk1Cz8vd0z6UNKGNPNKz3G+gg9RXq222vgum/ugQcvs9Ukr2v0o/wLK3V04L2DJTx
	SA43uYdseTMhK9hOa6aMzub2MY751WuoSOnin8nJ8Udh/8gtbfqxIb1ADbE5opMdBruZuoAof9Ejn
	HO1yMinW51ufaZGodwbOw8sp4CF6VHTZXI5mPjh39Z4btJy9UQtqUq89CiZnJQxIlPQSuW0mCJsSS
	mTyCAnfdi75wkJUb1OdZUPRK8osn62RMFMDvr/72yN1CJrhfYD8C01FsqivKfQV/y8XG+ULQiYSaj
	H3Fuhw4emwY2qZL1Ppyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poWE4-0002Il-17;
	Mon, 17 Apr 2023 21:17:28 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poWE1-0002G2-0e;
	Mon, 17 Apr 2023 21:17:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=CSVYEUhM0zGHlDR1yqa5KIpwwPynV1rh1Z3AvIT239o=; b=HAV8Q2PRznnTRQB1mVTlUgFPoC
	ltrCZJjPHhAU8wlccHB3t3UVVq42Z2K+M8DOQrD33ELN3IfqNl+sLOVQC9qMOABSQENIvNcWR3Qob
	IUdsqPdMn6Ji5RSojcTwd87KpWi6fTMFVikTzV+U24lkwYmTkw2foCvr+p8mWvQVPf0tGG1C3tSV3
	7nOYkoISxVFBVimTD4cxzyVnF6G8tCPo/TtsUbDs5Qgh0k1417LxW9NrNz+hk+7PV6n6YZb3KhXnX
	bkqq9GBD7pvYDcVb89v1sKPxppXAHvvg26AHkkEdX/VYE83HaaDtP5RWXbFRItW0bIvmbg7VJ1yNv
	Tfvh7iFg==;
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1poVqr-00Bfqv-3c; Mon, 17 Apr 2023 20:53:31 +0000
Received: by mail-pl1-x62e.google.com with SMTP id p8so27389481plk.9;
        Mon, 17 Apr 2023 13:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764808; x=1684356808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSVYEUhM0zGHlDR1yqa5KIpwwPynV1rh1Z3AvIT239o=;
        b=Bs6MBnbjQkX1GScZCbLklar3CQYsHMcNQJhdEJMSRoz85XciXhpnQ0YtDU9kdG/nWk
         TxMCtPr19eviQJI5aQ6Z23KjvD0/UYdwUUF801SK8Z3tk/XuPH8n6ufK4lU6OPOoTkEa
         tcxsOYaiL60cLVhSI6wekl2Ojt4T3pVi0l4/Kpd6dmP8a2GTqJPhoPlibhYfl7AzaVkC
         8dHP626PMZuKBlHUuWDeE5Ws0Xf5nvhx1+eNXqdjJYxnU1JpJLYxfuGpVyKb6jdKhgqK
         l+AozFzFnnh8JDe5VzEpQS6lDqTnIa40opwHXXYLbmcB20BMSqSIISIYF0OD142rh4KG
         4Sbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764808; x=1684356808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSVYEUhM0zGHlDR1yqa5KIpwwPynV1rh1Z3AvIT239o=;
        b=dBlnor3VOwDXOSsI2zEvaDsR3N/qVIci0tP03RH5zfqfOT4aobJYj2kFDdnIaGE4Fz
         JhLQE6g9HhGGH79GsCiXJmYx2EwyEWqaLVhruMHdD9V8Wr3p25JbYQckmxUl1NJ08tk0
         rdpJJmQzhU+mJO+gNFkGN2OIg2wCw6Ag8KZM3Ui88vNoTfcoodS4/5MaX2HulRhm8rum
         YV2cSe/4tjXt8O1K+QjbaBqophJ3JbiDx2mkVjt8FqSLy0hQpaVMLFmGnArA4KUePPPx
         iqexeZb67tUsNfejblj/m0CjqrSYnqCzM+ePF18XG5oN9lnKQLq6Uer2DyufCCtnbrTp
         ObhA==
X-Gm-Message-State: AAQBX9fLJxW4X6+ssM7Nyxw/YLTWFK/1TJeHBpVg2WDXOHhv6ZuVOGoN
	R8kh8/j4EVyztBQtzIl0aFo=
X-Google-Smtp-Source: AKy350a2GcdGbRUVrvD14pA7yb7zjU30cICJUnhJQSgTB8CRLuH7Cup5yhi/f0UjvURoMBG/RaZdVQ==
X-Received: by 2002:a17:903:1206:b0:19f:1871:3dcd with SMTP id l6-20020a170903120600b0019f18713dcdmr272381plh.5.1681764808447;
        Mon, 17 Apr 2023 13:53:28 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:53:28 -0700 (PDT)
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
Subject: [PATCH 31/33] sparc: Convert pgtable_pte_page_{ctor, dtor}() to ptdesc equivalents
Date: Mon, 17 Apr 2023 13:50:46 -0700
Message-Id: <20230417205048.15870-32-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_215329_180152_FA707A93 
X-CRM114-Status: UNSURE (   9.23  )
X-CRM114-Notice: Please train this message.
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

Part of the conversions to replace pgtable pte constructor/destructors with
ptdesc equivalents.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/sparc/mm/srmmu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 13f027afc875..964938aa7b88 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -355,7 +355,8 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
 		return NULL;
 	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
 	spin_lock(&mm->page_table_lock);
-	if (page_ref_inc_return(page) == 2 && !pgtable_pte_page_ctor(page)) {
+	if (page_ref_inc_return(page) == 2 &&
+			!ptdesc_pte_ctor(page_ptdesc(page))) {
 		page_ref_dec(page);
 		ptep = NULL;
 	}
@@ -371,7 +372,7 @@ void pte_free(struct mm_struct *mm, pgtable_t ptep)
 	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
 	spin_lock(&mm->page_table_lock);
 	if (page_ref_dec_return(page) == 1)
-		pgtable_pte_page_dtor(page);
+		ptdesc_pte_dtor(page_ptdesc(page));
 	spin_unlock(&mm->page_table_lock);
 
 	srmmu_free_nocache(ptep, SRMMU_PTE_TABLE_SIZE);
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
