Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48373C47DD9
	for <linux-um@archiver.kernel.org>; Wed, 28 Feb 2024 16:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V35t155KJsXeAGQVFrEgyTw7rGfHkctx2V/RiFf+sHI=; b=KFP8wSZu03y7k/kH8dV3ekvnIR
	JNjsF3auGZxH/tQIty8BJV8q2gMtc/j/c271kGIVDQF5aw0UoAEQK2HVmtIwn24sdZzp4oSQq12uj
	BkPKvvFNtZZ6J6dhUQqq6JTuMKQMMvPZzZcZTXujo0+89f4pqZ8LNymRdUGWi4oO53b3NvMFzfIPj
	GypNZFA1ZfrIuygW9F9PpW159PSjpfpARAShqLuqIMa6lE280IbN9oqPxmJHf9fIyrTVmPvUkG8iJ
	o/FT8yqoplgrAUNvBeW4/IjJiizX6lwcZu+hXavruSSsczXvyMGfvp3IeQbAyumWr2dyfCsdrzuzM
	sScJIZ+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfMlm-0000000A7DX-1Weg;
	Wed, 28 Feb 2024 16:26:58 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfMli-0000000A7B5-0rCx;
	Wed, 28 Feb 2024 16:26:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id F39A7CE2279;
	Wed, 28 Feb 2024 16:26:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155E1C433C7;
	Wed, 28 Feb 2024 16:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709137610;
	bh=1mSJiKFveQIcxWUIOdkvzQ2W+3D7jbH1bL69Ehdc/yY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oVqn6QUEeQbM2a4tYvbqKYOaLr8t7uOwvVSd3bqV+lsvDt9tkYSR8xnsdKr+lOCiU
	 CZOf9vQt2KEnN4bveiKcvGMJTXjxm2PhqkAsnz5WypOWq7OwnrpyTX58fEfNwX7J8l
	 eG9bQXiTQ1jwb0FPIjcsrBj+coy8kR3/3ZL5mtHjIuspJ8SlbH949BMqZudWeekl23
	 1jKX3aYwVPEcGT4aXxac6TXOf2h+HJSnkv4I388UUZPlt+TAiDSx4mPJorTFR+6tKd
	 3B8oABI8qB8/gfrybDKR/LttigggdNps8lLOUx5kQwegY6B5PBenGShBGh26yMAG/4
	 dax5em0LZHBrA==
Date: Wed, 28 Feb 2024 10:26:47 -0600
From: Rob Herring <robh@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v4 5/7] arm64: Unconditionally call
 unflatten_device_tree()
Message-ID: <20240228162647.GA4086865-robh@kernel.org>
References: <20240217010557.2381548-1-sboyd@kernel.org>
 <20240217010557.2381548-6-sboyd@kernel.org>
 <20240223000317.GA3835346-robh@kernel.org>
 <20240223102345.GA10274@willie-the-truck>
 <CAL_JsqJSeSHeWV3YJE9n2NuY+s_iE6f7N5C_oguEJn7jTZ20xA@mail.gmail.com>
 <Zd4dQpHO7em1ji67@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zd4dQpHO7em1ji67@FVFF77S0Q05N.cambridge.arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240228_082654_732555_6AD8D552 
X-CRM114-Status: GOOD (  33.71  )
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

On Tue, Feb 27, 2024 at 05:34:58PM +0000, Mark Rutland wrote:
> On Fri, Feb 23, 2024 at 11:17:02AM -0700, Rob Herring wrote:
> > On Fri, Feb 23, 2024 at 3:23 AM Will Deacon <will@kernel.org> wrote:
> > >
> > > On Thu, Feb 22, 2024 at 05:03:17PM -0700, Rob Herring wrote:
> > > > On Fri, Feb 16, 2024 at 05:05:54PM -0800, Stephen Boyd wrote:
> > > > > Call this function unconditionally so that we can populate an empty DTB
> > > > > on platforms that don't boot with a firmware provided or builtin DTB.
> > > > > When ACPI is in use, unflatten_device_tree() ignores the
> > > > > 'initial_boot_params' pointer so the live DT on those systems won't be
> > > > > whatever that's pointing to. Similarly, when kexec copies the DT data
> > > > > the previous kernel to the new one on ACPI systems,
> > > > > of_kexec_alloc_and_setup_fdt() will ignore the live DT (the empty root
> > > > > one) and copy the 'initial_boot_params' data.
> > > > >
> > > > > Cc: Rob Herring <robh+dt@kernel.org>
> > > > > Cc: Frank Rowand <frowand.list@gmail.com>
> > > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > > Cc: Will Deacon <will@kernel.org>
> > > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > > Cc: <linux-arm-kernel@lists.infradead.org>
> > > > > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > > > > ---
> > > > >  arch/arm64/kernel/setup.c | 3 +--
> > > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > >
> > > > Catalin, Will, Can I get an ack on this so I can take the series via the
> > > > DT tree.
> > >
> > > Mark had strong pretty strong objections to this in version one:
> > 
> > Yes, I had concerns with it as well.
> > 
> > > https://lore.kernel.org/all/ZaZtbU9hre3YhZam@FVFF77S0Q05N/
> > >
> > > and this patch looks the same now as it did then. Did something else
> > > change?
> > 
> > Yes, that version unflattened the bootloader passed DT. Now within
> > unflatten_devicetree(), the bootloader DT is ignored if ACPI is
> > enabled and we unflatten an empty tree. That will prevent the kernel
> > getting 2 h/w descriptions if/when a platform does such a thing. Also,
> > kexec still uses the bootloader provided DT as before.
> 
> That avoids the main instance of my concern, and means that this'll boot
> without issue, but IIUC this opens the door to dynamically instantiating DT
> devices atop an ACPI base system, which I think in general is something that's
> liable to cause more problems than it solves.
> 
> I understand that's desireable for the selftests, though I still don't believe
> it's strictly necessary -- there are plenty of other things that only work if
> the kernel is booted in a specific configuration.

Why add to the test matrix if we don't have to?

> Putting the selftests aside, why do we need to do this? Is there any other
> reason to enable this?

See my Plumbers talk...

Or in short, there's 3 main usecases:

- PCI FPGA card with devices instantiated in it 
- SoCs which expose their peripherals via a PCI endpoint.
- Injecting test devices with QEMU (testing, but not what this series 
  does. Jonathan Cameron's usecase)

In all cases, drivers already exist for the devices, and they often only 
support DT. DT overlays is the natural solution for this, and there's 
now kernel support for it (dynamically generating PCI DT nodes when they 
don't exist). The intent is to do the same thing on ACPI systems.

I don't see another solution other than 'go away, you're crazy'. There's 
ACPI overlays, but that's only a debug feature. Also, that would 
encourage more of the DT bindings in ACPI which I find worse than this 
mixture. There's swnodes, but that's just board files and platform_data 
2.0.

I share the concerns with mixing, but I don't see a better solution. The 
scope of what's possible is contained enough to avoid issues.

Rob

