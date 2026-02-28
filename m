Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB06FEE4CA
	for <linux-um@archiver.kernel.org>; Sat, 28 Feb 2026 06:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X3j0hnt2JP/KFdQ4c7HYEW0UCDX2N/3z8ziNkQTinCU=; b=zuiCi3N3VY7v6ahAOPHNNCCGH/
	0NjcarPn3DRxoNREfiQ6k+OGZBo6fvB+xB10L1NsOQxK7v12bbkkQVSa19EnJSFobm0+rnFhZ3Bb0
	HYOuFrv60b3PvJLQ0EqDWqBaK1PKZ8cDJ2gXahtxmjCRslTsDODEScD2ZUSU1ZdHb2yjKPE40tqfR
	2DQUybgnuyAS9CPBoNyLH75eAEURqkGsCfQ80+WfXm6xmQmyW3sijMwkrdigQISqYyn2VvaWIfh/o
	Ef44Xf0JIkgLJVvtSGnU2WPAcoPrFaKB40m4DAso9N06Ij4h998uB5XXnrhSIcPSFBxNXP63r6XFQ
	MJVHh4/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwEA1-00000009ZQd-0Yte;
	Sat, 28 Feb 2026 06:50:45 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwE9z-00000009ZQN-3yud;
	Sat, 28 Feb 2026 06:50:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3CCA96001D;
	Sat, 28 Feb 2026 06:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F92C116D0;
	Sat, 28 Feb 2026 06:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772261441;
	bh=vPTEPlrxe6ytedqa6Me+M+hZkV+rGO8rrN4LIEvszKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iTFfr8ocKEvs3vXYRewYWPSFe2kL3EkPqlXMH9SFlbuxla7B1++TfbbR29cAr/T69
	 8RlajaFDOInAOiN+ZK7veFCGRmxjx3J7bE/ObG1rUVu/wJzBNzB68455fQxxkndpm2
	 Tm8vLFnkUPRX5ZN0PkWUIEMTd4tfYl/XR8pSy9Z/UPR0Qpq83+piDFPoy0+TgckjTx
	 fIBVNpnimUABvVb4nGDJC3hmwuwMOJKdRSInNWdlSTmxsPRa6fXgS00DoHU0JgsDRW
	 lp50vbyxlZIuxosoVMrxCRj/2aCgMhGTMqw6gfvTpMznmcYFwDNIHqHcgooJXMIogZ
	 UhhsWMu+jeEcw==
Date: Fri, 27 Feb 2026 22:50:38 -0800
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
Subject: Re: [PATCH 21/25] xor: add a better public API
Message-ID: <20260228065038.GH65277@quark>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-22-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226151106.144735-22-hch@lst.de>
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

On Thu, Feb 26, 2026 at 07:10:33AM -0800, Christoph Hellwig wrote:
> xor_blocks is very annoying to use, because it is limited to 4 + 1
> sources / destinations, has an odd argument order and is completely
> undocumented.
> 
> Lift the code that loops around it from btrfs and async_tx/async_xor into
> common code under the name xor_gen and properly document it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/raid/xor.h |  3 +++
>  lib/raid/xor/xor-core.c  | 28 ++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/include/linux/raid/xor.h b/include/linux/raid/xor.h
> index 02bda8d99534..4735a4e960f9 100644
> --- a/include/linux/raid/xor.h
> +++ b/include/linux/raid/xor.h
> @@ -7,4 +7,7 @@
>  extern void xor_blocks(unsigned int count, unsigned int bytes,
>  	void *dest, void **srcs);
>  
> +void xor_gen(void *dest, void **srcss, unsigned int src_cnt,
> +		unsigned int bytes);

srcss => srcs

Ideally the source vectors would be 'const' as well.

> +/**
> + * xor_gen - generate RAID-style XOR information
> + * @dest:	destination vector
> + * @srcs:	source vectors
> + * @src_cnt:	number of source vectors
> + * @bytes:	length in bytes of each vector
> + *
> + * Performs bit-wise XOR operation into @dest for each of the @src_cnt vectors
> + * in @srcs for a length of @bytes bytes.
> + *
> + * Note: for typical RAID uses, @dest either needs to be zeroed, or filled with
> + * the first disk, which then needs to be removed from @srcs.
> + */
> +void xor_gen(void *dest, void **srcs, unsigned int src_cnt, unsigned int bytes)
> +{
> +	unsigned int src_off = 0;
> +
> +	while (src_cnt > 0) {
> +		unsigned int this_cnt = min(src_cnt, MAX_XOR_BLOCKS);
> +
> +		xor_blocks(this_cnt, bytes, dest, srcs + src_off);
> +
> +		src_cnt -= this_cnt;
> +		src_off += this_cnt;
> +	}
> +}
> +EXPORT_SYMBOL(xor_gen);

The alignment requirements on the vectors should be documented, as
should which values of bytes are accepted.  It looks like, at the very
least, the vectors have to be 32-byte aligned and the length has to be a
nonzero multiple of 512 bytes.  But I didn't check every implementation.

Also, the requirement on the calling context (e.g. !is_interrupt())
should be documented as well.

- Eric

