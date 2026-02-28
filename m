Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D3BFEE4CC
	for <linux-um@archiver.kernel.org>; Sat, 28 Feb 2026 06:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NgDGtsqBhUQwL9XsdeBt/A2oCAsnHmbkb4D0bvRZojQ=; b=p+xU26XN8Jr/GuSYQzXyC+WEf4
	nzmJ9WmOXaA8N/QTYMQ+GhFY074kzgEIAmtdrcZJhzUN716fDYmTOiKh58Ac6YYB/WJ+pumiWrlAT
	cL8fXx7nXgG0L/S4pAz1eHxzr9xC/olyB6LZN9uNuYp4S0PrnTeUYkZImFUMdMHjhSGrF0oV5P3SK
	Zdbj7MuT7REb6VtCqycHlGkxoYjaPNJ0ikNUrVKsPb/qJYNXHCiebABdb88fnc1kCdhSlDqCGjR4/
	fhzxry4UbRBPJWnua5GJRc+QsCJ/YzWN1fLM9c2HsxCHIR9Z/PeafDEcApf9XqCA8s50zxfS48hor
	u1bjrY+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwEHM-00000009Zqp-0dPn;
	Sat, 28 Feb 2026 06:58:20 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwEHH-00000009Zpl-3IPd;
	Sat, 28 Feb 2026 06:58:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0EEED40229;
	Sat, 28 Feb 2026 06:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B51C116D0;
	Sat, 28 Feb 2026 06:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772261893;
	bh=OZ08akKAa75pF5HX8BdM2b9T1B4d2lEE9VTD0Yyikqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WZJvSmvpEC6sHP/zivxpALj3tLGejpdvAPR0eMYRI+scB+s1IF4OeEtX5WKMQOtse
	 Y2O4u4bOc8GI/JkEy6r4u1efjOMWWhLBmlfPczD6cmniYI2bymYIkCjhEhIGubJ4gY
	 U9xKn5Z26jVbpiN+tbnYvysYm7bGRQ8U3XJJKW5Mpnhlp7/c6eic5HbKU4NYZzTh4Y
	 eWJy6kT6Z+zFjYDjttC40gAqyP1FxjjNb1CXpDAIZpiSYLp4Vl3s7MEe9JtyMARKCq
	 OsKaO4PPgfcbgTDw33LPxpOolodGKsdhIykRymhYri+JeNTEZUGQdgg0r4NRhV+/z9
	 uLwVU5xseRMgQ==
Date: Fri, 27 Feb 2026 22:58:10 -0800
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
Subject: Re: [PATCH 24/25] xor: pass the entire operation to the low-level ops
Message-ID: <20260228065810.GJ65277@quark>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-25-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226151106.144735-25-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_225815_945274_5E1EBF9B 
X-CRM114-Status: GOOD (  10.40  )
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

On Thu, Feb 26, 2026 at 07:10:36AM -0800, Christoph Hellwig wrote:
> +#define __DO_XOR_BLOCKS(_name, _handle1, _handle2, _handle3, _handle4)	\
> +void								\
> +xor_gen_##_name(void *dest, void **srcs, unsigned int src_cnt,		\
> +		unsigned int bytes)					\
> +{									\
> +	unsigned int src_off = 0;					\
> +									\
> +	while (src_cnt > 0) {						\
> +		unsigned int this_cnt = min(src_cnt, 4);		\
> +		unsigned long *p1 = (unsigned long *)srcs[src_off];	\
> +		unsigned long *p2 = (unsigned long *)srcs[src_off + 1];	\
> +		unsigned long *p3 = (unsigned long *)srcs[src_off + 2];	\
> +		unsigned long *p4 = (unsigned long *)srcs[src_off + 3];	\

This reads out of bounds if src_cnt isn't a multiple of 4.

- Eric

