Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E276CC61DA4
	for <linux-um@archiver.kernel.org>; Tue, 14 Feb 2023 12:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2Hm9Z5tfjgrqtciyR3pcxL01i5HOk7J1rarNy2ov4x4=; b=nWkMWckSO3kL3o
	Jg/Q8XKwDvpd56mrmT8XuSPw82GZHpZFf16xLC0IBvdoSpw/BDq+y5oYpilGJWn/fA74CFY81j3+7
	4EbWBDXFurrhv4fy2uL2iWStp2WTgtcBjxiIxjxOq83T/0t5MXaUGFXZbXf5oGJP4zcdIZmtzuj2V
	p1WBLxhUo2cHf5PmcqmMrpn58ELvkFmBTEpwezvdBn4HvM2qlCuxCBsEbekkaa54Wwan9ALnq+0M/
	CeQeU7GvWylVPViRuBaO06weLTKjF8UODcZHNtmVBKxfPgyOFtKXYor+hAXoEBPP+H0SnFQqJohon
	gXdnMCzLbRTkniWBVJJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRuAo-001X2Q-3i; Tue, 14 Feb 2023 12:12:38 +0000
Received: from smtp1.axis.com ([195.60.68.17])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRuAk-001X0M-IO
	for linux-um@lists.infradead.org; Tue, 14 Feb 2023 12:12:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1676376754;
  x=1707912754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LW+fYZVBMkIdds32xQMOF1cT/AnskpifFhDC6xuX7MA=;
  b=AsVR4LBQH+Ne3l7z0dnRQcN3mZZRzBEDxeLiJ86b+bWG2pAh0YQh9BGT
   sMpc8l5LNh4gYE1aF7829qSgMW+XHCVtZC/qhkI1whEtAPGDrc9x881KJ
   Rsqmc8yAC1eDtkSYrx6URMADwBQW5nAfIAOHvbUPAYCTHfPswRQqT8gxI
   R/Ds/v4X8nl21SuEmuIzlelpMPd1++XFaxhrzKR9PTxW+n5XliYWs9mef
   gJ2w5PpCynqc7YBThtjWmypSqPQXQ2pBZu9oFdCypssOBoWvkg9kgVlxI
   bvFWAQoXuoC4P4L36pti0MvH37fMqxhbp84U/oQodKAH93HPA3VoZo/bq
   Q==;
Date: Tue, 14 Feb 2023 13:12:25 +0100
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: Richard Weinberger <richard@nod.at>, Anton Ivanov
	<anton.ivanov@cambridgegreys.com>, "robh@kernel.org" <robh@kernel.org>,
	<devicetree@vger.kernel.org>, "linux-um@lists.infradead.org"
	<linux-um@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, kernel <kernel@axis.com>
Subject: Re: [PATCH] virt-pci: add platform bus support
Message-ID: <Y+t6qXBxLqf/+eQM@axis.com>
References: <20230127-uml-pci-platform-v1-1-ec6b45d2829f@axis.com>
 <d3f6d627290bb1a6a1fcfdfd5fad915578453e02.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d3f6d627290bb1a6a1fcfdfd5fad915578453e02.camel@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230214_041234_953712_461ACDF2 
X-CRM114-Status: GOOD (  41.48  )
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

On Mon, Feb 13, 2023 at 06:54:49PM +0100, Johannes Berg wrote:
> On Fri, 2023-01-27 at 15:30 +0100, Vincent Whitchurch wrote:
> > My first approach to getting platform drivers working on UML was by
> > adding a minimal PCI-to-platform bridge driver, which worked without
> > modifications to virt-pci, but that got shot down:
> > 
> >  https://lore.kernel.org/lkml/20230120-simple-mfd-pci-v1-1-c46b3d6601ef@axis.com/
> 
> Reading through that ... OK that isn't fun either :-)
> 
> Sounds like there's a use case for something else though, but the PCI
> IDs issue also makes that thorny.

Yes, Greg was initially totally opposed to the idea of putting platform
devices under PCI devices, but in his latest email he seemed to
allow it in some cases.  It's still unclear if he'd be OK with a
"virtual PCI-to-platform bridge" though.  And yes, adding platform
devices support like in this patch removes one layer and also eliminates
the disadvantage of having to wait for user space to specify a PCI ID
for the bridge device.

> > @@ -48,6 +51,7 @@ struct um_pci_device_reg {
> >  
> >  static struct pci_host_bridge *bridge;
> >  static DEFINE_MUTEX(um_pci_mtx);
> > +static struct um_pci_device *um_pci_platform_device;
> >  static struct um_pci_device_reg um_pci_devices[MAX_DEVICES];
> >  static struct fwnode_handle *um_pci_fwnode;
> >  static struct irq_domain *um_pci_inner_domain;
> > @@ -480,6 +484,9 @@ static void um_pci_handle_irq_message(struct virtqueue *vq,
> >  	struct virtio_device *vdev = vq->vdev;
> >  	struct um_pci_device *dev = vdev->priv;
> >  
> > +	if (!dev->irq)
> > +		return;
> > 
> 
> Does that mean platform devices don't have interrupts, or does that mean
> not all of them must have interrupts?

They don't have interrupts via this driver.  There isn't any standard
way for platform devices to handle interrupts since it it all depends on
what interrupt-parent is specified in the devicetree and how that is
implemented.

In my case, I have a separate virtio-gpio and use that as the
interrupt-parent like in the devicetree at the end of this email.  I
actually also did that when I used the platform-on-PCI solution since I
already use virtio-gpio as the interrupt controller for devices on other
busses like I2C and SPI and just reusing that was easier than
implementing MSI support in my virt-pci device.

> I'll note that this also would allow the device to send an MSI which
> feels a bit wrong? But I guess it doesn't really matter.

We could avoid setting up the IRQ/MSI virtqueue when we know we're
dealing with platform devices.

> So let me ask this: Conceptually, wouldn't the "right" way to handle
> this be a new virtio device and protocol and everything, with a new
> driver to handle it? I realise that would likely lead to quite a bit of
> code duplication, for now I just want to understand the concept here a
> bit better.

Yes, that could be a way to do it.  Or there could perhaps be some
feature bits indicating that only MMIO read/write/memset are allowed.

> Such a driver would then define its own messages, requiring (I guess)
> the equivalents of
>  * VIRTIO_PCIDEV_OP_INT,
>  * VIRTIO_PCIDEV_OP_MMIO_READ,
>  * VIRTIO_PCIDEV_OP_MMIO_WRITE, and
>  * (maybe) VIRTIO_PCIDEV_OP_MMIO_MEMSET,
> 
> but not
>  * VIRTIO_PCIDEV_OP_CFG_READ,
>  * VIRTIO_PCIDEV_OP_CFG_WRITE,
>  * VIRTIO_PCIDEV_OP_MSI and
>  * VIRTIO_PCIDEV_OP_PME,
> 
> right?

Yes, just the MMIO* stuff would be enough.

> How much code would we actually duplicate? Most of virt-pci is dedicated
> to the mess of PCI MSI domains, bridges, etc.

Probably not a huge amount, I can try to cook up a patch if you'd like.
But, besides the code duplication, I'm not sure if adding another new
virtio driver without a specification would be OK?

> The limitation to a single device feels odd, and the fact that you have

The limitation to a single device here is not a problem since one can
use simple-bus to instantiate any number of platform devices via the
devicetree.  The devicetree at the end of this email shows how that
looks like.

> to put it into DT under the PCI also seems odd. OTOH, the platform
> device has to be _somewhere_ right?

With this patch, it's not put under PCI in the devicetree, see the
example below.

> I guess I'm not really sure how to use it, but I suppose that's OK too
> :)

With a devicetree like the one below, using it shouldn't be all that
different from using the normal virt-pci except that the register ranges
and IRQ information are in the devicetree rather than coming via the
config space implementation in the virtio device.

With everything hooked up and with the backend code I have in roadtest,
this allows tests like this one which exercises some SoC's DMA
controller (the simplest one I could find in the tree):
 https://github.com/vwax/linux/commit/337e03bb3c1796c96ab8f397ff36e9b543f2c6d5

Here's the devicetree example I mentioned above:

 / {
     #address-cells = <2>;
     #size-cells = <2>;
 
     virtio@0 {
         compatible = "virtio,uml";
         socket-path = ".roadtest/roadtest-work/0/gpio.sock";
         virtio-device-id = <0x29>;
 
         gpio: gpio {
             compatible = "virtio,device29";
 
             gpio-controller;
             #gpio-cells = <2>;
 
             interrupt-controller;
             #interrupt-cells = <2>;
         };
     };
 
     virtio@2 {
         compatible = "virtio,uml";
         socket-path = ".roadtest/roadtest-work/0/platform.sock";
         virtio-device-id = <1234>;
         ranges;
 
         platform: bus@0,0 {
                 compatible = "virtio,device4d2", "simple-bus";
                 reg = <0x00000 0x10000000 0x0 0x10000>;
                 interrupt-parent = <&gpio>;
		 // Could use range translation here to avoid absolute
		 // addresses in reg properties
                 ranges;
         };
     };
 
 };
 
 &platform {
     foo@10001000 {
             compatible = "some-platform-device-complatible";
             reg = <0x00000 0x10001000 0 0x1000>;
             interrupts = <2 4>;
     };

     bar@10002000 {
             compatible = "another-platform-device-complatible";
             reg = <0x00000 0x10002000 0 0x1000>;
             interrupts = <3 4>;
     };
 };


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
