Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B934EC636CC
	for <linux-um@archiver.kernel.org>; Mon, 13 Feb 2023 17:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UpnEdao1FYgbZwBuB4yfsRlvxmVy+PmiLNHxV8vjgPI=; b=fEX8UnO7dwudpv
	w4OggoIM2hRTz9s8KwJNSLSnW6FhCfVsL5QW8wCUUqu4JO2gaEy7z4f/Im2tkRBqZJOtMCZQNx9rs
	oLc4PMs7YmKVamkMITaqq3rZzD2x7NhHNMLQkKI5RotNbR4Mn3Dxp5APSmWh/uPhPhpHU7Ym3O59D
	HprSWYM/929T4sgB+bgZBH1AekQy5eoR55+P+gaX3DESKAk5qOgt7+CfOoWs9tOw+ck17Nzup/5ho
	/r8giM7THtfk9SnWqFnMax4hWRS8AH04uuQnfRnOOfENO4PC5ZPFi92GCbSB9vI56alsq0oIZAjH3
	XrvN2J7XUe0Xlk+RMHyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRd2s-00FkkJ-NN; Mon, 13 Feb 2023 17:55:18 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRd2n-00FkfG-FG
	for linux-um@lists.infradead.org; Mon, 13 Feb 2023 17:55:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=U7puvbqVcgnomvSY81yMDf+QEHoaE+NYATxfT1qZ+ro=;
	t=1676310898; x=1677520498; b=bh3KO3VCU9YdSbeqOgJLk9kP5x0iua1a0NKVbZ62AHZYcB8
	brOrGb0KbIjBJ1Nh5442eIMtI2On1TBaKZVJSxIDmVNh1G3qC4wWJnkFfnrO7dAHl16kVNlSOhsL3
	9lLPWknOWlFuB85cNDPAAkYMqrkTehdK1+axXnRmO7digGLE0K9dFh0oS0485ahd1ktJZsz1Vcjz1
	sGrmDDoj6mXcw02rLlKIiR+fd0o66IxIvprjZd7H+7BHkQB+/EvmmCZp53ZBhz4XSlVIzRNuOyj/w
	67ErhNETwTs0zD0Ps9WThUd5oeVYp9k5ZpkWo82T8IXxTfvEpKITd4h3U183KTqw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1pRd2Q-00BHzu-0A;
	Mon, 13 Feb 2023 18:54:50 +0100
Message-ID: <d3f6d627290bb1a6a1fcfdfd5fad915578453e02.camel@sipsolutions.net>
Subject: Re: [PATCH] virt-pci: add platform bus support
From: Johannes Berg <johannes@sipsolutions.net>
To: Vincent Whitchurch <vincent.whitchurch@axis.com>, Richard Weinberger
	 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: robh@kernel.org, devicetree@lists.infradead.org, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@axis.com
Date: Mon, 13 Feb 2023 18:54:49 +0100
In-Reply-To: <20230127-uml-pci-platform-v1-1-ec6b45d2829f@axis.com>
References: <20230127-uml-pci-platform-v1-1-ec6b45d2829f@axis.com>
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230213_095513_557247_CAD82B4E 
X-CRM114-Status: GOOD (  23.61  )
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

On Fri, 2023-01-27 at 15:30 +0100, Vincent Whitchurch wrote:
> This driver registers PCI busses, but the underlying virtio protocol
> could just as easily be used to provide a platform bus instead.  If the
> virtio device node in the devicetree indicates that it's compatible with
> simple-bus, register platform devices instead of handling it as a PCI
> bus.
> 
> Only one platform bus is allowed and the logic MMIO region for the
> platform bus is placed at an arbitrarily-chosen address away from the
> PCI region.

So ... hm. I'm not sure I _like_ this so much. It feels decidedly
strange to put it this way.

But it looks like Richard already applied it, so I suppose look at this
as kind of a retroactive information gathering. :)


> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
> My first approach to getting platform drivers working on UML was by
> adding a minimal PCI-to-platform bridge driver, which worked without
> modifications to virt-pci, but that got shot down:
> 
>  https://lore.kernel.org/lkml/20230120-simple-mfd-pci-v1-1-c46b3d6601ef@axis.com/

Reading through that ... OK that isn't fun either :-)

Sounds like there's a use case for something else though, but the PCI
IDs issue also makes that thorny.

> @@ -48,6 +51,7 @@ struct um_pci_device_reg {
>  
>  static struct pci_host_bridge *bridge;
>  static DEFINE_MUTEX(um_pci_mtx);
> +static struct um_pci_device *um_pci_platform_device;
>  static struct um_pci_device_reg um_pci_devices[MAX_DEVICES];
>  static struct fwnode_handle *um_pci_fwnode;
>  static struct irq_domain *um_pci_inner_domain;
> @@ -480,6 +484,9 @@ static void um_pci_handle_irq_message(struct virtqueue *vq,
>  	struct virtio_device *vdev = vq->vdev;
>  	struct um_pci_device *dev = vdev->priv;
>  
> +	if (!dev->irq)
> +		return;
> 

Does that mean platform devices don't have interrupts, or does that mean
not all of them must have interrupts?

I'll note that this also would allow the device to send an MSI which
feels a bit wrong? But I guess it doesn't really matter.


So let me ask this: Conceptually, wouldn't the "right" way to handle
this be a new virtio device and protocol and everything, with a new
driver to handle it? I realise that would likely lead to quite a bit of
code duplication, for now I just want to understand the concept here a
bit better.

Such a driver would then define its own messages, requiring (I guess)
the equivalents of
 * VIRTIO_PCIDEV_OP_INT,
 * VIRTIO_PCIDEV_OP_MMIO_READ,
 * VIRTIO_PCIDEV_OP_MMIO_WRITE, and
 * (maybe) VIRTIO_PCIDEV_OP_MMIO_MEMSET,

but not
 * VIRTIO_PCIDEV_OP_CFG_READ,
 * VIRTIO_PCIDEV_OP_CFG_WRITE,
 * VIRTIO_PCIDEV_OP_MSI and
 * VIRTIO_PCIDEV_OP_PME,

right?

How much code would we actually duplicate? Most of virt-pci is dedicated
to the mess of PCI MSI domains, bridges, etc.

The limitation to a single device feels odd, and the fact that you have
to put it into DT under the PCI also seems odd. OTOH, the platform
device has to be _somewhere_ right?

I guess I'm not really sure how to use it, but I suppose that's OK too
:)

Thanks,
johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
