Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0298BC47258
	for <linux-um@archiver.kernel.org>; Wed, 17 Jan 2024 17:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lqtnHlKmsnEzzZiJQ4ioyLgmQocKohb+bg9zm4rHhcM=; b=f5XdhqXQa+bqDaCiw9HkAU8AVA
	dTeq+YQkImg/dz4YlQt/6I/k0I16+MjQT5OqHkL1f/Rl0dHGaQQtz0Md/8XyjuhUa4yTLUkm+bc59
	rwfBsVkbxu6CUiezuiHRzRf3cxC02wkmQhYdlRbkrleFTU5UDu3w/TNzaIaZ9onRk3oep6dFP1FZI
	Z1tNvRQydAybAQhNZ2pUO9c18S5XnJsdPCMipRx50NunvDbgS5Vcz9qa/qZK3vkIO6C9oLb2Xh1Dn
	GkEBj4Cy1Xvd55CjuJgwoHWrGwMZ1VEupnJm3NQ4D5mERFO25eEO2KibRvTYhpQZ0KqPRCMOyCdJT
	ohUNNOIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQA7w-000HXC-2P;
	Wed, 17 Jan 2024 17:55:00 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQA7o-000HUx-0e;
	Wed, 17 Jan 2024 17:54:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A0372616E9;
	Wed, 17 Jan 2024 17:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18862C433C7;
	Wed, 17 Jan 2024 17:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705514091;
	bh=J77FS0Bpoh8nK3y4ULhNSS2rlyTKBjXxlnteilrvwrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WGqGmlE25dqAiZWRrRkWSXIKygA+vpQOQvudOI4smF0yF+9MoHfmQC6PyBFpSWkBk
	 ssQBsIwrkcHj36bazih+ox4UPvJsDWBBoqrvC2nO1FQLqFxRRrSD3aOUfQXqWqyqnl
	 /zgabKW7Dzp1RbLxvTi0UlZcqiRrV6DRYoYe4Fg4yCDru891/7Zz14jA3v25IFJXt/
	 +f1Cjw8QPDdc68I8RiydMsFMZdDk5o+Kg+LyFCj9Oit8z1bJ4a9EsNZTwJcJPKCxV2
	 EQt9YTer5GBiuziU4DiiskqBKqRkDm5xAJPvTFLaCAlyXTHrDUDHQXJOnyL8EKGHq0
	 cK7aTGGHvFV9g==
Date: Wed, 17 Jan 2024 11:54:48 -0600
From: Rob Herring <robh@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org,
	Frank Rowand <frowand.list@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/6] arm64: Unconditionally call unflatten_device_tree()
Message-ID: <20240117175448.GB2779523-robh@kernel.org>
References: <20240112200750.4062441-1-sboyd@kernel.org>
 <20240112200750.4062441-2-sboyd@kernel.org>
 <ZaZtbU9hre3YhZam@FVFF77S0Q05N>
 <434b21afe1899b1567f3617261594842.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <434b21afe1899b1567f3617261594842.sboyd@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_095452_279492_FCC3F45F 
X-CRM114-Status: GOOD (  19.67  )
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

You mean so we don't unflatten the boot DTB, but instead unflatten the 
empty one, right? That sounds fine.

Another thing to check is kexec because it will still need the original 
DTB I think. Though if you are doing ACPI boot and kexec'ing, kexec may 
write out everything needed by the next kernel and the empty DTB would 
work just fine. Of course those users booting with ACPI and then 
kexec'ing to DT boot will be broken. Perhaps that's a feature...

Rob

