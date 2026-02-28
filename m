Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D18FEE4C5
	for <linux-um@archiver.kernel.org>; Sat, 28 Feb 2026 04:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hTTnDcnDoYmcoNie9tHbMTIizvVqtd87Tnc3PFg/feQ=; b=ncxTZfn+J+72EkBFbZYI1B2Ka1
	CdnyRzkEajZ73YVH9U7HbpF+mxGPVr3hPy9EK8nynPIZeaofMTvCo0XEZnZDnqYEGmceRwmv4X9Or
	M8ZmjYK7MUDHwRX2pHHpw4c1A/HJ0lHdYDHnHXlvq0qRjAtS2m3qUKSHrvugoda8PWBE1OdmLcUhw
	SuagphL63mlsmQAd5xfqeg54ccUDkzNUdwjgC7y3ZVRJczPn5WJfgLmoML5BWrOjdj5Cg4YgrP9iX
	bRAvR2oNQh1xeSiRlO+V+vwVH+hzmx0D/XMRgRyuLbSKohLU70NvOhaWVgVQQe78Oei0VBQn7pQ5+
	Z7QmsMrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwCBN-00000009Uox-3Xtu;
	Sat, 28 Feb 2026 04:44:01 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwCBL-00000009Unn-34wK;
	Sat, 28 Feb 2026 04:44:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AF29C438ED;
	Sat, 28 Feb 2026 04:43:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B7EC116D0;
	Sat, 28 Feb 2026 04:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772253838;
	bh=yQS8EYr1F4rANaBe7v+3inxmWJU0zVKQEOlUsxymw4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PuoEPD5dGKM2iOhSW+0my0D/f4VLvinBi2jt5Kbxbd81P1k+jWi0+KVciBAPrpL/g
	 r4r2NT2v38o9qtnIhfBxVgmjQSQJywLVObj3muDNlyHJqSESQCTZhmJe/6Rzsk2R9M
	 8ZnzLPFYGLtie7deDR1V8Pnkzre6yCwdaC1qBSQ9wNIL1XaAUgCSzSUwN7lW5l11mD
	 VW2gjQBqijiFVLqfxqw/TTKXHQthqIgVue3hQeJ64rdHrmcizqorwLbqqoBbwNSZH4
	 QorQ2T+BBBGPZMVwQBEeX4nOyWDWoKOqpyMPTJ5mdi+JknVW5oDrCxr9Qb4qEoWrJm
	 UhY0/KMibUBXA==
Date: Fri, 27 Feb 2026 20:43:55 -0800
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
Subject: Re: [PATCH 07/25] xor: split xor.h
Message-ID: <20260228044355.GD65277@quark>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226151106.144735-8-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_204359_796975_5BA8CD5E 
X-CRM114-Status: GOOD (  13.62  )
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

On Thu, Feb 26, 2026 at 07:10:19AM -0800, Christoph Hellwig wrote:
> Keep xor.h for the public API, and split the struct xor_block_template
> definition that is only needed by the xor.ko core and
> architecture-specific optimizations into a separate xor_impl.h header.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm/lib/xor-neon.c       |  1 +
>  arch/s390/lib/xor.c           |  2 +-
>  include/linux/raid/xor.h      | 22 +---------------------
>  include/linux/raid/xor_impl.h | 25 +++++++++++++++++++++++++
>  lib/raid/xor/xor-core.c       |  1 +
>  5 files changed, 29 insertions(+), 22 deletions(-)
>  create mode 100644 include/linux/raid/xor_impl.h

arch/arm64/lib/xor-neon.c needs to be updated to include xor_impl.h.

- Eric

