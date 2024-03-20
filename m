Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CB8C54E67
	for <linux-um@archiver.kernel.org>; Wed, 20 Mar 2024 09:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NcpPpj8COzr4sFGDjPc9DI4s95FhBo7rGSMdOcO4pRA=; b=LmqIgN5GwrVJiEWDeqkgmPdVma
	P+NiJUlrwr+5arfI+0NxqrubCM9aXxII1XXHsnKuqvVPpVD+7i37fCfV3XxfJWVkZ2XuZwEWlsMPc
	u1cVDcCYm2AEV7D4GWqaj8VNWxfRNgdYsbkCQbNavTwAPNjKT34QXWYLdQxTjWMOWAdTx6MlxVGi2
	pGpHXOxE8l5W0WquX8IHEWT2r/mQjspGeAKBYsmRuJwRI3JocTerkhOR1PpfNPLU5TlbiaHkQ4ksi
	ov2epdR2Li0QPZ8iDDDHKSG0lB52DZX9WGprbJ9T9TxeCzTh3kNylNTlaG68TKdpuRiKGGcURIuL+
	nUc/hRUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmsIM-0000000GUk5-0uIJ;
	Wed, 20 Mar 2024 09:31:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmsII-0000000GUi6-0CyA
	for linux-um@lists.infradead.org;
	Wed, 20 Mar 2024 09:31:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710927092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NcpPpj8COzr4sFGDjPc9DI4s95FhBo7rGSMdOcO4pRA=;
	b=QYRGyXGXp9M6MgxZ8UkRuABuhH+UBnm9dIafJ5HoGUFLeteHeISATx1hkGKtf0MR8Z1ZQF
	ezGY94/7TKWgvfSc+syDsKQOZrYpu8eDFrySGSQN2gUD2oxJo3s57/48Cuqy7vjRB3NYXG
	sdYLQA5JkF6bRtuyeOMWvt3oA+T7DIo=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-RoJQ3UZQMGGT2EQylSFZcA-1; Wed, 20 Mar 2024 05:31:31 -0400
X-MC-Unique: RoJQ3UZQMGGT2EQylSFZcA-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5cfc2041cdfso4358911a12.2
        for <linux-um@lists.infradead.org>; Wed, 20 Mar 2024 02:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710927090; x=1711531890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcpPpj8COzr4sFGDjPc9DI4s95FhBo7rGSMdOcO4pRA=;
        b=jk26vGeFbVmiCcRoSmCMftmS8PXLSey9XFd1PjEJBleIZqXzjoGFMo5HBUAIyEL+JF
         FyeUN0/K+1Ah58FOUnEm/WUTEle8ZEdIIAUHA1gyRNA5pT6+zm1YYoMRjfeCaviWrNb5
         Yt5mHmXN9AiBlcxKAIecO59dgu0vlRTegJFLPX3pLXSuvv8HWL76rG1vVf+SXT51iXTJ
         1aLQgLZNF+FCtLG5vC8RsbtDQcJGGuX7AG2LzGOsVH6VD6zCIwP2G7WXZGjNvt2nDrXS
         uyZvmJ3PA4Pb0MKsjxlH7PzxCsp1S1TcQ3Fdlqx6kKhvVmVKrdtYd7SJ3HIzRsYSzY4j
         E/iw==
X-Forwarded-Encrypted: i=1; AJvYcCUNIvoyXu/hJosD4h4UO+6ItmYX3sGXxxm2elTNYeQweCTuBA24X+juMFUvq7pqpp3+ZJHCxneTBJXqLjIdHnIAfdwqtwDdd7rx604a
X-Gm-Message-State: AOJu0YypRnlQWTYCTnCChBzVRuPKRVpOCCl7WG+0w8wG1OZCS0b+8Mb/
	CJ8y+VmAQRGdmaIClP/jDdt+i4IYzA7/kmUE+RzFnhylZuxyrZ4KMGFhIjps/bkBcNXjdsA4X7n
	Yg1oXjgF8W5wvWM71ylcj4BQExILP99s4HuW/wVZiwsmG6Czd91ksaWk3lW0IWi1CZRCWt6PXKO
	SD/eDxRLRdKOWgDdxLx4iN1AtBaj8Nvwf9OFQw
X-Received: by 2002:a05:6a20:e01:b0:1a3:6f61:200d with SMTP id ej1-20020a056a200e0100b001a36f61200dmr4956857pzb.9.1710927090295;
        Wed, 20 Mar 2024 02:31:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8qe09t4g3HfkRiIbfxrA8Ju1f60Up1DuN2Huw8OLenlVMbWpJINYFcOydIKj7JhZrxkyZn+X3zIVTMeJ8+is=
X-Received: by 2002:a05:6a20:e01:b0:1a3:6f61:200d with SMTP id
 ej1-20020a056a200e0100b001a36f61200dmr4956832pzb.9.1710927089974; Wed, 20 Mar
 2024 02:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240312021013.88656-1-xuanzhuo@linux.alibaba.com>
 <20240312021013.88656-2-xuanzhuo@linux.alibaba.com> <CACGkMEvVgfgAxLoKeFTgy-1GR0W07ciPYFuqs6PiWtKCnXuWTw@mail.gmail.com>
 <1710395908.7915084-1-xuanzhuo@linux.alibaba.com> <CACGkMEsT2JqJ1r_kStUzW0+-f+qT0C05n2A+Yrjpc-mHMZD_mQ@mail.gmail.com>
 <1710487245.6843069-1-xuanzhuo@linux.alibaba.com> <CACGkMEspzDTZP1yxkBz17MgU9meyfCUBDxG8mjm=acXHNxAxhg@mail.gmail.com>
 <1710741592.205804-1-xuanzhuo@linux.alibaba.com> <20240319025726-mutt-send-email-mst@kernel.org>
 <CACGkMEsO6e2=v36F=ezhHCEaXqG0+AhkCM2ZgmKAtyWncnif5Q@mail.gmail.com>
In-Reply-To: <CACGkMEsO6e2=v36F=ezhHCEaXqG0+AhkCM2ZgmKAtyWncnif5Q@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Mar 2024 17:31:18 +0800
Message-ID: <CACGkMEtfZx3+PcR7pCKQ9feLSERX6W-UKR0iJWEXVt7Q7ssZNA@mail.gmail.com>
Subject: Re: [PATCH vhost v3 1/4] virtio: find_vqs: pass struct instead of
 multi parameters
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-um@lists.infradead.org, 
	platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-s390@vger.kernel.org, kvm@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_023134_191500_FDD8CCB5 
X-CRM114-Status: GOOD (  41.36  )
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

On Wed, Mar 20, 2024 at 5:22=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Mar 19, 2024 at 2:58=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Mon, Mar 18, 2024 at 01:59:52PM +0800, Xuan Zhuo wrote:
> > > On Mon, 18 Mar 2024 12:18:23 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Fri, Mar 15, 2024 at 3:26=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > On Fri, 15 Mar 2024 11:51:48 +0800, Jason Wang <jasowang@redhat.c=
om> wrote:
> > > > > > On Thu, Mar 14, 2024 at 2:00=E2=80=AFPM Xuan Zhuo <xuanzhuo@lin=
ux.alibaba.com> wrote:
> > > > > > >
> > > > > > > On Thu, 14 Mar 2024 11:12:24 +0800, Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > > > > On Tue, Mar 12, 2024 at 10:10=E2=80=AFAM Xuan Zhuo <xuanzhu=
o@linux.alibaba.com> wrote:
> > > > > > > > >
> > > > > > > > > Now, we pass multi parameters to find_vqs. These paramete=
rs
> > > > > > > > > may work for transport or work for vring.
> > > > > > > > >
> > > > > > > > > And find_vqs has multi implements in many places:
> > > > > > > > >
> > > > > > > > >  arch/um/drivers/virtio_uml.c
> > > > > > > > >  drivers/platform/mellanox/mlxbf-tmfifo.c
> > > > > > > > >  drivers/remoteproc/remoteproc_virtio.c
> > > > > > > > >  drivers/s390/virtio/virtio_ccw.c
> > > > > > > > >  drivers/virtio/virtio_mmio.c
> > > > > > > > >  drivers/virtio/virtio_pci_legacy.c
> > > > > > > > >  drivers/virtio/virtio_pci_modern.c
> > > > > > > > >  drivers/virtio/virtio_vdpa.c
> > > > > > > > >
> > > > > > > > > Every time, we try to add a new parameter, that is diffic=
ult.
> > > > > > > > > We must change every find_vqs implement.
> > > > > > > > >
> > > > > > > > > One the other side, if we want to pass a parameter to vri=
ng,
> > > > > > > > > we must change the call path from transport to vring.
> > > > > > > > > Too many functions need to be changed.
> > > > > > > > >
> > > > > > > > > So it is time to refactor the find_vqs. We pass a structu=
re
> > > > > > > > > cfg to find_vqs(), that will be passed to vring by transp=
ort.
> > > > > > > > >
> > > > > > > > > Because the vp_modern_create_avq() use the "const char *n=
ames[]",
> > > > > > > > > and the virtio_uml.c changes the name in the subsequent c=
ommit, so
> > > > > > > > > change the "names" inside the virtio_vq_config from "cons=
t char *const
> > > > > > > > > *names" to "const char **names".
> > > > > > > > >
> > > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > > Acked-by: Johannes Berg <johannes@sipsolutions.net>
> > > > > > > > > Reviewed-by: Ilpo J=3DE4rvinen <ilpo.jarvinen@linux.intel=
.com>
> > > > > > > >
> > > > > > > > The name seems broken here.
> > > > > > >
> > > > > > > Email APP bug.
> > > > > > >
> > > > > > > I will fix.
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > [...]
> > > > > > > >
> > > > > > > > >
> > > > > > > > >  typedef void vq_callback_t(struct virtqueue *);
> > > > > > > > >
> > > > > > > > > +/**
> > > > > > > > > + * struct virtio_vq_config - configure for find_vqs()
> > > > > > > > > + * @cfg_idx: Used by virtio core. The drivers should set=
 this to 0.
> > > > > > > > > + *     During the initialization of each vq(vring setup)=
, we need to know which
> > > > > > > > > + *     item in the array should be used at that time. Bu=
t since the item in
> > > > > > > > > + *     names can be null, which causes some item of arra=
y to be skipped, we
> > > > > > > > > + *     cannot use vq.index as the current id. So add a c=
fg_idx to let vring
> > > > > > > > > + *     know how to get the current configuration from th=
e array when
> > > > > > > > > + *     initializing vq.
> > > > > > > >
> > > > > > > > So this design is not good. If it is not something that the=
 driver
> > > > > > > > needs to care about, the core needs to hide it from the API=
.
> > > > > > >
> > > > > > > The driver just ignore it. That will be beneficial to the vir=
tio core.
> > > > > > > Otherwise, we must pass one more parameter everywhere.
> > > > > >
> > > > > > I don't get here, it's an internal logic and we've already done=
 that.
> > > > >
> > > > >
> > > > > ## Then these must add one param "cfg_idx";
> > > > >
> > > > >  struct virtqueue *vring_create_virtqueue(struct virtio_device *v=
dev,
> > > > >                                          unsigned int index,
> > > > >                                          struct vq_transport_conf=
ig *tp_cfg,
> > > > >                                          struct virtio_vq_config =
*cfg,
> > > > > -->                                      uint cfg_idx);
> > > > >
> > > > >  struct virtqueue *vring_new_virtqueue(struct virtio_device *vdev=
,
> > > > >                                       unsigned int index,
> > > > >                                       void *pages,
> > > > >                                       struct vq_transport_config =
*tp_cfg,
> > > > >                                       struct virtio_vq_config *cf=
g,
> > > > > -->                                      uint cfg_idx);
> > > > >
> > > > >
> > > > > ## The functions inside virtio_ring also need to add a new param,=
 such as:
> > > > >
> > > > >  static struct virtqueue *vring_create_virtqueue_split(struct vir=
tio_device *vdev,
> > > > >                                                       unsigned in=
t index,
> > > > >                                                       struct vq_t=
ransport_config *tp_cfg,
> > > > >                                                       struct virt=
io_vq_config,
> > > > > -->                                                   uint cfg_id=
x);
> > > > >
> > > > >
> > > > >
> > > >
> > > > I guess what I'm missing is when could the index differ from cfg_id=
x?
> > >
> > >
> > >  @cfg_idx: Used by virtio core. The drivers should set this to 0.
> > >      During the initialization of each vq(vring setup), we need to kn=
ow which
> > >      item in the array should be used at that time. But since the ite=
m in
> > >      names can be null, which causes some item of array to be skipped=
, we
> > >      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > >      cannot use vq.index as the current id. So add a cfg_idx to let v=
ring
> > >      know how to get the current configuration from the array when
> > >      initializing vq.
> > >
> > >
> > > static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int =
nvqs,
> > >
> > >       ................
> > >
> > >       for (i =3D 0; i < nvqs; ++i) {
> > >               if (!names[i]) {
> > >                       vqs[i] =3D NULL;
> > >                       continue;
> > >               }
> > >
> > >               if (!callbacks[i])
> > >                       msix_vec =3D VIRTIO_MSI_NO_VECTOR;
> > >               else if (vp_dev->per_vq_vectors)
> > >                       msix_vec =3D allocated_vectors++;
> > >               else
> > >                       msix_vec =3D VP_MSIX_VQ_VECTOR;
> > >               vqs[i] =3D vp_setup_vq(vdev, queue_idx++, callbacks[i],=
 names[i],
> > >                                    ctx ? ctx[i] : false,
> > >                                    msix_vec);
> > >
> > >
> > > Thanks.
> >
> >
> > Jason what do you think is the way to resolve this?
>
> I wonder which driver doesn't use a specific virtqueue in this case.
>
> And it looks to me, introducing a per-vq-config struct might be better
> then we have
>
> virtio_vqs_config {
>       unsigned int nvqs;
>       struct virtio_vq_config *configs;
> }
>
> So we don't need the cfg_idx stuff.

And actually, I'm also ok to have cfg_idx internally, it's better than
having an API which has a field that the user doesn't need to care
about.

Thanks

>
> Thanks
>
> >
> > > >
> > > > Thanks
> > > >
> > > > > Thanks.
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > >
> > > > > > > Thanks.
> > > > > > >
> > > > > > > >
> > > > > > > > Thanks
> > > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > > >
> >


