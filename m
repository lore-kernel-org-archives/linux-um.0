Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54946C77B73
	for <linux-um@archiver.kernel.org>; Mon,  1 May 2023 20:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PatGic4bvgK6ZFC9f7Zw4JE/ta3jBtBeq005CFuIXrc=; b=PSTkKkVHjcWyC3
	qvNUmrZ/qqiuYD7Ti1YYg2xTCvC1O9W6vdQVI8A7ezLMjvsBUjeSlvPuEnQP5j3XEWuJQ2/Cd6MTv
	cU9TTHw/E6bxChVrz/fDaa5UVQ51SHuf4K9J1S+OW0EeZTJ/M4pew77geC5dMaG/mSukMaBE/2ABE
	D8yEN/lfIBlpHcaNWQDZU9+PlN4lgCxiUQzSvITKUFrS97+amlYGpaPSREJ9TUMrxGqxtFKqStM04
	VEUapgTJw275YnkLvzJMQEIA+w+/KcJFk8SluOcfUFY2J1kDpyIXp6+oa5mtdsKqRrEZ9mpIuOR1A
	aHVRdAwVoQ5AZ1fmeRzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptaKh-00GugW-0W;
	Mon, 01 May 2023 20:41:15 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptaKP-00GuPo-2L;
	Mon, 01 May 2023 20:40:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=L/HbzXYZlFs8Glr3mCgcQ6yZjaq6zFAfxmTJm9brDXY=; b=qSnKzZpc36S5p1lF71TyxLaq3v
	lVF0nwNbz3+kr5Ao1AAe0FUIBUIvmG8FM2+hsy2NfQnqmvE9j67gqz6LegGELY3Z8nsIeYKLjf9em
	xIoO+PSBUyIE4nx+6pYMdbGjCjCx0zqWZFJo8kdmyMssomRnbv3z2Xe6Zl5uSjXcjaNS1/gg/CeZ2
	wLirQ6FFSULUuFQng75xiaHfckj+HWwvzDz+PhBje3U8tv/Xza2FRxym2PiyqCb5aKXbw28YLgcyI
	UTpOrMrNoq7D76IjHC9KpjmiI+FWjEart3V9/b6N27Zo4vhaYUghVnIGDF/yNCpgwCth+MTIjQef3
	olVdmhcw==;
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptZCn-00Ez1F-32;
	Mon, 01 May 2023 19:29:04 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64115e652eeso29039022b3a.0;
        Mon, 01 May 2023 12:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969332; x=1685561332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/HbzXYZlFs8Glr3mCgcQ6yZjaq6zFAfxmTJm9brDXY=;
        b=YU74FvpHQCK1VqAuVX8r2BjduNpUerOh1yATlR8mKQ/tJLpS2WI1LKB7NUnPZev+ku
         rfgntGzBluAMKuHfK/jms2NgctRzUuZHcxtFDuNiPPeXkbQ7Z48v/aLnoLGhmcKi5okk
         NTHNilz0HthKY/XHg97rKwZvMnLAYPI7U1eBqYo3DUIS7zYhW0tg5v9W5kNg2nZAJHx+
         0W0xkqlDIUsVkMuesra65fGttpYRxCYfqsHDDsc8zlGh06W2A2UnpmXTtrAlRE/I54n/
         9b61gxsFscmWDNDgpJxss4pOhFtz/pn5R4Qs2mfASivX3bx3H5gbzbMc69UUOvWi91zv
         pr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969332; x=1685561332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/HbzXYZlFs8Glr3mCgcQ6yZjaq6zFAfxmTJm9brDXY=;
        b=dM0fLwn63QqlVtCPG5ca9Ne8d3GeEqxfk/4RNvg8j3U6qT4bA06NjIwyPi3Paf/QZC
         Fh4GRwCeA31v7qMQ7hIfUZ56ZWXc8qECEvyJM85mGxPJfjkKPQu5ivedpcwoe3zXz8oe
         4sbkAXhBwU3OQG6F7Pd34CiGekMAIZGFKoAsLFgPU7gP0RwupOobqPcyhrjgNWgyfLHJ
         V8J0Jmw5LIoyUzoqQvmIGR+tpZZ1nGDKu3uRVtxIvxTHJCzxYqUtoQ5crwf7hhodzkEg
         RAE1kITD/lrAzqBHKk9Y1lNPXl/w5BVyHLkc46vVeTmNaNIYkfKuXIjhyAH0Lg3neew+
         MSRA==
X-Gm-Message-State: AC+VfDzpUhlyhn9qHn6wAJwnE9x4QAN0xmYAYRRLaRrfrYAPAJbTWGgr
	j62Gucgf5oaprb8iI3jCc9w=
X-Google-Smtp-Source: ACHHUZ5tlVMWyUaJdG9fqFVZnpLPEvgTINU205p9ECnUgFr/jtV6hdVvJcRfvr33OgCYwfP6dTnMLg==
X-Received: by 2002:a17:902:c94f:b0:19a:727e:d4f3 with SMTP id i15-20020a170902c94f00b0019a727ed4f3mr22987004pla.5.1682969332204;
        Mon, 01 May 2023 12:28:52 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:28:51 -0700 (PDT)
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
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 13/34] mm: Create ptdesc equivalents for pgtable_{pte,pmd}_page_{ctor,dtor}
Date: Mon,  1 May 2023 12:28:08 -0700
Message-Id: <20230501192829.17086-14-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501192829.17086-1-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_202902_701927_6AFCD498 
X-CRM114-Status: UNSURE (   9.68  )
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

Creates ptdesc_pte_ctor(), ptdesc_pmd_ctor(), ptdesc_pte_dtor(), and
ptdesc_pmd_dtor() and make the original pgtable constructor/destructors
wrappers.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm.h | 56 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 58c911341a33..dc61aeca9077 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2847,20 +2847,34 @@ static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
 static inline void ptlock_free(struct ptdesc *ptdesc) {}
 #endif /* USE_SPLIT_PTE_PTLOCKS */
 
-static inline bool pgtable_pte_page_ctor(struct page *page)
+static inline bool ptdesc_pte_ctor(struct ptdesc *ptdesc)
 {
-	if (!ptlock_init(page_ptdesc(page)))
+	struct folio *folio = ptdesc_folio(ptdesc);
+
+	if (!ptlock_init(ptdesc))
 		return false;
-	__SetPageTable(page);
-	inc_lruvec_page_state(page, NR_PAGETABLE);
+	__folio_set_table(folio);
+	lruvec_stat_add_folio(folio, NR_PAGETABLE);
 	return true;
 }
 
+static inline bool pgtable_pte_page_ctor(struct page *page)
+{
+	return ptdesc_pte_ctor(page_ptdesc(page));
+}
+
+static inline void ptdesc_pte_dtor(struct ptdesc *ptdesc)
+{
+	struct folio *folio = ptdesc_folio(ptdesc);
+
+	ptlock_free(ptdesc);
+	__folio_clear_table(folio);
+	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
+}
+
 static inline void pgtable_pte_page_dtor(struct page *page)
 {
-	ptlock_free(page_ptdesc(page));
-	__ClearPageTable(page);
-	dec_lruvec_page_state(page, NR_PAGETABLE);
+	ptdesc_pte_dtor(page_ptdesc(page));
 }
 
 #define pte_offset_map_lock(mm, pmd, address, ptlp)	\
@@ -2942,20 +2956,34 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
 	return ptl;
 }
 
-static inline bool pgtable_pmd_page_ctor(struct page *page)
+static inline bool ptdesc_pmd_ctor(struct ptdesc *ptdesc)
 {
-	if (!pmd_ptlock_init(page_ptdesc(page)))
+	struct folio *folio = ptdesc_folio(ptdesc);
+
+	if (!pmd_ptlock_init(ptdesc))
 		return false;
-	__SetPageTable(page);
-	inc_lruvec_page_state(page, NR_PAGETABLE);
+	__folio_set_table(folio);
+	lruvec_stat_add_folio(folio, NR_PAGETABLE);
 	return true;
 }
 
+static inline bool pgtable_pmd_page_ctor(struct page *page)
+{
+	return ptdesc_pmd_ctor(page_ptdesc(page));
+}
+
+static inline void ptdesc_pmd_dtor(struct ptdesc *ptdesc)
+{
+	struct folio *folio = ptdesc_folio(ptdesc);
+
+	pmd_ptlock_free(ptdesc);
+	__folio_clear_table(folio);
+	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
+}
+
 static inline void pgtable_pmd_page_dtor(struct page *page)
 {
-	pmd_ptlock_free(page_ptdesc(page));
-	__ClearPageTable(page);
-	dec_lruvec_page_state(page, NR_PAGETABLE);
+	ptdesc_pmd_dtor(page_ptdesc(page));
 }
 
 /*
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
