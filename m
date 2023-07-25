Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1D1EB64DD
	for <linux-um@archiver.kernel.org>; Tue, 25 Jul 2023 04:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LSkxPGD1P0Ga3jFU/oewitUegGEc4O+cID0e7aE6Qs4=; b=HALrBAUJod6EJQ
	lTWqaG50iLhcSGPx8Lj3U5QQnSGfNpDWdlZ+eVX+RE05WNmOT7YXCW7WpZsudpHnd+8UFjWqlN2hU
	TpYCTUu+ReE0+NlWzt9GdV0my0k6cGBxd7YROefLmflE/PK1soHyyB2wpZZ88+S1Cv+G43oUhn6iw
	QnbKerAsBEaKXWfdcIYxo/Nqd2pJ0pnzrLnYzc7/HiHQg5mj5rWh/vFMhWZjUb9MTXob+zR+Lj22D
	QC3QUwaRzG0vKQORcgp5P6tBuu7jsWEOgh1Xxiw+oOGDfXRQkrgRG8pJxqYAFfVDC48CwItyfMXRG
	HfTUb6Z43nrewojRWKEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qO9b1-0069mp-2z;
	Tue, 25 Jul 2023 04:24:27 +0000
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qO9YV-0067bf-2m;
	Tue, 25 Jul 2023 04:21:54 +0000
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d13e0bfbbcfso1762029276.0;
        Mon, 24 Jul 2023 21:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690258910; x=1690863710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUnc1suNAj/KzreaB6s7vAsOWiJZx3FNBLzDbQjj/SU=;
        b=f6oxEdexqW7t8O18O1zlBzEMy1/ySz1lSWwZIgvC+6ZdC+AQVNOOjrUGsL3n8z9yLs
         jC/oIvWOegKfTXKYCqEjhGYC8DO1R1+qqiiOoaRmFe+GV40qDgP7vCBrkhQ8/QoelGjZ
         6zYUNV4SeVX24QIWi1/OsGEJx1KydkZGoq9ape10nJTNyMWr+pQqOvmxVzCb+3U9sgmC
         ze1LeRMHMeTo2LxUzcGxr55PmnWGKX2eITQpSi6L0WDbS9ycLs9Jos/2PAo+dLuVd9aS
         LiJCpXRUIDud7YKdN1pv+EIwqPuZ42v47LQ3yS2kQDdlx8gJ3/GU5UxByOmc+boocCVB
         ZyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690258910; x=1690863710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUnc1suNAj/KzreaB6s7vAsOWiJZx3FNBLzDbQjj/SU=;
        b=Iu5jLF+E76AfHXzaxp87KFQ6sS9ZCznH1wI2wnepnKNnG++IcTYCFhWW5a9EtfEtR7
         HWtUm4xrsdiNwipAaHQ7/Ip05/kCXL1M3hYuS2n356YE+gxsuGehP5G8KMe8hoUF1S0F
         EAN8dTIHSECWkrnjf1KJBIk0rfxBXabZdnCf+ZShqbBP3EVe/DZuGklP9hXjaCo05Rei
         ZQa4tjS08WbOFcRfXaQ6sAYYUGxxRCXcinJSmOvSIO3AtSw02nfm/nXM/+nOj1SYaYVt
         08RahmHqXC1vOsocP5WGVWYhz+NVF/PG4/ddJtbYK9otKVpamAXg0oF8xvBPki1ha52c
         SOgg==
X-Gm-Message-State: ABy/qLb1LNj3E7ZCBjKaT00yVfof3paKyCUHr7MnxF60gBup1LwpAAG1
	rNSVcaBx+4Er6yH30BXo9Ns=
X-Google-Smtp-Source: APBJJlE5+Qlh5eptk2IDiumLzwzdgKuW8E4L+dGkDhCtXpTjXCpZJt13f1YzsO4C3URc73BGKhlHpg==
X-Received: by 2002:a25:6814:0:b0:d0a:3876:a22a with SMTP id d20-20020a256814000000b00d0a3876a22amr1377987ybc.4.1690258909714;
        Mon, 24 Jul 2023 21:21:49 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id h9-20020a25b189000000b00d0db687ef48sm1175540ybj.61.2023.07.24.21.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 21:21:49 -0700 (PDT)
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
Subject: [PATCH mm-unstable v7 20/31] hexagon: Convert __pte_free_tlb() to use ptdescs
Date: Mon, 24 Jul 2023 21:20:40 -0700
Message-Id: <20230725042051.36691-21-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230725042051.36691-1-vishal.moola@gmail.com>
References: <20230725042051.36691-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_212151_929659_A4DD4B36 
X-CRM114-Status: UNSURE (   9.90  )
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

Part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/hexagon/include/asm/pgalloc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/hexagon/include/asm/pgalloc.h b/arch/hexagon/include/asm/pgalloc.h
index f0c47e6a7427..55988625e6fb 100644
--- a/arch/hexagon/include/asm/pgalloc.h
+++ b/arch/hexagon/include/asm/pgalloc.h
@@ -87,10 +87,10 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
 		max_kernel_seg = pmdindex;
 }
 
-#define __pte_free_tlb(tlb, pte, addr)		\
-do {						\
-	pgtable_pte_page_dtor((pte));		\
-	tlb_remove_page((tlb), (pte));		\
+#define __pte_free_tlb(tlb, pte, addr)				\
+do {								\
+	pagetable_pte_dtor((page_ptdesc(pte)));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #endif
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
