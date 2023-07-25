Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54BAEB64DD
	for <linux-um@archiver.kernel.org>; Tue, 25 Jul 2023 04:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s+Ye2mLLXaoC3d4E+fcQCpSKAefOyxQhXybE9M4iEHE=; b=iRIeYoEwUW6u8a
	Mn00XrGIvGaDuSNbelQvjp8NHcu8x5riaiwmADhuqxrC9BUN9dLoSvXdAYZap3cKUakmP8yxhSPMB
	ZEHwxbc+DhE5AimU29imp4A1qkMfXKZfBAde+GUeUNJhoodPs9Lxv/JMMxKrDjucbIaEIFsNXiE+5
	1uLsKBdmtvFFT6LwgyQdTLwKKYDrio79BmyjFGZPf8HWjk0iOGVMYTvvvI2NuzBlnEgYX4xyMAgv6
	RWLtfcrDLje+H8rGSshxxa91/5jmG5hb3ozQtXxWENalybQNCZ0QflXP/6AnHdO1IyOE4JuV7JQIm
	/+eW2Djxhd9jiqoOTCWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qO9cG-006Ax4-0X;
	Tue, 25 Jul 2023 04:25:44 +0000
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qO9Yn-0067uS-1k;
	Tue, 25 Jul 2023 04:22:11 +0000
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d10354858e8so1904014276.2;
        Mon, 24 Jul 2023 21:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690258929; x=1690863729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ES9RfFz84BcV9KH4Nk3AfkjPOEvVVRdPbPMSiTejLcw=;
        b=cSKYfsxsSJS7ffOM4NEt7zqMXRoog1hv17RKdUNV14hwO6VLFQmWr65pOVoZcWEcHO
         ZTxl5sTEIPleNQWx16W6XrYvQNc8QXYYi7iNKk/WLCGUAw+9con++Nm/zKIXiRkvFnF7
         Kmn+uijjQiZlrdtiQKHDxzRwNsdnc8EVkdLLz/rRCQKPLyPDRXi+bbVeFHkpJoJjSqoQ
         LLoMyhXQM5hAlfwlKm9TGFpC4wUaQoFel3CzrwsKFljyIKf+UmRISO6P0XGMas/PtQ7m
         PZz9tli6d2qqtk+AGtTpbrNJSRqge28gNGwJ8TouzN1vk9cQxwcl+kcXzH8Il6o+JKN2
         oqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690258929; x=1690863729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ES9RfFz84BcV9KH4Nk3AfkjPOEvVVRdPbPMSiTejLcw=;
        b=V5hIk7kofpmeu3275yWWjjRUJM1u57iGbRAlVAzBJTpn5SBvY8c9pyI77L8oeiF1tj
         L8l1Ko2qmXDfPNPIZD5ar5x/xMeafktoQfIFQpZsOJjUQr5h35NgWrM/ilosecVOh+zB
         Dv5azItWeuQkt2Ir5C7ObBMY3MIH5We3oU+EQ26vc1ScZ5Mn8/9eHa6Rf1yH/F7+yohz
         2arlGTdjwH8h8av1eITUvJlhFSMN9VMbZRpwlEYwn9th9dAxuWw/loKhNsf0UdSCWC7G
         EjmBUddXM5zr18vnF3oG09JRc1cvWLGIg/RO0u45o6e//e0qBMfwCp4ly5VWeZhx1MiN
         MSEA==
X-Gm-Message-State: ABy/qLbct9S0u1fndFfw3YYOCTx985NIQmNb4vuqCp7mYxL82w/4krxz
	088MNmrNaCaSCdnuyXNyu9E=
X-Google-Smtp-Source: APBJJlHinG28bY5749COLWHo/TBHjyABo5nSLZGYajOWLjAfKDEgrRU/vgHTv2Ygbb3WniVSdKl5LA==
X-Received: by 2002:a25:700a:0:b0:d16:c58a:e63a with SMTP id l10-20020a25700a000000b00d16c58ae63amr1491610ybc.23.1690258928721;
        Mon, 24 Jul 2023 21:22:08 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id h9-20020a25b189000000b00d0db687ef48sm1175540ybj.61.2023.07.24.21.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 21:22:08 -0700 (PDT)
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
	"David S. Miller" <davem@davemloft.net>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH mm-unstable v7 29/31] sparc: Convert pgtable_pte_page_{ctor, dtor}() to ptdesc equivalents
Date: Mon, 24 Jul 2023 21:20:49 -0700
Message-Id: <20230725042051.36691-30-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230725042051.36691-1-vishal.moola@gmail.com>
References: <20230725042051.36691-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_212209_605342_A45C5319 
X-CRM114-Status: GOOD (  11.06  )
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
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/sparc/mm/srmmu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 13f027afc875..8393faa3e596 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -355,7 +355,8 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
 		return NULL;
 	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
 	spin_lock(&mm->page_table_lock);
-	if (page_ref_inc_return(page) == 2 && !pgtable_pte_page_ctor(page)) {
+	if (page_ref_inc_return(page) == 2 &&
+			!pagetable_pte_ctor(page_ptdesc(page))) {
 		page_ref_dec(page);
 		ptep = NULL;
 	}
@@ -371,7 +372,7 @@ void pte_free(struct mm_struct *mm, pgtable_t ptep)
 	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
 	spin_lock(&mm->page_table_lock);
 	if (page_ref_dec_return(page) == 1)
-		pgtable_pte_page_dtor(page);
+		pagetable_pte_dtor(page_ptdesc(page));
 	spin_unlock(&mm->page_table_lock);
 
 	srmmu_free_nocache(ptep, SRMMU_PTE_TABLE_SIZE);
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
