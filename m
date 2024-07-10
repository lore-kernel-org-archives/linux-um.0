Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF3DC3DA42
	for <linux-um@archiver.kernel.org>; Wed, 10 Jul 2024 15:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BZ/UGiqczEfNWeKnxq+ScYWf6jHGQxfDprcFSlNwXPQ=; b=G8Vi5Pid+S/MADp0gMI34Y9A/n
	O2jwUgDTKv1xzt+QcyLGuukIhxFaUTVq/YBSzKLA/I5cY1fn86UEv3Wk8tHFdr96UbWWoncCy2Uj8
	qh2hv52H0dJfUFnpVZYccOt2fhUQePI4XRidzULeVJ8awGdroC8d8AYRpblVhVJoqAJ3pwwqYJcK8
	g3SMDurwt2fpBn0XLHsEmnRw3FMqI0hhGrccc+nLZohQhtAUgHsfrEgPTkw4IBR0fWeuWPHjyT0g6
	ohthvu+/uwhd+kfQ/kSXgPBgOdU02bzgGJiVVhiA2T21ddLVwlfXnsk/1YJh8LYQmzo1xs36AxZcv
	V73ME2qA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRZFW-0000000AxRE-37Jg;
	Wed, 10 Jul 2024 15:28:54 +0000
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRZFS-0000000AxQk-44Ik
	for linux-um@lists.infradead.org;
	Wed, 10 Jul 2024 15:28:52 +0000
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-52ea0f18500so6152426e87.3
        for <linux-um@lists.infradead.org>; Wed, 10 Jul 2024 08:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720625328; x=1721230128; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BZ/UGiqczEfNWeKnxq+ScYWf6jHGQxfDprcFSlNwXPQ=;
        b=NJgWAp0Gq0DVJ3RQpACl1yxvWwqyokwfV3BodATKKNYGPNgoNnU2UQ4iNs3vOhVVS/
         yIH8LBhtpY+t9nRPsvPMtcANTTQy7i4odXMkg/iFgou4WhAMx4tyhNbx52zTny3FHlhY
         +NXid/fBrIqtqpLAVO7NDyBEvCgRpQNNKksgEdwQiEgRo/v25mA8CVuRx+ClSa7F5yWr
         graGmP7fqHXvFOAhUiq4jwMzWtPcu+KW5STatrBr+acFRNR3F3+fHZ4J7Lh5ina52jnJ
         Q9kKDHFLoQkdR6nz7WZhlud9GEeIGacllmLdyiqKkALZrPZK0lJg0r8naxg3wihhW01m
         Ao/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720625328; x=1721230128;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZ/UGiqczEfNWeKnxq+ScYWf6jHGQxfDprcFSlNwXPQ=;
        b=JAmNyxhs57kt2UEjxk06UDl8+yX+t2hMfxoYucxyqF8EFzQLLHfLc/1wwtZzdJkrQI
         ON6KFP2/iopaoFs/OSDTWTm9CTLg9kyKD3T7a11FqbmnS1PnBRqK0U7xnzwwZUCKDEtP
         kY0VCpdhu2VVqC0yuLAFzjkp4x9Gm8pwCcGIFRLXdURyck8qoLIKRI5gv6Jp0dJ5BrQx
         7uPYlOvD6K5JE7qYkEDapZtcdhvm7PajCsOmAzMaDisomiOYZZ34M8MRscA7H4K6ZtqZ
         NbgL8boqQHZchPV0vm7tjN1ezPc54GEPaGgftfD2g/r2HpzKfWZLGUHz+Yo7NCiuktZF
         J1kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDCfyLdt4yv7jQdf9zlTKVV54nKew+g2ItH3k5uqHY82N4LOdbS/qWnn/0ICB8pG8z/+QHFlrT2Rworxjq+YGv0TpQfSg7hR/+yVx/
X-Gm-Message-State: AOJu0YwOQZwXd+yVJvpRlbW+WUXHs5rVoX78gBfFc4qo6fFubur1SVBi
	PH9FtI5NfUxwl4iRl/e1GPWayIt+zeCTsLZ89uY7VL2u4gzcXf5290ywmTRfccmqhAKIy6Y7iYG
	PegAk+jbLw9bM55Bft+SLnKNV6GRK/7KBkALvPA==
X-Google-Smtp-Source: AGHT+IFva/aOSUrC0d2gfrJaELKiBejlXq7juoOS4NWsej9fRXJn2qGo6TDgD4S8OrEaTK71/Fglkt59vHORRLv93uk=
X-Received: by 2002:a05:6512:1189:b0:52c:d8e9:5d8b with SMTP id
 2adb3069b0e04-52eb999446emr3966106e87.25.1720625328028; Wed, 10 Jul 2024
 08:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1720611677.git.mst@redhat.com> <3d655be73ce220f176b2c163839d83699f8faf43.1720611677.git.mst@redhat.com>
In-Reply-To: <3d655be73ce220f176b2c163839d83699f8faf43.1720611677.git.mst@redhat.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Wed, 10 Jul 2024 09:28:36 -0600
Message-ID: <CANLsYkyqhdmOWtHbNi5npOFXtMKrs7s21j+axW_4N=yQh=eHbw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] virtio: fix vq # for balloon
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
	Alexander Duyck <alexander.h.duyck@linux.intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Bjorn Andersson <andersson@kernel.org>, 
	Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
	Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	linux-um@lists.infradead.org, linux-remoteproc@vger.kernel.org, 
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240710_082851_060583_83BE367B 
X-CRM114-Status: GOOD (  23.40  )
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

On Wed, 10 Jul 2024 at 05:43, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> virtio balloon communicates to the core that in some
> configurations vq #s are non-contiguous by setting name
> pointer to NULL.
>
> Unfortunately, core then turned around and just made them
> contiguous again. Result is that driver is out of spec.
>
> Implement what the API was supposed to do
> in the 1st place. Compatibility with buggy hypervisors
> is handled inside virtio-balloon, which is the only driver
> making use of this facility, so far.
>
> Message-ID: <cover.1720173841.git.mst@redhat.com>
> Fixes: b0c504f15471 ("virtio-balloon: add support for providing free page reports to host")
> Cc: "Alexander Duyck" <alexander.h.duyck@linux.intel.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  arch/um/drivers/virtio_uml.c           |  4 ++--
>  drivers/remoteproc/remoteproc_virtio.c |  4 ++--

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  drivers/s390/virtio/virtio_ccw.c       |  4 ++--
>  drivers/virtio/virtio_mmio.c           |  4 ++--
>  drivers/virtio/virtio_pci_common.c     | 11 ++++++++---
>  drivers/virtio/virtio_vdpa.c           |  4 ++--
>  6 files changed, 18 insertions(+), 13 deletions(-)
>
> diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
> index 2b6e701776b6..c903e4959f51 100644
> --- a/arch/um/drivers/virtio_uml.c
> +++ b/arch/um/drivers/virtio_uml.c
> @@ -1019,7 +1019,7 @@ static int vu_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>                        struct irq_affinity *desc)
>  {
>         struct virtio_uml_device *vu_dev = to_virtio_uml_device(vdev);
> -       int i, queue_idx = 0, rc;
> +       int i, rc;
>         struct virtqueue *vq;
>
>         /* not supported for now */
> @@ -1038,7 +1038,7 @@ static int vu_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>                         continue;
>                 }
>
> -               vqs[i] = vu_setup_vq(vdev, queue_idx++, vqi->callback,
> +               vqs[i] = vu_setup_vq(vdev, i, vqi->callback,
>                                      vqi->name, vqi->ctx);
>                 if (IS_ERR(vqs[i])) {
>                         rc = PTR_ERR(vqs[i]);
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index d3f39009b28e..1019b2825c26 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -185,7 +185,7 @@ static int rproc_virtio_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>                                  struct virtqueue_info vqs_info[],
>                                  struct irq_affinity *desc)
>  {
> -       int i, ret, queue_idx = 0;
> +       int i, ret;
>
>         for (i = 0; i < nvqs; ++i) {
>                 struct virtqueue_info *vqi = &vqs_info[i];
> @@ -195,7 +195,7 @@ static int rproc_virtio_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>                         continue;
>                 }
>
> -               vqs[i] = rp_find_vq(vdev, queue_idx++, vqi->callback,
> +               vqs[i] = rp_find_vq(vdev, i, vqi->callback,
>                                     vqi->name, vqi->ctx);
>                 if (IS_ERR(vqs[i])) {
>                         ret = PTR_ERR(vqs[i]);
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index 62eca9419ad7..82a3440bbabb 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -694,7 +694,7 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  {
>         struct virtio_ccw_device *vcdev = to_vc_device(vdev);
>         dma64_t *indicatorp = NULL;
> -       int ret, i, queue_idx = 0;
> +       int ret, i;
>         struct ccw1 *ccw;
>         dma32_t indicatorp_dma = 0;
>
> @@ -710,7 +710,7 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>                         continue;
>                 }
>
> -               vqs[i] = virtio_ccw_setup_vq(vdev, queue_idx++, vqi->callback,
> +               vqs[i] = virtio_ccw_setup_vq(vdev, i, vqi->callback,
>                                              vqi->name, vqi->ctx, ccw);
>                 if (IS_ERR(vqs[i])) {
>                         ret = PTR_ERR(vqs[i]);
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 90e784e7b721..db6a0366f082 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -494,7 +494,7 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>  {
>         struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
>         int irq = platform_get_irq(vm_dev->pdev, 0);
> -       int i, err, queue_idx = 0;
> +       int i, err;
>
>         if (irq < 0)
>                 return irq;
> @@ -515,7 +515,7 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>                         continue;
>                 }
>
> -               vqs[i] = vm_setup_vq(vdev, queue_idx++, vqi->callback,
> +               vqs[i] = vm_setup_vq(vdev, i, vqi->callback,
>                                      vqi->name, vqi->ctx);
>                 if (IS_ERR(vqs[i])) {
>                         vm_del_vqs(vdev);
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 7d82facafd75..fa606e7321ad 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -293,7 +293,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
>         struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>         struct virtqueue_info *vqi;
>         u16 msix_vec;
> -       int i, err, nvectors, allocated_vectors, queue_idx = 0;
> +       int i, err, nvectors, allocated_vectors;
>
>         vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
>         if (!vp_dev->vqs)
> @@ -332,7 +332,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
>                         msix_vec = allocated_vectors++;
>                 else
>                         msix_vec = VP_MSIX_VQ_VECTOR;
> -               vqs[i] = vp_setup_vq(vdev, queue_idx++, vqi->callback,
> +               vqs[i] = vp_setup_vq(vdev, i, vqi->callback,
>                                      vqi->name, vqi->ctx, msix_vec);
>                 if (IS_ERR(vqs[i])) {
>                         err = PTR_ERR(vqs[i]);
> @@ -368,7 +368,7 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
>                             struct virtqueue_info vqs_info[])
>  {
>         struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> -       int i, err, queue_idx = 0;
> +       int i, err;
>
>         vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
>         if (!vp_dev->vqs)
> @@ -388,8 +388,13 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
>                         vqs[i] = NULL;
>                         continue;
>                 }
> +<<<<<<< HEAD
>                 vqs[i] = vp_setup_vq(vdev, queue_idx++, vqi->callback,
>                                      vqi->name, vqi->ctx,
> +=======
> +               vqs[i] = vp_setup_vq(vdev, i, callbacks[i], names[i],
> +                                    ctx ? ctx[i] : false,
> +>>>>>>> f814759f80b7... virtio: fix vq # for balloon
>                                      VIRTIO_MSI_NO_VECTOR);
>                 if (IS_ERR(vqs[i])) {
>                         err = PTR_ERR(vqs[i]);
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 7364bd53e38d..149e893583e9 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -368,7 +368,7 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>         struct cpumask *masks;
>         struct vdpa_callback cb;
>         bool has_affinity = desc && ops->set_vq_affinity;
> -       int i, err, queue_idx = 0;
> +       int i, err;
>
>         if (has_affinity) {
>                 masks = create_affinity_masks(nvqs, desc ? desc : &default_affd);
> @@ -384,7 +384,7 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>                         continue;
>                 }
>
> -               vqs[i] = virtio_vdpa_setup_vq(vdev, queue_idx++, vqi->callback,
> +               vqs[i] = virtio_vdpa_setup_vq(vdev, i, vqi->callback,
>                                               vqi->name, vqi->ctx);
>                 if (IS_ERR(vqs[i])) {
>                         err = PTR_ERR(vqs[i]);
> --
> MST
>

