Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991D5C54E58
	for <linux-um@archiver.kernel.org>; Tue, 26 Mar 2024 07:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Date:Subject:Message-ID:
	Reply-To:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ba4I0Bd+6onGK25mYl7fzEyLNywF5unBrX0VUtEKFgw=; b=YdlaR5mkVwXxnRimwffzq9zUhE
	j+fu+bEbzZv52BuAz/SBd6KCU+/AyLzUBRZp1zJst9TCCfLzt+hMkYOC+qSbmHgkSyPV7ju8Nl5Hn
	O8mUYeuYZUGyxRr4y4xwGGOraEOCIIKl4mxmtq8S1k5+wr40hgFYMpreEQoLCU7OW19+xwl2Ck+Rj
	VWmJQdFX6jYcvM0F/tBU96nEhoJKviyWZnoG6ykfUk2mGFNQ9aa7MZFcQNkCAT8iXti/xwN1b6p8Z
	hIdYKNmpoVCCAEH5eO8uoZos6H94moTuxoqwcT5WyV1MZESZIp2YR5frlTL8Ab/sPrVuDVt/cz1Cn
	FEgQknEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp1Ut-00000003UFY-32MW;
	Tue, 26 Mar 2024 07:45:27 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp1Uo-00000003UEu-3Xrl
	for linux-um@lists.infradead.org;
	Tue, 26 Mar 2024 07:45:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711439117; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=Ba4I0Bd+6onGK25mYl7fzEyLNywF5unBrX0VUtEKFgw=;
	b=PJEImLexq3GUOjljWURhxWMHlBVskR+1h20nSRW4LJNtvHly5q8SW1RXU/9TGrwt7vLJsCceT+cjQXTghLf0SarjZtIeh6NNCE7GWUHqUVjByxOvjzG0yhNwrht/seOTeExZPZcnsvOL1u6nj9UQ+ESw/sr7/B2ibDxYwQJHACk=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=25;SR=0;TI=SMTPD_---0W3KMp1M_1711439114;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3KMp1M_1711439114)
          by smtp.aliyun-inc.com;
          Tue, 26 Mar 2024 15:45:14 +0800
Message-ID: <1711438956.7547545-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v5 2/6] virtio: remove support for names array entries being null.
Date: Tue, 26 Mar 2024 15:42:36 +0800
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
References: <20240325090419.33677-1-xuanzhuo@linux.alibaba.com>
 <20240325090419.33677-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEuuNrDkEUnnES-APDVag2=4wjyZi3aEg0+8vY+Bho=BRg@mail.gmail.com>
In-Reply-To: <CACGkMEuuNrDkEUnnES-APDVag2=4wjyZi3aEg0+8vY+Bho=BRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_004524_335389_FDCB7474 
X-CRM114-Status: GOOD (  23.93  )
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

On Tue, 26 Mar 2024 12:28:34 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Mar 25, 2024 at 5:04=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > commit 6457f126c888 ("virtio: support reserved vqs") introduced this
> > support. Multiqueue virtio-net use 2N as ctrl vq finally, so the logic
> > doesn't apply. And not one uses this.
> >
> > On the other side, that makes some trouble for us to refactor the
> > find_vqs() params.
> >
> > So I remove this support.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  arch/um/drivers/virtio_uml.c             | 5 -----
> >  drivers/platform/mellanox/mlxbf-tmfifo.c | 4 ----
> >  drivers/remoteproc/remoteproc_virtio.c   | 5 -----
> >  drivers/s390/virtio/virtio_ccw.c         | 5 -----
> >  drivers/virtio/virtio_mmio.c             | 5 -----
> >  drivers/virtio/virtio_pci_common.c       | 9 ---------
> >  drivers/virtio/virtio_vdpa.c             | 5 -----
> >  include/linux/virtio_config.h            | 1 -
> >  8 files changed, 39 deletions(-)
> >
> > diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
> > index 8adca2000e51..1d1e8654b7fc 100644
> > --- a/arch/um/drivers/virtio_uml.c
> > +++ b/arch/um/drivers/virtio_uml.c
> > @@ -1031,11 +1031,6 @@ static int vu_find_vqs(struct virtio_device *vde=
v, unsigned nvqs,
> >                 return rc;
> >
> >         for (i =3D 0; i < nvqs; ++i) {
> > -               if (!names[i]) {
> > -                       vqs[i] =3D NULL;
> > -                       continue;
> > -               }
>
> Does this mean names[i] must not be NULL? If yes, should we fail or
> not? If not, do we need to change the doc?

I think we should make sure that the names[i] must not be NULL.
We should return fail.

>
> [...]
>
> > --- a/include/linux/virtio_config.h
> > +++ b/include/linux/virtio_config.h
> > @@ -56,7 +56,6 @@ typedef void vq_callback_t(struct virtqueue *);
> >   *     callbacks: array of callbacks, for each virtqueue
> >   *             include a NULL entry for vqs that do not need a callback
> >   *     names: array of virtqueue names (mainly for debugging)
> > - *             include a NULL entry for vqs unused by driver
> >   *     Returns 0 on success or error status
> >   * @del_vqs: free virtqueues found by find_vqs().
> >   * @synchronize_cbs: synchronize with the virtqueue callbacks (optiona=
l)
>
>
> Since we had other check for names[i] like:
>
>         if (per_vq_vectors) {
>                 /* Best option: one for change interrupt, one per vq. */
>                 nvectors =3D 1;
>                 for (i =3D 0; i < nvqs; ++i)
>                         if (names[i] && callbacks[i])
>                                 ++nvectors;
>
> in vp_find_vqs_msix() and maybe other places.

names[i] should always be true. I will check this.

Thanks


>
> > --
> > 2.32.0.3.g01195cf9f
> >
>

