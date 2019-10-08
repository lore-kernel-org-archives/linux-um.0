Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iHsAI-0002qX-3q
 for linux-um@lists.infradead.org; Tue, 08 Oct 2019 16:16:47 +0000
Subject: Re: [PATCH] um: virtio_uml: disallow modular build
References: <1570549401-Ia2c524a2c48a33cecd9d956898cebe358a37563d@changeid>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <63d60527-1bc0-cb76-75e2-3d051f583c1b@kot-begemot.co.uk>
Date: Tue, 8 Oct 2019 17:16:37 +0100
MIME-Version: 1.0
In-Reply-To: <1570549401-Ia2c524a2c48a33cecd9d956898cebe358a37563d@changeid>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Richard Weinberger <richard@nod.at>, Johannes Berg <johannes.berg@intel.com>

On 08/10/2019 16:43, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> This driver *can* be a module, but then its parameters (socket path)
> are untrusted data from inside the VM, and that isn't allowed. Allow
> the code to only be built-in to avoid that.
> 
> Fixes: 5d38f324993f ("um: drivers: Add virtio vhost-user driver")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   arch/um/drivers/Kconfig      | 2 +-
>   arch/um/drivers/virtio_uml.c | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
> index fea5a0d522dc..388096fb45a2 100644
> --- a/arch/um/drivers/Kconfig
> +++ b/arch/um/drivers/Kconfig
> @@ -337,7 +337,7 @@ config UML_NET_SLIRP
>   endmenu
>   
>   config VIRTIO_UML
> -	tristate "UML driver for virtio devices"
> +	bool "UML driver for virtio devices"
>   	select VIRTIO
>   	help
>   	  This driver provides support for virtio based paravirtual device
> diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
> index fc8c52cff5aa..511f595a3c3d 100644
> --- a/arch/um/drivers/virtio_uml.c
> +++ b/arch/um/drivers/virtio_uml.c
> @@ -4,12 +4,12 @@
>    *
>    * Copyright(c) 2019 Intel Corporation
>    *
> - * This module allows virtio devices to be used over a vhost-user socket.
> + * This driver allows virtio devices to be used over a vhost-user socket.
>    *
>    * Guest devices can be instantiated by kernel module or command line
>    * parameters. One device will be created for each parameter. Syntax:
>    *
> - *		[virtio_uml.]device=<socket>:<virtio_id>[:<platform_id>]
> + *		virtio_uml.device=<socket>:<virtio_id>[:<platform_id>]
>    * where:
>    *		<socket>	:= vhost-user socket path to connect
>    *		<virtio_id>	:= virtio device id (as in virtio_ids.h)
> 

Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.co.uk>

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

