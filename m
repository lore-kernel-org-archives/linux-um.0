Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96ACFC47DDF
	for <linux-um@archiver.kernel.org>; Wed, 31 Jan 2024 09:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VJZkeylYKHHxcFFB0bIOJ/hK42jYe/laqdrK+DNO0NQ=; b=Bf2nUvbNKy/edU6++9CfD1o13j
	3RI5Zj/1bT93w6Frn6hKBZzoUwPKEvzIqQ1hZatm600RXRnpUl8KbWw7Ntv8723e0tZaQAprQWgJ5
	+8xUuWDtV/w9YrPxvpo9ROgJIhYTiG9/dR89DoKYiZzDwhJeU6reNAPoRP4sd4vmJRAAx+tXs2PZb
	3z4GaJI+RZPhhTmIZji3/RwtqVIN1u6Ap86dow72uabkMrQwKNyMUm5951F0vHuKgTkmghElSVgpF
	1GSEha3nRR4GCAUAYHVBW9KcBWlJfbHuUWXbe6ZsG2AASokIEwU+hBHJ4dAbQh7REJoUoIwmgnHEN
	34woy5oA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV6ff-00000002NU2-0jek;
	Wed, 31 Jan 2024 09:14:15 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV6fd-00000002NSP-26V5
	for linux-um@bombadil.infradead.org;
	Wed, 31 Jan 2024 09:14:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=VJZkeylYKHHxcFFB0bIOJ/hK42jYe/laqdrK+DNO0NQ=; b=RQlkjnNaiEZef1PPM9zN9InNVO
	sBGpP+onyr22we4kaQxfiD3hlbfBMF1vz2M8RQuL9ykMTLaCwHeMWEY9eEXWCqlokXPkqteNAEC6/
	mykaCtLtEZkNYzp75vWi2SHg9NbmAgE8Vn/M+aPrPdCFIKiMC7Z5ELvJcTxFP+tT0Jh7L3evquv6g
	qRVbFMWCm/6ForB4mNa81kHTnPaKG6OpmY7GNbgnQvtwGNaKEQzuXlOV1F1T6vHZxU88zwJHyuK8d
	ds7oRxmxAYR5JFlp4QMlPwbXOOFE7i06+sTbzmpTYKvVxothaM/L4F0EJ9qLVxGtgNBcq3/YFkWoo
	W9OOdZbg==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV6fS-00000008tiH-3gGq
	for linux-um@lists.infradead.org;
	Wed, 31 Jan 2024 09:14:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706692441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VJZkeylYKHHxcFFB0bIOJ/hK42jYe/laqdrK+DNO0NQ=;
	b=SCfIWCDblVgSn1P5MfVCmBLRX+NoUnL06hA1Jj7JVC2U5bGaj6A01iqSFznwb0v8D+HNH8
	zJXaOloRl/qu1lYSvjRQ3rwEvLAf0mBW6xiZ0E5RPNHQYGd3E2aw0AYkZ2rbUusgN3h3Pd
	YI7ehaM9SzweEpfHBBsdLwfP62kpB6g=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706692441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VJZkeylYKHHxcFFB0bIOJ/hK42jYe/laqdrK+DNO0NQ=;
	b=SCfIWCDblVgSn1P5MfVCmBLRX+NoUnL06hA1Jj7JVC2U5bGaj6A01iqSFznwb0v8D+HNH8
	zJXaOloRl/qu1lYSvjRQ3rwEvLAf0mBW6xiZ0E5RPNHQYGd3E2aw0AYkZ2rbUusgN3h3Pd
	YI7ehaM9SzweEpfHBBsdLwfP62kpB6g=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-kYDh1H7yPIi_21a4Cflh0Q-1; Wed, 31 Jan 2024 04:12:36 -0500
X-MC-Unique: kYDh1H7yPIi_21a4Cflh0Q-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3bd4b623e4aso8946058b6e.3
        for <linux-um@lists.infradead.org>; Wed, 31 Jan 2024 01:12:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706692355; x=1707297155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJZkeylYKHHxcFFB0bIOJ/hK42jYe/laqdrK+DNO0NQ=;
        b=iSlw9FWSsr4hcSlZTVlmTv/k0OtxnZmOtkpFp2Vwp0ooGDLWIJm8VTf5+gxJPVo+m9
         xEHk5drVOtVbh5vkSzzKUEUXPQ3lEicfR9H2V+rbUDuMRnzbjaJ2NZW2xixkFO0pFvOf
         oUQ/DHd24eNX0qzxikYFoyGcDuxjo1Te6hq1GJZ3Hp9ejP0Oi9iUadVqB8RVejar99T9
         TyUNvytF11aMl14VWK4WVF4KSFrQRoiJP5+Ao8nIuHuHD5adU3aQQ7cY39vajaxvuJj8
         rO56nvDjZX0ksy11pX6iO5MXwY+I9vrFlQqIXaoJ5AFJO7Or/a2Of7NbNndOkTP9cpvK
         d11A==
X-Gm-Message-State: AOJu0YwT54coMFL+3qRXj/VnVQmBLppsw4NguS98iVTdFmiPaW7uC0yl
	FVC6J+1IY2V/szRkOPfLrC357wLX4lzZOjRh4wDHPn5HWg7xXLsrCC9d0HwmP4qhZlhslaCfrWf
	QmGjpSbEHPytdCfplQWp+7BLmU1vnXg8rUE0GXZLpltqfItIlysIfaQZ6yqThkJVn1HRIaD14m0
	OwIhQR3TfolsxxP+Kr5SZyK1CeAI6d35Oki669
X-Received: by 2002:a05:6808:10d0:b0:3be:b99e:c4b5 with SMTP id s16-20020a05680810d000b003beb99ec4b5mr1134502ois.49.1706692355410;
        Wed, 31 Jan 2024 01:12:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqf5XhmMZVc/mvQ+v/Dn0eccGIZhcIm1GbAvr8L9HK2CJQtaTuYKH+cdWn6A0p6FI4Vi12/FhvV3cS9wCPbWU=
X-Received: by 2002:a05:6808:10d0:b0:3be:b99e:c4b5 with SMTP id
 s16-20020a05680810d000b003beb99ec4b5mr1134482ois.49.1706692355156; Wed, 31
 Jan 2024 01:12:35 -0800 (PST)
MIME-Version: 1.0
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com> <20240130114224.86536-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240130114224.86536-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Jan 2024 17:12:22 +0800
Message-ID: <CACGkMEs-wUa_z_tGYEwBf7EVJAtuJdkX4HAdjqMXHEM1ys-gKQ@mail.gmail.com>
Subject: Re: [PATCH vhost 04/17] virtio_ring: split: remove double check of
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
X-CRM114-CacheID: sfid-20240131_091404_470558_6CF87573 
X-CRM114-Status: GOOD (  25.23  )
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
> In the functions vring_unmap_one_split and
> vring_unmap_one_split_indirect,
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
>  drivers/virtio/virtio_ring.c | 80 ++++++++++++++++++------------------
>  1 file changed, 39 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index dd03bc5a81fe..2b41fdbce975 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -452,9 +452,6 @@ static void vring_unmap_one_split_indirect(const stru=
ct vring_virtqueue *vq,
>  {
>         u16 flags;
>
> -       if (!vring_need_unmap_buffer(vq))
> -               return;
> -
>         flags =3D virtio16_to_cpu(vq->vq.vdev, desc->flags);
>
>         dma_unmap_page(vring_dma_dev(vq),
> @@ -472,27 +469,12 @@ static unsigned int vring_unmap_one_split(const str=
uct vring_virtqueue *vq,
>
>         flags =3D extra[i].flags;
>
> -       if (flags & VRING_DESC_F_INDIRECT) {
> -               if (!vq->use_dma_api)
> -                       goto out;
> -
> -               dma_unmap_single(vring_dma_dev(vq),
> -                                extra[i].addr,
> -                                extra[i].len,
> -                                (flags & VRING_DESC_F_WRITE) ?
> -                                DMA_FROM_DEVICE : DMA_TO_DEVICE);
> -       } else {
> -               if (!vring_need_unmap_buffer(vq))
> -                       goto out;
> -
> -               dma_unmap_page(vring_dma_dev(vq),
> -                              extra[i].addr,
> -                              extra[i].len,
> -                              (flags & VRING_DESC_F_WRITE) ?
> -                              DMA_FROM_DEVICE : DMA_TO_DEVICE);
> -       }
> +       dma_unmap_page(vring_dma_dev(vq),
> +                      extra[i].addr,
> +                      extra[i].len,
> +                      (flags & VRING_DESC_F_WRITE) ?
> +                      DMA_FROM_DEVICE : DMA_TO_DEVICE);
>
> -out:
>         return extra[i].next;
>  }
>
> @@ -660,7 +642,7 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>                         vq, desc, total_sg * sizeof(struct vring_desc),
>                         DMA_TO_DEVICE);
>                 if (vring_mapping_error(vq, addr)) {
> -                       if (vq->premapped)
> +                       if (!vring_need_unmap_buffer(vq))
>                                 goto free_indirect;
>
>                         goto unmap_release;
> @@ -713,6 +695,9 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>         return 0;
>
>  unmap_release:
> +
> +       WARN_ON(!vring_need_unmap_buffer(vq));
> +
>         err_idx =3D i;
>
>         if (indirect)
> @@ -774,34 +759,42 @@ static void detach_buf_split(struct vring_virtqueue=
 *vq, unsigned int head,
>  {
>         unsigned int i, j;
>         __virtio16 nextflag =3D cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F=
_NEXT);
> +       u16 flags;
>
>         /* Clear data ptr. */
>         vq->split.desc_state[head].data =3D NULL;
> +       flags =3D vq->split.desc_extra[head].flags;
>
>         /* Put back on free list: unmap first-level descriptors and find =
end */
>         i =3D head;
>
> -       while (vq->split.vring.desc[i].flags & nextflag) {
> -               vring_unmap_one_split(vq, i);
> -               i =3D vq->split.desc_extra[i].next;
> -               vq->vq.num_free++;
> -       }
> -
> -       vring_unmap_one_split(vq, i);
> -       vq->split.desc_extra[i].next =3D vq->free_head;
> -       vq->free_head =3D head;
> +       if (!(flags & VRING_DESC_F_INDIRECT)) {

So during add we do:

        if (!indirect && vring_need_unmap_buffer(vq))
                vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flag=
s &=3D
                        ~VRING_DESC_F_NEXT;

Then using flags here unconditionally seems not reliable.

I post a patch to store flags unconditionally at:

https://lore.kernel.org/all/20220224122655-mutt-send-email-mst@kernel.org/

> +               while (vq->split.vring.desc[i].flags & nextflag) {
> +                       if (vring_need_unmap_buffer(vq))
> +                               vring_unmap_one_split(vq, i);
> +                       i =3D vq->split.desc_extra[i].next;
> +                       vq->vq.num_free++;
> +               }
>
> -       /* Plus final descriptor */
> -       vq->vq.num_free++;
> +               if (vring_need_unmap_buffer(vq))
> +                       vring_unmap_one_split(vq, i);
>
> -       if (vq->indirect) {
> +               if (ctx)
> +                       *ctx =3D vq->split.desc_state[head].indir_desc;
> +       } else {
>                 struct vring_desc *indir_desc =3D
>                                 vq->split.desc_state[head].indir_desc;
>                 u32 len;
>
> -               /* Free the indirect table, if any, now that it's unmappe=
d. */
> -               if (!indir_desc)
> -                       return;
> +               if (vq->use_dma_api) {
> +                       struct vring_desc_extra *extra =3D vq->split.desc=
_extra;
> +
> +                       dma_unmap_single(vring_dma_dev(vq),
> +                                        extra[i].addr,
> +                                        extra[i].len,
> +                                        (flags & VRING_DESC_F_WRITE) ?
> +                                        DMA_FROM_DEVICE : DMA_TO_DEVICE)=
;
> +               }

Note that there's a following

BUG_ON(!(vq->split.desc_extra[head].flags &
                                VRING_DESC_F_INDIRECT));

Which I think we can remove.

Thanks


