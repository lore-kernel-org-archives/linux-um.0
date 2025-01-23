Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D3C3C02182
	for <linux-um@archiver.kernel.org>; Thu, 23 Jan 2025 13:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nDJpscd5iDH1/vb94JK69W34zwsdKCnkCWvmFoEl4dc=; b=n8jeM9tf7gGtbHboVS5bw6COYZ
	4TTrqnfj3xM9Hr6K91MvIHIPBxLeLYL4IA+h0Bk6FGQL/rGDdVjbRC4dQNSBqK5H0OdHa+QIPWNnF
	xC/4jl3rMr1Gb74/JdS4zmV0Mg3btHGaLHWewrLf44PCclTTlKbw0vYDxBLqqhYeiFq7PacSdGxKF
	HckCqIe6BPLW3umgJ3OQDUukphsbdk8Ddih7KrPQKbvSiM61D0sVowZ+EntXEqkSZP7ffA7BoXwdT
	lo7/D2MjxJOVGeei5i+9BWZsqIY1ukUR0wVgrfAJuyvwoU79Qj3isFSS8ThGjZ5JMPykpcT0Awd2l
	KPX8trJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1taxG3-0000000CWBJ-1Nft;
	Thu, 23 Jan 2025 13:28:31 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1taxG1-0000000CW8z-1Vig
	for linux-um@lists.infradead.org;
	Thu, 23 Jan 2025 13:28:30 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-219f8263ae0so16873285ad.0
        for <linux-um@lists.infradead.org>; Thu, 23 Jan 2025 05:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737638908; x=1738243708; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDJpscd5iDH1/vb94JK69W34zwsdKCnkCWvmFoEl4dc=;
        b=A/13PZBj2WHITRvuauA8jSoIPtgDDqFZk+zBbtdCUczz+8TNOrLmYjTZG/wDhpWgin
         awOIrdOMQcBbrDyKZIOZ9dxD0oovzcVz9NTuhm88pzmM4SOgqDPRHiFcKFtnwhhgNNhl
         HKNbKU06EsftycgMe3ju/vyxA2h8V0MSqpbaB7q/uQ98MSab8ls9YqHnds0iR5/dJrGk
         LbmouQps64ameYQFmiI6if/SE4mP9zEMlJwczXypzBE0SqqrVSyHgOzoPLl7G00fgges
         g1TNQ0VVL8wa4T4PIm36iL4SIYXK5MxY6rVS4c7jl2BWCcpzly6Iz/OyQO8N76w8NM6Q
         gBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737638908; x=1738243708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDJpscd5iDH1/vb94JK69W34zwsdKCnkCWvmFoEl4dc=;
        b=wO7kxn0fMXyJqC6feQl8i0NGVXyIS6MnWvkplUyWD+Uh3r4xs/W3JHmOJDuxU55Pq2
         hd9nN96+q1CZGDUNSIuAKusgNHsCjLSJeGi4Zb5s3+Tt16hqDELPCAsUbcQZcvzMvs5i
         qHm/1bY7zNu3+/9N93wFqiNd7Bau8+0MOnwG9FONnc/NoSPBX8osPk22M7Wt4S3/pDll
         iDVqNp0kt2CJDrEqCYIZd6S1ZxgKEFmyCbi3Ty0eut/i7jOlJk7L2OYBRRIgMJz3RKzv
         whnQ6r5YwZ+tND0yo+om6Rw5583r7RVsi4Oc+DmSq7k/bhiX6/a6E1APd891TJGK5eZq
         3B9w==
X-Forwarded-Encrypted: i=1; AJvYcCVVKho7SbxNzfAHKoa/Xl2FS7XMsj8erbia0uaaEB8FuFMTw3XvJSY14hEceVH2ZiH9wVX7GUinJw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwqhF59mEBrFWY47mlirWEguOGhAR+9X4qFSCyGRd2oHTSWxD9z
	1+uUwZedrOVavYylPf2patbZpCQfG5/a3r6alm7Ol68BHBZP2EsZPh0t7WbipJM=
X-Gm-Gg: ASbGncvVez4nnkfetj/0w307sG4PzD4LCcw4ww6g+7jkLyYKj0u6RfsTIueWgRcgXSO
	gVO1p/blL4/KAII5r6elxepqkJAWu2dGGwuOjSV75VYwVCsFJredoeBg5IYs8gfSXN+7jN/XjWv
	gYYMLaYc84UPtaDLVcag0LIHkGv+vGfdOq4aEe9IFOlU8EQg5cinvK1Zf6dGXCG3Ay1hYOkDWFv
	UwI8uQYL2CW9yDTLsUcbRgAi+GM4f0yQ+purEeZXVlOsaTq7oRK5oI0/gs03lr6NJ2UcG3Q1Ivz
	ql5uG/FK+EQ3XVciW8fc3KKPFBmN/pthFQHkffLoygVe
X-Google-Smtp-Source: AGHT+IGvH4jPt9gEk2i8wJlEQCGHtq7Z8F/nhrt9cHdxqXKECEeUfNk2qVC/Ig+lLuwaqRjslO9WHQ==
X-Received: by 2002:a17:902:da8d:b0:216:386e:dd8 with SMTP id d9443c01a7336-21c3540cd05mr367659545ad.17.1737638908563;
        Thu, 23 Jan 2025 05:28:28 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3ac3e2sm111583655ad.139.2025.01.23.05.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 05:28:28 -0800 (PST)
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
Subject: [PATCH 1/5] mm: pgtable: make generic tlb_remove_table() use struct ptdesc
Date: Thu, 23 Jan 2025 21:26:14 +0800
Message-Id: <e2a1b07eda16eb84bdc51f6227fec02f2c0a54f7.1737637631.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1737637631.git.zhengqi.arch@bytedance.com>
References: <cover.1737637631.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250123_052829_392361_21596AE1 
X-CRM114-Status: GOOD (  11.34  )
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

Now only arm will call tlb_remove_ptdesc()/tlb_remove_table() when
CONFIG_MMU_GATHER_TABLE_FREE is disabled. In this case, the type of the
table parameter is actually struct ptdesc * instead of struct page *.

Since struct ptdesc still overlaps with struct page and has not been
separated from it, forcing the table parameter to struct page * will not
cause any problems at this time. But this is definitely incorrect and
needs to be fixed. So just like the generic __tlb_remove_table(), let
generic tlb_remove_table() use struct ptdesc by default when
CONFIG_MMU_GATHER_TABLE_FREE is disabled.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/asm-generic/tlb.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index e402aef79c93e..10cdbe0e7adfe 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -228,10 +228,10 @@ static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page);
  */
 static inline void tlb_remove_table(struct mmu_gather *tlb, void *table)
 {
-	struct page *page = (struct page *)table;
+	struct ptdesc *ptdesc = (struct ptdesc *)table;
 
-	pagetable_dtor(page_ptdesc(page));
-	tlb_remove_page(tlb, page);
+	pagetable_dtor(ptdesc);
+	tlb_remove_page(tlb, ptdesc_page(ptdesc));
 }
 #endif /* CONFIG_MMU_GATHER_TABLE_FREE */
 
-- 
2.20.1


