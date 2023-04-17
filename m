Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53234C77B72
	for <linux-um@archiver.kernel.org>; Mon, 17 Apr 2023 22:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fLqJJ9CdOg0Hc8ZrEi4j1RZgx/lYnnr+YgPmlxWdMSw=; b=DCttUiku9el/EH
	O3KCvfppmpP3r6OrCX74GACRIheI2Rk4NFxYEZRseKaoqj6utszfFlyi9fRQ0lsCUD/M2GUnxWtWa
	4GYt6Uu8bpTEeATdTfGrMckjodj1lAVurMQT9IPW6XJsVU3y85wk8NR6tM96dzPnv3256ZiQvucy/
	Q1igFFI+DMk1uIA/3naJbJIpaIRPyLnVW2/tZc03afEvub2S2P8qmmS1J/K22mAXd7KHNhYTXHk6n
	U+qBA/2pJ/Mddu5n3fWu4qb82igRQ7TEy5mBBVOvAY2eFTQEyi6yfmEpls7cGV69UWcSxKQXw0feO
	JSHlUDa5ThgkSghlrMxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poX8A-000FPK-32;
	Mon, 17 Apr 2023 22:15:26 +0000
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poVys-0000Sb-2W;
	Mon, 17 Apr 2023 21:01:48 +0000
Received: by mail-qt1-x82e.google.com with SMTP id fg9so5826834qtb.1;
        Mon, 17 Apr 2023 14:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681765305; x=1684357305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8/b+eKq2obnq3wrn4AaChyOhPXbZKipyE2UTOB7XHg=;
        b=YGyF/lRXi57yzQpU6yGhUd34w0xiVIOwmZrpq81JH5gIE9xNTUH29k55rkhMB3sVvj
         XnTpTYyM5qIsmRDN7vZfBofgG9LlkIybCx9mImgGE5LB+uJnAQQmRM6ZdiLw7bNCd1lI
         AHfS3AasnwMMyxJGTi8hVUyuhvfeiUouS0JVjdlBAzrKo42J2lVZtbD00OjPAM3exRmn
         Fc2duat7XH2xdyKhBy//m1f8NAKsQTQEnonQlgNv+GMuPCit9eYAGWjeTBI89c9NkqrF
         eDbGmgv3YoohdrJJwCItXQ2z9TjUQNyd2ydtHDFgMeVvGyrk1NS+PpqiFbMGdRmx5nRp
         KVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681765305; x=1684357305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8/b+eKq2obnq3wrn4AaChyOhPXbZKipyE2UTOB7XHg=;
        b=TITCAZPGC0xNjj4R96G3CLUgsFMI8mbMUlqf2GGua/Y8dSJiVcrqmVNezYbe6pJwaN
         hVJ9B1YXjrcRdTf+u3Iv3Pcgz2Ew6SMRIJYx5bz76npcFk/PqFaWRUl9ZqWHSQ8T9VXJ
         01Ffz8Wsh/btyY8dRVJ7S959ules9EdvCrNnV8vtmKXIrm9seoq4JFeASDy+g1gp/+ze
         DYtBZYPjUb6TjsHUbzOjPywCUvKS12lKE8cQZ05/HmvGXTI9WKM2PQK295TL/h8tGS/j
         wE3YR+KS41+KXq527QWFp4U6AwWGJNOZw+lNOLxSR+U439Ej0b/oyltFSFbpKzv+Ls62
         FLog==
X-Gm-Message-State: AAQBX9cTfJQunOrSvohcsLfkd8+gvK+UuDpIbIMER8DTww+Gv354j86H
	Ua6CDH+DH2X/6ZNSrarx5vgzOwAtMRRLTw==
X-Google-Smtp-Source: AKy350Ygryz7WWGm7uHh1637qBCeDzWZK5X9wTShPkAHp+hvTpFfVrAPSXU4dDYY+IJtVCH6njxkhg==
X-Received: by 2002:a17:90a:4144:b0:240:973d:b436 with SMTP id m4-20020a17090a414400b00240973db436mr14169767pjg.49.1681764809815;
        Mon, 17 Apr 2023 13:53:29 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:53:29 -0700 (PDT)
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
Subject: [PATCH 32/33] um: Convert {pmd, pte}_free_tlb() to use ptdescs
Date: Mon, 17 Apr 2023 13:50:47 -0700
Message-Id: <20230417205048.15870-33-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_140146_824258_EC23E034 
X-CRM114-Status: UNSURE (   8.32  )
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
