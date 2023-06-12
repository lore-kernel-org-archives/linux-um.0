Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41AFBC88CB7
	for <linux-um@archiver.kernel.org>; Mon, 12 Jun 2023 21:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YwWOb6ZcnQN2hdUSNpZx+x7NoUdVPmOk318ZtSNJj6Q=; b=lfhkPJKcwu4IHf
	YxeRTiFBa/0rQHNfeWTWZQ99KB9LeXTsnsd2j5tnamm32pHzZjAZU1ty+FHptaHcc8O+U6kPiTlar
	xhHDrNog9YUxd54bjGlDkoNHQ2NE07G2aXVRi4IhquO8x5NxZHT2Wk/12WYt4gAf2HRg9obJobuo/
	R774T2g5dci4JCpezN0AGuOq69+vZSgt6N9nCngZDqmQTDBh5aU/yu4LQNLC5nz7cDE7UW1Qp/6pW
	qKoq8WNxukeIvrg+b//PCipQZieA6aRR7KTlTykbHUyiq0DLjg6JQV2hEM+CywNeUEnPewSxMLJCa
	RyxzJoaMsjj9C2IEI6tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8olT-005QBi-1z;
	Mon, 12 Jun 2023 21:07:51 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8oja-005O1C-0E;
	Mon, 12 Jun 2023 21:05:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=QSGr1AIBRcRb+Ur7L3hOWyc2qTqn+mhf5/YLNQmZcmA=; b=J/c80SSC1VBC/Qn56fyOzZAnV9
	UEUpd5Et1oHaAPRYcUxLrbX1+rVMQUkRtP9voFJWE4jtEjHED3gVtVCDkQsOqJRibf4MUYg57nBwU
	mDwKUUmjD9k5YGskYJMoDRVohwAN3x70oOc8EXvu371mZnLd7eJu1wuNC9/aOPcVmXoobZOrRPl/u
	z+og7U0c7r1yCuxuOrePeKGuifJwNNlMrKDYIBDPX6oH60hmGjse1Uv+O1KPLmFxcJkjsjIDF+85K
	1Pg3sBlcYXLcmgbTm5pqD0JdiH/gItSKZc7XnUoN264/c3zCD+qsl05LAQt8aIt/kAMLQi1sYk8zD
	HI0MqJEA==;
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
	by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1q8ojV-0034Ng-Fn; Mon, 12 Jun 2023 21:05:51 +0000
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-56cf00a04e5so29836037b3.0;
        Mon, 12 Jun 2023 14:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603941; x=1689195941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSGr1AIBRcRb+Ur7L3hOWyc2qTqn+mhf5/YLNQmZcmA=;
        b=qp0OZHJwYJBDFbnZ3ou1P2Ehue21X+g8zcdgyQxIvQy+nDe0qfAi0dHJH17SnCCz1g
         tKKUvfmw/BkCu2VWGVC9FTcKBTfgeit8iCuiiB2iFwBx6PIhFHMGEsTNb4ySvFT/d3ft
         wztSHCS6L0P5NyGlzSq35fcEZtgvv+BauybZ4ibvcrCUVHnGp/kHvLFHDT0vMZoFlpUX
         ovC+Ec8QSOvfx2fBvS9GXwZis3S10LP+c5zNsCcscOq3kZyLxngh/87tdHFT9B3GKdNj
         CWUudKrbpvmp3qcd3NPPZgIOvQGRSzySt8ja54VpNcHj9wUPZRrXlqZutJQePE3+1Opa
         Ut9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686603941; x=1689195941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSGr1AIBRcRb+Ur7L3hOWyc2qTqn+mhf5/YLNQmZcmA=;
        b=aeDK5tjxhAlWH6GzMjW0mEg7sXFJp2l2VYwK97jGDn0WZP6RHdF8SCNNR1IzJq/zzL
         T2cAfRPPjBCIsbJUe7eVSzIGincoH6wifU5NgAFnMHGWLiR1nAo23bDmsPDIbM9I669I
         PYEKBlGYPxE6+ovu01IrdJFrSKxdbWMNTMy3GFGvzrquIvi4lAL0JFFhso/4phhTV/de
         swt3UV/ZtKGHEu9YiedrhvpnmWjP8cJLfP2Bd7BlxI81nEa3+30SV2yuhN++5kr/pJBb
         f/QysPAl53vcDJo3AYi0OcfTY4AhWUBb6eyBxn0tYMMWXGe2Yy9gIbnGfm2azQuZslGr
         3Tiw==
X-Gm-Message-State: AC+VfDzmuohVtFDhebnf9xNApEBAeZZaMiSu9wF5pAD43GOwHYvx2WXv
	4W8tNLoJhehmMJRa10QPBXU=
X-Google-Smtp-Source: ACHHUZ6f4dQwcKAKk/nBaLFqSfud3ZdJTCw6E1GbyeLYv9ZLF94Eu4p9/l66ZpbQ0joORm5hDbfhlQ==
X-Received: by 2002:a81:9e53:0:b0:565:a081:a925 with SMTP id n19-20020a819e53000000b00565a081a925mr2763652ywj.29.1686603940939;
        Mon, 12 Jun 2023 14:05:40 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s125-20020a817783000000b00569eb609458sm2757115ywc.81.2023.06.12.14.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:05:40 -0700 (PDT)
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
	Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH v4 27/34] nios2: Convert __pte_free_tlb() to use ptdescs
Date: Mon, 12 Jun 2023 14:04:16 -0700
Message-Id: <20230612210423.18611-28-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612210423.18611-1-vishal.moola@gmail.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_220549_626081_FD5552B8 
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

Part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/nios2/include/asm/pgalloc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/nios2/include/asm/pgalloc.h b/arch/nios2/include/asm/pgalloc.h
index ecd1657bb2ce..ce6bb8e74271 100644
--- a/arch/nios2/include/asm/pgalloc.h
+++ b/arch/nios2/include/asm/pgalloc.h
@@ -28,10 +28,10 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 
-#define __pte_free_tlb(tlb, pte, addr)				\
-	do {							\
-		pgtable_pte_page_dtor(pte);			\
-		tlb_remove_page((tlb), (pte));			\
+#define __pte_free_tlb(tlb, pte, addr)					\
+	do {								\
+		pagetable_pte_dtor(page_ptdesc(pte));			\
+		tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 	} while (0)
 
 #endif /* _ASM_NIOS2_PGALLOC_H */
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
