Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC427C2BA18
	for <linux-um@archiver.kernel.org>; Thu, 20 Jun 2024 08:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fYkcvH1qikOhnYAi1RzJNYy38ecUZaxzjAiohS4BdJU=; b=xuLwaguobv/7ExfiY0I4Su0x1S
	xedWSPnsfUvHpwcTFmHiloLYzRe4Apw5CVvG+KdPKYBROlG+batgnoMhD7qRBLCK9ChPgfbGZVRAx
	1o8fRYDmwYtyNt5e1x4qRyFEr+1lFT9/9QeTU5pXsglGBCsuXLW2M8gkDNhl2T9t74D4JclyUit8f
	GmOVbIKEqkpMQHQKYU/BDQaIvr1gi3ekdYKOuBKDDKU1bFN3wONMApBToFzn5l3jrcEQ0hZ+yoshF
	SrQBml4mAjIqV71/ojAJ8MHSzXwNZKh+5T/9gclFng268ZbFAcXbxasuaMHefINAazX+cS3+FezxC
	9/YKoXzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKCqM-000000045j8-3h3d;
	Thu, 20 Jun 2024 08:08:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKCqK-000000045id-2sbr
	for linux-um@lists.infradead.org;
	Thu, 20 Jun 2024 08:08:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718870907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fYkcvH1qikOhnYAi1RzJNYy38ecUZaxzjAiohS4BdJU=;
	b=bF2P88s4SX3EaUwaeIwnArorSHARc3SzTla3IYss7j/qpYCU6LkXZBlS0zfg3IEcFxyo/2
	gtEsz+XWgkR2Ype+hZrBExturpTSxIKm6JHPGWpRP6V3YGCG058JwbtFWkkJELZyChz0Of
	4ckXhx6+JQ30wt2EWW6f1jtH9j785Sc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-5tRYAopyPQWvLSs2SEeGyA-1; Thu, 20 Jun 2024 04:08:25 -0400
X-MC-Unique: 5tRYAopyPQWvLSs2SEeGyA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-57a306c4b1eso375693a12.0
        for <linux-um@lists.infradead.org>; Thu, 20 Jun 2024 01:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718870904; x=1719475704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYkcvH1qikOhnYAi1RzJNYy38ecUZaxzjAiohS4BdJU=;
        b=EIWnWxV6uspqhPV7OTcSQyzU4DZWGdApNY2ztvnVIFQhcx/2zVlkOoMG6TnALCUwMF
         mwLAEi4SWkLMwkg5Z6f7BW/EIPKUHbjXsTcogxzpmCve/Dp1hmmUoj90sLofRm1q6Kpm
         vEtuEBjFGsMicCxrfwo6r5/PE4jYl8BEd1ZEWWovqMYb2So6rtZgGyP6nmXQXo+ZhJL+
         t/+8B9mkDFsaD47YXtT7EeSL99A726D8s4YO6rZazM929b2+KZZ2JuxpzjoKdw0gmBim
         OfoO/csdvuKpOeLuV8Yo0xKYJuLz/vpUlmS+Rr/UHjqZanJudfuOmxzOmXsObJKjKGJq
         CD1w==
X-Forwarded-Encrypted: i=1; AJvYcCVT9i3EvYvEkTo+MZcozR2JxjCclJ/qlCFx6X8RKtOfZKEShvXuAifYMs5VpQdSAyNxa8ucAe/N5jz2DHHl3ro9iDbBp0kihmf1nTtR
X-Gm-Message-State: AOJu0YxVKPtyAX5qoRgQEe5Fp8LwbPA38WQWQjBZahJAtS4R9WUdKKFj
	mHHkenv9AFYUSNBwxIpodNrgxAjzdtZMbl1Fq7wklSW0bw2Lq6J4E9SqZtb6n0wq2GUTVlbFm1u
	m+CQBBrRIETPsJB4kM8CelWmVw6GRGbwusgzvdXMtrHhWB+EI1p9LcTCSU4P2gA==
X-Received: by 2002:a50:ab18:0:b0:57d:12c3:eca6 with SMTP id 4fb4d7f45d1cf-57d12c3ed79mr2054082a12.18.1718870903886;
        Thu, 20 Jun 2024 01:08:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElyy2gCyt3ovTk4v5Gf3L+EBBsQDxCvTGnZmU0yxgu5HjKvNiZ0eDBqsa0yCdr2XWpOKzZ1g==
X-Received: by 2002:a50:ab18:0:b0:57d:12c3:eca6 with SMTP id 4fb4d7f45d1cf-57d12c3ed79mr2054031a12.18.1718870902978;
        Thu, 20 Jun 2024 01:08:22 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cd24df611sm5962871a12.16.2024.06.20.01.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 01:08:22 -0700 (PDT)
Date: Thu, 20 Jun 2024 04:08:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
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
	David Hildenbrand <david@redhat.com>,
	Jason Wang <jasowang@redhat.com>, linux-um@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH vhost v9 1/6] virtio_balloon: remove the dependence where
 names[] is null
Message-ID: <20240620040415-mutt-send-email-mst@kernel.org>
References: <20240424091533.86949-1-xuanzhuo@linux.alibaba.com>
 <20240424091533.86949-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20240424091533.86949-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240620_010828_829601_809D7D0A 
X-CRM114-Status: GOOD (  27.51  )
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

On Wed, Apr 24, 2024 at 05:15:28PM +0800, Xuan Zhuo wrote:
> Currently, the init_vqs function within the virtio_balloon driver relies
> on the condition that certain names array entries are null in order to
> skip the initialization of some virtual queues (vqs). This behavior is
> unique to this part of the codebase. In an upcoming commit, we plan to
> eliminate this dependency by removing the function entirely. Therefore,
> with this change, we are ensuring that the virtio_balloon no longer
> depends on the aforementioned function.
> 
> As specification 1.0-1.2, vq indexes should not be contiguous if some
> vq does not exist. But currently the virtqueue index is contiguous for
> all existing devices. The Linux kernel does not implement functionality
> to allow vq indexes to be discontinuous. So the current behavior of the
> virtio-balloon device is different for the spec. But this commit has no
> functional changes.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Jason Wang <jasowang@redhat.com>

I can't make heads of tails of this.

David you acked so maybe you can help rewrite the commit log here?

I don't understand what this says.
What in the balloon driver is out of spec?
NULL in names *exactly* allows skipping init for some vqs.
How is that "does not implement"?

And so on.


> ---
>  drivers/virtio/virtio_balloon.c | 48 ++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index c0a63638f95e..ccda6d08493f 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -548,49 +548,41 @@ static int init_vqs(struct virtio_balloon *vb)
>  	struct virtqueue *vqs[VIRTIO_BALLOON_VQ_MAX];
>  	vq_callback_t *callbacks[VIRTIO_BALLOON_VQ_MAX];
>  	const char *names[VIRTIO_BALLOON_VQ_MAX];
> -	int err;
> +	int err, idx = 0;
>  
> -	/*
> -	 * Inflateq and deflateq are used unconditionally. The names[]
> -	 * will be NULL if the related feature is not enabled, which will
> -	 * cause no allocation for the corresponding virtqueue in find_vqs.
> -	 */
> -	callbacks[VIRTIO_BALLOON_VQ_INFLATE] = balloon_ack;
> -	names[VIRTIO_BALLOON_VQ_INFLATE] = "inflate";
> -	callbacks[VIRTIO_BALLOON_VQ_DEFLATE] = balloon_ack;
> -	names[VIRTIO_BALLOON_VQ_DEFLATE] = "deflate";
> -	callbacks[VIRTIO_BALLOON_VQ_STATS] = NULL;
> -	names[VIRTIO_BALLOON_VQ_STATS] = NULL;
> -	callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
> -	names[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
> -	names[VIRTIO_BALLOON_VQ_REPORTING] = NULL;
> +	callbacks[idx] = balloon_ack;
> +	names[idx++] = "inflate";
> +	callbacks[idx] = balloon_ack;
> +	names[idx++] = "deflate";
>  
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
> -		names[VIRTIO_BALLOON_VQ_STATS] = "stats";
> -		callbacks[VIRTIO_BALLOON_VQ_STATS] = stats_request;
> +		names[idx] = "stats";
> +		callbacks[idx++] = stats_request;
>  	}
>  
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
> -		names[VIRTIO_BALLOON_VQ_FREE_PAGE] = "free_page_vq";
> -		callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
> +		names[idx] = "free_page_vq";
> +		callbacks[idx++] = NULL;
>  	}
>  
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
> -		names[VIRTIO_BALLOON_VQ_REPORTING] = "reporting_vq";
> -		callbacks[VIRTIO_BALLOON_VQ_REPORTING] = balloon_ack;
> +		names[idx] = "reporting_vq";
> +		callbacks[idx++] = balloon_ack;
>  	}
>  
> -	err = virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
> -			      callbacks, names, NULL);
> +	err = virtio_find_vqs(vb->vdev, idx, vqs, callbacks, names, NULL);
>  	if (err)
>  		return err;
>  
> -	vb->inflate_vq = vqs[VIRTIO_BALLOON_VQ_INFLATE];
> -	vb->deflate_vq = vqs[VIRTIO_BALLOON_VQ_DEFLATE];
> +	idx = 0;
> +
> +	vb->inflate_vq = vqs[idx++];
> +	vb->deflate_vq = vqs[idx++];
> +
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
>  		struct scatterlist sg;
>  		unsigned int num_stats;
> -		vb->stats_vq = vqs[VIRTIO_BALLOON_VQ_STATS];
> +		vb->stats_vq = vqs[idx++];
>  
>  		/*
>  		 * Prime this virtqueue with one buffer so the hypervisor can
> @@ -610,10 +602,10 @@ static int init_vqs(struct virtio_balloon *vb)
>  	}
>  
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
> -		vb->free_page_vq = vqs[VIRTIO_BALLOON_VQ_FREE_PAGE];
> +		vb->free_page_vq = vqs[idx++];
>  
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
> -		vb->reporting_vq = vqs[VIRTIO_BALLOON_VQ_REPORTING];
> +		vb->reporting_vq = vqs[idx++];
>  
>  	return 0;
>  }
> -- 
> 2.32.0.3.g01195cf9f


