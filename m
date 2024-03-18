Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20162C54E5D
	for <linux-um@archiver.kernel.org>; Mon, 18 Mar 2024 04:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YcMIvlcXZmHfP6Yrf0ho0KeclSMy8eBKOPAz1pFY4gM=; b=aFP7STJso14gKP14EHdYWXcGVX
	9iFD3LqVMnOTqIeTvc0sXcItwlTppr8G0Pw/zRdhe78js0MHNtPIMWXRn8BenIElVPwx1/5YW2xQ+
	xNGj4ZKWd5/q4WUscq/A0EcdkHbLV8GxzjwX/y4DTsK+JDM2vbVTL1GJdILL/utxyqkVG/rA3tMe0
	HV1jhm/mugvAUQP4VPUb+VtSHwdLrJoqrdvzyenD/UdjZbLpucigVl0qu5nvRYCZbaoo1iQmbMdBF
	R+8327iSG9/FLvUqIznm71Ob0EPMoxV/Nvqs2Dl+XLp3FXEl9XXvyHGye8jpSB8AJ9djetzM9BG0i
	JRCQFtkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm4SS-00000007EWS-3rPH;
	Mon, 18 Mar 2024 04:18:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm4SO-00000007EVt-2z4E
	for linux-um@lists.infradead.org;
	Mon, 18 Mar 2024 04:18:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710735517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YcMIvlcXZmHfP6Yrf0ho0KeclSMy8eBKOPAz1pFY4gM=;
	b=C1338esorfYIWaTdvC199pMQy+poifxpT8hHednsRLB8cnRW1+xB1570GPZg9mxfaA6rZv
	ie2P7VNTpyCsrE+i40Kl+EhnHlLB1hyJiUbaBJQWJcgy1CaV5OwMV30f995585Isuzdk3/
	WNnbIAKfINY1jmfgXo3GgjZy3c0siFU=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-k6npCFJaNRK64E6Yd1WlYQ-1; Mon, 18 Mar 2024 00:18:35 -0400
X-MC-Unique: k6npCFJaNRK64E6Yd1WlYQ-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1e01f53a293so5960185ad.0
        for <linux-um@lists.infradead.org>; Sun, 17 Mar 2024 21:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710735515; x=1711340315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YcMIvlcXZmHfP6Yrf0ho0KeclSMy8eBKOPAz1pFY4gM=;
        b=lbRfWZO0h5LhFUo1A8VYyB/ZmpDcJkuSbEwovO8g2rSF0ObBZgXyLp4daVS/NdMQgd
         m1qpBgM4OP5IsTrEUzZmyJ2Sf5J7pY63JUsboh0iUETrYIxmCt578GnczovB2KKqKyUL
         XCLDqYsAPJ6jIw7ne3+9ky69RSmQ5pcv1EmEuZ3O5zYSp9msL1YlAXVYc96WjYpJdfHD
         f/8dJOq5i9iuMJ0kPrhDVaWJaC6sBEIsNUFpayEaR/m1Q5n13mSQFsNQfU2rxDFWoWlY
         +/0rk8sbrwKYxvxk18lV3tNEme2i3Q/cmzYKEWqJiiBSN8FUp2ZU0JM13QS8zOiUrliF
         mHuw==
X-Forwarded-Encrypted: i=1; AJvYcCUkHdXmH1Ovc8kv4tP1T2pB0wFSwCaQx6WR3Rrlqw28UzeDRxtHEVArRRDOHjwAZkeTmx5/QvMNBr2t0Ks0qYCTiUpSDMjwpzHVpe+q
X-Gm-Message-State: AOJu0YxsM3uru3pkGkfsz1zmuzh8YCFCWdz8pZTEn7dOOxIEIH3PzQxV
	a5jxK9zjSuLXJh81o29dOapkVaGZ23gTmHsuffPlw94LioX1CE6yXLgdH95kuOK6t7h6x9G6BOO
	/Qql7gLqpWKMiPhqtR5VuSRbnOnr3QtDxnWhIaVJ5jYnS3ZyAD85Mw3sLLV8FZKW6g5/CwSGU8P
	Bs3mJPas+HsAV6ale3WsDcJXZwW0+NA/Jp1tp1
X-Received: by 2002:a17:902:d68b:b0:1de:f91:3cf3 with SMTP id v11-20020a170902d68b00b001de0f913cf3mr9020699ply.55.1710735514576;
        Sun, 17 Mar 2024 21:18:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFC9oB0f9oW121Bvau3zWELRsInCawRgYQJTSjt+TRvAgqSmbvs/LBhfOLf7eU9EldQFzvUZZSWPwuwPejjiP0=
X-Received: by 2002:a17:902:d68b:b0:1de:f91:3cf3 with SMTP id
 v11-20020a170902d68b00b001de0f913cf3mr9020679ply.55.1710735514309; Sun, 17
 Mar 2024 21:18:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240312021013.88656-1-xuanzhuo@linux.alibaba.com>
 <20240312021013.88656-2-xuanzhuo@linux.alibaba.com> <CACGkMEvVgfgAxLoKeFTgy-1GR0W07ciPYFuqs6PiWtKCnXuWTw@mail.gmail.com>
 <1710395908.7915084-1-xuanzhuo@linux.alibaba.com> <CACGkMEsT2JqJ1r_kStUzW0+-f+qT0C05n2A+Yrjpc-mHMZD_mQ@mail.gmail.com>
 <1710487245.6843069-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1710487245.6843069-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 18 Mar 2024 12:18:23 +0800
Message-ID: <CACGkMEspzDTZP1yxkBz17MgU9meyfCUBDxG8mjm=acXHNxAxhg@mail.gmail.com>
Subject: Re: [PATCH vhost v3 1/4] virtio: find_vqs: pass struct instead of
 multi parameters
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-um@lists.infradead.org, 
	platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-s390@vger.kernel.org, kvm@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240317_211840_851937_79EB79D3 
X-CRM114-Status: GOOD (  31.19  )
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

On Fri, Mar 15, 2024 at 3:26=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Fri, 15 Mar 2024 11:51:48 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Thu, Mar 14, 2024 at 2:00=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Thu, 14 Mar 2024 11:12:24 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Tue, Mar 12, 2024 at 10:10=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.=
alibaba.com> wrote:
> > > > >
> > > > > Now, we pass multi parameters to find_vqs. These parameters
> > > > > may work for transport or work for vring.
> > > > >
> > > > > And find_vqs has multi implements in many places:
> > > > >
> > > > >  arch/um/drivers/virtio_uml.c
> > > > >  drivers/platform/mellanox/mlxbf-tmfifo.c
> > > > >  drivers/remoteproc/remoteproc_virtio.c
> > > > >  drivers/s390/virtio/virtio_ccw.c
> > > > >  drivers/virtio/virtio_mmio.c
> > > > >  drivers/virtio/virtio_pci_legacy.c
> > > > >  drivers/virtio/virtio_pci_modern.c
> > > > >  drivers/virtio/virtio_vdpa.c
> > > > >
> > > > > Every time, we try to add a new parameter, that is difficult.
> > > > > We must change every find_vqs implement.
> > > > >
> > > > > One the other side, if we want to pass a parameter to vring,
> > > > > we must change the call path from transport to vring.
> > > > > Too many functions need to be changed.
> > > > >
> > > > > So it is time to refactor the find_vqs. We pass a structure
> > > > > cfg to find_vqs(), that will be passed to vring by transport.
> > > > >
> > > > > Because the vp_modern_create_avq() use the "const char *names[]",
> > > > > and the virtio_uml.c changes the name in the subsequent commit, s=
o
> > > > > change the "names" inside the virtio_vq_config from "const char *=
const
> > > > > *names" to "const char **names".
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > Acked-by: Johannes Berg <johannes@sipsolutions.net>
> > > > > Reviewed-by: Ilpo J=3DE4rvinen <ilpo.jarvinen@linux.intel.com>
> > > >
> > > > The name seems broken here.
> > >
> > > Email APP bug.
> > >
> > > I will fix.
> > >
> > >
> > > >
> > > > [...]
> > > >
> > > > >
> > > > >  typedef void vq_callback_t(struct virtqueue *);
> > > > >
> > > > > +/**
> > > > > + * struct virtio_vq_config - configure for find_vqs()
> > > > > + * @cfg_idx: Used by virtio core. The drivers should set this to=
 0.
> > > > > + *     During the initialization of each vq(vring setup), we nee=
d to know which
> > > > > + *     item in the array should be used at that time. But since =
the item in
> > > > > + *     names can be null, which causes some item of array to be =
skipped, we
> > > > > + *     cannot use vq.index as the current id. So add a cfg_idx t=
o let vring
> > > > > + *     know how to get the current configuration from the array =
when
> > > > > + *     initializing vq.
> > > >
> > > > So this design is not good. If it is not something that the driver
> > > > needs to care about, the core needs to hide it from the API.
> > >
> > > The driver just ignore it. That will be beneficial to the virtio core=
.
> > > Otherwise, we must pass one more parameter everywhere.
> >
> > I don't get here, it's an internal logic and we've already done that.
>
>
> ## Then these must add one param "cfg_idx";
>
>  struct virtqueue *vring_create_virtqueue(struct virtio_device *vdev,
>                                          unsigned int index,
>                                          struct vq_transport_config *tp_c=
fg,
>                                          struct virtio_vq_config *cfg,
> -->                                      uint cfg_idx);
>
>  struct virtqueue *vring_new_virtqueue(struct virtio_device *vdev,
>                                       unsigned int index,
>                                       void *pages,
>                                       struct vq_transport_config *tp_cfg,
>                                       struct virtio_vq_config *cfg,
> -->                                      uint cfg_idx);
>
>
> ## The functions inside virtio_ring also need to add a new param, such as=
:
>
>  static struct virtqueue *vring_create_virtqueue_split(struct virtio_devi=
ce *vdev,
>                                                       unsigned int index,
>                                                       struct vq_transport=
_config *tp_cfg,
>                                                       struct virtio_vq_co=
nfig,
> -->                                                   uint cfg_idx);
>
>
>

I guess what I'm missing is when could the index differ from cfg_idx?

Thanks

> Thanks.
>
>
>
>
> >
> > Thanks
> >
> > >
> > > Thanks.
> > >
> > > >
> > > > Thanks
> > > >
> > >
> >
>


