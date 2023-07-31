Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C3B5C001DC
	for <linux-um@archiver.kernel.org>; Mon, 31 Jul 2023 17:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s+Ye2mLLXaoC3d4E+fcQCpSKAefOyxQhXybE9M4iEHE=; b=aSmh3X2evzL08i
	uOIU0g3LJq+K9B1apIRCFNkh997HSigxKE8NFxM5LuMuyxQBziABapPkO4yhCr5wfzI3+LK8AKDRe
	loyduJeYGMhoQXWoVn3I9iQtuwYZsjdXDUrQjwZyXZCm8VJPdEBxPVqnGgNwTVRr1RE1lRyFKPINB
	Iv9EYLQXDpdsPBg07KSCXz7m5aflLktr6e19fbCH8e52OZgSbh48eTB7cjl9qdMVvV3vPDcRFH6C+
	yu112vGCrrVDmcLC/rnCEBHp3WgkiUxDYGaf46GWYxLmJs0QKTjhHxaKPLEbLMs9II6fgfEqvwyxv
	G8vKszTObif4EgbH93xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWOx-00GoTm-0Q;
	Mon, 31 Jul 2023 17:09:47 +0000
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWJy-00Gkoo-2m;
	Mon, 31 Jul 2023 17:04:41 +0000
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d1fb9107036so5127299276.0;
        Mon, 31 Jul 2023 10:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690823078; x=1691427878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ES9RfFz84BcV9KH4Nk3AfkjPOEvVVRdPbPMSiTejLcw=;
        b=bucd5YCHLhUvx7sCV87tgBpS/yvMqV1hEBgLcIdtkbm6tehUvQ4b8S8cGlWi7/sHjP
         BwMI7RjEZDCFEoZqNSu1BeMgh4cbrdk5jNpPQbDjyiWAygQ6GF4RuUGGOqf6kg0VdfDp
         NpGCzdPUkKHCC4r7KLVhXjv8laMIW1vLz9Hl1FxyK0cd8KUbq0iEAg4q7XF5QTVPGxVT
         zofHi8CwcgETUVRV13Pib0COy9kOuveisGg57GrFHsyYwDdtVuj+zN7pcxA+niXzYe26
         MUnkSw5QHmNGRsesWl9frKtr+MQAPLnxo4yz7glnwyiVSVRMIHwbjCv+Zju9S3AQsrM+
         fRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690823078; x=1691427878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ES9RfFz84BcV9KH4Nk3AfkjPOEvVVRdPbPMSiTejLcw=;
        b=OO9IMnoqj9HCCTjbvvZKYfHsC8xe9Dj5UZREGJYoL2adW1ZRTIiHnlFkivhxbLUdD3
         ED8TiERvaj8pj8ND8vfr7lTVix/PKw5MdXfpk42pz5ZiPwq6XDxf+TGWNahBM/VmbAwW
         Pxi/QtWKfY0xNEJinuJpOX1QUU3+sGzR0HjApwK+l3vY7GxMJxbEsNj5kZNkuxA/dFaY
         9M/jN/ssyyefphcch8dNVoLBLqYARPEjaQPMitxi8MgYohG720EbA2exUA9r0Howir+a
         YLSB9hx4VViF5zwpVdCFVPOnwNkARXwigLMgACZ0yMIg08+ORf+8+x19/53V8eUHjjyW
         pAag==
X-Gm-Message-State: ABy/qLavT/5EIn677wbX1Ffc1ZVCyemYeuQL2bMflqrAXGh3Va0Yf9hk
	devZ/3zPQFOURFeXcFjzdvR+xd7rQpQoVg==
X-Google-Smtp-Source: APBJJlH4kzdzBzRUIaE/50pCy+wwrgbHVj7GhIP0EpKNGW/07mJrSi1SmuvJmvqLlmEJ9bXKX+N7ow==
X-Received: by 2002:a25:2496:0:b0:d0d:f5f3:d2bf with SMTP id k144-20020a252496000000b00d0df5f3d2bfmr9661709ybk.48.1690823077914;
        Mon, 31 Jul 2023 10:04:37 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id x31-20020a25ac9f000000b00c832ad2e2eesm2511833ybi.60.2023.07.31.10.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 10:04:37 -0700 (PDT)
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
Subject: [PATCH mm-unstable v8 29/31] sparc: Convert pgtable_pte_page_{ctor, dtor}() to ptdesc equivalents
Date: Mon, 31 Jul 2023 10:03:30 -0700
Message-Id: <20230731170332.69404-30-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731170332.69404-1-vishal.moola@gmail.com>
References: <20230731170332.69404-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_100438_929071_68360B00 
X-CRM114-Status: GOOD (  11.42  )
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
