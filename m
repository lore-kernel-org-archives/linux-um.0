Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548E1C47DDB
	for <linux-um@archiver.kernel.org>; Thu,  1 Feb 2024 06:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Date:Subject:Message-ID:
	Reply-To:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TWr1CQEd6xDFjrk3l/xQeYg2YrwKV9kMpWG3h49S4As=; b=NLu7OTLu9rGpuQJKexCOER2yEV
	rqz+nqD4z4jnqJm/lTzM3PKblcGDxogcrO8JTTlALTgl4EpMjoPJ7mZaYfrCAJnMKxTtaTxPEl9AP
	mO7ukT/Kzq/sRLJjLb8mz1ZizXmolEooUaFWGSqiTtUTZaTFstU1F9qYKpLf5qnBubggsvmMkilD5
	hAZXYFlxVMxm2dKJsddT9guiWrl5cYMz5sFAWHoE1hAdsbZFAfLCOS0RoFCLiYvckYRldwHsFVAZG
	XMsDETezYnOVrB/WiSDpYdNscwL5clINbY9qiXLfVoumNGZRZYHwE+XAKjI+/pUrjqagV1/+O8ezC
	0RScGKsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVQs3-00000006ouW-0AIW;
	Thu, 01 Feb 2024 06:48:23 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVQrz-00000006ot2-0HXw
	for linux-um@lists.infradead.org;
	Thu, 01 Feb 2024 06:48:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706770094; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=TWr1CQEd6xDFjrk3l/xQeYg2YrwKV9kMpWG3h49S4As=;
	b=Pq9PIdsvAqFuTGSs8Hr0zLOR3Q50Vnnna5ExBx41bH2HsopKdNgg/mBapxtA8MiJAAUIWqQxX/Og1W3KEzzpFkFQIahzDX46m9L23+LsB+7owS0lZHGsAQ1TuMs9jveOpC9p3cSlqoGlcrD+pZD9/gDcDXkFLc8OY4j4n1rDRXU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=36;SR=0;TI=SMTPD_---0W.pYjzd_1706770089;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.pYjzd_1706770089)
          by smtp.aliyun-inc.com;
          Thu, 01 Feb 2024 14:48:10 +0800
Message-ID: <1706769826.0586398-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 04/17] virtio_ring: split: remove double check of the unmap ops
Date: Thu, 1 Feb 2024 14:43:46 +0800
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
 <20240130114224.86536-5-xuanzhuo@linux.alibaba.com>
 <CACGkMEs-wUa_z_tGYEwBf7EVJAtuJdkX4HAdjqMXHEM1ys-gKQ@mail.gmail.com>
In-Reply-To: <CACGkMEs-wUa_z_tGYEwBf7EVJAtuJdkX4HAdjqMXHEM1ys-gKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_224819_649722_334F1824 
X-CRM114-Status: GOOD (  28.93  )
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

On Wed, 31 Jan 2024 17:12:22 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Jan 30, 2024 at 7:42=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > In the functions vring_unmap_one_split and
> > vring_unmap_one_split_indirect,
> > multiple checks are made whether unmap is performed and whether it is
> > INDIRECT.
> >
> > These two functions are usually called in a loop, and we should put the
> > check outside the loop.
> >
> > And we unmap the descs with VRING_DESC_F_INDIRECT on the same path with
> > other descs, that make the thing more complex. If we distinguish the
> > descs with VRING_DESC_F_INDIRECT before unmap, thing will be clearer.
> >
> > 1. only one desc of the desc table is used, we do not need the loop
> > 2. the called unmap api is difference from the other desc
> > 3. the vq->premapped is not needed to check
> > 4. the vq->indirect is not needed to check
> > 5. the state->indir_desc must not be null
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 80 ++++++++++++++++++------------------
> >  1 file changed, 39 insertions(+), 41 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index dd03bc5a81fe..2b41fdbce975 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -452,9 +452,6 @@ static void vring_unmap_one_split_indirect(const st=
ruct vring_virtqueue *vq,
> >  {
> >         u16 flags;
> >
> > -       if (!vring_need_unmap_buffer(vq))
> > -               return;
> > -
> >         flags =3D virtio16_to_cpu(vq->vq.vdev, desc->flags);
> >
> >         dma_unmap_page(vring_dma_dev(vq),
> > @@ -472,27 +469,12 @@ static unsigned int vring_unmap_one_split(const s=
truct vring_virtqueue *vq,
> >
> >         flags =3D extra[i].flags;
> >
> > -       if (flags & VRING_DESC_F_INDIRECT) {
> > -               if (!vq->use_dma_api)
> > -                       goto out;
> > -
> > -               dma_unmap_single(vring_dma_dev(vq),
> > -                                extra[i].addr,
> > -                                extra[i].len,
> > -                                (flags & VRING_DESC_F_WRITE) ?
> > -                                DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > -       } else {
> > -               if (!vring_need_unmap_buffer(vq))
> > -                       goto out;
> > -
> > -               dma_unmap_page(vring_dma_dev(vq),
> > -                              extra[i].addr,
> > -                              extra[i].len,
> > -                              (flags & VRING_DESC_F_WRITE) ?
> > -                              DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > -       }
> > +       dma_unmap_page(vring_dma_dev(vq),
> > +                      extra[i].addr,
> > +                      extra[i].len,
> > +                      (flags & VRING_DESC_F_WRITE) ?
> > +                      DMA_FROM_DEVICE : DMA_TO_DEVICE);
> >
> > -out:
> >         return extra[i].next;
> >  }
> >
> > @@ -660,7 +642,7 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
> >                         vq, desc, total_sg * sizeof(struct vring_desc),
> >                         DMA_TO_DEVICE);
> >                 if (vring_mapping_error(vq, addr)) {
> > -                       if (vq->premapped)
> > +                       if (!vring_need_unmap_buffer(vq))
> >                                 goto free_indirect;
> >
> >                         goto unmap_release;
> > @@ -713,6 +695,9 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
> >         return 0;
> >
> >  unmap_release:
> > +
> > +       WARN_ON(!vring_need_unmap_buffer(vq));
> > +
> >         err_idx =3D i;
> >
> >         if (indirect)
> > @@ -774,34 +759,42 @@ static void detach_buf_split(struct vring_virtque=
ue *vq, unsigned int head,
> >  {
> >         unsigned int i, j;
> >         __virtio16 nextflag =3D cpu_to_virtio16(vq->vq.vdev, VRING_DESC=
_F_NEXT);
> > +       u16 flags;
> >
> >         /* Clear data ptr. */
> >         vq->split.desc_state[head].data =3D NULL;
> > +       flags =3D vq->split.desc_extra[head].flags;
> >
> >         /* Put back on free list: unmap first-level descriptors and fin=
d end */
> >         i =3D head;
> >
> > -       while (vq->split.vring.desc[i].flags & nextflag) {
> > -               vring_unmap_one_split(vq, i);
> > -               i =3D vq->split.desc_extra[i].next;
> > -               vq->vq.num_free++;
> > -       }
> > -
> > -       vring_unmap_one_split(vq, i);
> > -       vq->split.desc_extra[i].next =3D vq->free_head;
> > -       vq->free_head =3D head;
> > +       if (!(flags & VRING_DESC_F_INDIRECT)) {
>
> So during add we do:
>
>         if (!indirect && vring_need_unmap_buffer(vq))
>                 vq->split.desc_extra[prev & (vq->split.vring.num - 1)].fl=
ags &=3D
>                         ~VRING_DESC_F_NEXT;


This does not affect this patch.

1. this just considers the VRING_DESC_F_NEXT of desc_extra.flags
2. the desc_extra.flags is updated by virtqueue_add_desc_split()

So for desc_extra.flags & VRING_DESC_F_INDIRECT, that is right.

Thanks.


>
> Then using flags here unconditionally seems not reliable.
>
> I post a patch to store flags unconditionally at:
>
> https://lore.kernel.org/all/20220224122655-mutt-send-email-mst@kernel.org/
>
> > +               while (vq->split.vring.desc[i].flags & nextflag) {
> > +                       if (vring_need_unmap_buffer(vq))
> > +                               vring_unmap_one_split(vq, i);
> > +                       i =3D vq->split.desc_extra[i].next;
> > +                       vq->vq.num_free++;
> > +               }
> >
> > -       /* Plus final descriptor */
> > -       vq->vq.num_free++;
> > +               if (vring_need_unmap_buffer(vq))
> > +                       vring_unmap_one_split(vq, i);
> >
> > -       if (vq->indirect) {
> > +               if (ctx)
> > +                       *ctx =3D vq->split.desc_state[head].indir_desc;
> > +       } else {
> >                 struct vring_desc *indir_desc =3D
> >                                 vq->split.desc_state[head].indir_desc;
> >                 u32 len;
> >
> > -               /* Free the indirect table, if any, now that it's unmap=
ped. */
> > -               if (!indir_desc)
> > -                       return;
> > +               if (vq->use_dma_api) {
> > +                       struct vring_desc_extra *extra =3D vq->split.de=
sc_extra;
> > +
> > +                       dma_unmap_single(vring_dma_dev(vq),
> > +                                        extra[i].addr,
> > +                                        extra[i].len,
> > +                                        (flags & VRING_DESC_F_WRITE) ?
> > +                                        DMA_FROM_DEVICE : DMA_TO_DEVIC=
E);
> > +               }
>
> Note that there's a following
>
> BUG_ON(!(vq->split.desc_extra[head].flags &
>                                 VRING_DESC_F_INDIRECT));
>
> Which I think we can remove.
>
> Thanks
>

