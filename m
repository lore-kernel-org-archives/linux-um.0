Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mG1Lt-002sJ7-4L
 for linux-um@lists.infradead.org; Tue, 17 Aug 2021 15:50:11 +0000
Date: Tue, 17 Aug 2021 10:50:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2 7/8] um: add PCI over virtio emulation driver
Message-ID: <20210817155006.GA3020013@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210301160501.bafdfe225ce2.I21b27d26611ebecd8c918e20728e37b184d817bb@changeid>
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
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>

On Mon, Mar 01, 2021 at 04:07:07PM +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> To support testing of PCI/PCIe drivers in UML, add a PCI bus
> support driver. This driver uses virtio, which in UML is really
> just vhost-user, to talk to devices, and adds the devices to
> the virtual PCI bus in the system.

Hi Johannes,

The virtio_pcidev_ops kernel-doc below doesn't match the actual enum,
so it generates several warnings:

  include/uapi/linux/virtio_pcidev.h:41: warning: Enum value 'VIRTIO_PCIDEV_OP_RESERVED' not described in enum 'virtio_pcidev_ops'
  include/uapi/linux/virtio_pcidev.h:41: warning: Enum value 'VIRTIO_PCIDEV_OP_MMIO_READ' not described in enum 'virtio_pcidev_ops'
  include/uapi/linux/virtio_pcidev.h:41: warning: Enum value 'VIRTIO_PCIDEV_OP_MMIO_WRITE' not described in enum 'virtio_pcidev_ops'
  include/uapi/linux/virtio_pcidev.h:41: warning: Excess enum value 'VIRTIO_PCIDEV_OP_BAR_READ' description in 'virtio_pcidev_ops'
  include/uapi/linux/virtio_pcidev.h:41: warning: Excess enum value 'VIRTIO_PCIDEV_OP_BAR_WRITE' description in 'virtio_pcidev_ops'

FWIW, here's the command I used to find these:

  $ find include drivers/pci -type f -path "*pci*.[ch]" | xargs scripts/kernel-doc -none

> diff --git a/include/uapi/linux/virtio_pcidev.h b/include/uapi/linux/virtio_pcidev.h
> new file mode 100644
> index 000000000000..89daa88bcfef
> --- /dev/null
> +++ b/include/uapi/linux/virtio_pcidev.h
> @@ -0,0 +1,64 @@
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> +/*
> + * Copyright (C) 2021 Intel Corporation
> + * Author: Johannes Berg <johannes@sipsolutions.net>
> + */
> +#ifndef _UAPI_LINUX_VIRTIO_PCIDEV_H
> +#define _UAPI_LINUX_VIRTIO_PCIDEV_H
> +#include <linux/types.h>
> +
> +/**
> + * enum virtio_pcidev_ops - virtual PCI device operations
> + * @VIRTIO_PCIDEV_OP_CFG_READ: read config space, size is 1, 2, 4 or 8;
> + *	the @data field should be filled in by the device (in little endian).
> + * @VIRTIO_PCIDEV_OP_CFG_WRITE: write config space, size is 1, 2, 4 or 8;
> + *	the @data field contains the data to write (in little endian).
> + * @VIRTIO_PCIDEV_OP_BAR_READ: read BAR mem/pio, size can be variable;
> + *	the @data field should be filled in by the device (in little endian).
> + * @VIRTIO_PCIDEV_OP_BAR_WRITE: write BAR mem/pio, size can be variable;
> + *	the @data field contains the data to write (in little endian).
> + * @VIRTIO_PCIDEV_OP_MMIO_MEMSET: memset MMIO, size is variable but
> + *	the @data field only has one byte (unlike @VIRTIO_PCIDEV_OP_MMIO_WRITE)
> + * @VIRTIO_PCIDEV_OP_INT: legacy INTx# pin interrupt, the addr field is 1-4 for
> + *	the number
> + * @VIRTIO_PCIDEV_OP_MSI: MSI(-X) interrupt, this message basically transports
> + *	the 16- or 32-bit write that would otherwise be done into memory,
> + *	analogous to the write messages (@VIRTIO_PCIDEV_OP_MMIO_WRITE) above
> + * @VIRTIO_PCIDEV_OP_PME: Dummy message whose content is ignored (and should be
> + *	all zeroes) to signal the PME# pin.
> + */
> +enum virtio_pcidev_ops {
> +	VIRTIO_PCIDEV_OP_RESERVED = 0,
> +	VIRTIO_PCIDEV_OP_CFG_READ,
> +	VIRTIO_PCIDEV_OP_CFG_WRITE,
> +	VIRTIO_PCIDEV_OP_MMIO_READ,
> +	VIRTIO_PCIDEV_OP_MMIO_WRITE,
> +	VIRTIO_PCIDEV_OP_MMIO_MEMSET,
> +	VIRTIO_PCIDEV_OP_INT,
> +	VIRTIO_PCIDEV_OP_MSI,
> +	VIRTIO_PCIDEV_OP_PME,
> +};

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

