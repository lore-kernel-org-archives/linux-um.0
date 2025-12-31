Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9498EE6458
	for <linux-um@archiver.kernel.org>; Wed, 31 Dec 2025 15:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H6r7yw9l553CBnZ0Oq6/Kvj3e3aIbXAlTRdm8Qc8sow=; b=mW/ZSKsYQ3FSiNFrafd5y9LB9C
	I8v1CS+kyqxb7hbVW4JEFgInkQ5N7cVD6rYTYIPwa59tKvFAC7vaL5sWftJIS77Af6qeLQxP4a/tk
	qhPc3UrFHFoJ7ftExk1o02K2cs1NcdJjGexQWnkrGbjkAH4+waYo9FZjELweCVErCG60JtZiflGmf
	EECRb5iwCZ4IWt5dios6nRpzIvU2KO6TOeJSYLBU+77t6L1OMec17h2Ss1hVlhXL4tLGxbceWO894
	RHI0pCcft07QGF2VFzwjVaNL5D9iPCdADLnm07W7DwKt8YccoFq7tAPy0JyA63fLhEu70BHXJ72IT
	baIGDktQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vaySJ-000000066O7-2WQ6;
	Wed, 31 Dec 2025 15:49:47 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vaySH-000000066Ml-3Rw1
	for linux-um@lists.infradead.org;
	Wed, 31 Dec 2025 15:49:46 +0000
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-64b9d01e473so15471426a12.2
        for <linux-um@lists.infradead.org>; Wed, 31 Dec 2025 07:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767196183; x=1767800983; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6r7yw9l553CBnZ0Oq6/Kvj3e3aIbXAlTRdm8Qc8sow=;
        b=QGFJM+5zzECLce/Ez4Hm9KA6Yf2GspnQLdjfiLnUsbTeaLIkdBKnz9eKXeAd01+4TB
         Rsl1Eg/dsnn+mN4bsUM0JR01/PqQDE/Zp8RhK9RpWiwT+ANY5tEVk4JNUDMU3oHuEvQ0
         dswALg0SwD518q5oPBa/UZJvodrqsY0GkjBGn5zxaQcaJYF/JEiqLEVXhBh8flXBd+/X
         WQYb+g0r50BvbK2zGN0pIEwE7tqemOTo9DqrxSo+A0PtVHLiHQIX+ezWSCoAml7dzPAR
         01jQrZB+6wHQsKClgyurzc3qcBZO0TQG9ky3ao6g3rHvsKzIhRX0QSPClWpndQgJ4BpD
         AO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767196183; x=1767800983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H6r7yw9l553CBnZ0Oq6/Kvj3e3aIbXAlTRdm8Qc8sow=;
        b=NZklyo04yPq0dMqZbn+VP+b/s6/g2bju/cCS05TdE+/v9jgZ/i+5e9UCYJESGXI5jq
         S/IePY9xdZJhquVDOS0VO7zv2wKHLPbIlvU1a4FV90nWhW+REQJV7X15HrEEHC4HFnrR
         bUQwxXQsyQWwIVIjTbtCy1uMJtOKvsV8XxCW4SNmvjFQvkp4nKqyDbvdR6sSRz6eO83p
         l8Ha5IS0K3nInAoRYHwdOME4rEG5Ys6SISZf3ieJTkg0xTU/m7Y+iz3kwxCRv4DQaJFu
         s9wfBnDSmyoqA9yqkw0Ke0PqK1/tgFven172NV0p+qyZZMGuFsJRqOKSbnAjfrJtMPBe
         ui2g==
X-Forwarded-Encrypted: i=1; AJvYcCV7pxKsttZKVAxsBA3eV/Rhg78mk4EiLyIttC2mQDs0ZXTBltp4qLp+wxYgGAyY70BuCkVZ4583mA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwW2U8MT9BxTp3qxzEOwOHRTbuqplDsPdx/pDRpiXHlCkXXRky+
	TYm7kKVcZXtnZpi+0x35OhDHeH2PGt1SHgD5vd0aZVzk9tQPjKviPD8cx4278mNmxYKWgHQd/WQ
	RQHIdYYKikrc9NJtvN8jXkMMwHOfN4oQ=
X-Gm-Gg: AY/fxX4P5OrKNgjowePLIM5xrfdScctjKD4FpCQZPB9fb3CrT7W8ZafqivmtBB+1Qpi
	LsZzi2mzQuxgZFpFXf+NhAbj2+JxUhtKAaz4kEVU+tgfsWRnCnQjQonucKLnc6YPKtmnrKoheGB
	opOtgGag3U1rl5uGWZM6dA8qXC/aXvVvqYRX3KqxTOXw7hJ1klXduLIj2oqSTf6EX4TLZeemVFI
	mZQ+USTAXyQPvoZ3vbP/avijCG2Dyx7d42Xl8AGD4MtziUkdqiosGplhhyixCK3my3Rpw8m
X-Google-Smtp-Source: AGHT+IFWPXcZKnGq0Krk9SV9S7c2h0pNtpTmEWv1Brc1vDiv5zIRm5JUQPWxix5qBNEZM9fT8eFcchz/mGnlgfTZ7QQ=
X-Received: by 2002:a05:6402:430d:b0:64d:170:7976 with SMTP id
 4fb4d7f45d1cf-64d01707bacmr33060451a12.16.1767196183052; Wed, 31 Dec 2025
 07:49:43 -0800 (PST)
MIME-Version: 1.0
References: <20251228124001.3624742-1-rppt@kernel.org> <20251228124001.3624742-2-rppt@kernel.org>
In-Reply-To: <20251228124001.3624742-2-rppt@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 31 Dec 2025 16:49:31 +0100
X-Gm-Features: AQt7F2rayRHt2K_8t_heYN2h4Fxse0t-QPEGBzoKWlAlrWu2fr6sWsAyLE9oYEU
Message-ID: <CA+=Fv5TDfwnu7Qf2y=PLWWN1EvNpNbr8habnTO7R4_caAySDzw@mail.gmail.com>
Subject: Re: [PATCH 01/28] alpha: introduce arch_zone_limits_init()
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alex Shi <alexs@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Andreas Larsson <andreas@gaisler.com>, 
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	"David S. Miller" <davem@davemloft.net>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Hildenbrand <david@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Jonathan Corbet <corbet@lwn.net>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, 
	Stafford Horne <shorne@gmail.com>, Suren Baghdasaryan <surenb@google.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Will Deacon <will@kernel.org>, x86@kernel.org, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-mm@kvack.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
	sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251231_074945_894425_4CD129FE 
X-CRM114-Status: GOOD (  19.85  )
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

On Sun, Dec 28, 2025 at 1:40=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Move calculations of zone limits to a dedicated arch_zone_limits_init()
> function.
>
> Later MM core will use this function as an architecture specific callback
> during nodes and zones initialization and thus there won't be a need to
> call free_area_init() from every architecture.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/alpha/mm/init.c | 15 ++++++++++-----
>  include/linux/mm.h   |  1 +
>  2 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/arch/alpha/mm/init.c b/arch/alpha/mm/init.c
> index 4c5ab9cd8a0a..cd0cb1abde5f 100644
> --- a/arch/alpha/mm/init.c
> +++ b/arch/alpha/mm/init.c
> @@ -208,12 +208,8 @@ callback_init(void * kernel_end)
>         return kernel_end;
>  }
>
> -/*
> - * paging_init() sets up the memory map.
> - */
> -void __init paging_init(void)
> +void __init arch_zone_limits_init(unsigned long *max_zone_pfn)
>  {
> -       unsigned long max_zone_pfn[MAX_NR_ZONES] =3D {0, };
>         unsigned long dma_pfn;
>
>         dma_pfn =3D virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
> @@ -221,8 +217,17 @@ void __init paging_init(void)
>
>         max_zone_pfn[ZONE_DMA] =3D dma_pfn;
>         max_zone_pfn[ZONE_NORMAL] =3D max_pfn;
> +}
> +
> +/*
> + * paging_init() sets up the memory map.
> + */
> +void __init paging_init(void)
> +{
> +       unsigned long max_zone_pfn[MAX_NR_ZONES] =3D {0, };
>
>         /* Initialize mem_map[].  */
> +       arch_zone_limits_init(max_zone_pfn);
>         free_area_init(max_zone_pfn);
>
>         /* Initialize the kernel's ZERO_PGE. */
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 15076261d0c2..628c0e0ac313 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3552,6 +3552,7 @@ static inline unsigned long get_num_physpages(void)
>   * free_area_init(max_zone_pfns);
>   */
>  void free_area_init(unsigned long *max_zone_pfn);
> +void arch_zone_limits_init(unsigned long *max_zone_pfn);
>  unsigned long node_map_pfn_alignment(void);
>  extern unsigned long absent_pages_in_range(unsigned long start_pfn,
>                                                 unsigned long end_pfn);
> --
> 2.51.0
>

This looks fine to me from the Alpha side.

Acked-by: Magnus Lindholm <linmag7@gmail.com>

