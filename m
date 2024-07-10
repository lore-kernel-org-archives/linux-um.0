Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29EF3C3DA41
	for <linux-um@archiver.kernel.org>; Wed, 10 Jul 2024 18:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4Wa91XRdvflqoUl4ERsLfqpwV8EWmy2Wo2L5wqHiP4U=; b=mRcOUkOQjaLJ9/GOriOwmfJhyp
	YLQ/8C2iyzXAK7FLCFEH5CATcq6epyFiFWM9GOKI+K1Kc+LfWieSWZRpRRuArxIVTzJeT1yYRxEWv
	ejx0D9hHq8oI6DGHeB9r5iEc6W0bvxDl+/Zdm+7tDbomseHRyAYSLjdH3z+mBim7RaW+/NKmmFq/V
	jYefXdEkPJOgB1cnmTnG2y6S9tc44B7ZGTrWQMRR+SDQuST6pQouUffo1UqIDgPSYIB4QRSSd0G+i
	JWttWtRR6/lbGZCsj795TNuo0EQat4FFLtzuKpIwxqPh1jxn5/kOZjdM0Jm4WhNiW46TP9439i+9G
	0Ggd96dA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRcE7-0000000BRKi-2F1L;
	Wed, 10 Jul 2024 18:39:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRcE4-0000000BRJP-2GfW
	for linux-um@lists.infradead.org;
	Wed, 10 Jul 2024 18:39:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720636775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Wa91XRdvflqoUl4ERsLfqpwV8EWmy2Wo2L5wqHiP4U=;
	b=FlNJV09o7oEB3u2chwRYHwojVqIaoUy3LhTKPo61VCgLt9tGEMM3HgtwLg2o4jIxQU4YJ7
	fc+G3JEap7m7KRJ0zW2z68Ms1RTPkGEd7B+m9/giAgERJ7XeBqL7RJaWGN4NP3Y/EnoWFJ
	9Z64TXYZuSvJDZdfya3Co0cI4wXjy94=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-7wmBSRHxOVyW9eZXecaKdw-1; Wed, 10 Jul 2024 14:39:34 -0400
X-MC-Unique: 7wmBSRHxOVyW9eZXecaKdw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-426620721c2so438985e9.2
        for <linux-um@lists.infradead.org>; Wed, 10 Jul 2024 11:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720636773; x=1721241573;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Wa91XRdvflqoUl4ERsLfqpwV8EWmy2Wo2L5wqHiP4U=;
        b=Xy6oF+4cRuFM0eJo90gHrt3kfIySpNecUv00Ljdy6CL6PLeC3AVFyQm+oJnW/WXFkb
         V1z5ylHH36tLyjSOkOH/vxfRZhJwHfOQoXzdwN1OJfoVVhB5A1TbWtoxYUus3D+PLs7f
         Ha/47QhMd9FONi8FP0cRue4NgR63xcOTUFnti5Y/5j6NOClCNKhizd5HeNw4hseiV0Ji
         lflUiZS6S2VRTHP6D1dzHCF3g/nzLfo0Ip6sBEKEntdnlGMCrCLeIKpFDT7nfhKbOXep
         xTtUWOeY9H3gBSrLP6orFr8vYUu0Y+4vYlFZu9ydYTsOUI1AxVT5YLtr0Kj4LLT8tIwO
         abNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAlF4fljk/MyjJ/wBl4aaqhTOEU+juItpiynuHXd39B52tor3zbIRmrjtqlKt0k86L04+nW6ebMbh4iuC/5UUzvnZNYVltdIKLF7V0
X-Gm-Message-State: AOJu0YxJ3HkFnaUu34iJ5EzRu4Ya/weKERCkdc3W4Jwg/Hza+YydZSAx
	A5o8bX+x+ssxCj89HP1ord99FEIloT+NYML5BjhmvuCVR+fLV7+3KY60eQf3I8cQrQz3mxkICX+
	zN3uHvaANka4/SilLrku11fq5QoPpFU6JxzdhUqHC92bA3Uw6cdhoh4IYNg1+7w==
X-Received: by 2002:a7b:c458:0:b0:426:64f5:b10d with SMTP id 5b1f17b1804b1-426707db59bmr38554065e9.14.1720636773020;
        Wed, 10 Jul 2024 11:39:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG74ZhHPUOEWOdKZQANHlo67lTxvcQgP6YunxBETGdCT6l5hx3iAl/9nDeoE0ZV+lKH4kLIVQ==
X-Received: by 2002:a7b:c458:0:b0:426:64f5:b10d with SMTP id 5b1f17b1804b1-426707db59bmr38553905e9.14.1720636772416;
        Wed, 10 Jul 2024 11:39:32 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:f6ae:a6e3:8cbc:2cbd:b8ff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427270238a6sm57772915e9.20.2024.07.10.11.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 11:39:31 -0700 (PDT)
Date: Wed, 10 Jul 2024 14:39:26 -0400
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
Message-ID: <20240710142239-mutt-send-email-mst@kernel.org>
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
X-CRM114-CacheID: sfid-20240710_113936_688815_7CAABE5C 
X-CRM114-Status: GOOD (  34.21  )
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


Oh, thanks a lot for pointing this out!

I see so this patch is no good as is, we need to add a workaround for
virtio-fs first.

QEMU workaround is simple - just add an extra queue. But I did not
reasearch how this would interact with vhost-user.

From driver POV, I guess we could just ignore queue # 1 - would that be
ok or does it have performance implications?
Or do what I did for balloon here: try with spec compliant #s first,
if that fails then assume it's the spec issue and shift by 1.


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


