Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A352FEE4CE
	for <linux-um@archiver.kernel.org>; Sat, 28 Feb 2026 07:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3y/IqGod0OtoNjM34bJe5aCjje6al8v83ndNN1uCr6A=; b=kYqGD0ex4kuXMjrwh/Yi8dqoC3
	0lXDPd/0Y0ulgNkMt1apylF8CLjs5izfL/T0NgtuDk/2++v52guwRc1g9tQ18Iev84Bika0xq1vjn
	Xh+IVPjwMCVOE5MAj5XC7gn1sFpTtvPOq3GR3pBBtqSJWPx1q4pwXjqaoSRDiP8akn7u0o1ZbwLBL
	wDYw3sj9e0L7MHPq6MEbagzcFZjsJ4+CtRiyiR7ezrusxnj1CVQEA0LbEe2RbcHGXcDpR9tGlNU7r
	lXWqD3eBYM9nL5arEgTb4kEMreuo89EhIibUKESsgSTt0tBB6DFX967CHnYTRc215M6YLng0DH2p4
	MoqJpZ0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwEXy-00000009b35-2Dqw;
	Sat, 28 Feb 2026 07:15:30 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwEXv-00000009b2o-2CYB;
	Sat, 28 Feb 2026 07:15:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B403E6001D;
	Sat, 28 Feb 2026 07:15:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39044C116D0;
	Sat, 28 Feb 2026 07:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772262925;
	bh=zWqt8Joca1KvplCXgcwLYttswt0fM6g1E9UxDDRiVTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vz3k8kyTWZXHMK5zn7xXibfO3tQ+c+PplCLKYAb/nEXG6XVyxylOPTDzXmct2v/wF
	 WmaMWfVwV7ygt8481V3ntzFPARMBXxozM0S4vYM+fu8NTjVMCeXuO/SMU92oOtftWp
	 YviS01hMbTL4Nkd5vseytV1ImcKk3TWqfzHY4gUzr3YvSM+tsz1IZkLgKG1gW+KaxO
	 rZfmvPr+C7N697Fz2WWHkMDqBLHLN/FfRu//s+ea1lU/Ju8ebw+5Si06It93glm1Ff
	 QePblciurUn+VamkBgtZHIFv4AD004DBjvXkKZVZLJlMvZ9IVJkH2jsgcBMJr2hP7p
	 3dV2gvb5/dQtw==
Date: Fri, 27 Feb 2026 23:15:21 -0800
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
Subject: Re: [PATCH 09/25] xor: move generic implementations out of
 asm-generic/xor.h
Message-ID: <20260228071521.GK65277@quark>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226151106.144735-10-hch@lst.de>
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

On Thu, Feb 26, 2026 at 07:10:21AM -0800, Christoph Hellwig wrote:
> Move the generic implementations from asm-generic/xor.h to
> per-implementaion .c files in lib/raid.
> 
> Note that this would cause the second xor_block_8regs instance created by
> arch/arm/lib/xor-neon.c to be generated instead of discarded as dead
> code, so add a NO_TEMPLATE symbol to disable it for this case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This makes the generic code always be included in xor.ko, even when the
architecture doesn't need it.  For example, x86_64 doesn't need it,
since it always selects either the AVX or SSE code.

Have you considered putting the generic code in xor-core.c (or in
headers included by it) before xor_arch.h is included, and putting
__maybe_unused on the xor_block_template structs?  Then they'll still be
available for arch_xor_init() to use, but any of them that aren't used
in a particular build will be optimized out as dead code by the
compiler.

lib/crc/ and lib/crypto/ take a similar approach for most algorithms.

- Eric

