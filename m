Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0871BC2BA18
	for <linux-um@archiver.kernel.org>; Thu, 20 Jun 2024 11:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d0vRFjJoymfNkJ7AiCzZKbFSRm1LITjQgITc8revWNM=; b=hDuZkN9Twg28suXZTkhKICGS9Z
	HZSAl0bAFSe4eR/DWPe1cssQZOByzsdi7S+ymJlqiovB92As824NQSN0+QYnTY4zIkTMuW2gLcE/M
	6o5FSpeqU16+bzm50cC9rHCJynBnx6OOIEGMNmL+Pu0baWi13XRo2mL0l/1MjfZl52Ho8D7jQuG+Y
	A9aGvVh8+gGbtF0zAbMI+/VGg0WdnZ36EVvx/U//UI5Yj4ihRc7hHW+38Ip9yeMM/bbI1O5/Cm70r
	iyORSErL28f/WXE0zn46MaSu7h+qm1GsDAWLJUXKzteLtX7HFYB03LJ/rj081JoAiKBJkKZQ1HWzT
	LKRMFrjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKG8I-00000004p7G-0q2C;
	Thu, 20 Jun 2024 11:39:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKG8E-00000004p4M-2KZz
	for linux-um@lists.infradead.org;
	Thu, 20 Jun 2024 11:39:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718883547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d0vRFjJoymfNkJ7AiCzZKbFSRm1LITjQgITc8revWNM=;
	b=Fs8KjdKfwjzSP7BBYDPDahX+leRCUti8xPWmXuZAoClA84vqEnF6HeDEvW4emu941xwDhW
	w7Wv+cMIygFNP0aibFGPe0cX7HlHJEK4ma6kQ0xQvrdig4a++VkoqjwRBPmShr0v4sk8ST
	qhch//VX6yneuG/KtrtXiRgUoUPQbM8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-ngALE9QsM5CRvQrMcAFNCQ-1; Thu, 20 Jun 2024 07:37:42 -0400
X-MC-Unique: ngALE9QsM5CRvQrMcAFNCQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a6f4ba2ab1bso35361966b.1
        for <linux-um@lists.infradead.org>; Thu, 20 Jun 2024 04:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718883461; x=1719488261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0vRFjJoymfNkJ7AiCzZKbFSRm1LITjQgITc8revWNM=;
        b=Xi+WETEbmi14ARqkXV95+dJKGl1kacD6O+As3NhirEvd5OrUp8f/bAl193inRDtMhW
         6Oce1VdJnej7Nvab4wU4haV1OMZZOX9I9vpp3h8CIsuZNKtopY5Dgy0I7bw6RjFE2RQv
         /gBy97DCwRZW+1Ll7G9DArz06neoKyjkW5P/N09p2m8NJFfw/PvCIGtxKHgQoeTVedxy
         P8Q27L8jPZ1HFAut+m7TTM48r86IS2qghM5qT+BvLWWL9eljn+tTfxUzdTWpaoKtso0G
         7sA53pYLpe3yaVz4Vy9Tm82eOAKgNT8Dfy59mjdgXNql4g8XkVgRUjrAwQaqLZ/xxWwP
         kzrA==
X-Forwarded-Encrypted: i=1; AJvYcCUAZrbTkbnmARq/2TTqqzNt1rNwcsUuUWAJOEMP2X4gQVaL2yhdtWHF9eefY1Dd+SIx2rRQK4n4BiQ6pT91eyX+nzgeOQPJ94k+G7SA
X-Gm-Message-State: AOJu0Yy5SGUFuOcSNUdLqrX+tl/YZ3McvlALi4ZXPB/NSZgBAxbvtTW1
	OXozcBRCvP8U+CirZmTWGM5rfQGM2ZZjXAlPIAdFQzHA8G9T93XdzLR20k0HJWtAkaKttFW5M2z
	XG5lcU8Utl5HvXMPZmA7HRvxsuyDnw3cly8getUp7LGCF9T99X5qRvcrN2+C6HA==
X-Received: by 2002:a17:907:198e:b0:a68:a800:5f7e with SMTP id a640c23a62f3a-a6fab605032mr323036366b.10.1718883461409;
        Thu, 20 Jun 2024 04:37:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDIGM+jwPnAqXhfTi5j68F0TiQKYd3uIDh3xaq5X5qn943fCJOq9d8Dl2broWQ/a34GcpdjA==
X-Received: by 2002:a17:907:198e:b0:a68:a800:5f7e with SMTP id a640c23a62f3a-a6fab605032mr323032466b.10.1718883460605;
        Thu, 20 Jun 2024 04:37:40 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ecdce5sm752536366b.108.2024.06.20.04.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 04:37:39 -0700 (PDT)
Date: Thu, 20 Jun 2024 07:37:32 -0400
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
Message-ID: <20240620073111-mutt-send-email-mst@kernel.org>
References: <20240424091533.86949-1-xuanzhuo@linux.alibaba.com>
 <20240424091533.86949-4-xuanzhuo@linux.alibaba.com>
 <20240620034823-mutt-send-email-mst@kernel.org>
 <1718874049.457552-1-xuanzhuo@linux.alibaba.com>
 <20240620050545-mutt-send-email-mst@kernel.org>
 <1718875249.1787696-3-xuanzhuo@linux.alibaba.com>
 <20240620061202-mutt-send-email-mst@kernel.org>
 <1718880210.0475078-2-xuanzhuo@linux.alibaba.com>
 <20240620070354-mutt-send-email-mst@kernel.org>
 <1718881968.7394087-7-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1718881968.7394087-7-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240620_043911_179021_461EB3A9 
X-CRM114-Status: GOOD (  38.01  )
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

On Thu, Jun 20, 2024 at 07:12:48PM +0800, Xuan Zhuo wrote:
> On Thu, 20 Jun 2024 07:06:53 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Thu, Jun 20, 2024 at 06:43:30PM +0800, Xuan Zhuo wrote:
> > > On Thu, 20 Jun 2024 06:15:08 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Thu, Jun 20, 2024 at 05:20:49PM +0800, Xuan Zhuo wrote:
> > > > > On Thu, 20 Jun 2024 05:14:24 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > > On Thu, Jun 20, 2024 at 05:00:49PM +0800, Xuan Zhuo wrote:
> > > > > > > > > @@ -226,21 +248,37 @@ struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
> > > > > > > > >
> > > > > > > > >  static inline
> > > > > > > > >  int virtio_find_vqs(struct virtio_device *vdev, unsigned nvqs,
> > > > > > > > > -			struct virtqueue *vqs[], vq_callback_t *callbacks[],
> > > > > > > > > -			const char * const names[],
> > > > > > > > > -			struct irq_affinity *desc)
> > > > > > > > > +		    struct virtqueue *vqs[], vq_callback_t *callbacks[],
> > > > > > > > > +		    const char * const names[],
> > > > > > > > > +		    struct irq_affinity *desc)
> > > > > > > > >  {
> > > > > > > > > -	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, NULL, desc);
> > > > > > > > > +	struct virtio_vq_config cfg = {};
> > > > > > > > > +
> > > > > > > > > +	cfg.nvqs = nvqs;
> > > > > > > > > +	cfg.vqs = vqs;
> > > > > > > > > +	cfg.callbacks = callbacks;
> > > > > > > > > +	cfg.names = (const char **)names;
> > > > > > > >
> > > > > > > >
> > > > > > > > Casting const away? Not safe.
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > Because the vp_modern_create_avq() use the "const char *names[]",
> > > > > > > and the virtio_uml.c changes the name in the subsequent commit, so
> > > > > > > change the "names" inside the virtio_vq_config from "const char *const
> > > > > > > *names" to "const char **names".
> > > > > >
> > > > > > I'm not sure I understand which commit you mean,
> > > > > > and this kind of change needs to be documented, but it does not matter.
> > > > > > Don't cast away const.
> > > > >
> > > > >
> > > > > Do you mean change the virtio_find_vqs(), from
> > > > > const char * const names[] to const char *names[].
> > > > >
> > > > > And update the caller?
> > > > >
> > > > > If we do not cast the const, we need to update all the caller to remove the
> > > > > const.
> > > > >
> > > > > Right?
> > > > >
> > > > > Thanks.
> > > >
> > > >
> > > > Just do not split the patchset at a boundary that makes you do that.
> > > > If you are passing in an array from a const section then it
> > > > has to be const and attempts to change it are a bad idea.
> > >
> > > Without this patch set:
> > >
> > > static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
> > > 				     unsigned index, vq_callback_t *callback,
> > > 				     const char *name, bool ctx)
> > > {
> > > 	struct virtio_uml_device *vu_dev = to_virtio_uml_device(vdev);
> > > 	struct platform_device *pdev = vu_dev->pdev;
> > > 	struct virtio_uml_vq_info *info;
> > > 	struct virtqueue *vq;
> > > 	int num = MAX_SUPPORTED_QUEUE_SIZE;
> > > 	int rc;
> > >
> > > 	info = kzalloc(sizeof(*info), GFP_KERNEL);
> > > 	if (!info) {
> > > 		rc = -ENOMEM;
> > > 		goto error_kzalloc;
> > > 	}
> > > ->	snprintf(info->name, sizeof(info->name), "%s.%d-%s", pdev->name,
> > > 		 pdev->id, name);
> > >
> > > 	vq = vring_create_virtqueue(index, num, PAGE_SIZE, vdev, true, true,
> > > 				    ctx, vu_notify, callback, info->name);
> > >
> > >
> > > The name is changed by vu_setup_vq().
> > > If we want to pass names to
> > > virtio ring, the names must not be  "const char * const"
> > >
> > > And the admin queue of pci do the same thing.
> > >
> > > And I think you are right, we should not cast the const.
> > > So we have to remove the "const" from the source.
> > > And I checked the source code, if we remove the "const", I think
> > > that makes sense.
> > >
> > > Thanks.
> >
> > /facepalm
> >
> > This is a different const.
> >
> >
> > There should be no need to drop the annotation, core
> > does not change these things and using const helps make
> > sure that is the case.
> 
> 
> If you do not like this, the left only way is to allocate new
> memory to store the info, if the caller do not change.
> 
> In the further, maybe the caller can use the follow struct directly.
> 
> struct virtio_vq_config {
>  	vq_callback_t      callback;
>  	const char         *name;
>  	const bool          ctx;
> };
> 
> For now, we can allocate memory to change the arrays (names, callbacks..)
> to the array of struct virtio_vq_config.
> 
> And the find_vqs() accepts the array of struct virtio_vq_config.
> 
> How about this?
> 
> Thanks.


Basically I am not sure how bad a single big patch would be.


> >
> >
> >
> > >
> > >
> > > >
> > > >
> > > > > >
> > > > > > --
> > > > > > MST
> > > > > >
> > > >
> >


