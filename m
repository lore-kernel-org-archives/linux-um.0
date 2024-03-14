Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04442C54E58
	for <linux-um@archiver.kernel.org>; Thu, 14 Mar 2024 03:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ujVLStF8fNwjZHlFP85Jc/cq8HmkRWbLvyNFVb8jE2E=; b=RKP+gOSRQFmSJN8y6qYct6cgwv
	r6DszJ9dhgyIfu191vnzCjyPAWAJpvDJjK1rX0TBkkr81Xm6gnIOOT+pdLBSk26AQIziw0vgLvMnV
	IWrBLYEzuDlMdO5exgMIgAAk6/j9ybEK0RBmWqL8W9Szkel7535xL+zzeR9FnJj0gO1ZFaElwPKcP
	dci09AIwOUtSgjrYp+YvE74BvLbRVGZxecftFnkWy4jd6tZvwf/1pBMCaDrgdSaFd+lWw1fwqTMij
	u4EkpnqoM88HmgFjGIInQZR8iSeFgwzj33kJuVEBzR3gA+vsU5RofIuO8BON9NOJe0fR7hBo9Zt19
	Xr65KpOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkbWP-0000000CliV-2NQD;
	Thu, 14 Mar 2024 03:12:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkbWL-0000000ClhA-18kr
	for linux-um@lists.infradead.org;
	Thu, 14 Mar 2024 03:12:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710385958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ujVLStF8fNwjZHlFP85Jc/cq8HmkRWbLvyNFVb8jE2E=;
	b=KjN35+a24zDpXSCcAyy1CY5AgZV287zRJg/H26Qg+Wul8D3iJ/vAquhZihpc1wszHJykGy
	QTztO/fVtIvC3oSqp7WlYpjavbIp1OcISXCcp+40AQlqiPy4z/vrB50tOIQPVpoSynf/zV
	IGM490uDeJLP2sBci9uD0wa3zBlb2Ao=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-ytIs4ZYBMGa3GNB_6kI9Tg-1; Wed, 13 Mar 2024 23:12:36 -0400
X-MC-Unique: ytIs4ZYBMGa3GNB_6kI9Tg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-29bda2d3ea3so516790a91.3
        for <linux-um@lists.infradead.org>; Wed, 13 Mar 2024 20:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710385955; x=1710990755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujVLStF8fNwjZHlFP85Jc/cq8HmkRWbLvyNFVb8jE2E=;
        b=UFJ5rhTdErrsn5JMUL/3JjvmAr2r5/66oeeKG4HvWmFe4QOmi5h+WiCovraEec62Ft
         XRE+5rnnu0+tHIst5ka4VBVEQrj0mqomF6HVYYMppohYlucumTX8WlJ/nBUXEkroovgf
         uzoFN9UJSXzXMFk6zlM09UGvcpPKwQS8c/yDzgA2TXKOraRFh5VuxXPrWvZeop0Ln+kF
         o0hSla94Wela2sGBDJ8S/SXKEOi7gs/05NOGt5UmOsXrxGJHeQzuSNiGz1AquRkwFrW0
         8QkUHsO3bdrVZnxO0XtmbsK4Xpqy1mVZt7uze7PhSAQqRjt853EYymkTU8xaEXuVweuc
         OcHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5EQisQy10zahT0CJg/vWEYRWvt+wm+KHuDTvodVtx0QMdbyZjQQtQkZOUk0U+cjmINuJODENYdvxS+Lo2Qksi+iAghbDkreIOIIV1
X-Gm-Message-State: AOJu0YwY/28ZzLbvw2YrXKcgNb+uL791awygOhpOkWyoNBmfsTsM1AHO
	23oST5HWqJ3EV+JTW6LjE2tJx5d9MZsKjMgDyfRUh9IgMnObntsSGyDGNkNf5M2jHQslWITUYwi
	rmXnOVVTZwVa0vAD9C0Dnz7OfsiGfKGM+xmSlG/uZysqSUk3zpGNLb6rIJc2CYX3w8motR9I2Wk
	RtL2MnUAfp/J4jhlRIAHACAyn0ouyxOiTOHdHr
X-Received: by 2002:a17:90b:1115:b0:29b:dc5c:d534 with SMTP id gi21-20020a17090b111500b0029bdc5cd534mr556803pjb.29.1710385955621;
        Wed, 13 Mar 2024 20:12:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgnFIYDkamcOx1cys2VlJt8HrQE2eq5Dv8Fg1l35A9jQKw+iznC+SY6FdtZSdCDKBufcIfbsUlkHcDHjjBuKE=
X-Received: by 2002:a17:90b:1115:b0:29b:dc5c:d534 with SMTP id
 gi21-20020a17090b111500b0029bdc5cd534mr556779pjb.29.1710385955375; Wed, 13
 Mar 2024 20:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240312021013.88656-1-xuanzhuo@linux.alibaba.com> <20240312021013.88656-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240312021013.88656-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Mar 2024 11:12:24 +0800
Message-ID: <CACGkMEvVgfgAxLoKeFTgy-1GR0W07ciPYFuqs6PiWtKCnXuWTw@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20240313_201241_526758_EB198999 
X-CRM114-Status: GOOD (  19.91  )
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

On Tue, Mar 12, 2024 at 10:10=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> Now, we pass multi parameters to find_vqs. These parameters
> may work for transport or work for vring.
>
> And find_vqs has multi implements in many places:
>
>  arch/um/drivers/virtio_uml.c
>  drivers/platform/mellanox/mlxbf-tmfifo.c
>  drivers/remoteproc/remoteproc_virtio.c
>  drivers/s390/virtio/virtio_ccw.c
>  drivers/virtio/virtio_mmio.c
>  drivers/virtio/virtio_pci_legacy.c
>  drivers/virtio/virtio_pci_modern.c
>  drivers/virtio/virtio_vdpa.c
>
> Every time, we try to add a new parameter, that is difficult.
> We must change every find_vqs implement.
>
> One the other side, if we want to pass a parameter to vring,
> we must change the call path from transport to vring.
> Too many functions need to be changed.
>
> So it is time to refactor the find_vqs. We pass a structure
> cfg to find_vqs(), that will be passed to vring by transport.
>
> Because the vp_modern_create_avq() use the "const char *names[]",
> and the virtio_uml.c changes the name in the subsequent commit, so
> change the "names" inside the virtio_vq_config from "const char *const
> *names" to "const char **names".
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: Johannes Berg <johannes@sipsolutions.net>
> Reviewed-by: Ilpo J=3DE4rvinen <ilpo.jarvinen@linux.intel.com>

The name seems broken here.

[...]

>
>  typedef void vq_callback_t(struct virtqueue *);
>
> +/**
> + * struct virtio_vq_config - configure for find_vqs()
> + * @cfg_idx: Used by virtio core. The drivers should set this to 0.
> + *     During the initialization of each vq(vring setup), we need to kno=
w which
> + *     item in the array should be used at that time. But since the item=
 in
> + *     names can be null, which causes some item of array to be skipped,=
 we
> + *     cannot use vq.index as the current id. So add a cfg_idx to let vr=
ing
> + *     know how to get the current configuration from the array when
> + *     initializing vq.

So this design is not good. If it is not something that the driver
needs to care about, the core needs to hide it from the API.

Thanks


