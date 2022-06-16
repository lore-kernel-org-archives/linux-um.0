Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from smtp1.axis.com ([195.60.68.17])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1mvq-001ugM-Tk
	for linux-um@lists.infradead.org; Thu, 16 Jun 2022 10:41:00 +0000
Date: Thu, 16 Jun 2022 12:40:52 +0200
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH] um: virt-pci: set device ready in probe()
Message-ID: <20220616104052.GA7518@axis.com>
References: <20220610151203.3492541-1-vincent.whitchurch@axis.com>
 <CACGkMEsf5p=JvHHjd_jtEwtdQijTR7ZAwetEuSG-oprF6RBsVA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACGkMEsf5p=JvHHjd_jtEwtdQijTR7ZAwetEuSG-oprF6RBsVA@mail.gmail.com>
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
To: Jason Wang <jasowang@redhat.com>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, kernel <kernel@axis.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Michael S." Tsirkin" <mst@redhat.com>, "linux-um@lists.infradead.org, linux-um@lists.infradead.org, linux-kernel <linux-kernel@vger.kernel.org>

On Mon, Jun 13, 2022 at 08:58:40AM +0200, Jason Wang wrote:
> On Fri, Jun 10, 2022 at 11:12 PM Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:
> > diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
> > index 5c092a9153ea..027847023184 100644
> > --- a/arch/um/drivers/virt-pci.c
> > +++ b/arch/um/drivers/virt-pci.c
> > @@ -544,6 +544,8 @@ static int um_pci_init_vqs(struct um_pci_device *dev)
> >         dev->cmd_vq = vqs[0];
> >         dev->irq_vq = vqs[1];
> >
> > +       virtio_device_ready(dev->vdev);
> > +
> >         for (i = 0; i < NUM_IRQ_MSGS; i++) {
> >                 void *msg = kzalloc(MAX_IRQ_MSG_SIZE, GFP_KERNEL);
> >
> > @@ -587,7 +589,7 @@ static int um_pci_virtio_probe(struct virtio_device *vdev)
> >         dev->irq = irq_alloc_desc(numa_node_id());
> >         if (dev->irq < 0) {
> >                 err = dev->irq;
> > -               goto error;
> > +               goto err_reset;
> >         }
> >         um_pci_devices[free].dev = dev;
> >         vdev->priv = dev;
> > @@ -604,6 +606,9 @@ static int um_pci_virtio_probe(struct virtio_device *vdev)
> >
> >         um_pci_rescan();
> >         return 0;
> > +err_reset:
> > +       virtio_reset_device(vdev);
> > +       vdev->config->del_vqs(vdev);
> 
> This part seems to be an independent fix.

Yes, I guess that last line could have been added in a separate patch.
When adding the cleanup in the error path for the virtio_device_ready()
call added by the patch I noticed that this driver wasn't deleting its
virtqueues in the error path, unlike other virtio drivers I looked at.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

