Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52FCE77188
	for <linux-um@archiver.kernel.org>; Fri,  3 Jan 2025 03:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oBhK1CXUGm9csX2RzVpIIXFvov7I6iYRPJ+9MZcmeVs=; b=1pa+/qrDsND2oRmSl7+dvkeUCa
	b5DOOolCHBX0ylchsCPwsyyxLKMuhTWbD8/C4/H2n4aRDbC3gdLW2FBWU/LM/HPTMuUGMVTAyveGM
	+O+XvOuTRgYT4lu9sOgyi9Htyx4WA8HBPXZV9i/GZDc7OXyKb8uVzJGzSvJeTpvy24vdY2RyNufSI
	a1AN04DHWyUqRwoSZMGEqNQg2l3pk/sz5vtWPAfYl9E001hVI25s4jr9ZEPjpqhSx3df5bMxGnD/b
	Asfe7XSNMPvWgb9MT+ttPNkACUfRFrpMdXD2UeiCVqBDdQySlQh5SzdJv7zBtr0dvmwWKznYV2iE9
	1vvTPlOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTYg4-0000000C2Io-2KgP;
	Fri, 03 Jan 2025 03:48:48 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tTYg2-0000000C2Gz-2hFT
	for linux-um@lists.infradead.org;
	Fri, 03 Jan 2025 03:48:48 +0000
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2f44353649aso13428729a91.0
        for <linux-um@lists.infradead.org>; Thu, 02 Jan 2025 19:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735876122; x=1736480922; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oBhK1CXUGm9csX2RzVpIIXFvov7I6iYRPJ+9MZcmeVs=;
        b=BJGde7YoTNrUTlt1B5LWCYxyDaB0MF0I8Iy2VsnqTgthYQrO2kJWkKIQpd4Tu9Wuc+
         ky9AVRBW5XPSWPmMsJ+sBP5X/coOMeWgarAZ2ixfPpH9OSHgG5CK3xXixD5oic2PYPoy
         AZu/dggDyNRmq/rpNXzxtAwWbcSzny/9Np/tOqq6DUQ+b2mENnaysHKW/ypDoKLS33VX
         vvWWpwD6k8YcAyEUEAGQLAKftmOrwJnqErak7fjopi7FjgdANHy4Z6IjRBNUz3DAyaPJ
         5jbxhgm4/q7Ej4PXchQEWW6wPlxo0Wb5dnjlDIzlNEACZrBukcQlmPQQppJvhLCwftiz
         1fEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735876122; x=1736480922;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oBhK1CXUGm9csX2RzVpIIXFvov7I6iYRPJ+9MZcmeVs=;
        b=O/XtOQmtKqTmQ/eA6Bt32JLUZKmWOy3Napp6i+o8hlVoMfXhY22MM5KLW7uAwNwCuZ
         Nd/wTmfjg4Sx7C4JD94gpxLjlGyxy30tseNb/PNRwq1AXBt6QziTOKTRG2lnDh9/G2Ze
         bhuQdNp6ddkAbZhbKMiqBH9MmHS6dizYqm6bdqhKvt6wFQaP0e/bUZgRPP0QUWjeOpds
         iJEPiVr3ZxWDXtPB3GSm179USuhHYbLaTZ4Mahf5/7y2aszN8Xp91Yd+UeCXS6A2mIfK
         0f/a/Fgq2ctvvkr6cmD2YlJoogkxupLRxYLoaarFCrQw/KHwdWzu2Ogxve6PWtiXWPlw
         oQ1A==
X-Forwarded-Encrypted: i=1; AJvYcCUV217bKa2VIMPqxRbHTjaxvQ/1uifjvRBoT3Bo6YM3EY+qGah3vbSKJR2FGc3lkDaa1UAV6LRAEg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxGZCZ0oCaA8FvqsO2P2smNao2nyNmLn/8+8cLXLTfRUIdj51vJ
	ClRLA8tMW2leN1LYZL4lfobtlsm8ifJC2ECjgBIcn+dcRcBqfjxGE0ixhEbvCpY=
X-Gm-Gg: ASbGncvmjmZMoO4/evQb2IktN6k1If+iSFeCNOx2Vrtd16zHSJjl65gBJCuwFO6JA8V
	8xcxFIMa4GIkq50QfUJJnN14gnWKjWz3LXwbRZ3x9zsdDCvEIOnIUlyWBJhGSrLQPEqBAup0yaM
	/U0xliVk8m5ZBVSLuINELxclWzNRDigCvt0WTUYYW5ISqQGgy5hHQrgMZMXJASzXGumtyrAW9iA
	rKz+ApNiFMjvPF2yrKtpRaJ2V0ZpbzRiuDl493DijmwamHfUfeq/cBVNpE4Mngs2nNSZdlOFey2
	D09mgQ==
X-Google-Smtp-Source: AGHT+IGYgpZrnqPiPCHLxVCKQrrsZq8D5LYrHf09cYbjj5EwfNYfddJqRahKvm2mW4f56s0g/0EfTw==
X-Received: by 2002:a05:6a00:2449:b0:728:e906:e45a with SMTP id d2e1a72fcca58-72abdecdbfdmr70684623b3a.24.1735876121963;
        Thu, 02 Jan 2025 19:48:41 -0800 (PST)
Received: from [10.84.148.23] ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad84eb50sm25233750b3a.90.2025.01.02.19.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2025 19:48:41 -0800 (PST)
Message-ID: <ebce5e05-5e46-4c6e-94a0-bcf3655a862b@bytedance.com>
Date: Fri, 3 Jan 2025 11:48:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/15] riscv: pgtable: move pagetable_dtor() to
 __tlb_remove_table()
Content-Language: en-US
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: peterz@infradead.org, agordeev@linux.ibm.com, palmer@dabbelt.com,
 tglx@linutronix.de, david@redhat.com, jannh@google.com, hughd@google.com,
 yuzhao@google.com, willy@infradead.org, muchun.song@linux.dev,
 vbabka@kernel.org, lorenzo.stoakes@oracle.com, akpm@linux-foundation.org,
 rientjes@google.com, vishal.moola@gmail.com, arnd@arndb.de, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, dave.hansen@linux.intel.com,
 rppt@kernel.org, ryan.roberts@arm.com, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
 <0e8f0b3835c15e99145e0006ac1020ae45a2b166.1735549103.git.zhengqi.arch@bytedance.com>
 <1b09335c-f0b6-4ccb-9800-5fb22f7e8083@arm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <1b09335c-f0b6-4ccb-9800-5fb22f7e8083@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250102_194846_838763_1A2A4E7F 
X-CRM114-Status: GOOD (  17.65  )
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

Hi Kevin,

On 2025/1/3 00:53, Kevin Brodsky wrote:
> On 30/12/2024 10:07, Qi Zheng wrote:
>>   static inline void riscv_tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
>>   {
>> -	if (riscv_use_sbi_for_rfence())
>> +	if (riscv_use_sbi_for_rfence()) {
>>   		tlb_remove_ptdesc(tlb, pt);
>> -	else
>> +	} else {
>> +		pagetable_dtor(pt);
>>   		tlb_remove_page_ptdesc(tlb, pt);
> 
> I find the imbalance pretty confusing: pagetable_dtor() is called
> explicitly before using tlb_remove_page() but not tlb_remove_ptdesc().
> Doesn't that assume that CONFIG_MMU_GATHER_HAVE_TABLE_FREE is selected?
> Could we not call pagetable_dtor() from __tlb_batch_free_encoded_pages()
> to ensure that the dtor is always called just before freeing, and remove

In __tlb_batch_free_encoded_pages(), we can indeed detect PageTable()
and call pagetable_dtor() to dtor the page table pages.
But __tlb_batch_free_encoded_pages() is also used to free normal pages
(not page table pages), so I don't want to add overhead there.

But now I think maybe we can do this in tlb_remove_page_ptdesc(), like
this:

diff --git a/arch/csky/include/asm/pgalloc.h 
b/arch/csky/include/asm/pgalloc.h
index f1ce5b7b28f22..e45c7e91dcbf9 100644
--- a/arch/csky/include/asm/pgalloc.h
+++ b/arch/csky/include/asm/pgalloc.h
@@ -63,7 +63,6 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)

  #define __pte_free_tlb(tlb, pte, address)              \
  do {                                                   \
-       pagetable_dtor(page_ptdesc(pte));               \
         tlb_remove_page_ptdesc(tlb, page_ptdesc(pte));  \
  } while (0)

diff --git a/arch/hexagon/include/asm/pgalloc.h 
b/arch/hexagon/include/asm/pgalloc.h
index 40e42a0e71673..9903449f45cff 100644
--- a/arch/hexagon/include/asm/pgalloc.h
+++ b/arch/hexagon/include/asm/pgalloc.h
@@ -89,7 +89,6 @@ static inline void pmd_populate_kernel(struct 
mm_struct *mm, pmd_t *pmd,

  #define __pte_free_tlb(tlb, pte, addr)                         \
  do {                                                           \
-       pagetable_dtor((page_ptdesc(pte)));                     \
         tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));      \
  } while (0)

diff --git a/arch/loongarch/include/asm/pgalloc.h 
b/arch/loongarch/include/asm/pgalloc.h
index 7211dff8c969e..de5b3f5c85d1c 100644
--- a/arch/loongarch/include/asm/pgalloc.h
+++ b/arch/loongarch/include/asm/pgalloc.h
@@ -57,7 +57,6 @@ static inline pte_t *pte_alloc_one_kernel(struct 
mm_struct *mm)

  #define __pte_free_tlb(tlb, pte, address)                      \
  do {                                                           \
-       pagetable_dtor(page_ptdesc(pte));                       \
         tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));        \
  } while (0)

diff --git a/arch/m68k/include/asm/sun3_pgalloc.h 
b/arch/m68k/include/asm/sun3_pgalloc.h
index 2b626cb3ad0ae..731cc8f0731d3 100644
--- a/arch/m68k/include/asm/sun3_pgalloc.h
+++ b/arch/m68k/include/asm/sun3_pgalloc.h
@@ -19,7 +19,6 @@ extern const char bad_pmd_string[];

  #define __pte_free_tlb(tlb, pte, addr)                         \
  do {                                                           \
-       pagetable_dtor(page_ptdesc(pte));                       \
         tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));        \
  } while (0)

diff --git a/arch/mips/include/asm/pgalloc.h 
b/arch/mips/include/asm/pgalloc.h
index 36d9805033c4b..964ad514be281 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -56,7 +56,6 @@ static inline void pgd_free(struct mm_struct *mm, 
pgd_t *pgd)

  #define __pte_free_tlb(tlb, pte, address)                      \
  do {                                                           \
-       pagetable_dtor(page_ptdesc(pte));                       \
         tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));        \
  } while (0)

diff --git a/arch/nios2/include/asm/pgalloc.h 
b/arch/nios2/include/asm/pgalloc.h
index 12a536b7bfbd4..ef6b4b8301ac6 100644
--- a/arch/nios2/include/asm/pgalloc.h
+++ b/arch/nios2/include/asm/pgalloc.h
@@ -30,7 +30,6 @@ extern pgd_t *pgd_alloc(struct mm_struct *mm);

  #define __pte_free_tlb(tlb, pte, addr)                                 \
         do {                                                            \
-               pagetable_dtor(page_ptdesc(pte));                       \
                 tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));      \
         } while (0)

diff --git a/arch/openrisc/include/asm/pgalloc.h 
b/arch/openrisc/include/asm/pgalloc.h
index 596e2355824e3..9361205610910 100644
--- a/arch/openrisc/include/asm/pgalloc.h
+++ b/arch/openrisc/include/asm/pgalloc.h
@@ -68,7 +68,6 @@ extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);

  #define __pte_free_tlb(tlb, pte, addr)                         \
  do {                                                           \
-       pagetable_dtor(page_ptdesc(pte));                       \
         tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));      \
  } while (0)

diff --git a/arch/riscv/include/asm/pgalloc.h 
b/arch/riscv/include/asm/pgalloc.h
index c8907b8317115..61c26576614da 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -25,12 +25,10 @@
   */
  static inline void riscv_tlb_remove_ptdesc(struct mmu_gather *tlb, 
void *pt)
  {
-       if (riscv_use_sbi_for_rfence()) {
+       if (riscv_use_sbi_for_rfence())
                 tlb_remove_ptdesc(tlb, pt);
-       } else {
-               pagetable_dtor(pt);
+       else
                 tlb_remove_page_ptdesc(tlb, pt);
-       }
  }

  static inline void pmd_populate_kernel(struct mm_struct *mm,
diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
index 96d938fdf2244..5b5c73e9fdb4b 100644
--- a/arch/sh/include/asm/pgalloc.h
+++ b/arch/sh/include/asm/pgalloc.h
@@ -34,7 +34,6 @@ static inline void pmd_populate(struct mm_struct *mm, 
pmd_t *pmd,

  #define __pte_free_tlb(tlb, pte, addr)                         \
  do {                                                           \
-       pagetable_dtor(page_ptdesc(pte));                       \
         tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));      \
  } while (0)

diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.h
index f0af23c3aeb2b..4fd59fb184818 100644
--- a/arch/um/include/asm/pgalloc.h
+++ b/arch/um/include/asm/pgalloc.h
@@ -27,7 +27,6 @@ extern pgd_t *pgd_alloc(struct mm_struct *);

  #define __pte_free_tlb(tlb, pte, address)                      \
  do {                                                           \
-       pagetable_dtor(page_ptdesc(pte));                       \
         tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));      \
  } while (0)

@@ -35,7 +34,6 @@ do { 
        \

  #define __pmd_free_tlb(tlb, pmd, address)                      \
  do {                                                           \
-       pagetable_dtor(virt_to_ptdesc(pmd));                    \
         tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pmd));     \
  } while (0)

@@ -43,7 +41,6 @@ do { 
        \

  #define __pud_free_tlb(tlb, pud, address)                      \
  do {                                                           \
-       pagetable_dtor(virt_to_ptdesc(pud));            \
         tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pud));     \
  } while (0)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index a96d4b440f3da..a59205863f431 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -506,6 +506,7 @@ static inline void tlb_remove_ptdesc(struct 
mmu_gather *tlb, void *pt)
  /* Like tlb_remove_ptdesc, but for page-like page directories. */
  static inline void tlb_remove_page_ptdesc(struct mmu_gather *tlb, 
struct ptdesc *pt)
  {
+       pagetable_dtor(pt);
         tlb_remove_page(tlb, ptdesc_page(pt));
  }

This avoids explicitly calling pagetable_dtor() in the architecture
code. If that makes sense, I can send a formal separate patch to do
this.

Thanks,
Qi


> the extra handling from arch code? I may well be missing something, I'm
> not super familiar with the tlb handling code >
> - Kevin

