Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E17EEC01A2
	for <linux-um@archiver.kernel.org>; Mon, 23 Mar 2026 08:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=izD245/HWTfY4YvMavmH0UjvQPvQnie+y+bSLStgLq0=; b=ngwJG+4e0p/mCEGQSCHvd2E8Ab
	Oyp4C2wnY5OmnqgNwsdHrHNuH8xHLfCw2Qa3td8iiXfQhcZPGZjnEXasq86T2aL8DyWrHg19Y16e2
	1P/nwLdgCgqQTDDEXoa9MwrFLukLKxjcefznnmlPjlwS5y6KorVu6EAjI5C/yZQWpurkvtbDTqol7
	mg73E5nTMBiOnAG+uaognL//tvvWKhnarEgT4rEYU0VCWwWHqAWSj1VX8CQzOHEjnZBbRxh123fKb
	JDsREPS6IsV5igl8beT+eeuQFynLrLKgrSJpGaq7Gl1VP3FigxYF2ZW2rFWtWcZx0sQp2yLKEBY8q
	f3Tb97/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4ayg-0000000GJEp-2SGs;
	Mon, 23 Mar 2026 08:49:38 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4ayc-0000000GJBn-1Ti1;
	Mon, 23 Mar 2026 08:49:37 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260323084927euoutp02741697b9873d78530075a5e111d0c62e~fbDhQX7Vx2817128171euoutp02Q;
	Mon, 23 Mar 2026 08:49:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260323084927euoutp02741697b9873d78530075a5e111d0c62e~fbDhQX7Vx2817128171euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1774255767;
	bh=izD245/HWTfY4YvMavmH0UjvQPvQnie+y+bSLStgLq0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=qR20M1T8vm/bninpWfYJUqD2cujoDpUOWwbtW5EzAYPKXXW/reNN8Na0Z0P22N5Fq
	 KD9VJ2HiMGpMBAqMkrXfK9sxLV95K7db3i4rPSoQsvdHzljE+ooz9t4d3X72LfLXNP
	 8uUHazdKV/PWg9ZWyVALYMO1f3Gp3Q87CRMB/Hm0=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260323084927eucas1p12614d2febd7dd400e32c691c74e396e2~fbDhDI1aS1911919119eucas1p1N;
	Mon, 23 Mar 2026 08:49:27 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260323084923eusmtip200157d20bd875804c9aaff92db3a8414~fbDd8kVqg2543925439eusmtip2B;
	Mon, 23 Mar 2026 08:49:23 +0000 (GMT)
Message-ID: <1c4e429b-f30c-42a9-8de1-71cb2cbbc114@samsung.com>
Date: Mon, 23 Mar 2026 09:49:22 +0100
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v2 0/3] Inline helpers into Rust without full LTO
To: Miguel Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Danilo Krummrich <dakr@kernel.org>, Abdiel Janulgue
	<abdiel.janulgue@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>,
	Andreas Hindborg <a.hindborg@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux.dev, driver-core@lists.linux.dev, acourbot@nvidia.com,
	akpm@linux-foundation.org, aliceryhl@google.com,
	anton.ivanov@cambridgegreys.com, bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com, david@davidgow.net, gary@garyguo.net,
	johannes@sipsolutions.net, justinstitt@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-um@lists.infradead.org, linux@armlinux.org.uk, llvm@lists.linux.dev,
	lossin@kernel.org, mark.rutland@arm.com, mmaurer@google.com,
	morbo@google.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	nicolas.schier@linux.dev, nsc@kernel.org, peterz@infradead.org,
	richard@nod.at, rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	urezki@gmail.com, will@kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260322194616.89847-1-ojeda@kernel.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260323084927eucas1p12614d2febd7dd400e32c691c74e396e2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260322194701eucas1p1f72625f53e50806fa4f430550f291e76
X-EPHeader: CA
X-CMS-RootMailID: 20260322194701eucas1p1f72625f53e50806fa4f430550f291e76
References: <20260322192159.88138-1-ojeda@kernel.org>
	<CGME20260322194701eucas1p1f72625f53e50806fa4f430550f291e76@eucas1p1.samsung.com>
	<20260322194616.89847-1-ojeda@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260323_014935_824753_57F8419F 
X-CRM114-Status: GOOD (  14.39  )
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

On 22.03.2026 20:46, Miguel Ojeda wrote:
> On Sun, 22 Mar 2026 20:21:59 +0100 Miguel Ojeda <ojeda@kernel.org> wrote:
>> I will reply to a couple other bindings in separate emails to avoid
>> spamming people too much.
> Under UML, I got `-Wstatic-in-inline` for `dma_free_attrs`:
>
>        BINDGEN rust/bindings/bindings_generated.rs - due to target missing
>      In file included from rust/helpers/helpers.c:59:
>      rust/helpers/dma.c:17:2: warning: static function 'dma_free_attrs' is used in an inline function with external linkage [-Wstatic-in-inline]
>         17 |         dma_free_attrs(dev, size, cpu_addr, dma_handle, attrs);
>            |         ^
>      rust/helpers/dma.c:12:1: note: use 'static' to give inline function 'rust_helper_dma_free_attrs' internal linkage
>         12 | __rust_helper void rust_helper_dma_free_attrs(struct device *dev, size_t size,
>            | ^
>            | static
>
> For some reason, `dma_free_attrs` is not marked `inline` in
> `include/linux/dma-mapping.h` to begin with, unlike the rest.
>
> Unless I am missing something and there is a reason for that, it looks
> like it has just been missing since it was added in commit ed6ccf10f24b
> ("dma-mapping: properly stub out the DMA API for !CONFIG_HAS_DMA").
>
> Do you want a patch?

Yes please, this looks like an oversight.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


