Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A82EB64DC
	for <linux-um@archiver.kernel.org>; Thu, 22 Jun 2023 21:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s+Ye2mLLXaoC3d4E+fcQCpSKAefOyxQhXybE9M4iEHE=; b=xom7HY8A59xAIQ
	cVhBgCShQKhsv2oJVxAAvQhZBjk/4yl+gGLX5mEdj/sYjRW8+UAt/G/ESC1Q6FCfkM/a+2TnYcFT0
	W4mlcIi48b6STlE3o3RstMvl250tFMi5SyQ/ku2boevUADcK5rxLCe5Y09bQmykyIMRsDoFk6Apnx
	OAnxwdSFn9cQS/Effua3a1JjlqsP1/MfRGmVx02FreMVCdzNUULLPkFBXlV+5xOo4wsGo708Tolks
	JJsqt7bj7eFNxTHDIMSsdMQIUlMsOeaGti6j8YqJff00tY2zYGj7JFquqNELO0z5llESxQIcPgOFT
	71V2YkBIBtlE+aVIugkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCRS6-001m6v-0s;
	Thu, 22 Jun 2023 21:02:50 +0000
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCROP-001iWw-30;
	Thu, 22 Jun 2023 20:59:04 +0000
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-bb15165ba06so6116031276.2;
        Thu, 22 Jun 2023 13:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687467540; x=1690059540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ES9RfFz84BcV9KH4Nk3AfkjPOEvVVRdPbPMSiTejLcw=;
        b=oM2eqoarO5mbV/RC9CFfzfiqtalAJnN4v5hz57x8U3YE+/nDsUrmXb6G6NrrfuA0hI
         XHlp77eZ+DzSkin9lWOejdHXde4PpTwM3RiXeCXAduuSgLDQHciXyNj0UWZkZs6yvfTo
         QiJ21UomG7h0wL2TX1WHwgye+s/VKR+Tvt1mxLr3lV1WjwsNROzbcgrXcLO9VnGSpeAH
         7uCU00iH87QJVCo5EKIyfZlW0ogPYyMPi5bY1z7m39x6DegLfFGe3afEY/9WN7xyqGjN
         dkO4NEs5eZtRaUa3RiJYmwztOORKB/ecQ6EJlrLWdOw/VRXBlFmMwGL9APm0v6t4+G2k
         ZQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687467540; x=1690059540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ES9RfFz84BcV9KH4Nk3AfkjPOEvVVRdPbPMSiTejLcw=;
        b=EVwpm+VurHDIbgZXx1L00uXVk+39DKCVUHJ23JG4QRGVyH/XhMIpG36eqzoGDpz5Bg
         RNYi8xV4kc7hUjmKx4lQJ5xuvRUJQKwP83FkG4QsNlylt8NqUyGzxFt8fOtJbu3N+8IJ
         TqtnT/mXG5uZK8GBD6Qo5cW9rrEJeZHHuqb2GVfejy1dk+YrxSYUOXdAuOIfLbLJDAaO
         cFylu67yoD1XsN0yDeFxzyIQhZNte6qneEHIIMPLg7DQR+f2eTvR/cS6TwDM21HaYDYe
         zYPxpKYTfCNTcvcENMx2d6MGRdlarJgw73a2E95tXDkTUY/EtgYV9W+6mGSk1qssC93U
         Teeg==
X-Gm-Message-State: AC+VfDxSmon5QDwcNdpB/HcFfb7iL+xkSKc6Io2mkrr86Wf2+Q9vH7p2
	6VXHvErB2PC5miRBs6JVxiA=
X-Google-Smtp-Source: ACHHUZ6Ec2kbAX1UDgGMj9ZCyBvb/VNaStMToJEcOH7SUf7INOW9CMO0HLoZFa/KezNB/PETnccRFQ==
X-Received: by 2002:a25:bc53:0:b0:ba7:db6c:c0eb with SMTP id d19-20020a25bc53000000b00ba7db6cc0ebmr10225049ybk.3.1687467540710;
        Thu, 22 Jun 2023 13:59:00 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::36])
        by smtp.googlemail.com with ESMTPSA id d18-20020a5b0c52000000b00bc501a1b062sm1684937ybr.42.2023.06.22.13.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 13:59:00 -0700 (PDT)
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
Subject: [PATCH v5 31/33] sparc: Convert pgtable_pte_page_{ctor, dtor}() to ptdesc equivalents
Date: Thu, 22 Jun 2023 13:57:43 -0700
Message-Id: <20230622205745.79707-32-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622205745.79707-1-vishal.moola@gmail.com>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230622_135902_133727_2BCFE0C0 
X-CRM114-Status: GOOD (  10.76  )
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
