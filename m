Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4B1F36BA4
	for <linux-um@archiver.kernel.org>; Fri, 10 Apr 2026 03:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zuI9CuAq4ouP3xdUoAp+vg+3Srv0NooAubzTfiX0RTg=; b=YzoJPWXcsIqasVUHyb6Mr3vOPL
	Gz5ic8gQ9uFkVBS/W/nzvScKXkP8dnxgXlYfzn+1qrXwoiNaxPr4IxUhtALwhHmO2YF+c5wG+SLLD
	TRwOliSUYU3IChG8NYYOQCmLz3fGHLCRKEOKjcxr/fwdid/Dz1DtKyVMowroX5Al1Ks+AhN766Qbt
	OsYGnxeFrR9E1EToB8eBz0J2+HwisrAjpLy1LOMyljleHjkGb23v0U/+M9brUgUhMKj7nlV16QB5s
	BkWGvlzFyVDDq5WVTzvewV+NcPtXhTSSPJGHR+9vGPF/hogj/VMvLWtkMcf62A4waT9fqqofZTEUO
	RkPYLIGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB2PU-0000000BX2y-42RE;
	Fri, 10 Apr 2026 03:19:56 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB2PR-0000000BX2S-1CdP;
	Fri, 10 Apr 2026 03:19:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A3716444F9;
	Fri, 10 Apr 2026 03:19:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35C1C4CEF7;
	Fri, 10 Apr 2026 03:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775791191;
	bh=++Koq39UWrgs6Y9/teNpfuGX4Prd7yZehxjZlfBpaLk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=mdYIM+3nOOfJk2sQndWIVe1crpn+qIFglFUaJi6YUZ8om+pF74JbkoMG1pCSpEb9w
	 XY42HnmovukKhj85guOzmyhoPciXUmwPx7036BzxDj+GBwDX7w8ZX/kQj6Kf75C9nQ
	 yMJOxpzFMvk+DFq2q3tbouAiWajtfDS+AXyxjQFI3HFmtdEmAwU/TRZgmOQyhKh0dz
	 oTEcDPh4RcJYLV/DB6MyHh1cNOYj4HnTWHBSTgpco77/7Mk4f7CQSMgdwxNaeolZeG
	 11Id3MhuCNF2BddA3SZqi8zEZAyyZSbKwJdKtgyQMtKdIjBxiedoSXRHs0s+vuBPie
	 fHhNTH/TVHimw==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id BEAFCF4007B;
	Thu,  9 Apr 2026 23:19:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 09 Apr 2026 23:19:48 -0400
X-ME-Sender: <xms:VGzYaRzc9F2SaA_dXGONVlZncUeqwfeC1knsfsUGLqCLtL9x7AJ9oQ>
    <xme:VGzYaXbKB70COhi6wU5zcJDCn3jfZcRswNA20Sizt_IZgoixIWdWvIaDWTE9UJGaO
    0gyCPv6TWv531UsombbNhRf0U-TJegFRbhlgcIH7rcKGm2a1YHwez-u>
X-ME-Received: <xmr:VGzYaeCIWm-xaXNHRiAOee5n1VgDRaIYH8ii2WphVWSDkg5IlPqKJ2tQQw7rWGta-3eIj1g2bSuh8bC3JY4Fe1PIIjMC3ZQPqnM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvkedvlecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:VGzYaRWWYH9YS5_KZb8QZgCAsWZfUiB9ORAbpTx2OwSeNwf8aS1oTQ>
    <xmx:VGzYaYKyeSQq62O7WlXYf1xoalWcpZEhKySYJd9-cJQMpEvayfPE0g>
    <xmx:VGzYaaJiDRoNy9BMYAaTC41fiA_6sbPjbfWZ4OvQdt7iOTvnCgAc1A>
    <xmx:VGzYac91Cyql-IFbLq_KalJjxN3efCc9QroVK6-eoTOUQqKKiQULjQ>
    <xmx:VGzYaQXpDuEx9ex4m7qF5l0GU1hi1krNMW-ZgN0aa1e6laSCn6NuISRa>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 23:19:47 -0400 (EDT)
Date: Thu, 09 Apr 2026 20:19:47 -0700
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
  Dan Williams <dan.j.williams@intel.com>,  Chris Mason <clm@fb.com>,
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
Message-ID: <69d86c53cfc4_2b31100e7@djbw-dev.notmuch>
In-Reply-To: <20260327061704.3707577-25-hch@lst.de>
References: <20260327061704.3707577-1-hch@lst.de>
 <20260327061704.3707577-25-hch@lst.de>
Subject: Re: [PATCH 24/28] async_xor: use xor_gen
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260409_201953_394720_5542D92A 
X-CRM114-Status: GOOD (  19.92  )
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
> Replace use of the loop around xor_blocks with the easier to use xor_gen
> API.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  crypto/async_tx/async_xor.c | 34 ++++++++++------------------------
>  1 file changed, 10 insertions(+), 24 deletions(-)
[..]
> @@ -168,11 +156,10 @@ dma_xor_aligned_offsets(struct dma_device *device, unsigned int offset,
>   *
>   * honored flags: ASYNC_TX_ACK, ASYNC_TX_XOR_ZERO_DST, ASYNC_TX_XOR_DROP_DST
>   *
> - * xor_blocks always uses the dest as a source so the
> - * ASYNC_TX_XOR_ZERO_DST flag must be set to not include dest data in
> - * the calculation.  The assumption with dma engines is that they only
> - * use the destination buffer as a source when it is explicitly specified
> - * in the source list.
> + * xor_gen always uses the dest as a source so the ASYNC_TX_XOR_ZERO_DST flag
> + * must be set to not include dest data in the calculation.  The assumption with
> + * dma engines is that they only use the destination buffer as a source when it
> + * is explicitly specified in the source list.
>   *
>   * src_list note: if the dest is also a source it must be at index zero.
>   * The contents of this array will be overwritten if a scribble region
> @@ -259,11 +246,10 @@ EXPORT_SYMBOL_GPL(async_xor_offs);
>   *
>   * honored flags: ASYNC_TX_ACK, ASYNC_TX_XOR_ZERO_DST, ASYNC_TX_XOR_DROP_DST
>   *
> - * xor_blocks always uses the dest as a source so the
> - * ASYNC_TX_XOR_ZERO_DST flag must be set to not include dest data in
> - * the calculation.  The assumption with dma engines is that they only
> - * use the destination buffer as a source when it is explicitly specified
> - * in the source list.
> + * xor_gen always uses the dest as a source so the ASYNC_TX_XOR_ZERO_DST flag
> + * must be set to not include dest data in the calculation.  The assumption with
> + * dma engines is that they only use the destination buffer as a source when it
> + * is explicitly specified in the source list.

In retrospect, no need to duplicate this help, but as is:

Reviewed-by: Dan Williams <djbw@kernel.org>

