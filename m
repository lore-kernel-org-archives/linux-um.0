Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F01C25B7C
	for <linux-um@archiver.kernel.org>; Mon,  7 Aug 2023 23:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MFVIZW4v1YfpIHNFEDwltEzfUJ2p5BcQR5j3VD2udi0=; b=GzW3vBpzVmQRcU
	KZNO93WTshByReAQdA9hcxZQffowDPWDJFl2MkWMQinZEo3znDCa/4pyZ8Km0mPkG3k5z12Yu5YmA
	rEoZg1nwbzOJ1W5DlD/xsuOixQUJhKt20WxoDNlbw/NyYCg4EyzI5F3CZBkbLb6+yaar5ChoC/Zq8
	JX6f0rSZbpGp8+o9DBZpT58/iPu28lTlTNQY0bg6TSBHYdS6e70U5v/DP1ivtzcIsqyvIWyoS7ES3
	RBjFwp0aXcdppqD6gJj75dgQ9JogWI57VKp9l+NQgMOeLl8EqhuXyVqCVhEATffvAP1FhjsLcWK1O
	EAVNNrWGex7FjKdrOkmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9L9-0017yO-0k;
	Mon, 07 Aug 2023 23:08:43 +0000
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9Ie-0015ET-2d;
	Mon, 07 Aug 2023 23:06:12 +0000
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d3563cb41e9so4205604276.0;
        Mon, 07 Aug 2023 16:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691449567; x=1692054367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ke0Z6VjA86Q0iJYCAtHmQzMGt2iXqJZdkl8QiQF9dCo=;
        b=W+7e7ZXA6pq6bkOdiU4kqXMdaRoaFiJYq1YjNheTen2BEAKrJsHyDCwylC8TwIaELf
         OoOeKnKEm2Bup1E3lQkfzBFhNx4UEQeZdbP6gFS8EtHNx1s6wSSR8pJNy131BEuCYsID
         5yHclRtlDqB0YUpxc8mp/j3duvqB/kcSwVKs7titgSAxTd3bahGpDvqB1s5BR/l1Q8b5
         JJTz17F1sukT0v2fD4c6TeVfoKxL+4R8ZKOAgjggAvDHXskwAwGz/9+hK5mkw3BMis+2
         8wcIPPvCrUvFi8Oxcy9SzYIpq7haNxXeYlICDRNRlufgVcr5TYo9K2btnO8SAcdlpPvp
         77sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449567; x=1692054367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ke0Z6VjA86Q0iJYCAtHmQzMGt2iXqJZdkl8QiQF9dCo=;
        b=R6P5MIumQ1oQn3hg3ymp97shg/Hfj6izaNgd1ryIGmCseifA/fvu5YQTWsCZ64BXmV
         2D/wEONl6RS1e3XVjwUXPTroQEVtWaewCOz5e4l5CBAM6OqHFczwsKOyI7ZRoJ2L8P6B
         wTzTgn+o7kU67GLgq887UiP4MqOR94un6JjHCUsbxTuJh+KQ4xGxq8bQdcUDPd9GDRNk
         68vDVlkMS5UJat4W6aMk8Sxs8lMIKtn9rA5BzZegFXUIC37TeW2pKsemYCP7npl0oYy8
         InMEWIZqEPHGIlcWSFtEKFhevMW+kuVhQ/Gka3paxm1rPNFs6bgnUyBKfbln0xmqYG3J
         l8Sw==
X-Gm-Message-State: AOJu0YwDCQdqxSv0RCYcG5OTpUF36YcuZQ7CNxO+RlmxalDScnHU7V0J
	tKTVZSOkvOmzR07U7lpaSPo=
X-Google-Smtp-Source: AGHT+IEFwZzf7hWzCaDcJ0rf5o011LKpXcZZ+QgyAwbXtivToV2K1Z3qkIAZZunAX4r/XJQivv3Vpw==
X-Received: by 2002:a25:29c2:0:b0:d4c:f456:d562 with SMTP id p185-20020a2529c2000000b00d4cf456d562mr4842541ybp.1.1691449567341;
        Mon, 07 Aug 2023 16:06:07 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id d190-20020a25cdc7000000b00d3596aca5bcsm2545203ybf.34.2023.08.07.16.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 16:06:07 -0700 (PDT)
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
	Mike Rapoport <rppt@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH mm-unstable v9 24/31] nios2: Convert __pte_free_tlb() to use ptdescs
Date: Mon,  7 Aug 2023 16:05:06 -0700
Message-Id: <20230807230513.102486-25-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807230513.102486-1-vishal.moola@gmail.com>
References: <20230807230513.102486-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_160609_000405_CACA62E8 
X-CRM114-Status: GOOD (  10.55  )
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

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: Dinh Nguyen <dinguyen@kernel.org>
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
