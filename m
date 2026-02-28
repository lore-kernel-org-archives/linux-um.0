Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE857FEE4C6
	for <linux-um@archiver.kernel.org>; Sat, 28 Feb 2026 05:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pPKu8pyhkInpX09bIAbmlPH+OLoaLy8SUm0nQHgk8LI=; b=MivcV/g1P4+6/lWd+/+ncEPLCC
	zg5S3CALGNxITkQRxj47HSZLLrmYSpeFecG6tDjruQj8gHOTJrd7/DRwMQGofnEPRlldLeiImBYaB
	/P5pHEEZmfTkBcAdVsWYpTmrg/0A+Fue36Rgb6AtH4y+cIzYCyikEU4YfYgyWaBU82cadttc4C6K7
	1iPL5htcGjjJni8AiQFkFKRp9eaojWUqTQq+vgXJgfd4GBA7vaxStEgTTgVT0XpBHYRpxWRNCADNh
	Fkua6vudA4mCCAySWt1btGKyqyVet2Vq52NAGkIwmTvO6wwJ6GcEKeEdag8vkPaiFkU3E5tk9Nj5u
	u3IBoboA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwD1H-00000009WO5-3bWz;
	Sat, 28 Feb 2026 05:37:39 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwD1E-00000009WNZ-26y7;
	Sat, 28 Feb 2026 05:37:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 555454064C;
	Sat, 28 Feb 2026 05:37:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE76EC116D0;
	Sat, 28 Feb 2026 05:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772257055;
	bh=eqLNM+it9jPNWRs+scO49PSKMIRVyGiqn9NcqSlCp7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vJAxXZ8Kz5WRI3FAqQiiWltyd3uQ9vRfiXCgBQwT4V+lApPXGfBKpNyhyElFSuB3u
	 XB4VENMAfKNQt4jt5mepYgezGyP/JFcan/V5g78ruKQj4Ji3BOedSoLRvaGOzY6b7q
	 Mc5XWWLUQF0PcVSlTTmo7S7Zck6GQKRu3zWFaP+B5XItpiitYzcZpUfca6qi8XUfOd
	 6vh1cIQZcaLVpiV5n3ZguAWWWmPlxPcj2Nj9plSsomBCSSLqZZekWhAfjQ2YeYW7iu
	 rDzWS5l+PL0z3I+4kxGk4sYmPecb+wzM6vyPcl7Y9d2Uxa1CYls2Am5BPUZnt/qH5z
	 mB77YqO/RTn8A==
Date: Fri, 27 Feb 2026 21:37:30 -0800
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
Subject: Re: [PATCH 15/25] riscv: move the XOR code to lib/raid/
Message-ID: <20260228053730.GE65277@quark>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-16-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226151106.144735-16-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_213736_573619_A975CDCD 
X-CRM114-Status: GOOD (  12.54  )
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

On Thu, Feb 26, 2026 at 07:10:27AM -0800, Christoph Hellwig wrote:
> Move the optimized XOR into lib/raid and include it it in xor.ko
> instead of always building it into the main kernel image.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/include/asm/xor.h                 | 54 +------------------
>  arch/riscv/lib/Makefile                      |  1 -
>  lib/raid/xor/Makefile                        |  1 +
>  lib/raid/xor/riscv/xor-glue.c                | 56 ++++++++++++++++++++
>  {arch/riscv/lib => lib/raid/xor/riscv}/xor.S |  0

The EXPORT_SYMBOL() statements in xor.S can be removed, since the
functions are now located in the same module as their callers.

- Eric

