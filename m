Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD57C001DC
	for <linux-um@archiver.kernel.org>; Mon, 31 Jul 2023 17:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LSkxPGD1P0Ga3jFU/oewitUegGEc4O+cID0e7aE6Qs4=; b=Q7eFJBV2c4pUOY
	8b0k/CjbCzz3pcH85fIvJg5xku7xkKPb1U/ZTVKClvgQ59iRGgNcbvb4jXCKah0ChIa/BxmfKdCRw
	I5PUxoRJTVqUGwHImxNGzmYl/wdf90gPMxz0smy7okqbQz/a8ZbWyJKNCo5nTi+xBwA8QNq5Rg68o
	Cm5tcnfOZQjLEh7ko8OPZEW1c6ncLG+5Bixz+81eoO1tOS6yyJKtN1f0ogj6N03fIyP81tcMDOZCo
	EOmX6dcJVKBJMC8r9ofc9IWByJxFFHr0R9a1CLaRjeDyuLO3ZSNfCyx54s3xFO30NKbhLnrju2Skd
	KZ0jV3xUHXgUZAdgMzIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWN7-00Gn9m-2V;
	Mon, 31 Jul 2023 17:07:53 +0000
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQWJf-00GkTo-0X;
	Mon, 31 Jul 2023 17:04:20 +0000
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-bff89873d34so3787358276.2;
        Mon, 31 Jul 2023 10:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690823058; x=1691427858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUnc1suNAj/KzreaB6s7vAsOWiJZx3FNBLzDbQjj/SU=;
        b=LZWvv3P5ObD312NoT3HCx6hT2mcipY2zu8mSMdCIx/PBIBw4fnj2ZRkQKvrh+bnMcb
         cAhsWuRoUJhfVjNPelqZekFAhbwYfyzvXSZQKgwb66CUaJSig1RixymjgB6EpjMZeG9i
         TPX/SETFM0d6TUT+vW8F9GlkDQXYjB62fk/7jUTcwacjm8I/TfM4mDRrCt1nWg7/91vP
         laynl0EMAor5eoXfG6EYJS8WyMBq5PEy+tqv6UFYxDYMRASimm9gjZvXzBE5l6AVAiGx
         CLfIZvVLYDlmtO9VH/rc+XPRyyAblWv0VbvnMMW+5OEC9ZkYXTzgntXD+ElukV+Op4w9
         X05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690823058; x=1691427858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUnc1suNAj/KzreaB6s7vAsOWiJZx3FNBLzDbQjj/SU=;
        b=DZWrfAnqoke5urbBBjoQSEGyZg2D7biOf2hgDrTAfY/dyXJpP8RWPINRfMSZ3MNXRb
         IFTgYNEER+agb7D0vZNfV/1gSFzY2uRobjbyaZblnlH/4ERiFRn8VkKUFdPp9XAXSXEq
         zzCYwvUdUjHv4cdt7tMTC/wbC6BL2vKxdXjmLaI3+OUstATgIKguSDpFRlMFh3/1w/kf
         PpJZMrUw4Em7ofiqKw31yK9n4tt/Y40GQINlcnAjZqzwLh/JhtJHtS+fuELrrXL8fUHF
         S6nxiwIi6yyRHZKk5ssK0sCgsBu49cqm95oLXZ3Sc3oir63dG9Rxp15AuxBAxUG10Wy0
         n2yA==
X-Gm-Message-State: ABy/qLbba8DHmrHAV4chuZjt5rLB/KPTMzXd8y1eCfAvSs1YNgADdwhX
	0Po72+1dFiDKQWx6BLf/XLs=
X-Google-Smtp-Source: APBJJlHweyU7H3TneHig7w5n/DLDjL/9e2cIxm5cNvwqW36o28cnjEbZQWmE0nZHXnpgzHbA2ayWvQ==
X-Received: by 2002:a25:acd2:0:b0:c6d:f875:520e with SMTP id x18-20020a25acd2000000b00c6df875520emr7715191ybd.49.1690823058269;
        Mon, 31 Jul 2023 10:04:18 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id x31-20020a25ac9f000000b00c832ad2e2eesm2511833ybi.60.2023.07.31.10.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 10:04:17 -0700 (PDT)
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
Subject: [PATCH mm-unstable v8 20/31] hexagon: Convert __pte_free_tlb() to use ptdescs
Date: Mon, 31 Jul 2023 10:03:21 -0700
Message-Id: <20230731170332.69404-21-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731170332.69404-1-vishal.moola@gmail.com>
References: <20230731170332.69404-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_100419_224574_EE3861EA 
X-CRM114-Status: GOOD (  10.25  )
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
