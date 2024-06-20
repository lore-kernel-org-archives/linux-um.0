Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B4CC2BA1A
	for <linux-um@archiver.kernel.org>; Thu, 20 Jun 2024 11:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=asOuL0T8Du5hh5YbTvqvuUvFHIqZ4G+a72SoWSKyqQM=; b=4wiuAxm9/RxL8Ea5TEe+C15lKF
	T2NfZBTEGisjXoZL+pq8QQhD4UB3G5cal3/jKFzVTM8mLRtefvkCUbz0Q8TSpz2dGrKXqdgwZobz2
	n2c8YRoNfp1ZLRN03IEpx1h8PHXNSzJcEI6RDtI0mmwjetxOaHmvamzL3lv5NaVtxqlPtKnVal4Fd
	Sfi/hR2XOE37/fFOlMc2FaW0OxwsnyO9k1aoRwUHwlrJXBcOPv1jiQYJWFNJSyJorUNZb7SzvQPgW
	3tbYZqksUHA6I48mKsyo5yPohsCip+SyGlFok4Z0eqnlIitbib3e/Ca4YigWs6Xuo7eU/LZMgo75H
	CHIKYqIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKFdF-00000004gJT-0pLq;
	Thu, 20 Jun 2024 11:07:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKFdC-00000004gI0-1z8B
	for linux-um@lists.infradead.org;
	Thu, 20 Jun 2024 11:07:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718881625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=asOuL0T8Du5hh5YbTvqvuUvFHIqZ4G+a72SoWSKyqQM=;
	b=eehrslI6qokEvY150xKWnNx268YInHae3kYaM2T8GGuM1Lsn0bzVzFpdtJQk/qVKuP253Q
	xEkgOcjN43oAz8L2gImHGSM/Tk4YjPCNSROgtncDaILajuRSuHgWZ5AXrT3Ssttf71fTig
	W8NXRJwpfBjzVj411BgGEdaTB9DkShs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-ZTbiJkG4MHSB0aB909GlyA-1; Thu, 20 Jun 2024 07:07:02 -0400
X-MC-Unique: ZTbiJkG4MHSB0aB909GlyA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-57a49b8a27eso241377a12.0
        for <linux-um@lists.infradead.org>; Thu, 20 Jun 2024 04:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718881621; x=1719486421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asOuL0T8Du5hh5YbTvqvuUvFHIqZ4G+a72SoWSKyqQM=;
        b=tLCPZHi4HCbEhJNeZgGgv9YBEpCtjEv0AmTYfidhTYyKdVfZ5xfaGv9mYtxy2WdJYZ
         dFXs/qN3m9WxBm7gWqa+SRibJjucRf5KMN/lYYqo8/hJh9ML5z631b+IIpHH4xNnsAxG
         S6RlSSUW/6uT4XcW8G/4xkqczXz8jijISVQlq5QAYX+3D9fF8FcsZ5QdiNvPcDnsMe0B
         BO6syeKRB3iqIpCJXZdrWqD2oi+I5zEvSKl8hwB3zkQsN3hOJwKvpKvO7fntbXsk5bmP
         aH9v6tUv8ymgQD6+UkCkwdeLiavIpiKd2/wHzJu48xGwB3ktoqprVtp7EXXokUZcgDpZ
         Ds/A==
X-Forwarded-Encrypted: i=1; AJvYcCU/s3tk3CsY7JTX42GI1oj/5Mm3oAldCuseFeuHU/sKt20IFEn0HHE2+aIZSvEIZXZm/9UeDbftvueaAIyMYqdyH12snvS0lxsn0My8
X-Gm-Message-State: AOJu0YwZbDwkYOospMK22eP9912WfXhe655m2kDjkBEex0fH40iRovhA
	xtMZxqdp4UuiyHYRlSvuuSFemh7MJ6+RJvIHKpVgmCw135DxGybU9mSpH25/irVh5ZQRtN5iqbT
	x0dqpnjMsp5gXZ3AqmhDM9YW8vLYPxpRfGOzc0XrQ1tYAPEKdBOtlXlX1Yeh5xw==
X-Received: by 2002:a50:f681:0:b0:572:1589:eb98 with SMTP id 4fb4d7f45d1cf-57d07e7ad48mr2720567a12.12.1718881620763;
        Thu, 20 Jun 2024 04:07:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+O2pcBIB3xTxXGVaSg2RJcQJnlZbfDTdu2g3BCbKZScECK74GIw+9TE9o8AKC9KjzfkuaJw==
X-Received: by 2002:a50:f681:0:b0:572:1589:eb98 with SMTP id 4fb4d7f45d1cf-57d07e7ad48mr2720537a12.12.1718881620258;
        Thu, 20 Jun 2024 04:07:00 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d26a50cbbsm241731a12.63.2024.06.20.04.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 04:06:59 -0700 (PDT)
Date: Thu, 20 Jun 2024 07:06:53 -0400
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
Message-ID: <20240620070354-mutt-send-email-mst@kernel.org>
References: <20240424091533.86949-1-xuanzhuo@linux.alibaba.com>
 <20240424091533.86949-4-xuanzhuo@linux.alibaba.com>
 <20240620034823-mutt-send-email-mst@kernel.org>
 <1718874049.457552-1-xuanzhuo@linux.alibaba.com>
 <20240620050545-mutt-send-email-mst@kernel.org>
 <1718875249.1787696-3-xuanzhuo@linux.alibaba.com>
 <20240620061202-mutt-send-email-mst@kernel.org>
 <1718880210.0475078-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1718880210.0475078-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240620_040706_615177_6DAC981C 
X-CRM114-Status: GOOD (  31.77  )
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

On Thu, Jun 20, 2024 at 06:43:30PM +0800, Xuan Zhuo wrote:
> On Thu, 20 Jun 2024 06:15:08 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Thu, Jun 20, 2024 at 05:20:49PM +0800, Xuan Zhuo wrote:
> > > On Thu, 20 Jun 2024 05:14:24 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Thu, Jun 20, 2024 at 05:00:49PM +0800, Xuan Zhuo wrote:
> > > > > > > @@ -226,21 +248,37 @@ struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
> > > > > > >
> > > > > > >  static inline
> > > > > > >  int virtio_find_vqs(struct virtio_device *vdev, unsigned nvqs,
> > > > > > > -			struct virtqueue *vqs[], vq_callback_t *callbacks[],
> > > > > > > -			const char * const names[],
> > > > > > > -			struct irq_affinity *desc)
> > > > > > > +		    struct virtqueue *vqs[], vq_callback_t *callbacks[],
> > > > > > > +		    const char * const names[],
> > > > > > > +		    struct irq_affinity *desc)
> > > > > > >  {
> > > > > > > -	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, NULL, desc);
> > > > > > > +	struct virtio_vq_config cfg = {};
> > > > > > > +
> > > > > > > +	cfg.nvqs = nvqs;
> > > > > > > +	cfg.vqs = vqs;
> > > > > > > +	cfg.callbacks = callbacks;
> > > > > > > +	cfg.names = (const char **)names;
> > > > > >
> > > > > >
> > > > > > Casting const away? Not safe.
> > > > >
> > > > >
> > > > >
> > > > > Because the vp_modern_create_avq() use the "const char *names[]",
> > > > > and the virtio_uml.c changes the name in the subsequent commit, so
> > > > > change the "names" inside the virtio_vq_config from "const char *const
> > > > > *names" to "const char **names".
> > > >
> > > > I'm not sure I understand which commit you mean,
> > > > and this kind of change needs to be documented, but it does not matter.
> > > > Don't cast away const.
> > >
> > >
> > > Do you mean change the virtio_find_vqs(), from
> > > const char * const names[] to const char *names[].
> > >
> > > And update the caller?
> > >
> > > If we do not cast the const, we need to update all the caller to remove the
> > > const.
> > >
> > > Right?
> > >
> > > Thanks.
> >
> >
> > Just do not split the patchset at a boundary that makes you do that.
> > If you are passing in an array from a const section then it
> > has to be const and attempts to change it are a bad idea.
> 
> Without this patch set:
> 
> static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
> 				     unsigned index, vq_callback_t *callback,
> 				     const char *name, bool ctx)
> {
> 	struct virtio_uml_device *vu_dev = to_virtio_uml_device(vdev);
> 	struct platform_device *pdev = vu_dev->pdev;
> 	struct virtio_uml_vq_info *info;
> 	struct virtqueue *vq;
> 	int num = MAX_SUPPORTED_QUEUE_SIZE;
> 	int rc;
> 
> 	info = kzalloc(sizeof(*info), GFP_KERNEL);
> 	if (!info) {
> 		rc = -ENOMEM;
> 		goto error_kzalloc;
> 	}
> ->	snprintf(info->name, sizeof(info->name), "%s.%d-%s", pdev->name,
> 		 pdev->id, name);
> 
> 	vq = vring_create_virtqueue(index, num, PAGE_SIZE, vdev, true, true,
> 				    ctx, vu_notify, callback, info->name);
> 
> 
> The name is changed by vu_setup_vq().
> If we want to pass names to
> virtio ring, the names must not be  "const char * const"
> 
> And the admin queue of pci do the same thing.
> 
> And I think you are right, we should not cast the const.
> So we have to remove the "const" from the source.
> And I checked the source code, if we remove the "const", I think
> that makes sense.
> 
> Thanks.

/facepalm

This is a different const.


There should be no need to drop the annotation, core
does not change these things and using const helps make
sure that is the case.



> 
> 
> >
> >
> > > >
> > > > --
> > > > MST
> > > >
> >


