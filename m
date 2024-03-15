Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B7CC54E58
	for <linux-um@archiver.kernel.org>; Fri, 15 Mar 2024 07:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Date:Subject:Message-ID:
	Reply-To:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wYXGZXsXkyY7qVA2NeuTlUtUzzuzmBM3vEFpfOr6Om4=; b=LMwepoW28qiowYaawMRHbMWVtt
	GQGflwxhkK3ugcAVgltB124tqwV4wtfUBMBJILYqV5uoxwBSnoIKii2AvTpEdxcRob3Lt4fYbpk5o
	Nw1TiD221qFEBj7OYd2f6bIe39ZRzoBOq8LVjucXSA/M21Kefucm6c7/P2dkOPD6VILzL2qvtgsWK
	rU4T584GBuVl4RRWnNsKonbSe2YP0hR3mSp7KNmIfSO7FnOFPNl7EzqHPE01Q9PZwuhyHpV2CnSzP
	uvFHfr2IRsrU88H7AhYWNt673tNCeLO+PVH8LfAKsghZv8T5/UBWo3emgxh6Dt/vgfZ/5Mj0kYi90
	iloZMZBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rl1xe-0000000GybQ-09Kd;
	Fri, 15 Mar 2024 07:26:38 +0000
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rl1xJ-0000000GyOZ-1h8Z
	for linux-um@lists.infradead.org;
	Fri, 15 Mar 2024 07:26:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710487572; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=wYXGZXsXkyY7qVA2NeuTlUtUzzuzmBM3vEFpfOr6Om4=;
	b=w0lrCIBljB1hQbsWctYB/5dnGHupEN5qEne8u9Ch5A0GnqHhGxmP4W4FSTk+5VghYA74wilvT+7Ph9BnJNCybpArb5IM3Dr2XGelAhq2uN7UFli0VqhfIFK8rhpUsGi8DqTy1sJZywU16z0IccwydXop1soPTiP6qqbhQLr7zvg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0W2VQGyQ_1710487569;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W2VQGyQ_1710487569)
          by smtp.aliyun-inc.com;
          Fri, 15 Mar 2024 15:26:10 +0800
Message-ID: <1710487245.6843069-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v3 1/4] virtio: find_vqs: pass struct instead of multi parameters
Date: Fri, 15 Mar 2024 15:20:45 +0800
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
 linux-um@lists.infradead.org,
 platform-driver-x86@vger.kernel.org,
 linux-remoteproc@vger.kernel.org,
 linux-s390@vger.kernel.org,
 kvm@vger.kernel.org
References: <20240312021013.88656-1-xuanzhuo@linux.alibaba.com>
 <20240312021013.88656-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEvVgfgAxLoKeFTgy-1GR0W07ciPYFuqs6PiWtKCnXuWTw@mail.gmail.com>
 <1710395908.7915084-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsT2JqJ1r_kStUzW0+-f+qT0C05n2A+Yrjpc-mHMZD_mQ@mail.gmail.com>
In-Reply-To: <CACGkMEsT2JqJ1r_kStUzW0+-f+qT0C05n2A+Yrjpc-mHMZD_mQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240315_002618_284842_BA70347B 
X-CRM114-Status: GOOD (  27.17  )
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

On Fri, 15 Mar 2024 11:51:48 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Thu, Mar 14, 2024 at 2:00=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Thu, 14 Mar 2024 11:12:24 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Tue, Mar 12, 2024 at 10:10=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.al=
ibaba.com> wrote:
> > > >
> > > > Now, we pass multi parameters to find_vqs. These parameters
> > > > may work for transport or work for vring.
> > > >
> > > > And find_vqs has multi implements in many places:
> > > >
> > > >  arch/um/drivers/virtio_uml.c
> > > >  drivers/platform/mellanox/mlxbf-tmfifo.c
> > > >  drivers/remoteproc/remoteproc_virtio.c
> > > >  drivers/s390/virtio/virtio_ccw.c
> > > >  drivers/virtio/virtio_mmio.c
> > > >  drivers/virtio/virtio_pci_legacy.c
> > > >  drivers/virtio/virtio_pci_modern.c
> > > >  drivers/virtio/virtio_vdpa.c
> > > >
> > > > Every time, we try to add a new parameter, that is difficult.
> > > > We must change every find_vqs implement.
> > > >
> > > > One the other side, if we want to pass a parameter to vring,
> > > > we must change the call path from transport to vring.
> > > > Too many functions need to be changed.
> > > >
> > > > So it is time to refactor the find_vqs. We pass a structure
> > > > cfg to find_vqs(), that will be passed to vring by transport.
> > > >
> > > > Because the vp_modern_create_avq() use the "const char *names[]",
> > > > and the virtio_uml.c changes the name in the subsequent commit, so
> > > > change the "names" inside the virtio_vq_config from "const char *co=
nst
> > > > *names" to "const char **names".
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > Acked-by: Johannes Berg <johannes@sipsolutions.net>
> > > > Reviewed-by: Ilpo J=3DE4rvinen <ilpo.jarvinen@linux.intel.com>
> > >
> > > The name seems broken here.
> >
> > Email APP bug.
> >
> > I will fix.
> >
> >
> > >
> > > [...]
> > >
> > > >
> > > >  typedef void vq_callback_t(struct virtqueue *);
> > > >
> > > > +/**
> > > > + * struct virtio_vq_config - configure for find_vqs()
> > > > + * @cfg_idx: Used by virtio core. The drivers should set this to 0.
> > > > + *     During the initialization of each vq(vring setup), we need =
to know which
> > > > + *     item in the array should be used at that time. But since th=
e item in
> > > > + *     names can be null, which causes some item of array to be sk=
ipped, we
> > > > + *     cannot use vq.index as the current id. So add a cfg_idx to =
let vring
> > > > + *     know how to get the current configuration from the array wh=
en
> > > > + *     initializing vq.
> > >
> > > So this design is not good. If it is not something that the driver
> > > needs to care about, the core needs to hide it from the API.
> >
> > The driver just ignore it. That will be beneficial to the virtio core.
> > Otherwise, we must pass one more parameter everywhere.
>
> I don't get here, it's an internal logic and we've already done that.


## Then these must add one param "cfg_idx";

 struct virtqueue *vring_create_virtqueue(struct virtio_device *vdev,
 					 unsigned int index,
 					 struct vq_transport_config *tp_cfg,
 					 struct virtio_vq_config *cfg,
--> 					 uint cfg_idx);

 struct virtqueue *vring_new_virtqueue(struct virtio_device *vdev,
 				      unsigned int index,
 				      void *pages,
 				      struct vq_transport_config *tp_cfg,
 				      struct virtio_vq_config *cfg,
--> 					 uint cfg_idx);


## The functions inside virtio_ring also need to add a new param, such as:

 static struct virtqueue *vring_create_virtqueue_split(struct virtio_device=
 *vdev,
						      unsigned int index,
						      struct vq_transport_config *tp_cfg,
						      struct virtio_vq_config,
--> 					              uint cfg_idx);



Thanks.




>
> Thanks
>
> >
> > Thanks.
> >
> > >
> > > Thanks
> > >
> >
>

