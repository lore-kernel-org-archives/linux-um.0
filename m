Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4AEAC4707B
	for <linux-um@archiver.kernel.org>; Thu, 18 Jan 2024 15:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dhDoZpZeUn10XxyBQ5M6DxWUMdgqWpNspCtK0s+TXTg=; b=XeB8n7bEpqkTAqW341rpWDX81Q
	fSKosd6FnCsRKkrp4AOqOI90gUePRPE8qT/z+Uv0czIJsA/UL0IZvCtDBFqNYdCzMDUQo6sINp8IC
	XMe3mNTkx8BqqYwCkPHpg4kQPcmWrGxdlqTuhrAQsTK0aqBL0imczcKiB4t+jRNjP/UoznWNrajf2
	e6azVkrzqo2UkENIDrro/o90ejMbYBtyH3tJhJdpbifYeNjeOE18/6QbAoQ7fVI2QOpnPHTr0Xvo9
	VIewLmp2B4CYz4RVQvqQJWZKy1080C881wyH3pS987pOdMMJ4I56pnKcGQXO3BmpDazssei1Z/pXH
	5vJ9YWgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQUIC-00362S-0Q;
	Thu, 18 Jan 2024 15:26:56 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQUI8-00361b-1k;
	Thu, 18 Jan 2024 15:26:54 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A8C11042;
	Thu, 18 Jan 2024 07:27:36 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.28.174])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73C1F3F73F;
	Thu, 18 Jan 2024 07:26:47 -0800 (PST)
Date: Thu, 18 Jan 2024 15:26:43 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org,
	Frank Rowand <frowand.list@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/6] arm64: Unconditionally call unflatten_device_tree()
Message-ID: <ZalDM90KoQ2Il0j7@FVFF77S0Q05N.cambridge.arm.com>
References: <20240112200750.4062441-1-sboyd@kernel.org>
 <20240112200750.4062441-2-sboyd@kernel.org>
 <ZaZtbU9hre3YhZam@FVFF77S0Q05N>
 <434b21afe1899b1567f3617261594842.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <434b21afe1899b1567f3617261594842.sboyd@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240118_072652_714153_94C1581F 
X-CRM114-Status: GOOD (  18.61  )
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

On Tue, Jan 16, 2024 at 05:27:18PM -0800, Stephen Boyd wrote:
> Quoting Mark Rutland (2024-01-16 03:51:14)
> > Hi Stephen,
> > 
> > On Fri, Jan 12, 2024 at 12:07:44PM -0800, Stephen Boyd wrote:
> > > Call this function unconditionally so that we can populate an empty DTB
> > > on platforms that don't boot with a firmware provided or builtin DTB.
> > > There's no harm in calling unflatten_device_tree() unconditionally.
> > 
> > For better or worse, that's not true: there are systems the provide both a DTB
> > *and* ACPI tables, and we must not consume both at the same time as those can
> > clash and cause all sorts of problems. In addition, we don't want people being
> > "clever" and describing disparate portions of their system in ACPI and DT.
> > 
> > It is a very deliberate choice to not unflatten the DTB when ACPI is in use,
> > and I don't think we want to reopen this can of worms.
> 
> Hmm ok. I missed this part. Can we knock out the initial_boot_params in
> this case so that we don't unflatten a DTB when ACPI is in use?

Why is that better than just not calling unflatten_device_tree(), as we do
today?

The cover letter says this is all so that we can run DT tests for the clk
framework; why can't that just depend on the system being booted with DT rather
than ACPI? We have other tests which are architecture and/or configuration
dependent...

Mark.

