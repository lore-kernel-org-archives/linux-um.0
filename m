Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00858C0218B
	for <linux-um@archiver.kernel.org>; Thu, 23 Jan 2025 13:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8C94XB4BAC98f0nzKDfhip6ZZIJjZtAIgTVlkxB/zEY=; b=HgdjVcD+qEGhJhX1pswa+IYSMW
	abh3IB32F6hYINY+JAl+5yqbgk+gteUqZTYf30mbEzzI7tRIN6p3jOfg/f0cZhrv8ICK96iWpEmoR
	bJg/kCTSSAFobPJuwksCMgCYM1guxfdvzkbqqZrCOdXw8TpGEJGQF+mqe0z8nxKbJ5sRF3BS9KEKA
	MQICi8Jz2VWHjb69H3pAPYvX8JizIGzqI+teUUZZ5CyfOW1A4Q52iJ9cxHI5+NojW3PpBcxpzKr7G
	fJuZoWolYIrN3GijuYkHbyHd83Pdxx9P49SiN60cIttgbYvU1uPWIYbP33vhVuY7yR/BvmZ1JnD2E
	FYHyDWzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1taxGh-0000000CWcb-3669;
	Thu, 23 Jan 2025 13:29:11 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1taxGe-0000000CWa0-3VYc
	for linux-um@lists.infradead.org;
	Thu, 23 Jan 2025 13:29:09 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2166022c5caso13618455ad.2
        for <linux-um@lists.infradead.org>; Thu, 23 Jan 2025 05:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737638948; x=1738243748; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8C94XB4BAC98f0nzKDfhip6ZZIJjZtAIgTVlkxB/zEY=;
        b=dZmriKqVdLkRsJYb9RCNJZvdzO+mo/QpnmTqNckodE2SQ78rkhe9QBZpfsIvf3Me8f
         TBJOiSuOz7b0eI3AK6bGiGH2GCLt9HCEAB20eemNpl9YTyc1T5y7TjGYjzw//f1CPP4Y
         AaKOzNwS+hAOYLA1r/91+tgXaGH4eKBB3D+wGcaOwR7HZDMmQn6lpeGOy5Z/tFVYIOcJ
         rwEfkss2axLRmk68Q8+rZr6+TgWPL9tqUkHcGgyRtLNc0l2miyUYVgjeZn+8mHo59vfu
         QBRhJDAEa7Tr0y6ilaMF23T1RD/oAvMfkmStftu9v8MzJ7c82UO7SAwJF022hJMU3dnw
         dYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737638948; x=1738243748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8C94XB4BAC98f0nzKDfhip6ZZIJjZtAIgTVlkxB/zEY=;
        b=lLzK7Y6FNMlIZ/Ta0stPm/1wslR8vG20h8cGGuhYhZayF7tpTAYeei8foBHbQtSA3V
         yAy0TfHhbaIvgw2qRrriBQCG4iIuA+9m8BSzaXHr/OvKgKwBPz7jk4Msi893ykXX8ufD
         I/hVpIgghm+Ac9sHt6QwfVgLcZ9OPzh5T1T6W+Zg/atRj0KoZRPKaUAJiiLienG78skZ
         xIYU0E2dbv62pRrrOrS1Pp2blg7S+Y0VejzLkSdpaC7z0cpPu2BhCLDucpSHw3N/RzIl
         MvCgyIlZ3D7u+iF/HKJr7XwTIyYjGeun2585Vl45J+/xoedxEVd7t7i/BdUfRzk0l0Zd
         KmDw==
X-Forwarded-Encrypted: i=1; AJvYcCWB7RTLw4jIfZQ6UvWnbUXf4slxA0XrIy/npzfYwR+DR/Ev8r1hQeuyxumHmcaUFXpRi5J0992vNA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwRbtyIfhaL3rcjMP6KceMLVPfaJWA6IJsdqYGQg1q2u+deOcYt
	e+drsVRQxlvgxS1GCxpCT9428JsHlaSTKhrhrVisUnSMoU4qwxYidkzCoEZgZv0=
X-Gm-Gg: ASbGnctp4BxVeazv/kErsqKr6fF2Nh2D4pQaKlgQkx9cBVOfnjHP5JkYWGvp/9S4esT
	N++AJUgSTfBGxKQez2/q9ruY0IuxoaeAH4dx3UEiMyekWq/+xem/FHTydK4RBm6Ufw2WBUPBaxW
	3SzyH+RpGx52TCs5MVphpP3Yr20PSLFHwrfkuWkfIvIKWV0cYcmJmaUdShlnMPIlAS7txGcFRVM
	B7BQwZqUSxhYUwJ8YO3yARG6MtwNeO4WyTQD3JQDgRh5LY6luAjDuvQAxfdib/Qxw8tSTxw13CK
	4ULOnsIb+kvi1Q2QNw6mhcwWR42kbnmD6gLDTfThP6mf
X-Google-Smtp-Source: AGHT+IFkSdO3UtmG5jKkAJtanqQZSHufZoNoVtMFPHl42HZUz79kP6iB5Pw4LWGczfrtYHtt4kZUXA==
X-Received: by 2002:a17:902:f54f:b0:215:b468:1a33 with SMTP id d9443c01a7336-21c351c67acmr376126085ad.4.1737638948337;
        Thu, 23 Jan 2025 05:29:08 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3ac3e2sm111583655ad.139.2025.01.23.05.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 05:29:07 -0800 (PST)
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
Subject: [PATCH 5/5] mm: pgtable: remove tlb_remove_page_ptdesc()
Date: Thu, 23 Jan 2025 21:26:18 +0800
Message-Id: <62d6a04c3a0e70efd435cc2c8a4d9d07d94e7ece.1737637631.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1737637631.git.zhengqi.arch@bytedance.com>
References: <cover.1737637631.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250123_052908_872611_6D895C0C 
X-CRM114-Status: UNSURE (   6.79  )
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
index 10cdbe0e7adfe..dec030cb12108 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -509,12 +509,6 @@ static inline void tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
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


