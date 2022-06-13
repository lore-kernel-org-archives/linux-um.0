Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0e2L-001pUV-Sf
	for linux-um@lists.infradead.org; Mon, 13 Jun 2022 06:58:59 +0000
Received: by mail-lf1-f72.google.com with SMTP id g40-20020a0565123ba800b004791450e602so2652164lfv.17
        for <linux-um@lists.infradead.org>; Sun, 12 Jun 2022 23:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220610151203.3492541-1-vincent.whitchurch@axis.com>
In-Reply-To: <20220610151203.3492541-1-vincent.whitchurch@axis.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 13 Jun 2022 14:58:40 +0800
Message-ID: <CACGkMEsf5p=JvHHjd_jtEwtdQijTR7ZAwetEuSG-oprF6RBsVA@mail.gmail.com>
Subject: Re: [PATCH] um: virt-pci: set device ready in probe()
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
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, kernel@axis.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-um@lists.infradead.org, linux-kernel <linux-kernel@vger.kernel.org>

On Fri, Jun 10, 2022 at 11:12 PM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> Call virtio_device_ready() to make this driver work after commit
> b4ec69d7e09 ("virtio: harden vring IRQ"), since the driver uses the
> virtqueues in the probe function.  (The virtio core sets the device
> ready when probe returns.)
>
> Fixes: 8b4ec69d7e09 ("virtio: harden vring IRQ")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  arch/um/drivers/virt-pci.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
> index 5c092a9153ea..027847023184 100644
> --- a/arch/um/drivers/virt-pci.c
> +++ b/arch/um/drivers/virt-pci.c
> @@ -544,6 +544,8 @@ static int um_pci_init_vqs(struct um_pci_device *dev)
>         dev->cmd_vq = vqs[0];
>         dev->irq_vq = vqs[1];
>
> +       virtio_device_ready(dev->vdev);
> +
>         for (i = 0; i < NUM_IRQ_MSGS; i++) {
>                 void *msg = kzalloc(MAX_IRQ_MSG_SIZE, GFP_KERNEL);
>
> @@ -587,7 +589,7 @@ static int um_pci_virtio_probe(struct virtio_device *vdev)
>         dev->irq = irq_alloc_desc(numa_node_id());
>         if (dev->irq < 0) {
>                 err = dev->irq;
> -               goto error;
> +               goto err_reset;
>         }
>         um_pci_devices[free].dev = dev;
>         vdev->priv = dev;
> @@ -604,6 +606,9 @@ static int um_pci_virtio_probe(struct virtio_device *vdev)
>
>         um_pci_rescan();
>         return 0;
> +err_reset:
> +       virtio_reset_device(vdev);
> +       vdev->config->del_vqs(vdev);

This part seems to be an independent fix.

Thanks

>  error:
>         mutex_unlock(&um_pci_mtx);
>         kfree(dev);
> --
> 2.34.1
>


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

