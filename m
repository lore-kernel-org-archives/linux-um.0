Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D71BC4707B
	for <linux-um@archiver.kernel.org>; Thu, 18 Jan 2024 15:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mUNsFenW2kQSpQ9qdN8ct6BhVd3x1bbOo8FyxyRW/LU=; b=dn5qyDoaLWdjBz0vZfn1Q9AJoz
	7pJ2/K7qkQzHX1Zj0fVPXkSLlRs4mYqRFsYK3yc9iMeLVdYMfpURXiJeHz5MHZeX1JZFlZkZFEqI7
	5vcsGAYjs1WpY3USxCUr6tcRalrq0KWEmPeKpBxwTdi10fjFKaBaYalErIXmBZCRn6pGQCLfTODLG
	wBBxAj2ya+a2J9CLfv3gXHTQDcAP9VTZtqqB4xZEq8Emrsatf5phw3fZOZOwOS2y9cH0Wag50Jkxl
	UZTchyCeXYh6eU7orTRO5poscZz6wPOm1gYOXxsZeANFS5Uc5zTbRv7PHkSBWOYR+d1y2FMaZ/7Oi
	fR2IB3nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQUFA-0035IB-0a;
	Thu, 18 Jan 2024 15:23:48 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQUF6-0035Gb-0Q;
	Thu, 18 Jan 2024 15:23:45 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42C441042;
	Thu, 18 Jan 2024 07:24:25 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.28.174])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF5303F73F;
	Thu, 18 Jan 2024 07:23:35 -0800 (PST)
Date: Thu, 18 Jan 2024 15:23:30 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/6] arm64: Unconditionally call unflatten_device_tree()
Message-ID: <ZalCcivD0vXpQfr9@FVFF77S0Q05N.cambridge.arm.com>
References: <20240112200750.4062441-1-sboyd@kernel.org>
 <20240112200750.4062441-2-sboyd@kernel.org>
 <ZaZtbU9hre3YhZam@FVFF77S0Q05N>
 <CAMuHMdU0qtMeX=7SY+32=30-QGMRniFVCCm217REJ1X+ZNJ=Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdU0qtMeX=7SY+32=30-QGMRniFVCCm217REJ1X+ZNJ=Aw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240118_072344_309756_5166CCFF 
X-CRM114-Status: GOOD (  16.02  )
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

On Tue, Jan 16, 2024 at 03:13:42PM +0100, Geert Uytterhoeven wrote:
> Hi Mark,
> 
> On Tue, Jan 16, 2024 at 12:51 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > On Fri, Jan 12, 2024 at 12:07:44PM -0800, Stephen Boyd wrote:
> > > Call this function unconditionally so that we can populate an empty DTB
> > > on platforms that don't boot with a firmware provided or builtin DTB.
> > > There's no harm in calling unflatten_device_tree() unconditionally.
> >
> > For better or worse, that's not true: there are systems the provide both a DTB
> > *and* ACPI tables, and we must not consume both at the same time as those can
> > clash and cause all sorts of problems. In addition, we don't want people being
> > "clever" and describing disparate portions of their system in ACPI and DT.
> 
> We'd get to the latter anyway, when plugging in a USB device where the
> circuitry on/behind the USB device is described in DT.

I don't understand what you mean there; where is the DT description of the USB
device coming from if the DTB hasn't been unflattened?

Mark.

