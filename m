Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCD2C4828D
	for <linux-um@archiver.kernel.org>; Wed, 31 Jan 2024 11:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Date:Subject:Message-ID:
	Reply-To:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hNzHtzVpBU2+0miP3b1vKMXJO0IZm/151kGzW+L2WI0=; b=Xw9xK9B3gV5izbItaU+1j+z4G8
	ag98vhhfJGIZpwaeWo3Q1jYNcYPZjxG2OXJutoMXbD5MztiIn16d/ZVCddqD5CafqHaFBORse9rIx
	TVwxZdFTloCBF+f25aV27UHh/vHOD6eF7r8osvEU08XfsumxaeU2UW2t0iS6J5vfgrWBNmPmtro88
	jchV0UIcUeUuRS4iwe1OdtLisLTqVARq+OaptLz61FQxX0tqMGqi+od63o3cE81dgXgUznDZGbpry
	1n+xtMA3kqnS7rAVElLRNedMFrRNFmY6ece+1ClSs4Zv7jb5x2m91w+H/KuSMJk+HdHAJgf47CR5F
	esjbdDzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV8aC-000000032LF-3nL0;
	Wed, 31 Jan 2024 11:16:44 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV7Ph-00000002dYC-1jNv
	for linux-um@bombadil.infradead.org;
	Wed, 31 Jan 2024 10:01:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:References:Cc:To:From:Date:Subject:Message-ID:Sender:Reply-To:
	MIME-Version:Content-ID:Content-Description;
	bh=hNzHtzVpBU2+0miP3b1vKMXJO0IZm/151kGzW+L2WI0=; b=Gb99bhzrsWvytE5sQaehGzIwrd
	+vUW/zbSJa4aQqoGQFnDAVMjLk5w4JAS6pyXfLX7uE9mLYuZCJS9lNBozhniF9nrpuo5tNX7teJ4i
	ziJE+V3owZsB/rzvuGKBTvYW2sRVWe8a6cyWLvHPO4eAds98Tlq0qjrExQa6qeKXpmthEMR5/aXb5
	laRqjIIr9UhiJ9hJBQX4rOFjUmCO3wj8l8ngqEdjuixHjd8I9P/zwisHRSHsKINOfFfu0pBgxvm1f
	30Ai4s9HfpOVWjEVwaLZAbdf6gtaCUam7gi2Vl+g/3bdZIDtAfsw2f1pjSjQENIopHqwc3Hgtnr7a
	U7hXt5vQ==;
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV7PK-00000008wYS-23YI
	for linux-um@lists.infradead.org;
	Wed, 31 Jan 2024 10:01:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706695273; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=hNzHtzVpBU2+0miP3b1vKMXJO0IZm/151kGzW+L2WI0=;
	b=dPIX2M37FXzeuLvu/e7vAhw16m76USR7dwEXKk+PZrc9aEf2ot/6S6xUjYvDN8i9LLAQHAygyTsPkNWxAjyNkTUxy2YMzd+WpprVJeHLhBBXTtGa8aC3CClZl41W2CoZHoAb3Oih0ZsNq6T+b2V6+q4cqERNCPoRnkYhzWbOBXQ=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=36;SR=0;TI=SMTPD_---0W.j9ASw_1706695270;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.j9ASw_1706695270)
          by smtp.aliyun-inc.com;
          Wed, 31 Jan 2024 18:01:11 +0800
Message-ID: <1706695212.333408-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 03/17] virtio_ring: packed: structure the indirect desc table
Date: Wed, 31 Jan 2024 18:00:12 +0800
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
 <20240130114224.86536-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEvz55WO+TN2KCv+KLvdT-ZxLike81maahBeVanrCk_Lrg@mail.gmail.com>
In-Reply-To: <CACGkMEvz55WO+TN2KCv+KLvdT-ZxLike81maahBeVanrCk_Lrg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_100135_232147_A26D50C3 
X-CRM114-Status: GOOD (  24.29  )
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

On Wed, 31 Jan 2024 17:12:10 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Jan 30, 2024 at 7:42=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > This commit structure the indirect desc table.
> > Then we can get the desc num directly when doing unmap.
> >
> > And save the dma info to the struct, then the indirect
> > will not use the dma fields of the desc_extra. The subsequent
> > commits will make the dma fields are optional. But for
> > the indirect case, we must record the dma info.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 63 ++++++++++++++++++++----------------
> >  1 file changed, 35 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 7280a1706cca..dd03bc5a81fe 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -72,9 +72,16 @@ struct vring_desc_state_split {
> >         struct vring_desc *indir_desc;  /* Indirect descriptor, if any.=
 */
> >  };
> >
> > +struct vring_packed_desc_indir {
> > +       dma_addr_t addr;                /* Descriptor Array DMA addr. */
> > +       u32 len;                        /* Descriptor Array length. */
> > +       u32 num;
> > +       struct vring_packed_desc desc[];
> > +};
> > +
> >  struct vring_desc_state_packed {
> >         void *data;                     /* Data for callback. */
> > -       struct vring_packed_desc *indir_desc; /* Indirect descriptor, i=
f any. */
> > +       struct vring_packed_desc_indir *indir_desc; /* Indirect descrip=
tor, if any. */
> >         u16 num;                        /* Descriptor list length. */
> >         u16 last;                       /* The last desc state in a lis=
t. */
> >  };
> > @@ -1249,10 +1256,13 @@ static void vring_unmap_desc_packed(const struc=
t vring_virtqueue *vq,
> >                        DMA_FROM_DEVICE : DMA_TO_DEVICE);
> >  }
> >
> > -static struct vring_packed_desc *alloc_indirect_packed(unsigned int to=
tal_sg,
> > +static struct vring_packed_desc_indir *alloc_indirect_packed(unsigned =
int total_sg,
> >                                                        gfp_t gfp)
> >  {
> > -       struct vring_packed_desc *desc;
> > +       struct vring_packed_desc_indir *in_desc;
> > +       u32 size;
> > +
> > +       size =3D struct_size(in_desc, desc, total_sg);
> >
> >         /*
> >          * We require lowmem mappings for the descriptors because
> > @@ -1261,9 +1271,10 @@ static struct vring_packed_desc *alloc_indirect_=
packed(unsigned int total_sg,
> >          */
> >         gfp &=3D ~__GFP_HIGHMEM;
> >
> > -       desc =3D kmalloc_array(total_sg, sizeof(struct vring_packed_des=
c), gfp);
> >
> > -       return desc;
> > +       in_desc =3D kmalloc(size, gfp);
> > +
> > +       return in_desc;
> >  }
> >
> >  static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> > @@ -1274,6 +1285,7 @@ static int virtqueue_add_indirect_packed(struct v=
ring_virtqueue *vq,
> >                                          void *data,
> >                                          gfp_t gfp)
> >  {
> > +       struct vring_packed_desc_indir *in_desc;
> >         struct vring_packed_desc *desc;
> >         struct scatterlist *sg;
> >         unsigned int i, n, err_idx;
> > @@ -1281,10 +1293,12 @@ static int virtqueue_add_indirect_packed(struct=
 vring_virtqueue *vq,
> >         dma_addr_t addr;
> >
> >         head =3D vq->packed.next_avail_idx;
> > -       desc =3D alloc_indirect_packed(total_sg, gfp);
> > -       if (!desc)
> > +       in_desc =3D alloc_indirect_packed(total_sg, gfp);
> > +       if (!in_desc)
> >                 return -ENOMEM;
> >
> > +       desc =3D in_desc->desc;
> > +
> >         if (unlikely(vq->vq.num_free < 1)) {
> >                 pr_debug("Can't add buf len 1 - avail =3D 0\n");
> >                 kfree(desc);
> > @@ -1321,17 +1335,15 @@ static int virtqueue_add_indirect_packed(struct=
 vring_virtqueue *vq,
> >                 goto unmap_release;
> >         }
> >
> > +       in_desc->num =3D i;
> > +       in_desc->addr =3D addr;
> > +       in_desc->len =3D total_sg * sizeof(struct vring_packed_desc);
>
> It looks to me if we don't use dma_api we don't even need these steps?

YES


>
> > +
> >         vq->packed.vring.desc[head].addr =3D cpu_to_le64(addr);
> >         vq->packed.vring.desc[head].len =3D cpu_to_le32(total_sg *
> >                                 sizeof(struct vring_packed_desc));
> >         vq->packed.vring.desc[head].id =3D cpu_to_le16(id);
> >
> > -       if (vring_need_unmap_buffer(vq)) {
> > -               vq->packed.desc_extra[id].addr =3D addr;
> > -               vq->packed.desc_extra[id].len =3D total_sg *
> > -                               sizeof(struct vring_packed_desc);
> > -       }
> > -
> >         vq->packed.desc_extra[id].flags =3D VRING_DESC_F_INDIRECT |
> >                 vq->packed.avail_used_flags;
> >
> > @@ -1362,7 +1374,7 @@ static int virtqueue_add_indirect_packed(struct v=
ring_virtqueue *vq,
> >         /* Store token and indirect buffer state. */
> >         vq->packed.desc_state[id].num =3D 1;
> >         vq->packed.desc_state[id].data =3D data;
> > -       vq->packed.desc_state[id].indir_desc =3D desc;
> > +       vq->packed.desc_state[id].indir_desc =3D in_desc;
> >         vq->packed.desc_state[id].last =3D id;
> >
> >         vq->num_added +=3D 1;
> > @@ -1381,7 +1393,7 @@ static int virtqueue_add_indirect_packed(struct v=
ring_virtqueue *vq,
> >                 vring_unmap_desc_packed(vq, &desc[i]);
> >
> >  free_desc:
> > -       kfree(desc);
> > +       kfree(in_desc);
> >
> >         END_USE(vq);
> >         return -ENOMEM;
> > @@ -1595,7 +1607,6 @@ static void detach_buf_packed(struct vring_virtqu=
eue *vq,
> >                               unsigned int id, void **ctx)
> >  {
> >         struct vring_desc_state_packed *state =3D NULL;
> > -       struct vring_packed_desc *desc;
> >         unsigned int i, curr;
> >         u16 flags;
> >
> > @@ -1621,28 +1632,24 @@ static void detach_buf_packed(struct vring_virt=
queue *vq,
> >
> >                 if (ctx)
> >                         *ctx =3D state->indir_desc;
> > +
>
> Unnecessary changes.


Could you say more?
You do not like this patch?

Thanks.



>
> Thanks
>

