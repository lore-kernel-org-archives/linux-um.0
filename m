Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49836C47DDB
	for <linux-um@archiver.kernel.org>; Thu,  1 Feb 2024 06:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Date:Subject:Message-ID:
	Reply-To:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MEWzvms1R/ORBUAlAqjpfFPhXkqBhuuRUlVjrBLyH30=; b=dAGEK7sox8eD3egLO+EPs+B6QV
	d82Urz5dqlLXK250VFv7eYaIRoRu+EUG+0L6sHcP/vmoXB1ryPFI8u5+r7QG7LRTT5z251Xz2+xou
	r0j+kdApJzFCsGu87FKQlbD85HKkA4OsN9NM81aX43CDHJvwRRyf5bIkkGDxnPNLKsUKuXI1LpOQk
	BFFQTXkS3pePQMitospa7sSvuthKCQkDZ2ijZXupxchQD1p2BLm61KMmKHqkMuxiQ0Jl8xze01ZjZ
	vhZLFz0rqdZwTiEJHTQIMQ36BNURTGn5rFpaykEEmuWxQNzbAILWkMX1wUnPCqJUgeBURJXkDKDAy
	XLwKpwvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVQCo-00000006iKP-2XvI;
	Thu, 01 Feb 2024 06:05:46 +0000
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVQCl-00000006iIj-3HEG
	for linux-um@lists.infradead.org;
	Thu, 01 Feb 2024 06:05:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706767541; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=MEWzvms1R/ORBUAlAqjpfFPhXkqBhuuRUlVjrBLyH30=;
	b=SXrzuc1beA7ecVnnaG+LQ0bvTg6TwysNSiscWiiP8lQDp7nIJDnNrxCJR2h9MV7M33l4oHOAvxlvYRSKOfKsD/E1UvuXFricGR6z4v8OY53GDrGu1hQjUCxyZtDwgQt1MsiTQno8RAYthOodPfQMe/ngGxfzXV0N1IEUQFKZ9Fo=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=36;SR=0;TI=SMTPD_---0W.om0fl_1706767538;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.om0fl_1706767538)
          by smtp.aliyun-inc.com;
          Thu, 01 Feb 2024 14:05:40 +0800
Message-ID: <1706767497.2529867-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 06/17] virtio_ring: no store dma info when unmap is not needed
Date: Thu, 1 Feb 2024 14:04:57 +0800
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
 <20240130114224.86536-7-xuanzhuo@linux.alibaba.com>
 <CACGkMEtNCjvtDWySzeAqETGZtBSL0MR6=JySBBtm3=s19wB=1w@mail.gmail.com>
In-Reply-To: <CACGkMEtNCjvtDWySzeAqETGZtBSL0MR6=JySBBtm3=s19wB=1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_220544_003320_448A4E1A 
X-CRM114-Status: GOOD (  26.38  )
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

On Wed, 31 Jan 2024 17:12:29 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Jan 30, 2024 at 7:42=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > As discussed:
> > http://lore.kernel.org/all/CACGkMEug-=3DC+VQhkMYSgUKMC=3D=3D04m7-uem_yC=
21bgGkKZh845w@mail.gmail.com
> >
> > When the vq is premapped mode, the driver manages the dma
> > info is a good way.
> >
> > So this commit make the virtio core not to store the dma
> > info and release the memory which is used to store the dma
> > info.
> >
> > If the use_dma_api is false, the memory is also not allocated.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 89 ++++++++++++++++++++++++++++--------
> >  1 file changed, 70 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 831667a57429..5bea25167259 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -94,12 +94,15 @@ struct vring_desc_state_packed {
> >  };
> >
> >  struct vring_desc_extra {
> > -       dma_addr_t addr;                /* Descriptor DMA addr. */
> > -       u32 len;                        /* Descriptor length. */
> >         u16 flags;                      /* Descriptor flags. */
> >         u16 next;                       /* The next desc state in a lis=
t. */
> >  };
> >
> > +struct vring_desc_dma {
> > +       dma_addr_t addr;                /* Descriptor DMA addr. */
> > +       u32 len;                        /* Descriptor length. */
> > +};
> > +
> >  struct vring_virtqueue_split {
> >         /* Actual memory layout for this queue. */
> >         struct vring vring;
> > @@ -116,6 +119,7 @@ struct vring_virtqueue_split {
> >         /* Per-descriptor state. */
> >         struct vring_desc_state_split *desc_state;
> >         struct vring_desc_extra *desc_extra;
> > +       struct vring_desc_dma *desc_dma;
> >
> >         /* DMA address and size information */
> >         dma_addr_t queue_dma_addr;
> > @@ -156,6 +160,7 @@ struct vring_virtqueue_packed {
> >         /* Per-descriptor state. */
> >         struct vring_desc_state_packed *desc_state;
> >         struct vring_desc_extra *desc_extra;
> > +       struct vring_desc_dma *desc_dma;
> >
> >         /* DMA address and size information */
> >         dma_addr_t ring_dma_addr;
> > @@ -472,13 +477,14 @@ static unsigned int vring_unmap_one_split(const s=
truct vring_virtqueue *vq,
> >                                           unsigned int i)
> >  {
> >         struct vring_desc_extra *extra =3D vq->split.desc_extra;
> > +       struct vring_desc_dma *dma =3D vq->split.desc_dma;
> >         u16 flags;
> >
> >         flags =3D extra[i].flags;
> >
> >         dma_unmap_page(vring_dma_dev(vq),
> > -                      extra[i].addr,
> > -                      extra[i].len,
> > +                      dma[i].addr,
> > +                      dma[i].len,
> >                        (flags & VRING_DESC_F_WRITE) ?
> >                        DMA_FROM_DEVICE : DMA_TO_DEVICE);
> >
> > @@ -535,8 +541,11 @@ static inline unsigned int virtqueue_add_desc_spli=
t(struct virtqueue *vq,
> >                 next =3D extra[i].next;
> >                 desc[i].next =3D cpu_to_virtio16(vq->vdev, next);
> >
> > -               extra[i].addr =3D addr;
> > -               extra[i].len =3D len;
> > +               if (vring->split.desc_dma) {
> > +                       vring->split.desc_dma[i].addr =3D addr;
> > +                       vring->split.desc_dma[i].len =3D len;
> > +               }
> > +
> >                 extra[i].flags =3D flags;
> >         } else
> >                 next =3D virtio16_to_cpu(vq->vdev, desc[i].next);
> > @@ -1072,16 +1081,26 @@ static void virtqueue_vring_attach_split(struct=
 vring_virtqueue *vq,
> >         vq->free_head =3D 0;
> >  }
> >
> > -static int vring_alloc_state_extra_split(struct vring_virtqueue_split =
*vring_split)
> > +static int vring_alloc_state_extra_split(struct vring_virtqueue_split =
*vring_split,
> > +                                        bool need_unmap)
> >  {
> >         struct vring_desc_state_split *state;
> >         struct vring_desc_extra *extra;
> > +       struct vring_desc_dma *dma;
> >         u32 num =3D vring_split->vring.num;
> >
> >         state =3D kmalloc_array(num, sizeof(struct vring_desc_state_spl=
it), GFP_KERNEL);
> >         if (!state)
> >                 goto err_state;
> >
> > +       if (need_unmap) {
> > +               dma =3D kmalloc_array(num, sizeof(struct vring_desc_dma=
), GFP_KERNEL);
> > +               if (!dma)
> > +                       goto err_dma;
> > +       } else {
> > +               dma =3D NULL;
> > +       }
> > +
> >         extra =3D vring_alloc_desc_extra(num);
> >         if (!extra)
> >                 goto err_extra;
> > @@ -1090,9 +1109,12 @@ static int vring_alloc_state_extra_split(struct =
vring_virtqueue_split *vring_spl
> >
> >         vring_split->desc_state =3D state;
> >         vring_split->desc_extra =3D extra;
> > +       vring_split->desc_dma =3D dma;
> >         return 0;
> >
> >  err_extra:
> > +       kfree(dma);
> > +err_dma:
> >         kfree(state);
> >  err_state:
> >         return -ENOMEM;
> > @@ -1108,6 +1130,7 @@ static void vring_free_split(struct vring_virtque=
ue_split *vring_split,
> >
> >         kfree(vring_split->desc_state);
> >         kfree(vring_split->desc_extra);
> > +       kfree(vring_split->desc_dma);
> >  }
> >
> >  static int vring_alloc_queue_split(struct vring_virtqueue_split *vring=
_split,
> > @@ -1209,7 +1232,8 @@ static int virtqueue_resize_split(struct virtqueu=
e *_vq, u32 num)
> >         if (err)
> >                 goto err;
> >
> > -       err =3D vring_alloc_state_extra_split(&vring_split);
> > +       err =3D vring_alloc_state_extra_split(&vring_split,
> > +                                           vring_need_unmap_buffer(vq)=
);
> >         if (err)
> >                 goto err_state_extra;
> >
> > @@ -1245,14 +1269,16 @@ static u16 packed_last_used(u16 last_used_idx)
> >
> >  /* caller must check vring_need_unmap_buffer() */
> >  static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
> > -                                    const struct vring_desc_extra *ext=
ra)
> > +                                    unsigned int i)
> >  {
> > +       const struct vring_desc_extra *extra =3D &vq->packed.desc_extra=
[i];
> > +       const struct vring_desc_dma *dma =3D &vq->packed.desc_dma[i];
> >         u16 flags;
> >
> >         flags =3D extra->flags;
>
> I don't think this can be compiled.

I do not find any error.
Could you say more?

Thanks.


>
> Thanks
>

