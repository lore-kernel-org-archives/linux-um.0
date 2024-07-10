Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D369BC3DA41
	for <linux-um@archiver.kernel.org>; Wed, 10 Jul 2024 18:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F+jxUeQSFPMoGDRB/Tj2AzJBbVNk2aXSQNlmGiXjDjE=; b=Dugs1LnAiTOFDPnxW8fqxEjKxC
	1cWTXm60s6EJfMZrtUVwy7piVNaGd/S3aNYcc2H9pxiRx4pGsJ5/ZYLftRDdvEdJvOp07q5beQG++
	mGCP8INXPmLujCS4OvBOhhskqLnFomKwL20YZpeW7WbQmhM0us+TC+C5Qfd7vVot+BJ0LC3LPdsbq
	Jk9l+6SSSx1H3BcdlfXBEoHRcmCvZv/+ezY0eR2rBxfvW+dOaW+aN2/h4E5v3WbZugiqNL/DKyxpq
	dl3oSAOHHn7flb1sYk2U+RmSL20RZe3SDMC0Tn6uKi+vKkk17VpEQ3xuCVdQu+dEi3vFTRlNXQQ6R
	IRSRc3Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRbon-0000000BOTU-32WI;
	Wed, 10 Jul 2024 18:13:29 +0000
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRbol-0000000BOSO-1Cyo
	for linux-um@lists.infradead.org;
	Wed, 10 Jul 2024 18:13:28 +0000
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-58b5f7bf3edso24147a12.0
        for <linux-um@lists.infradead.org>; Wed, 10 Jul 2024 11:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720635204; x=1721240004; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+jxUeQSFPMoGDRB/Tj2AzJBbVNk2aXSQNlmGiXjDjE=;
        b=RzBgjLhAgcatI5YEwFuL+/DmEL/RvSoTa+XHpgLvKoZuM+j7e9fg2WORTSxgL4fV0C
         F3HbE6xXyrLiONm4W57vJrPiFBvSeY20T5qY9Re87xdf0LeodReS6sqqQNIXBVZccn7q
         QxctzHPy4+BSOSAsjP/fERHNU2bv7f8wccoAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720635204; x=1721240004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+jxUeQSFPMoGDRB/Tj2AzJBbVNk2aXSQNlmGiXjDjE=;
        b=YqBmS5IwN60YEQhfO8QjtMO/Bg0XF4T12mgFH73onyjE16ZR8GqgkInZipJoUmYXY/
         3nfLK8I/qYTNd6Vm+xQQxgWk85HpquIIMj+zHuDue3GZXCzWkdwvJGRAG6dzrmfUi95U
         mufm4PPJh8i6ScXKHVYmAnA0LqyD6BZUAAlJJ/puGCheXrqwiYkZfE1tgg8Ax/0osorX
         Ic0s/e8P5azN1VXJucWEfi6/uYl3aTwfgvqwRPm3O6QTVJOyF1Q4Wv2JQQOBu3FP3ciW
         XL3ZTZsdk7F2iASHYJ7cj6apbqPenQHyLucInTJXyguSOXlUoHRxT7LADHRWWBcnmlQ4
         u6aQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+yN6HET9xBHNsTyoFdx9Ob4lWtl7/7GKCnxqxF2ACWIgtqT9xtgm7CniOaFQ+A5CrXQePMUx530T9FHo/aamnBT1N99ZyVaZQNTQe
X-Gm-Message-State: AOJu0Ywkopx+ad4aR4kd/gzsqREmwbE85gCdUW1UFGJCG/JkNWm6iSC8
	pjrBCIaaZvMlH7VBxQ0i+PXvCqmVBDQ8nblRVHvSuj8e2TrGuUi3JXLB40e/wkE/rjDDc9Znh6H
	jaYjZ+EE=
X-Google-Smtp-Source: AGHT+IF02WQLcs1NQJQ+dXBPbfUOhebfmteRAZfID3e+CbkqLpp2ujdwMwZKuL7gGkJLqcs6nM3qng==
X-Received: by 2002:a05:6402:50c7:b0:578:638e:3683 with SMTP id 4fb4d7f45d1cf-594bab80624mr6623013a12.5.1720635204474;
        Wed, 10 Jul 2024 11:13:24 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bb9605c2sm2476909a12.13.2024.07.10.11.13.22
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 11:13:23 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a77cc44f8aaso3007066b.3
        for <linux-um@lists.infradead.org>; Wed, 10 Jul 2024 11:13:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXqAB4JuPjqV6RiGpM1OCAYFovQUH5rk/+f8l0cm9HG8i3jXdjPHQ924DoTPaTRGpbGXqLR/urWQir6RTWm4vtCXsZaq1caG8KOP2BN
X-Received: by 2002:a05:6512:281d:b0:52c:cd77:fe03 with SMTP id
 2adb3069b0e04-52eb9991dcfmr5848110e87.14.1720635181335; Wed, 10 Jul 2024
 11:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1720611677.git.mst@redhat.com> <3d655be73ce220f176b2c163839d83699f8faf43.1720611677.git.mst@redhat.com>
In-Reply-To: <3d655be73ce220f176b2c163839d83699f8faf43.1720611677.git.mst@redhat.com>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Wed, 10 Jul 2024 11:12:34 -0700
X-Gmail-Original-Message-ID: <CABVzXAnjAdQqVNtir_8SYc+2dPC-weFRxXNMBLRcmFsY8NxBhQ@mail.gmail.com>
Message-ID: <CABVzXAnjAdQqVNtir_8SYc+2dPC-weFRxXNMBLRcmFsY8NxBhQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] virtio: fix vq # for balloon
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
	Alexander Duyck <alexander.h.duyck@linux.intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	linux-um@lists.infradead.org, linux-remoteproc@vger.kernel.org, 
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240710_111327_351792_E280D65B 
X-CRM114-Status: GOOD (  22.76  )
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

On Wed, Jul 10, 2024 at 4:43=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> virtio balloon communicates to the core that in some
> configurations vq #s are non-contiguous by setting name
> pointer to NULL.
>
> Unfortunately, core then turned around and just made them
> contiguous again. Result is that driver is out of spec.

Thanks for fixing this - I think the overall approach of the patch looks go=
od.

> Implement what the API was supposed to do
> in the 1st place. Compatibility with buggy hypervisors
> is handled inside virtio-balloon, which is the only driver
> making use of this facility, so far.

In addition to virtio-balloon, I believe the same problem also affects
the virtio-fs device, since queue 1 is only supposed to be present if
VIRTIO_FS_F_NOTIFICATION is negotiated, and the request queues are
meant to be queue indexes 2 and up. From a look at the Linux driver
(virtio_fs.c), it appears like it never acks VIRTIO_FS_F_NOTIFICATION
and assumes that request queues start at index 1 rather than 2, which
looks out of spec to me, but the current device implementations (that
I am aware of, anyway) are also broken in the same way, so it ends up
working today. Queue numbering in a spec-compliant device and the
current Linux driver would mismatch; what the driver considers to be
the first request queue (index 1) would be ignored by the device since
queue index 1 has no function if F_NOTIFICATION isn't negotiated.

[...]
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_p=
ci_common.c
> index 7d82facafd75..fa606e7321ad 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -293,7 +293,7 @@ static int vp_find_vqs_msix(struct virtio_device *vde=
v, unsigned int nvqs,
>         struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
>         struct virtqueue_info *vqi;
>         u16 msix_vec;
> -       int i, err, nvectors, allocated_vectors, queue_idx =3D 0;
> +       int i, err, nvectors, allocated_vectors;
>
>         vp_dev->vqs =3D kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
>         if (!vp_dev->vqs)
> @@ -332,7 +332,7 @@ static int vp_find_vqs_msix(struct virtio_device *vde=
v, unsigned int nvqs,
>                         msix_vec =3D allocated_vectors++;
>                 else
>                         msix_vec =3D VP_MSIX_VQ_VECTOR;
> -               vqs[i] =3D vp_setup_vq(vdev, queue_idx++, vqi->callback,
> +               vqs[i] =3D vp_setup_vq(vdev, i, vqi->callback,
>                                      vqi->name, vqi->ctx, msix_vec);
>                 if (IS_ERR(vqs[i])) {
>                         err =3D PTR_ERR(vqs[i]);
> @@ -368,7 +368,7 @@ static int vp_find_vqs_intx(struct virtio_device *vde=
v, unsigned int nvqs,
>                             struct virtqueue_info vqs_info[])
>  {
>         struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
> -       int i, err, queue_idx =3D 0;
> +       int i, err;
>
>         vp_dev->vqs =3D kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
>         if (!vp_dev->vqs)
> @@ -388,8 +388,13 @@ static int vp_find_vqs_intx(struct virtio_device *vd=
ev, unsigned int nvqs,
>                         vqs[i] =3D NULL;
>                         continue;
>                 }
> +<<<<<<< HEAD
>                 vqs[i] =3D vp_setup_vq(vdev, queue_idx++, vqi->callback,
>                                      vqi->name, vqi->ctx,
> +=3D=3D=3D=3D=3D=3D=3D
> +               vqs[i] =3D vp_setup_vq(vdev, i, callbacks[i], names[i],
> +                                    ctx ? ctx[i] : false,
> +>>>>>>> f814759f80b7... virtio: fix vq # for balloon

This still has merge markers in it.

Thanks,
-- Daniel

