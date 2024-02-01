Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC83C47DB3
	for <linux-um@archiver.kernel.org>; Thu,  1 Feb 2024 03:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Date:Subject:Message-ID:
	Reply-To:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OIzQSRKNh1ZV+Nnz1+bU4a7ItleWsZPQWVeR5Bih22A=; b=Bi823P4yZN0pxj4W+M1rQx+/x+
	6P+lFN+3hw+S5hQtK1gbdlmF1xQzqD2VWHdg2+/zTmp1VHaswFcHo/kKXWnbj4Kow6W+eKhPVhqnV
	SeiH26B6h8hLoxnjgejVs/fusi/4YMMWZNYjZjo8R+JIupeVl+v0+ToBTn5alN33n/Q6apqpt+Iou
	ZFOXtehKKMJCGDAQR/77TqABhWyeIlAWSTEQ8pbbWCLLjp+nbZxTQpyQpGPLY6yPOc6MS9+zLZf3R
	ZqXN5/Iu1024RcL7wlHako8HeTr+VAD/TaWS4OZ9z3UfsTOXJs3/MnJ1OAlgKwmH+iJECUBO3B7+N
	aZNynoCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVNPq-00000006LpL-0uCe;
	Thu, 01 Feb 2024 03:07:02 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVNPm-00000006LoN-1YE5
	for linux-um@lists.infradead.org;
	Thu, 01 Feb 2024 03:07:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706756812; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=OIzQSRKNh1ZV+Nnz1+bU4a7ItleWsZPQWVeR5Bih22A=;
	b=Q8SQApPZUV0QhWOS7bGJ+5rqJw3Jyxd8vCspg+dQMy12/pFhH/c2HmASkRi8264i1fqDOIFhYrtvjTUjnFSwD8vUvhVl23xNKNNXvfiytPzZV5wBfsfmTKvk0NbvwcKu/0CrYmEt8ck6mJqSnLQrjGP+ZoKcDHpBf0mNi7+qO2M=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=36;SR=0;TI=SMTPD_---0W.mW2hm_1706756809;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.mW2hm_1706756809)
          by smtp.aliyun-inc.com;
          Thu, 01 Feb 2024 11:06:50 +0800
Message-ID: <1706756442.5524123-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 07/17] virtio: find_vqs: pass struct instead of multi parameters
Date: Thu, 1 Feb 2024 11:00:42 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Vadim Pasternak <vadimp@nvidia.com>,
 Bjorn Andersson <andersson@kernel.org>,
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
 Benjamin Berg <benjamin.berg@intel.com>,
 Yang Li <yang.lee@linux.alibaba.com>,
 linux-um@lists.infradead.org,
 netdev@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 linux-remoteproc@vger.kernel.org,
 linux-s390@vger.kernel.org,
 kvm@vger.kernel.org,
 bpf@vger.kernel.org
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com>
 <20240130114224.86536-8-xuanzhuo@linux.alibaba.com>
 <CACGkMEvb4N8kthr4qWXrLOh9v422OYhrYU6hQejusw-e5EacPw@mail.gmail.com>
In-Reply-To: <CACGkMEvb4N8kthr4qWXrLOh9v422OYhrYU6hQejusw-e5EacPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_190658_924088_9438B307 
X-CRM114-Status: GOOD (  31.18  )
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

On Wed, 31 Jan 2024 17:12:34 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Jan 30, 2024 at 7:42=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > Now, we pass multi parameters to find_vqs. These parameters
> > may work for transport or work for vring.
> >
> > And find_vqs has multi implements in many places:
> >
> > But every time,
> >  arch/um/drivers/virtio_uml.c
> >  drivers/platform/mellanox/mlxbf-tmfifo.c
> >  drivers/remoteproc/remoteproc_virtio.c
> >  drivers/s390/virtio/virtio_ccw.c
> >  drivers/virtio/virtio_mmio.c
> >  drivers/virtio/virtio_pci_legacy.c
> >  drivers/virtio/virtio_pci_modern.c
> >  drivers/virtio/virtio_vdpa.c
> >
> > Every time, we try to add a new parameter, that is difficult.
> > We must change every find_vqs implement.
> >
> > One the other side, if we want to pass a parameter to vring,
> > we must change the call path from transport to vring.
> > Too many functions need to be changed.
> >
> > So it is time to refactor the find_vqs. We pass a structure
> > cfg to find_vqs(), that will be passed to vring by transport.
> >
> > And squish the parameters from transport to a structure.
>=20
> The patch did more than what is described here, it also switch to use
> a structure for vring_create_virtqueue() etc.
>=20
> Is it better to split?

Sure.

>=20
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  arch/um/drivers/virtio_uml.c             | 29 +++++++-----
> >  drivers/platform/mellanox/mlxbf-tmfifo.c | 14 +++---
> >  drivers/remoteproc/remoteproc_virtio.c   | 28 ++++++-----
> >  drivers/s390/virtio/virtio_ccw.c         | 33 ++++++-------
> >  drivers/virtio/virtio_mmio.c             | 30 ++++++------
> >  drivers/virtio/virtio_pci_common.c       | 59 +++++++++++-------------
> >  drivers/virtio/virtio_pci_common.h       |  9 +---
> >  drivers/virtio/virtio_pci_legacy.c       | 16 ++++---
> >  drivers/virtio/virtio_pci_modern.c       | 24 +++++-----
> >  drivers/virtio/virtio_ring.c             | 59 ++++++++++--------------
> >  drivers/virtio/virtio_vdpa.c             | 33 +++++++------
> >  include/linux/virtio_config.h            | 51 ++++++++++++++++----
> >  include/linux/virtio_ring.h              | 40 ++++++----------
> >  13 files changed, 217 insertions(+), 208 deletions(-)
> >
> > diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
> > index 8adca2000e51..161bac67e454 100644
> > --- a/arch/um/drivers/virtio_uml.c
> > +++ b/arch/um/drivers/virtio_uml.c
> > @@ -937,11 +937,12 @@ static int vu_setup_vq_call_fd(struct virtio_uml_=
device *vu_dev,
> >  }
> >
> >  static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
> > -                                    unsigned index, vq_callback_t *cal=
lback,
> > -                                    const char *name, bool ctx)
> > +                                    unsigned index,
> > +                                    struct virtio_vq_config *cfg)
> >  {
> >         struct virtio_uml_device *vu_dev =3D to_virtio_uml_device(vdev);
> >         struct platform_device *pdev =3D vu_dev->pdev;
> > +       struct transport_vq_config tp_cfg =3D {};
>=20
> Nit: what did "tp" short for?

tp: transport

Any better?


>=20
> >         struct virtio_uml_vq_info *info;
> >         struct virtqueue *vq;
> >         int num =3D MAX_SUPPORTED_QUEUE_SIZE;
> > @@ -953,10 +954,15 @@ static struct virtqueue *vu_setup_vq(struct virti=
o_device *vdev,
> >                 goto error_kzalloc;
> >         }
> >         snprintf(info->name, sizeof(info->name), "%s.%d-%s", pdev->name,
> > -                pdev->id, name);
> > +                pdev->id, cfg->names[cfg->cfg_idx]);
> >
> > -               dev_err(dev, "vring_new_virtqueue %s failed\n", name);

[...]


> > -       if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
> > -               return vring_create_virtqueue_packed(index, num, vring_=
align,
> > -                               vdev, weak_barriers, may_reduce_num,
> > -                               context, notify, callback, name, vdev->=
dev.parent);
> > +       dma_dev =3D tp_cfg->dma_dev;
> > +       if (!dma_dev)
> > +               dma_dev  =3D vdev->dev.parent;
>=20
> Nit: This seems suboptimal than using "?:" ?

YES


>=20
> >
> > -       return vring_create_virtqueue_split(index, num, vring_align,
> > -                       vdev, weak_barriers, may_reduce_num,
> > -                       context, notify, callback, name, vdev->dev.pare=
nt);
> > -}

[...]

> >                         err =3D PTR_ERR(vqs[i]);
> >                         goto err_setup_vq;
> > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_confi=
g.h
> > index 2b3438de2c4d..e2c72e125dae 100644
> > --- a/include/linux/virtio_config.h
> > +++ b/include/linux/virtio_config.h
> > @@ -94,6 +94,20 @@ typedef void vq_callback_t(struct virtqueue *);
> >   *     If disable_vq_and_reset is set, then enable_vq_after_reset must=
 also be
> >   *     set.
> >   */
> > +
> > +struct virtio_vq_config {
> > +       unsigned int nvqs;
> > +
> > +       /* the vq index may not eq to the cfg index of the other array =
items */
>=20
> What does this mean?


When we read from the names/ctx/callbacks array, we can use the vq index,
because some names maybe null, the vq index may not equal to the array inde=
x.
We must save a cfg idx for the names/ctx/callbacks array.



	for (i =3D 0; i < nvqs; ++i) {
		if (!cfg->names[i]) {
			vqs[i] =3D NULL;
			continue;
		}

		cfg->cfg_idx =3D i;
		vqs[i] =3D vp_setup_vq(vdev, queue_idx++, cfg, VIRTIO_MSI_NO_VECTOR);
		if (IS_ERR(vqs[i])) {
			err =3D PTR_ERR(vqs[i]);
			goto out_del_vqs;
		}
	}

notice "i" and "queue_idx"

Thanks.


>=20
> > +       unsigned int cfg_idx;
> > +
> > +       struct virtqueue **vqs;
> > +       vq_callback_t **callbacks;
> > +       const char *const *names;
> > +       const bool *ctx;
> > +       struct irq_affinity *desc;
> > +};
> > +
> >  struct virtio_config_ops {
> >         void (*get)(struct virtio_device *vdev, unsigned offset,
> >                     void *buf, unsigned len);

[...]

> > diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
> > index 9b33df741b63..0de46ed17cc0 100644
> > --- a/include/linux/virtio_ring.h
> > +++ b/include/linux/virtio_ring.h
> > @@ -5,6 +5,7 @@
> >  #include <asm/barrier.h>
> >  #include <linux/irqreturn.h>
> >  #include <uapi/linux/virtio_ring.h>
> > +#include <linux/virtio_config.h>
> >
> >  /*
> >   * Barriers in virtio are tricky.  Non-SMP virtio guests can't assume
> > @@ -60,38 +61,25 @@ struct virtio_device;
> >  struct virtqueue;
> >  struct device;
> >
> > +struct transport_vq_config {
>=20
> To reduce the confusion, let's rename this as "vq_transport_config"

OK

Thanks.


>=20
> Thanks
>=20

