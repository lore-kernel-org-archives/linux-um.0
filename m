Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C6B1C04FE1
	for <linux-um@archiver.kernel.org>; Mon,  7 Aug 2023 23:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xzzhsRNX1JMmYu2OWkk92Ngub3TUPSh+tSiD+QRuN1I=; b=PJu47Z0t0dVL7V
	h1wqeq7HQuKZggOQDunhUEqU0fBYsKDX9SBdRnlHfSyFqsYb0JmaRSLJMtAP3fHnGvZpD7OaXZ1hl
	BRvvCK+cgIyM7ThuoW9OLUDGz6+zf4RnqL0WhIbrfcWgUERp5eQCiVgwdNsic/cNmr+ypBsgrZ/mu
	SsKGm6D+YvzLnZrqgn7WxCz+ru8eALmN1MZiNBMPppcVKf7OXT8ZnHm+Uf4l2SLctM2ehrLp8OGZp
	7bIdgxzTPd+Mys7zKTH1yJnFfjN2ZcJ1ldH3qXYVK2ELj21KGb29txlyRcCDHron2qGH98GY9HNCf
	rHZv+eSINcpey6n6SCww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9L6-0017vJ-1s;
	Mon, 07 Aug 2023 23:08:40 +0000
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9Ii-0015HM-18;
	Mon, 07 Aug 2023 23:06:14 +0000
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-56d263da4f2so3630554eaf.0;
        Mon, 07 Aug 2023 16:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691449570; x=1692054370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XaHpTf3P/utbT17OPG/H5MolPsiYyRMVXSdV5AvoHU=;
        b=GmyaVrawFabDS7oM/FJ2wsqOTnvNiSZkWHllyllBSGtBhNSpEmhqjU2xmr+48gvMwO
         LUXnCk58UhmfTImv2R4R9LNF0+WlzxXIVQ4Y7ZC5fEeHoGrn0o/ogRSADB0Y+NluFrtN
         MrrlZ4Lz/gi5878wRIWP06wgFFKVx+8i+ghKFpBHekPx9T0p+3sqj2xh34rznNB4nw+U
         O7FH+uzt41O2vvO9FAauF/idvM9r4rw7Q35Wwsa8GbYTT2MLxcQcKcfZ8291m/c55wrV
         URc64VPnBpaXKs/Bni+oDqsCjGnYy/ppZbjbVbnispVrc0PlqosfX2g85SuErvT0W1h1
         o3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449570; x=1692054370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XaHpTf3P/utbT17OPG/H5MolPsiYyRMVXSdV5AvoHU=;
        b=lmvcu/yi7ZAnWVk8t40zEoJY6CU/rxZkq/4Srcf5HwHfVmgAnVoXQDpsQd0BTi8Ru9
         eRQNHnqU+h7JTuF+ALzXcoz2EKoW5/1H65Nh3wnk0dluVzF2lGEdvQkgfKSHcUeb3Hhx
         c26UvgdcfeXmdCpsnYGq4t6j+Ku06q0XB4MLE8LZXDKsASMWvAk/g1+AZgJyepPfBDzo
         Qx/RyO6pU7cS1c8+Y015218E6pDAYJiwj+E5qdFniB+uogEdzs7rTUOPoRsnlu/nbPBX
         5TX0paqNR55g+L7BneoCydI1JE+56Fk6jjwXe8eXG3IguQwkp3LTfgH90uwORs9Us1e3
         7cLA==
X-Gm-Message-State: AOJu0YxS89xjT+wiGmmtgR3PsC6LhcTItG2adHp39AYVEeHqSw/mR6Nt
	P8m18dT7Yl0YkdreK8rd0Ds=
X-Google-Smtp-Source: AGHT+IFfR71b5uGC/N7nUJvkV7EEf+q4ZrD/2jbgt4p5+XAZUesJuHroaMR2T6Qu+08oLKK4OIq5Tg==
X-Received: by 2002:a05:6808:1997:b0:3a7:5314:e55e with SMTP id bj23-20020a056808199700b003a75314e55emr14747526oib.24.1691449569767;
        Mon, 07 Aug 2023 16:06:09 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id d190-20020a25cdc7000000b00d3596aca5bcsm2545203ybf.34.2023.08.07.16.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 16:06:09 -0700 (PDT)
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
	Jonas Bonn <jonas@southpole.se>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH mm-unstable v9 25/31] openrisc: Convert __pte_free_tlb() to use ptdescs
Date: Mon,  7 Aug 2023 16:05:07 -0700
Message-Id: <20230807230513.102486-26-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807230513.102486-1-vishal.moola@gmail.com>
References: <20230807230513.102486-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_160612_439279_C077A7A9 
X-CRM114-Status: UNSURE (   9.69  )
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

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/openrisc/include/asm/pgalloc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/openrisc/include/asm/pgalloc.h b/arch/openrisc/include/asm/pgalloc.h
index b7b2b8d16fad..c6a73772a546 100644
--- a/arch/openrisc/include/asm/pgalloc.h
+++ b/arch/openrisc/include/asm/pgalloc.h
@@ -66,10 +66,10 @@ extern inline pgd_t *pgd_alloc(struct mm_struct *mm)
 
 extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
 
-#define __pte_free_tlb(tlb, pte, addr)	\
-do {					\
-	pgtable_pte_page_dtor(pte);	\
-	tlb_remove_page((tlb), (pte));	\
+#define __pte_free_tlb(tlb, pte, addr)				\
+do {								\
+	pagetable_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #endif
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
