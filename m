Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742D5C54E67
	for <linux-um@archiver.kernel.org>; Tue, 26 Mar 2024 04:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VYJdaPfqxCLnNgCpNcotB2CUqnM+IpEVFvBowNr66ZI=; b=hUYB5EVu3VnbuNzkwgPatH1SOT
	hPy1+A8fDjKDel50ku3TkNbObAgHtvLG+8uBNacgOzI769+liaH7Do1mLD3T5P5BJzr0vtK3mfFtg
	xaL/P5ZklD7BrId7q1Ijb9F7JfC3mwPslyGdsSe13ZbQFLpoiLfJfZS0P37SxovRiLz+ul2i27YRp
	p/ChJPqj5J1F7GbRWxi/BbJXW1Dlzevx2lkv8g3JGVI2OePWUXxCErNaKb5UG5VPoDfRtRNPZuXxM
	qvsDSZuBpOF4wRsHzcZBD4bfjAn8IfbHFcu8DhwYo3DMY0KvuvCzDgCjt/mXE7AhqmJD0N1rDfD7A
	l+w0rbUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1royQg-000000031yV-3IcO;
	Tue, 26 Mar 2024 04:28:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1royQe-000000031xl-0TTD
	for linux-um@lists.infradead.org;
	Tue, 26 Mar 2024 04:28:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711427330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VYJdaPfqxCLnNgCpNcotB2CUqnM+IpEVFvBowNr66ZI=;
	b=aWWffcPeoO2J8El2OytmIQt3aF3bVvnPgNdCgYCSJJstShzl9u2HR2xDhg/mGeQOxWpR3s
	49vNGeUJEwVHwWQNbOguUBmAl9UDVt1MsoO42R1915Df1LLsmKahsUCfaceaR/dquuOP+n
	99fDIuVxHma2ucYPrbkr9TvMoNNGeWc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-Nd0DXgmNPOOChcD0uS_sWg-1; Tue, 26 Mar 2024 00:28:46 -0400
X-MC-Unique: Nd0DXgmNPOOChcD0uS_sWg-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1e0c4fbaf6bso13243205ad.0
        for <linux-um@lists.infradead.org>; Mon, 25 Mar 2024 21:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711427325; x=1712032125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYJdaPfqxCLnNgCpNcotB2CUqnM+IpEVFvBowNr66ZI=;
        b=QUGNsA6amsRVK/MbIYGCYi5gFfvZlabe2E8BHIVVLw/n9ngELsHZzpwDfVSExh77oy
         mND3zWBwS/gWwGSdNNbKjT9m6/2JsJoiNoYe6nxZqWjeHseIPeefRXKMQxP6B8BujXzX
         6uCfF9JaqGRgPRXoOmogDQsTHIn9InGiN8ZDxtPZ6GylMktyUzkE8FcHRe60SzSqmdXm
         6Vy8gg6evR2gJ6qM3luazoIg/YeujD/uigKJaeEktBMJRglK0spGRKiQEnGz/w29y1v6
         e8xEQGD2nU8gPxbqRNamtcQOv+g6gyuMGb0thrpCPzlx8xXmjZIEDgOM7t9gTpYWsslv
         2gWw==
X-Forwarded-Encrypted: i=1; AJvYcCWC7EnMrO5w9fBaMd55uuJn8LiMe6C1F1KMCKI51G7Oz3EuFQPDGwznDzIIzAUfC6lFpenUuu7ojYpjAZahnaqiJA6U2MMBnuOFup7U
X-Gm-Message-State: AOJu0YynKHWzVZgcIXal7W/UiegiFSQWGNrVjuUAcGoVbvCebxGQH1po
	vq//T6QQuggCc+QSYwH3WXwlzaAvOAUQ+x1AJo/m5y8bot5lwVYEIDM66Xvz7vkDSfO+lz1DSjH
	QOlh2yNW5KivkbCDALvWiPJFogg2NdR05gjh7c8hrft5xzyfaqKU+g6P0RcSfyQzi31o2e85n6m
	1H9IKVmadZCZljMKtQjzqMHgDfIoH2lREzH2su
X-Received: by 2002:a17:902:e541:b0:1e0:f550:82e2 with SMTP id n1-20020a170902e54100b001e0f55082e2mr154441plf.22.1711427325202;
        Mon, 25 Mar 2024 21:28:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYwbHtFo5NnweY6aiIQsz8qOqVwbBb5nB1OBSL78XFdIi+hU5TswumUMNoFDqt6TH1kJ3Y6QgJCf7jKybputQ=
X-Received: by 2002:a17:902:e541:b0:1e0:f550:82e2 with SMTP id
 n1-20020a170902e54100b001e0f55082e2mr154413plf.22.1711427324953; Mon, 25 Mar
 2024 21:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240325090419.33677-1-xuanzhuo@linux.alibaba.com> <20240325090419.33677-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240325090419.33677-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Mar 2024 12:28:34 +0800
Message-ID: <CACGkMEuuNrDkEUnnES-APDVag2=4wjyZi3aEg0+8vY+Bho=BRg@mail.gmail.com>
Subject: Re: [PATCH vhost v5 2/6] virtio: remove support for names array
 entries being null.
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	David Hildenbrand <david@redhat.com>, linux-um@lists.infradead.org, 
	platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-s390@vger.kernel.org, kvm@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240325_212852_484463_9F6BA1FD 
X-CRM114-Status: GOOD (  20.61  )
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

On Mon, Mar 25, 2024 at 5:04=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> commit 6457f126c888 ("virtio: support reserved vqs") introduced this
> support. Multiqueue virtio-net use 2N as ctrl vq finally, so the logic
> doesn't apply. And not one uses this.
>
> On the other side, that makes some trouble for us to refactor the
> find_vqs() params.
>
> So I remove this support.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  arch/um/drivers/virtio_uml.c             | 5 -----
>  drivers/platform/mellanox/mlxbf-tmfifo.c | 4 ----
>  drivers/remoteproc/remoteproc_virtio.c   | 5 -----
>  drivers/s390/virtio/virtio_ccw.c         | 5 -----
>  drivers/virtio/virtio_mmio.c             | 5 -----
>  drivers/virtio/virtio_pci_common.c       | 9 ---------
>  drivers/virtio/virtio_vdpa.c             | 5 -----
>  include/linux/virtio_config.h            | 1 -
>  8 files changed, 39 deletions(-)
>
> diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
> index 8adca2000e51..1d1e8654b7fc 100644
> --- a/arch/um/drivers/virtio_uml.c
> +++ b/arch/um/drivers/virtio_uml.c
> @@ -1031,11 +1031,6 @@ static int vu_find_vqs(struct virtio_device *vdev,=
 unsigned nvqs,
>                 return rc;
>
>         for (i =3D 0; i < nvqs; ++i) {
> -               if (!names[i]) {
> -                       vqs[i] =3D NULL;
> -                       continue;
> -               }

Does this mean names[i] must not be NULL? If yes, should we fail or
not? If not, do we need to change the doc?

[...]

> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -56,7 +56,6 @@ typedef void vq_callback_t(struct virtqueue *);
>   *     callbacks: array of callbacks, for each virtqueue
>   *             include a NULL entry for vqs that do not need a callback
>   *     names: array of virtqueue names (mainly for debugging)
> - *             include a NULL entry for vqs unused by driver
>   *     Returns 0 on success or error status
>   * @del_vqs: free virtqueues found by find_vqs().
>   * @synchronize_cbs: synchronize with the virtqueue callbacks (optional)


Since we had other check for names[i] like:

        if (per_vq_vectors) {
                /* Best option: one for change interrupt, one per vq. */
                nvectors =3D 1;
                for (i =3D 0; i < nvqs; ++i)
                        if (names[i] && callbacks[i])
                                ++nvectors;

in vp_find_vqs_msix() and maybe other places.

> --
> 2.32.0.3.g01195cf9f
>


