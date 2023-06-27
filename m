Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1F5C001B1
	for <linux-um@archiver.kernel.org>; Tue, 27 Jun 2023 03:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LSkxPGD1P0Ga3jFU/oewitUegGEc4O+cID0e7aE6Qs4=; b=QOOg8DuEnDd/w9
	DtzArLkioyXkGoQoDA1wOVRm3dYeSxC7NqAHoNj3+a3RaL7U1vdHH2v2jdwI+YkXTNqr8loABKvqP
	JYgKS+7c3ZUHGjB375EuFkbeYjz/NLZZWDFozJ7YSumH1UG0deUdZ1PNRkTgOQcrVMOo2ku6nUfG3
	br/Hvkh3bkm7vVUQmNXmXVBxIazjb9EHWtYgR9XMkrweQBTkNxPPXVPdZxKxJhF9vhCONFNwD6sRT
	/9YjJUP5/jF4asNnWiIm16whtcjkNr6DkxEZPUKI9uqQlcJ5+dhYSxY2Zf4T3FkG041FTX6NpwuUV
	Vf1UG8FO7u6NtPulJd1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qDzF4-00BZfQ-1V;
	Tue, 27 Jun 2023 03:19:46 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qDzCV-00BXAG-2x;
	Tue, 27 Jun 2023 03:17:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=aUnc1suNAj/KzreaB6s7vAsOWiJZx3FNBLzDbQjj/SU=; b=i/eXJkUJiTGUKNPvHTmP3aHskf
	dfH6N8sgp/VsY0zyoqKzGPdoFC4OmukcrPqGKEACffkaIzWKxM5UuGtU6tAcF2gz8ZarfZqJuUZjA
	Dxn+nSjtN/ntkcY5G/TGJGppzIISZQrVd3EHIhExaGnQaJJQmuQpYoDd0mQYiNF19L67Hhl+EDjjC
	oIu7h17COb6Moj++dOmw/s4QkR/WBYra7HEuIYo6yKv8yBZ7RS+VroJg1IZ8QxwDd16dSCcZJqezi
	+IyErA7Fjg5WVg/uNH8VEG9YswDiPfL0h7XtHpueKkVa+g19tjw9QnCJqcFdzg7A1LyGm0SirTNRK
	vxDl4ukg==;
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qDzBO-004SyA-0V;
	Tue, 27 Jun 2023 03:17:06 +0000
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5701e8f2b79so43163487b3.0;
        Mon, 26 Jun 2023 20:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687835754; x=1690427754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUnc1suNAj/KzreaB6s7vAsOWiJZx3FNBLzDbQjj/SU=;
        b=m20u0ufiAKGaCJ1eF+oXsWKBIRL5JTjyvtae8lqFZvtXfIrM7cJtjjAu/m4Uz73Z8l
         2OzyWyLCkpN3ueHXh3OYTXgBp8fMDOqyT852NuEeBcWkgEMJmVKnx3KmXsByRx3AKFHF
         Vg5wuji9LMQRgJRH1HqmX3jxPY497r0xZlE76FEouiAeDZpP9QjhFrAgiTXpIz8r0/Pn
         raAur9OcS2AWjvRxW5kW7BBQEK8M8XOe3JN2fYON+zb1b/iUEGPKmhswAXipr/RMjiJ1
         5Ou/YPdkNRNCdvvgrCiDyHNc6JnGXPl8TTudPcGz7r3XrC0of8M4idYi+6qLUVc137gj
         TxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687835754; x=1690427754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUnc1suNAj/KzreaB6s7vAsOWiJZx3FNBLzDbQjj/SU=;
        b=ccdZ3NMQcNdDLKEx6VEWpSTmTZ3w8K8+1Gw6T3y+VKPaZuRMM/8QW/mg1uzaZQVGas
         IC8szdy582WjDRhdNOzzDo+fFesN9aGPEtNObg/BxXFAePTlLXwJT2w5QK3iHRtDMwvu
         7BzGeNUgkLgD0RD4/sJTwaZiRR4WBX6NaJeJ6iO0sy/r2wKzvM8Fkva43lO7+ITiN7LA
         EXovdNkCWswKdC1BwPtjBQOl653IYg8g1Ro8eTOOHoxjfLbtjetA+2X1PePM8xIUmDHU
         q7Lx7bJO4Dpqb2VwM2a1bmb7U4VBwFMa0Cr1mCzAUt7YzVbgXg4vgBEWniBqZ1R8qpZf
         T7NA==
X-Gm-Message-State: AC+VfDyjl6reNYkImT7E/E8l4kBtshIGelC+FKWXduPMz0l+bs3lqNAJ
	ZkiHr3L5VZB+XK1iXyGFvLM=
X-Google-Smtp-Source: ACHHUZ5MOzNqvj1LDJTcnkC+L2S0i67qvPaFwWjlYeZ+6A+ljBIE978bk3O2AZxZRJ0D8kmPxN2z/Q==
X-Received: by 2002:a81:7189:0:b0:56f:ecdd:ded7 with SMTP id m131-20020a817189000000b0056fecddded7mr30983642ywc.10.1687835754377;
        Mon, 26 Jun 2023 20:15:54 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s4-20020a0dd004000000b0057399b3bd26sm1614798ywd.33.2023.06.26.20.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:15:54 -0700 (PDT)
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
Subject: [PATCH v6 22/33] hexagon: Convert __pte_free_tlb() to use ptdescs
Date: Mon, 26 Jun 2023 20:14:20 -0700
Message-Id: <20230627031431.29653-23-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627031431.29653-1-vishal.moola@gmail.com>
References: <20230627031431.29653-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_041559_139013_9A0D45FA 
X-CRM114-Status: UNSURE (   9.92  )
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
