Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B06CAC5AC
	for <linux-um@archiver.kernel.org>; Tue, 23 Sep 2025 16:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hM+wBS6oz+A94GcAbMmM728zYBYkAygS4m8GUSpi98M=; b=Fi49KpJecUMbsXhUA5itMBqOOE
	mQfnVoojQBdpho7pEVxOU2cU9rApyB9RyO1ZI0U8zNZy3RWFbb+llni1LjOCTrRFjfGlW11mQTUmE
	AJ0swa4lM7MASje8bfDghz0+4HUjCIr+5pgNHVilg+Szr2N52jcCuzbhom+eF+2AuBrZCYRYxZ4fk
	rdwY+ahcEUC3UCBgFdNIjbXbjFYfOWNkMR/xr8wuR3lnzCA7pN2zXcBQpPyFgaIWN8a/H9gVvI7Id
	eZqfASfxFVPGdrL1ryH1dQ5c8hHgVThwIzu7Si9uIbirN1YaEqcKOYTGnNHmv6p3+scqHVyLr5ZOX
	E1+mnYUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v15lP-0000000EFMB-1Vlp;
	Tue, 23 Sep 2025 16:21:11 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v15lK-0000000EFJt-27Xt
	for linux-um@lists.infradead.org;
	Tue, 23 Sep 2025 16:21:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7BE3043BE2;
	Tue, 23 Sep 2025 16:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9B7C4CEF5;
	Tue, 23 Sep 2025 16:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758644465;
	bh=qXVz/hDVPsuZNQA18ppIjdhpvEqnsfHeZE0v2amdRuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VK2g3lz9szCECiQtGmt2X/Zi+uw6ZAgz8SmH6kPHKDyIVnmJOTI2XRa49z4z4BAI3
	 H6v6QR2EoLEU0O6RqvzjhdUyGlXsvKjBXaYSotr6EFTSEcJwM2vrt8ymdgyA1sSufx
	 LiXz0qKEgVBoNKR6YOYzky7sUe3LrcWGit4t6bOKGWVsdOM7COl2qdatHm6IRd5Azn
	 4iGmR4y+wimk3HNOsdyC5q/WcfWtd56jwzk+PGefLZuQFZTOyyUf8x341vzzAMtioB
	 vrgpmNS4I7U+5DyKMTPXtFZxMRdNuJs9EJLkTdwUFGP2JWOLr14rRW36xoKwmcrytv
	 vM0HMkfQptj4w==
Date: Tue, 23 Sep 2025 21:50:55 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Brian Norris <briannorris@chromium.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, linux-pci@vger.kernel.org, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	Johannes Berg <johannes@sipsolutions.net>, Sami Tolvanen <samitolvanen@google.com>, 
	Richard Weinberger <richard@nod.at>, Wei Liu <wei.liu@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, kunit-dev@googlegroups.com, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Subject: Re: [PATCH 0/4] PCI: Add support and tests for FIXUP quirks in
 modules
Message-ID: <sb6o4y5ymss3ko73ruwsdgr2dnv2etbg6zq5muaw2vyhlm52bc@zl4uswmomakz>
References: <20250912230208.967129-1-briannorris@chromium.org>
 <aMgZJgU7p57KC0DL@infradead.org>
 <aMhd4REssOE-AlYw@google.com>
 <aNGR0x185VGHxSde@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNGR0x185VGHxSde@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250923_092106_573242_34757F1B 
X-CRM114-Status: GOOD (  12.30  )
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

On Mon, Sep 22, 2025 at 11:13:39AM -0700, Christoph Hellwig wrote:
> On Mon, Sep 15, 2025 at 11:41:37AM -0700, Brian Norris wrote:
> > I see fixups in controller drivers here:
> > 
> > drivers/pci/controller/dwc/pci-imx6.c
> > drivers/pci/controller/dwc/pci-keystone.c
> > drivers/pci/controller/dwc/pcie-qcom.c
> > drivers/pci/controller/pci-loongson.c
> > drivers/pci/controller/pci-tegra.c
> > drivers/pci/controller/pcie-iproc-bcma.c
> > drivers/pci/controller/pcie-iproc.c
> > 
> > Are any of those somehow wrong?
> 
> When did we allow modular
> controller drivers anyway?  That feels like a somewhat bad idea, too.
> 

Why not? We currently only restrict the controller drivers implementing the
irqchip controller from being *removed* because of the IRQ disposal concern.
Other than that, I don't see why kernel should restrict building them as
modules.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

