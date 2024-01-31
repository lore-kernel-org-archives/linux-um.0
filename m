Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5476CC47258
	for <linux-um@archiver.kernel.org>; Wed, 31 Jan 2024 10:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zJLwocwtNUB8ZTp4FCceWuPM46tHyYM0Zkz28XCMF9w=; b=pjRzREGW3J0xhL/jp78jtJKJYh
	AjqEvw441h8SiktItHP4ummiEViOiQzSWVyEl7IYo7kwoz8KiZzbvHx587qQItgwEx5hvSYmJIX+U
	N+neFPRbPfE6RnY7VEF939h0GQ/aQ2/bnZRs97NXuk9E4XDEVUnVfCHXDBBqM2GoUdZ8dDfMFwzPk
	DiXa7r52zoVczhXmNWsFlH14vbAaUbfw9Jc/sk4hV1UK71TnUA7T4pmNwdH3JLaNnrpVh1B6+YLhu
	2zIu1hFfMcXJm3XAjXBQrzWN6qgVtIH7x9K5qTLADVIktLLdqvK8V3+uSkeO/qkzl/Uzt0zqBeDRK
	kkPxFIpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV7eC-00000002j62-31Dc;
	Wed, 31 Jan 2024 10:16:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV6fS-00000002NMm-47U0
	for linux-um@lists.infradead.org;
	Wed, 31 Jan 2024 09:14:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706692440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zJLwocwtNUB8ZTp4FCceWuPM46tHyYM0Zkz28XCMF9w=;
	b=PfNChhIg0M5MX1Vq378N3NHBzAVKvsMRvFIKi5kwm2MpoYaW0KtR75tVYBm9LLVEzPMQ/N
	nlbX/cDui5J30BbCUcUnyKRAM584F32c9tqhu/hXQVN3ShtbA0GZ3OXMtOJA8mXFRBYIb/
	M2nqPsoH/D5ioKzJgthu+46uuLnM0Ro=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-fcbNSQbDM9aeCcPPTkYNIQ-1; Wed, 31 Jan 2024 04:12:24 -0500
X-MC-Unique: fcbNSQbDM9aeCcPPTkYNIQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-295aaffe58bso729559a91.1
        for <linux-um@lists.infradead.org>; Wed, 31 Jan 2024 01:12:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706692343; x=1707297143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJLwocwtNUB8ZTp4FCceWuPM46tHyYM0Zkz28XCMF9w=;
        b=xGZtUm8awsMqB7pv73C7WBKZ+1K3RIDiMpDZsqIBH61EHB+E9v+0l3ZK3K31Xq8nH2
         S+LpTRmzM0DMf+Jz9p9ZFGXaw6+QnvyW51QqotN6blcKZeUr/v+ZWJ8uvoogo9knhepg
         AQoDKEFBt+toj0nSlOgZt+Znh4wk9g6TQqT/Zy33ug/dj+WPHkXHJma7WaplCTYMFmvJ
         jRNKj6B+8K5bm2yBU55tlchTpyLv2DJi96N26acrwKVmJqS7cLw6eKVoOVZNVI9ckUwc
         at9Ut4U/I9c4gVXlOwJ3/HOYpaxVqQDVFeyevhkqrf3XF08qzHHhz5pEQW9iormiqShv
         CpNQ==
X-Gm-Message-State: AOJu0YzlwnuCpuzcJyURtRqLx60yil7fQaRTSa9uU+3q02f4W2PiSwjO
	eusZvcdkcRk4qhLBvebvidJM2ciXZnZRw6w8rgxsaVgpfkk1STY7Ui/FsCFGLB3NMdFnJ/201EV
	jA7wMrvRVSXPERtPwqADxcIII7DeCRR4pUkTVG+2SNM7zHSXHtc7M31XynXgKMoLn76P4Mf9gwF
	afRvnn+sh8yTYt27eVbCZblTYDJP1V8l/6aNd1
X-Received: by 2002:a17:90a:4812:b0:28e:850e:7e87 with SMTP id a18-20020a17090a481200b0028e850e7e87mr4055932pjh.41.1706692342963;
        Wed, 31 Jan 2024 01:12:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHA19Z59zeHpR3nNimF0ZQi1mnwkJcouyhWsEmqEUBepD+NIxCTxSZH5EaaTBhFTcpXCqGmenq5iSv576m9gbY=
X-Received: by 2002:a17:90a:4812:b0:28e:850e:7e87 with SMTP id
 a18-20020a17090a481200b0028e850e7e87mr4055914pjh.41.1706692342651; Wed, 31
 Jan 2024 01:12:22 -0800 (PST)
MIME-Version: 1.0
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com> <20240130114224.86536-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240130114224.86536-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Jan 2024 17:12:10 +0800
Message-ID: <CACGkMEvz55WO+TN2KCv+KLvdT-ZxLike81maahBeVanrCk_Lrg@mail.gmail.com>
Subject: Re: [PATCH vhost 03/17] virtio_ring: packed: structure the indirect
 desc table
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
X-CRM114-CacheID: sfid-20240131_011403_127564_4DC67F4A 
X-CRM114-Status: GOOD (  23.99  )
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
> This commit structure the indirect desc table.
> Then we can get the desc num directly when doing unmap.
>
> And save the dma info to the struct, then the indirect
> will not use the dma fields of the desc_extra. The subsequent
> commits will make the dma fields are optional. But for
> the indirect case, we must record the dma info.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 63 ++++++++++++++++++++----------------
>  1 file changed, 35 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 7280a1706cca..dd03bc5a81fe 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -72,9 +72,16 @@ struct vring_desc_state_split {
>         struct vring_desc *indir_desc;  /* Indirect descriptor, if any. *=
/
>  };
>
> +struct vring_packed_desc_indir {
> +       dma_addr_t addr;                /* Descriptor Array DMA addr. */
> +       u32 len;                        /* Descriptor Array length. */
> +       u32 num;
> +       struct vring_packed_desc desc[];
> +};
> +
>  struct vring_desc_state_packed {
>         void *data;                     /* Data for callback. */
> -       struct vring_packed_desc *indir_desc; /* Indirect descriptor, if =
any. */
> +       struct vring_packed_desc_indir *indir_desc; /* Indirect descripto=
r, if any. */
>         u16 num;                        /* Descriptor list length. */
>         u16 last;                       /* The last desc state in a list.=
 */
>  };
> @@ -1249,10 +1256,13 @@ static void vring_unmap_desc_packed(const struct =
vring_virtqueue *vq,
>                        DMA_FROM_DEVICE : DMA_TO_DEVICE);
>  }
>
> -static struct vring_packed_desc *alloc_indirect_packed(unsigned int tota=
l_sg,
> +static struct vring_packed_desc_indir *alloc_indirect_packed(unsigned in=
t total_sg,
>                                                        gfp_t gfp)
>  {
> -       struct vring_packed_desc *desc;
> +       struct vring_packed_desc_indir *in_desc;
> +       u32 size;
> +
> +       size =3D struct_size(in_desc, desc, total_sg);
>
>         /*
>          * We require lowmem mappings for the descriptors because
> @@ -1261,9 +1271,10 @@ static struct vring_packed_desc *alloc_indirect_pa=
cked(unsigned int total_sg,
>          */
>         gfp &=3D ~__GFP_HIGHMEM;
>
> -       desc =3D kmalloc_array(total_sg, sizeof(struct vring_packed_desc)=
, gfp);
>
> -       return desc;
> +       in_desc =3D kmalloc(size, gfp);
> +
> +       return in_desc;
>  }
>
>  static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> @@ -1274,6 +1285,7 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>                                          void *data,
>                                          gfp_t gfp)
>  {
> +       struct vring_packed_desc_indir *in_desc;
>         struct vring_packed_desc *desc;
>         struct scatterlist *sg;
>         unsigned int i, n, err_idx;
> @@ -1281,10 +1293,12 @@ static int virtqueue_add_indirect_packed(struct v=
ring_virtqueue *vq,
>         dma_addr_t addr;
>
>         head =3D vq->packed.next_avail_idx;
> -       desc =3D alloc_indirect_packed(total_sg, gfp);
> -       if (!desc)
> +       in_desc =3D alloc_indirect_packed(total_sg, gfp);
> +       if (!in_desc)
>                 return -ENOMEM;
>
> +       desc =3D in_desc->desc;
> +
>         if (unlikely(vq->vq.num_free < 1)) {
>                 pr_debug("Can't add buf len 1 - avail =3D 0\n");
>                 kfree(desc);
> @@ -1321,17 +1335,15 @@ static int virtqueue_add_indirect_packed(struct v=
ring_virtqueue *vq,
>                 goto unmap_release;
>         }
>
> +       in_desc->num =3D i;
> +       in_desc->addr =3D addr;
> +       in_desc->len =3D total_sg * sizeof(struct vring_packed_desc);

It looks to me if we don't use dma_api we don't even need these steps?

> +
>         vq->packed.vring.desc[head].addr =3D cpu_to_le64(addr);
>         vq->packed.vring.desc[head].len =3D cpu_to_le32(total_sg *
>                                 sizeof(struct vring_packed_desc));
>         vq->packed.vring.desc[head].id =3D cpu_to_le16(id);
>
> -       if (vring_need_unmap_buffer(vq)) {
> -               vq->packed.desc_extra[id].addr =3D addr;
> -               vq->packed.desc_extra[id].len =3D total_sg *
> -                               sizeof(struct vring_packed_desc);
> -       }
> -
>         vq->packed.desc_extra[id].flags =3D VRING_DESC_F_INDIRECT |
>                 vq->packed.avail_used_flags;
>
> @@ -1362,7 +1374,7 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>         /* Store token and indirect buffer state. */
>         vq->packed.desc_state[id].num =3D 1;
>         vq->packed.desc_state[id].data =3D data;
> -       vq->packed.desc_state[id].indir_desc =3D desc;
> +       vq->packed.desc_state[id].indir_desc =3D in_desc;
>         vq->packed.desc_state[id].last =3D id;
>
>         vq->num_added +=3D 1;
> @@ -1381,7 +1393,7 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>                 vring_unmap_desc_packed(vq, &desc[i]);
>
>  free_desc:
> -       kfree(desc);
> +       kfree(in_desc);
>
>         END_USE(vq);
>         return -ENOMEM;
> @@ -1595,7 +1607,6 @@ static void detach_buf_packed(struct vring_virtqueu=
e *vq,
>                               unsigned int id, void **ctx)
>  {
>         struct vring_desc_state_packed *state =3D NULL;
> -       struct vring_packed_desc *desc;
>         unsigned int i, curr;
>         u16 flags;
>
> @@ -1621,28 +1632,24 @@ static void detach_buf_packed(struct vring_virtqu=
eue *vq,
>
>                 if (ctx)
>                         *ctx =3D state->indir_desc;
> +

Unnecessary changes.

Thanks


