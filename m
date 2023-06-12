Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C361C88CB2
	for <linux-um@archiver.kernel.org>; Mon, 12 Jun 2023 21:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vmTlNFQRB92Y7FtvOqGDrS0ZsHcFsWTCkR39mmPE4ZE=; b=VKEIQ8qIV8Z3To
	N6yQLsksTNBAHUBtw21HSe7qgxEl56G7kEkEoh4bMtnZU6dTvAXuvIn9PU+dUpyk1mGEcVEbAs03Z
	p9c4l2Qgn06gjNPDKICr79xgUf2tV/9gW1B7TrpCH9gErWjG5m+Ngk0o8xwdts4vZc7eosGuemvFw
	VQPPtZszHNkM1HyH+aNokf/0qzoQeHtlxdHzha4+cT21yGk92lscIqeonCkJFUP3400+94APTrXxi
	jEq51nhE72j/rfDWH7bh5JraLKdWFZL20scQIe31UF7tsYrF4QTY/ZAwB7DKv/dNdtJM9QTkLXsKP
	epyxn//ZH74oSqw8DCgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8oke-005PCY-0P;
	Mon, 12 Jun 2023 21:07:00 +0000
Received: from mail-oo1-f52.google.com ([209.85.161.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8ojL-005NjB-2e;
	Mon, 12 Jun 2023 21:05:41 +0000
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-55b5472ab85so2188590eaf.0;
        Mon, 12 Jun 2023 14:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603931; x=1689195931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFY2ToTc/KdsqBsJRwbv8KRLKHn/LK4ImlbTce4a9J0=;
        b=Hs3OvBwxjNbzyixj7aSD+NgtYC45wE004i2+DhLM32gwxSgyME8uf0ehUc+DFmEBWc
         xTMw6H3P+HY7Tq7UuCfgFLKB1x+LkNTK02YDaXYWD1PeR9EEokleZ/wyxNBXTFWH/El9
         c1bXL1i+QVcFD32llcBXIuwFJs/8j8fBCHPhcoBGFcfEu/JCwezOfmF0Yorw8OxgwAQW
         Ostw6KM5t1cwURmpaD0hTGMu4TC4wHA6I1gDTQyjBc+K/xsxhtlIAUhVsIG12sG34SnA
         HCLguPK5bJjFlDAoWGoj4Zr1Q8mKdxu4vSYAJa+HTJDnQnTisEOZH/pEJVvGvXlWVYbR
         pDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686603931; x=1689195931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFY2ToTc/KdsqBsJRwbv8KRLKHn/LK4ImlbTce4a9J0=;
        b=kaGpVOLg85b/33+yCsu3DcjIVKEo1Li3xp7RpeWcrbJSfiU9L3/6V+xv7DKxeUqIUz
         AGEPNMPhoqkwnDqrM/Smx6OpkqVeUwFUEjuL06HQUzTIYvV06f/gPEFo1SuCTsmyrVXk
         0nuR+oGP+SiwdGUlDoCDuXmrQCupDudMpEIGzNuqH1Dl6CIhmU3SUdzC5d4im95OIIKy
         7ClPyumn7pi459buY5vSlnAHMu56vEia335pIrzslxrsErlVpQO3QA5tkx9DExM6Kchd
         O02e6JuqxI0ALien8+L55INobF7SZHc8+f/tvSgplOkR2Ug78ziKb7g9US34lBIVaky6
         jZPg==
X-Gm-Message-State: AC+VfDxwWidJoQufYWYEJNhRn+3CcfFtXBrUrykhuPDAJufAuDsq80TK
	61WOmy6Wu7oMFlJjBmkVd3Y=
X-Google-Smtp-Source: ACHHUZ6j3CfgAuZNFN9JISmvDm/MlbHYE4sRUTkol2XKHwfWtbEYLS5pSkDxzuxqJ+njTa+59MBJKg==
X-Received: by 2002:a05:6358:1a8a:b0:129:bddf:7960 with SMTP id gm10-20020a0563581a8a00b00129bddf7960mr4783450rwb.16.1686603930823;
        Mon, 12 Jun 2023 14:05:30 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s125-20020a817783000000b00569eb609458sm2757115ywc.81.2023.06.12.14.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:05:30 -0700 (PDT)
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
	Guo Ren <guoren@kernel.org>
Subject: [PATCH v4 22/34] csky: Convert __pte_free_tlb() to use ptdescs
Date: Mon, 12 Jun 2023 14:04:11 -0700
Message-Id: <20230612210423.18611-23-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612210423.18611-1-vishal.moola@gmail.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_140539_872022_D632E3D0 
X-CRM114-Status: GOOD (  10.74  )
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
