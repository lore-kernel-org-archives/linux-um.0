Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39103D58CA3
	for <linux-um@archiver.kernel.org>; Sun, 22 Mar 2026 19:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bTmPP8OnLqeiExMy5beFcuohfgWt4dpRZ1DWTpf3YZQ=; b=gJXGN4ZoRaipQ/XDd3Ha5I02w8
	nShUGcqSL2eruihOdCawqUpp+kVBLnTb5/LwC3cJAZAepYgtwXTHadkrMmuQ8ANx2Qneo4yQ/ulnN
	D3Rgtvw0AhHDptlCAHlNifUwsvXV3IcZ7qPrGJ6m4XX715IpNDXtbR+5vzYiaNnhAgsrWPHO+vI+r
	KV5Zg0NoE55qna1G+Jt2QAzJQ1AVjT0zl+rTVbX55y7B2PvmX/w+CMxSYWvqDW8/JbQgJtwiJNEOE
	OyNDO1UvC5KetqmyJpGDwU/tb890lY419c5qsXy6oHFeq+BekXB3HNc8P3Goz+aF62DGbcQBYLshi
	Ojmi2K6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4OlI-0000000Fbzy-1e5W;
	Sun, 22 Mar 2026 19:47:00 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4OlG-0000000FbzL-1zbH;
	Sun, 22 Mar 2026 19:46:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0257A60008;
	Sun, 22 Mar 2026 19:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E6EC19424;
	Sun, 22 Mar 2026 19:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774208816;
	bh=1o+jeVIgTmIEnNI1PbynIhcC+gTd7dWDUEQ66WQ3SEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vIa1NAg67V4CbhaU/2J0neghThBo4k7QPXUkypKgNLrBdUC1+6bKq11fPhBcCBQKr
	 6POM42bjrnwCLw9SComR95paL974H2Hte8463o2aLUAyXHR4mPRLjhWooIWAfANSk3
	 EmLbZAQ6wZgDom/KBs3EOE6zqYx4M9UNAOHEs4w2qOz6rBm+gyBAu4aQFjyg9lglLP
	 wLJPP1a5I13OknAV72tZzyK+X4adG5wMzHDq77K0vmouUahPu1g8IavcKcFp/wVaHx
	 5CntxUA0nUHEEM/KLptxAsewn+VEchWkcF5OforQ4OI0xzTI9du+HyNP1VvV79DNwC
	 Ejo0iFDdhtrRg==
From: Miguel Ojeda <ojeda@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	ojeda@kernel.org
Cc: iommu@lists.linux.dev,
	driver-core@lists.linux.dev,
	acourbot@nvidia.com,
	akpm@linux-foundation.org,
	aliceryhl@google.com,
	anton.ivanov@cambridgegreys.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	david@davidgow.net,
	gary@garyguo.net,
	johannes@sipsolutions.net,
	justinstitt@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-um@lists.infradead.org,
	linux@armlinux.org.uk,
	llvm@lists.linux.dev,
	lossin@kernel.org,
	mark.rutland@arm.com,
	mmaurer@google.com,
	morbo@google.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	nicolas.schier@linux.dev,
	nsc@kernel.org,
	peterz@infradead.org,
	richard@nod.at,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu,
	urezki@gmail.com,
	will@kernel.org
Subject: Re: Re: [PATCH v2 0/3] Inline helpers into Rust without full LTO
Date: Sun, 22 Mar 2026 20:46:16 +0100
Message-ID: <20260322194616.89847-1-ojeda@kernel.org>
In-Reply-To: <20260322192159.88138-1-ojeda@kernel.org>
References: <20260322192159.88138-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On Sun, 22 Mar 2026 20:21:59 +0100 Miguel Ojeda <ojeda@kernel.org> wrote:
>
> I will reply to a couple other bindings in separate emails to avoid
> spamming people too much.

Under UML, I got `-Wstatic-in-inline` for `dma_free_attrs`:

      BINDGEN rust/bindings/bindings_generated.rs - due to target missing
    In file included from rust/helpers/helpers.c:59:
    rust/helpers/dma.c:17:2: warning: static function 'dma_free_attrs' is used in an inline function with external linkage [-Wstatic-in-inline]
       17 |         dma_free_attrs(dev, size, cpu_addr, dma_handle, attrs);
          |         ^
    rust/helpers/dma.c:12:1: note: use 'static' to give inline function 'rust_helper_dma_free_attrs' internal linkage
       12 | __rust_helper void rust_helper_dma_free_attrs(struct device *dev, size_t size,
          | ^
          | static

For some reason, `dma_free_attrs` is not marked `inline` in
`include/linux/dma-mapping.h` to begin with, unlike the rest.

Unless I am missing something and there is a reason for that, it looks
like it has just been missing since it was added in commit ed6ccf10f24b
("dma-mapping: properly stub out the DMA API for !CONFIG_HAS_DMA").

Do you want a patch?

Cc'ing Marek, Robin, Danilo, Abdiel, Daniel, Andreas, Christoph.

I hope that helps!

Cheers,
Miguel

