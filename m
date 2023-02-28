Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B142C64ED6
	for <linux-um@archiver.kernel.org>; Tue, 28 Feb 2023 17:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pTHqU8z8+blMMbkQRagu2AvCUHEbVXKy+3/P5D9IZBw=; b=AuBwnKH25lmHC4
	zXZlJvqgxT0W7vHhckhdKTBZjvFTXTW3gUe9uAgbXbU8bq1xuUX8mo9McLTiOBITixJhAnihdYyKF
	e01WL+vVSWMpeHQOZSxIuyuftQJYVCCJkxiLTMHk0i0Az9lBGKdTdPMj1RG87Mo6RNNcUwZErtUqu
	JS8DpgxR6Ls+Fqs39Ks1/rwl2N/qvUlSKm7mKdxh3MWAW3/GBOIVTpSEnNVko9AEd9TiRDvi5kwRT
	vLEfeuOeIppphiF2DCyAvqOATvwoIBW5GfQ+yDafOlUvnY3FaDi24WCVILzLdDK8BVgkGfDfZfuRO
	OODAAgOIjq+oaJPaN4pA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pX3xD-00DuBJ-3H; Tue, 28 Feb 2023 17:39:55 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pX3x8-00Du7p-ET
	for linux-um@lists.infradead.org; Tue, 28 Feb 2023 17:39:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1kOgwoHUpeZnKGhyoamiE8rEFrDmo1RwpX9g7ay49uU=;
	t=1677605985; x=1678815585; b=cCmiGe9pC+0QxBMV8O5+1yLoXyshVDHxfXV5sB0fBfkeYMc
	TSfNpIwng6soJDF+9Zau1b/sWWNmMrsE8iUtNpGlMSb6C4AthHPbWzrZalFnamk/XNyy67jhwWKtz
	2ECTWdnpStk/3GxAGp7nM4wrtlqCU5ZqwO2VpufIfpjbZ3WSnDzILrJbKqBvuSaxSgjRp9qXjiZdk
	2UfEXjbkqGTkS7IGQqrDYOhMX+6knTPLaY5UeVXm/2rWxD4G1a+MN9kd6JJVk0xo7U8eHRzuhd796
	JHh0GQKjcmJ/35A9+NI8vfTwl5zEv0ceUqkilZCBisUpCP478F0qI/oJGrMYmSYg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1pX3wt-00845w-0N;
	Tue, 28 Feb 2023 18:39:35 +0100
Message-ID: <699d35cd36f3d77c112a6aa8705b043efaa63711.camel@sipsolutions.net>
Subject: Re: [PATCH] virt-pci: add platform bus support
From: Johannes Berg <johannes@sipsolutions.net>
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov
	 <anton.ivanov@cambridgegreys.com>, "robh@kernel.org" <robh@kernel.org>, 
	devicetree@vger.kernel.org, "linux-um@lists.infradead.org"
	 <linux-um@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, kernel <kernel@axis.com>
Date: Tue, 28 Feb 2023 18:39:34 +0100
In-Reply-To: <Y+t6qXBxLqf/+eQM@axis.com>
References: <20230127-uml-pci-platform-v1-1-ec6b45d2829f@axis.com>
	 <d3f6d627290bb1a6a1fcfdfd5fad915578453e02.camel@sipsolutions.net>
	 <Y+t6qXBxLqf/+eQM@axis.com>
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230228_093950_507103_36132728 
X-CRM114-Status: GOOD (  33.30  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Tue, 2023-02-14 at 13:12 +0100, Vincent Whitchurch wrote:
> 
> Yes, Greg was initially totally opposed to the idea of putting platform
> devices under PCI devices, but in his latest email he seemed to
> allow it in some cases.  It's still unclear if he'd be OK with a
> "virtual PCI-to-platform bridge" though.  And yes, adding platform
> devices support like in this patch removes one layer and also eliminates
> the disadvantage of having to wait for user space to specify a PCI ID
> for the bridge device.

Right.

> > > +	if (!dev->irq)
> > > +		return;
> > > 
> > 
> > Does that mean platform devices don't have interrupts, or does that mean
> > not all of them must have interrupts?
> 
> They don't have interrupts via this driver.  There isn't any standard
> way for platform devices to handle interrupts since it it all depends on
> what interrupt-parent is specified in the devicetree and how that is
> implemented.

Ah, OK.

> > I'll note that this also would allow the device to send an MSI which
> > feels a bit wrong? But I guess it doesn't really matter.
> 
> We could avoid setting up the IRQ/MSI virtqueue when we know we're
> dealing with platform devices.

Not sure it matters then?

> > So let me ask this: Conceptually, wouldn't the "right" way to handle
> > this be a new virtio device and protocol and everything, with a new
> > driver to handle it? I realise that would likely lead to quite a bit of
> > code duplication, for now I just want to understand the concept here a
> > bit better.
> 
> Yes, that could be a way to do it.  Or there could perhaps be some
> feature bits indicating that only MMIO read/write/memset are allowed.

Right.

> > How much code would we actually duplicate? Most of virt-pci is dedicated
> > to the mess of PCI MSI domains, bridges, etc.
> 
> Probably not a huge amount, I can try to cook up a patch if you'd like.
> But, besides the code duplication, I'm not sure if adding another new
> virtio driver without a specification would be OK?

Yeah ... let's not worry. Was mostly trying to understand it better.

I'm not really bothered by it :)

> > The limitation to a single device feels odd, and the fact that you have
> 
> The limitation to a single device here is not a problem since one can
> use simple-bus to instantiate any number of platform devices via the
> devicetree.  The devicetree at the end of this email shows how that
> looks like.

OK cool.

> With a devicetree like the one below, using it shouldn't be all that
> different from using the normal virt-pci except that the register ranges
> and IRQ information are in the devicetree rather than coming via the
> config space implementation in the virtio device.

Makes sense.

Thanks for all the answers & examples! Let's just leave it as is then :)

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
