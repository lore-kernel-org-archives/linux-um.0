Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0D4FC6174
	for <linux-um@archiver.kernel.org>; Sat,  3 Jan 2026 05:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=10gk4kIzv5viXrYP6wsblohOaaYzL8Wh9uCfOfLAyTE=; b=QskgYVUwh49Lj3SgxrKfLEfIp5
	JDLApOAdHu6TS8+8rPfAABbaFQbCFqCYzGLQQvhuipBYcWzKiIZW5CW2Xr51fCMM3fvPH/SKoa1On
	JsaReqADbaf+wMuC/roj0uPo2hcSqPIzZ2tQG5uw0nhm3Dxb795o8UnMPFbWDLvUf9QlFdygTXrpl
	xjFjPILJHUEQ2bX940ekHADIbjYEq46e2ngbVmFbQJqBUrq/4mdXg8F34Hn+/lHT51ZfmMuREq0ji
	7QEVNvCaeTJONgX15xZDMM5J4irf5xT6msAVBcu4mn9iP4T5rVMrcuGwpFoB2NAVIQhVHepBFMz8n
	CwSrzUyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbuJc-0000000909E-1AII;
	Sat, 03 Jan 2026 05:36:40 +0000
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbuJW-00000009070-0crw
	for linux-um@lists.infradead.org;
	Sat, 03 Jan 2026 05:36:36 +0000
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-42fb5810d39so8128694f8f.2
        for <linux-um@lists.infradead.org>; Fri, 02 Jan 2026 21:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767418591; x=1768023391; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=10gk4kIzv5viXrYP6wsblohOaaYzL8Wh9uCfOfLAyTE=;
        b=kFKwiFyfwIzgCTWImL6CEHj7kl+MF16YmJcChFDmY2ZJtVwD+M6/MMszL5Q5yWSS1A
         ditRaRoMss92ESpfl9fWsLa8XkA0+yy/QC+l4hUSX2DIuPfSfgAM+QsDzPBFffciTXfU
         aemswB5r8hB7CBGzumhzc+qvoCWln77ic5Kk/AEyTujZca/I6cuArTIY/vSXZpW3hX5b
         U7+dhfp5vIYeTC17bpYnf91WmwIQ8QP9ckJfhfWSgQEHLiBq2p34XdPMFqL2vK8I8d0V
         NU+yr/DmReH3m9cDasQPWAmApwU9w/qZtSgogPIJJCMAbMzKJTNe0fZw2dUSyIAqphTl
         ts2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767418591; x=1768023391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10gk4kIzv5viXrYP6wsblohOaaYzL8Wh9uCfOfLAyTE=;
        b=LuDhypCZ3kdUHz3aAKt7e5JBrPn/j/X+YPl4/wc0UuwLuNtQ3ncc/7vMnVadC+pxhn
         87M08x3JTbRZgi0J1gftFPXkyn/2/BeKcR0Nk76RiTokrawxzVxX2W9zUp2e/D4pSxpN
         xq1D4gXGY8QoqYtuf7YUZ/9QbGSjygbCTjHjl+NCyj3TpaIUeC2CeboyH0hYaexKAYk5
         f5Q7gTGtEim3g4Jt1kHM6DtNkh4xkUPV+u4p2V1bX38REZd9yY1iQtck32eey0ZUPMFy
         IiFx1ryg9djNfGSXFEU1JCqnDttBs8a+jOdPOFVWVo1YUWOTejWgJI8rS9yWAddRmlcF
         79xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOKjS81eR8J8en2h2IF18gmx7dAvRGE6KhabZQKZ+KMAuGdOq0Mp97kOqUaqDX5vSdNGA2JHvSHA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxd64ALGPIZujhswSpO8QIYPe3suqiombIIkgwat8GzIqSl1aMk
	2c02NUytCBMqpS+m2BVu7O+OJhA3EHggH9kk8YEx5I9HFDwQPpoVmi06
X-Gm-Gg: AY/fxX4aKRVIn5xy/hPZKMe6XW1NuzWBJJk7xeqWPekmDwas8v/3g5BlkRtIXnOBb4O
	pb3W2yWKbl8tGTsiDJWygE2OcXWs6TvW0UZTJpJ8+ENCYLfxe2et+FPnN5Tu5gFx4NGJXFg+dC0
	rz9AI11vZ4LytaBEdmUgSt6d1pkBa/zCXteSeMf2vXgXVEuLd/HJXkgWfRSjbteDQYfALbYfbVl
	0jDyxK4W1mcdS12aXuSeIqHUSFiYFrCq9Y8gB19VFpVan1WjnmHpFPRApM8XylG9llk1p1187lN
	SWKhSYcR4IBGrg9ozH4lZIG+syQySxFZiJgC+8KczRNsff0Au9A1+4hd0nL0Wsuje8s8krTWzN2
	WJ87rmifQwYbzG7x24oWYxGd2PFOVsWAtnJh6pmXui5Xn/bks1x+gMIO20hoJBPiES6JeDnsUtG
	kmdLZas3JPlUDPupM8Nm9qHpo25ELkVnq7zPcqnTmoU+kikMoAp1IO9THtTGIhzlCw
X-Google-Smtp-Source: AGHT+IGVfFhDmvRzquITceR9a5MtoKyW2aPxvUx0HbCgVxiLGpVVcSZGOqzt3JsoKLBzXfIUaXLywg==
X-Received: by 2002:a05:6000:178f:b0:430:fd84:317a with SMTP id ffacd0b85a97d-4324e4fb825mr53362620f8f.38.1767418590643;
        Fri, 02 Jan 2026 21:36:30 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa4749sm89007161f8f.37.2026.01.02.21.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 21:36:28 -0800 (PST)
Date: Sat, 3 Jan 2026 05:36:26 +0000
From: Stafford Horne <shorne@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alex Shi <alexs@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Jonathan Corbet <corbet@lwn.net>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
	x86@kernel.org, linux-alpha@vger.kernel.org,
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
Subject: Re: [PATCH v2 12/28] openrisc: introduce arch_zone_limits_init()
Message-ID: <aViq2vsMk5tltK0f@antec>
References: <20260102070005.65328-1-rppt@kernel.org>
 <20260102070005.65328-13-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102070005.65328-13-rppt@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260102_213634_208499_B74F4DEF 
X-CRM114-Status: GOOD (  20.45  )
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

On Fri, Jan 02, 2026 at 08:59:48AM +0200, Mike Rapoport wrote:
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
>  arch/openrisc/mm/init.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
> index 9382d9a0ec78..67de93e7a685 100644
> --- a/arch/openrisc/mm/init.c
> +++ b/arch/openrisc/mm/init.c
> @@ -39,15 +39,19 @@
>  
>  int mem_init_done;
>  
> -static void __init zone_sizes_init(void)
> +void __init arch_zone_limits_init(unsigned long *max_zone_pfns)
>  {
> -	unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
> -
>  	/*
>  	 * We use only ZONE_NORMAL
>  	 */
> -	max_zone_pfn[ZONE_NORMAL] = max_low_pfn;
> +	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
> +}
> +
> +static void __init zone_sizes_init(void)
> +{
> +	unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
>  
> +	arch_zone_limits_init(max_zone_pfn);
>  	free_area_init(max_zone_pfn);
>  }

Thanks, this looks like a good cleanup.


Acked-by: Stafford Horne <shorne@gmail.com>

