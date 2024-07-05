Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D23C30658
	for <linux-um@archiver.kernel.org>; Fri,  5 Jul 2024 10:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Odn3kI68k2nJO/AKzhT19WX3OnWz2Ozg0VobWfUmy3A=; b=I8Vi3D7NC0qy1B8x20u+MzB6ei
	5G3jl10txGi2cdEmDGYmaNW0weUYo7CfMi19hdvf2vap78OBYRYtiDWbiGWmeWNAdL/gpHSLi4A2U
	rBCEPPc1Rj86U7kxtqDjRJz4j32VIE5vp/pu688TqUXWGYFlxTmDDO8pR+Lb/X74W7X1t/D6Jj0lw
	E68LN9ctz4Rm+zf2X47XqN4/IJqB/vL1GemnD35efdSq30+4IGkUsK7D0jB6x/VdDNjw6eZbCINlF
	vKfX7FoPUTfJ6ev0K1C0EmCxQfeuat/CFm185duUYvePA2XP+fvZz+Q2BEGNF0MGbTi/Tdg50n/Dc
	U/V19zmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPfsU-0000000FbNr-3Wp3;
	Fri, 05 Jul 2024 10:09:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPfsR-0000000FbLI-1OBl
	for linux-um@lists.infradead.org;
	Fri, 05 Jul 2024 10:09:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720174152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Odn3kI68k2nJO/AKzhT19WX3OnWz2Ozg0VobWfUmy3A=;
	b=BdDZ5HD0iyApu7/ZuXewiaa6jDPczxjRgUAba/STsMigGySzcIc3ZrxA5GDOz84DlB6ss3
	CRI72Kbdw34pa7Fpf2IhD0EDg6I0f6jS7cNdD0GnjC60HxZubzjbPLXA9x8ft1rTb6+wqx
	JZ6WCPFP4t2O/4qyA+TmCPcALAp5E3g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-fE-XtgznMCi-tQfPPpdqhQ-1; Fri, 05 Jul 2024 06:09:11 -0400
X-MC-Unique: fE-XtgznMCi-tQfPPpdqhQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4256c2a2e8dso11330885e9.3
        for <linux-um@lists.infradead.org>; Fri, 05 Jul 2024 03:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720174150; x=1720778950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Odn3kI68k2nJO/AKzhT19WX3OnWz2Ozg0VobWfUmy3A=;
        b=hP3VyzFGx5EtHQX7Ckodp7zoFXQoplIsRuN3hCc8pJReJ2/nV2VPBik+lYMuBxia0M
         XN41pqqDh7uxc4gXO5AKC+LTeLwO4+poLbmoJXZEaheHaO6HfW3d7BqpH+E1YyjGTq3e
         J0/RfTAUnHgigxfogbc2kZqLhbacxb5WeC41H6vYsTAV0kfbh/Q+bC6CLUX2XzQ/BIM4
         G9vM77MR5ixsdH2tXwbFylK2HdKhDY28xYo+bW8n4WjQ7xb8Myv7ffhqZTJe3015zK9s
         8w8W/KBFMsJ8GdOUn7QfKLnboZLX2G7VUHOFYeNztI+h5RUjbp15OHiZYdQUGb5nEdcl
         PLvw==
X-Forwarded-Encrypted: i=1; AJvYcCVmj73MdsMTqjDvKYXOfiv/HyTv7fG718/7QKeOJkC/afRVI6j3eDF6FuGdHWnarzHN4ubUmf++ZasEiKN5ZW3rP4lD/OHNazZSQ+AE
X-Gm-Message-State: AOJu0YwgnKa/2cvpoZwXzbgP3w6Md9O1/zhPaG5M0g665MamFltJTveL
	/4sILaVyij58UOi9T8k9hpd0ej7Sml5Vhyvhl0jT4lEus/GyQhToH4z/b0crrlhbkmfGotB/+Ha
	aaoes4UxmdvfDwWJ5zXryV4mGDXXH6klCngWD8390r4rlseOJRwNALxVKpw9TjQ==
X-Received: by 2002:a05:6000:18d1:b0:366:f001:78d5 with SMTP id ffacd0b85a97d-3679dd15831mr2701323f8f.13.1720174149720;
        Fri, 05 Jul 2024 03:09:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4wwtYRyztkbCukZKtbADwQgiOS0R3XAJxhjPsgDTBQMKf8FQrtcOZyu+TAhVhA0306KQefg==
X-Received: by 2002:a05:6000:18d1:b0:366:f001:78d5 with SMTP id ffacd0b85a97d-3679dd15831mr2701283f8f.13.1720174149018;
        Fri, 05 Jul 2024 03:09:09 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:a185:2de6:83fc:7632:9788])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3678eb6593bsm7742101f8f.93.2024.07.05.03.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:09:08 -0700 (PDT)
Date: Fri, 5 Jul 2024 06:09:01 -0400
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
Subject: [PATCH 2/2] virtio: fix vq # when vq skipped
Message-ID: <1a5d7456542bcd1df8e397c93c48deacd244add5.1720173841.git.mst@redhat.com>
References: <cover.1720173841.git.mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cover.1720173841.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240705_030915_472886_2F2FF8AF 
X-CRM114-Status: GOOD (  15.01  )
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

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/um/drivers/virtio_uml.c           | 4 ++--
 drivers/remoteproc/remoteproc_virtio.c | 4 ++--
 drivers/s390/virtio/virtio_ccw.c       | 4 ++--
 drivers/virtio/virtio_mmio.c           | 4 ++--
 drivers/virtio/virtio_pci_common.c     | 8 ++++----
 drivers/virtio/virtio_vdpa.c           | 4 ++--
 6 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 77faa2cf3a13..d65346cd340e 100644
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
@@ -1036,7 +1036,7 @@ static int vu_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 			continue;
 		}
 
-		vqs[i] = vu_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
+		vqs[i] = vu_setup_vq(vdev, i, callbacks[i], names[i],
 				     ctx ? ctx[i] : false);
 		if (IS_ERR(vqs[i])) {
 			rc = PTR_ERR(vqs[i]);
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index 25b66b113b69..2d17135abb66 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -187,7 +187,7 @@ static int rproc_virtio_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 				 const bool * ctx,
 				 struct irq_affinity *desc)
 {
-	int i, ret, queue_idx = 0;
+	int i, ret;
 
 	for (i = 0; i < nvqs; ++i) {
 		if (!names[i]) {
@@ -195,7 +195,7 @@ static int rproc_virtio_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 			continue;
 		}
 
-		vqs[i] = rp_find_vq(vdev, queue_idx++, callbacks[i], names[i],
+		vqs[i] = rp_find_vq(vdev, i, callbacks[i], names[i],
 				    ctx ? ctx[i] : false);
 		if (IS_ERR(vqs[i])) {
 			ret = PTR_ERR(vqs[i]);
diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index d6491fc84e8c..64541b3bb8a2 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -696,7 +696,7 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
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
 
-		vqs[i] = virtio_ccw_setup_vq(vdev, queue_idx++, callbacks[i],
+		vqs[i] = virtio_ccw_setup_vq(vdev, i, callbacks[i],
 					     names[i], ctx ? ctx[i] : false,
 					     ccw);
 		if (IS_ERR(vqs[i])) {
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 173596589c71..a3a66a0b7cb1 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -496,7 +496,7 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
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
 
-		vqs[i] = vm_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
+		vqs[i] = vm_setup_vq(vdev, i, callbacks[i], names[i],
 				     ctx ? ctx[i] : false);
 		if (IS_ERR(vqs[i])) {
 			vm_del_vqs(vdev);
diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index f6b0b00e4599..eeff060cacec 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -292,7 +292,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	u16 msix_vec;
-	int i, err, nvectors, allocated_vectors, queue_idx = 0;
+	int i, err, nvectors, allocated_vectors;
 
 	vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
 	if (!vp_dev->vqs)
@@ -328,7 +328,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 			msix_vec = allocated_vectors++;
 		else
 			msix_vec = VP_MSIX_VQ_VECTOR;
-		vqs[i] = vp_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
+		vqs[i] = vp_setup_vq(vdev, i, callbacks[i], names[i],
 				     ctx ? ctx[i] : false,
 				     msix_vec);
 		if (IS_ERR(vqs[i])) {
@@ -365,7 +365,7 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
 		const char * const names[], const bool *ctx)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	int i, err, queue_idx = 0;
+	int i, err;
 
 	vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
 	if (!vp_dev->vqs)
@@ -383,7 +383,7 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
 			vqs[i] = NULL;
 			continue;
 		}
-		vqs[i] = vp_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
+		vqs[i] = vp_setup_vq(vdev, i, callbacks[i], names[i],
 				     ctx ? ctx[i] : false,
 				     VIRTIO_MSI_NO_VECTOR);
 		if (IS_ERR(vqs[i])) {
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index e803db0da307..fe91a5d673dc 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -370,7 +370,7 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
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
 
-		vqs[i] = virtio_vdpa_setup_vq(vdev, queue_idx++,
+		vqs[i] = virtio_vdpa_setup_vq(vdev, i,
 					      callbacks[i], names[i], ctx ?
 					      ctx[i] : false);
 		if (IS_ERR(vqs[i])) {
-- 
MST


