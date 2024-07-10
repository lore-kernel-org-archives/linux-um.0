Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF577C3DA41
	for <linux-um@archiver.kernel.org>; Wed, 10 Jul 2024 18:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nOMGW3S5XfF0umS0MhtMBuBfpR4wOzwlUDWp6i5Agkc=; b=MZkHtQQjNXtT8sDzxj6Qb5tPYS
	D1kOB1+xxK0MDstzaYWyvxcgNE9PQ/PZ2bMoulATl4jJoxZfL8EChhQWwy7Bv7Ycio5rS+i70vpzv
	BPRnYtLDv09UWGnSgH7afk/KArX8VmVNzv9utoVvaL3YwlSLceBUNmJh+G+rd2H7feu1ohEouSoZq
	kZPds2yIcbVdIUkB5gcZWT6XeZ1vA1pMCBhIQoRoQhRRNeftuIQ5Hp0ZQr8Rs73nJZAxtOVt1Vf3m
	l/nD+O+PxA9PsQpdcUvBEGFrqjpvqPyyZU/7hVSlR6CS60T+RcnhwQoGG6eqHwmmXkytbeAajEaBC
	hLO8Xs8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRcF2-0000000BRWC-2nL7;
	Wed, 10 Jul 2024 18:40:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRcEz-0000000BRVl-3nY6
	for linux-um@lists.infradead.org;
	Wed, 10 Jul 2024 18:40:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720636832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nOMGW3S5XfF0umS0MhtMBuBfpR4wOzwlUDWp6i5Agkc=;
	b=DDmpwweKGQL+A3ESHK7Butp6geN7A8u4OMHGMquJPZxmExeQHwbPmrT+q9PZuFdwY7G5pG
	2ElJ71KfEHLYtBMFfMxLlcdl6wCUjdUPkclYSrf6tNt+hvlcObCflCfv/HYrVDxXB5bUAz
	ejhYxozgOfDaDHMcRZc8+bWjggtN14U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-ih9AZs_xObG-SqJYRj-FnA-1; Wed, 10 Jul 2024 14:40:31 -0400
X-MC-Unique: ih9AZs_xObG-SqJYRj-FnA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42668699453so595175e9.3
        for <linux-um@lists.infradead.org>; Wed, 10 Jul 2024 11:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720636830; x=1721241630;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nOMGW3S5XfF0umS0MhtMBuBfpR4wOzwlUDWp6i5Agkc=;
        b=E1eoO7RLxkSAvRVDs96TiXkn0ZJrpIfnrIoE8vtwgmB44CadLaYTZwMygb09E7rkyQ
         bIJWDG1KxLM1XIOWA9uvym4PLeRj63ZCG34mNB7nVA8rtheESNaZMrcM2zNWTd1gPyvx
         8b/xSxl10D5SxDaE/LpK62eLG2iWmIP9J+cDRoawwW4OkE52SweG3QsQxRU9Ss40teFr
         /iUDdewaEbpFvJaUpu+sXUaimGw56x5lFhoy8YyS1zsloyr1zJLoRMsuWSAGXapZF2Xa
         WjcUwWxb4zIQ4N9G0JoodUvqgFnyvflWgOyXUHlY0tq0QFHjfHYub+H6MgTvu6c3n/kQ
         q+Yw==
X-Forwarded-Encrypted: i=1; AJvYcCU5xnhfV0eSi1iyeINlsday3YPLe8gP5I5kcxoUw46iDowpB+3vUnQMAtXo0mankOtzingI7L6/5n60EyfNv0RBZcXetYwNTOSesMnB
X-Gm-Message-State: AOJu0YzEnpFLRpe00qTz3kpZwRGCciwYIoAGe7NjC3CD9A3pR7OrrEWa
	TLvXJSUxHfbAHomTwH1+RhpSHmYAWQQYAEVlFnhjVv7jFUMQqgL0TFWgwlN1lO5H0pgv/rWD6t+
	6Z83hFuo+iY49p9F2TkSkhnPTrM2yJtgelhqxHx5W+KbO4glZGbilNC7SVTV5rA==
X-Received: by 2002:a1c:4b0e:0:b0:426:5b76:13bd with SMTP id 5b1f17b1804b1-426708f2127mr51924395e9.38.1720636830437;
        Wed, 10 Jul 2024 11:40:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHW6BXHt7TvysChZRc5l+/HKuwpL6Ky9xwFKNWqpa0ClAMfEvn97X0Cu0s4c3ufKnu0Y+84KA==
X-Received: by 2002:a1c:4b0e:0:b0:426:5b76:13bd with SMTP id 5b1f17b1804b1-426708f2127mr51924105e9.38.1720636829731;
        Wed, 10 Jul 2024 11:40:29 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:f6ae:a6e3:8cbc:2cbd:b8ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7e039sm5973934f8f.2.2024.07.10.11.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 11:40:29 -0700 (PDT)
Date: Wed, 10 Jul 2024 14:40:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Verkamp <dverkamp@chromium.org>
Cc: linux-kernel@vger.kernel.org,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
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
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	linux-um@lists.infradead.org, linux-remoteproc@vger.kernel.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] virtio: fix vq # for balloon
Message-ID: <20240710144012-mutt-send-email-mst@kernel.org>
References: <cover.1720611677.git.mst@redhat.com>
 <3d655be73ce220f176b2c163839d83699f8faf43.1720611677.git.mst@redhat.com>
 <CABVzXAnjAdQqVNtir_8SYc+2dPC-weFRxXNMBLRcmFsY8NxBhQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABVzXAnjAdQqVNtir_8SYc+2dPC-weFRxXNMBLRcmFsY8NxBhQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240710_114034_038388_78E96917 
X-CRM114-Status: GOOD (  31.68  )
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

On Wed, Jul 10, 2024 at 11:12:34AM -0700, Daniel Verkamp wrote:
> On Wed, Jul 10, 2024 at 4:43 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > virtio balloon communicates to the core that in some
> > configurations vq #s are non-contiguous by setting name
> > pointer to NULL.
> >
> > Unfortunately, core then turned around and just made them
> > contiguous again. Result is that driver is out of spec.
> 
> Thanks for fixing this - I think the overall approach of the patch looks good.
> 
> > Implement what the API was supposed to do
> > in the 1st place. Compatibility with buggy hypervisors
> > is handled inside virtio-balloon, which is the only driver
> > making use of this facility, so far.
> 
> In addition to virtio-balloon, I believe the same problem also affects
> the virtio-fs device, since queue 1 is only supposed to be present if
> VIRTIO_FS_F_NOTIFICATION is negotiated, and the request queues are
> meant to be queue indexes 2 and up. From a look at the Linux driver
> (virtio_fs.c), it appears like it never acks VIRTIO_FS_F_NOTIFICATION
> and assumes that request queues start at index 1 rather than 2, which
> looks out of spec to me, but the current device implementations (that
> I am aware of, anyway) are also broken in the same way, so it ends up
> working today. Queue numbering in a spec-compliant device and the
> current Linux driver would mismatch; what the driver considers to be
> the first request queue (index 1) would be ignored by the device since
> queue index 1 has no function if F_NOTIFICATION isn't negotiated.
> 
> [...]
> > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > index 7d82facafd75..fa606e7321ad 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -293,7 +293,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
> >         struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> >         struct virtqueue_info *vqi;
> >         u16 msix_vec;
> > -       int i, err, nvectors, allocated_vectors, queue_idx = 0;
> > +       int i, err, nvectors, allocated_vectors;
> >
> >         vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
> >         if (!vp_dev->vqs)
> > @@ -332,7 +332,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
> >                         msix_vec = allocated_vectors++;
> >                 else
> >                         msix_vec = VP_MSIX_VQ_VECTOR;
> > -               vqs[i] = vp_setup_vq(vdev, queue_idx++, vqi->callback,
> > +               vqs[i] = vp_setup_vq(vdev, i, vqi->callback,
> >                                      vqi->name, vqi->ctx, msix_vec);
> >                 if (IS_ERR(vqs[i])) {
> >                         err = PTR_ERR(vqs[i]);
> > @@ -368,7 +368,7 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
> >                             struct virtqueue_info vqs_info[])
> >  {
> >         struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > -       int i, err, queue_idx = 0;
> > +       int i, err;
> >
> >         vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
> >         if (!vp_dev->vqs)
> > @@ -388,8 +388,13 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
> >                         vqs[i] = NULL;
> >                         continue;
> >                 }
> > +<<<<<<< HEAD
> >                 vqs[i] = vp_setup_vq(vdev, queue_idx++, vqi->callback,
> >                                      vqi->name, vqi->ctx,
> > +=======
> > +               vqs[i] = vp_setup_vq(vdev, i, callbacks[i], names[i],
> > +                                    ctx ? ctx[i] : false,
> > +>>>>>>> f814759f80b7... virtio: fix vq # for balloon
> 
> This still has merge markers in it.
> 
> Thanks,
> -- Daniel

ouch forgot to commit ;)


