Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5578EC7EE23
	for <linux-um@archiver.kernel.org>; Wed, 31 May 2023 22:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g+7H1qfIYf1fNGxI3Phvl1pS+jb8CrSRV05JjQa8MlM=; b=RoGqw9iy9rf/iL
	N2GsHie9yL2QjOyNhW+zs+6kcE+m+QD45mYRTI8/5E3f6WCqknB6UqdxfNFLZz2HEMdRc5IHRHjjl
	MtaFbd7MOZ/TLauYAnwYv2PcQkksf31wbgJgPeih9l4ZJ15wwkmMxgh6JXPATaO3RZrZIahoXxcfW
	zpMAYHywxz5QHwwGILWqHxD1sDVcvXIKoGXEhqotnzOYvIoH7MXClegVcZZminypnTnIgGDUO1xrE
	2w6jhYJCu8yybd47Us4nlb0QLl1Exxj156uuQFTcGouRbPoOWXZcgXgmF0bcLprsU516OhPW4NVKq
	TcjgSk/mLNSJq6lqFlbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4UVn-001LYN-2j;
	Wed, 31 May 2023 22:41:47 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4UVl-001LWt-1E;
	Wed, 31 May 2023 22:41:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=cQ/uV998f7GBK3U8fEwXlOSI96PW+5wzkUNMHiphdSU=; b=W6dksV6HhzkQPzAEa96+U7hafS
	B8KUmYSgJG6o6e30txMnAwBGe9dVSyXQkk7axrAOoT0h/b9zgRecb3fXOAb9MYBpi2zWVlwZ7InmK
	6vLwlfoUVY3lhfLUObESQiyUSAtjp+Y7EgaDAhjETlV3ZHza4+VW4e8ySiCQ18pzLTCP7aqb1Rghn
	5D/L6XJWxjSlJ4jKOi/RGMFE8mY6YekioSF5kbCZTJO5a/wG6AceZSv46lmWQTbawQxJH9m+cTfpz
	+V/d4WFMp/jgBWbGEvEvhPrCk1jNqVKG9C2IEtaPuZwJXrauzUqz4j+9C9RIEGRsQTyf3sX/nqc+3
	YOTj2W8A==;
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4TQV-00FdKp-0Q;
	Wed, 31 May 2023 21:32:28 +0000
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-565e6beb7aaso743157b3.2;
        Wed, 31 May 2023 14:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568734; x=1688160734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQ/uV998f7GBK3U8fEwXlOSI96PW+5wzkUNMHiphdSU=;
        b=Gco7uaZ8T0f7tmyth6uZeLtIanv6GpulpDiuQwIsnzqnPkjzJkIu0h1PZGQ4iQfI5A
         Wsvmi3eI4+D34lVcMDUsWRCETH5qcZJ6o4mHbMVq/3LTC/HNm7eQ6q2KfFVCA86f3d3I
         LxBFjI2qJ2MPH41lEvrCJnwlKDxe1mBh52b4jr4phbiXUV/rBKhdQfCzS+0QvKIx+CwJ
         I9nD3g0MgWbwsz1cldEhhb6oFNl81Iu/IWeIlG3kHhqR9NOaQpioUXIEm19YojgZVH7b
         YKNDEnmfXzRXtSrjS8AB8ePFyFPpDGIfkcu+Z1fbAVxcvdW9nHAWNVZ44Hj2Se7PAnUx
         U49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568734; x=1688160734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQ/uV998f7GBK3U8fEwXlOSI96PW+5wzkUNMHiphdSU=;
        b=iebx7+f+Iz8/3FWrr5YPdIMSMnhVXHqLYwKjh7AjnJm4Ftwj7Q98lbPK8QudFMaVAR
         YUjAEZKt0u0W7lYcTu43QGZkKk2UokGtTqwtEYcowIHFQ95RY5rdoBK4eTycowKA2/pe
         w3uif7yzcoHy4utE83TuvsGYdw7Br/FevhQ688asJ+oc9ME7BSCNgr33uKd5cPmx7M8/
         S7obmPRx0GzHlv+alA6kGfsHlEyK52dvbXYwE+N9VN55yt54upOvP7Kudmww4suOFXJa
         T6KjskmcBntgRUxzqJQGxrMzZOvjj64DCBSNYPt+1j4nZkeYQAvgcjXGRiZNm7UC7AGV
         KZCg==
X-Gm-Message-State: AC+VfDwG/VPQejKeid5kHEZn2/3TPwHxKG7uUjIAf+ff78DOk+gLpZwq
	OxieIjjQWNKtExzrLReDWiE=
X-Google-Smtp-Source: ACHHUZ5gIOI1fuO3+omWI3ZFi04M+ls0ECM5yJW/hGOTfIhuUEs0QHIWlyyE93+ta0AMRd/Bn9r+fw==
X-Received: by 2002:a0d:db15:0:b0:562:6c0:c4d3 with SMTP id d21-20020a0ddb15000000b0056206c0c4d3mr7636270ywe.13.1685568734582;
        Wed, 31 May 2023 14:32:14 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:32:14 -0700 (PDT)
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
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH v3 33/34] um: Convert {pmd, pte}_free_tlb() to use ptdescs
Date: Wed, 31 May 2023 14:30:31 -0700
Message-Id: <20230531213032.25338-34-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_223217_440643_CF1522DC 
X-CRM114-Status: UNSURE (   9.45  )
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
ptdesc equivalents. Also cleans up some spacing issues.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/um/include/asm/pgalloc.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.h
index 8ec7cd46dd96..de5e31c64793 100644
--- a/arch/um/include/asm/pgalloc.h
+++ b/arch/um/include/asm/pgalloc.h
@@ -25,19 +25,19 @@
  */
 extern pgd_t *pgd_alloc(struct mm_struct *);
 
-#define __pte_free_tlb(tlb,pte, address)		\
-do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page((tlb),(pte));			\
+#define __pte_free_tlb(tlb, pte, address)			\
+do {								\
+	pagetable_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #ifdef CONFIG_3_LEVEL_PGTABLES
 
-#define __pmd_free_tlb(tlb, pmd, address)		\
-do {							\
-	pgtable_pmd_page_dtor(virt_to_page(pmd));	\
-	tlb_remove_page((tlb),virt_to_page(pmd));	\
-} while (0)						\
+#define __pmd_free_tlb(tlb, pmd, address)			\
+do {								\
+	pagetable_pmd_dtor(virt_to_ptdesc(pmd));			\
+	tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pmd));	\
+} while (0)
 
 #endif
 
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
