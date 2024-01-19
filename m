Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94560C4725D
	for <linux-um@archiver.kernel.org>; Fri, 19 Jan 2024 23:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9IV/ZmeBzcGbXtPhwhP5/GxqE1BHMbmaPE0pVB1IAhg=; b=ebyPudgdNyFlDSI/9HTynK9PuU
	5LlczWwBHX60goo+FwJJCMgvhMhwCaoxDviJPmA0pT5Lt20E3ntXgM4nmMi4elGWwylT+qM63YrT/
	rXKUzeZUzFBi/gtWfwLWwZX7pq4rItd6kCRRJab6/8I8m3kKKqAaWjGgYDNP6TzqpRzRvtLmqDcUA
	jIFctWQV2R9a6p8z9l+cMw3+SyLYU4Ns3YS7zVVN+RRd7/1aL9koGqed2LkaT/ef4EyU76mjeAPvu
	wefQDdHmsVEbUfFbhuIGT6Vfqp9JKeGeyUJkl0l6nQWhZVejH5ThqWkMBgx2AT837qQ4EpcCZJVry
	uJLvvtsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQy0b-006rNc-2I;
	Fri, 19 Jan 2024 23:10:45 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQy0X-006rMG-1c;
	Fri, 19 Jan 2024 23:10:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 09918B81BA9;
	Fri, 19 Jan 2024 23:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A2AC433F1;
	Fri, 19 Jan 2024 23:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705705839;
	bh=hLvySJOGh3H9r6ZYVIGvpuQ7Zcb/pUmD6s9QAjLdlmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H7as3jphr/I/+VOFoHA/dDZFNvfVfRn2PMpnFrkReodXeioRG9Q1/QXBCBYASb4Oh
	 ASbADsHm7oaSU2U8sAMhRBhkG1hZzvwQLNVmdFti9FJEuofwnUhUb1KV18Nrt9Eo4E
	 TTOIGmp3+6Ay5A/JwyUwsD1pMfNyffItFyqA3IoYaf6vSrpX2up4Hfxbq9G4SIXDPy
	 iA8+yMQzQg/IsjvDXpCCcl9D700BjuCgPyeOSSZXqKfNx/+ZsuVYlIxCDjwJ7Wdm3W
	 eNbnDH33gPh8XnnEaFCuJTEF6hh+z9MgoRmk1zEqsj7S5X2/Oc7tCh+Xueumv6IL0T
	 5gFqj7oSlYXhA==
Date: Fri, 19 Jan 2024 17:10:36 -0600
From: Rob Herring <robh@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org,
	Frank Rowand <frowand.list@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/6] arm64: Unconditionally call unflatten_device_tree()
Message-ID: <20240119231036.GA1247053-robh@kernel.org>
References: <20240112200750.4062441-1-sboyd@kernel.org>
 <20240112200750.4062441-2-sboyd@kernel.org>
 <ZaZtbU9hre3YhZam@FVFF77S0Q05N>
 <434b21afe1899b1567f3617261594842.sboyd@kernel.org>
 <ZalDM90KoQ2Il0j7@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZalDM90KoQ2Il0j7@FVFF77S0Q05N.cambridge.arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240119_151041_678743_97CBF9C8 
X-CRM114-Status: GOOD (  25.00  )
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

On Thu, Jan 18, 2024 at 03:26:43PM +0000, Mark Rutland wrote:
> On Tue, Jan 16, 2024 at 05:27:18PM -0800, Stephen Boyd wrote:
> > Quoting Mark Rutland (2024-01-16 03:51:14)
> > > Hi Stephen,
> > > 
> > > On Fri, Jan 12, 2024 at 12:07:44PM -0800, Stephen Boyd wrote:
> > > > Call this function unconditionally so that we can populate an empty DTB
> > > > on platforms that don't boot with a firmware provided or builtin DTB.
> > > > There's no harm in calling unflatten_device_tree() unconditionally.
> > > 
> > > For better or worse, that's not true: there are systems the provide both a DTB
> > > *and* ACPI tables, and we must not consume both at the same time as those can
> > > clash and cause all sorts of problems. In addition, we don't want people being
> > > "clever" and describing disparate portions of their system in ACPI and DT.
> > > 
> > > It is a very deliberate choice to not unflatten the DTB when ACPI is in use,
> > > and I don't think we want to reopen this can of worms.
> > 
> > Hmm ok. I missed this part. Can we knock out the initial_boot_params in
> > this case so that we don't unflatten a DTB when ACPI is in use?
> 
> Why is that better than just not calling unflatten_device_tree(), as we do
> today?
> 
> The cover letter says this is all so that we can run DT tests for the clk
> framework; why can't that just depend on the system being booted with DT rather
> than ACPI? 

Because then the tests can never run on x86 and some people still use 
those systems. It's no different than why do we compile !x86 drivers on 
x86. It is convenient.

> We have other tests which are architecture and/or configuration
> dependent...

There's another usecase of non-discoverable devices behind discoverable 
devices. See my LPC session slides for more details. For this we will 
need some base DT to apply overlays to on DT AND ACPI systems. This is 
what Geert was getting at. Yes, it could be done with some other code 
path, but the DT unittest has done that hack for years and this series 
is getting rid of it.

Rob

