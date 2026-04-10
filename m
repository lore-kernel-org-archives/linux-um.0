Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E7AF36BA2
	for <linux-um@archiver.kernel.org>; Fri, 10 Apr 2026 03:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A1MMLpCtWUIER2yB2khaeXpeJnU94ahgZaruTHZtRRM=; b=J0o6oh1IGFPCIQp8JIGdtrz3f/
	BvBet2HaWJrbV+L04+FTaL6/iGePD/lb5TYWRb4uSIftY0c+Puc1cmGOZYs28uqtnJLNpE9sW30RK
	7r0dhvO8koVWpcajkfg6OSW24Hh6WY8spN7bz+Q1Sq+MfKoVzXFR/YThPMwzb7bsHtk+HsPrC4uRJ
	sa7G1i2h7ZAbEX/yAeGwE3PyCZBqvkh6oy8Yd9CZydTSB62kN5o0U2l/fSZgfjX9rTL4mZvu+r9x/
	2NagVVhD1RARgaA/MRbWzk4BlAqX3zT8594/L4pwpuz/VKak0JSyD6u5+Xzkg06R7ndqefzBTBxLF
	/tMuqeeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB2A4-0000000BVxu-1iEv;
	Fri, 10 Apr 2026 03:04:00 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB2A3-0000000BVx7-0im8;
	Fri, 10 Apr 2026 03:03:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id F401C60128;
	Fri, 10 Apr 2026 03:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C90C4AF09;
	Fri, 10 Apr 2026 03:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775790237;
	bh=Nwk8dytVxtAcRGL5pp2fXfwnyG0rAc7e4uC2d6AAYRg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=T/D7P0OnXqHBDeQqj0h+GFE/3Xub3uNWD/H6IQFMt2AY/bVaKy+WmWuJnHHHPs4te
	 hV9xrnF3uDTri3QzZLfx5iXWWOJjOHraM49yvjYlNU4idQTQ+/Sm3e0QBl2DI93SWn
	 lV68Gq3HrDHSYteo85CoZZEXlSJugMUTCVv+QbvJPDu34f6X/8VLyYV6FTPQEDtclJ
	 ajyD2uqb/ZTUnOgDwjdDTl+pyVgJHVqYiR+gAIfeeejGfdPS8EzWxC8Kd1fe1Qw6HU
	 n0zDG+/IH8P7jUAey0rb5m9iJQ+QpVGqPHl1+NZdXdiwtZ0yCDj1wYJccYYpDVlwtg
	 segn4CgTD+0SQ==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1DD50F4006C;
	Thu,  9 Apr 2026 23:03:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 09 Apr 2026 23:03:55 -0400
X-ME-Sender: <xms:m2jYaVvuNB5v6GdnqhWjXHPrj-Xs1ai94wK3KRNupkgFhOqQzZzC3g>
    <xme:m2jYaUkpyJyCUCNgE74bnGCIbxEU2FOGFeTlPUTKpeQlSmmrwZCpKgaYK17P95KFr
    nEzX-ncsYgUTkO6FZme_rDCXDG2CwOa1VyCDjvXXLNAOHNJiDm0VQ>
X-ME-Received: <xmr:m2jYabd6-O1qxrmkpOxlYl4FVsVLLTtlO0FUgeKGKnisk32YMxXKA6ajLjBSsi4OwpBieBXg5XNaIMpiNH287KhulUeaVDZHAno>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvkedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefkjghfufggtgfgsehtjeertddttdejnecuhfhrohhmpeffrghnucghihhl
    lhhirghmshcuoegujhgsfieskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    elhfeiudfgvdeijedtleeltdduueekffejjedvjefhgeevjeefueejledtleetjeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegujhgsfidomh
    gvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudejjedvfedtgeehhedqfeeffeel
    gedtgeejqdgujhgsfieppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpd
    hnsggprhgtphhtthhopeehjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgt
    hheslhhsthdruggvpdhrtghpthhtoheprhhitghhrghrugdrhhgvnhguvghrshhonheslh
    hinhgrrhhordhorhhgpdhrtghpthhtohepmhgrthhtshhtkeeksehgmhgrihhlrdgtohhm
    pdhrtghpthhtoheplhhinhhmrghgjeesghhmrghilhdrtghomhdprhgtphhtthhopehlih
    hnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheptggrthgrlhhinhdr
    mhgrrhhinhgrshesrghrmhdrtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheprghruggssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegt
    hhgvnhhhuhgrtggriheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:m2jYaaC4G7STwDvUR7CS2sxLuhd9_4NTIflnGuzCDX01-Jgs4uT14w>
    <xmx:m2jYabFJVBuKmgUrK5OxBUlDqAvsZl1v-KMAzmE5eUIfVrz_tB9pMg>
    <xmx:m2jYaaX7R7qnh6LbNHm0_HED8Pa2kjuIJjs5gCHCF1o3NoJmwEhrDw>
    <xmx:m2jYaRZOO7FN7nulMEWiPxFetgPeGu3izX4XOgb9ubOxzrqmygE-lA>
    <xmx:m2jYaUDJMWByc2-YkX4kdjvhaEqEcInJJMajfYWN-Sgm8d1ZFIpInjBP>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 23:03:53 -0400 (EDT)
Date: Thu, 09 Apr 2026 20:03:52 -0700
From: Dan Williams <djbw@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Richard Henderson <richard.henderson@linaro.org>,
  Matt Turner <mattst88@gmail.com>,  Magnus Lindholm <linmag7@gmail.com>,
  Russell King <linux@armlinux.org.uk>,
  Catalin Marinas <catalin.marinas@arm.com>,
  Will Deacon <will@kernel.org>,  Ard Biesheuvel <ardb@kernel.org>,
  Huacai Chen <chenhuacai@kernel.org>,  WANG Xuerui <kernel@xen0n.name>,
  Madhavan Srinivasan <maddy@linux.ibm.com>,
  Michael Ellerman <mpe@ellerman.id.au>,
  Nicholas Piggin <npiggin@gmail.com>,
  "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
  Paul Walmsley <pjw@kernel.org>,  Palmer Dabbelt <palmer@dabbelt.com>,
  Albert Ou <aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>,
  Heiko Carstens <hca@linux.ibm.com>,  Vasily Gorbik <gor@linux.ibm.com>,
  Alexander Gordeev <agordeev@linux.ibm.com>,
  Christian Borntraeger <borntraeger@linux.ibm.com>,
  Sven Schnelle <svens@linux.ibm.com>,
  "David S. Miller" <davem@davemloft.net>,
  Andreas Larsson <andreas@gaisler.com>,
  Richard Weinberger <richard@nod.at>,
  Anton Ivanov <anton.ivanov@cambridgegreys.com>,
  Johannes Berg <johannes@sipsolutions.net>,
  Thomas Gleixner <tglx@kernel.org>,  Ingo Molnar <mingo@redhat.com>,
  Borislav Petkov <bp@alien8.de>,
  Dave Hansen <dave.hansen@linux.intel.com>,  x86@kernel.org,
  "H. Peter Anvin" <hpa@zytor.com>,
  Herbert Xu <herbert@gondor.apana.org.au>,
  Dan Williams <djbw@kernel.org>,  Chris Mason <clm@fb.com>,
  David Sterba <dsterba@suse.com>,  Arnd Bergmann <arnd@arndb.de>,
  Song Liu <song@kernel.org>,  Yu Kuai <yukuai@fnnas.com>,
  Li Nan <linan122@huawei.com>,  Theodore Ts'o <tytso@mit.edu>,
  "Jason A. Donenfeld" <Jason@zx2c4.com>,  linux-alpha@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  loongarch@lists.linux.dev,  linuxppc-dev@lists.ozlabs.org,
  linux-riscv@lists.infradead.org,  linux-s390@vger.kernel.org,
  sparclinux@vger.kernel.org,  linux-um@lists.infradead.org,
  linux-crypto@vger.kernel.org,  linux-btrfs@vger.kernel.org,
  linux-arch@vger.kernel.org,  linux-raid@vger.kernel.org
Message-ID: <69d86898b666c_2b31100cd@djbw-dev.notmuch>
In-Reply-To: <20260327061704.3707577-23-hch@lst.de>
References: <20260327061704.3707577-1-hch@lst.de>
 <20260327061704.3707577-23-hch@lst.de>
Subject: Re: [PATCH 22/28] xor: add a better public API
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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

Christoph Hellwig wrote:
> xor_blocks is very annoying to use, because it is limited to 4 + 1
> sources / destinations, has an odd argument order and is completely
> undocumented.
> 
> Lift the code that loops around it from btrfs and async_tx/async_xor into
> common code under the name xor_gen and properly document it.

Apologies for the latency on taking a look at this set from me. This and
the touch to async_xor() look good.

Reviewed-by: Dan Williams <djbw@kernel.org>

