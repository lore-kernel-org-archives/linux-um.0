Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3176EC77B7C
	for <linux-um@archiver.kernel.org>; Mon,  1 May 2023 20:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fLqJJ9CdOg0Hc8ZrEi4j1RZgx/lYnnr+YgPmlxWdMSw=; b=wSPbS2VnNan5XV
	hQPPTUjXqX+eqZMLJvyJRl9yun+4q9LDmnTqb5VZh4mrXlmP2RW5AqMWpfcIJGW+6q6OjA1uFYdn3
	fp0GSIKLgItKXdCTwEj8b+Lj9xiYnr++oQXi9aw6T7mKIiws8WbWAnc7yICNGGiNeSNmjjaw+7alm
	/6a0SyQSZTc8IAD6KidT9Q5duluUPXUnrWcRjEv8TfGO7pyoAEbjp2syDj1QAurDUE40s5Rm1/hoH
	5yq5JajIphh9j1sk25imsndQQHYVJxYOnhMDoqkYDN27mP9HNFqndL+zY9JAsUfJYEkWsP381jzNG
	OEU9BjyS8V6cdmwjdgKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptaKQ-00GuSK-18;
	Mon, 01 May 2023 20:40:58 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptaKL-00GuME-1a;
	Mon, 01 May 2023 20:40:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=m8/b+eKq2obnq3wrn4AaChyOhPXbZKipyE2UTOB7XHg=; b=p2WxVEaFg+NpsAkDM/t5w0ZElu
	porNyKj4/zjdMvr8vBBDbsqYAkkLAPkDVPKV5vdIMA4WBW4IsbTMdHmwsMoEAxOtrmblIN+4gls89
	vzMcVmv3zWygOD3H1ehr4Rw3J8yxpBtmYikf0KOdMkEjGmZXSjxjcrbU23FKvPMBuy+U1xwiClqu1
	gJluo9lRK04vY3R9ZaqRdyEw+WDlQikgr0zTQ0H2ZlNrsgu8SqPuPQ/SUVmvSe48Cs87lLP99Z+7R
	FCtbM/B0J7BW4os3dLY8A9lM6R/pOwYBo79kCoGDeVU2JSClp8EbjNXhKfgf9ZnPEYw/62GTBIX19
	HPTnBUeA==;
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZDE-00Ez7Y-1w;
	Mon, 01 May 2023 19:29:30 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1aaf7067647so9435445ad.0;
        Mon, 01 May 2023 12:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969362; x=1685561362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8/b+eKq2obnq3wrn4AaChyOhPXbZKipyE2UTOB7XHg=;
        b=Q3jl6YttJDwUuWKyn1dVs6I8W94SFWxxciTJdLpT/LELBYCeGyev+ExIC9w29x2Yt1
         zXHIDz5du52vN2frCHR+hIpcwuJ6c3WNhfC/Gsy1nS14RuXHFXtXj5G9xq8KbaH8upCB
         hoZ+KR9ZQITjkQA540sZmLX6PX4iGNe7NpnWG1G2AsO+NZdypSRuEfFuzqh0wPvQQaGw
         4XpO3Q1D/iCtA92s97XY1Or0L7GqG2SHJxpwKx0yuxfIbjPslNXarskrtkCCtU8UwW5x
         DSxt7iwfG4oFpxWasaAVqe2jz7cH5xxqomQxklMjhuQacqvGLIa7+5cde3ROrtfKL2NP
         oDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969362; x=1685561362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8/b+eKq2obnq3wrn4AaChyOhPXbZKipyE2UTOB7XHg=;
        b=M0LsdqzA26brjpB0OzMYet7eL+SQzMtfFRug2zZeZC+02eZgOlDKTgEM6RoQEAhfj/
         oSYEnX2XDekFhRgi9zXASJq84QxX9tUwwNSQWU6HtZS29GTkEuBlieOptmZXx0OoYFQD
         jjdn1harJOjgvB6VZDFS/bZz03sEvebpK1jbWbwpsY8AogJ0BzPfvC0lAE+OlGTMv2vK
         SLt8bmlaR2LEXmTJCvsbQVoTgQj1x0Tp5iuu4TRX9sfr8prBmmRAAqVRbVZj5X2iLhWh
         BBANy/YBmk4RLogXuNtpgPWKTaOj9HN8pcMI6euLmfrx+mT6m7F7/qGCnWQU3jNYt+z2
         t52Q==
X-Gm-Message-State: AC+VfDxRhfdDULAL2RNDtpCPNqzJiHridoAQqHgqmOeFxXiAeAlwZA2A
	t1vsZJ6L3cQlxWPcGrRsYOc9RpqA2CM6csev
X-Google-Smtp-Source: ACHHUZ7SACaylL3/aSyKhkx7S2g1HYBvFG08B1pme9nPnu6u4pSNBbJS188a/Kq3fbmOV3eKOsv72w==
X-Received: by 2002:a17:902:db0b:b0:1aa:e5cd:647a with SMTP id m11-20020a170902db0b00b001aae5cd647amr7875588plx.23.1682969362180;
        Mon, 01 May 2023 12:29:22 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:29:21 -0700 (PDT)
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
Subject: [PATCH v2 33/34] um: Convert {pmd, pte}_free_tlb() to use ptdescs
Date: Mon,  1 May 2023 12:28:28 -0700
Message-Id: <20230501192829.17086-34-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501192829.17086-1-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_202928_903433_040018B3 
X-CRM114-Status: UNSURE (   9.00  )
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
index 8ec7cd46dd96..760b029505c1 100644
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
+	ptdesc_pte_dtor(page_ptdesc(pte));			\
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
+	ptdesc_pmd_dtor(virt_to_ptdesc(pmd));			\
+	tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pmd));	\
+} while (0)
 
 #endif
 
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
