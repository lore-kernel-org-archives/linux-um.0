Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06CDFD0659
	for <linux-um@archiver.kernel.org>; Wed, 11 Mar 2026 08:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mz2pLUCkhcl+A7HJAWoFhExbwujxhC5QH/K/Z1t3+jg=; b=mXv0Ey04wKY3yOpsnzmrXCRUWp
	w7KjY0wrUczzlLQDu9bqjqKaulYeUDAN/Rn/M9s4fTdTTVEXeTHd7qRDeb0eL0qY7Aq5vFRHZdLdB
	yzTk03vp+0HFyyakoid8mWTbjeav8k1GidX3F3D3LxrZIH1g8qq6CAzHnc8C1s1iU5qEsc8yaeWbG
	4VQlEjrp+2F9tQEifiZ26Zh4te2uV91WcHkJV1gUzIxe+dZgyeyEaiI+S0f8/uz6fY37pftVN+B10
	/Lzx6yCDjaddpIJC7yGVipCyFmvAUF5YczCqj1zltqqZ4/4HXIj5UEvSTE7VfEnfhkjPTq6tts0fG
	XmphYDVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0FCR-0000000BCLP-3lsA;
	Wed, 11 Mar 2026 08:45:51 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0FCQ-0000000BCKd-0LPp;
	Wed, 11 Mar 2026 08:45:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=mz2pLUCkhcl+A7HJAWoFhExbwujxhC5QH/K/Z1t3+jg=; b=l98ka0CR9G/I95e9nWM15lT5Q9
	7nuOgXl6NPCIWcsczF9WY+UU8hVrREbw7ZHLVBhe+CJRjFdRvpjhy3tcIsw46C6df3pIGo6lEcedo
	p4k7A5magQdvorPknJkOOnwlSm8D1xTs5CE2KSV1jQlE2f6pYhQM9EasNsOwbBaNedWRr5qSZZ2hf
	3x/p8yEzZE4mb81yTx+N5KGWvS9Z4wPABPFtmGUujrlo1HZw3fzlLkb0tRs9TjrPWOzMjiGfvlNlO
	PDcFeuBAnv5Q4CRt4cJ8mKc/dr/BPEQD7v6Zy7pliAY2rTqBCHENJmB0aL1IwtWl8PwOwz/b2BSdh
	RA9AQZSg==;
Received: from mailout.nod.at ([116.203.167.152] helo=lithops.sigma-star.at)
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0FCL-0000000GSIy-3OYF;
	Wed, 11 Mar 2026 08:45:48 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id BC6442B03D8;
	Wed, 11 Mar 2026 09:45:35 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id U1QpR9pLQfYI; Wed, 11 Mar 2026 09:45:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id E817E2ABFDC;
	Wed, 11 Mar 2026 09:45:34 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sQ20C_OvpL54; Wed, 11 Mar 2026 09:45:34 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 297CD2A87F7;
	Wed, 11 Mar 2026 09:45:34 +0100 (CET)
Date: Wed, 11 Mar 2026 09:45:33 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: hch <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Richard Henderson <richard.henderson@linaro.org>, 
	Matt Turner <mattst88@gmail.com>, 
	Magnus Lindholm <linmag7@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, will <will@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy, CS GROUP" <chleroy@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, davem <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Thomas Gleixner <tglx@kernel.org>, mingo <mingo@redhat.com>, 
	bp <bp@alien8.de>, dave hansen <dave.hansen@linux.intel.com>, 
	x86 <x86@kernel.org>, hpa <hpa@zytor.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, 
	dan j williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>, 
	Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>, 
	Li Nan <linan122@huawei.com>, tytso <tytso@mit.edu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, 
	linux-alpha <linux-alpha@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	loongarch <loongarch@lists.linux.dev>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, 
	linux-s390 <linux-s390@vger.kernel.org>, 
	sparclinux <sparclinux@vger.kernel.org>, 
	linux-um <linux-um@lists.infradead.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, 
	linux-btrfs <linux-btrfs@vger.kernel.org>, 
	linux-arch <linux-arch@vger.kernel.org>, 
	linux-raid <linux-raid@vger.kernel.org>
Message-ID: <942530005.19163.1773218733711.JavaMail.zimbra@nod.at>
In-Reply-To: <20260311070416.972667-4-hch@lst.de>
References: <20260311070416.972667-1-hch@lst.de> <20260311070416.972667-4-hch@lst.de>
Subject: Re: [PATCH 03/27] um/xor: cleanup xor.h
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF147 (Linux)/8.8.12_GA_3809)
Thread-Topic: um/xor: cleanup xor.h
Thread-Index: ROrz3iTmErkYXUli/cm3A2WDQMn1kg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260311_084545_959592_503F9309 
X-CRM114-Status: UNSURE (   9.42  )
X-CRM114-Notice: Please train this message.
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

----- Urspr=C3=BCngliche Mail -----
> Since commit c055e3eae0f1 ("crypto: xor - use ktime for template
> benchmarking") the benchmarking works just fine even for TT_MODE_INFCPU,
> so drop the workarounds.  Note that for CPUs supporting AVX2, which
> includes almost everything built in the last 10 years, the AVX2
> implementation is forced anyway.
>=20
> CONFIG_X86_32 is always correctly set for UM in arch/x86/um/Kconfig,
> so don't override it either.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> arch/um/include/asm/xor.h | 16 ----------------
> 1 file changed, 16 deletions(-)

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard

