Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EFF8C3DA45
	for <linux-um@archiver.kernel.org>; Wed, 10 Jul 2024 11:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dantDwMOlETrf9aGxvEc7PJAx1dHcQNitKFTmPZgcf0=; b=asn4nv8W9OAa3njnRWuhCPcyii
	fgAySyImwPdQ0cYLW1AupcZn0TxLnk7vK5eETuqDPbssQkNnJQF3drhCDACVgZfWhltbULIDngfpT
	nl5oOPBOukSpSKHXW0XqRztXt9h0xdJBJ0SKaNogLOfXqqgDn/8sXQmt9RDDQoOe5p4yMGxu1/Q2u
	0i3Ru8zHpnb/3tubGUSmOegv0CC47Epf8cqu/0fmvSmerIbLppyR+didTt2hcXFQmi2U4+gg0uT8R
	fI9DoJwX+HQskMukWTOvZafN68hB1GUP0V93zTZidT8jODAiuytO/4JVeHRZ/7QWlq802YeX7nAip
	93TXitGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRVjD-0000000AOno-0VEk;
	Wed, 10 Jul 2024 11:43:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRVj9-0000000AOm7-2gyw
	for linux-um@lists.infradead.org;
	Wed, 10 Jul 2024 11:43:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720611793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dantDwMOlETrf9aGxvEc7PJAx1dHcQNitKFTmPZgcf0=;
	b=XKy73gbWx4EP1LEmrjCqFR1SZZuJ2FLgEp3koN4uu7leLQPSabWe6MVbQp935LVY/zRpoh
	BmRb8s03ZdTpjooXrLVaPlvR4tMMQ3I1v8IRwZsAPnqCmaFcynXR4LEYQ1xiYo1L2YJP5/
	cnI2wPDEIYUSFEXtZC698Hj0/xOTjLA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-9eMwtYgMO06SA78S9_B4BQ-1; Wed, 10 Jul 2024 07:43:11 -0400
X-MC-Unique: 9eMwtYgMO06SA78S9_B4BQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52e98693f43so6403958e87.3
        for <linux-um@lists.infradead.org>; Wed, 10 Jul 2024 04:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720611790; x=1721216590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dantDwMOlETrf9aGxvEc7PJAx1dHcQNitKFTmPZgcf0=;
        b=ty8nph9QsvP2go+uFzPqZykRErdKvNjNe6OoOFcbNT9zSUvFWZEThva2ElBQnPISoq
         G1xd81wqqDmfjGKK4Ba8+7VDFs4+HCMHQAUp0jq90uayulHwaTJlYqI5WBjT+iZSxwNv
         1jDlZx+1ZyM9Sg8Fgdx9o6GiKKH/MeRxQ/hW2Iu+gc9vKtq8gFpLrZFbPotsizU5yVs9
         zNj2MzsbhKuwQmrUCxTsnJYCgcuoQD2AkbFfHTgf/Rmj2Rt/ZRIS1Z3rsYcSrNtAbpkH
         daQmUtIo+tuvDndgLOWdPa2Iy/ZZCs3V45MRXLAxeUL7QgUZjEzTbttaepnoXrYFO56a
         rqfw==
X-Forwarded-Encrypted: i=1; AJvYcCX//ryzr0CYHVYWv6Y5C1J8eWDHdYA5RkwEbBwEHyPsU3QHV0t6WMCq7nzPDB95tslSvpp6NBlSwQy2cRcSIcYediJ8XHoyEkv+1SCE
X-Gm-Message-State: AOJu0YzfqX0wn+JGCTF61/cZg/+6SIOIMP9oB3DMbquFfIdJrUjMrU1k
	t3rjvs9tnEpWAOx+dmovOJj982w/m0QPBVPkYB07J2ZtbE3hZckB3/s1WCiczwJ4WsPcaWCreCX
	nXIzxCNB3zBeEktvQbkkjDtgVkKfEPxvTOI3MNGoBpamGr3kE+WRf46bZz4KABw==
X-Received: by 2002:a05:6512:3b14:b0:52c:881b:73c0 with SMTP id 2adb3069b0e04-52eb9991651mr4077101e87.17.1720611790022;
        Wed, 10 Jul 2024 04:43:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgkEXUDq3v4r1GoviXAGSNIk0Zdz6VLo68qEF34tyrv1bXKV9EaKdlhd51uHaPo0VqKgOvbQ==
X-Received: by 2002:a05:6512:3b14:b0:52c:881b:73c0 with SMTP id 2adb3069b0e04-52eb9991651mr4077074e87.17.1720611789296;
        Wed, 10 Jul 2024 04:43:09 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:f6ae:a6e3:8cbc:2cbd:b8ff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f74159csm77658215e9.42.2024.07.10.04.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 04:43:08 -0700 (PDT)
Date: Wed, 10 Jul 2024 07:42:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>,
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
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	linux-um@lists.infradead.org, linux-remoteproc@vger.kernel.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Subject: [PATCH v2 2/2] virtio: fix vq # for balloon
Message-ID: <3d655be73ce220f176b2c163839d83699f8faf43.1720611677.git.mst@redhat.com>
References: <cover.1720611677.git.mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cover.1720611677.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240710_044315_778009_775C6D37 
X-CRM114-Status: GOOD (  16.39  )
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

virtio balloon communicates to the core that in some
configurations vq #s are non-contiguous by setting name
pointer to NULL.

Unfortunately, core then turned around and just made them
contiguous again. Result is that driver is out of spec.

Implement what the API was supposed to do
in the 1st place. Compatibility with buggy hypervisors
is handled inside virtio-balloon, which is the only driver
making use of this facility, so far.

Message-ID: <cover.1720173841.git.mst@redhat.com>
Fixes: b0c504f15471 ("virtio-balloon: add support for providing free page reports to host")
Cc: "Alexander Duyck" <alexander.h.duyck@linux.intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/um/drivers/virtio_uml.c           |  4 ++--
 drivers/remoteproc/remoteproc_virtio.c |  4 ++--
 drivers/s390/virtio/virtio_ccw.c       |  4 ++--
 drivers/virtio/virtio_mmio.c           |  4 ++--
 drivers/virtio/virtio_pci_common.c     | 11 ++++++++---
 drivers/virtio/virtio_vdpa.c           |  4 ++--
 6 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 2b6e701776b6..c903e4959f51 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -1019,7 +1019,7 @@ static int vu_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 		       struct irq_affinity *desc)
 {
 	struct virtio_uml_device *vu_dev = to_virtio_uml_device(vdev);
-	int i, queue_idx = 0, rc;
+	int i, rc;
 	struct virtqueue *vq;
 
 	/* not supported for now */
@@ -1038,7 +1038,7 @@ static int vu_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 			continue;
 		}
 
-		vqs[i] = vu_setup_vq(vdev, queue_idx++, vqi->callback,
+		vqs[i] = vu_setup_vq(vdev, i, vqi->callback,
 				     vqi->name, vqi->ctx);
 		if (IS_ERR(vqs[i])) {
 			rc = PTR_ERR(vqs[i]);
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index d3f39009b28e..1019b2825c26 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -185,7 +185,7 @@ static int rproc_virtio_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 				 struct virtqueue_info vqs_info[],
 				 struct irq_affinity *desc)
 {
-	int i, ret, queue_idx = 0;
+	int i, ret;
 
 	for (i = 0; i < nvqs; ++i) {
 		struct virtqueue_info *vqi = &vqs_info[i];
@@ -195,7 +195,7 @@ static int rproc_virtio_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 			continue;
 		}
 
-		vqs[i] = rp_find_vq(vdev, queue_idx++, vqi->callback,
+		vqs[i] = rp_find_vq(vdev, i, vqi->callback,
 				    vqi->name, vqi->ctx);
 		if (IS_ERR(vqs[i])) {
 			ret = PTR_ERR(vqs[i]);
diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 62eca9419ad7..82a3440bbabb 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -694,7 +694,7 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 {
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
 	dma64_t *indicatorp = NULL;
-	int ret, i, queue_idx = 0;
+	int ret, i;
 	struct ccw1 *ccw;
 	dma32_t indicatorp_dma = 0;
 
@@ -710,7 +710,7 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 			continue;
 		}
 
-		vqs[i] = virtio_ccw_setup_vq(vdev, queue_idx++, vqi->callback,
+		vqs[i] = virtio_ccw_setup_vq(vdev, i, vqi->callback,
 					     vqi->name, vqi->ctx, ccw);
 		if (IS_ERR(vqs[i])) {
 			ret = PTR_ERR(vqs[i]);
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 90e784e7b721..db6a0366f082 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -494,7 +494,7 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
 	int irq = platform_get_irq(vm_dev->pdev, 0);
-	int i, err, queue_idx = 0;
+	int i, err;
 
 	if (irq < 0)
 		return irq;
@@ -515,7 +515,7 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 			continue;
 		}
 
-		vqs[i] = vm_setup_vq(vdev, queue_idx++, vqi->callback,
+		vqs[i] = vm_setup_vq(vdev, i, vqi->callback,
 				     vqi->name, vqi->ctx);
 		if (IS_ERR(vqs[i])) {
 			vm_del_vqs(vdev);
diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 7d82facafd75..fa606e7321ad 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -293,7 +293,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtqueue_info *vqi;
 	u16 msix_vec;
-	int i, err, nvectors, allocated_vectors, queue_idx = 0;
+	int i, err, nvectors, allocated_vectors;
 
 	vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
 	if (!vp_dev->vqs)
@@ -332,7 +332,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 			msix_vec = allocated_vectors++;
 		else
 			msix_vec = VP_MSIX_VQ_VECTOR;
-		vqs[i] = vp_setup_vq(vdev, queue_idx++, vqi->callback,
+		vqs[i] = vp_setup_vq(vdev, i, vqi->callback,
 				     vqi->name, vqi->ctx, msix_vec);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
@@ -368,7 +368,7 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
 			    struct virtqueue_info vqs_info[])
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	int i, err, queue_idx = 0;
+	int i, err;
 
 	vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
 	if (!vp_dev->vqs)
@@ -388,8 +388,13 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
 			vqs[i] = NULL;
 			continue;
 		}
+<<<<<<< HEAD
 		vqs[i] = vp_setup_vq(vdev, queue_idx++, vqi->callback,
 				     vqi->name, vqi->ctx,
+=======
+		vqs[i] = vp_setup_vq(vdev, i, callbacks[i], names[i],
+				     ctx ? ctx[i] : false,
+>>>>>>> f814759f80b7... virtio: fix vq # for balloon
 				     VIRTIO_MSI_NO_VECTOR);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 7364bd53e38d..149e893583e9 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -368,7 +368,7 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 	struct cpumask *masks;
 	struct vdpa_callback cb;
 	bool has_affinity = desc && ops->set_vq_affinity;
-	int i, err, queue_idx = 0;
+	int i, err;
 
 	if (has_affinity) {
 		masks = create_affinity_masks(nvqs, desc ? desc : &default_affd);
@@ -384,7 +384,7 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 			continue;
 		}
 
-		vqs[i] = virtio_vdpa_setup_vq(vdev, queue_idx++, vqi->callback,
+		vqs[i] = virtio_vdpa_setup_vq(vdev, i, vqi->callback,
 					      vqi->name, vqi->ctx);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
-- 
MST


