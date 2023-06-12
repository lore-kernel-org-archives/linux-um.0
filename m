Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDA5C7EE43
	for <linux-um@archiver.kernel.org>; Mon, 12 Jun 2023 22:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T8RpUJJ9290U/4lltQGvqQi7HzzdVjQEo1LfNdPN4Fk=; b=CdmCGpFROxtyUD
	MM+V0gJcnhyyx2vHQzZytl4cGw2PO40ubJXF+b6l6Xvlf0Ybfz0YzVkhyZhaJU2P95MHET4WwCKWE
	PEZ4JWeUZwjOHAs62SVtA4j/t2LwML1R7vQSAPF7CZ8waquf4a4nfHLK/YfB2LAHQEXz/d37TVzju
	8g/uii56SF/jUOTQOsM7MUM0eNIMOCveDJrhiWTYIUfKcEpE2MKC3TceLZRe50vQz5Ykc92XxFqZA
	Wv/ViceKcl5WJVAw/xo2kOYU1zL7TtatAbKu0f3B51WdtbEv9N9bohaVMHeRkUrIzXLl/utvYc65n
	za3aN9qzKMuLrcKMtY6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8paE-005cR8-0d;
	Mon, 12 Jun 2023 22:00:18 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8paA-005cP3-2j;
	Mon, 12 Jun 2023 22:00:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ELrYSGf3rZcM0SKncNLanyoUH1rFlxcI1YjdtaAHWOM=; b=F1ByNlRjil0AoGqLEyAn/K/P54
	IgTyyaegSJtGiUpEJbKJfJRudBDoRjNauHQufne9kPcpC208favzQwMn3aUwhyBxTWpbNm7n4VeRH
	hN4kH0IkhOplBPyUqIawKTz0QpDG60MqUNLZIPNZzR3hOCXtcGUHzjxGjOeMuFa3lnQiULRVRdEdv
	/nv+/28JkrsWJH5rxB/IiSR1W1I/5wiGp8ZtabzG3BKjbIlRLmonI7gPP/mSoCmiwMIDJk3dGi4Xq
	PMvmYN1WjIc5ahyJUbctLgQXQ4QQ7LSB9+yikBoXRlDSQLH8ENf+STQGJ5cPVRUZSG1xRuOACOGOp
	L93j1TuQ==;
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8ojG-0090i2-24;
	Mon, 12 Jun 2023 21:05:38 +0000
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-56d047c92a8so25739907b3.2;
        Mon, 12 Jun 2023 14:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603933; x=1689195933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELrYSGf3rZcM0SKncNLanyoUH1rFlxcI1YjdtaAHWOM=;
        b=LyMVzyXqiqaKfQOftnbB5qB90EtUnrbgPE+tRRy8u809McOQMdRt58iULBOhR8JFtH
         hhRJmphgmRUDnbyyXP2Q9YxbwzAkn3ThfcILkwgMQG3ISbn98a07kPZmsAVC8Vehd4Mo
         1biR1LFmmxLwxk8sGkOJv0esnaOWjdr489RSbTn71+xsATggGjgO9UBlAUeAeLB5A5f/
         kGoRSfqAHa+jn1LV08UE8edOQfnKwbxOGGV8ICxkOoxOLTvOaFWF2RtvL1e5xr2jqLU0
         QA04uFGbeM6zqpolABbfncapro6b5DTja8wzwTkJfjoIbnkhTJwsqQTX3z92z2Org5Ii
         BY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686603933; x=1689195933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELrYSGf3rZcM0SKncNLanyoUH1rFlxcI1YjdtaAHWOM=;
        b=GofQRT+kiS2vGvyDtTy85394gmv0z3oysr/MX0zWE3UiOXD8MSeuvm3ITgEqkr2PiF
         pfNblA7ba183hA8fXBHpPoIcNozR0oy6xhCYer5MZkFfrzjhaoWsfu6/6WPNTQ/8jhVv
         VnSPY6+Zs6sAubXL9s1dVUnKidEqYXJUCuzKmk/cdVokpb0qxL6zjXJLOw6AQa43tFQa
         RgF5onsuYB6T9bZ4u3jJC0lhu4dHihe2L/nbxSxmSN1BkbT3ZII25zv6jaLtONX9/mYl
         Ib/pbqgr5l+dcLQNjCWZH2TmzWm6eoxSolB+XWhkwfGW3n9zHbBQyjSBznkulrRDARgt
         ytlw==
X-Gm-Message-State: AC+VfDzUeMr5g0mKyNhQxSzOt+HmZYnKc0he5SqUh+NUjZ/B4Y1Vl4of
	hYdgPXWeMd+25DUmL7LO9Wk=
X-Google-Smtp-Source: ACHHUZ7fItlbNlNZv8dpxyHqv1w2q3utm4HiSoRDwiOPIqWB+aVpZeSy3j3Rf4mLiiGsI+aWaI88yQ==
X-Received: by 2002:a81:8942:0:b0:56d:1f8d:b480 with SMTP id z63-20020a818942000000b0056d1f8db480mr4434878ywf.25.1686603932812;
        Mon, 12 Jun 2023 14:05:32 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s125-20020a817783000000b00569eb609458sm2757115ywc.81.2023.06.12.14.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:05:32 -0700 (PDT)
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
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v4 23/34] hexagon: Convert __pte_free_tlb() to use ptdescs
Date: Mon, 12 Jun 2023 14:04:12 -0700
Message-Id: <20230612210423.18611-24-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612210423.18611-1-vishal.moola@gmail.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_220535_087935_06682F99 
X-CRM114-Status: UNSURE (   9.65  )
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
