Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hvOak-0001ny-Ca
 for linux-um@lists.infradead.org; Wed, 07 Aug 2019 16:15:12 +0000
Subject: Re: [RFC] um: virtio: Workaround for using virtio_net with snabb
References: <20190731203030.29821-1-johannes@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <394f11ad-88e3-1d1f-8b8e-51fdc14aea8d@cambridgegreys.com>
Date: Wed, 7 Aug 2019 17:14:45 +0100
MIME-Version: 1.0
In-Reply-To: <20190731203030.29821-1-johannes@sipsolutions.net>
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
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Erel Geron <erelx.geron@intel.com>



On 31/07/2019 21:30, Johannes Berg wrote:
> From: Erel Geron <erelx.geron@intel.com>
> 
> Workaround a crash of snabb when using virtio_uml.
> 
> Signed-off-by: Erel Geron <erelx.geron@intel.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   arch/um/drivers/virtio_uml.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
> index 30eeb907f42a..9c1308f56b93 100644
> --- a/arch/um/drivers/virtio_uml.c
> +++ b/arch/um/drivers/virtio_uml.c
> @@ -31,6 +31,10 @@
>   #include <os.h>
>   #include "vhost_user.h"
>   
> +/* TODO for the workaround in vhost_user_init */
> +#include <linux/virtio_ids.h>
> +#include <linux/virtio_net.h>
> +
>   /* Workaround due to a conflict between irq_user.h and irqreturn.h */
>   #ifdef IRQ_NONE
>   #undef IRQ_NONE
> @@ -200,6 +204,11 @@ static int vhost_user_init(struct virtio_uml_device *vu_dev)
>   	if (rc)
>   		return rc;
>   
> +	/* TODO workaround for some implementations */
> +	if (vu_dev->vdev.id.device == VIRTIO_ID_NET)
> +		vu_dev->features &= ~BIT_ULL(VIRTIO_NET_F_CTRL_VQ) &
> +				~BIT_ULL(VIRTIO_NET_F_MQ);

If it is needed only for some implementations, then it should be an option.

Have you tried it vs let's say dpdk (IIRC it supports vhost_user as an 
interface).

> +
>   	if (vu_dev->features & BIT_ULL(VHOST_USER_F_PROTOCOL_FEATURES)) {
>   		rc = vhost_user_get_protocol_features(vu_dev,
>   				&vu_dev->protocol_features);
> 

-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

