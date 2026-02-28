Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5CADFEE4C3
	for <linux-um@archiver.kernel.org>; Sat, 28 Feb 2026 04:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HxHllU4ceXSYzkZVN7jXp5kDkLsJe3gAM2lgZ6PCW3Q=; b=O+QC9pEaNvlrHzL2gy8n08D7vu
	F161vTG+tR/uxragszHiivuswbpEGJa6e0M4jwiQx+UIMWvRjbWfC428LjG0/2briIIj23lAzXv4S
	+F9jnNPPjOm/WhYeZRSkZo25v7iqAoqBBXwBAyMvYueP47f4NEfsZp3Z7E+np5kIsDLmLKhdMqWv0
	mAhsLUp86NSn3JMZC8u4khAh8Jrl8JvGjI0mqXkRFLgEfr0WREs56pMtTXjn8qViTLlAXyDWtOhoW
	0qcZdnmqhM/nsdtNRuvrp/R6Nz82oelROd+mdjki+bM5Dm4CQMfLYML5dTBbQMTWsGc/olImHQlij
	HlwoP4Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwByN-00000009U3u-3vYj;
	Sat, 28 Feb 2026 04:30:35 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwBy5-00000009U3A-12Td;
	Sat, 28 Feb 2026 04:30:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3A6BB4388D;
	Sat, 28 Feb 2026 04:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198B3C116D0;
	Sat, 28 Feb 2026 04:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772253010;
	bh=NxIyVYtgLysk+spkHOyEoka9HT1s3BaoNbqWwqQmPXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fyh0YCjcPmsVmzz5h+F1Yy8gWejjphUUrGeKnqhIxGQ+qjYtEztmeP1kaQL7ddsRN
	 jdkA6zr3qARSLzOxvszanCJtbGe6MxgPdM+Z6+dhb7aZQXTNmMRzbGAktPG2fY5fUl
	 TBJYgxI6xb9qhwF67ngcAYU9OKtc/uqzcX+3yEYAKMVGlX0rGBTQLNzUCfh3Qw8tog
	 0VEAgqbQJ3xpTSjCyP3w5YgI628hkJaD1By1DZb0TabsJZRA6BOO4+elbK3T8jYutF
	 xqGj5SaKcx64Foh0YOFWYjXkw2x5ciOjaB0TEjg5I3513gVMPITkGZ7CF1NbrQ8JTi
	 72nJ1I+TSmVTQ==
Date: Fri, 27 Feb 2026 20:30:06 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
	Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>,
	Li Nan <linan122@huawei.com>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [PATCH 03/25] um/xor: don't override XOR_SELECT_TEMPLATE
Message-ID: <20260228043006.GA65277@quark>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226151106.144735-4-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_203017_369682_D82C1B09 
X-CRM114-Status: GOOD (  18.22  )
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

On Thu, Feb 26, 2026 at 07:10:15AM -0800, Christoph Hellwig wrote:
> XOR_SELECT_TEMPLATE is only ever called with a NULL argument, so all the
> ifdef'ery doesn't do anything.  With our without this, the time travel
> mode should work fine on CPUs that support AVX2, as the AVX2
> implementation is forced in this case, and won't work otherwise.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/um/include/asm/xor.h | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/arch/um/include/asm/xor.h b/arch/um/include/asm/xor.h
> index 647fae200c5d..c9ddedc19301 100644
> --- a/arch/um/include/asm/xor.h
> +++ b/arch/um/include/asm/xor.h
> @@ -4,21 +4,11 @@
>  
>  #ifdef CONFIG_64BIT
>  #undef CONFIG_X86_32
> -#define TT_CPU_INF_XOR_DEFAULT (AVX_SELECT(&xor_block_sse_pf64))
>  #else
>  #define CONFIG_X86_32 1
> -#define TT_CPU_INF_XOR_DEFAULT (AVX_SELECT(&xor_block_8regs))
>  #endif
>  
>  #include <asm/cpufeature.h>
>  #include <../../x86/include/asm/xor.h>
> -#include <linux/time-internal.h>
> -
> -#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
> -#undef XOR_SELECT_TEMPLATE
> -/* pick an arbitrary one - measuring isn't possible with inf-cpu */
> -#define XOR_SELECT_TEMPLATE(x)	\
> -	(time_travel_mode == TT_MODE_INFCPU ? TT_CPU_INF_XOR_DEFAULT : x)
> -#endif

I'm not following this change.  Previously, in TT_MODE_INFCPU mode,
XOR_SELECT_TEMPLATE(NULL) returned &xor_block_avx, &xor_block_sse_pf64,
or &xor_block_8regs, causing the benchmark to be skipped.  After this
change, the benchmark starts being done on CPUs that don't support AVX.

- Eric

