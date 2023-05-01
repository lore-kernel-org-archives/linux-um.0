Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB73C7EE21
	for <linux-um@archiver.kernel.org>; Mon,  1 May 2023 20:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g43mP9yy2k0/21aswA5/1ZKaAAs6in+b68Rwy/2V5pA=; b=T/E6MhSJTo+t2Q
	wh4Zaexd38GxBFA1C2E7NU83y3/L2WnjFB3GsDujs+7ERK5/ftSrsyiG+aUtdS65Mo/9XSURTq9y+
	NwbWu74aRSvQp6QTXHNrxNMd72Y1+uQYf/3tKhlReqevhDkDpjpo4SOgZb3bQe/rGr95LwSrsk4A4
	YNM8xaYIeCHP6OVNes2m1BKh1Sjpt9RMoIajp80ILSfMcc6UtRwoZf99qrB1J7LAvXBQKr6XmxnOi
	tMF5m3yHuFm7LGdqlh4+sT6JxHEtvEB7TPYiNIOv/DthXABum4/OvYa9iba2EGNZSF7R8NNmJg4M6
	skGXIL7qrr84aXu22FQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptaAH-00GsAp-1J;
	Mon, 01 May 2023 20:30:29 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZCm-00GhNx-0U;
	Mon, 01 May 2023 19:29:01 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ab05018381so4986105ad.2;
        Mon, 01 May 2023 12:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969339; x=1685561339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrqntkjJd8BO8YfASMnosk0HIl+t/0EXXW8sSx0dJVg=;
        b=YynIc3MWOn+7eKGjmZARCn/IjCANfe8gTHKhI/1ubKTs4ZbiubHG1P9aimD9KzNrIR
         eunJCIzqiXfZGl0CCMrWEsO+nwpbu9UTA+2coBncf0PpX1ohouYsG2DEdDJZPuTXi/ir
         yR5oJPT4K2awb6eBfuzacZRfwPXKDUNKWynDv8oNvVCBXhLYj3JhwMiPBRO+Fg6hjdSs
         FM9xgZDHU6Sc+urW7voaFKEt/7m6LjDuxZZp6qL4zZI9dwEcGtT8oaSDqFIY7TNV4Oop
         NDnPsASY2UskW6usELO5k/OqVJv807YApzHQHt4bSD2BLXySmWIPAbRFeQIxlm3YwdkY
         qcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969339; x=1685561339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrqntkjJd8BO8YfASMnosk0HIl+t/0EXXW8sSx0dJVg=;
        b=g7v3P6Lgx+DEpM+hNnEKHt/OIsrj6rAl5M3k9ubB4pUzWbJmmF23mTpu4TMTFjOg03
         auSF86uKtpO8nBLhrkCDEhWLSFVTAfAWk4Ov6nVIvoiuEcrrmxTcq+YzbiUUgXOHDccm
         qmz5NAI6w47ASJdxFv9yoeAux6my7lT/j05r+tKOT0+TXSzUaodVRcvm38Wrl6bdzwve
         QEhOTW922giv6dOmAvf4RWfHgwqJuydYSbtFb/8sZxmlD7EYS75WdT8/iKm4wiNaK1lT
         /xpw9BlzYT0OGKAYXwpAWsI3rqLRKyaBEDZn/TJggoxq8fqxCpI9gNhWMk0ciJfO/DmU
         D35g==
X-Gm-Message-State: AC+VfDyBihKvRFSC2HfU6eNDaUp/+wCIReIaieUd3n9bZExajQqyuRaA
	5EFugHP/jX1qoTJc4W1uTA0=
X-Google-Smtp-Source: ACHHUZ77ujqEA4Fn1OLOb7e5ecCGVNnJtAoTp2B3mAkadiAfSXyelwvqP5mlNEo41vojA+MW1rmqbg==
X-Received: by 2002:a17:902:ce8e:b0:1aa:efad:f2d4 with SMTP id f14-20020a170902ce8e00b001aaefadf2d4mr5633464plg.63.1682969339499;
        Mon, 01 May 2023 12:28:59 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:28:59 -0700 (PDT)
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
Subject: [PATCH v2 18/34] mm: Remove page table members from struct page
Date: Mon,  1 May 2023 12:28:13 -0700
Message-Id: <20230501192829.17086-19-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501192829.17086-1-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_122900_187357_2830C89B 
X-CRM114-Status: UNSURE (   9.91  )
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

The page table members are now split out into their own ptdesc struct.
Remove them from struct page.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm_types.h | 14 --------------
 include/linux/pgtable.h  |  3 ---
 2 files changed, 17 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6161fe1ae5b8..31ffa1be21d0 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -141,20 +141,6 @@ struct page {
 		struct {	/* Tail pages of compound page */
 			unsigned long compound_head;	/* Bit zero is set */
 		};
-		struct {	/* Page table pages */
-			unsigned long _pt_pad_1;	/* compound_head */
-			pgtable_t pmd_huge_pte; /* protected by page->ptl */
-			unsigned long _pt_s390_gaddr;	/* mapping */
-			union {
-				struct mm_struct *pt_mm; /* x86 pgds only */
-				atomic_t pt_frag_refcount; /* powerpc */
-			};
-#if ALLOC_SPLIT_PTLOCKS
-			spinlock_t *ptl;
-#else
-			spinlock_t ptl;
-#endif
-		};
 		struct {	/* ZONE_DEVICE pages */
 			/** @pgmap: Points to the hosting device page map. */
 			struct dev_pagemap *pgmap;
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index b067ac10f3dd..90fa73a896db 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1034,10 +1034,7 @@ struct ptdesc {
 TABLE_MATCH(flags, __page_flags);
 TABLE_MATCH(compound_head, pt_list);
 TABLE_MATCH(compound_head, _pt_pad_1);
-TABLE_MATCH(pmd_huge_pte, pmd_huge_pte);
 TABLE_MATCH(mapping, _pt_s390_gaddr);
-TABLE_MATCH(pt_mm, pt_mm);
-TABLE_MATCH(ptl, ptl);
 #undef TABLE_MATCH
 static_assert(sizeof(struct ptdesc) <= sizeof(struct page));
 
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
