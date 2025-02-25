Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD934C021B2
	for <linux-um@archiver.kernel.org>; Tue, 25 Feb 2025 03:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g0Ocxe5/W3x8AaSNUp1nmQA6Ns9xuyK5JD/uD9z0OJg=; b=Y15IMwFlKTIw9MUrv8ec7YdhGN
	Su1qXJgwcyJkCxYqYRgoxngGFiT+AYvvvuzbf+jeAr+CQHlEyHRxeAf5bcR786h2k+i4bpnZtQkIc
	+o5ANlCOczfVKSbCwTZ0yEYD8g0+utKbPxASJTJXx4tjw/HPsV3xI71BLOu0zaocFcnIHa3QUBG05
	3pdj7KLyoBFyAknNfj2dbmSNUQqrLDN8CXia6OuAj9e2/P/B4ul9j7UEK0w2CfH6dC+VkHi+FjOUJ
	WjKen7u/eAQd2RHXAI/ouDBRBssJTZsbfd+zVTjLCXaOOCdaoH69huONo4E6eZA70nbqKsJiFXv6Z
	61ZWxpeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmltw-0000000FtQ6-258m;
	Tue, 25 Feb 2025 03:46:32 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmltt-0000000FtNR-2zGv
	for linux-um@lists.infradead.org;
	Tue, 25 Feb 2025 03:46:30 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-220bff984a0so108512005ad.3
        for <linux-um@lists.infradead.org>; Mon, 24 Feb 2025 19:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740455189; x=1741059989; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0Ocxe5/W3x8AaSNUp1nmQA6Ns9xuyK5JD/uD9z0OJg=;
        b=Meeg67WWgsTYxId/dV0z+bFKgOuH5m59vap9//IP9UPVHXbSKkNJZMk6h2j+OsqAoQ
         sd0pezCI5LCpnHkQQ846Gq61vMwvpUX0wCxQ7CmKum6FQI/Kh/Luxy4Zm71xf9/5QeDr
         ALSIFxVt8XaFxdSrPXbxAsT03DbM5oday/XsHPm5rvJEKvZCoryuBpIg3iVGvyv7QgIW
         BKkBdce5xKXJlEj/Rliy0Gav/Hro0ISpasnQ9KOpeNzH2KhLBVfi1T+FX1J5Aly6jZ80
         tE4v53NLg0UApqNrU14DNiEu5O+blR+/hlfZhXQFjugFWLIh+viOUDqHmHPPadPJrIyG
         Z1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455189; x=1741059989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0Ocxe5/W3x8AaSNUp1nmQA6Ns9xuyK5JD/uD9z0OJg=;
        b=bSM5XtTf6KiDnRvMidcDWgho48LMHBjxGOSFc8j+qAHj4KiS6Y9eZ27tbriUtBCaJm
         SEODyidplGQlz/6gLwTvblR8mZO1cCIrthU0YUU2oq/HPK/2uyECymq2qHWo1v98Mout
         /WDPLgN1UHu9CpZJl11TiZzZg53Ie2G4r+STpOQkJsxJUaN4c/+UUWZoD/18J9qFuMmM
         uKpe+SwkwAI5fHCYepapMZ8R8P5K/9hVUl9/JzeZYBhqetUrbF7zwQo2iFxdmU78d0Mz
         HXMb2mv6I3porDKshmfl/LJcDu9RWVVTetYNNV1O2Fawc4ptIfzskYeygAkM5YexmScX
         tPDg==
X-Forwarded-Encrypted: i=1; AJvYcCUvvz7kBmJ0Q5qgnwwNZtXF6a4SMROuFPGZga5ZWVmZUHfLXPKSk9Omoaeh5CMj72HFP3QLQSMZug==@lists.infradead.org
X-Gm-Message-State: AOJu0YxBaIO/FQwAPN+oAQHVRMcXCXhzR0nAwyg07sduKwk6ahhbymBx
	gUO/P35i1QR6GkL68EdDeglmhapIdRtWHEQzHCAPtyCWvhhUyDi06524WbwBbCk=
X-Gm-Gg: ASbGncspEffXWf9+WmqqoFutVKQ7Hpb4VwEgxyQEZi2X4NvaFqxGjnm/G+eyp+w66By
	DCGa616aw3N4EJRFtcKPa9YO5nczFrRdCsx5Mc/9FN8nPkW5mnDkPiElolSgtgihPt8pB3PC/Ks
	dgTvUT8E9Hh4kW7n6Pn14zJhdKWkS64ODldI9LQY310J8FjI5vfH6QfMhhZfusR1/senlgV+4wf
	yKaJTiM2j54FsD7gBpQiBTewP5VxdLAoGQbTtCtFACj0EjY2WcF+A8wKp6is/8DU+9/QJ+JFC51
	/g9dbuj5xab88fI4g6pi4Ibco6oEz0evZsRR7my08aKIoSPKj6TwH9eFrSLQnALHWQ==
X-Google-Smtp-Source: AGHT+IGBfXw23ytiI6FvQDqnu6HA+6X81xKlY5Cdi/AJkyrR2YGvsG8wye6vZ+K3tNu1qHLJYKOiEg==
X-Received: by 2002:a05:6a00:22c9:b0:731:771:38f2 with SMTP id d2e1a72fcca58-734790de607mr3427312b3a.8.1740455188892;
        Mon, 24 Feb 2025 19:46:28 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81f014sm409429b3a.156.2025.02.24.19.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:46:28 -0800 (PST)
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
Subject: [PATCH v2 1/6] mm: pgtable: make generic tlb_remove_table() use struct ptdesc
Date: Tue, 25 Feb 2025 11:45:51 +0800
Message-Id: <5be8c3ab7bd68510bf0db4cf84010f4dfe372917.1740454179.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1740454179.git.zhengqi.arch@bytedance.com>
References: <cover.1740454179.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_194629_760553_68439B01 
X-CRM114-Status: GOOD (  11.98  )
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
index b35b36fa7aabf..54f579750c8e5 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -232,10 +232,10 @@ static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page);
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


