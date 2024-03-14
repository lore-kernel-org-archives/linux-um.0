Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11984C5475B
	for <linux-um@archiver.kernel.org>; Thu, 14 Mar 2024 06:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Date:Subject:Message-ID:
	Reply-To:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/3auDq21P+3VIk5KDxp7XywdJJcGN1ChRwn63QuP8Pg=; b=TByWrHpkuukEJJuLwhf3CD2wXB
	jGQ1Zorv0EkEIlCmNjd6cx8Lk1gpbEQsD5mG38E1ZU59DS01FXluBXqqMxTpYrKQSTOO05iRgcZBF
	u7ktL/ANtumtEfUpQ9MCnlRMbQOCf05GFIzs1IMCRYB0g5mT6Uo7bcwptOOHBuG/6LY5PIHhYOKaP
	gTcQGHTyN1yhUn3W/UifZFhTl7VCxgRbytGAPHxLNCBhQmTnBIJIpKqXbfkiXsqSItFfFfbzkE5fE
	AuD3pt+elYzdSUohXzFuEhvbCyCYEC2XFUHrXEvUGppeNG/XoRBjZUPUqAAwHtXArHpo8uvEE9ZGk
	gphl5j5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rke9M-0000000D8Bb-2LkX;
	Thu, 14 Mar 2024 06:01:08 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rke95-0000000D82M-0gLS
	for linux-um@bombadil.infradead.org;
	Thu, 14 Mar 2024 06:00:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:References:Cc:To:From:Date:Subject:Message-ID:Sender:Reply-To:
	MIME-Version:Content-ID:Content-Description;
	bh=/3auDq21P+3VIk5KDxp7XywdJJcGN1ChRwn63QuP8Pg=; b=eJ27py/HoELFxb2BZ2/8oIEeLH
	Y0A+GHJ+GS/JYFUv6xnnXDbd587TBXDRjiEGqk9Pl/fWyz0N/x6l4fe7QvLEPaOkKH3Nq6tSmNvix
	Q2kVS/VrCbMaKXAAUDt65taPzZTBne8oD3Mn+Sh+L09HgkwMr5AjrpN9ctXWAdXDqQbGGoiaQloKn
	fyz4AvoTznRwi49sK29vuygctNDw3nrSMQ0YgNXFtsXye0evzhE3OGdwljqL4s9nVjTgAezhKBSB5
	QFoftku2Pw9viL5QjYeBbPVyYT9KjAkjVQPAsCDj7n1D8dQjE3CG4W7WmnhIwPhDKMfW/3oal9p7a
	O3jDKeyg==;
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rke8y-0000000AMZ0-2L18
	for linux-um@lists.infradead.org;
	Thu, 14 Mar 2024 06:00:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710396031; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=/3auDq21P+3VIk5KDxp7XywdJJcGN1ChRwn63QuP8Pg=;
	b=X7xOAyTzRU0zpryR83xAF8mV/cAk9wXeopwhTqHAt9t2ZsYcLM0nkGdosmTRIPvjAnoPJhhWQ75EZisafsDRMNYhXiuLZLAweUPheS6Ytiu+iN/agij3j+0iUXfpgjLjqFWjACUQg0R/hwmgyQfpqf9+/0200CIRYl7tJ3SSzWM=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0W2RGslY_1710396029;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W2RGslY_1710396029)
          by smtp.aliyun-inc.com;
          Thu, 14 Mar 2024 14:00:29 +0800
Message-ID: <1710395908.7915084-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v3 1/4] virtio: find_vqs: pass struct instead of multi parameters
Date: Thu, 14 Mar 2024 13:58:28 +0800
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
In-Reply-To: <CACGkMEvVgfgAxLoKeFTgy-1GR0W07ciPYFuqs6PiWtKCnXuWTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240314_060047_307524_CA443968 
X-CRM114-Status: GOOD (  21.82  )
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

On Thu, 14 Mar 2024 11:12:24 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Mar 12, 2024 at 10:10=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> >
> > Now, we pass multi parameters to find_vqs. These parameters
> > may work for transport or work for vring.
> >
> > And find_vqs has multi implements in many places:
> >
> >  arch/um/drivers/virtio_uml.c
> >  drivers/platform/mellanox/mlxbf-tmfifo.c
> >  drivers/remoteproc/remoteproc_virtio.c
> >  drivers/s390/virtio/virtio_ccw.c
> >  drivers/virtio/virtio_mmio.c
> >  drivers/virtio/virtio_pci_legacy.c
> >  drivers/virtio/virtio_pci_modern.c
> >  drivers/virtio/virtio_vdpa.c
> >
> > Every time, we try to add a new parameter, that is difficult.
> > We must change every find_vqs implement.
> >
> > One the other side, if we want to pass a parameter to vring,
> > we must change the call path from transport to vring.
> > Too many functions need to be changed.
> >
> > So it is time to refactor the find_vqs. We pass a structure
> > cfg to find_vqs(), that will be passed to vring by transport.
> >
> > Because the vp_modern_create_avq() use the "const char *names[]",
> > and the virtio_uml.c changes the name in the subsequent commit, so
> > change the "names" inside the virtio_vq_config from "const char *const
> > *names" to "const char **names".
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Acked-by: Johannes Berg <johannes@sipsolutions.net>
> > Reviewed-by: Ilpo J=3DE4rvinen <ilpo.jarvinen@linux.intel.com>
>
> The name seems broken here.

Email APP bug.

I will fix.


>
> [...]
>
> >
> >  typedef void vq_callback_t(struct virtqueue *);
> >
> > +/**
> > + * struct virtio_vq_config - configure for find_vqs()
> > + * @cfg_idx: Used by virtio core. The drivers should set this to 0.
> > + *     During the initialization of each vq(vring setup), we need to k=
now which
> > + *     item in the array should be used at that time. But since the it=
em in
> > + *     names can be null, which causes some item of array to be skippe=
d, we
> > + *     cannot use vq.index as the current id. So add a cfg_idx to let =
vring
> > + *     know how to get the current configuration from the array when
> > + *     initializing vq.
>
> So this design is not good. If it is not something that the driver
> needs to care about, the core needs to hide it from the API.

The driver just ignore it. That will be beneficial to the virtio core.
Otherwise, we must pass one more parameter everywhere.

Thanks.

>
> Thanks
>

