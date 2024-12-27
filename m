Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E5BE7718B
	for <linux-um@archiver.kernel.org>; Fri, 27 Dec 2024 16:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:Message-ID:To:From:CC:In-Reply-To:Subject:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=J4Xw2EJnY1X4WK+jvdY4voHsewcHZzxXdmJCqhZbsvE=; b=Tnqm8aKuVd04ODlOuaYc4LZ62b
	zGGzUwdTMVX1pnoBkTX48aFOE2v1PDVx9QZFpXyhLlrUDVQuegiITFSNem60irZ7DNpHacjgA/EQR
	Ep0Y5hhmAbp24BWseApdRzEKDU8EIGD5WviR4M7hVmC2M4+lArGu6SljgOAmpUZdAG+SXi37eg+tI
	vZezBqYbiwNiZbZwGKzGEUU2njnSlWJ5Trmac9JDpxvajkAsCGu0P91ptVJknFbjWyiJXK9bW7jGf
	sEQ6ftww+e9cfkKya0RprFmhSVJIGjLvNtz45DNuoFLua3tBEV8bK6XWvhGQGfn/zsXCtgG8jiCeo
	m9xsq0wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tRDOz-00000000dCr-3jGG;
	Fri, 27 Dec 2024 16:41:29 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tRDNo-00000000d1u-27P4
	for linux-um@lists.infradead.org;
	Fri, 27 Dec 2024 16:40:18 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-21680814d42so79974835ad.2
        for <linux-um@lists.infradead.org>; Fri, 27 Dec 2024 08:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1735317614; x=1735922414; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4Xw2EJnY1X4WK+jvdY4voHsewcHZzxXdmJCqhZbsvE=;
        b=nhGfAHd5lMV0MYGeDcMxR1IelDmZrIHLKZicdttrt7vLC5yaxQQ8+SOBH9gUaaDnyw
         Ebf7HgqGjMMYbdo4ZUEuO+aiiLw3fiQazpkLxT/Xbgl3KXrWY4q5JMbThQLS25PqUY5R
         VGLOlettHj7jDgvHAcIf0CqCPd+B8DQUHZgzCqsmiUjALqOjUhlgJaD3Q2qqiS5GaBHW
         B3H1SWcFrBdb0Kf8VCLQUlEr6KrLGNO7CZmGo4YYKTm4n0iYymEV0qb3pUpg0Co6eBxG
         jm9j1YFXWqf5Wg4InolNPSbaEMTDTexjGHFurHq95rZI2y9ng0js/sqhJZL22PrScJqE
         A0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735317614; x=1735922414;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4Xw2EJnY1X4WK+jvdY4voHsewcHZzxXdmJCqhZbsvE=;
        b=jihxBMGBOvEbBtiNvJoShqzTz7KglBpa+fl93dWCCHjkynXlWd+55ZfLPK+7zKFYIs
         WNsV+jK290ICOv0KaIp4iBkvQ9WIKwYs7oQVGxF50xoStIfGNxYr4h3+tEK6RZbx59X1
         ND2Jx2ftYGVaBY1b7AL/uZD/sazQHzOTYx5wxoOrdlp/PgeDhqAIlhit4y1LgFBt2h62
         wH1JqbGbFxXOO7IgZW6SFIpPOcW1GRhog76Nkno/hYJF6PnFscJqXSNW47+jGFgRpFzp
         UT4g5peRAW8/ECXuPfOdr5XX6pZ/Ix5Gjl/ZIQPQh7bGjvzpWx1kwnOC5z6GPoYIAKM4
         iyOg==
X-Forwarded-Encrypted: i=1; AJvYcCWhKHprD3MuCS55fD7HjoUjhe8PEX7HAWFJTcZ1uFbABIwNjsQRd73KA+M6UECbvU/d7QS0MvflmQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzVktUFFk9K16PmxulkyBFr3x0zTwQeJxfV/6E4r8pgJ4NsuWxY
	k5+qhl4XN+youA6OFdb4iggHsy1XQvMj9X/FyJ+0z8XdaECI47Q5toHYo1TBTUs=
X-Gm-Gg: ASbGnctE5m0mSXj/8opuq4xa2tFh3ERAmtEP5/SnQxrVSiU67CrxeXacM34Zhm08Xfu
	JN6adrMtGT57xZrOKQQReRiFPHRV6/qKH5p/3ki5uppvIP9/Fm3+b6BR3AJL3XvvTkA3nUEG1rD
	Ni8CqOiv58MUfBVnWrlW4qgyydam/OT2Xi6S7Vmct+N+hL2Tfs+s+EhHN7//Homwo6BVQmz0/At
	nIPFAG2B7CyHz6GqM71KiSrZeudrZ9zYWtCCBuDmaeb/zPftQ==
X-Google-Smtp-Source: AGHT+IGj5bTxRBL/TPC4rp9UNK8vWD764vaF6GBCxeBJ0bzTi0HACd7gUMrcV8Bcwh/Ub684hrsLqw==
X-Received: by 2002:a17:902:f645:b0:216:5556:8b46 with SMTP id d9443c01a7336-219e70dbcf8mr427204505ad.49.1735317614352;
        Fri, 27 Dec 2024 08:40:14 -0800 (PST)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-89eaa1c4fdfsm7512714a12.60.2024.12.27.08.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 08:40:13 -0800 (PST)
Date: Fri, 27 Dec 2024 08:40:13 -0800 (PST)
X-Google-Original-Date: Fri, 27 Dec 2024 08:40:12 PST (-0800)
Subject: Re: [PATCH v3 02/17] riscv: mm: Skip pgtable level check in {pud,p4d}_alloc_one
In-Reply-To: <84ddf857508b98a195a790bc6ff6ab8849b44633.1734945104.git.zhengqi.arch@bytedance.com>
CC: peterz@infradead.org, agordeev@linux.ibm.com, kevin.brodsky@arm.com,
  tglx@linutronix.de, david@redhat.com, jannh@google.com, hughd@google.com, yuzhao@google.com,
  willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org, lorenzo.stoakes@oracle.com,
  akpm@linux-foundation.org, rientjes@google.com, vishal.moola@gmail.com, Arnd Bergmann <arnd@arndb.de>,
  Will Deacon <will@kernel.org>, aneesh.kumar@kernel.org, npiggin@gmail.com, dave.hansen@linux.intel.com,
  rppt@kernel.org, ryan.roberts@arm.com, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
  linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
  sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org,
  linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
  linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
  linux-sh@vger.kernel.org, linux-um@lists.infradead.org, zhengqi.arch@bytedance.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: zhengqi.arch@bytedance.com
Message-ID: <mhng-3d6d3e65-b264-4033-b985-fa7763cacf9e@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241227_084016_546135_7CC3F7D6 
X-CRM114-Status: GOOD (  22.06  )
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

On Mon, 23 Dec 2024 01:40:48 PST (-0800), zhengqi.arch@bytedance.com wrote:
> From: Kevin Brodsky <kevin.brodsky@arm.com>
>
> {pmd,pud,p4d}_alloc_one() is never called if the corresponding page
> table level is folded, as {pmd,pud,p4d}_alloc() already does the
> required check. We can therefore remove the runtime page table level
> checks in {pud,p4d}_alloc_one. The PUD helper becomes equivalent to
> the generic version, so we remove it altogether.
>
> This is consistent with the way arm64 and x86 handle this situation
> (runtime check in p4d_free() only).
>
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  arch/riscv/include/asm/pgalloc.h | 22 ++++------------------
>  1 file changed, 4 insertions(+), 18 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
> index f52264304f772..8ad0bbe838a24 100644
> --- a/arch/riscv/include/asm/pgalloc.h
> +++ b/arch/riscv/include/asm/pgalloc.h
> @@ -12,7 +12,6 @@
>  #include <asm/tlb.h>
>
>  #ifdef CONFIG_MMU
> -#define __HAVE_ARCH_PUD_ALLOC_ONE
>  #define __HAVE_ARCH_PUD_FREE
>  #include <asm-generic/pgalloc.h>
>
> @@ -88,15 +87,6 @@ static inline void pgd_populate_safe(struct mm_struct *mm, pgd_t *pgd,
>  	}
>  }
>
> -#define pud_alloc_one pud_alloc_one
> -static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
> -{
> -	if (pgtable_l4_enabled)
> -		return __pud_alloc_one(mm, addr);
> -
> -	return NULL;
> -}
> -
>  #define pud_free pud_free
>  static inline void pud_free(struct mm_struct *mm, pud_t *pud)
>  {
> @@ -118,15 +108,11 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
>  #define p4d_alloc_one p4d_alloc_one
>  static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
>  {
> -	if (pgtable_l5_enabled) {
> -		gfp_t gfp = GFP_PGTABLE_USER;
> -
> -		if (mm == &init_mm)
> -			gfp = GFP_PGTABLE_KERNEL;
> -		return (p4d_t *)get_zeroed_page(gfp);
> -	}
> +	gfp_t gfp = GFP_PGTABLE_USER;
>
> -	return NULL;
> +	if (mm == &init_mm)
> +		gfp = GFP_PGTABLE_KERNEL;
> +	return (p4d_t *)get_zeroed_page(gfp);
>  }
>
>  static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

Are you trying to keep these together, or do you want me to try and pick 
up the RISC-V bits on their own?

