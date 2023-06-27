Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88ADFEB64DC
	for <linux-um@archiver.kernel.org>; Tue, 27 Jun 2023 03:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Q9YK12Nsx6ujQfndJjchy/U9wYLDzQsH9o5g0eiiEws=; b=nd1iTxQvUt3ZLY
	mHGNUr2TE5OfXzp/h3QhpiIYRFNXWXgHzlalb3hnpUmr6AKJh3+ceDulOIH95YTtBZ+xwcFyv4G1R
	fuHCDT/WJjGBb6DG0HJVHP5XVS6e1atL2UG5mtFqW93ENl5xW7AfUn9Xx/k8iF6NSS/IscQXT8+9c
	alef2A3fDi0Z7pfgOC1w0slcK/WuxQTEC6LYLpMi+r+HBd8h9HPkilec4sX8yXYyksubCiFF3vuTA
	4dLooN58TEdERisnBxil5KwmTpIfVz4eQN3E1YFgjsh8/9aq1kFe0i1sT4O6iurW2m3Hts/5BoHDp
	fML2vVbxEnBpdGKNl9uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qDzDp-00BYLU-1z;
	Tue, 27 Jun 2023 03:18:29 +0000
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qDzBJ-00BW1c-1c;
	Tue, 27 Jun 2023 03:16:03 +0000
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5704fce0f23so42036357b3.3;
        Mon, 26 Jun 2023 20:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687835752; x=1690427752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CuYJ7liBLmFxtlpmCAIL/qtog0vkZLk1dVk72P32nA=;
        b=Z2y492L3/D8WlJ5Hq0dqKp0BKJYUW7Eb9G7qdf3vIGRQ+O8SF6z7cY8de1pnrMmDqQ
         +a96x8kX3opEhwfyHnlNFTWX5OwZauzWBj6C4ouPJiZfrfA0EmnR4gOkOWCXT0Tt5rk7
         XHfLS6CI7/qHcQlfDrYckrQudKqfd53TugdHSOAC54JEXTOgwU9ogsxc/TSIilUUybaL
         /EAuzpcVE6dEZDr0iMV3l0ZL5CrHH5SQ2tSWsVIXTRE6S7JRWuiJGvbxR8kbv1x+D3dj
         SKo4oZP9xKp5iaeAAmMvP/qF+1bKjojF2HvsjQLLw57QGCxHLxvjF/rVFYkYGLWd7pTO
         F1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687835752; x=1690427752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CuYJ7liBLmFxtlpmCAIL/qtog0vkZLk1dVk72P32nA=;
        b=jnRDzFLs7Nv51KqnslKOHzhzVW7AOmoRxCkFjCWtljgGA6d2BKQm/bjtOg3onNn/YF
         I9j+HLiv1+JWvVJKQusTXKo05SCOeu8O3aNq8POMXc8ITPIJy3AG4U9Pm7YJyOyxLtri
         5j6d8Y2lH3euwdKPkA9AwZBohezPXmrRYwV1y2ehn5PCaqnfuIuKaLayEa2Hx9RytoKD
         a4cUQjojuSNSAt1pibVWpB+BwShWitpIqlAxrT65/p0VzgvrNr7P3L1qrItEkElLRe/a
         nWP6/0aa8IXQ/ZjGrgDmUywYdKFESUwtH/pjwECUCxY1dih5Y4wVOPKlDjq1/oHXRU6Z
         BpSw==
X-Gm-Message-State: AC+VfDxe6yV3KlKtxSw5WjVcvGflNxrP0SfcwzDjPCGK5kaIYUCQBGHG
	i25CdPJI0eaw/M0+Mx2iE0Q=
X-Google-Smtp-Source: ACHHUZ5CQK8kRHJUPJM2uDCPFRj7p03JLp7keUZBkce6O+8d/iMl0gg4/oyJxvTRdTEHePf390CKKQ==
X-Received: by 2002:a81:4689:0:b0:573:9751:ad15 with SMTP id t131-20020a814689000000b005739751ad15mr18645821ywa.17.1687835752283;
        Mon, 26 Jun 2023 20:15:52 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s4-20020a0dd004000000b0057399b3bd26sm1614798ywd.33.2023.06.26.20.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:15:52 -0700 (PDT)
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
	Guo Ren <guoren@kernel.org>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v6 21/33] csky: Convert __pte_free_tlb() to use ptdescs
Date: Mon, 26 Jun 2023 20:14:19 -0700
Message-Id: <20230627031431.29653-22-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627031431.29653-1-vishal.moola@gmail.com>
References: <20230627031431.29653-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230626_201553_601037_4DD4914E 
X-CRM114-Status: GOOD (  11.02  )
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
Acked-by: Guo Ren <guoren@kernel.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
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
