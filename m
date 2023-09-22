Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859AEE7D0C5
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 01:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To:
	From:Date:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u8cghBncHCGns7ZFPI04Sseg3/MgvroDgp0MLjFpL2c=; b=cM8H7F8ttartk2
	C5vRCpjCCQWiTffNQVDrhUMsZAo3PXJj0IzxAMKWOItMVmvHMTG4X7m7bRFAZPxKApvzFPbQ8wYA+
	/t7qcNk3CpDd1C7ALCUow2D3ZM3F26Qsej/GVatvyNhNuyASQpt4rDDGVJjDfrobyjMibsXqpcLSX
	bpm69ewPJhB/CUf+1PiJ2PT4uuLHUU+VsBIS/D6euYsJB8LSFAL004hDiIZMxXhnesR7GVSvEwgiq
	bCH/RF8wsZQ2bUO2QACzgMbLpDFKkCcKIfm3Dcd0AXxTu1TshqES3rsC2pJQera+WyWCRqzy9Ki0K
	8w9zbw+Ip1rHEZZA52KQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjVK8-007abO-1u;
	Fri, 22 Sep 2023 01:51:16 +0000
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjVK2-007aVi-2T
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 01:51:13 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=36;SR=0;TI=SMTPD_---0Vsa-hC4_1695347462;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vsa-hC4_1695347462)
          by smtp.aliyun-inc.com;
          Fri, 22 Sep 2023 09:51:04 +0800
Message-ID: <1695347358.2770545-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v14 30/42] virtio_pci: introduce helper to get/set queue reset
Date: Fri, 22 Sep 2023 09:49:18 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Mark Gross <markgross@kernel.org>,
 Vadim Pasternak <vadimp@nvidia.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 linux-um@lists.infradead.org,
 netdev@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 linux-remoteproc@vger.kernel.org,
 linux-s390@vger.kernel.org,
 kvm@vger.kernel.org,
 bpf@vger.kernel.org,
 kangjie.xu@linux.alibaba.com
References: <20220801063902.129329-1-xuanzhuo@linux.alibaba.com>
 <20220801063902.129329-31-xuanzhuo@linux.alibaba.com>
 <20230921100112-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230921100112-mutt-send-email-mst@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230921_185110_985980_CF781AD3 
X-CRM114-Status: GOOD (  20.12  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Thu, 21 Sep 2023 10:02:53 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Mon, Aug 01, 2022 at 02:38:50PM +0800, Xuan Zhuo wrote:
> > Introduce new helpers to implement queue reset and get queue reset
> > status.
> >
> >  https://github.com/oasis-tcs/virtio-spec/issues/124
> >  https://github.com/oasis-tcs/virtio-spec/issues/139
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_pci_modern_dev.c | 39 ++++++++++++++++++++++++++
> >  include/linux/virtio_pci_modern.h      |  2 ++
> >  2 files changed, 41 insertions(+)
> >
> > diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> > index fa2a9445bb18..869cb46bef96 100644
> > --- a/drivers/virtio/virtio_pci_modern_dev.c
> > +++ b/drivers/virtio/virtio_pci_modern_dev.c
> > @@ -3,6 +3,7 @@
> >  #include <linux/virtio_pci_modern.h>
> >  #include <linux/module.h>
> >  #include <linux/pci.h>
> > +#include <linux/delay.h>
> >
> >  /*
> >   * vp_modern_map_capability - map a part of virtio pci capability
> > @@ -474,6 +475,44 @@ void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
> >  }
> >  EXPORT_SYMBOL_GPL(vp_modern_set_status);
> >
> > +/*
> > + * vp_modern_get_queue_reset - get the queue reset status
> > + * @mdev: the modern virtio-pci device
> > + * @index: queue index
> > + */
> > +int vp_modern_get_queue_reset(struct virtio_pci_modern_device *mdev, u16 index)
> > +{
> > +	struct virtio_pci_modern_common_cfg __iomem *cfg;
> > +
> > +	cfg = (struct virtio_pci_modern_common_cfg __iomem *)mdev->common;
> > +
> > +	vp_iowrite16(index, &cfg->cfg.queue_select);
> > +	return vp_ioread16(&cfg->queue_reset);
> > +}
> > +EXPORT_SYMBOL_GPL(vp_modern_get_queue_reset);
> > +
>
> Actually, this does not validate that the config structure is big
> enough. So it can access some unrelated memory. Don't know whether
> that's exploitable e.g. for CoCo but not nice, anyway.
> Need to validate the size and disable reset if it's too small.


static int vp_modern_disable_vq_and_reset(struct virtqueue *vq)
{
	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
	struct virtio_pci_vq_info *info;
	unsigned long flags;

->	if (!virtio_has_feature(vq->vdev, VIRTIO_F_RING_RESET))
		return -ENOENT;

	vp_modern_set_queue_reset(mdev, vq->index);


I checked VIRTIO_F_RING_RESET before call this.

Do you mean, we should put the check to this function.


Thanks.



>
>
> > +/*
> > + * vp_modern_set_queue_reset - reset the queue
> > + * @mdev: the modern virtio-pci device
> > + * @index: queue index
> > + */
> > +void vp_modern_set_queue_reset(struct virtio_pci_modern_device *mdev, u16 index)
> > +{
> > +	struct virtio_pci_modern_common_cfg __iomem *cfg;
> > +
> > +	cfg = (struct virtio_pci_modern_common_cfg __iomem *)mdev->common;
> > +
> > +	vp_iowrite16(index, &cfg->cfg.queue_select);
> > +	vp_iowrite16(1, &cfg->queue_reset);
> > +
> > +	while (vp_ioread16(&cfg->queue_reset))
> > +		msleep(1);
> > +
> > +	while (vp_ioread16(&cfg->cfg.queue_enable))
> > +		msleep(1);
> > +}
> > +EXPORT_SYMBOL_GPL(vp_modern_set_queue_reset);
> > +
> >  /*
> >   * vp_modern_queue_vector - set the MSIX vector for a specific virtqueue
> >   * @mdev: the modern virtio-pci device
> > diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
> > index 05123b9a606f..c4eeb79b0139 100644
> > --- a/include/linux/virtio_pci_modern.h
> > +++ b/include/linux/virtio_pci_modern.h
> > @@ -113,4 +113,6 @@ void __iomem * vp_modern_map_vq_notify(struct virtio_pci_modern_device *mdev,
> >  				       u16 index, resource_size_t *pa);
> >  int vp_modern_probe(struct virtio_pci_modern_device *mdev);
> >  void vp_modern_remove(struct virtio_pci_modern_device *mdev);
> > +int vp_modern_get_queue_reset(struct virtio_pci_modern_device *mdev, u16 index);
> > +void vp_modern_set_queue_reset(struct virtio_pci_modern_device *mdev, u16 index);
> >  #endif
> > --
> > 2.31.0
>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
