Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB49DC27C79
	for <linux-um@archiver.kernel.org>; Thu, 20 Jun 2024 10:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Date:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5CRoRxERu4+oRXXip7PscLm7zrTgDIeqj9eXCBM0QrY=; b=aWpJ7ZfWB09QAEitbdShwIuNta
	+OofKeJN+KPcQWtNomhMDTF24Xe9AYV5ZCBd0WP3ZS1XVI+Ga7ITBg78OQ/Q6GNe/ZG97F3Sz1aJr
	wcEjXrVpQENhjFzPSEJfScK5tBD+JON6ft4rWn+6u8Y/x5Y1DR5FihIHXcPqoMYvLtyiecsk0kQ/E
	dK9FhUcwWlJ16bpgZ3MaOvPWMp+WZ5GBdFYWnqCfh/GLbV7cQsyT1B9iGr+5hORPZ9riFbiFZRcsN
	gGLOQg2UbsaaqQ/FmbrLYp4TEEdmtakBKjCqv/1PpgzPHXlZvGSiKk3y86lVR+j8TRZbWd+Ia5Gkb
	Q4F6xS7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKFKo-00000004dBm-0ag2;
	Thu, 20 Jun 2024 10:48:06 +0000
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKFKj-00000004d8T-2KsJ
	for linux-um@lists.infradead.org;
	Thu, 20 Jun 2024 10:48:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718880477; h=Message-ID:Subject:Date:From:To;
	bh=5CRoRxERu4+oRXXip7PscLm7zrTgDIeqj9eXCBM0QrY=;
	b=AdjoD4vD2xd+qROTz4VezBS98XhNmi6Mv+NKs5GVrVG0dew52AmKfybpd8BWeycKOVMO/ChF4sC5tlvblD17FvjhHyrcHD4OS9um1j4zr9xGMez+yZwB4qvc9fkQ6PHqQT9jNhTs7GnDYvD4bPi9HoqmCLbailywLdiSdmp9pYM=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=25;SR=0;TI=SMTPD_---0W8sCGbd_1718880475;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8sCGbd_1718880475)
          by smtp.aliyun-inc.com;
          Thu, 20 Jun 2024 18:47:56 +0800
Message-ID: <1718880210.0475078-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v9 3/6] virtio: find_vqs: pass struct instead of multi parameters
Date: Thu, 20 Jun 2024 18:43:30 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
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
 David Hildenbrand <david@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 linux-um@lists.infradead.org,
 platform-driver-x86@vger.kernel.org,
 linux-remoteproc@vger.kernel.org,
 linux-s390@vger.kernel.org,
 kvm@vger.kernel.org
References: <20240424091533.86949-1-xuanzhuo@linux.alibaba.com>
 <20240424091533.86949-4-xuanzhuo@linux.alibaba.com>
 <20240620034823-mutt-send-email-mst@kernel.org>
 <1718874049.457552-1-xuanzhuo@linux.alibaba.com>
 <20240620050545-mutt-send-email-mst@kernel.org>
 <1718875249.1787696-3-xuanzhuo@linux.alibaba.com>
 <20240620061202-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240620061202-mutt-send-email-mst@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240620_034802_015692_F3AC4586 
X-CRM114-Status: GOOD (  23.57  )
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

On Thu, 20 Jun 2024 06:15:08 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Thu, Jun 20, 2024 at 05:20:49PM +0800, Xuan Zhuo wrote:
> > On Thu, 20 Jun 2024 05:14:24 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > On Thu, Jun 20, 2024 at 05:00:49PM +0800, Xuan Zhuo wrote:
> > > > > > @@ -226,21 +248,37 @@ struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
> > > > > >
> > > > > >  static inline
> > > > > >  int virtio_find_vqs(struct virtio_device *vdev, unsigned nvqs,
> > > > > > -			struct virtqueue *vqs[], vq_callback_t *callbacks[],
> > > > > > -			const char * const names[],
> > > > > > -			struct irq_affinity *desc)
> > > > > > +		    struct virtqueue *vqs[], vq_callback_t *callbacks[],
> > > > > > +		    const char * const names[],
> > > > > > +		    struct irq_affinity *desc)
> > > > > >  {
> > > > > > -	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, NULL, desc);
> > > > > > +	struct virtio_vq_config cfg = {};
> > > > > > +
> > > > > > +	cfg.nvqs = nvqs;
> > > > > > +	cfg.vqs = vqs;
> > > > > > +	cfg.callbacks = callbacks;
> > > > > > +	cfg.names = (const char **)names;
> > > > >
> > > > >
> > > > > Casting const away? Not safe.
> > > >
> > > >
> > > >
> > > > Because the vp_modern_create_avq() use the "const char *names[]",
> > > > and the virtio_uml.c changes the name in the subsequent commit, so
> > > > change the "names" inside the virtio_vq_config from "const char *const
> > > > *names" to "const char **names".
> > >
> > > I'm not sure I understand which commit you mean,
> > > and this kind of change needs to be documented, but it does not matter.
> > > Don't cast away const.
> >
> >
> > Do you mean change the virtio_find_vqs(), from
> > const char * const names[] to const char *names[].
> >
> > And update the caller?
> >
> > If we do not cast the const, we need to update all the caller to remove the
> > const.
> >
> > Right?
> >
> > Thanks.
>
>
> Just do not split the patchset at a boundary that makes you do that.
> If you are passing in an array from a const section then it
> has to be const and attempts to change it are a bad idea.

Without this patch set:

static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
				     unsigned index, vq_callback_t *callback,
				     const char *name, bool ctx)
{
	struct virtio_uml_device *vu_dev = to_virtio_uml_device(vdev);
	struct platform_device *pdev = vu_dev->pdev;
	struct virtio_uml_vq_info *info;
	struct virtqueue *vq;
	int num = MAX_SUPPORTED_QUEUE_SIZE;
	int rc;

	info = kzalloc(sizeof(*info), GFP_KERNEL);
	if (!info) {
		rc = -ENOMEM;
		goto error_kzalloc;
	}
->	snprintf(info->name, sizeof(info->name), "%s.%d-%s", pdev->name,
		 pdev->id, name);

	vq = vring_create_virtqueue(index, num, PAGE_SIZE, vdev, true, true,
				    ctx, vu_notify, callback, info->name);


The name is changed by vu_setup_vq(). If we want to pass names to
virtio ring, the names must not be  "const char * const"

And the admin queue of pci do the same thing.

And I think you are right, we should not cast the const.
So we have to remove the "const" from the source.
And I checked the source code, if we remove the "const", I think
that makes sense.

Thanks.



>
>
> > >
> > > --
> > > MST
> > >
>

