Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8916FD8FCE
	for <linux-um@archiver.kernel.org>; Thu, 26 Feb 2026 15:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5NKb8s5uQsJxGoQ2AVBEtObpQ/CvaKcz4OqTIpIkbmc=; b=CFM3hal5HfCMTAkI2I9sQCztvy
	4IIL2STVyJ8W4b2DIytsnpJISYdrt9Yiawdu/nuBeYuVK/KNV5hQPSKqQcYk9KyKkImQp/KESlI/k
	oKdKBIoEk4llJ1zIuqYvlFOnXQbQzhyDLRRmMMVyIkZXh+UF+D7bbfH+Cs0e1eVmXY0pjjXVmw6I9
	v4Ev2QKiPMeQcjVB0uaxI6ya/Ubc319xjaDOQ5Jm54n65yvsrngV7OPISlB5tkUOBS087st2+8sri
	YnAckYC6KjlyLZ6UC740MTcjaBlnuVfVif4Y/6GjJX65BZ7KZGy3udPS1hNgxU63UIKRCE+kgbVIJ
	L52u8x2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvdX0-00000006XlW-1Vnu;
	Thu, 26 Feb 2026 15:44:02 +0000
Received: from flow-a8-smtp.messagingengine.com ([103.168.172.143])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvdWx-00000006XkM-0R1i;
	Thu, 26 Feb 2026 15:44:00 +0000
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 702FC1380BA9;
	Thu, 26 Feb 2026 10:43:55 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 26 Feb 2026 10:43:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772120635;
	 x=1772127835; bh=5NKb8s5uQsJxGoQ2AVBEtObpQ/CvaKcz4OqTIpIkbmc=; b=
	BFOz5yqxSmg9S50IsSdLRGyQHw6zGY1eOdKa+Po1ZziBbN2GJ+4j9GfSK2vBzpb8
	jke/0DjjeJ1N27rCrrDV17hYarBNm1Yv5Ef3DpswEsW5lXmy5P2MpCy6/j4n03oF
	6AXtPA/NP2OgKRV62bfh5y074ZgZyuVK80kBotJiI5viaax3nK4TDXtsz7/fmWKi
	Idb44puvspjnRxIVW8rRiXroKSe3UOJgw6SBDrDW/b4nrdVt9gRrGH0VYyTCCFI+
	MaLql0ByGC1lAPGvtsNQy7knHDrJrYmiw6Z0TH7LP/fMQ/mbjchvlBUub+fpzM0z
	AwgDVPMDWtHsSHNybdc70Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772120635; x=
	1772127835; bh=5NKb8s5uQsJxGoQ2AVBEtObpQ/CvaKcz4OqTIpIkbmc=; b=F
	c2ByHch3ij59MUwgdS2tUPIb02ImNYf+PdWdDaqtx5ATw62eUpliVMY8iV5D7hR3
	wYi0CHEzfkgh/mmBuCbJYAChbEOC/Yi8PJeN5l62Iy2psmFsZrqPUq0n/+vZEsQO
	qYjytQD72iqh1ghXwEeBJ+WUnvc4Fp1Jeo/4mgECJRniva5kBNFlm6iANF8sqab6
	oNPUlMV1dQUyv+GQi7/PfCZFIvgRRn3B9r6NcepO1/wYvQBeHCR1LEsGxh1+Og4p
	FYPE0U4hjheq9evedYJAexwrwIPKQjOD7fllTYCzxyIBPwHANOFBQd6w9WsyZAmJ
	opoR4yIXQlrQwxqExmjlA==
X-ME-Sender: <xms:N2qgaaQjbD4lDTTpYYJW04n5-N_REynhDJNOjDcAsLpq8XoFDTIP1Q>
    <xme:N2qgaalYz6oAwIkXti0ilmTZ4SAWzxEhI78J-NBiOcz8jBnpIMTvnyc8aM72hc_ES
    ARSAHBEQvzfvqva9WEslWopqCs96M2xP3m79vrzlriTC5w2htjwEyM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeigeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohephedtpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopegtrghtrghlih
    hnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhl
    ihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegrnhhtohhnrdhivhgrnhhovhestggrmh
    gsrhhiughgvghgrhgvhihsrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggv
    lhhtrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprh
    gtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtohep
    mhhpvgesvghllhgvrhhmrghnrdhiugdrrghupdhrtghpthhtoheptghlmhesfhgsrdgtoh
    hm
X-ME-Proxy: <xmx:N2qgaUJWUEXUlLEjkxtJWtWBvZvargLkJYDYLT1WCObuQQIhrpl4jg>
    <xmx:N2qgabuNvv7e3NmdoP0u_IPqZN1TMDnyqD0tO35lBUa_NaOCzbSmCg>
    <xmx:N2qgaRqz5OOPUoSW-rsw8dZEHVicCLZG3p0s42DHReFDaNuct761aw>
    <xmx:N2qgafV0jsQUaX0mdJgZVSo50cBCHJXR9outsNs-5KBrOO1PzPsRXw>
    <xmx:O2qgafUJmIOfDaRuA5FfQ3utukV1YK4slK3UAvn21GEOucPhAX52tGfc>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A0F9D700065; Thu, 26 Feb 2026 10:43:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AQu7KcbS869J
Date: Thu, 26 Feb 2026 16:40:21 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christoph Hellwig" <hch@lst.de>,
 "Andrew Morton" <akpm@linux-foundation.org>
Cc: "Richard Henderson" <richard.henderson@linaro.org>,
 "Matt Turner" <mattst88@gmail.com>,
 "Magnus Lindholm" <linmag7@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, "Huacai Chen" <chenhuacai@kernel.org>,
 "WANG Xuerui" <kernel@xen0n.name>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <chleroy@kernel.org>,
 "Paul Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>,
 "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>,
 "Dan Williams" <dan.j.williams@intel.com>, "Chris Mason" <clm@fb.com>,
 "David Sterba" <dsterba@suse.com>, "Song Liu" <song@kernel.org>,
 "Yu Kuai" <yukuai@fnnas.com>, "Li Nan" <linan122@huawei.com>,
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-btrfs@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-raid@vger.kernel.org
Message-Id: <29afa24a-f659-481b-b5a8-7b8b9e009755@app.fastmail.com>
In-Reply-To: <20260226151106.144735-10-hch@lst.de>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-10-hch@lst.de>
Subject: Re: [PATCH 09/25] xor: move generic implementations out of asm-generic/xor.h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_074359_634856_816F4FDF 
X-CRM114-Status: GOOD (  12.25  )
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

On Thu, Feb 26, 2026, at 16:10, Christoph Hellwig wrote:
> Move the generic implementations from asm-generic/xor.h to
> per-implementaion .c files in lib/raid.
>
> Note that this would cause the second xor_block_8regs instance created by
> arch/arm/lib/xor-neon.c to be generated instead of discarded as dead
> code, so add a NO_TEMPLATE symbol to disable it for this case.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Arnd Bergmann <arnd@arndb.de> # for asm-generic
> 
> -#pragma GCC diagnostic ignored "-Wunused-variable"
> -#include <asm-generic/xor.h>
> +#define NO_TEMPLATE
> +#include "../../../lib/raid/xor/xor-8regs.c"

The #include is slightly ugly, but I see it gets better in a later patch,
and is clearly worth it either way.

The rest of the series looks good to me as well. I had a brief
look at each patch, but nothing to complain about.

     Arnd

