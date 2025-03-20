Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F4A6C28B30
	for <linux-um@archiver.kernel.org>; Thu, 20 Mar 2025 08:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9fZxlKJUERZdsf4qnLan7tGcGlAbwUKZhazb3kBq/EM=; b=QcgIGMNB43+FiV6CG+UdOnO07Y
	8Ag+erId5ILAW8uJ4v4zEBR+1xzVXE/K08X1HrDPQQ7h6VF381gXN7wioRE2BxOm5KKQjx8AGiN/X
	BMvRcgfCf0GqtB6kdS4tm9YDcmIyb0qfixbPwCSrJ/gxpJo12ou6FnJzu4V/b1AT8cgxSHyvaszwN
	gjze8M+YpyadtEyt4StsVorW63+dzSJJT+vUca8pLOXkGis2+0IJ+n8ewTsQON8IHoNGKeeV8mdJz
	XLe7NCeXL3Zntov4CmjNLKypx12org1IsPGsAi9rjK6jXWYI5ib8K4bQtXh23i43l2aElnsiL0H7Q
	HQ2JppbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvBhE-0000000BbvZ-1DFR;
	Thu, 20 Mar 2025 08:56:12 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvBba-0000000Bb77-2xin
	for linux-um@lists.infradead.org;
	Thu, 20 Mar 2025 08:50:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9fZxlKJUERZdsf4qnLan7tGcGlAbwUKZhazb3kBq/EM=;
	t=1742460622; x=1743670222; b=MHil1JjzjsytZddaaE6NlLkoZW6UV0kRvA5y63+AIu3vZNp
	66qPsie1PlFayG0C4elI/VgrMcju8h2hI32401cgVVjX6fQHpiVhmgcuuY2OIgEGTiBMVWcwRBpud
	FJIs9uzNyQJKn7kX2kbYqSJz+VPgfHFRpODiazSjjIbW6oYqHlIa9QAhZ0PB0mWleHVqZ9UN3uOx6
	8fuqQ1WniZyAz+OqJ5kortRzahLlmnw00Ok9lepvc9jX8aUPYEEW4evNCF0Ue4x4ye2ChEXcG/FQ/
	2Xi3kre1LaIzfrK/zgsg+JskYLF2SevPrO2JFWHmguFIb8VeHxduSuAXHHB7qpvg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tvBbX-0000000HLAs-3exX;
	Thu, 20 Mar 2025 09:50:20 +0100
Message-ID: <0f52e834c526d716abde0f48df7aeaf3ea8cffdf.camel@sipsolutions.net>
Subject: Re: [PATCH 3/3] um: Add VFIO-based virtual PCI driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org
Date: Thu, 20 Mar 2025 09:50:19 +0100
In-Reply-To: <20250315161910.4082396-4-tiwei.btw@antgroup.com>
References: <20250315161910.4082396-1-tiwei.btw@antgroup.com>
	 <20250315161910.4082396-4-tiwei.btw@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250320_015022_743644_ED0B7A9F 
X-CRM114-Status: GOOD (  20.56  )
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

On Sun, 2025-03-16 at 00:19 +0800, Tiwei Bie wrote:
> Implement a new virtual PCI driver based on the VFIO framework.
> This driver allows users to pass through PCI devices to UML via
> VFIO. Currently, only MSI-X capable devices are supported, and
> it is assumed that drivers will use MSI-X.

Seems nice, but I haven't tested it now :)

> +static irqreturn_t uml_vfio_interrupt(int unused, void *opaque)
> +{
> +	struct uml_vfio_intr_ctx *ctx =3D opaque;
> +	struct uml_vfio_device *dev =3D ctx->dev;
> +	int index =3D ctx - dev->intr_ctx;
> +	int irqfd =3D dev->udev.irqfd[index];
> +	int irq =3D dev->msix_data[index];
> +	uint64_t v;
> +	int r;
> +
> +	do {
> +		r =3D os_read_file(irqfd, &v, sizeof(v));
> +		if (r =3D=3D sizeof(v))
> +			generic_handle_irq(irq);
> +	} while (r =3D=3D sizeof(v) || r =3D=3D -EINTR);
> +	WARN(r !=3D -EAGAIN, "read returned %d\n", r);
> +
> +	return IRQ_HANDLED;
> +}

This seems mostly right - looks like it's an eventfd.

> +	irqfd =3D uml_vfio_user_activate_irq(&dev->udev, index);
> +	if (irqfd < 0)
> +		return irqfd;
> +
> +	ctx->irq =3D um_request_irq(UM_IRQ_ALLOC, irqfd, IRQ_READ,
> +				  uml_vfio_interrupt, IRQF_SHARED,
> +				  "vfio-uml", ctx);

However I'm not sure it's right with IRQF_SHARED since you don't detect
if it was actually not your interrupt that fired? We don't really have
any good reason to have shared interrupts anyway though, and I'm not
sure we even *can* share interrupts in the lower layers in ARCH=3Dum, so
I'm not sure it matters?

> +	err =3D add_sigio_fd(irqfd);
> +	if (err)
> +		goto free_irq;

doesn't the irq framework do that automatically?

> +static int uml_vfio_deactivate_irq(struct uml_vfio_device *dev, int inde=
x)
> +{
> +	struct uml_vfio_intr_ctx *ctx =3D &dev->intr_ctx[index];
> +
> +	if (ctx->irq >=3D 0) {
> +		ignore_sigio_fd(dev->udev.irqfd[index]);
> +		um_free_irq(ctx->irq, ctx);

and here too?

> +static int uml_vfio_update_msix_cap(struct uml_vfio_device *dev,
> +				    unsigned int offset, int size,
> +				    unsigned long val)
> +{
> +	int err =3D 0;
> +
> +	if (size =3D=3D 2 && offset =3D=3D dev->msix_cap + PCI_MSIX_FLAGS) {
> +		switch (val & ~PCI_MSIX_FLAGS_QSIZE) {
> +		case PCI_MSIX_FLAGS_ENABLE:
> +		case 0:
> +			err =3D uml_vfio_user_update_irqs(&dev->udev);
> +			break;
> +		}
> +	}
> +
> +	return err;

do you really want to ignore and return 0 if it wasn't supported?

> +static int uml_vfio_update_msix_table(struct uml_vfio_device *dev,
> +				      unsigned int offset, int size,
> +				      unsigned long val)
> +{
> +	int index;
> +
> +	offset -=3D dev->msix_offset + PCI_MSIX_ENTRY_DATA;
> +
> +	if (size !=3D 4 || offset % PCI_MSIX_ENTRY_SIZE !=3D 0)
> +		return 0;

here too?

> +static void uml_vfio_cfgspace_write(struct um_pci_device *pdev,
> +				    unsigned int offset, int size,
> +				    unsigned long val)
> +{
> +	struct uml_vfio_device *dev =3D to_vdev(pdev);
> +
> +	if (offset < dev->msix_cap + PCI_CAP_MSIX_SIZEOF &&
> +			offset + size > dev->msix_cap)

I'd probably indent the second line just to after "if ("?

> +	if (bar =3D=3D dev->msix_bar && offset + size > dev->msix_offset &&
> +			offset < dev->msix_offset + dev->msix_size)
> +		WARN_ON(uml_vfio_update_msix_table(dev, offset, size, val));

likewise

> +static u8 uml_vfio_find_capability(struct uml_vfio_device *dev, u8 cap)
> +{
> +	u8 id, pos;
> +	u16 ent;
> +	int ttl =3D 48;

any particular significance in that value?

> +int uml_vfio_user_setup_iommu(int container)
> +{
> +	unsigned long reserved =3D uml_reserved - uml_physmem;
> +	struct vfio_iommu_type1_dma_map dma_map =3D {
> +		.argsz =3D sizeof(dma_map),
> +		.flags =3D VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE,
> +		.vaddr =3D uml_reserved,
> +		.iova =3D reserved,
> +		.size =3D physmem_size - reserved,
> +	};

maybe point over to the big comment in vhost_user_set_mem_table() from
virtio_uml.c? Same things apply here I guess.

johannes

