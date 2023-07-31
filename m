Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BA4C001DC
	for <linux-um@archiver.kernel.org>; Mon, 31 Jul 2023 17:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=muCHaq/XOEguiB8i+G1wsIfby4WiPAA7HzoO2bm4syI=; b=HWvWrP6IWVfgJe
	ZpMsqgE0XLyi+VhbTtlM219AtNQeZiqlxiGpBmdCGhUKmN2JJ6WB1Erk+rBcI0ZWHfHxzkXbkiye8
	SivDZa2qLN+yRUTxqQf2EZ6kYOPvVcF72vY4//7Xud/m1uYj17Ylv3HM9S40y6JddGPVYhTtKQZXS
	gLLvRBIE1pl40G32s0F5tPmfugh1X30vTDKWRlU5vSL9QaV51s0oc/TkDESb4UtHMQauBFQkF9FRd
	pBa9Ed1xsljYmmSvsQ6t9CxVpCbrtWAw5qp0TXnJJUS6qHhuLTLCpD02nON8XJFGB+lvpaWMc+QYG
	qFJoJ5A8C6RmOfZbMzIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWOu-00GoRL-1F;
	Mon, 31 Jul 2023 17:09:44 +0000
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWJw-00Gkla-0W;
	Mon, 31 Jul 2023 17:04:40 +0000
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d066d72eb12so6699490276.1;
        Mon, 31 Jul 2023 10:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690823075; x=1691427875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9EaWELDe99nUon5K3Z+iJo2yPeaFSzyCnD+eyoagSI=;
        b=NsFqLoWt3v/Ei4hrw5AsnvwdpZbLVDKyj7Tbvrs08XADPJ7gaOSxsw7sciWyK4ium/
         IicTt5pAnx/uEvhHlkhBbrdEgtE6/Y30DbetyPtuylWlm9M94rgMfdNkMfsGqtqBt9r5
         2L6Wjhryz46RjM7Eb4DDBBbwHfcSN7h5N/Jso4kYni+cF2Cm7JoIdTfshA0rAirRtgJq
         t1r00+5UN5MvK3JKDaigYuLE4bDBuDPbT6+YGl+hj7DsF2cKQbydBN3rr041uGf1vOTw
         rMTuYysQGj/R6E2nTgdgPgBnp/CeSE0cUWUK6rVcO8oVilzfT/uwMzlyU+7MnJSFTrKk
         qPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690823075; x=1691427875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9EaWELDe99nUon5K3Z+iJo2yPeaFSzyCnD+eyoagSI=;
        b=bTZ5JIunujkm5x5VoL2mAq84KVay3ce2fCd7TzDlevBu8cfJv5y/pma06upaq3ATlI
         7YdihTeTP0WfH/82LViWFGC0h4oygscHKkiBT9mYVwyIbeu+UvFPl25p75AITxBtJNOa
         AAWTHK17NMBsRTGxOzKR1MxInUfX7VANokF7jwdKKjJNvYniU0r5TAwscgqYrknJaof/
         zh6YmVPPr2CApkiy6ge4uxVE+IKAlXwPkrzdBdoP3BPls16aQmqNVzPdUHwPTroxTYvE
         JmSQpffVlN5n7BAqUibGTzEAeQK073cij7vH1YrN4LUmPGW4qKUGwT10pRJMP45/+9/n
         nE/Q==
X-Gm-Message-State: ABy/qLY1MWaI9LH4P2KZUbe7hWxn4xqrqVeDjw528OcjjgkbDeGqkOQq
	4wZsPB5gJYr54H7CNU8NSdY=
X-Google-Smtp-Source: APBJJlGLJI7wOi/cAC+4887p5NxC1O6Jx9Z8tS0dkQscAqT6FlNcjE8alBIW2Z/pk8K3FJGLN+6VNQ==
X-Received: by 2002:a25:ac99:0:b0:d35:ee7e:349 with SMTP id x25-20020a25ac99000000b00d35ee7e0349mr1328711ybi.1.1690823074854;
        Mon, 31 Jul 2023 10:04:34 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id x31-20020a25ac9f000000b00c832ad2e2eesm2511833ybi.60.2023.07.31.10.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 10:04:34 -0700 (PDT)
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
Subject: [PATCH mm-unstable v8 28/31] sparc64: Convert various functions to use ptdescs
Date: Mon, 31 Jul 2023 10:03:29 -0700
Message-Id: <20230731170332.69404-29-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731170332.69404-1-vishal.moola@gmail.com>
References: <20230731170332.69404-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_100436_217612_B64A5C61 
X-CRM114-Status: GOOD (  12.37  )
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

As part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents, convert various page table functions to use ptdescs.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/sparc/mm/init_64.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 0d7fd793924c..9a63a3e08e40 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2893,14 +2893,15 @@ pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 
 pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
-	struct page *page = alloc_page(GFP_KERNEL | __GFP_ZERO);
-	if (!page)
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL | __GFP_ZERO, 0);
+
+	if (!ptdesc)
 		return NULL;
-	if (!pgtable_pte_page_ctor(page)) {
-		__free_page(page);
+	if (!pagetable_pte_ctor(ptdesc)) {
+		pagetable_free(ptdesc);
 		return NULL;
 	}
-	return (pte_t *) page_address(page);
+	return ptdesc_address(ptdesc);
 }
 
 void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
@@ -2910,10 +2911,10 @@ void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 
 static void __pte_free(pgtable_t pte)
 {
-	struct page *page = virt_to_page(pte);
+	struct ptdesc *ptdesc = virt_to_ptdesc(pte);
 
-	pgtable_pte_page_dtor(page);
-	__free_page(page);
+	pagetable_pte_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 void pte_free(struct mm_struct *mm, pgtable_t pte)
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
