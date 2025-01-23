Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D938CC0218B
	for <linux-um@archiver.kernel.org>; Thu, 23 Jan 2025 13:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bSVoet4BIZh93xV/DLydReH1JogDWuAFDaImcbetZJc=; b=VGomrD/UE0X4BWlmwoLEVN4zuM
	qpLHHD4AkzrnvR/UVOaSjeui91L4BVvGqude/2vKoj0RX+i97swHFdMoXWA38xVlf3Xzm8e4HWTAv
	CHZST7GtJ/wJprS48/yqLdJEGOKf986F/QY3cZPCGLidruA5bbLZkKEMHUxx9X3S7uOAwntlvelp3
	GAeqjKdiEf0s1CwqrJU9ontlJj6V+7Mh9MGZ0IXmwLRWenQ3DK5WrdAN74CNPgtYlhuF3Ufe3sOsQ
	dzjQ7Fl/62n1hRE6SWCq1kqcaEAHqbBVIhllI5vWPfPGhdhIU0CNszEdo1WWkpolvktGhX0c1vyZZ
	6rHii/tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1taxGY-0000000CWVx-2edy;
	Thu, 23 Jan 2025 13:29:02 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1taxGU-0000000CWSb-49Tq
	for linux-um@lists.infradead.org;
	Thu, 23 Jan 2025 13:29:00 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-21661be2c2dso15403335ad.1
        for <linux-um@lists.infradead.org>; Thu, 23 Jan 2025 05:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737638938; x=1738243738; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSVoet4BIZh93xV/DLydReH1JogDWuAFDaImcbetZJc=;
        b=FCHypj1dcOHI9TRPI9rp2cRm7kUpAI4BH28yD7m9lCOw5joaBJoaszb2KHodydIidF
         aCi8dRrjnyDp+fTGCckvymB7tkzTDhg1tPTA6nYnyT6dH9mFrD+6Ttho7kKt/7Lg8TPX
         1ddZfa4HyifA5qTMw/eElunDVdR0qr1g4R+THOypMxwCza8wbeKTyubHUvOXeJ4bNSBE
         l3fMY66iyYpcqMAg4flsSaKUUVyPDcI0JHwakshdFSUsq6onHn+QVmmdv1bKqcZiUl91
         3Axzc1jQj/vunmsgDmCPlkGfooltEo6K/wUu63Z+iajkwoYi8LwgOOitSM8RlK056Sua
         80HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737638938; x=1738243738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSVoet4BIZh93xV/DLydReH1JogDWuAFDaImcbetZJc=;
        b=HYwAnV7/rY+Yb8U3mjOsU1vEqN5WDS7bWhPL+lBYb8piMU5Ir6flfVw+pXaupZltlr
         xbj1TnEWVf8DiROv3uFg/WPwYMs3vmckuRnGmeuHegyRW93mOLVoXDdhmiUr7CVuXXIT
         mlt1eEWGXoh+uTm3Pvavb73YglrBCaL9CQZnPGa6HZbnyXbCzwpU8psCFPnn+n2Pdwyc
         YDuHB0LaaGN4P73339ZAl4WFQ+UeV6xYMo0e9kmxkORrDpgplC2kjlBep0xDalHpF2A7
         4cYM621ylnNXnl3tUyiKOjwPQ1NhWckhkSdVo/E3JOJdv26NnqbYbIMVxJHOTtcP7CSk
         MWng==
X-Forwarded-Encrypted: i=1; AJvYcCXlh4Q3CYkJ90VHSDcC718y8EsZbCt9lQRK94JqTJaAuz8SC/9Jf7TGImBokX4FEFnqPDs70r+D2w==@lists.infradead.org
X-Gm-Message-State: AOJu0YxaGCOUmeGii14ZlJEZwGP/Rwk691Q36TYnJW+Cofch+8ZJNvjv
	S1scFRSGBxSwryHpRE5r3JgtizkyYOT/4vbAoVlb84N3YsjOw2i7D/TCxdlpC9A=
X-Gm-Gg: ASbGncvyrlWCP4bGQT1zN8bEhilfGjiukpW2kvI4sTEeCqq/7JqI6unMNInlrLr/faQ
	C1i9LqwPJfrSDF1WlBii8Zqza91NY6WKCu6xbN/tdqbc3hhB1ikicD395Y699K8MuJ/hateeLXb
	1wa2vwIxHpr4NkDHeJ3YxFHHCvLuYteDGtMybbgtM9D/5f3wwD17EEtwI4/OQdJYSUcDSL6KwUc
	i64KVyfXPS9cQAgstfUCC3eAkJfBEvMjRPO2+1uWrpQdxTyO6xhb2V9uGXJa4B31lY4ySDAp0qE
	im+ogO+qtrx2JEh5jXiJAMV5leSgu3Yn3OXzr53S6pRW
X-Google-Smtp-Source: AGHT+IE9ITT+lxW4q5ku2WHS5AYNu8WFWCG+wILMASo2spfcLUt1T5YAi0clrsTLRCDPofgLk2+QPw==
X-Received: by 2002:a17:902:e5ce:b0:216:6590:d472 with SMTP id d9443c01a7336-21c3551ae48mr419794535ad.21.1737638938491;
        Thu, 23 Jan 2025 05:28:58 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3ac3e2sm111583655ad.139.2025.01.23.05.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 05:28:57 -0800 (PST)
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
Subject: [PATCH 4/5] x86: pgtable: unconditionally use tlb_remove_table()
Date: Thu, 23 Jan 2025 21:26:17 +0800
Message-Id: <00bf7935d65826eee547ac195d7854b1c946dbc5.1737637631.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1737637631.git.zhengqi.arch@bytedance.com>
References: <cover.1737637631.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250123_052859_019048_B965D7EC 
X-CRM114-Status: UNSURE (   8.54  )
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

If the CONFIG_MMU_GATHER_TABLE_FREE is disabled, the tlb_remove_table()
will fall back to pagetable_dtor() + tlb_remove_page(). So let's use
tlb_remove_table() unconditionally to free page table pages.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/paravirt.c | 17 +----------------
 arch/x86/mm/pgtable.c      | 11 -----------
 2 files changed, 1 insertion(+), 27 deletions(-)

diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 1ccaa3397a670..527f5605aa3e5 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -59,21 +59,6 @@ void __init native_pv_lock_init(void)
 		static_branch_enable(&virt_spin_lock_key);
 }
 
-#ifndef CONFIG_PT_RECLAIM
-static void native_tlb_remove_table(struct mmu_gather *tlb, void *table)
-{
-	struct ptdesc *ptdesc = (struct ptdesc *)table;
-
-	pagetable_dtor(ptdesc);
-	tlb_remove_page(tlb, ptdesc_page(ptdesc));
-}
-#else
-static void native_tlb_remove_table(struct mmu_gather *tlb, void *table)
-{
-	tlb_remove_table(tlb, table);
-}
-#endif
-
 struct static_key paravirt_steal_enabled;
 struct static_key paravirt_steal_rq_enabled;
 
@@ -195,7 +180,7 @@ struct paravirt_patch_template pv_ops = {
 	.mmu.flush_tlb_kernel	= native_flush_tlb_global,
 	.mmu.flush_tlb_one_user	= native_flush_tlb_one_user,
 	.mmu.flush_tlb_multi	= native_flush_tlb_multi,
-	.mmu.tlb_remove_table	= native_tlb_remove_table,
+	.mmu.tlb_remove_table	= tlb_remove_table,
 
 	.mmu.exit_mmap		= paravirt_nop,
 	.mmu.notify_page_enc_status_changed	= paravirt_nop,
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 1fef5ad32d5a8..3bc8ad282b272 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -19,22 +19,11 @@ EXPORT_SYMBOL(physical_mask);
 #endif
 
 #ifndef CONFIG_PARAVIRT
-#ifndef CONFIG_PT_RECLAIM
-static inline
-void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
-{
-	struct ptdesc *ptdesc = (struct ptdesc *)table;
-
-	pagetable_dtor(ptdesc);
-	tlb_remove_page(tlb, ptdesc_page(ptdesc));
-}
-#else
 static inline
 void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
 {
 	tlb_remove_table(tlb, table);
 }
-#endif /* !CONFIG_PT_RECLAIM */
 #endif /* !CONFIG_PARAVIRT */
 
 gfp_t __userpte_alloc_gfp = GFP_PGTABLE_USER | PGTABLE_HIGHMEM;
-- 
2.20.1


