Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7BCC4828F
	for <linux-um@archiver.kernel.org>; Fri,  2 Feb 2024 16:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3pDdkTGuClKWnFIHrS9QZ6TRzprmpBoRtjJRbCpiteU=; b=RD/toc3U5rVs7yw8CKuHY6BtRO
	vfW07mtWwdvH7razXoQielWpFB+LqYYx+g1Km7cPBIscYPd2Pej+o7c+CSnBhHrCAa5KTma8wSK0f
	f4EPJb4FCKlXIuQMC3QJNg1zKzMJRp3nAlIIFX5rui33R4NMkVkdorKdUQ6HBjx+YkJk/2hNdYc1P
	M3iSTom1U01ctc9NTXfu7+24u3SJ7Jh96oeGI1QcWX2GVSEI0SW+PBcigyWz5aw3MKmcDT72v6SnS
	cwHXBOJIBytAGroreUtR40R9iGBW02liWZFR0N48fS289UMZRmNyx52TjOjmKrBeY2qOYQTNtAn5J
	OtMe1X3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVwQj-0000000CJHf-1oCy;
	Fri, 02 Feb 2024 16:30:17 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVwQe-0000000CJEh-3uWR;
	Fri, 02 Feb 2024 16:30:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id E4432CE2C25;
	Fri,  2 Feb 2024 16:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38DBC433F1;
	Fri,  2 Feb 2024 16:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706891409;
	bh=BWx5zc/9MunoZpEToFg41sUYEu6SA2ONTzdVIp4DFg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nD0wNsNjQI1fhiecntkw5a6Fp7hmW0qtJo1/A0aveYZgSTrwHYLmWnGWv4zOeLtTK
	 60PWwFzI7mkJ62Phn1vBRCDQ5aXOdukBrtWjUX/yjlzD6/h+IoreEoHhpR3lMCK08M
	 Ds+ATzgYHo3pBJ7m1dTef9ZuBxRZNNAy75WdYfHVkyQ2ZHydivsNZZBMpq876kE6KI
	 YKYSk4ZCHcGjR0Jzh0mqhawazabqc6drmLCcUcuqbWGReBDSLhwO6gLlBQfaS+oQt5
	 tWBoUCu/mXaVJkQWGlPe1UxcwwvY30RVROsfMuipUMmbowBNPSZjGJ7Rafrt/6H7KA
	 AJNSq2ugYDc+w==
Date: Fri, 2 Feb 2024 10:30:06 -0600
From: Rob Herring <robh@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/7] arm64: Unconditionally call
 unflatten_device_tree()
Message-ID: <20240202163006.GA209874-robh@kernel.org>
References: <20240130004508.1700335-1-sboyd@kernel.org>
 <20240130004508.1700335-2-sboyd@kernel.org>
 <20240131205405.GA2249327-robh@kernel.org>
 <efe6a7886c3491cc9c225a903efa2b1e.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efe6a7886c3491cc9c225a903efa2b1e.sboyd@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240202_083013_464619_A9ACE846 
X-CRM114-Status: GOOD (  32.60  )
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

On Wed, Jan 31, 2024 at 02:59:53PM -0800, Stephen Boyd wrote:
> Quoting Rob Herring (2024-01-31 12:54:05)
> > On Mon, Jan 29, 2024 at 04:45:00PM -0800, Stephen Boyd wrote:
> > > Call this function unconditionally so that we can populate an empty DTB
> > > on platforms that don't boot with a firmware provided or builtin DTB.
> > > Override 'initial_boot_params' to NULL when ACPI is in use but the
> > > bootloader has loaded a DTB so that we don't allow both ACPI and DT to
> > > be used during boot. If there isn't a valid initial_boot_params dtb then
> > > unflatten_device_tree() returns early so this is fine.
> > > 
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Frank Rowand <frowand.list@gmail.com>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: <linux-arm-kernel@lists.infradead.org>
> > > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > > ---
> > >  arch/arm64/kernel/setup.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > > index 417a8a86b2db..ffb1942724ae 100644
> > > --- a/arch/arm64/kernel/setup.c
> > > +++ b/arch/arm64/kernel/setup.c
> > > @@ -351,8 +351,11 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
> > >       /* Parse the ACPI tables for possible boot-time configuration */
> > >       acpi_boot_table_init();
> > >  
> > > -     if (acpi_disabled)
> > > -             unflatten_device_tree();
> > > +     /* Don't use the FDT from boot if ACPI is in use */
> > > +     if (!acpi_disabled)
> > > +             initial_boot_params = NULL;
> > 
> > I still think this is a problem for kexec. See 
> > of_kexec_alloc_and_setup_fdt(). You see it uses initial_boot_params. At 
> > first glance it looks like it would just write out everything we need. 
> > But for UEFI boot, I think we need all the chosen properties like 
> > linux,uefi-mmap-start preserved from the current boot for the next 
> > kernel we kexec.
> 
> Ok, got it.
> 
> > 
> > I think you'll have to check acpi_disabled in unflatten_device_tree() 
> > and unflatten the empty tree leaving initial_boot_params alone. That 
> > means our FDT and unflattened tree will be different DTs, but I think 
> > that's fine.
> 
> It's sort of scary given that 'initial_boot_params' is an exported
> global. Maybe that should be hidden away and accessed with a function
> instead so that this mismatch doesn't break something later on?

What you see now is after I did a pass of minimizing the number of 
users.

BTW, I've now got another use for unconditionally calling 
unflatten_device_tree() with this[1].

Rob

[1] https://lore.kernel.org/all/20240201194653.GA1328565-robh@kernel.org/

