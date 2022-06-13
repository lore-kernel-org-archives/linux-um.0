Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0eSQ-001xTg-4C
	for linux-um@lists.infradead.org; Mon, 13 Jun 2022 07:25:55 +0000
Received: by mail-ed1-f71.google.com with SMTP id y4-20020aa7ccc4000000b0042df06d83bcso3409855edt.22
        for <linux-um@lists.infradead.org>; Mon, 13 Jun 2022 00:25:51 -0700 (PDT)
Date: Mon, 13 Jun 2022 03:25:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] um: virt-pci: set device ready in probe()
Message-ID: <20220613032529-mutt-send-email-mst@kernel.org>
References: <20220610151203.3492541-1-vincent.whitchurch@axis.com>
 <CACGkMEsf5p=JvHHjd_jtEwtdQijTR7ZAwetEuSG-oprF6RBsVA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsf5p=JvHHjd_jtEwtdQijTR7ZAwetEuSG-oprF6RBsVA@mail.gmail.com>
Content-Disposition: inline
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
Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, kernel@axis.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-um@lists.infradead.org, linux-kernel <linux-kernel@vger.kernel.org>

On Mon, Jun 13, 2022 at 02:58:40PM +0800, Jason Wang wrote:
> On Fri, Jun 10, 2022 at 11:12 PM Vincent Whitchurch
> <vincent.whitchurch@axis.com> wrote:
> >
> > Call virtio_device_ready() to make this driver work after commit
> > b4ec69d7e09 ("virtio: harden vring IRQ"), since the driver uses the
> > virtqueues in the probe function.  (The virtio core sets the device
> > ready when probe returns.)
> >
> > Fixes: 8b4ec69d7e09 ("virtio: harden vring IRQ")
> > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> > ---
> >  arch/um/drivers/virt-pci.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
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
> 
> Thanks


Yes good point. I merged as is, oh well.

> >  error:
> >         mutex_unlock(&um_pci_mtx);
> >         kfree(dev);
> > --
> > 2.34.1
> >


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

