Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050BEC47DD9
	for <linux-um@archiver.kernel.org>; Fri, 23 Feb 2024 00:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ptAOfULggNO+IbVxMprkwBs1rny0N9tVPVvrHf1XTiM=; b=nn26syjX4mngBjr4PhI030m4Xd
	DnSD6DP4hohXDC3eE8jPOaPDOGOUQwqqnFePyL9W2oXj0UcvrFDqJpB+MRmYt5MM9T2dqJy/AzZcM
	AcT2Y1H1hX4wLilKfPbvui1BvUBLQ9rjQKLRHkBmlQZgUQ5E1DxSAGm3/+wILMXr9M9ZCDyr6LOzA
	ZBGL9JK1K5U+nBIFj21pVjmrxpJBO5t2yZPUEUwgr7SnSpE6wcCqgSYB2TlWLgHz7Xuhx5vnXGxNS
	C+6wxDjK7W/a9CER1Kbb8kDb5YGvtv3t7PCvnr4RroBQaBnKtvL1GRyDCzhQGgdV3LjwOUbMFYMxB
	lF/aOb3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdJ2k-000000077VK-04DX;
	Fri, 23 Feb 2024 00:03:58 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdJ2B-000000077Ph-2E9w;
	Fri, 23 Feb 2024 00:03:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 08E316339E;
	Fri, 23 Feb 2024 00:03:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B1BC433C7;
	Fri, 23 Feb 2024 00:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708646602;
	bh=MoRpThz8BwfGmQI/tdKDwo2lq+nMd+Ual2CCuubziSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cic+Typd/Jo4A8aZdMWorj3V/IJph/j22l1PdN+nPGCHm4iZfwiLNl65BzABHjIxm
	 Iqz2LIvb4Dg1cGZe3e9wB5lF3jTkEm14dH2k4Vm1W+JG0BS9XVXV7s2LD9qSqiy8l+
	 4dX1FShLh+4XcOIf5X6i22kZ0XvVyRQZWMWB923qnu/lMp1brWdCmuGOWMf7J8B1Ic
	 0g2q737UYikU/jvWOKf8T+ebhFnAtVRYcWrMSHFHx8ZVBTzz20ajVetX/MiCuST/B4
	 CAJnvBDzwmRczVF9VicJZS48AQ6Q2ib4yJfGeZuq4Q8zEAYpg4QoxfJcdiDMAJmOl4
	 owPDQU0LZN0Bw==
Date: Thu, 22 Feb 2024 17:03:17 -0700
From: Rob Herring <robh@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 5/7] arm64: Unconditionally call
 unflatten_device_tree()
Message-ID: <20240223000317.GA3835346-robh@kernel.org>
References: <20240217010557.2381548-1-sboyd@kernel.org>
 <20240217010557.2381548-6-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217010557.2381548-6-sboyd@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240222_160324_029809_ECFCADED 
X-CRM114-Status: GOOD (  14.09  )
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

On Fri, Feb 16, 2024 at 05:05:54PM -0800, Stephen Boyd wrote:
> Call this function unconditionally so that we can populate an empty DTB
> on platforms that don't boot with a firmware provided or builtin DTB.
> When ACPI is in use, unflatten_device_tree() ignores the
> 'initial_boot_params' pointer so the live DT on those systems won't be
> whatever that's pointing to. Similarly, when kexec copies the DT data
> the previous kernel to the new one on ACPI systems,
> of_kexec_alloc_and_setup_fdt() will ignore the live DT (the empty root
> one) and copy the 'initial_boot_params' data.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  arch/arm64/kernel/setup.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Catalin, Will, Can I get an ack on this so I can take the series via the 
DT tree.

Rob

