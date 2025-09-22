Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BD5CAC5AA
	for <linux-um@archiver.kernel.org>; Mon, 22 Sep 2025 18:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yMn8t+f20gi/0sHsGEn/jlhXaeASyTY3G1FnyjiIJ7k=; b=MsvZXerlwFNOTcHNC7RI8ZdiZq
	m3GJ4KZD/+3JN8mdrNiUFLxZB+fBbsuxN+IV7d4qygW8yaOLESOsUBDCFLGLV8bmoEtMnXRiSVNI2
	ckVPfmtNrMrV7Evl7kjrNe0uoTZPn0Eqx59gMB7I2wI2iLR9JEfeez+ijcKnyz3/ZIdWGkyian/ww
	1vp0d8hy0NzknRI6IlalH9DNoIkFVcCf2p49Wu/OUs5sbNJn/pFsxauBALLa1Y3nTubKHOV7on0BF
	mMKiQaPaIBWfy0mi0y4T3QceWt6hT8pOqRVVx/g8Lq47SsZDtvoTX2m5YUks2oYX3iDNs9vTDxeJj
	Tcwho05g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0l2k-0000000BDzg-0RJ1;
	Mon, 22 Sep 2025 18:13:42 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0l2h-0000000BDyB-3k1f;
	Mon, 22 Sep 2025 18:13:39 +0000
Date: Mon, 22 Sep 2025 11:13:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>, linux-pci@vger.kernel.org,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Sami Tolvanen <samitolvanen@google.com>,
	Richard Weinberger <richard@nod.at>, Wei Liu <wei.liu@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	kunit-dev@googlegroups.com,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH 0/4] PCI: Add support and tests for FIXUP quirks in
 modules
Message-ID: <aNGR0x185VGHxSde@infradead.org>
References: <20250912230208.967129-1-briannorris@chromium.org>
 <aMgZJgU7p57KC0DL@infradead.org>
 <aMhd4REssOE-AlYw@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMhd4REssOE-AlYw@google.com>
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

On Mon, Sep 15, 2025 at 11:41:37AM -0700, Brian Norris wrote:
> I see fixups in controller drivers here:
> 
> drivers/pci/controller/dwc/pci-imx6.c
> drivers/pci/controller/dwc/pci-keystone.c
> drivers/pci/controller/dwc/pcie-qcom.c
> drivers/pci/controller/pci-loongson.c
> drivers/pci/controller/pci-tegra.c
> drivers/pci/controller/pcie-iproc-bcma.c
> drivers/pci/controller/pcie-iproc.c
> 
> Are any of those somehow wrong?

Controller drivers are a special case I guess, but I'd rather still
not open it up to any random driver.  When did we allow modular
controller drivers anyway?  That feels like a somewhat bad idea, too.


