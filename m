Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A84EB64DD
	for <linux-um@archiver.kernel.org>; Thu, 22 Jun 2023 21:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LSkxPGD1P0Ga3jFU/oewitUegGEc4O+cID0e7aE6Qs4=; b=mRm6QQteNYxXfI
	oz09WBPw8U8EjfVhljh6R5gjhqmD7V4k1SG64V4XVHQQp2gmdqhdC56puv7KPplrNKIT1wMQH9Z+M
	lGiSSBVZzFDFgf0reECVpM9hBibCadSzI1m6cZDd9rDrMUMrWEX4krmUk5qJlBCJxFbHlR8bdiX7J
	0JcbdF/EiqLW13ClWBGTn9m9hnXmpKY6R4baXuA+hs38/aKqDOnLPLnYylTLiR4J8gXX/3+Sjh3ov
	DRFg8sdrHt/CF79xHiiJCIO3bdT8c57zyphN7DB2EwAIsx5ZY/6itcBzFnt30PSR4OF7+8ov6PwR3
	ch0yqE6XSiZc7nKUTWlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCRQk-001knM-1w;
	Thu, 22 Jun 2023 21:01:26 +0000
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCRO6-001iAx-1U;
	Thu, 22 Jun 2023 20:58:44 +0000
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-76245581814so521716085a.1;
        Thu, 22 Jun 2023 13:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687467521; x=1690059521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUnc1suNAj/KzreaB6s7vAsOWiJZx3FNBLzDbQjj/SU=;
        b=mxSRrVtskejfc/X16Q74dptO75kex0U1BDLuwz97pVRe94MsJ1tXF/mDBi2+KIRPRR
         7frc0Ipdbv1qDfHMpCRO5VQbJ/DKNN2DmrrOctIElaXq4X1eS2wG1MgKx+EEIDm5IE/n
         dhPljY31cmgrHKk6DhfJfpvGe6V9T4MqXnsXF7ZHxbxJIsBPM+C004kDxiRMae/4a+6A
         l/JL+zpf4vx2gyi8iDyTm65oAYm1ZOIjSFK4K+nSdgPKFtV6K4nHQ1K38iP6GDgp4k/p
         RVulC8Jyfz61VS4MiwEinectlQ9R+QOPA/9MgDEtR4kVqNBk2wlMydoonlFLN2E5gAjW
         A4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687467521; x=1690059521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUnc1suNAj/KzreaB6s7vAsOWiJZx3FNBLzDbQjj/SU=;
        b=iLueGH/c162HjGjTW41s+txRMesgSEiKziYVv+5WkjSjWtddkmF2mKchNYzT77i2b6
         WaHWVqv1DnMsVFU3HOtkJAugEtRNJigVkeq18SkZMBIXdmhwTGzmQwwtfHwZJ1cXEf4C
         vjE0fpo5vVOlot1cRlhc6SnQSKxbNK1FrY5TSWTNiShFFQCHYge5BIYAeLioXf6gxCrt
         Pk0D1pSpfhZ4g2Ey+wFp7T67yaT3Rbnpv+iePH42vIgqvV2Rt4ByniDehAA/UOF2pWW6
         zh0UbgM9sEiO82FWocOyCIS8ISx6otN5ZoL07mJRNqZZcyybPI313TdzvCayPobdVt/t
         HWIQ==
X-Gm-Message-State: AC+VfDyfjgQII79NHmH9baYMZnqMmDq7875kFSqXJND3tnd+8O/E3QKM
	M1JIjNzkgiDr953odUq7f6k=
X-Google-Smtp-Source: ACHHUZ6uwsaC+f+4ISzpiwzmvKryO8fCbzH23CcTApoIn0lsQ518YuGTPwW7f524cMEve6g2SlrGNw==
X-Received: by 2002:a05:620a:c82:b0:75e:6837:19f8 with SMTP id q2-20020a05620a0c8200b0075e683719f8mr19290818qki.54.1687467521509;
        Thu, 22 Jun 2023 13:58:41 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::36])
        by smtp.googlemail.com with ESMTPSA id d18-20020a5b0c52000000b00bc501a1b062sm1684937ybr.42.2023.06.22.13.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 13:58:41 -0700 (PDT)
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
Subject: [PATCH v5 22/33] hexagon: Convert __pte_free_tlb() to use ptdescs
Date: Thu, 22 Jun 2023 13:57:34 -0700
Message-Id: <20230622205745.79707-23-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622205745.79707-1-vishal.moola@gmail.com>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230622_135842_550048_5F701779 
X-CRM114-Status: UNSURE (   9.61  )
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
