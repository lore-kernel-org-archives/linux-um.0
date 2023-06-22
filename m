Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E6AC0015E
	for <linux-um@archiver.kernel.org>; Thu, 22 Jun 2023 21:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/HjZSdb4wB3dJhZQQOxeFh1iD2vlYz3MlWwNysi/NfQ=; b=R83o6nwDxLylMZ
	mX3pRyVKNrLIa3dpnFHG4mBnuJy1Br8FYkjFdPilXYw0FfgHiEb6aSN/HUsDfBJkQN+32F4uua5QK
	nMFBkTXaFd5dZuvRsm1qcuTfnUMi0L1XjcAbBdnUQ9USx+kSkNldiT3wP6BS9r1UdF1/aYzUOo0tz
	2OXxwRAPARTYryB5hjelq7M+noJffo4oXw1eWRJ+JIUlewfRmWIJkgMl+fEoHWgaa202dYhychBLD
	1nu6WSUkonl/yKoQKPdWxPOZBJe8I4jw6cRaxwiqjPFhKL9iCNIBQzPw3UUpz3LQfAIL3yJ0a5CfL
	8F8SROfzgJrSa1UG+22Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCRRR-001lV2-2B;
	Thu, 22 Jun 2023 21:02:09 +0000
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCROH-001iN8-22;
	Thu, 22 Jun 2023 20:58:55 +0000
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5700b37da3fso71799907b3.1;
        Thu, 22 Jun 2023 13:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687467532; x=1690059532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AnRv7d38hHUVaoAGins0CaWMMRgzo0GwUb20Y9YoSw=;
        b=iN2FzqOQCGlMw61BHmPlvHKCi1d4I+83kYFUJ+05be01GNIJnqIJIlehoUIlvwUaVM
         d/OWGkj4lxemSlNpzjA9vagyXYnKzygaSW8qGOFAS4kKsFBEkls14ZpomWkO/T200zVH
         qlBgWwV7Su2BIgoVpSS5ByD582z4lmvR8XQqnfXM/x/kcWnUDA1l8EH7UvhzGe/a36fq
         qzeiYGkPPC0vXVHADUCnvEqnbyiXBVZ5TrMcTAX4hM8+UdpZhrwM5A+KI61Sp+b5buW5
         P1n/PN9/guunik8p7869oduuP/QEBbbnDZw3HC5F5neXLeBMAmnYdB3CF11sup6NCeqV
         0mxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687467532; x=1690059532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0AnRv7d38hHUVaoAGins0CaWMMRgzo0GwUb20Y9YoSw=;
        b=SHh8RmpeTHTunVvL65AzM8UZSGydKgJ/tZvMxxpUPEvPn+Zkv9OzaYHRcWujgtwgVw
         gfhkzji5ayoeaXCsIsgvDrMjYrwSDi1+5IF/VNFCd9vP6wfJ82AwyFukiGtjinTRnfNn
         T+BJZVeydD5S0/4WWjXis4z9QnIHQ7An10V2oR0j9BtF2aKHKp2oF2RmYrJaWIQSuDMn
         6xvzD0TEJ/pMGLnIh/MqSGdQYY+GIH4uo41X15DuuYFspQ8VBmdUTzNrRpbPCXH9mpID
         hJLck0wuhJTjjPPvTrchQn/YtitoejYlTS/AyWCLeiPTwmpneHbpnh0tnfX4HGSETJIn
         TT1w==
X-Gm-Message-State: AC+VfDyOGT6cvqYEFqHyffbtM1QzyxjUwSmiDtUZsi0/y/4jeUVHvIRP
	fJtG+LKOJnu2Ql41gfyaj+vwbHTI1lWoQA==
X-Google-Smtp-Source: ACHHUZ4L0O/ZcQJNV1a5FO9DGWMsGkRAWmV2oZ5bMU1z3VMLdsFOJ9p+X6w0stYIYuPTzeAJzZnheQ==
X-Received: by 2002:a05:6902:1cf:b0:bff:78f9:ffcd with SMTP id u15-20020a05690201cf00b00bff78f9ffcdmr4883793ybh.38.1687467532210;
        Thu, 22 Jun 2023 13:58:52 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::36])
        by smtp.googlemail.com with ESMTPSA id d18-20020a5b0c52000000b00bc501a1b062sm1684937ybr.42.2023.06.22.13.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 13:58:51 -0700 (PDT)
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
Subject: [PATCH v5 27/33] openrisc: Convert __pte_free_tlb() to use ptdescs
Date: Thu, 22 Jun 2023 13:57:39 -0700
Message-Id: <20230622205745.79707-28-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622205745.79707-1-vishal.moola@gmail.com>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230622_135853_685491_EF469E86 
X-CRM114-Status: UNSURE (   9.44  )
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
