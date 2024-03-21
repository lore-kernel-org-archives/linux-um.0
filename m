Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E26C54E58
	for <linux-um@archiver.kernel.org>; Thu, 21 Mar 2024 04:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Date:Subject:Message-ID:
	Reply-To:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=req0CIF/JHvwS9l1KiNeKKb/Omqe6sSvgFAD4vx65+k=; b=0RP6ygX+0pERm0q8iM/11OP0cA
	O+AU6qxyJbLu0Zje7Gj3dCjjlhE5dY0uLqKi0YreC1XnL6+Hx1N0ahlV8pqcCZOBn6HAWUErpPQae
	oFHkGfGggAINTp86x2hSs9z3MV7HW3mwq2/Me5MGxbQegDR2igp9kVAfCyI5+aHEkMlBVCGT5wDA7
	P3iCeyJM1dta7++hAYy4fG13ky0YJLAI1Ld7wMCYZ92fyMSL5eHJcXGqOacP/R4oURL8oGgslOCKb
	cRcJaUYs6t+4Hj9XGgUYT1EU7n6tmuqdCW8KOhN++n5cfRG5UP9pUxBvVJHx6tpuNWsG3DCemsWFt
	8GUQbLwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rn9nN-00000001n6v-2vAl;
	Thu, 21 Mar 2024 04:12:49 +0000
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rn9nK-00000001n6A-1qWH
	for linux-um@lists.infradead.org;
	Thu, 21 Mar 2024 04:12:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710994363; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=req0CIF/JHvwS9l1KiNeKKb/Omqe6sSvgFAD4vx65+k=;
	b=eq0vEwY9Xi0wB9tLzAnaWUdV1+6rhGN5E44vTQvI3Js1R5UXc7Pl2Pg5NqSEiU45x1jCPGUqWc7lEAggaQ3aYGlt6ojFLIM/hPZIVYrxKkLiuYhIQlB8OoY+wqfm1wQC21nE7YimaTk2+KbUzQuYXe/tOKqOG3BSha5l+lvbUFo=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0W2zLFlC_1710994361;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W2zLFlC_1710994361)
          by smtp.aliyun-inc.com;
          Thu, 21 Mar 2024 12:12:42 +0800
Message-ID: <1710994269.7745419-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v3 1/4] virtio: find_vqs: pass struct instead of multi parameters
Date: Thu, 21 Mar 2024 12:11:09 +0800
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
 linux-um@lists.infradead.org,
 platform-driver-x86@vger.kernel.org,
 linux-remoteproc@vger.kernel.org,
 linux-s390@vger.kernel.org,
 kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20240312021013.88656-1-xuanzhuo@linux.alibaba.com>
 <20240312021013.88656-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEvVgfgAxLoKeFTgy-1GR0W07ciPYFuqs6PiWtKCnXuWTw@mail.gmail.com>
 <1710395908.7915084-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsT2JqJ1r_kStUzW0+-f+qT0C05n2A+Yrjpc-mHMZD_mQ@mail.gmail.com>
 <1710487245.6843069-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEspzDTZP1yxkBz17MgU9meyfCUBDxG8mjm=acXHNxAxhg@mail.gmail.com>
 <1710741592.205804-1-xuanzhuo@linux.alibaba.com>
 <20240319025726-mutt-send-email-mst@kernel.org>
 <CACGkMEsO6e2=v36F=ezhHCEaXqG0+AhkCM2ZgmKAtyWncnif5Q@mail.gmail.com>
 <1710927569.5383172-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuEqiLLGj-HY=gx4R1EVh_d=eYrmi=cuLzb1SiqiEHb-A@mail.gmail.com>
In-Reply-To: <CACGkMEuEqiLLGj-HY=gx4R1EVh_d=eYrmi=cuLzb1SiqiEHb-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_211246_865709_EBA5F90F 
X-CRM114-Status: GOOD (  48.97  )
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

On Thu, 21 Mar 2024 12:03:36 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Mar 20, 2024 at 5:41=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Wed, 20 Mar 2024 17:22:50 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Tue, Mar 19, 2024 at 2:58=E2=80=AFPM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Mon, Mar 18, 2024 at 01:59:52PM +0800, Xuan Zhuo wrote:
> > > > > On Mon, 18 Mar 2024 12:18:23 +0800, Jason Wang <jasowang@redhat.c=
om> wrote:
> > > > > > On Fri, Mar 15, 2024 at 3:26=E2=80=AFPM Xuan Zhuo <xuanzhuo@lin=
ux.alibaba.com> wrote:
> > > > > > >
> > > > > > > On Fri, 15 Mar 2024 11:51:48 +0800, Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > > > > On Thu, Mar 14, 2024 at 2:00=E2=80=AFPM Xuan Zhuo <xuanzhuo=
@linux.alibaba.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, 14 Mar 2024 11:12:24 +0800, Jason Wang <jasowang@=
redhat.com> wrote:
> > > > > > > > > > On Tue, Mar 12, 2024 at 10:10=E2=80=AFAM Xuan Zhuo <xua=
nzhuo@linux.alibaba.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Now, we pass multi parameters to find_vqs. These para=
meters
> > > > > > > > > > > may work for transport or work for vring.
> > > > > > > > > > >
> > > > > > > > > > > And find_vqs has multi implements in many places:
> > > > > > > > > > >
> > > > > > > > > > >  arch/um/drivers/virtio_uml.c
> > > > > > > > > > >  drivers/platform/mellanox/mlxbf-tmfifo.c
> > > > > > > > > > >  drivers/remoteproc/remoteproc_virtio.c
> > > > > > > > > > >  drivers/s390/virtio/virtio_ccw.c
> > > > > > > > > > >  drivers/virtio/virtio_mmio.c
> > > > > > > > > > >  drivers/virtio/virtio_pci_legacy.c
> > > > > > > > > > >  drivers/virtio/virtio_pci_modern.c
> > > > > > > > > > >  drivers/virtio/virtio_vdpa.c
> > > > > > > > > > >
> > > > > > > > > > > Every time, we try to add a new parameter, that is di=
fficult.
> > > > > > > > > > > We must change every find_vqs implement.
> > > > > > > > > > >
> > > > > > > > > > > One the other side, if we want to pass a parameter to=
 vring,
> > > > > > > > > > > we must change the call path from transport to vring.
> > > > > > > > > > > Too many functions need to be changed.
> > > > > > > > > > >
> > > > > > > > > > > So it is time to refactor the find_vqs. We pass a str=
ucture
> > > > > > > > > > > cfg to find_vqs(), that will be passed to vring by tr=
ansport.
> > > > > > > > > > >
> > > > > > > > > > > Because the vp_modern_create_avq() use the "const cha=
r *names[]",
> > > > > > > > > > > and the virtio_uml.c changes the name in the subseque=
nt commit, so
> > > > > > > > > > > change the "names" inside the virtio_vq_config from "=
const char *const
> > > > > > > > > > > *names" to "const char **names".
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > > > > Acked-by: Johannes Berg <johannes@sipsolutions.net>
> > > > > > > > > > > Reviewed-by: Ilpo J=3DE4rvinen <ilpo.jarvinen@linux.i=
ntel.com>
> > > > > > > > > >
> > > > > > > > > > The name seems broken here.
> > > > > > > > >
> > > > > > > > > Email APP bug.
> > > > > > > > >
> > > > > > > > > I will fix.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > [...]
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > >  typedef void vq_callback_t(struct virtqueue *);
> > > > > > > > > > >
> > > > > > > > > > > +/**
> > > > > > > > > > > + * struct virtio_vq_config - configure for find_vqs()
> > > > > > > > > > > + * @cfg_idx: Used by virtio core. The drivers should=
 set this to 0.
> > > > > > > > > > > + *     During the initialization of each vq(vring se=
tup), we need to know which
> > > > > > > > > > > + *     item in the array should be used at that time=
. But since the item in
> > > > > > > > > > > + *     names can be null, which causes some item of =
array to be skipped, we
> > > > > > > > > > > + *     cannot use vq.index as the current id. So add=
 a cfg_idx to let vring
> > > > > > > > > > > + *     know how to get the current configuration fro=
m the array when
> > > > > > > > > > > + *     initializing vq.
> > > > > > > > > >
> > > > > > > > > > So this design is not good. If it is not something that=
 the driver
> > > > > > > > > > needs to care about, the core needs to hide it from the=
 API.
> > > > > > > > >
> > > > > > > > > The driver just ignore it. That will be beneficial to the=
 virtio core.
> > > > > > > > > Otherwise, we must pass one more parameter everywhere.
> > > > > > > >
> > > > > > > > I don't get here, it's an internal logic and we've already =
done that.
> > > > > > >
> > > > > > >
> > > > > > > ## Then these must add one param "cfg_idx";
> > > > > > >
> > > > > > >  struct virtqueue *vring_create_virtqueue(struct virtio_devic=
e *vdev,
> > > > > > >                                          unsigned int index,
> > > > > > >                                          struct vq_transport_=
config *tp_cfg,
> > > > > > >                                          struct virtio_vq_con=
fig *cfg,
> > > > > > > -->                                      uint cfg_idx);
> > > > > > >
> > > > > > >  struct virtqueue *vring_new_virtqueue(struct virtio_device *=
vdev,
> > > > > > >                                       unsigned int index,
> > > > > > >                                       void *pages,
> > > > > > >                                       struct vq_transport_con=
fig *tp_cfg,
> > > > > > >                                       struct virtio_vq_config=
 *cfg,
> > > > > > > -->                                      uint cfg_idx);
> > > > > > >
> > > > > > >
> > > > > > > ## The functions inside virtio_ring also need to add a new pa=
ram, such as:
> > > > > > >
> > > > > > >  static struct virtqueue *vring_create_virtqueue_split(struct=
 virtio_device *vdev,
> > > > > > >                                                       unsigne=
d int index,
> > > > > > >                                                       struct =
vq_transport_config *tp_cfg,
> > > > > > >                                                       struct =
virtio_vq_config,
> > > > > > > -->                                                   uint cf=
g_idx);
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > >
> > > > > > I guess what I'm missing is when could the index differ from cf=
g_idx?
> > > > >
> > > > >
> > > > >  @cfg_idx: Used by virtio core. The drivers should set this to 0.
> > > > >      During the initialization of each vq(vring setup), we need t=
o know which
> > > > >      item in the array should be used at that time. But since the=
 item in
> > > > >      names can be null, which causes some item of array to be ski=
pped, we
> > > > >      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^
> > > > >      cannot use vq.index as the current id. So add a cfg_idx to l=
et vring
> > > > >      know how to get the current configuration from the array when
> > > > >      initializing vq.
> > > > >
> > > > >
> > > > > static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned =
int nvqs,
> > > > >
> > > > >       ................
> > > > >
> > > > >       for (i =3D 0; i < nvqs; ++i) {
> > > > >               if (!names[i]) {
> > > > >                       vqs[i] =3D NULL;
> > > > >                       continue;
> > > > >               }
> > > > >
> > > > >               if (!callbacks[i])
> > > > >                       msix_vec =3D VIRTIO_MSI_NO_VECTOR;
> > > > >               else if (vp_dev->per_vq_vectors)
> > > > >                       msix_vec =3D allocated_vectors++;
> > > > >               else
> > > > >                       msix_vec =3D VP_MSIX_VQ_VECTOR;
> > > > >               vqs[i] =3D vp_setup_vq(vdev, queue_idx++, callbacks=
[i], names[i],
> > > > >                                    ctx ? ctx[i] : false,
> > > > >                                    msix_vec);
> > > > >
> > > > >
> > > > > Thanks.
> > > >
> > > >
> > > > Jason what do you think is the way to resolve this?
> > >
> > > I wonder which driver doesn't use a specific virtqueue in this case.
> >
> >
> > commit 6457f126c888b3481fdae6f702e616cd0c79646e
> > Author: Michael S. Tsirkin <mst@redhat.com>
> > Date:   Wed Sep 5 21:47:45 2012 +0300
> >
> >     virtio: support reserved vqs
> >
> >     virtio network device multiqueue support reserves
> >     vq 3 for future use (useful both for future extensions and to make =
it
> >     pretty - this way receive vqs have even and transmit - odd numbers).
> >     Make it possible to skip initialization for
> >     specific vq numbers by specifying NULL for name.
> >     Document this usage as well as (existing) NULL callback.
> >
> >     Drivers using this not coded up yet, so I simply tested
> >     with virtio-pci and verified that this patch does
> >     not break existing drivers.
> >
> >     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >     Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> >
> > This patch introduced this.
> >
> > Could we remove this? Then we can use the vq.index directly. That will
> > be great.
> >
> > >
> > > And it looks to me, introducing a per-vq-config struct might be better
> > > then we have
> > >
> > > virtio_vqs_config {
> > >       unsigned int nvqs;
> > >       struct virtio_vq_config *configs;
> > > }
> >
> > YES. I prefer this. But we need to refactor every driver.
>
> Yes.
>
> >
> > >
> > > So we don't need the cfg_idx stuff.
> >
> > This still needs cfg_idx.
>
> Drive needs to pass config for each virtqueue. We can still check
> config->name so the virtqueue index could be used.

I see. If we pass the config for one queue to virtio ring,
then we do not to pass the idx.

But for now, I will remove the logic of checking name,
then we can use vq->index inside virtio ring.

Thanks.


>
> Thanks
>
> >
> > Thanks
> >
> >
> > >
> > > Thanks
> > >
> > > >
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > > Thanks.
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > Thanks
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Thanks.
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Thanks
> > > > > > > > > >
> > > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > >
> > > >
> > >
> >
>

