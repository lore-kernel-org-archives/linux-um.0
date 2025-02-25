Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FD0C021B2
	for <linux-um@archiver.kernel.org>; Tue, 25 Feb 2025 04:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=36KztU5HqI7wNxhzV6WNrh7mWCrhUr2tDKJnWGxYavY=; b=NdTQP2+Id/NnvcYrKemR6KHhpg
	JmHAzsMNW8p0sFANdCUbkKedn/sjpPLbkXxo+sMqAhfeLmzJc8Qq/+7kRPa8yulYlAYk9eT2qsybY
	RtNxPvcKU75LvsJTpm/+I5NORYw9QEgZJpQNB1H96Y0oPJfOz7DojtaF+0lUeRsHXQJUZVhmVvwI5
	27pwqnaO82W8x8ROlZiwcNH1NdEsetV8VrTUgQiezqtlt8DclKBzt141PlT2XESJDNL40AlSMAM81
	jIE23xNIMP7exrRu98qxAb4xjpsIx/9xN9o7dJVdcVdcj3xyEwB+gKS81xqRcAB3c3OcbWwESOY3L
	z548McVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmmw8-0000000FyTX-2dF4;
	Tue, 25 Feb 2025 04:52:52 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmluo-0000000FtxY-1kzx
	for linux-um@bombadil.infradead.org;
	Tue, 25 Feb 2025 03:47:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=36KztU5HqI7wNxhzV6WNrh7mWCrhUr2tDKJnWGxYavY=; b=k8Zr6+0cpX+MnxKSSN7kaWcNJq
	pW40Rr6tHDgqLPKAht5Yh3IjbvqAISO7t6dswh5arxYSwfAUkXxrL6txdgy6s3aan7y1fxmV4Kx7p
	2MyboJ6m2Z6NcIMUABxQmsrnNLjeHCjty0nWUYdtrdYbDJxXc95vFwhnvjCkoUyYWGi3t0CHha/4b
	kMm+/xPWM4L2kxGQsm9D6s3oixTgoW1d7fn5NmzaTNbGW1ehivHFYVrMXeoF/yWty5ecNWdcZrqGm
	/emRb8uB3PpIzEr/Z1JkvWHSN/5hZrGNc+c8hO+Ds9i49thoTF1AAd0rJj+GCeI0noHoSeFxBaz2m
	Q+Vz3nFA==;
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmlud-00000003Hu4-3Ul5
	for linux-um@lists.infradead.org;
	Tue, 25 Feb 2025 03:47:18 +0000
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2fc0bd358ccso10323383a91.2
        for <linux-um@lists.infradead.org>; Mon, 24 Feb 2025 19:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740455228; x=1741060028; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36KztU5HqI7wNxhzV6WNrh7mWCrhUr2tDKJnWGxYavY=;
        b=J3PntTs/xUVENdv7e2YSnXXHfalq2wuT0ENTAgW0+zxVq6jmICrFY/8q5LIDpA6AtK
         EII68QDhRE9qPnghFAwYCY+hzXO2JAr+JedmRFwE7y2TK+3+cH2tKuRI7epDQVuLUhXU
         6re/k/lwXyS/52VqtRC11ho0BwacZpc9szt9jBt3b7KQMhWLF9CDIg0gx1A1RyWDqQP2
         SrzuHFZkeGTee0u6R5eZgD1xKMp1Zg6/kY3CzRr9yp7cwEZ8yLiHK0iGJmVfOzvjDskC
         op8WMQYBi9rZ8bua+iV/kNnBjz7/Vf/ncQ3kPrynxzeM8CoAidGSrpQdSXgL48G4Cf5y
         45pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455228; x=1741060028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36KztU5HqI7wNxhzV6WNrh7mWCrhUr2tDKJnWGxYavY=;
        b=Tih4g/S6IOYp/2WIEeaayCfg3u12Iztq4raveKye4D1jtW2uSuuTznf4WTb6ZieBAJ
         duWFl8a4u7Nk+McQQx8kFpD3J5DoSs1ozQ4iMILeuPtS3SlaGS/zVuTK/99LppBmfg9a
         oOdMgb6S3GFusUMdjecyMR2Z4noG8uhxzmYAws+BLcBCW20K3ZhMu+NAntw13ycF6h6k
         KTAsRgcGRKx7RHVhTO4Vh94Lp4uTMdy5NtM3h8Dg5I2rx8oabxGwVzDACla2oAr+3LS/
         tKDYT5+ivBI1Gov+dRdhVe2Lj05SJEEpmKcaDb6WzJNE960eUwWn0jrv0+oXncIy00k2
         H9fQ==
X-Forwarded-Encrypted: i=1; AJvYcCWusHIK+fcmIuNGkSQ75K2rqvvnkXGOIXEml+8E1M812yvvypIAphmvRLYsjqJKijPS4otrlKzv3A==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywb1hXK5eGsf2xi11N8s15Es0OzXabyvqx/kSZdhNBh72AEx19a
	t3f2ahPPCGJtOxl8I4INNK/DYNDfQo2u4O1sWUjLHjXYz/lTrdpRoEw/l7PBs6c=
X-Gm-Gg: ASbGncuT2plamMcaTMXrRU5+/t7Q2uOB5uXBmSWVXaFy4+qjyWvvkz4GtOeEikt3yQY
	DidH+HYIOjZLIC5RsWNYLGQdXQBm33pEAxqaXzseaDy2ng9SybzKZWVP6fylRCb34zQ3ChPdtFW
	Izrycx2+QfGrIX1IZEQ4+u1HToCxCD+1SZYtb6IqdIz6geKXAhvNzhNtWorJqHTCDuBgkeOs7Y4
	PvFRoQ9hvS2z90pW3z55aiHet4jbAl72T06pEOGQm/big19bws8AouvJi9iuIjYBFIa9MJyXSFB
	B08167YyLm18UOuQaWPAYv5iCeJTAxcSYColdgtNticBR7Qrl1PtUYBWjrkTE7DxpA==
X-Google-Smtp-Source: AGHT+IHErQlNtWAOdWTcDw4ZwAn3kttLeu4q3Mf0dru9ScBNUcUevexLBEyVDaZ2sKSBMgz3Y5FwbQ==
X-Received: by 2002:a05:6a21:7a44:b0:1ee:cb9c:9dc9 with SMTP id adf61e73a8af0-1f0fc89a091mr2965600637.35.1740455228677;
        Mon, 24 Feb 2025 19:47:08 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81f014sm409429b3a.156.2025.02.24.19.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:47:08 -0800 (PST)
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
Subject: [PATCH v2 5/6] x86: pgtable: convert to use tlb_remove_ptdesc()
Date: Tue, 25 Feb 2025 11:45:55 +0800
Message-Id: <36ad56b7e06fa4b17fb23c4fc650e8e0d72bb3cd.1740454179.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1740454179.git.zhengqi.arch@bytedance.com>
References: <cover.1740454179.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_034716_096534_F2F25A38 
X-CRM114-Status: UNSURE (   9.07  )
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

The x86 has already been converted to use struct ptdesc, so convert it to
use tlb_remove_ptdesc() instead of tlb_remove_table().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/x86/mm/pgtable.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index b1c1f72c1fd1b..f28ddac0f734a 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -45,7 +45,7 @@ early_param("userpte", setup_userpte);
 void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte)
 {
 	paravirt_release_pte(page_to_pfn(pte));
-	tlb_remove_table(tlb, page_ptdesc(pte));
+	tlb_remove_ptdesc(tlb, page_ptdesc(pte));
 }
 
 #if CONFIG_PGTABLE_LEVELS > 2
@@ -59,21 +59,21 @@ void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
 #ifdef CONFIG_X86_PAE
 	tlb->need_flush_all = 1;
 #endif
-	tlb_remove_table(tlb, virt_to_ptdesc(pmd));
+	tlb_remove_ptdesc(tlb, virt_to_ptdesc(pmd));
 }
 
 #if CONFIG_PGTABLE_LEVELS > 3
 void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
 {
 	paravirt_release_pud(__pa(pud) >> PAGE_SHIFT);
-	tlb_remove_table(tlb, virt_to_ptdesc(pud));
+	tlb_remove_ptdesc(tlb, virt_to_ptdesc(pud));
 }
 
 #if CONFIG_PGTABLE_LEVELS > 4
 void ___p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d)
 {
 	paravirt_release_p4d(__pa(p4d) >> PAGE_SHIFT);
-	tlb_remove_table(tlb, virt_to_ptdesc(p4d));
+	tlb_remove_ptdesc(tlb, virt_to_ptdesc(p4d));
 }
 #endif	/* CONFIG_PGTABLE_LEVELS > 4 */
 #endif	/* CONFIG_PGTABLE_LEVELS > 3 */
-- 
2.20.1


