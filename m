Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6F3C021BC
	for <linux-um@archiver.kernel.org>; Tue, 25 Feb 2025 04:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y+AOLMBHyoEBsAHQDRMLfrp+DU3rIi9C1hjH+u4umGY=; b=tr+4y0WQu7TWlGlcVGRn2PylC4
	u/77/01cx7nFHRALR+W2KFtN99l/Cq3eon+DX8NiZnmmM5ravgSYnh6rVBSy6ddV1oQzeON6tbrsU
	KQhguQcywoVsNLSgJWUxOhIP8SVeJyPuoE3PtfDf54m1iZ7UMpKGE5qao4GkS7YqvW+UahpNkgxol
	LWrqyL/tn7t1brVq98g93xQogpxHHcRinIL8rDbhgdncI5+aSqsoFVwK15u0fzNmNQ4jwZ2k9Xj6h
	APlsE6aQJktA9a7srKtztjVeiuyyHyv1tL+aBo/p60mr1CtY/aN9mKF3Q40NONXGHbUha4KAy/5eY
	/Eeqz49Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmmw9-0000000FyTq-1xJS;
	Tue, 25 Feb 2025 04:52:53 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmlux-0000000Fu1M-2vxn
	for linux-um@bombadil.infradead.org;
	Tue, 25 Feb 2025 03:47:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Y+AOLMBHyoEBsAHQDRMLfrp+DU3rIi9C1hjH+u4umGY=; b=fvKgqXEjWVU+kgzLwExkYCqVua
	VHOHQuDZsPDSNnfPROXtrf1xszDEw0CR0i1kdB4AWHizLhrAl1k2H8cnDEqeoqLkwGXQJYF8ZTDf8
	5SpMg5Qox/fnL2EGktq5s/Zb5sdyAV8JutJLqXEmHEMxSWM/JGTHGiKP7UUZgucpmZ9x3p8aw+7MD
	bT/Ef4F6nnpL/3lvXuoGSh39koEQtc+U4tPdvBou/8zL7s7gpmpBH2V4JYA33YGkkJmowBYKoJqP+
	lvwjfm3HxVeG/JVQbMV0bAobYi6zJW2rXB3FwfqxFzHC0MTeese9FKM9Kgo47MkPijmdS009fYJNy
	hdAABthA==;
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmluh-00000003Hvp-3lnb
	for linux-um@lists.infradead.org;
	Tue, 25 Feb 2025 03:47:34 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-22185cddbffso103442525ad.1
        for <linux-um@lists.infradead.org>; Mon, 24 Feb 2025 19:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740455238; x=1741060038; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+AOLMBHyoEBsAHQDRMLfrp+DU3rIi9C1hjH+u4umGY=;
        b=GgvCjSq4Gc+YxCcULbNUSwIy1K+bzuxO+D+2uNQdFxpG4NU46lBD4LHmwV/k/8Ihvp
         o876JKEM3MDlCQpi0V3b1bEf2/t8z2ad2dLO3SEPSbYwkvQWdmSI84HGfXrUJSxIUWrs
         YK1qu1U8OiKniXuPXefl2L6tzfl8KFA1/Qe/a98Pom2Nsj/KQNjtkYq09jPP0DcNcgC+
         0Af1hhSYw6jEW337/r0bUy//n+NnrWhWBi9KkTmRH/rvPrHiYQErR2R2xHwFiXTS9QkF
         hgckEs4QO1FWSS2lq3kdo9UW24Ju+r8PonvS+r3mDPynVKZccsC+9+waMVpPgL4APbGP
         fIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455238; x=1741060038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+AOLMBHyoEBsAHQDRMLfrp+DU3rIi9C1hjH+u4umGY=;
        b=HgnKoXC7Dbol+RDOWMuL8U5hB4xJwTolT5hQ7yq74iIDlIVAKw7faOxy6UxAO8AQBj
         hjj7phEWrycrzgvUfV2SZ/eLd0qp1B+WvSmt4C7TEg/LjI+iZOVuMOWh0fcb6XHGsP4r
         KIICTiTczJ+Yt2I98nzriLTq++xpXIXQLoHZVkrCDiTYFstmKjg+/a1Ms5hesMV+o5st
         alZWshu1Hu11TelBMj2aK1ZtlPISnOi81CBn3cr8Lc6/73LaLLxzc/BtmYmH0K/pHzcL
         Ji4/5zA521LWG4+Bk8Rw6Morlnz/lbw7EZigtgdPo6KXGUSAgoxLqAJwoc/hpmFLOOlw
         DsxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1Tsp8twMeYltZv/9brmc936qllolmPI/un+M1S8F9ofcng6HDzuVGsSwpVR0uL3x7hQgdQ07+4Q==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx8PNNGXkl/CuX1f66O60jWwa/BMLIlyh2G8LUX4J5xqhTlLDFT
	GVHVSv9HGyhn1bOl8nJX45kPVZKKTqo3LSGJt5fubionltN2QeRcGZStIOAo6Rc=
X-Gm-Gg: ASbGncv5mNZSRXhZ5BjNrQKKIwGOuSHogiaw1184XsNn25vga2ZpcMC7kwWtu4MPXgS
	uLbCxcK7CqnnS1Rm6ShxTIkQusAwd/Uy419hEowHvuV/t1u1uYXAnglGdqdMl9x+wTyggw4Sc46
	0/wVKowq94IyPBY7OW8qi08hapvS3uUl/O004gdxosrcwEUzgfl3zrLo7LHXREyccrCAAeCS86R
	T1SA/MTO+lweKDFCk9b80tiKQ4jfhpj3v2bBhOPDtoV8MI2YbxNT8QzXx+DKJr7uj3Of5Klr8OF
	iC4qryO2Npoo4TncRRuKdAZZ5qveH/PpcIkue/0HCtUWxo5MxYK2T5Sc3Yj0+HUToA==
X-Google-Smtp-Source: AGHT+IHDwvQZzbKv24vEjKNvLJNI+R1iJ4OqsIlmXN9p1d6u9OWq0+ZfVfD6gOTuv6xGQ3OntwSRRg==
X-Received: by 2002:a05:6a00:6f0e:b0:734:26c6:26d3 with SMTP id d2e1a72fcca58-73426c62969mr26062579b3a.5.1740455238550;
        Mon, 24 Feb 2025 19:47:18 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81f014sm409429b3a.156.2025.02.24.19.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:47:18 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	kevin.brodsky@arm.com,
	riel@surriel.com,
	vishal.moola@gmail.com,
	david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	willy@infradead.org,
	yuzhao@google.com,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	arnd@arndb.de,
	dave.hansen@linux.intel.com,
	rppt@kernel.org,
	alexghiti@rivosinc.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	linux-riscv@lists.infradead.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 6/6] mm: pgtable: remove tlb_remove_page_ptdesc()
Date: Tue, 25 Feb 2025 11:45:56 +0800
Message-Id: <3df04c8494339073b71be4acb2d92e108ecd1b60.1740454179.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1740454179.git.zhengqi.arch@bytedance.com>
References: <cover.1740454179.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_034726_218023_7DB8AD95 
X-CRM114-Status: UNSURE (   7.41  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

The tlb_remove_ptdesc()/tlb_remove_table() is specially designed for page
table pages, and now all architectures have been converted to use it to
remove page table pages. So let's remove tlb_remove_page_ptdesc(), it
currently has no users and should not be used for page table pages.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/tlb.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 18bf499ef8801..dd292c6d3ce88 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -511,12 +511,6 @@ static inline void tlb_remove_ptdesc(struct mmu_gather *tlb, struct ptdesc *pt)
 	tlb_remove_table(tlb, pt);
 }
 
-/* Like tlb_remove_ptdesc, but for page-like page directories. */
-static inline void tlb_remove_page_ptdesc(struct mmu_gather *tlb, struct ptdesc *pt)
-{
-	tlb_remove_page(tlb, ptdesc_page(pt));
-}
-
 static inline void tlb_change_page_size(struct mmu_gather *tlb,
 						     unsigned int page_size)
 {
-- 
2.20.1


