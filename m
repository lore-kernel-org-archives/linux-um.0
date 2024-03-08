Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88160C5475B
	for <linux-um@archiver.kernel.org>; Fri,  8 Mar 2024 19:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LKyZ9ybpeY27OV6kZ9Akn3ZqP1/WIciqb6YlIuMdkGw=; b=GSE1kKgkaOB+cnVzWAu317Mqtm
	2zMVRdccqs1IjnjhTvx6FFWY+0sXBjTxXJToKlVdGS2mMV9uzEl8+O+U0+wO/sOiAKq+3JqIBiqJ8
	d4dwiC0Zi4ZsLQuBE3WLbbtnWigtD9i8/ZVuiRS6D4RKrZTYfw+W2woPnhi6JhqiX5vaJ2+qOCzFy
	DWAMnlv/Csik9UcSwzzMbGaqm9l11d5R303oV0TnMXoQRe5GWMBn+N3zcfFc3yiWmX+Y39HvU4+Zq
	5KVa8MKnKL+391tWIXSiF8ypOVSMqKJ6zmBc1p6UW7KntQlEZNd9p1C3ae+GbLk5kq6gcWzp1TOQM
	YDeztWLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rigLh-0000000B85h-0xDo;
	Fri, 08 Mar 2024 19:57:45 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rigLd-0000000B842-1dMU;
	Fri, 08 Mar 2024 19:57:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2A1D560DE1;
	Fri,  8 Mar 2024 19:57:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DA4C433C7;
	Fri,  8 Mar 2024 19:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709927859;
	bh=YiBGrbosKvqE47v3MV2Cv6bc3D4XgmKIS13Wo10TU6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F+WNdQe6cbmECo8/n08DihHN9dFt68Jrd2Mhc6uk0wgnjCtbn4KRYxrsFbMOOgy5S
	 TdjWm08AmK4/GV9LrwJlUpee8jZN8ejdRzJQ+rsmLle0F3w7iYOhR1kd7SjZO+Uoof
	 hccrogfp6ZHLr9e5RUnk4oMhKFH8S9xqpvP4OLv85YI92U9bc0dkEClOH+L6AqOgQq
	 LxSvSxQ2nMydUXKe5/rsXzBCD86bOPvS0PZ883GD6hTQqDPj0VHf9/g4L7uo/loXIz
	 h23C4T+IAl8OlVCFDe4O8GtTg4ZUCP0WKz7mVkD9oB3TLaGIduoG79NghY126KQi/F
	 LmA2zOOXXmd9g==
Date: Fri, 8 Mar 2024 13:57:37 -0600
From: Rob Herring <robh@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/7] of: populate of_root node if bootloader doesn't
Message-ID: <20240308195737.GA1174908-robh@kernel.org>
References: <20240217010557.2381548-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217010557.2381548-1-sboyd@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_115741_576968_66F69EFF 
X-CRM114-Status: GOOD (  17.76  )
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

On Fri, Feb 16, 2024 at 05:05:49PM -0800, Stephen Boyd wrote:
> Arch maintainers, please ack/review patches.
> 
> This is a resend of a series from Frank last year[1]. I worked in Rob's
> review comments to unconditionally call unflatten_device_tree() and
> fixup/audit calls to of_have_populated_dt() so that behavior doesn't
> change.
> 
> I need this series so I can add DT based tests in the clk framework.
> Either I can merge it through the clk tree once everyone is happy, or
> Rob can merge it through the DT tree and provide some branch so I can
> base clk patches on it.
> 
> Changes from v3 (https://lore.kernel.org/r/20240202195909.3458162-1-sboyd@kernel.org):
>  * Made OF_UNITTEST depend on OF_EARLY_FLATREE
>  * Made OF_EARLY_FLATREE depend on absence of arches that don't call
>    unflatten_device_tree()
>  * Added of_ prefix to dtb_ prefixed KUnit tests
>  * Picked up tags
> 
> Changes from v2 (https://lore.kernel.org/r/20240130004508.1700335-1-sboyd@kernel.org):
>  * Reorder patches to have OF changes largely first
>  * No longer modify initial_boot_params if ACPI=y
>  * Put arm64 patch back to v1
> 
> Changes from v1 (https://lore.kernel.org/r/20240112200750.4062441-1-sboyd@kernel.org):
>  * x86 patch included
>  * arm64 knocks out initial dtb if acpi is in use
>  * keep Kconfig hidden but def_bool enabled otherwise
> 
> Changes from Frank's series[1]:
>  * Add a DTB loaded kunit test
>  * Make of_have_populated_dt() return false if the DTB isn't from the
>    bootloader
>  * Architecture calls made unconditional so that a root node is always
>    made
> 
> Frank Rowand (2):
>   of: Create of_root if no dtb provided by firmware
>   of: unittest: treat missing of_root as error instead of fixing up
> 
> Stephen Boyd (5):
>   of: Always unflatten in unflatten_and_copy_device_tree()
>   um: Unconditionally call unflatten_device_tree()
>   x86/of: Unconditionally call unflatten_and_copy_device_tree()
>   arm64: Unconditionally call unflatten_device_tree()
>   of: Add KUnit test to confirm DTB is loaded

I've applied the series minus the arm64 patch. It's only needed if 
anyone cares about this working on arm64 ACPI systems. That can be delt 
with separately.

Rob

