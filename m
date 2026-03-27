Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5E710BA43C
	for <linux-um@archiver.kernel.org>; Fri, 27 Mar 2026 08:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qGOrNjEazvrzVhLMp+K3yNYEg55RN3GLZqMpakgepoM=; b=0tyEox4jxW7ej/QkahNsL5IjqY
	b3WD+wgj/Y3X5u86PHFfcEdZ0DMRIaA3McR9JT/zheXtJ5HsNMVINnePmTnH+4FBVCtV2qaMb4IMB
	oJS61xhqaBEfZfH20kpIhVYfot5LDp/3v8kbYisjZ1wtQZyfFRi1a1o/TpTbG/M6CMrwd2/o7BG+m
	mfRN1IR75KGxfVIzmRRL81qhId33kc7lhaIK/cXXEXzB/ncUyQXSqKlFYsWu7FtdjW8O/3mOgC4J4
	AVsO+T65yeG5cwzs5Lu7j0Hq9jB3mS7PJipmmDVnY0OamXc4gQTu/3aOekmJVTjLgrLRnBeKtqJhJ
	Y4lzWxuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w62Vp-00000006xmw-2Bxh;
	Fri, 27 Mar 2026 08:25:49 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w62Vn-00000006xm9-1LpP;
	Fri, 27 Mar 2026 08:25:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5C5CB6132B;
	Fri, 27 Mar 2026 08:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A409AC4AF0E;
	Fri, 27 Mar 2026 08:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774599946;
	bh=oGcTlThlcrf/a6X6Pba0yaQBbOhK2gU5HD6vMRqLYbw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=SCw3XSmbAGspl1ahHzR9hENTHY5uIP6pHK1EXM1nnwDzeWfDylaqquE35acjrRHH3
	 vT5m5lC8gw0DpNVnep9R6Cf8dWPJRqPdlBYjgXEwesSwyqhicWBhuGMtDvIgsBo5Si
	 5GZ+3p66/qiFFP29Pq3mrBCtr5TAMQHsbD5/ZhCQgajJrfYK/tHYkIqP2t3WhAvW9I
	 YjMhP1C3LRL73un2ThsrILuHl5NiW8hZc9VxUHbCMcCc1aPK1Gl/rRWGS9BBltb5CI
	 pFy5jE8lNsiivmtQLHgH9N7mkJOw0GGtYne0MS8Obhh9TxXnLT7bc0+v/h4aZUiKHT
	 z21HAUIPUYQ2w==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6F5B9F4006E;
	Fri, 27 Mar 2026 04:25:43 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Fri, 27 Mar 2026 04:25:43 -0400
X-ME-Sender: <xms:Bz_GaeV3zNaSpHJHySYxTNOI14Bf1EmJgTqGji8Tx6XrdR-ly4fPVA>
    <xme:Bz_GaVaecSFZVaUx_LS_q-dDchW3x2ph_U-FNZZvjkVa-2Cbgvi2qQJJQEWm1pEen
    o2Nmsvazvbril7mJ2bFLAHoL0kR_6ydzStl4XH8vMJ4O7DQEb3zgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdelkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvueehiedtvedtleekuddutefgffdtleetfeetveejveejieehfefhjeei
    jeefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopeehtddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtoheptggrthgrlhhinhdrmhgrrh
    hinhgrshesrghrmhdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidr
    ohhrghdruhhkpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvgdprhgtphhtthhope
    grnhhtohhnrdhivhgrnhhovhestggrmhgsrhhiughgvghgrhgvhihsrdgtohhmpdhrtghp
    thhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtohepuggrvhgvmh
    esuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrohhusegvvggtshdrsggvrhhk
    vghlvgihrdgvughupdhrtghpthhtohepmhhpvgesvghllhgvrhhmrghnrdhiugdrrghu
X-ME-Proxy: <xmx:Bz_GadcJkX20GupXEUp-1Bp1i56g4LWcqwmuAAUTXMfU5fJkgo7Tdw>
    <xmx:Bz_Gae4Ua-AeB83mS_pFrGVbAUqLQoAnmgxrDbHOol1S2B-duVR5XQ>
    <xmx:Bz_GaRnLH2iPqmlmio84hLTWA0CS_wnMOI2-h11M3d92fo7SmGfrqA>
    <xmx:Bz_GaUbPhoo7c5hIYcd0gM0CfIgT0rg3SwoJSuxv9v4EumISMkIDVQ>
    <xmx:Bz_GafNBX4aAxc6vxqjfi2htd4zy-WLnaQnlHHZvUG3bWFOqd9K8W1h7>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3B247700065; Fri, 27 Mar 2026 04:25:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: ALG_cRBuf6HF
Date: Fri, 27 Mar 2026 09:25:22 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
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
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Paul Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>,
 "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "David S. Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>,
 "Dan Williams" <dan.j.williams@intel.com>, "Chris Mason" <clm@fb.com>,
 "David Sterba" <dsterba@suse.com>, "Arnd Bergmann" <arnd@arndb.de>,
 "Song Liu" <song@kernel.org>, "Yu Kuai" <yukuai@fnnas.com>,
 "Li Nan" <linan122@huawei.com>, "Theodore Ts'o" <tytso@mit.edu>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-raid@vger.kernel.org
Message-Id: <e7979928-b33a-4132-b08b-d95b91b14295@app.fastmail.com>
In-Reply-To: <20260327061704.3707577-4-hch@lst.de>
References: <20260327061704.3707577-1-hch@lst.de>
 <20260327061704.3707577-4-hch@lst.de>
Subject: Re: [PATCH 03/28] arm64/xor: fix conflicting attributes for xor_block_template
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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


On Fri, 27 Mar 2026, at 07:16, Christoph Hellwig wrote:
> Commit 2c54b423cf85 ("arm64/xor: use EOR3 instructions when available")
> changes the definition to __ro_after_init instead of const, but failed to
> update the external declaration in xor.h.  This was not found because
> xor-neon.c doesn't include <asm/xor.h>, and can't easily do that due to
> current architecture of the XOR code.
>

Even if it did, it wouldn't matter - __ro_after_init has no effect on declarations, only on definitions - it only controls the placement of the object in the .data..ro_after_init section (and declarations don't generate any code)

> Fixes: 2c54b423cf85 ("arm64/xor: use EOR3 instructions when available")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm64/include/asm/xor.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

