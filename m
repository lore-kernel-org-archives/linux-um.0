Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4ACC021BE
	for <linux-um@archiver.kernel.org>; Thu, 27 Feb 2025 13:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VZScFKf+GfAOC+cGkef77m9WTcLt48410fHxRRqxMGc=; b=zajseRxqXTe9vhA6xP/6ctG4ub
	wwa4lTxbsfPLHioi/cp2g0eaa/isj2kFu4q0cct+9afYb6fZaHl2Y+9IJpRivXEwcgaHSnyGPBiux
	lsNSK+070C3pdgmHUcGc8iuK/hHnU2KYzkaEkIP+y8ct/HuIQ2gzeOZHmjsa4oIxwuXFeLdjBjUBz
	a648sIsja76g3LY1qsP3eAFLjJTjOXRajh8ewJbExPAnGTWkQpd7I6MzM9SNlQJDpr/s1gGofry5R
	9wZcFufYF346ZSS/yAFuysKMxRo0LSjP+MWw1EVQcVNTxHici68WelXFMPEJfJtO/4QDgadLmQ+Cv
	w6wnzTzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tne0n-00000007Y0K-2OAN;
	Thu, 27 Feb 2025 13:33:13 +0000
Received: from mail-io1-f46.google.com ([209.85.166.46])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tndvi-00000007X1Y-39dl;
	Thu, 27 Feb 2025 13:27:59 +0000
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-851c4ee2a37so71441739f.3;
        Thu, 27 Feb 2025 05:27:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740662877; x=1741267677;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VZScFKf+GfAOC+cGkef77m9WTcLt48410fHxRRqxMGc=;
        b=HKFBXHMxZouykIz6nCU1f5dS/wuY2UnLDNZAUeLtWr6Z7aZ/matUAgUuBVHI8lRjE/
         eEh9jtp7o2FpRBpEyRiiCwxHV2KE0SzMF/BhhHUAZ2g2UCbqAu87RWrv5YBnp5wXdTAE
         vo8Ym3urPe0V7dXx8IoPf+ZB6I1UhMs/5M6zjwY3qXf909tqKxewAUBJJBrxiCzuF9FZ
         BLIAgWICe//57oEWizPZGMpjgovEyRG15/6yy7CkJb8FVKCxbP4UcNnrN4YZhBhc5rjm
         hRZINFFuRCqe0vsef7V/lLMAy5oSsKv81eB1+S1nAcbYUbCXnc3b73NHITmjcm2ap8xx
         rWfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz/65X9Rax0kb6oa5+yLC7mthQb7NV0zDC2cvlAeCK4rWB6mYxr5X+zwcSFO/73W+UFUPzDWzuJQo=@lists.infradead.org, AJvYcCXJnwlD6QvJ3qWsDEJ72TvQNbok9P5TNUJX5L/hcOlaTkgYO1C9n3IaWDne74/muoTUxpUGqFKe9fRgdQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxHhXJ0OlHJMy1ncB3sbWeVkvtCDGZVKdStP6jEDpuon8JlhT+f
	Lyr2+BGwYUP+Ox//iBR2KSI+G8VbjQCaOTR+aCQrkgvaKnI7elDWtHQAbiEP
X-Gm-Gg: ASbGncucdduBnPvHBQMtKMOa9oyvBvdxl+jU+7yPllJQJbnUkf8WtPwPR/Rmh572oHQ
	ESYo66qHlVUbrvdrsm3G46t3cATh45f3jvyfKfS0JALIEyFbj9UnnyFakt4WwVNOvASsbDczEjh
	KOjRsr+zHwF6VsrI3TpPQjADRAnMpbg5Iv9OgI4TV+a7OEmKlylK9K2zLZgfPmYGSAMn/NegE0c
	il4h2vQCyC6xZClJLj1KrP9Ka/4UCjRh3ljb7bWas11rtZ3CILBv0weRJtFlwrfS5irspQyZkvq
	x2ZrnVHNXkRt7eIAThigKYhoevDN/HoZRYkwwhCwBnuksiqrPXp2eLQa3oCtyDM5
X-Google-Smtp-Source: AGHT+IHamU4LLTk/97jcD648IXqBXLezmB+7kExwuyujnzRkmGz4BMXvwLCtcVWrH7A6+FfeiQ4lSA==
X-Received: by 2002:a05:6e02:1fc4:b0:3d3:e191:71bd with SMTP id e9e14a558f8ab-3d3e191731emr17287905ab.16.1740662876957;
        Thu, 27 Feb 2025 05:27:56 -0800 (PST)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com. [209.85.166.49])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f061c07c9bsm347636173.13.2025.02.27.05.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 05:27:56 -0800 (PST)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-85592116ca4so75341539f.1;
        Thu, 27 Feb 2025 05:27:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV7AyMzYvqq9fD72lwop5kTwsfPngNS+bCCgfERUk2iUv4hoiQVN+m4+hHjLNX8C4R4niSJ3pX64G+Fvw==@lists.infradead.org, AJvYcCXxO5W8szrrzQwkhD8EZhWHe5Mgq2umt0lhaJi8kps1yLIezkMXKvOIBPftuWzBqha2t1j5S5vadFE=@lists.infradead.org
X-Received: by 2002:a05:6122:1d53:b0:520:51a4:b81c with SMTP id
 71dfb90a1353d-5224ccbbe10mr3808700e0c.6.1740662495074; Thu, 27 Feb 2025
 05:21:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1740454179.git.zhengqi.arch@bytedance.com> <19db3e8673b67bad2f1df1ab37f1c89d99eacfea.1740454179.git.zhengqi.arch@bytedance.com>
In-Reply-To: <19db3e8673b67bad2f1df1ab37f1c89d99eacfea.1740454179.git.zhengqi.arch@bytedance.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 27 Feb 2025 14:21:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU8ttibKCiUPxSNBpJyrtBbrt1CqLa++jq6CpJFbFCwAg@mail.gmail.com>
X-Gm-Features: AQ5f1Jqe6so1GjZXdkUhIIAiYHT08E9WH9vQcbiUEIVlcQBmr8vV6ha0mxzJuRo
Message-ID: <CAMuHMdU8ttibKCiUPxSNBpJyrtBbrt1CqLa++jq6CpJFbFCwAg@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] mm: pgtable: convert some architectures to use tlb_remove_ptdesc()
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: peterz@infradead.org, kevin.brodsky@arm.com, riel@surriel.com, 
	vishal.moola@gmail.com, david@redhat.com, jannh@google.com, hughd@google.com, 
	willy@infradead.org, yuzhao@google.com, muchun.song@linux.dev, 
	akpm@linux-foundation.org, will@kernel.org, aneesh.kumar@kernel.org, 
	npiggin@gmail.com, arnd@arndb.de, dave.hansen@linux.intel.com, 
	rppt@kernel.org, alexghiti@rivosinc.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-um@lists.infradead.org, x86@kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250227_052758_782075_5628E69E 
X-CRM114-Status: GOOD (  20.80  )
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

Hi Qi,

On Tue, 25 Feb 2025 at 04:46, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> Now, the nine architectures of csky, hexagon, loongarch, m68k, mips,
> nios2, openrisc, sh and um do not select CONFIG_MMU_GATHER_RCU_TABLE_FREE,
> and just call pagetable_dtor() + tlb_remove_page_ptdesc() (the wrapper of
> tlb_remove_page()). This is the same as the implementation of
> tlb_remove_{ptdesc|table}() under !CONFIG_MMU_GATHER_TABLE_FREE, so
> convert these architectures to use tlb_remove_ptdesc().
>
> The ultimate goal is to make the architecture only use tlb_remove_ptdesc()
> or tlb_remove_table() for page table pages.
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks for your patch!

>  arch/m68k/include/asm/sun3_pgalloc.h | 3 +--

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

> --- a/arch/m68k/include/asm/sun3_pgalloc.h
> +++ b/arch/m68k/include/asm/sun3_pgalloc.h
> @@ -19,8 +19,7 @@ extern const char bad_pmd_string[];
>
>  #define __pte_free_tlb(tlb, pte, addr)                         \
>  do {                                                           \
> -       pagetable_dtor(page_ptdesc(pte));                       \
> -       tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));        \
> +       tlb_remove_ptdesc((tlb), page_ptdesc(pte));             \
>  } while (0)
>

With only a single statement remaining, you can remove the do { ... }
while construct, too.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

