Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C050C001DF
	for <linux-um@archiver.kernel.org>; Mon,  7 Aug 2023 23:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j3xz8nui1fB5VVE6wtiI6mQJGw49BhzDWc/9G7owUQY=; b=hu8ueB1wHDo8Ld
	vQw++fZlZpajTIJzrGmExjA42rQ1SnR4eDa0IWFCo0pvdQWBj0YZ9PFs7hEsWrd/G4xaHSkoo5FN1
	zo8CdumbOgKUIm7E++AeMgZArwpEps+KyNB94RrYKw5WJveMi6P8r0EM2rTyyiJrsBUgWCDQYVNG+
	jGU4vm4+/35MABiy+tbFTSB4OcGrW94lHoiDdl5fMnMd6A7Xzf42NhD1kQ78sbHA8o/WqOvk+/lpI
	KG+OJSXGglRM4uJ3+1TznO+FzjfoXpPAiJgmLXTX6fJ2S/0bBrBI80YPGYd+H6OlVk9wqr8dkk7Mt
	6cXnjP5LuP+aKFpEchMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9KW-0017DU-1S;
	Mon, 07 Aug 2023 23:08:04 +0000
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qT9IU-00150c-1T;
	Mon, 07 Aug 2023 23:06:00 +0000
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-cfcebc33d04so5106496276.2;
        Mon, 07 Aug 2023 16:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691449557; x=1692054357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/qh+9u1BcCIl2V5thva5G2rletbRXaxfcBgzJGGgXU=;
        b=pCbA+UxrLZ96Iu/LappjpSZmLEozYOYmdO5RTxaM7BlCH20e3MEhp3Bn4lGiK7HrnF
         zI5vTymTyexPs2fEWKMf3YOixGPBtUiqT1+gX7fLWBa+Q9gs2M2cYtqmojJG+cqpxy8a
         yiuXYP2euWfRpeTnK/Ph7t69G3h70UOk68zLodvepBaU3Ub4ZFK2KFzJhB7TlCbjRGdX
         ie8hnx40ZzCuPRz3xDX8QGC9rAdvd3I0ubBMPCct9yJ64tgNkqrnZ4vxqqMZLVPIiaaP
         rYqmFrrQlxG0A3en5YH5Vcd7HyjhL8swCun/14090vxoeSz0eujRX7UW9eNuwqOQts53
         n0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449557; x=1692054357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/qh+9u1BcCIl2V5thva5G2rletbRXaxfcBgzJGGgXU=;
        b=WCGt9zVEWTNv1ztOGJ968tTwhQZ4HBWzfT4ykPDBocH/B5KSWF5QT+6Pi+Vz7LzPKD
         fGv9ebIW+d23jyUbOqn5x9NnGygb6OI7B6aqSmqx82HtUhJ/fwJkmFUDVASbzgIpqYHU
         /gJsjSU+2CkPyX20xSGyHBA/9aShGZhI5tYi6gpvEYTGoOtRzow9uX18QQlqR33wHSCv
         npLMczWt+nRHBx3hSc5iiD7dC1uVY6+s8Zf0r7vS8BZ80r4IxKW2K+fhKR7kAejfz0ds
         pIEgSk+xltngGh20moZLoUJPnVPsfEGDVFt6GsON7uwVYq1+Zf1j8SCmBykQTZ23nlUs
         ayQA==
X-Gm-Message-State: AOJu0YzqPBixK6CPBYXpcSnnEx1DQw+LNRjKzpX0ZsSXcZPvqvtUW8Xv
	u7/K7kak8RmveyePFKr5rWs=
X-Google-Smtp-Source: AGHT+IGb7qTBQz9qcaNa56xxCbdxPZmnKDiha96eaUPQlL4XzY5YUB1UJSqCKxKHPrzOS/VVDboJfg==
X-Received: by 2002:a05:6902:4c4:b0:d0f:65db:dc0e with SMTP id v4-20020a05690204c400b00d0f65dbdc0emr10052463ybs.39.1691449556886;
        Mon, 07 Aug 2023 16:05:56 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id d190-20020a25cdc7000000b00d3596aca5bcsm2545203ybf.34.2023.08.07.16.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 16:05:56 -0700 (PDT)
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
	Guo Ren <guoren@kernel.org>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH mm-unstable v9 19/31] csky: Convert __pte_free_tlb() to use ptdescs
Date: Mon,  7 Aug 2023 16:05:01 -0700
Message-Id: <20230807230513.102486-20-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807230513.102486-1-vishal.moola@gmail.com>
References: <20230807230513.102486-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_160558_609799_34C712F3 
X-CRM114-Status: GOOD (  10.82  )
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

Acked-by: Guo Ren <guoren@kernel.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/csky/include/asm/pgalloc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
index 7d57e5da0914..9c84c9012e53 100644
--- a/arch/csky/include/asm/pgalloc.h
+++ b/arch/csky/include/asm/pgalloc.h
@@ -63,8 +63,8 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 
 #define __pte_free_tlb(tlb, pte, address)		\
 do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page(tlb, pte);			\
+	pagetable_pte_dtor(page_ptdesc(pte));		\
+	tlb_remove_page_ptdesc(tlb, page_ptdesc(pte));	\
 } while (0)
 
 extern void pagetable_init(void);
-- 
2.40.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
