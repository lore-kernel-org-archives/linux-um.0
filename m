Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D221E92725
	for <linux-um@archiver.kernel.org>; Mon, 29 Dec 2025 01:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W+mdphFdhHyow6rAPBZM50HCMYbmaBeO4dGerIc0iH4=; b=snPUmaU+EAwGfkpeRBBYwUv+yn
	quzTrX5XVhgRU56012OHOFSTG7m0ZIcLn9R33lJfwptOv57Dl3iQwnCsumhk5NdP3mgmeXURp4JQc
	9CQVdiO7oH5ZilDEVXzHDI567jJae0tq2pk70q7gFpBV+VjAmuLx9hzPiJs2z3vFiybW++5mAo6h4
	G2x3afeBtcXm0IrgTEEyWWRlpL8icebnaZIKIlG+2Y/pBSA60GL4PxmrpKthsNZmoszeMuoKr9Gxk
	99qyItI2WbgbzSy1LuRu1ePFLD0+GhkR8GZnvbkLv1ause3geUwpW+a4zaSWp40zhwtMSgIDUpDOp
	tfEcNNhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1va21I-00000003BoF-1Abn;
	Mon, 29 Dec 2025 01:26:00 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1va21G-00000003Bml-1Ute
	for linux-um@lists.infradead.org;
	Mon, 29 Dec 2025 01:25:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E913C4448C
	for <linux-um@lists.infradead.org>; Mon, 29 Dec 2025 01:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD665C2BCAF
	for <linux-um@lists.infradead.org>; Mon, 29 Dec 2025 01:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766971556;
	bh=QcHUIuYE7RQs56jGjmqpy2oUOjx983YRYnPBuaD4boU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JRFWKJxzPMVQR44/fR5nIIhozZE+LgKUESPHybZ8wZno197JiHenXGKVJkNpSqguw
	 2xLe+veDDWm8kNDY+BiuQ6SvvVwq4Hpcc3W1hwbZp+jfRAR1nDJPVP4EK59344ImkK
	 wlsii6F/eZYefoyYAw2fXzJjRbRH+kzlnYLQAY1eO5Ubr8qm60ldJqs+pPD1ZsFSsg
	 NrY0alhp0ugdEFKLyzrY3OxKA1u0ctAhx1QBGvs/z6tbv8fsSbtYftMz3kEpB6/lKF
	 BZtMwOxmk5Eoyviyb7mYDSTLqm3LFsfpO0X0ux1I+BeIUazvoB3riY6Caw19+VvfnP
	 zpfyrSVDOV9qA==
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42fbc305552so6952048f8f.0
        for <linux-um@lists.infradead.org>; Sun, 28 Dec 2025 17:25:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUWADwkSAqHuHR4mHs+zlGOZLakbhjdGCpG1ZEIZ3u4sQy0Lc+aKVCeaqMMXb7BNcmKDIqwPcE5sA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwKXlyoEA/q/DBqjQNAMh2GOYy5wRs/bkSPZaDMWiV+ZOC294Ar
	+nsoNslpQQZTgXR6HJa5v0wenZFGHfg1mTvylQFKomOh4uF5igt5rtF8XC9Zac94fPQG39e1jKo
	QTwtRcPIsOPj2obM5Se5080XGPgDQhUo=
X-Google-Smtp-Source: AGHT+IH0/4lM/7b5Nef4Fb6rn6mJpOxGdWgk9AqK9LZQSl+6Va320QICtWgPPv8KCBU6m5HaJgurTChUGp2fBhZ8S4E=
X-Received: by 2002:a05:6000:2308:b0:430:ff0c:35f9 with SMTP id
 ffacd0b85a97d-4324e50d989mr31524498f8f.48.1766971554637; Sun, 28 Dec 2025
 17:25:54 -0800 (PST)
MIME-Version: 1.0
References: <20251228124001.3624742-1-rppt@kernel.org> <20251228124001.3624742-6-rppt@kernel.org>
In-Reply-To: <20251228124001.3624742-6-rppt@kernel.org>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 29 Dec 2025 09:25:42 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSMLhnqQeZB=oEwLGzXfJwxPh+vJvTuz-OFGrwJi5uPSA@mail.gmail.com>
X-Gm-Features: AQt7F2ovPXIqQiKDAgz2Iigjc3UdRKj7ty_Tsln8fN_MKzmJJ5LWRy6ejtLdRVA
Message-ID: <CAJF2gTSMLhnqQeZB=oEwLGzXfJwxPh+vJvTuz-OFGrwJi5uPSA@mail.gmail.com>
Subject: Re: [PATCH 05/28] csky: introduce arch_zone_limits_init()
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alex Shi <alexs@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Andreas Larsson <andreas@gaisler.com>, 
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	"David S. Miller" <davem@davemloft.net>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Hildenbrand <david@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, 
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Jonathan Corbet <corbet@lwn.net>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>, 
	Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, 
	Michal Simek <monstr@monstr.eu>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Richard Weinberger <richard@nod.at>, 
	Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>, x86@kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251228_172558_444153_26FCE7D4 
X-CRM114-Status: GOOD (  17.98  )
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

On Sun, Dec 28, 2025 at 8:41=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
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
>  arch/csky/kernel/setup.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/arch/csky/kernel/setup.c b/arch/csky/kernel/setup.c
> index e0d6ca86ea8c..8968815d93e6 100644
> --- a/arch/csky/kernel/setup.c
> +++ b/arch/csky/kernel/setup.c
> @@ -51,6 +51,14 @@ static void __init setup_initrd(void)
>  }
>  #endif
>
> +void __init arch_zone_limits_init(unsigned long *max_zone_pfns)
> +{
> +       max_zone_pfns[ZONE_NORMAL] =3D max_low_pfn;
> +#ifdef CONFIG_HIGHMEM
> +       max_zone_pfns[ZONE_HIGHMEM] =3D max_pfn;
> +#endif
> +}
> +
LGTM!

Acked-by: Guo Ren <guoren@kernel.org>

>  static void __init csky_memblock_init(void)
>  {
>         unsigned long lowmem_size =3D PFN_DOWN(LOWMEM_LIMIT - PHYS_OFFSET=
_OFFSET);
> @@ -83,12 +91,9 @@ static void __init csky_memblock_init(void)
>         setup_initrd();
>  #endif
>
> -       max_zone_pfn[ZONE_NORMAL] =3D max_low_pfn;
> -
>         mmu_init(min_low_pfn, max_low_pfn);
>
>  #ifdef CONFIG_HIGHMEM
> -       max_zone_pfn[ZONE_HIGHMEM] =3D max_pfn;
>
>         highstart_pfn =3D max_low_pfn;
>         highend_pfn   =3D max_pfn;
> @@ -97,6 +102,7 @@ static void __init csky_memblock_init(void)
>
>         dma_contiguous_reserve(0);
>
> +       arch_zone_limits_init(max_zone_pfn);
>         free_area_init(max_zone_pfn);
>  }
>
> --
> 2.51.0
>


--=20
Best Regards
 Guo Ren

