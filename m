Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD65C5478C
	for <linux-um@archiver.kernel.org>; Fri, 23 Feb 2024 11:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GGQwoUedCg6SDZwo1edcNmRqrJZx6k4MPaiQZLBrczA=; b=EJExQjA43yuCCJPw2zUeVwMs8S
	j8Vuk6ixvPP75zgjMGFGejlJeOruxz1XAdmLxkhkQPboMG2tazEBg6e1zff6TXaf9mFquCr6IOoOA
	kzoqNhfbxNqHmxbzz0XgTcWjOLRjsQuUBtUqzzmgmkHvPAi411pZeaMV7YCR4hi5cDIX0r7hjrRQw
	cNN4QUZdDNk5Wcb4uUAH/E7qgF4E3D+jletF/JNQ8zv2tOisMYUPiVqTkuLv0XP3/3etWchgC1QpE
	HFwxyfarRpsgwwiX7KU4ATMxo8A/Aj/trKYkvXyYzduLfE72YvAB+dau5BElSeNFSjnJGE2Mq3+CS
	FVKT4pFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdTq0-00000009932-2aZu;
	Fri, 23 Feb 2024 11:35:45 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdSie-00000008tHa-2LmW;
	Fri, 23 Feb 2024 10:23:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id ED27063429;
	Fri, 23 Feb 2024 10:23:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD81C43390;
	Fri, 23 Feb 2024 10:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708683831;
	bh=POfdF2ZcozXmc94NwYnJXw5bpLHLF02/HCONX/hP5F0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hbubaLcQoaLHfcbIAVPWfexu6j5RRj/AGj/NMVXOc/9b0VdmsSZOcrzf7L6EeL8M0
	 6HkSzwrO1awO6Lc72BAtPx2c7mvsqGYRp+l9ILMHDvNVkEH9+jTf78oycSXiotHnNz
	 We2l0WXMP9CJWjNAP+Qn0JiOxpl8FPQkfwUVpVexEn1UVGkxUZNqmmBMS+fA1MSzK+
	 d22/rT0z8/5f2Cc3TSxCjMjQDdtonOZAOtaDUWZ04DLlq/eDvwflAGBeI/EhXhvhV/
	 tnxOpVp+CqZU0GSmAW0hWWada3Te5lm0y2nBTbC171yGJIA/YW01mIrCeLW2KEDNvO
	 K393QH8TJpxig==
Date: Fri, 23 Feb 2024 10:23:45 +0000
From: Will Deacon <will@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org,
	Frank Rowand <frowand.list@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 5/7] arm64: Unconditionally call
 unflatten_device_tree()
Message-ID: <20240223102345.GA10274@willie-the-truck>
References: <20240217010557.2381548-1-sboyd@kernel.org>
 <20240217010557.2381548-6-sboyd@kernel.org>
 <20240223000317.GA3835346-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223000317.GA3835346-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240223_022355_023677_E1312949 
X-CRM114-Status: GOOD (  17.74  )
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

On Thu, Feb 22, 2024 at 05:03:17PM -0700, Rob Herring wrote:
> On Fri, Feb 16, 2024 at 05:05:54PM -0800, Stephen Boyd wrote:
> > Call this function unconditionally so that we can populate an empty DTB
> > on platforms that don't boot with a firmware provided or builtin DTB.
> > When ACPI is in use, unflatten_device_tree() ignores the
> > 'initial_boot_params' pointer so the live DT on those systems won't be
> > whatever that's pointing to. Similarly, when kexec copies the DT data
> > the previous kernel to the new one on ACPI systems,
> > of_kexec_alloc_and_setup_fdt() will ignore the live DT (the empty root
> > one) and copy the 'initial_boot_params' data.
> > 
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: <linux-arm-kernel@lists.infradead.org>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >  arch/arm64/kernel/setup.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> Catalin, Will, Can I get an ack on this so I can take the series via the 
> DT tree.

Mark had strong pretty strong objections to this in version one:

https://lore.kernel.org/all/ZaZtbU9hre3YhZam@FVFF77S0Q05N/

and this patch looks the same now as it did then. Did something else
change?

Will

