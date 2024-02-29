Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B9BC54798
	for <linux-um@archiver.kernel.org>; Thu, 29 Feb 2024 08:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yYWjbn49/FOaKnxv8tY8E/wAWpBZLZbrgSR43I6LPzc=; b=pgHWzGcttKs/SOwBzuymrvl1JA
	1FHiNOv/Bmeut3xJjyndmuSu5lK7BDlO9zDqvpODE6cMp+Fu+u+y4wa4/I18v1ZywCq5LUli6QGGY
	HllnNqTdjk/ZIJR+t6I5HCQZRJwFz6cG2jwWK2Jnqj+nUwsHwvHaxcSTMIjsEH9q4LGorvLbAS9M2
	aV9heXXWpP5CRmn6uN+9ItWlmY2p4zn4ruejASmRFtgIAPtuPMXSVdX8wWT3klgfobhAlYXhUG9Df
	kaq4GB0U8jk/Bjdb4hQCDh4tGbPWTaqNsF34RoA4FGIh6oLy6UlZcBM0shgviKaql4P6pi3iUIMOK
	5DUABZoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfbfa-0000000Ccrg-1ons;
	Thu, 29 Feb 2024 08:21:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfbfX-0000000CcqF-3oRS
	for linux-um@lists.infradead.org;
	Thu, 29 Feb 2024 08:21:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709194890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yYWjbn49/FOaKnxv8tY8E/wAWpBZLZbrgSR43I6LPzc=;
	b=T/Zygzf3dqVjgThhvj5sxatIHDR86p07Asu/pudn/xzjxzMv/2aoi6q38U/TEDbDuWuQtx
	C0GxA7nXh0AwO8uQHYKiJQeLd9Fqv0dsYpA1orrA237nY/QcSEzkQGvO2v7UhAep0oxe0Y
	N+a0fMyv7uzfTpQ24U7uUkYHm2ICsXo=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-IFaUkFEZOwubx7fuGPby5w-1; Thu, 29 Feb 2024 03:21:25 -0500
X-MC-Unique: IFaUkFEZOwubx7fuGPby5w-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5131aa087beso404348e87.2
        for <linux-um@lists.infradead.org>; Thu, 29 Feb 2024 00:21:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709194883; x=1709799683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYWjbn49/FOaKnxv8tY8E/wAWpBZLZbrgSR43I6LPzc=;
        b=oGCL3ATj0zbGl7x7BvTjic6RP3z9LIIQPFkWkNixzxAvFlo8xNrYKgCDZVP0bJSfJT
         tUSiWFTGW1HzfCoZ/farY5mvffNm+jCy5IzCcmL3U6AWarhnVkpmii47euGpZ9tixs5o
         SXLj7W/Dhf3GcQB97FMxHeMPPvGUH3qrnd7Ztfy+EKlVeTjZZlmx2YVUq5cVmjGuH7pV
         OtYZyWuP6cqPxhlU2rEHPfpnGAh4Ys6phzpHfd7/F7JdL3gGQUMRErDvFfgE59vUtSDx
         nlQhG0BHzJ6ri1PcmbUtRNsTM8cPAD57r96dg74R6qL15C8I21GFhSNfDqoR0xNoCkpN
         K5uA==
X-Forwarded-Encrypted: i=1; AJvYcCUaKHwahdX3SEsC1giIQFvgxSfnm4GRNjTOy3w0KJpC2fJTo0FRJHo8w4TnBHRpiJ/FWDfHq8cXw1oJ3xmVU5Ia5VbFS803QcKeKJIi
X-Gm-Message-State: AOJu0YwSJBZaep0mwG6lnsoEJ4rprruJP5oYHDimoeRqtfUuGo8R8j7g
	NYLrhL/Kx86xSkvlJ/XbT5L+mhDKiKmpV9X286JlssSVmR8+2/sz4STC4U+bR6dz2NAsTGc3M88
	UxqhJh2KlFCeixJSGMl9x0ePuTjFWWWTr3bMTgVtQ8OWSmJ3jRX5u1yhz1L/5Tg==
X-Received: by 2002:a05:6512:2388:b0:513:26e7:440c with SMTP id c8-20020a056512238800b0051326e7440cmr679715lfv.61.1709194883515;
        Thu, 29 Feb 2024 00:21:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnM+zAIJHxVsYzJ0TLR9J0gKcOujhg4JzZrjGf+sjNfANqyY2DOR0YHjNv8O6HjvN3PHqhFQ==
X-Received: by 2002:a05:6512:2388:b0:513:26e7:440c with SMTP id c8-20020a056512238800b0051326e7440cmr679694lfv.61.1709194883093;
        Thu, 29 Feb 2024 00:21:23 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:d6b0:a21c:61c4:2098:5db])
        by smtp.gmail.com with ESMTPSA id bt6-20020a056000080600b0033db9383e70sm1078294wrb.81.2024.02.29.00.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 00:21:22 -0800 (PST)
Date: Thu, 29 Feb 2024 03:21:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
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
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-um@lists.infradead.org, netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH vhost v3 00/19] virtio: drivers maintain dma info for
 premapped vq
Message-ID: <20240229031755-mutt-send-email-mst@kernel.org>
References: <20240229072044.77388-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20240229072044.77388-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240229_002132_053426_DDD8DCF1 
X-CRM114-Status: GOOD (  27.33  )
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

On Thu, Feb 29, 2024 at 03:20:25PM +0800, Xuan Zhuo wrote:
> As discussed:
> http://lore.kernel.org/all/CACGkMEvq0No8QGC46U4mGsMtuD44fD_cfLcPaVmJ3rHYqRZxYg@mail.gmail.com
> 
> If the virtio is premapped mode, the driver should manage the dma info by self.
> So the virtio core should not store the dma info.
> So we can release the memory used to store the dma info.
> 
> But if the desc_extra has not dma info, we face a new question,
> it is hard to get the dma info of the desc with indirect flag.
> For split mode, that is easy from desc, but for the packed mode,
> it is hard to get the dma info from the desc. And for hardening
> the dma unmap is saft, we should store the dma info of indirect
> descs.
> 
> So I introduce the "structure the indirect desc table" to
> allocate space to store dma info with the desc table.
> 
> On the other side, we mix the descs with indirect flag
> with other descs together to share the unmap api. That
> is complex. I found if we we distinguish the descs with
> VRING_DESC_F_INDIRECT before unmap, thing will be clearer.
> 
> Because of the dma array is allocated in the find_vqs(),
> so I introduce a new parameter to find_vqs().
> 
> Note:
>     this is on the top of
>         [PATCH vhost v1] virtio: packed: fix unmap leak for indirect desc table
>         http://lore.kernel.org/all/20240223071833.26095-1-xuanzhuo@linux.alibaba.com
> 
> Please review.
> 
> Thanks
> 
> v3:
>     1. fix the conflict with the vp_modern_create_avq().

Okay but are you going to address huge memory waste all this is causing for
- people who never do zero copy
- systems where dma unmap is a nop

?

You should address all comments when you post a new version, not just
what was expedient, or alternatively tag patch as RFC and explain
in commit log that you plan to do it later.

> v2:
>     1. change the dma item of virtio-net, every item have MAX_SKB_FRAGS + 2
>         addr + len pairs.
>     2. introduce virtnet_sq_free_stats for __free_old_xmit
> 
> v1:
>     1. rename transport_vq_config to vq_transport_config
>     2. virtio-net set dma meta number to (ring-size + 1)(MAX_SKB_FRGAS +2)
>     3. introduce virtqueue_dma_map_sg_attrs
>     4. separate vring_create_virtqueue to an independent commit
> 
> 
> 
> Xuan Zhuo (19):
>   virtio_ring: introduce vring_need_unmap_buffer
>   virtio_ring: packed: remove double check of the unmap ops
>   virtio_ring: packed: structure the indirect desc table
>   virtio_ring: split: remove double check of the unmap ops
>   virtio_ring: split: structure the indirect desc table
>   virtio_ring: no store dma info when unmap is not needed
>   virtio: find_vqs: pass struct instead of multi parameters
>   virtio: vring_create_virtqueue: pass struct instead of multi
>     parameters
>   virtio: vring_new_virtqueue(): pass struct instead of multi parameters
>   virtio_ring: simplify the parameters of the funcs related to
>     vring_create/new_virtqueue()
>   virtio: find_vqs: add new parameter premapped
>   virtio_ring: export premapped to driver by struct virtqueue
>   virtio_net: set premapped mode by find_vqs()
>   virtio_ring: remove api of setting vq premapped
>   virtio_ring: introduce dma map api for page
>   virtio_ring: introduce virtqueue_dma_map_sg_attrs
>   virtio_net: unify the code for recycling the xmit ptr
>   virtio_net: rename free_old_xmit_skbs to free_old_xmit
>   virtio_net: sq support premapped mode
> 
>  arch/um/drivers/virtio_uml.c             |  31 +-
>  drivers/net/virtio_net.c                 | 283 ++++++---
>  drivers/platform/mellanox/mlxbf-tmfifo.c |  24 +-
>  drivers/remoteproc/remoteproc_virtio.c   |  31 +-
>  drivers/s390/virtio/virtio_ccw.c         |  33 +-
>  drivers/virtio/virtio_mmio.c             |  30 +-
>  drivers/virtio/virtio_pci_common.c       |  59 +-
>  drivers/virtio/virtio_pci_common.h       |   9 +-
>  drivers/virtio/virtio_pci_legacy.c       |  16 +-
>  drivers/virtio/virtio_pci_modern.c       |  38 +-
>  drivers/virtio/virtio_ring.c             | 698 ++++++++++++-----------
>  drivers/virtio/virtio_vdpa.c             |  45 +-
>  include/linux/virtio.h                   |  13 +-
>  include/linux/virtio_config.h            |  48 +-
>  include/linux/virtio_ring.h              |  82 +--
>  tools/virtio/virtio_test.c               |   4 +-
>  tools/virtio/vringh_test.c               |  28 +-
>  17 files changed, 847 insertions(+), 625 deletions(-)
> 
> --
> 2.32.0.3.g01195cf9f


