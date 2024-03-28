Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51913C54E64
	for <linux-um@archiver.kernel.org>; Thu, 28 Mar 2024 06:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Date:Subject:Message-ID:
	Reply-To:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IBtAlx6xKMHEbRBKxgn51ZjPfu2bAbCnF3S7grDjY3g=; b=SEq26/5V7Y6cCFkdO4c/BXMFeT
	wAAOUgCBzF/H+oL4ZTdUWqJr2Upu3jLvhdyBt86AyisfP7myJLvyGpI6EZiYP4p5F+sMfsVJUtzBm
	/vM3qa4YyNS+2OOW5Wjs/mB+aCmxji59Z7O9KCOWK2Li6ftcJe40+fUeBLVVrguWDvxzaAfmLD5sn
	0wCyC0Dtz0c0xLPQXlO59OeWUexZ84MmpzUIMjjY0iZwwRRcysYDeZSqnhICUHgTE5HLKmWR+/qSc
	dwY9WHP91elWM/+J0VKSlxMPqnbuMruR1QfdT1P3SBpE1TJriXsS+DOiyuirLmsfVuCywSLEBrPge
	mN+ERm6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpjLE-0000000CjLj-0eLP;
	Thu, 28 Mar 2024 06:34:24 +0000
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpjL9-0000000CjIH-1aUB
	for linux-um@lists.infradead.org;
	Thu, 28 Mar 2024 06:34:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711607654; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=IBtAlx6xKMHEbRBKxgn51ZjPfu2bAbCnF3S7grDjY3g=;
	b=OPZY5qFgtBkNM8T9gFu7mkAqC9UnD+uei/WusP+Hkh3Grl6E8qnvhocMKNEVFAKoYimSFqi9Ewh7odWZGsYago2XNxm8Zfmlwp8Msykek4s8+qBAZI+7E7fl8NNvmGO32FoQHxblYGfLbOWH9xNzT4xJL9UKOzaE/c9Dh6uXyaY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=25;SR=0;TI=SMTPD_---0W3QzI2o_1711607650;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3QzI2o_1711607650)
          by smtp.aliyun-inc.com;
          Thu, 28 Mar 2024 14:34:11 +0800
Message-ID: <1711607635.4907694-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v6 5/6] virtio: vring_new_virtqueue(): pass struct instead of multi parameters
Date: Thu, 28 Mar 2024 14:33:55 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 linux-um@lists.infradead.org,
 platform-driver-x86@vger.kernel.org,
 linux-remoteproc@vger.kernel.org,
 linux-s390@vger.kernel.org,
 kvm@vger.kernel.org
References: <20240327095741.88135-1-xuanzhuo@linux.alibaba.com>
 <20240327095741.88135-6-xuanzhuo@linux.alibaba.com>
 <CACGkMEu4J0ZD26GjahKr6YysBrj==rgtiKcnpnuV7dC9Zj-+CQ@mail.gmail.com>
In-Reply-To: <CACGkMEu4J0ZD26GjahKr6YysBrj==rgtiKcnpnuV7dC9Zj-+CQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_233420_032572_35CBF517 
X-CRM114-Status: GOOD (  18.92  )
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

On Thu, 28 Mar 2024 12:31:48 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Mar 27, 2024 at 5:58=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > Now, we pass multi parameters to vring_new_virtqueue. These parameters
> > may from transport or from driver.
> >
> > vring_new_virtqueue is called by many places.
> > Every time, we try to add a new parameter, that is difficult.
> >
> > If parameters from the driver, that should directly be passed to vring.
> > Then the vring can access the config from driver directly.
> >
> > If parameters from the transport, we squish the parameters to a
> > structure. That will be helpful to add new parameter.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/platform/mellanox/mlxbf-tmfifo.c | 12 ++++---
> >  drivers/remoteproc/remoteproc_virtio.c   | 11 ++++---
> >  drivers/virtio/virtio_ring.c             | 29 +++++++++++-----
> >  include/linux/virtio_ring.h              | 42 +++++++++++++++++++-----
> >  tools/virtio/virtio_test.c               |  4 +--
> >  tools/virtio/vringh_test.c               | 28 ++++++++--------
> >  6 files changed, 84 insertions(+), 42 deletions(-)
> >
> > diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platfor=
m/mellanox/mlxbf-tmfifo.c
> > index 4252388f52a2..d2e871fad8b4 100644
> > --- a/drivers/platform/mellanox/mlxbf-tmfifo.c
> > +++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
> > @@ -1059,6 +1059,7 @@ static int mlxbf_tmfifo_virtio_find_vqs(struct vi=
rtio_device *vdev,
> >                                         struct virtio_vq_config *cfg)
> >  {
> >         struct mlxbf_tmfifo_vdev *tm_vdev =3D mlxbf_vdev_to_tmfifo(vdev=
);
> > +       struct vq_transport_config tp_cfg =3D {};
> >         struct virtqueue **vqs =3D cfg->vqs;
> >         struct mlxbf_tmfifo_vring *vring;
> >         unsigned int nvqs =3D cfg->nvqs;
> > @@ -1078,10 +1079,13 @@ static int mlxbf_tmfifo_virtio_find_vqs(struct =
virtio_device *vdev,
> >                 /* zero vring */
> >                 size =3D vring_size(vring->num, vring->align);
> >                 memset(vring->va, 0, size);
> > -               vq =3D vring_new_virtqueue(i, vring->num, vring->align,=
 vdev,
> > -                                        false, false, vring->va,
> > -                                        mlxbf_tmfifo_virtio_notify,
> > -                                        cfg->callbacks[i], cfg->names[=
i]);
> > +
> > +               tp_cfg.num =3D vring->num;
> > +               tp_cfg.vring_align =3D vring->align;
> > +               tp_cfg.weak_barriers =3D false;
> > +               tp_cfg.notify =3D mlxbf_tmfifo_virtio_notify;
> > +
> > +               vq =3D vring_new_virtqueue(vdev, i, vring->va, &tp_cfg,=
 cfg);
> >                 if (!vq) {
> >                         dev_err(&vdev->dev, "vring_new_virtqueue failed=
\n");
> >                         ret =3D -ENOMEM;
> > diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remotepro=
c/remoteproc_virtio.c
> > index 489fea1d41c0..2319c2007833 100644
> > --- a/drivers/remoteproc/remoteproc_virtio.c
> > +++ b/drivers/remoteproc/remoteproc_virtio.c
> > @@ -106,6 +106,7 @@ static struct virtqueue *rp_find_vq(struct virtio_d=
evice *vdev,
> >  {
> >         struct rproc_vdev *rvdev =3D vdev_to_rvdev(vdev);
> >         struct rproc *rproc =3D vdev_to_rproc(vdev);
> > +       struct vq_transport_config tp_cfg;
>
> Should we zero this structure?

YES.

Will fix in next version.

Thanks.


>
> Thanks
>

