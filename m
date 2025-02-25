Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F145C021B2
	for <linux-um@archiver.kernel.org>; Tue, 25 Feb 2025 03:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8OP1Tf7pAaJ4pNIvAgoQe1yrsY5TH0xWN2DlWHIb0tQ=; b=2v1E8Gw3T5x/fEhyoW02YmEYkx
	bv5TZroy7Se7Fg9OANv/sjjAa3Ve+ZArm62vCKr0D0MDnZyziR0rs4XJJKILBIzFuyAhDx5dDTT8k
	AxEMoBpy96cTqvSrn0uFxVJpS9P1ZTV12lH33YxKYom1xxxEJqK1cwNiZwo7/+jWOQ7P57rOtaAxU
	FEiLTmga6QMgi/JQlgh2RXOvMv4XEoyMr/dh5USjhKuBgZ8mvAEF4yGapf1al9HAX5fihgjlyNu+t
	JFWr5lYkhAuAQCkcPHmoE4bhdjUucuFwuO9UD57L7J0z8tJlzec0z6VnDOtFBtIoTw5WyO8ElFnKk
	Y2dz27jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmlu5-0000000FtWX-3Ojl;
	Tue, 25 Feb 2025 03:46:41 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmlu3-0000000FtUW-1DNP
	for linux-um@lists.infradead.org;
	Tue, 25 Feb 2025 03:46:40 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-220f4dd756eso106403415ad.3
        for <linux-um@lists.infradead.org>; Mon, 24 Feb 2025 19:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740455199; x=1741059999; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OP1Tf7pAaJ4pNIvAgoQe1yrsY5TH0xWN2DlWHIb0tQ=;
        b=X3OkspkbTWOzjOZIRl5pUIycoang0a11pfuSTCtlzNDriQ0v0A8Mc0F5VVt1/hDedH
         pO8NKFqwbE7B6TxS0dPUGhdRKa9B0XtB5IrDvbywv2l16X4qY+1GrSR5IRCf5BBKiY7q
         IM/CqmKT2S4nl55yvOjK5OStj/pJiwvOsjUa0D1j+L/pYGnvx419D+zkkN3a4KFS0j4F
         kOmA40QAKFYNL4CnJLb5e8sIYB/9AsO8VnlCT+dwD9RlfUO5pM1Mw9ZERPHTIvtO2JoR
         EKuugu7ebyVB+6sAr8xyXWUmgedm/sTI+ST6vYCPVO38qFmdiEHcWglPRjBgXDyYQ32P
         dDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455199; x=1741059999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OP1Tf7pAaJ4pNIvAgoQe1yrsY5TH0xWN2DlWHIb0tQ=;
        b=JR8Lhcn+vRt3aZd2vkCY+dcVFaNMd+oh9MusloFWe34m1GcRpV2UWn6qTnONCnRqjh
         xT0ePSOvFE6+Qew1W6Bd8szOMi703yy5VaU0NsYZ0fhiSW6nAk+0BBxHuXVeXfSjP7Vy
         H8EuglpznKJEKumpdL3sov/A+/n+3B8tioPnVzxiBIvoKql8jTQsQaGMDluFBFVoMJoW
         e8Ys9Sj7blpP/dv22EVl90VkrYTuybHWG/v+drdAs2IjIizmtNRNLxaYxvQTvhZkJTfu
         D2Lu9aKzcKGUz3C8PYfTtmfgUuLfyT6O4dMhfIN8GduCSzVUTIPufVEo821tVQg06haf
         X/yQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/sxaqLYxZGPAG/nWiStGOOQVaWPpNrPBZESK6KVq0fNN8kOJ462WCo2W2Ye6+5svHaHYdj+zDjw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwWnRS3ADnjHxE2xwCcx3ctAjjo8bweSQ7lIvVAch41n/eC3hOD
	ysiAMkDEvPqHfWtPYtQgFVOYhXfxAVTgHnWgIUIuBWn7dJ2Rn5C4YxtjLXEfLGc=
X-Gm-Gg: ASbGncv43nlaQMlt9Ll2RNaqbzgatC9wp3CpqTPF517gfZfOVa0lUVyz02k2L7yIKwl
	vF1r02uOYIQR6ZforKb+zphvvZkmYsrzdmsQ1y1VERgUM5OtpGHFMjzztf3vt/HFpgw3fC7L9/W
	USYTc9ZiF2LplM8lYnFWgWVBQGIZJihfz3C1bnLbXWKYKLedqUKYjmvh8DrEalQz5DHgI/IzPLB
	yANlE4JkAZHu3nOThsYt9QVpYnihr0wuCoOkT+0e1VFlI1OV39z4MeWmimQGoUBV9p5H+a0/6/f
	lOBzD0xAf0+NTstxKiebfPL+XZ0R8riFqO4IuQAenxQIvm9sM5ZBexTKJT5otAYbig==
X-Google-Smtp-Source: AGHT+IFHXm4yz9k/q53vQDLsSd2kyUiUDLPeAK4sNAWc/t1WzpyNSO/kW4XJ16gHc0dMjVe/gJ+ItQ==
X-Received: by 2002:a05:6a00:230b:b0:734:9cc:a6e4 with SMTP id d2e1a72fcca58-734791ab6bfmr3168643b3a.21.1740455198810;
        Mon, 24 Feb 2025 19:46:38 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81f014sm409429b3a.156.2025.02.24.19.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:46:38 -0800 (PST)
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
Subject: [PATCH v2 2/6] mm: pgtable: change pt parameter of tlb_remove_ptdesc() to struct ptdesc *
Date: Tue, 25 Feb 2025 11:45:52 +0800
Message-Id: <60bb44299cf2d731df6592e446e7f694054d0dbe.1740454179.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1740454179.git.zhengqi.arch@bytedance.com>
References: <cover.1740454179.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_194639_332833_D2692383 
X-CRM114-Status: UNSURE (   9.92  )
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

All callers of tlb_remove_ptdesc() pass it a pointer of struct ptdesc, so
let's change the pt parameter from void * to struct ptdesc * to perform
a type safety check.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/tlb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 54f579750c8e5..18bf499ef8801 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -506,7 +506,7 @@ static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
 	return tlb_remove_page_size(tlb, page, PAGE_SIZE);
 }
 
-static inline void tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
+static inline void tlb_remove_ptdesc(struct mmu_gather *tlb, struct ptdesc *pt)
 {
 	tlb_remove_table(tlb, pt);
 }
-- 
2.20.1


