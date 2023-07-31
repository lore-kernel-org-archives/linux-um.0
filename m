Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39FBC001DC
	for <linux-um@archiver.kernel.org>; Mon, 31 Jul 2023 17:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o7CStUpLFB7D9jmiRxAOsU9qI9YOzRKCTqHrJk7whg8=; b=qHN7Um8kcIgkMa
	ACK9l+sE6wMAe1G1ATssm6rA37tIoRcrCWpMCGbZxoy9+i4+0N9RMTygoT2xPG3TRfmBtYH/+o113
	fLX2QjTqWE+VIDU0on7GSw9x1wzHifv8xLT2h5Ikp+9ee2CexrSqatNzS8FOuUvQo+h2p7iOREudN
	KZveXp1mS+3VP+qhhVJpcYNLGOSURB1bBcBA7L2hnKpqePqgnzp7DZ+nLM+pOG/KDNIjDoSuYJpqf
	MVef3FFBdmF9iBp4ZPnI1GuD06EwgIZ0rwgZCviL6cmKtyrhHh5h5DM69AIbpfJIxQ5qe15DiJKEq
	6mfd7fSInpGlw8NfOLLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWOZ-00GoEU-1a;
	Mon, 31 Jul 2023 17:09:23 +0000
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWJv-00Gkjj-2x;
	Mon, 31 Jul 2023 17:04:38 +0000
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a734b8a27fso605225b6e.1;
        Mon, 31 Jul 2023 10:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690823073; x=1691427873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NG13BwzmmAIpXpcduEwvRHFbS3iQhU18W2JpKLteVDY=;
        b=J5UHMtA0qoYiWw4Ld5R0BKI4Tc5AGDSmTkXJ2I6fYmBwlIVDq2NZ9TijiKx7n7oR9S
         O2+0XndgcZyKpOow8lUaucDbgGPax/K8O+lCXFcyUW1OtbVxoGLUMUxT+xXe1Nbotguq
         wXQV4F4SfOD9dJwiO/iz9SNiN+CqscWBWqXkI0FM0EZ9ZzfP3bhZCq1/PYVKZkiSL88/
         WlbyA+YZDFKl4pgL1EI3/3iabhB8k7YUgWRxCXqfKPLtTRNQuaY8gnPQjbT+Yt9xzJqB
         tpRwv/UorbhC7cKUIm0hPbznR4XxDKlGiKxb+h0cWPY+2avNMZiADFAVxe8ptEu65tNh
         rVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690823073; x=1691427873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NG13BwzmmAIpXpcduEwvRHFbS3iQhU18W2JpKLteVDY=;
        b=GZwubmfdBgdq9dP6Z/s8IRfCF0kRWQvU9LoxMSb7uJHbzArc+ezarexTa9lntljXBn
         mxUXi+gYHlAShQMIPeXzK3BNKnbTBDg4v0PIjRUet0YEo5P0pFXqSHZNJRaN6DttR27l
         edV7NUXqT8bq9ksFCKGh6CSgpSqk0YREToyMHSvGckIudxhpn8wePKKW4p4MO8SnZkbN
         Z57FYRDrsl4awdVVdddV6cHQ7A7n9IZTc7kw8IRIeZMLNZBAyvz3H0d1kOkf/H+VK6TR
         bYm5zTMGPV50tzhlNRFnyejcs88gSjkjLFzWsdM9IJZOP4AuXjE3Z80jrGNnBrBoVlTB
         ASLg==
X-Gm-Message-State: ABy/qLYvmOxErP7ayR6X1/3oDNV/oJCWJ7pv0DuoIN4F3ROkIubXVfv4
	vwfQWg2zSVpi+pcqUlwmsys=
X-Google-Smtp-Source: APBJJlFtSPsXmTmbaE2JVTTuMieuMfoOw8pkpK4ugTgdmGfxbA+pL1HJ6fgn2J808MNJLpsNTjXtIQ==
X-Received: by 2002:a05:6808:655:b0:396:4bbc:9a36 with SMTP id z21-20020a056808065500b003964bbc9a36mr8685999oih.19.1690823072749;
        Mon, 31 Jul 2023 10:04:32 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id x31-20020a25ac9f000000b00c832ad2e2eesm2511833ybi.60.2023.07.31.10.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 10:04:32 -0700 (PDT)
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
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH mm-unstable v8 27/31] sh: Convert pte_free_tlb() to use ptdescs
Date: Mon, 31 Jul 2023 10:03:28 -0700
Message-Id: <20230731170332.69404-28-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731170332.69404-1-vishal.moola@gmail.com>
References: <20230731170332.69404-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_100435_983168_6761E377 
X-CRM114-Status: GOOD (  10.91  )
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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/sh/include/asm/pgalloc.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
index a9e98233c4d4..5d8577ab1591 100644
--- a/arch/sh/include/asm/pgalloc.h
+++ b/arch/sh/include/asm/pgalloc.h
@@ -2,6 +2,7 @@
 #ifndef __ASM_SH_PGALLOC_H
 #define __ASM_SH_PGALLOC_H
 
+#include <linux/mm.h>
 #include <asm/page.h>
 
 #define __HAVE_ARCH_PMD_ALLOC_ONE
@@ -31,10 +32,10 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 	set_pmd(pmd, __pmd((unsigned long)page_address(pte)));
 }
 
-#define __pte_free_tlb(tlb,pte,addr)			\
-do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page((tlb), (pte));			\
+#define __pte_free_tlb(tlb, pte, addr)				\
+do {								\
+	pagetable_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #endif /* __ASM_SH_PGALLOC_H */
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
