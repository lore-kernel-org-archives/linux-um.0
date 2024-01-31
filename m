Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DC1C4828E
	for <linux-um@archiver.kernel.org>; Wed, 31 Jan 2024 11:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=60OE93oZxMpAy5PTfrRWb+NgmfRgxzqKxIV3hKWBwnk=; b=bypxtmsNjBTDfaVQBtW9CWaVGz
	vbRDkgALpdj7aSP4uZdIVusgwXoXE6x3a3yv1ELk5muWICR3sptwuBb5HwKYwINWOb6ohNlN8fynM
	fa1O8SaKhVqbfiX44QeyIH0rkkYhRpeBIIVFFEM8bCWzPzXz+djvp2xEoJXxFosGkihP4CE9tOANz
	s82jrJsmHPxVjzgbMZHgqu3g4M816YHQDH8T9h3/rtrS1Qn/bydoJOQEmB2/zWSh6oCmHIhb8slBh
	nCqSpHqKWLzm84cjGoOC4BgmzSDxCwvgp+8Q6JUm+uM6q0ail2QceCRDM2GG1uNALx2KhsXYahOrn
	L328lbTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV8ol-000000036x0-0hkF;
	Wed, 31 Jan 2024 11:31:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV6fs-00000002NaV-2yEP
	for linux-um@lists.infradead.org;
	Wed, 31 Jan 2024 09:14:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706692467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=60OE93oZxMpAy5PTfrRWb+NgmfRgxzqKxIV3hKWBwnk=;
	b=WUePwTh9Y30UPBm0hVCrzPpFSb996xEqZGUWlrgrSKTGm7m6CdtsMQuiPWg16wMBF0LX6j
	ZQX8mAFbRQlC5tst/3XbYzv765Ep+pLON3TXqfjI5OkX64OewYro+MNxeVSAGCGXetWhUi
	bK1bnpGBzhxOgNqlxZhaodiVKe4o2bI=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-LtiMnQb1NIq0jsvwLiJPVA-1; Wed, 31 Jan 2024 04:13:05 -0500
X-MC-Unique: LtiMnQb1NIq0jsvwLiJPVA-1
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-7d5bbf0b3e3so1791196241.0
        for <linux-um@lists.infradead.org>; Wed, 31 Jan 2024 01:13:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706692385; x=1707297185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60OE93oZxMpAy5PTfrRWb+NgmfRgxzqKxIV3hKWBwnk=;
        b=xQaUSNKr97YDMp34OuCb0eoxDHbpHFiUsd0gt+v+Crdw/ujSnI6IkbrgPyIKx2dObw
         CzzWAPfcPJjxANsCJnVkb9yJLmlP+0rh4dKLezO43LwmTRobBxnKSJhd7lNdzyE0L7u0
         j37YyOId1yDhnhGEk2ivgVvRN8tFvo/8usBEya07llvADJtuM1pN4WJTl8LZnWFvO30g
         aLtDMEiyRrd4ba9hqkF2QtMRjWvO+38X9fB8OKQhn51/wG7uRcE9/PnN2PqB6PapWAf6
         Y52GBHqyRKaYSsfEKavsrplxKJDZKQs6frPtRpcitz4x5QWYOgn5M9BGfKBeHn7sIbwK
         m6SA==
X-Gm-Message-State: AOJu0Yy7VYbF3HOMh+X9yWjQdoJp8SMb099hiD2C5Bu+7hpwT6KDdB04
	tUjgA5Xn+EdXrdCbTzT63t7gK8bwmCM0bGrfbGIgyUZL7ntBYe2OZNSrdjMVBWvML1JWv4WSnXS
	jYihaGx+3IbSn7BFSZDdpRcRFjj81sVSW6jlD+iea7fxuAyoJDMHUke/N+YedhzDSs252iUIROV
	T1Q90AwvN5+jAZCSJergCBjQq9RVB7z4EVjugf
X-Received: by 2002:a05:6102:3a72:b0:46b:3515:e946 with SMTP id bf18-20020a0561023a7200b0046b3515e946mr689894vsb.26.1706692384888;
        Wed, 31 Jan 2024 01:13:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgfhT0+kNvJvRq3b0MROwRjSrfE5RBznl53uEMT/GjL79yJlQ2dVHq4B1TZ1jfZQ3KLNrl4yziYblN9FfKH0U=
X-Received: by 2002:a05:6102:3a72:b0:46b:3515:e946 with SMTP id
 bf18-20020a0561023a7200b0046b3515e946mr689871vsb.26.1706692384618; Wed, 31
 Jan 2024 01:13:04 -0800 (PST)
MIME-Version: 1.0
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com> <20240130114224.86536-18-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240130114224.86536-18-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Jan 2024 17:12:47 +0800
Message-ID: <CACGkMEv2cyuesaTx899hwZt7uDdqwmAwXJ8fZDv00W9FbVbTpw@mail.gmail.com>
Subject: Re: [PATCH vhost 17/17] virtio_net: sq support premapped mode
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
X-CRM114-CacheID: sfid-20240131_011428_857229_7AAFB3F1 
X-CRM114-Status: GOOD (  21.58  )
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

On Tue, Jan 30, 2024 at 7:43=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> If the xsk is enabling, the xsk tx will share the send queue.
> But the xsk requires that the send queue use the premapped mode.
> So the send queue must support premapped mode.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 167 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 163 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 226ab830870e..cf0c67380b07 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -46,6 +46,7 @@ module_param(napi_tx, bool, 0644);
>  #define VIRTIO_XDP_REDIR       BIT(1)
>
>  #define VIRTIO_XDP_FLAG        BIT(0)
> +#define VIRTIO_DMA_FLAG        BIT(1)
>
>  /* RX packet size EWMA. The average packet size is used to determine the=
 packet
>   * buffer size when refilling RX rings. As the entire RX ring may be ref=
illed
> @@ -140,6 +141,21 @@ struct virtnet_rq_dma {
>         u16 need_sync;
>  };
>
> +struct virtnet_sq_dma {
> +       union {
> +               struct virtnet_sq_dma *next;
> +               void *data;
> +       };
> +       dma_addr_t addr;
> +       u32 len;
> +       bool is_tail;
> +};
> +
> +struct virtnet_sq_dma_head {
> +       struct virtnet_sq_dma *free;
> +       struct virtnet_sq_dma *head;

Any reason the head must be a pointer instead of a simple index?

> +};
> +
>  /* Internal representation of a send virtqueue */
>  struct send_queue {
>         /* Virtqueue associated with this send _queue */
> @@ -159,6 +175,8 @@ struct send_queue {
>
>         /* Record whether sq is in reset state. */
>         bool reset;
> +
> +       struct virtnet_sq_dma_head dmainfo;
>  };
>
>  /* Internal representation of a receive virtqueue */
> @@ -348,6 +366,131 @@ static struct xdp_frame *ptr_to_xdp(void *ptr)
>         return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG=
);
>  }
>
> +static inline void *virtnet_sq_unmap(struct send_queue *sq, void *data)
> +{
> +       struct virtnet_sq_dma *head, *tail;
> +
> +       if (!((unsigned long)data & VIRTIO_DMA_FLAG))
> +               return data;
> +
> +       head =3D (void *)((unsigned long)data & ~VIRTIO_DMA_FLAG);
> +
> +       tail =3D head;
> +
> +       while (true) {
> +               virtqueue_dma_unmap_page_attrs(sq->vq, tail->addr, tail->=
len,
> +                                              DMA_TO_DEVICE, 0);
> +
> +               if (tail->is_tail)
> +                       break;
> +
> +               tail =3D tail->next;
> +       }
> +
> +       data =3D tail->data;
> +       tail->is_tail =3D false;
> +
> +       tail->next =3D sq->dmainfo.free;
> +       sq->dmainfo.free =3D head;
> +
> +       return data;
> +}
> +
> +static void *virtnet_sq_dma_splice(struct send_queue *sq,
> +                                  struct virtnet_sq_dma *head,
> +                                  struct virtnet_sq_dma *tail,
> +                                  void *data)
> +{
> +       sq->dmainfo.free =3D tail->next;
> +
> +       tail->is_tail =3D true;
> +       tail->data =3D data;
> +
> +       head =3D (void *)((unsigned long)head | VIRTIO_DMA_FLAG);
> +
> +       return head;
> +}
> +
> +static struct virtnet_sq_dma *virtnet_sq_map_sg(struct send_queue *sq, i=
nt nents, void *data)
> +{
> +       struct virtnet_sq_dma *head, *tail, *p;
> +       struct scatterlist *sg;
> +       dma_addr_t addr;
> +       int i;
> +
> +       head =3D sq->dmainfo.free;
> +       p =3D head;
> +
> +       tail =3D NULL;
> +
> +       for_each_sg(sq->sg, sg, nents, i) {
> +               addr =3D virtqueue_dma_map_page_attrs(sq->vq, sg_page(sg)=
,
> +                                                   sg->offset, sg->lengt=
h,
> +                                                   DMA_TO_DEVICE, 0);
> +               if (virtqueue_dma_mapping_error(sq->vq, addr))
> +                       goto err;
> +
> +               sg->dma_address =3D addr;
> +
> +               tail =3D p;
> +               tail->addr =3D sg->dma_address;
> +               tail->len =3D sg->length;
> +
> +               p =3D p->next;
> +       }
> +
> +       return virtnet_sq_dma_splice(sq, head, tail, data);
> +
> +err:
> +       if (tail)
> +               virtnet_sq_unmap(sq, virtnet_sq_dma_splice(sq, head, tail=
, data));
> +
> +       return NULL;
> +}
> +
> +static int virtnet_add_outbuf(struct send_queue *sq, u32 num, void *data=
)
> +{
> +       int ret;
> +
> +       if (sq->vq->premapped) {
> +               data =3D virtnet_sq_map_sg(sq, num, data);
> +               if (!data)
> +                       return -ENOMEM;
> +       }
> +
> +       ret =3D virtqueue_add_outbuf(sq->vq, sq->sg, num, data, GFP_ATOMI=
C);
> +       if (ret && sq->vq->premapped)
> +               virtnet_sq_unmap(sq, data);
> +
> +       return ret;
> +}
> +
> +static int virtnet_sq_init_dma_mate(struct send_queue *sq)
> +{
> +       struct virtnet_sq_dma *d;
> +       int size, i;
> +
> +       size =3D virtqueue_get_vring_size(sq->vq);
> +
> +       size +=3D MAX_SKB_FRAGS + 2;

Is this enough for the case where an indirect descriptor is used?

Thanks


