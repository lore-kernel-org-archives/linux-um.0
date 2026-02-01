Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCE4D172A6
	for <linux-um@archiver.kernel.org>; Sun,  1 Feb 2026 22:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nxxXeMZ2Mj2NhEcakAGevZjWJ8Zk/OwUaMBA61xjWow=; b=aS4pHzvy6yI7cSEeNaVYUtPHE6
	u9HG4gujF4tS2cQTwQH+YPckDs4W+dVXC2SOoD6W+vexpQAKeBtvYMHMQHM8h0r+elVYYTqg/2ZIS
	Je62qx0qcB+AK6UsBd2hm28RSULdFlGzI2BOVEuV7ZKePEuSBMb+WY+vyJA7IzLkaB+ns6H3Vaqxr
	c4ZoW20hHKm0QA4lK0nAjoJeu1LijvQ1thO80I7DJStS/kBGLf4Ahe63/SPEno8NntGbmLQB+LorW
	xmU6Un09KJZ+IdT8Wxt115CumWBsJ+jaVc6eQiM3VRYfkELqezyJys/0K1os4v8rFjd4J4bnwVvyu
	M9qePNOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmfVs-00000004BvU-1C7D;
	Sun, 01 Feb 2026 22:01:48 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmfVo-00000004Bv9-1sFN
	for linux-um@lists.infradead.org;
	Sun, 01 Feb 2026 22:01:46 +0000
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-65808d08423so5662559a12.1
        for <linux-um@lists.infradead.org>; Sun, 01 Feb 2026 14:01:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769983302; cv=none;
        d=google.com; s=arc-20240605;
        b=DUPmWj5UbfW8yc9405b2R8SfiZktwD0FiJ0dFK1LgzJVUHQdTJMFGWJ5govx3mOTf/
         W4N34GEj9yNOZtBBY2fvzHlg09i9YuIj68oFsOmmKPujdn8/iOukA+U3aR7zfeIc52IF
         ONp7u+BcWo6pmNXweRy1rawzYIEfpSgiiM1NbEIIQ5/GK0Zk57vtomDHYcxvsPe5kVEm
         eLh0vi3ibkivJO0QNFPJJ7TthFAFfeWYs+yxC0s373DrNgpFQNf7V1o0qDs9zh4msL55
         PmYYfMriayUw0YirSnM5eYcXLC+8oY7vqMfQ/8P79HnFv/Yd52kVV7/8LhQhQKigIKRb
         e36g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nxxXeMZ2Mj2NhEcakAGevZjWJ8Zk/OwUaMBA61xjWow=;
        fh=zYI1s2KnELN7K+g58MIFK4L57pwtoTaY46GG1b7lmqQ=;
        b=WjjjID/fGTUF4IQiw/o5fSw68cHuIB1OgPRp1WUabb8lTXcDrAoy6wVcyMq7WqJXtv
         UH2WvRpv9Rd9B7EX9jYLla6ZAQz/v9eIEbFEChWKCJ4Kk8Vpk03mxZNBfax1EFMWdphV
         //WCjNquZimwvNA2ufXiMqremzjRz+VPlAy+45qaF7CtYG9Xu5ksg7bIfmSMpgJUrjRz
         fpJobCeLgYBEu7uqxbI4rL/DKI8jC7wERsMKUgpqiUXNZh3vTL+zBFRsF1BS5Zh1du0b
         96bMNOcPnGpojLsJLyhEmwZmAUjCaCIza6RmERQ2yhbg5b/VN1B19EttDVmcz9KXKgGC
         rAlg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769983302; x=1770588102; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxxXeMZ2Mj2NhEcakAGevZjWJ8Zk/OwUaMBA61xjWow=;
        b=fQma6iQb9IIW2glXIFqH2RN2D0S2upALw1IhNNv/Ltt/nS/egYI5WfyW1nrJmx+9FU
         g/nXcAmckY+PB9yAxoKJMB1zxL5Djur2ypJfYxc5lfZE5Wu08ALyMfDVazPBN7qOyKzI
         YttI5GjFrdwOcXit3TkzKKLBEJV85TaWaSupKNVyDWH++AdEfC1haLdCYvNVF/MW0yhM
         vGeRgsjqi1zjij3ygzkKBmi8kt0E/1NOfZ87VGmisyY2s9ARwFoc9nzIJWhTNU8vNs60
         l7NK5/NsKg24XFsvKjteTJ4b0oYB9wQZ+BnpoxpHD54b+wS9b4XgKhvQZgS479Pzfa3R
         XlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769983302; x=1770588102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nxxXeMZ2Mj2NhEcakAGevZjWJ8Zk/OwUaMBA61xjWow=;
        b=UylR2CiZvsErUCcr5SsO3DyRf8nvhb1pHA5IhtCBJwDY3RyGLJQSlw6ehT0+y7h4/F
         exhJXFiPWNCgol/hYrLzK4Bas/at8c69SlXBHGkAyVMOgGxmTBF7JQqvuhrNup7Y6F0O
         I7sVT3d4SdOMUt90k9vBmGRwTfHkSwV0fVDdqm2HjNjAX4yOhkXKh70sgq4ZRe+vndU7
         E+XTj44tWFXpz+d71BdAW/Y+8bPNc9v2LhIm39YMIXUGotpmQ82pXHjlzbemvCzgdfH2
         csSlbCSnsS+w0biifVwgu2gvJQ/UUdjRvZMoXgLfbPjTEWUTs+mY2rpMHGQBI+5PbxM8
         hCHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC6AcyLuchSklWWexFo20SBR1fuvo9fFNdE1kU8z11LN5S1QLZ6I/iM+N4oLimooZzAsaFRO3NkA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz6mY4TkQ7YTKzH+7/q1raqSObHVAjRyn6VxKSk50zzpFXy8Lzn
	P3eNc5aUVSvG96E7DbeR0+BYTr8o52kXsNiq4YQyKbTk5fOuCG27v/AppUbHZZUoVpPMEuzjYQH
	imorsRqJoUdilAAqXvzPWJFQ1WR/VfPI=
X-Gm-Gg: AZuq6aLBztOI9NTBB+wlm/aYesS9gn3qXaS7fnsYYwFODAasnfSCdaG2yX0qkadOW0I
	4qopPqnnsnWhNFAOKJKvPFRy0olXs0ZfNNR/pKR5sbYhaIyULvyLm7j879O6wnZhc6EW+J5ooXT
	AgNeDM1sGqkhn/01pFJ5pc9JrW3+40MJwlFS/NMN6vv3QHzhIBkzbOZOla8zaRLe1W/0PcTCUPc
	vltZ3NNX7ENI6UUdocI/tlbxVAwxco8LHKGaF8oiZuDS9drBel7taAdVcHuC55DWyPtfchrIBhn
	kj1rV236Y9xI82P3MgZFG/EWQaEF
X-Received: by 2002:a05:6402:90b:b0:64c:9e19:9858 with SMTP id
 4fb4d7f45d1cf-658de58d61fmr5598076a12.22.1769983301701; Sun, 01 Feb 2026
 14:01:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.1769515122.git.zhengqi.arch@bytedance.com> <3380f40a89b73c488202c85f9a8abf99fb08543b.1769515122.git.zhengqi.arch@bytedance.com>
In-Reply-To: <3380f40a89b73c488202c85f9a8abf99fb08543b.1769515122.git.zhengqi.arch@bytedance.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 1 Feb 2026 23:01:30 +0100
X-Gm-Features: AZwV_Qj9VNkT5OuGD6ka3IvGbnZ780_iMCZkDjCZeudKZ-RrGhxplhYBmunMjcY
Message-ID: <CA+=Fv5RhxvyxKr2t+pHd1tbGrK57P-+b3pGe1nVaK_OLiFt2wg@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] alpha: mm: enable MMU_GATHER_RCU_TABLE_FREE
To: Qi Zheng <qi.zheng@linux.dev>
Cc: david@kernel.org, andreas@gaisler.com, richard.weiyang@gmail.com, 
	will@kernel.org, peterz@infradead.org, aneesh.kumar@kernel.org, 
	npiggin@gmail.com, dev.jain@arm.com, ioworker0@gmail.com, 
	akpm@linux-foundation.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-alpha@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-um@lists.infradead.org, 
	sparclinux@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260201_140144_505651_44FDC6C9 
X-CRM114-Status: GOOD (  15.89  )
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

On Tue, Jan 27, 2026 at 1:16=E2=80=AFPM Qi Zheng <qi.zheng@linux.dev> wrote=
:
>
> From: Qi Zheng <zhengqi.arch@bytedance.com>
>
> On a 64-bit system, madvise(MADV_DONTNEED) may cause a large number of
> empty PTE page table pages (such as 100GB+). To resolve this problem,
> first enable MMU_GATHER_RCU_TABLE_FREE to prepare for enabling the
> PT_RECLAIM feature, which resolves this problem.
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Matt Turner <mattst88@gmail.com>
> ---
>  arch/alpha/Kconfig           | 1 +
>  arch/alpha/include/asm/tlb.h | 6 +++---
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
> index 80367f2cf821c..6c7dbf0adad62 100644
> --- a/arch/alpha/Kconfig
> +++ b/arch/alpha/Kconfig
> @@ -38,6 +38,7 @@ config ALPHA
>         select OLD_SIGSUSPEND
>         select CPU_NO_EFFICIENT_FFS if !ALPHA_EV67
>         select MMU_GATHER_NO_RANGE
> +       select MMU_GATHER_RCU_TABLE_FREE
>         select SPARSEMEM_EXTREME if SPARSEMEM
>         select ZONE_DMA
>         help
> diff --git a/arch/alpha/include/asm/tlb.h b/arch/alpha/include/asm/tlb.h
> index 4f79e331af5ea..ad586b898fd6b 100644
> --- a/arch/alpha/include/asm/tlb.h
> +++ b/arch/alpha/include/asm/tlb.h
> @@ -4,7 +4,7 @@
>
>  #include <asm-generic/tlb.h>
>
> -#define __pte_free_tlb(tlb, pte, address)              pte_free((tlb)->m=
m, pte)
> -#define __pmd_free_tlb(tlb, pmd, address)              pmd_free((tlb)->m=
m, pmd)
> -
> +#define __pte_free_tlb(tlb, pte, address)      tlb_remove_ptdesc((tlb), =
page_ptdesc(pte))
> +#define __pmd_free_tlb(tlb, pmd, address)      tlb_remove_ptdesc((tlb), =
virt_to_ptdesc(pmd))
> +
>  #endif
> --
> 2.20.1
>

Looks good from an Alpha perspective.

Acked-by: Magnus Lindholm <linmag7@gmail.com>

