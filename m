Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A05C35FFF
	for <linux-um@archiver.kernel.org>; Thu, 20 Mar 2025 15:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DdzfMRcvr3gESf8MnQ0ywcAx5a09FhJXwmQvAmSNmZo=; b=Qgy2Y3Gherx0M+oJe9AwZCjB+r
	PjM+ztYDYRMPz71do1bKUKLqlulKyM8EsJLSOd64Nc67OLkuUiVCmBQHjFeFDb/D1jFsMlqesAy9q
	rmKOiMLMM4SECNhB+Qer1TL756sSrcu9QKEbc9HYENrY1Odb6uJ6n5SEQ8UJbqmsXScQG6bmMzWGU
	DKe6JmVD9D4SnkGhK3aYAmFr319y2fqA3JgcpoeflSOUyD/dS7YK6XfTRTmSXuRhSGlMyPHI3EaCo
	v96ymZ6fwm1NYizWIGcHeoOJJaCOrnr2lQsk0vUR2xvfWJBZA7N8OKr42iPQ3eof+sTvc7rJ6Z8RG
	DTT9+1XQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvHdO-0000000CVk2-36Y8;
	Thu, 20 Mar 2025 15:16:38 +0000
Received: from out0-195.mail.aliyun.com ([140.205.0.195])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvHdK-0000000CViM-2ia5
	for linux-um@lists.infradead.org;
	Thu, 20 Mar 2025 15:16:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1742483791; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DdzfMRcvr3gESf8MnQ0ywcAx5a09FhJXwmQvAmSNmZo=;
	b=eC7ZFtpi56GNi406ftk3IF1EDKTlxMH2/HtuvdbrFgOco9wO0AUjeEc2QgTLoLe3Lr+jXY8SkYraP+29kHt9QvyvfdEeEtT0CzXKiZtq9xgOTwHzBXSOUbTESMBt15KC5vwtCMRICBiMePnKuaNOdLyShRpq6MUVT+Ednvrn1oI=
Received: from 30.174.89.39(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.bzYUOY6_1742483789 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 20 Mar 2025 23:16:29 +0800
Message-ID: <388b30f1-ea2f-4a82-8610-50b2b60cf8d9@antgroup.com>
Date: Thu, 20 Mar 2025 23:16:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] um: Add VFIO-based virtual PCI driver
To: Johannes Berg <johannes@sipsolutions.net>, richard@nod.at,
 anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org
References: <20250315161910.4082396-1-tiwei.btw@antgroup.com>
 <20250315161910.4082396-4-tiwei.btw@antgroup.com>
 <0f52e834c526d716abde0f48df7aeaf3ea8cffdf.camel@sipsolutions.net>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <0f52e834c526d716abde0f48df7aeaf3ea8cffdf.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250320_081635_358404_E75AE146 
X-CRM114-Status: GOOD (  25.10  )
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

On 2025/3/20 16:50, Johannes Berg wrote:
> On Sun, 2025-03-16 at 00:19 +0800, Tiwei Bie wrote:
>> Implement a new virtual PCI driver based on the VFIO framework.
>> This driver allows users to pass through PCI devices to UML via
>> VFIO. Currently, only MSI-X capable devices are supported, and
>> it is assumed that drivers will use MSI-X.
> 
> Seems nice, but I haven't tested it now :)

Thanks! :)

> 
>> +static irqreturn_t uml_vfio_interrupt(int unused, void *opaque)
>> +{
>> +	struct uml_vfio_intr_ctx *ctx = opaque;
>> +	struct uml_vfio_device *dev = ctx->dev;
>> +	int index = ctx - dev->intr_ctx;
>> +	int irqfd = dev->udev.irqfd[index];
>> +	int irq = dev->msix_data[index];
>> +	uint64_t v;
>> +	int r;
>> +
>> +	do {
>> +		r = os_read_file(irqfd, &v, sizeof(v));
>> +		if (r == sizeof(v))
>> +			generic_handle_irq(irq);
>> +	} while (r == sizeof(v) || r == -EINTR);
>> +	WARN(r != -EAGAIN, "read returned %d\n", r);
>> +
>> +	return IRQ_HANDLED;
>> +}
> 
> This seems mostly right - looks like it's an eventfd.

Yeah, it's an eventfd.

> 
>> +	irqfd = uml_vfio_user_activate_irq(&dev->udev, index);
>> +	if (irqfd < 0)
>> +		return irqfd;
>> +
>> +	ctx->irq = um_request_irq(UM_IRQ_ALLOC, irqfd, IRQ_READ,
>> +				  uml_vfio_interrupt, IRQF_SHARED,
>> +				  "vfio-uml", ctx);
> 
> However I'm not sure it's right with IRQF_SHARED since you don't detect
> if it was actually not your interrupt that fired? We don't really have
> any good reason to have shared interrupts anyway though, and I'm not
> sure we even *can* share interrupts in the lower layers in ARCH=um, so
> I'm not sure it matters?

Makes sense. Will fix it. Thanks!

> 
>> +	err = add_sigio_fd(irqfd);
>> +	if (err)
>> +		goto free_irq;
> 
> doesn't the irq framework do that automatically?

Currently it's not supported. Users need to add it manually, e.g.:

https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/um/drivers/rtc_user.c?h=v6.14-rc7#n43
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/um/drivers/rtc_kern.c?h=v6.14-rc7#n127

> 
>> +static int uml_vfio_deactivate_irq(struct uml_vfio_device *dev, int index)
>> +{
>> +	struct uml_vfio_intr_ctx *ctx = &dev->intr_ctx[index];
>> +
>> +	if (ctx->irq >= 0) {
>> +		ignore_sigio_fd(dev->udev.irqfd[index]);
>> +		um_free_irq(ctx->irq, ctx);
> 
> and here too?
> 
>> +static int uml_vfio_update_msix_cap(struct uml_vfio_device *dev,
>> +				    unsigned int offset, int size,
>> +				    unsigned long val)
>> +{
>> +	int err = 0;
>> +
>> +	if (size == 2 && offset == dev->msix_cap + PCI_MSIX_FLAGS) {
>> +		switch (val & ~PCI_MSIX_FLAGS_QSIZE) {
>> +		case PCI_MSIX_FLAGS_ENABLE:
>> +		case 0:
>> +			err = uml_vfio_user_update_irqs(&dev->udev);
>> +			break;
>> +		}
>> +	}
>> +
>> +	return err;
> 
> do you really want to ignore and return 0 if it wasn't supported?

I just realized that this part could be confusing. It handles only some
essential cmds and ignores others. I'll add some comments to clarify.

> 
>> +static int uml_vfio_update_msix_table(struct uml_vfio_device *dev,
>> +				      unsigned int offset, int size,
>> +				      unsigned long val)
>> +{
>> +	int index;
>> +
>> +	offset -= dev->msix_offset + PCI_MSIX_ENTRY_DATA;
>> +
>> +	if (size != 4 || offset % PCI_MSIX_ENTRY_SIZE != 0)
>> +		return 0;
> 
> here too?
> 
>> +static void uml_vfio_cfgspace_write(struct um_pci_device *pdev,
>> +				    unsigned int offset, int size,
>> +				    unsigned long val)
>> +{
>> +	struct uml_vfio_device *dev = to_vdev(pdev);
>> +
>> +	if (offset < dev->msix_cap + PCI_CAP_MSIX_SIZEOF &&
>> +			offset + size > dev->msix_cap)
> 
> I'd probably indent the second line just to after "if ("?

Sure. Will do.

> 
>> +	if (bar == dev->msix_bar && offset + size > dev->msix_offset &&
>> +			offset < dev->msix_offset + dev->msix_size)
>> +		WARN_ON(uml_vfio_update_msix_table(dev, offset, size, val));
> 
> likewise
> 
>> +static u8 uml_vfio_find_capability(struct uml_vfio_device *dev, u8 cap)
>> +{
>> +	u8 id, pos;
>> +	u16 ent;
>> +	int ttl = 48;
> 
> any particular significance in that value?

I borrowed the value of PCI_FIND_CAP_TTL from drivers/pci/pci.h,
which is an internal header and can't be included from here. I'll
add a comment to it.

> 
>> +int uml_vfio_user_setup_iommu(int container)
>> +{
>> +	unsigned long reserved = uml_reserved - uml_physmem;
>> +	struct vfio_iommu_type1_dma_map dma_map = {
>> +		.argsz = sizeof(dma_map),
>> +		.flags = VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE,
>> +		.vaddr = uml_reserved,
>> +		.iova = reserved,
>> +		.size = physmem_size - reserved,
>> +	};
> 
> maybe point over to the big comment in vhost_user_set_mem_table() from
> virtio_uml.c? Same things apply here I guess.

Good idea. Will do.

Thanks again for the review! :)

Regards,
Tiwei

