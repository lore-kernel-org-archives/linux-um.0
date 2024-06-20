Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A9CC27C79
	for <linux-um@archiver.kernel.org>; Thu, 20 Jun 2024 09:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7n/q6GHKkD/zFmXGYbmYPlaDuYuUj7aK/70/tkj3IdI=; b=FQ26PlBWET00VfbIXsD08TNCa3
	nEIisyw7t+WFeWkO/sZYIZcDgJiyAf1meGP360pixDGaHFdOtFZkgMbTsnCWQ3nCFoX1Dj1vHlQKF
	WKGD8A6WkkKZK2G4Tz7wtYIh2GAkc1XaakFR91Wsm0jDxlqd58yZsPZJSH5xukRoNNwVO/OKOfMJ0
	4JXteKCZMB68109n/K2ew0JqO1SnnVKxpXWpL3fFOUuhAck1CUD5UnbmZyaSoVFzejQ04wsnbihsF
	ToprERXjs+bvMyaABYHj/eXPsujO3/JpX45DToZeGxKvS1ffK+2kt29j/eBhsIroqUOUnyifoPK4I
	MfakAgCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKDsM-00000004LPh-3Bwd;
	Thu, 20 Jun 2024 09:14:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKDsJ-00000004LOu-39W2
	for linux-um@lists.infradead.org;
	Thu, 20 Jun 2024 09:14:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718874874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7n/q6GHKkD/zFmXGYbmYPlaDuYuUj7aK/70/tkj3IdI=;
	b=IVnOgZNJjPSKg//Deu0Ps6yV+JdQGfCykic0ySBulqD0VZJoq44QwvaU+d7evZYHJOKKKq
	oMrW9k0A1zAWR1hcNsHm4X5zzeH6IBzEhwMg8vSiLgQvHMKuZYvdo6JjuoXtuSajw7n+ab
	39KnF3YkRDHDqhUF/Zo76nlv550/L9E=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-dau3MAuzOmOegGZAhOXgKA-1; Thu, 20 Jun 2024 05:14:32 -0400
X-MC-Unique: dau3MAuzOmOegGZAhOXgKA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a6f4af1c655so22874666b.3
        for <linux-um@lists.infradead.org>; Thu, 20 Jun 2024 02:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718874871; x=1719479671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7n/q6GHKkD/zFmXGYbmYPlaDuYuUj7aK/70/tkj3IdI=;
        b=v7F2CAr+bezAP0DU5+WYb9Yqit474/q9yBA78q5uWqwGEJKvzeZqt+2jYDKnAtY0ut
         YZ3qU2YhCHS+GVbjFmhbtAUqbV3zaiPpvdV6sJcUs/p4o6Yw/2Rxfkfa1dpixjhfx9v/
         SAM2r0ZsdzXsyIYgBCcB3fJrT1k0iEWbt6B1arjy6HpESE26vGTXt+2OK34AmL3ECaLs
         n4da/F5mytMW6T0dsyga2Ehs6e0SmsSf82VNq3w7xU3a0MEKeU7EHE50ImVgExQ3XaJe
         kbOsldVuPN9SuSUGSSOmBzmb2JefCkpWD7bsXIm/lkWIei/lgY5t7WbVu7aSwJpwoAyd
         HIUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1sSkkRPe8xjzd70Hp6/mDR9vzgqTe4kpqC6df2a9wB2mNc41S+7PaNoR5qQE9K+KMdLC8lOFOpaUvd5iBE1loQLIkh0Pd4ssRZvjm
X-Gm-Message-State: AOJu0YyC6cKrhzDnBDalwkZhL7hpESFU//mW8Gb9/tdE4fsft/7kmNZ7
	aJcrpDuk5kDMaPr9apjuGHBg4CbMHBgbesg2nBPsIkGLKeUe10uxJ1iVo0AY1jknGqAc0cVsOKa
	04PdemAhVjbAj0XdNJ24Gvj1NVWTFcMvGRhCU02EVjcxjC26fkjizzuThWNuq4w==
X-Received: by 2002:a17:907:a581:b0:a6f:af4f:ff82 with SMTP id a640c23a62f3a-a6faf500049mr334401166b.25.1718874871297;
        Thu, 20 Jun 2024 02:14:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxdf7P1AFITZr2DVkTfIKfl2IcVnjVg8p04jUd8bO23ArK3RuJSM+iwOfOkWQb1H37WeNIsA==
X-Received: by 2002:a17:907:a581:b0:a6f:af4f:ff82 with SMTP id a640c23a62f3a-a6faf500049mr334396566b.25.1718874870708;
        Thu, 20 Jun 2024 02:14:30 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56da3fe5sm759661166b.18.2024.06.20.02.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 02:14:30 -0700 (PDT)
Date: Thu, 20 Jun 2024 05:14:24 -0400
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
Subject: Re: [PATCH vhost v9 3/6] virtio: find_vqs: pass struct instead of
 multi parameters
Message-ID: <20240620050545-mutt-send-email-mst@kernel.org>
References: <20240424091533.86949-1-xuanzhuo@linux.alibaba.com>
 <20240424091533.86949-4-xuanzhuo@linux.alibaba.com>
 <20240620034823-mutt-send-email-mst@kernel.org>
 <1718874049.457552-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1718874049.457552-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240620_021435_883463_9CF3E29A 
X-CRM114-Status: GOOD (  10.71  )
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

On Thu, Jun 20, 2024 at 05:00:49PM +0800, Xuan Zhuo wrote:
> > > @@ -226,21 +248,37 @@ struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
> > >
> > >  static inline
> > >  int virtio_find_vqs(struct virtio_device *vdev, unsigned nvqs,
> > > -			struct virtqueue *vqs[], vq_callback_t *callbacks[],
> > > -			const char * const names[],
> > > -			struct irq_affinity *desc)
> > > +		    struct virtqueue *vqs[], vq_callback_t *callbacks[],
> > > +		    const char * const names[],
> > > +		    struct irq_affinity *desc)
> > >  {
> > > -	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, NULL, desc);
> > > +	struct virtio_vq_config cfg = {};
> > > +
> > > +	cfg.nvqs = nvqs;
> > > +	cfg.vqs = vqs;
> > > +	cfg.callbacks = callbacks;
> > > +	cfg.names = (const char **)names;
> >
> >
> > Casting const away? Not safe.
> 
> 
> 
> Because the vp_modern_create_avq() use the "const char *names[]",
> and the virtio_uml.c changes the name in the subsequent commit, so
> change the "names" inside the virtio_vq_config from "const char *const
> *names" to "const char **names".

I'm not sure I understand which commit you mean,
and this kind of change needs to be documented, but it does not matter.
Don't cast away const.

-- 
MST


