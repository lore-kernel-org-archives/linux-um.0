Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98195C7EE2E
	for <linux-um@archiver.kernel.org>; Tue, 13 Jun 2023 00:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2qAYWhdWPB73P+jHVt4eBNHAPSgkmK+Qy1JOlBW8Bi8=; b=j2BkdIxOkiagik
	YXTXF4/GdW6k9p1O8a77xWNjvuTjGEmxcifIfrZsQYEbeqqNnX2C/I/175XXjPuQF5drKi4xI9jtm
	4S+WjusdxZYP3ONRoZJeQvNxoO/+PeODOWt6Cby6SnXHCUEk2xfZ2dtdr0VlTR6sxZGJM2Do06jdn
	YlJNZoKDa48QiTe4AT7YQ2RLJ8ag23r+wAgmZP5eAuUPMzPwZ15FI+lcLoOlxH/HIWgKPi91Ftfl6
	dapdk7ILdOpTABl5kHvZQh4QKf+ZrBw5p021F2htPRUlg8xS+HWjjfB9GV/TzV26UConM7D9ljf14
	xxup0daOAtoPzEBURQzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8sGt-006SlU-0f;
	Tue, 13 Jun 2023 00:52:31 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8sGq-006Sje-1R;
	Tue, 13 Jun 2023 00:52:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=e/NReaJdz90gZ2NQIlUYsxuwjuA5PoSk9HvAIR22dRg=; b=ZQycMBqM5rPYVjGhIQhejgB4nw
	5GfIvFOmA1a8fuvLb7PS4EAUK1ESDhbhZs8dW8myful5DmeuW0tlapqUuOh7CnT/KCoUPK52cjcsM
	5wkpR+z9fHPQThd2x4JxAoy1M2eQcy6RDKR70yKmgC9MFIa864hNxmWvpj2r1oSEyoffmdElJpOeh
	IEnVSEWGrmEO+IP8+6cjyo0+VXxgpDwa+mUM2vHHiecBmE+j0jYYnBFYXR1o+9rdwdtklz8cPvuyL
	lvMSQbQjk/hRJwfSsvBwC2UmOnKIdT/Wla6VIlw6SrES92gDFNshE318Be4UptzkoNZO3cfXvxwOS
	3pLrMkpg==;
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8oit-0090by-0R;
	Mon, 12 Jun 2023 21:05:16 +0000
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-56d549284bbso2187247b3.0;
        Mon, 12 Jun 2023 14:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603908; x=1689195908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/NReaJdz90gZ2NQIlUYsxuwjuA5PoSk9HvAIR22dRg=;
        b=cJPixJ7fvL8lj4msWoT6T4UdDliAegelx3fhfZFkllamFJSmCzzBfgBkJHvHf5VBH4
         +bFQaX0c9HvMpz3cMr64OoUwpvHF+4NrriYC39tboK0Z4VjLF9J6MmzkevSDnSF+eJ9S
         vsFP6THd62TglAym5r/waWV4KiQYY/X7Hysf9ft4FBrKTw7bicGfQMMhWM2I4CuvKtOv
         cwDTHbNBV8LRmkAEvkAc0kAr+XDxv+lhnXg68dTw4NnjCIip7ummoW4kmN1lP3wtz1t1
         rgvGb1IbL+Qt1u/Y4z+ep/GLJI6yTMWmeJDiLjESMtlIxdtrVlVrtQkxPe5yKm5XHK1M
         0mYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686603908; x=1689195908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/NReaJdz90gZ2NQIlUYsxuwjuA5PoSk9HvAIR22dRg=;
        b=Dg9bBPrAGaq2QhOPMJrFZ/36pCrUZMGNsNOmGEZyzopoZHXsH16yGvz0ZKDWy6WxtL
         HyIJ5pS1NyV/0vDqrD8gR4ZGBYnow314yZNHtcgj2yXB6LV+OVrW9llNFKx54wNxHaTQ
         5ZNzMcPPdqt3/SseFVd+GtRcwi+o2UdUehDrWVZzE4f2/4tPY4lc3AtrIbXnlwUjtIrP
         ZGv72eVe0ZmtYLdn4o3ht/RUdSOFu41uJD3btuh2IfvkXMfDQT3aejlTVbVUmfPAaBqQ
         n8mO3KUfHJfkic84CD08Z8yEgpIb779EoJbtr+OdCxc7fsi9EVD1dtcrk5cpPwXaNAUH
         Ij7A==
X-Gm-Message-State: AC+VfDyMbUdWRQ2wveNMEFISOZb400s5Vl5Eo/psFFzTU2v3Vd4cc/M0
	ebm0hzxINKYqWe9FCho8Kq4=
X-Google-Smtp-Source: ACHHUZ5kijcVYXBTbbFcK1VnPllJL1iB2ONZxmZAAAXhO7jcUSS10Gkxlzbwqmp6U6Z9PG+yvX9PWw==
X-Received: by 2002:a81:9288:0:b0:56c:f916:905 with SMTP id j130-20020a819288000000b0056cf9160905mr7254032ywg.32.1686603908266;
        Mon, 12 Jun 2023 14:05:08 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s125-20020a817783000000b00569eb609458sm2757115ywc.81.2023.06.12.14.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:05:08 -0700 (PDT)
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
Subject: [PATCH v4 11/34] mm: Convert pmd_ptlock_free() to use ptdescs
Date: Mon, 12 Jun 2023 14:04:00 -0700
Message-Id: <20230612210423.18611-12-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612210423.18611-1-vishal.moola@gmail.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_220513_160703_D4A0E0C1 
X-CRM114-Status: UNSURE (   9.25  )
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

This removes some direct accesses to struct page, working towards
splitting out struct ptdesc from struct page.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f48e626d9c98..3b54bb4c9753 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2950,12 +2950,12 @@ static inline bool pmd_ptlock_init(struct ptdesc *ptdesc)
 	return ptlock_init(ptdesc);
 }
 
-static inline void pmd_ptlock_free(struct page *page)
+static inline void pmd_ptlock_free(struct ptdesc *ptdesc)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	VM_BUG_ON_PAGE(page->pmd_huge_pte, page);
+	VM_BUG_ON_PAGE(ptdesc->pmd_huge_pte, ptdesc_page(ptdesc));
 #endif
-	ptlock_free(page);
+	ptlock_free(ptdesc_page(ptdesc));
 }
 
 #define pmd_huge_pte(mm, pmd) (pmd_ptdesc(pmd)->pmd_huge_pte)
@@ -2968,7 +2968,7 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 }
 
 static inline bool pmd_ptlock_init(struct ptdesc *ptdesc) { return true; }
-static inline void pmd_ptlock_free(struct page *page) {}
+static inline void pmd_ptlock_free(struct ptdesc *ptdesc) {}
 
 #define pmd_huge_pte(mm, pmd) ((mm)->pmd_huge_pte)
 
@@ -2992,7 +2992,7 @@ static inline bool pgtable_pmd_page_ctor(struct page *page)
 
 static inline void pgtable_pmd_page_dtor(struct page *page)
 {
-	pmd_ptlock_free(page);
+	pmd_ptlock_free(page_ptdesc(page));
 	__ClearPageTable(page);
 	dec_lruvec_page_state(page, NR_PAGETABLE);
 }
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
