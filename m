Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A57C54E58
	for <linux-um@archiver.kernel.org>; Fri, 15 Mar 2024 03:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jRnPjyJeZad1F26bIZOTcaKiZRrwc4cB/pDexLjVGDE=; b=XRPw210PdyO7HwetWDfQO/EmLP
	77W+fEsMgzW+0eryleMZV1iQsszCIEKrQnqZFriKw8p1w10k2xj09sfaDzk0AiHI8C8MuDWOIzInw
	12J6ff7lBOvJOdq+Hje3UcDVwLfJsYjh4x5I+zfu1gOrOQQ6qmAnyTOtt0CemehQjWb0jKWRA67un
	LkoQQEeXy87arA+cABB3RwkJVt+YEQDB0Npl0MvwWvgdVeAkqx8vC0YZxF4qk2qZewkDtH5eaxuOQ
	Sw9JikhADG+TzYFnUeWYeryZivoQMeMI9c3JQRrPK24Mfoux3CnRAJ56dqiANJIm2LvlI8oVds1te
	ek12hJnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkyc6-0000000GZPA-0JTi;
	Fri, 15 Mar 2024 03:52:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkyc2-0000000GZOf-3NkC
	for linux-um@lists.infradead.org;
	Fri, 15 Mar 2024 03:52:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710474724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jRnPjyJeZad1F26bIZOTcaKiZRrwc4cB/pDexLjVGDE=;
	b=VKg8aE7eO9wJeqvTEnDsLgmSTOzSBTfZ6WDZY0yYx5l3Gucoi/EQI4t08HOC+Y0Koaus3G
	03BTdgw33/Yhz6SWxdLJTDJzcWc8Xppo4Sxg3WN9XhhQlWmRh68XVjoUE6fkJrbHlFqIYP
	RSlb1ik6u5wleWqvrKyQbpbLtZvR4+k=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-GOjiYN-nOy-QokXdBGu7jg-1; Thu, 14 Mar 2024 23:52:01 -0400
X-MC-Unique: GOjiYN-nOy-QokXdBGu7jg-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-29c718b7ff5so1543249a91.2
        for <linux-um@lists.infradead.org>; Thu, 14 Mar 2024 20:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710474720; x=1711079520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRnPjyJeZad1F26bIZOTcaKiZRrwc4cB/pDexLjVGDE=;
        b=fjjM2Z0sQINp960LhFj8VH0ciKy4lvD8xL5ItlFZF1ePby66+1sIWafxx12hNB9zmC
         OIALpk8+X+QotSfOSS0Uoa5c2iLyWMTyIwSjnXxHC1pKwLwVf3Kmol5UcJd6sa6+PHxF
         gOCS+iu7OjvfCGzOcXwW38O0SVmBqZiJvbZjISuriZqIAHgIS+WhPbS6+k6ZM16Nq7KR
         E2B6b9UeW5hgJOjgs4eoS3SA9ec0RST1nm8osJDhrBTQ9k3kQDB6xFmxkdJhDNuOKwOu
         EHnY8FKkIuqGdfxI/K81N/uLl3QZOWDaVuLz7cNyBWFOhC/RIujvHlOfT4ZJOSXNC3t0
         Y45g==
X-Forwarded-Encrypted: i=1; AJvYcCXpbQPdBKFnEnfFw1K/mNsvun744bSXnN4Lxiox3S2UKZOPUFmr1xL1lqfUrFmaaNoLp2FYWdyYMDEf+uI4D49kGrneOYIbfRikbElS
X-Gm-Message-State: AOJu0YxxP3vTO01JOxfxeH++h2BRk7KMPr8HmTPj6/3aerGtdTydnuU1
	03JBE5LEUz8unp72pnEgQBBfP3qxTsG32Wp5RQRWxR1BzKfuiFBk4TLCWYNs1zBwrYtqPoOjEI9
	Avh5kyRMBBvz8KcXFJYdfdDvxE7/o0jGUrfy8XqhcHAkEcfJ/8oR9wdrr3lk76hWmy/+5vH+7uY
	zHy1rNyJgnffjT3oHic/5ZDZDaGOvS0VQpiwSZ
X-Received: by 2002:a17:90b:882:b0:29b:4755:23fc with SMTP id bj2-20020a17090b088200b0029b475523fcmr3558906pjb.33.1710474720128;
        Thu, 14 Mar 2024 20:52:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXDOuKDvuP/EqiFyBnUcJaSQVamH9YfVITPXeJDT8/OaXE+8nukfAwdydXN+5KUnq8MlXvmaNj0CipGi0ChDY=
X-Received: by 2002:a17:90b:882:b0:29b:4755:23fc with SMTP id
 bj2-20020a17090b088200b0029b475523fcmr3558876pjb.33.1710474719748; Thu, 14
 Mar 2024 20:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240312021013.88656-1-xuanzhuo@linux.alibaba.com>
 <20240312021013.88656-2-xuanzhuo@linux.alibaba.com> <CACGkMEvVgfgAxLoKeFTgy-1GR0W07ciPYFuqs6PiWtKCnXuWTw@mail.gmail.com>
 <1710395908.7915084-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1710395908.7915084-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 15 Mar 2024 11:51:48 +0800
Message-ID: <CACGkMEsT2JqJ1r_kStUzW0+-f+qT0C05n2A+Yrjpc-mHMZD_mQ@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20240314_205206_953492_E2585B2A 
X-CRM114-Status: GOOD (  27.16  )
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

On Thu, Mar 14, 2024 at 2:00=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Thu, 14 Mar 2024 11:12:24 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Tue, Mar 12, 2024 at 10:10=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alib=
aba.com> wrote:
> > >
> > > Now, we pass multi parameters to find_vqs. These parameters
> > > may work for transport or work for vring.
> > >
> > > And find_vqs has multi implements in many places:
> > >
> > >  arch/um/drivers/virtio_uml.c
> > >  drivers/platform/mellanox/mlxbf-tmfifo.c
> > >  drivers/remoteproc/remoteproc_virtio.c
> > >  drivers/s390/virtio/virtio_ccw.c
> > >  drivers/virtio/virtio_mmio.c
> > >  drivers/virtio/virtio_pci_legacy.c
> > >  drivers/virtio/virtio_pci_modern.c
> > >  drivers/virtio/virtio_vdpa.c
> > >
> > > Every time, we try to add a new parameter, that is difficult.
> > > We must change every find_vqs implement.
> > >
> > > One the other side, if we want to pass a parameter to vring,
> > > we must change the call path from transport to vring.
> > > Too many functions need to be changed.
> > >
> > > So it is time to refactor the find_vqs. We pass a structure
> > > cfg to find_vqs(), that will be passed to vring by transport.
> > >
> > > Because the vp_modern_create_avq() use the "const char *names[]",
> > > and the virtio_uml.c changes the name in the subsequent commit, so
> > > change the "names" inside the virtio_vq_config from "const char *cons=
t
> > > *names" to "const char **names".
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Acked-by: Johannes Berg <johannes@sipsolutions.net>
> > > Reviewed-by: Ilpo J=3DE4rvinen <ilpo.jarvinen@linux.intel.com>
> >
> > The name seems broken here.
>
> Email APP bug.
>
> I will fix.
>
>
> >
> > [...]
> >
> > >
> > >  typedef void vq_callback_t(struct virtqueue *);
> > >
> > > +/**
> > > + * struct virtio_vq_config - configure for find_vqs()
> > > + * @cfg_idx: Used by virtio core. The drivers should set this to 0.
> > > + *     During the initialization of each vq(vring setup), we need to=
 know which
> > > + *     item in the array should be used at that time. But since the =
item in
> > > + *     names can be null, which causes some item of array to be skip=
ped, we
> > > + *     cannot use vq.index as the current id. So add a cfg_idx to le=
t vring
> > > + *     know how to get the current configuration from the array when
> > > + *     initializing vq.
> >
> > So this design is not good. If it is not something that the driver
> > needs to care about, the core needs to hide it from the API.
>
> The driver just ignore it. That will be beneficial to the virtio core.
> Otherwise, we must pass one more parameter everywhere.

I don't get here, it's an internal logic and we've already done that.

Thanks

>
> Thanks.
>
> >
> > Thanks
> >
>


