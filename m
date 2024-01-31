Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4256DC47DDF
	for <linux-um@archiver.kernel.org>; Wed, 31 Jan 2024 09:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l2gdg9RDObpqK4bkMt73JUbXQJSSaxJiWlkmE80gR1M=; b=LjRgo9qQyFjeyXlIjScJ1doMKf
	W8lV6/PEKutqBP22b6+BSP7fp6IqVJna7hLLZTdoTffj/iJ0hovbavdVRUycLSsepgkwhIWFe2OBq
	mgr8PFD3lqOPmOYI68jh16yszFbAIA5v2rCb5BElkd2N5BproYF3Q900Ld40niGwhjw9/dIkMu9/X
	jU2kNJIE9VH5gSd6dOBOJ9GiJ7uako0rlLvfwtKd9/SIWP9FMzgqJi1y/Gp2HRrwL58IKeES1r/BX
	QblU2jn6j45m3gKLheObS+k7TSNKYvKwVIhVOZ9Q/EjW3SFBRPo/wby5Zkz1+YYx2HEPHap0loYwM
	dwrMVBGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV6fW-00000002NP4-3eq2;
	Wed, 31 Jan 2024 09:14:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV6fT-00000002NMw-3rqa
	for linux-um@lists.infradead.org;
	Wed, 31 Jan 2024 09:14:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706692441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l2gdg9RDObpqK4bkMt73JUbXQJSSaxJiWlkmE80gR1M=;
	b=JrkOcMHLgqQbau73nC9OMCeAkzMG2wIgUv/Yzgz0MKEHhXSH2JaQ/Lk4LybOCom168i/b5
	rRyahPAdc92/oNV5q12eqOxLtheCsfTkUG8aBMqy4Y1M+IzKh7Oc6h9yvTub4Q0FjEJrkn
	0e/pCWUqPNhIjzN1kia1K61+h2UogFY=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339--Dx_FEZcO2uVuyxurysoNg-1; Wed, 31 Jan 2024 04:12:32 -0500
X-MC-Unique: -Dx_FEZcO2uVuyxurysoNg-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-598b4d37248so4337028eaf.1
        for <linux-um@lists.infradead.org>; Wed, 31 Jan 2024 01:12:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706692351; x=1707297151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2gdg9RDObpqK4bkMt73JUbXQJSSaxJiWlkmE80gR1M=;
        b=hVjk9HGXOFXr7iZQ9AHrWiJka44fgxa/9w/Aw51sVETyk4suRZg3Qn+QBU+syEaFxA
         Hz7D6HzAsAjlUSLbhQoHVqVAwLeLsb3eUfaR1Y4e9w+/dIu3ofkYI6O+a4ZEoJyxqyXo
         OxmUo/aMJHdfyLXg+eMxc34CCCB0CxxDo3cnRGEUuu4GQtyNiP2pD6jl6IxyuLaGfxaH
         khyhYVTXiKU5JBZgP9pXzD/XoxqLq+Kru5c2DPYWWLYL7oqzE/cZBWFUfE0AaHpxSc1V
         DOzMa+JRYt1vVqJxxqgW7DE9VrSTajr+Q4VIrXXvnfpx3BjTaPmL1OOpXuP05PXXySso
         2MAQ==
X-Gm-Message-State: AOJu0YypgAyc15VG0d65yBQyFI/2HBGjd+//3jZXHPMCt5BpWz84hIoF
	hB5umMTH/ry7Q/l1rypvHPYWmsYqgM8m6QhlDP1XIPtDtlLVaEAiLtXmtfp7Zers+wTuA0zLatw
	CSYJeBhn6pWslAGdSaF2jK29YZao4Gf7ZeCh67qdHusaycTVFm0JFPy2mylRlAaTdyCXCCumQQ4
	NMdz56sw52uKTDis5kjWOQSsuYPfBD1rco0ZX1
X-Received: by 2002:a05:6358:999e:b0:176:40d5:2bd5 with SMTP id j30-20020a056358999e00b0017640d52bd5mr828182rwb.6.1706692351278;
        Wed, 31 Jan 2024 01:12:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5NRr7GtdKMQ4owCABZALmFK8Ctmda9rRzFtgneCkccV/xIa+/8MmJgT2OLhfyx42b2XxtxqmD6xFHD/Xq8vY=
X-Received: by 2002:a05:6358:999e:b0:176:40d5:2bd5 with SMTP id
 j30-20020a056358999e00b0017640d52bd5mr828142rwb.6.1706692350948; Wed, 31 Jan
 2024 01:12:30 -0800 (PST)
MIME-Version: 1.0
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com> <20240130114224.86536-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240130114224.86536-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Jan 2024 17:12:19 +0800
Message-ID: <CACGkMEvmqVpcXCaF6f24N6gTN2yHJOeu0bL4JBYL4Zmyg8C2sQ@mail.gmail.com>
Subject: Re: [PATCH vhost 02/17] virtio_ring: packed: remove double check of
 the unmap ops
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Benjamin Berg <benjamin.berg@intel.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-um@lists.infradead.org, 
	netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_011404_069630_B28687BF 
X-CRM114-Status: GOOD (  31.64  )
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

On Tue, Jan 30, 2024 at 7:42=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> In the functions vring_unmap_extra_packed and vring_unmap_desc_packed,
> multiple checks are made whether unmap is performed and whether it is
> INDIRECT.
>
> These two functions are usually called in a loop, and we should put the
> check outside the loop.
>
> And we unmap the descs with VRING_DESC_F_INDIRECT on the same path with
> other descs, that make the thing more complex. If we distinguish the
> descs with VRING_DESC_F_INDIRECT before unmap, thing will be clearer.
>
> 1. only one desc of the desc table is used, we do not need the loop
> 2. the called unmap api is difference from the other desc
> 3. the vq->premapped is not needed to check
> 4. the vq->indirect is not needed to check
> 5. the state->indir_desc must not be null
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 76 ++++++++++++++++++------------------
>  1 file changed, 39 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 4677831e6c26..7280a1706cca 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1220,6 +1220,7 @@ static u16 packed_last_used(u16 last_used_idx)
>         return last_used_idx & ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR));
>  }
>
> +/* caller must check vring_need_unmap_buffer() */
>  static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
>                                      const struct vring_desc_extra *extra=
)
>  {
> @@ -1227,33 +1228,18 @@ static void vring_unmap_extra_packed(const struct=
 vring_virtqueue *vq,
>
>         flags =3D extra->flags;
>
> -       if (flags & VRING_DESC_F_INDIRECT) {
> -               if (!vq->use_dma_api)
> -                       return;
> -
> -               dma_unmap_single(vring_dma_dev(vq),
> -                                extra->addr, extra->len,
> -                                (flags & VRING_DESC_F_WRITE) ?
> -                                DMA_FROM_DEVICE : DMA_TO_DEVICE);
> -       } else {
> -               if (!vring_need_unmap_buffer(vq))
> -                       return;
> -
> -               dma_unmap_page(vring_dma_dev(vq),
> -                              extra->addr, extra->len,
> -                              (flags & VRING_DESC_F_WRITE) ?
> -                              DMA_FROM_DEVICE : DMA_TO_DEVICE);
> -       }
> +       dma_unmap_page(vring_dma_dev(vq),
> +                      extra->addr, extra->len,
> +                      (flags & VRING_DESC_F_WRITE) ?
> +                      DMA_FROM_DEVICE : DMA_TO_DEVICE);
>  }
>
> +/* caller must check vring_need_unmap_buffer() */
>  static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
>                                     const struct vring_packed_desc *desc)
>  {
>         u16 flags;
>
> -       if (!vring_need_unmap_buffer(vq))
> -               return;
> -
>         flags =3D le16_to_cpu(desc->flags);
>
>         dma_unmap_page(vring_dma_dev(vq),
> @@ -1329,7 +1315,7 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>                         total_sg * sizeof(struct vring_packed_desc),
>                         DMA_TO_DEVICE);
>         if (vring_mapping_error(vq, addr)) {
> -               if (vq->premapped)
> +               if (!vring_need_unmap_buffer(vq))
>                         goto free_desc;
>
>                 goto unmap_release;
> @@ -1344,10 +1330,11 @@ static int virtqueue_add_indirect_packed(struct v=
ring_virtqueue *vq,
>                 vq->packed.desc_extra[id].addr =3D addr;
>                 vq->packed.desc_extra[id].len =3D total_sg *
>                                 sizeof(struct vring_packed_desc);
> -               vq->packed.desc_extra[id].flags =3D VRING_DESC_F_INDIRECT=
 |
> -                                                 vq->packed.avail_used_f=
lags;
>         }
>
> +       vq->packed.desc_extra[id].flags =3D VRING_DESC_F_INDIRECT |
> +               vq->packed.avail_used_flags;

Is this a bug fix? Or if we only need to check _F_INDIRECT, we can
simply avoid doing this by checking vq->indirect && state->indir_desc?

> +
>         /*
>          * A driver MUST NOT make the first descriptor in the list
>          * available before all subsequent descriptors comprising
> @@ -1388,6 +1375,8 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>  unmap_release:
>         err_idx =3D i;
>
> +       WARN_ON(!vring_need_unmap_buffer(vq));

Nitpick, using BUG_ON might be better as it may lead to unexpected
results which we can't recover from.

> +
>         for (i =3D 0; i < err_idx; i++)
>                 vring_unmap_desc_packed(vq, &desc[i]);
>
> @@ -1484,9 +1473,10 @@ static inline int virtqueue_add_packed(struct virt=
queue *_vq,
>                         if (unlikely(vring_need_unmap_buffer(vq))) {
>                                 vq->packed.desc_extra[curr].addr =3D addr=
;
>                                 vq->packed.desc_extra[curr].len =3D sg->l=
ength;
> -                               vq->packed.desc_extra[curr].flags =3D
> -                                       le16_to_cpu(flags);
>                         }
> +
> +                       vq->packed.desc_extra[curr].flags =3D le16_to_cpu=
(flags);
> +
>                         prev =3D curr;
>                         curr =3D vq->packed.desc_extra[curr].next;
>
> @@ -1536,6 +1526,8 @@ static inline int virtqueue_add_packed(struct virtq=
ueue *_vq,
>
>         vq->packed.avail_used_flags =3D avail_used_flags;
>
> +       WARN_ON(!vring_need_unmap_buffer(vq));
> +
>         for (n =3D 0; n < total_sg; n++) {
>                 if (i =3D=3D err_idx)
>                         break;
> @@ -1605,7 +1597,9 @@ static void detach_buf_packed(struct vring_virtqueu=
e *vq,
>         struct vring_desc_state_packed *state =3D NULL;
>         struct vring_packed_desc *desc;
>         unsigned int i, curr;
> +       u16 flags;
>
> +       flags =3D vq->packed.desc_extra[id].flags;
>         state =3D &vq->packed.desc_state[id];
>
>         /* Clear data ptr. */
> @@ -1615,22 +1609,32 @@ static void detach_buf_packed(struct vring_virtqu=
eue *vq,
>         vq->free_head =3D id;
>         vq->vq.num_free +=3D state->num;
>
> -       if (unlikely(vring_need_unmap_buffer(vq))) {
> -               curr =3D id;
> -               for (i =3D 0; i < state->num; i++) {
> -                       vring_unmap_extra_packed(vq,
> -                                                &vq->packed.desc_extra[c=
urr]);
> -                       curr =3D vq->packed.desc_extra[curr].next;
> +       if (!(flags & VRING_DESC_F_INDIRECT)) {
> +               if (vring_need_unmap_buffer(vq)) {
> +                       curr =3D id;
> +                       for (i =3D 0; i < state->num; i++) {
> +                               vring_unmap_extra_packed(vq,
> +                                                        &vq->packed.desc=
_extra[curr]);
> +                               curr =3D vq->packed.desc_extra[curr].next=
;
> +                       }

So before the change, we had:

        if (unlikely(vq->do_unmap)) {
                curr =3D id;
                for (i =3D 0; i < state->num; i++) {
                        vring_unmap_extra_packed(vq,
                                                 &vq->packed.desc_extra[cur=
r]);
                        curr =3D vq->packed.desc_extra[curr].next;
                }
        }

This looks like a bug as we should unmap the indirect descriptor
regradless of whether do_unmap is true or false.

If yes, we need a independent fix instead of squashing it in this patch?

>                 }
> -       }
>
> -       if (vq->indirect) {
> +               if (ctx)
> +                       *ctx =3D state->indir_desc;
> +       } else {
> +               const struct vring_desc_extra *extra;
>                 u32 len;
>
> +               if (vq->use_dma_api) {
> +                       extra =3D &vq->packed.desc_extra[id];
> +                       dma_unmap_single(vring_dma_dev(vq),
> +                                        extra->addr, extra->len,
> +                                        (flags & VRING_DESC_F_WRITE) ?
> +                                        DMA_FROM_DEVICE : DMA_TO_DEVICE)=
;
> +               }
> +

Thanks


