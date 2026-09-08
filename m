Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C86C79FAA
	for <linux-um@archiver.kernel.org>; Tue,  8 Sep 2026 05:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l0UrpxibHZnDBNXE1bN5qrJqc7sTw2Bd+aGpZLtd0Ug=; b=Q6jS31aFotJTJ4P24m/K3ihBTU
	WdrC1x6z9ZCjCwX/UrFOb4WoAMCF+GqoGndoLuH3XMTO+ITexq+hzrtuDkqCJsd5e1tB27gE2IMgm
	4GqGRBKG226LQbfE8oq9f4VIwjh2A6ZxYTARJQKrdDSUQrei1EEUjRleTJkZ3Cn8qfnCPKz2DmHzK
	OmUwGSxVlm4RkiiQ0YRRuPMn6bOrf0ukW3vgkdVC/EwYD6tnFg9sRAPAfQOcDbvgfq0fq2Hb20Sug
	g0d+N5FHODQe4W3+CNo4G5YjhAxcO5j/Egp/qPoq6u4qYxYfdk6d3By2D6raWiWa4uRouDtImPJHZ
	0mR2CxmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3oYj-000000085dE-46a4;
	Tue, 08 Sep 2026 05:39:53 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3oYg-000000085a5-0RqD
	for linux-um@lists.infradead.org;
	Tue, 08 Sep 2026 05:39:52 +0000
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4956869750eso37502515e9.2
        for <linux-um@lists.infradead.org>; Mon, 07 Sep 2026 22:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788845988; x=1789450788; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l0UrpxibHZnDBNXE1bN5qrJqc7sTw2Bd+aGpZLtd0Ug=;
        b=nuXUJqhnIEbTUdAN6k7T+dV4UnueU0gU0v5HXNx7bt1fjeFt4Evh7HrgdFcW07OXd4
         0J0ckwShXtP3Xu1LrwHljQfeADAH+h+UW0pn0jtpi1wEvEGyI/0KlHxITF1Ul/ZEgHlQ
         Oj1Ib1xtZpzuNdJDAbGBm7AaTEqlndd5lP1kadV32SGTDPj41Y8wt8Q2hMOX9o8R8iB9
         Kd7a05V+Dfu3yeAaRnpgpJ5LEXip6wNliStf/5/NLJEotH8RSPQL7S9IrSDFxVeJ5h3K
         IIcMJwalv1OthM7KysKt0Ry4cXuYK+V5waQtDfcPV8tdo5/7qt2Y76avpItPmXllEQzM
         P3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788845988; x=1789450788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l0UrpxibHZnDBNXE1bN5qrJqc7sTw2Bd+aGpZLtd0Ug=;
        b=ebzJoIwz4gdXr2I3sDzoXILPotcJvtxgCk0JfTVfjjlNUWvM5aDkMh3bE3udrgJyp/
         csLm9XtOjFAgmawMGPVbjiUzUCPJfib0NbBMwc5dJ4SBi/kJxMubpVuE1V1jH2rshGUq
         tiJw3EWJO6sRCm23P7AqOd6lrq720abK5O/o7uL57XEY+TI+JFv3pk7BVhlPZieFDMn1
         GPJ4/7k4OP9rmmWciWlA/Vvubp1DNvnWQuAeHLulLARkU4DkRYBEHaU1NkSg/uOyPAcE
         Kw4U5TMt3MOgQHy1WjB7juTCfxrjkOQPolDnBL2cnPZ42d1wlAJ1iBt71DHtVKduEKoK
         JjMA==
X-Forwarded-Encrypted: i=1; AKwUvBx3JuMP6KIIYUEQjNy14/JLIiUb6mUib4qDBOSOTEQjT9tqPyiknsClxqZ4vidjsLMfiE7kYlRFyw==@lists.infradead.org
X-Gm-Message-State: AFuF++nHZM4Rj7ThtlIlZJ+mseKuHkv9QtI5Rr59gIb97+tPrr6W+XOy
	pVVrlXKrqrlGtcHJw3HyHJi92Bha7LDUilVaMvS9py75IWG9/mvHKq3I
X-Gm-Gg: AYBFou1RHsXPcB7Gmllaf+p60tlljT6HvuXuBT7uRkL3EeJ2D+is8GJJ79VnzUqBKHO
	PatNWBhwd3aETC4GlgA4r9JyyIdHhLrVptobBnhihEHjJ0A5X+wlymddROWKEhgqD2TWqDJOpwu
	DmhBpfrdPTpiCtqFvbmh8TvWVs0pYk84uFRGTrI63BagBOQfdd5u5sHAfYzl/Xhma65cYD8ejrm
	HkRNFKOrsstLutrxGTQV8jpORByfuAwKP2K+PwI+Mq08tSCouef8YfQoFAyAiJ6kViekuIKuxVr
	PdnB5wcz4YHNRaYy8v17y6eAFpGG3XbTwDobowASqGmy7vZcaOxOkiMTooKDDdIPlm95GTYPCSa
	PZUs2IbR7buPyyxa2XXGO8xtjhmP2rkU6qb+81XsnCVPTsuQOwNrTYRWAQOU97XR77qI1fO0Akh
	IjpfCJpF0VxIop48gDBj5CVPoHX3Bhrw7bND/r3tbjrULL7797tMFmXbb17BrUkUcP/bNoibGI/
	eTbqAKMKA0EecxwNXPEWDlO4cUqnL/5uljPvVKSDra021FrvsjFPhp21aD2eO4Tpyyg5FUmdgho
	vpH67eLmd/XoxP5Dq7ZMeUNVSZZOtVI=
X-Received: by 2002:a05:600c:3587:b0:49d:17d8:abec with SMTP id 5b1f17b1804b1-49d17d8abf5mr31972855e9.21.1788845987998;
        Mon, 07 Sep 2026 22:39:47 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-117-170-066.95.117.pool.telefonica.de. [95.117.170.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm523841335e9.13.2026.09.07.22.39.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 22:39:47 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtualization@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-um@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v3 6/6] virtio_vdpa: implement synchronize_cbs()
Date: Tue,  8 Sep 2026 07:38:17 +0200
Message-Id: <20260908053817.26065-7-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260908053817.26065-1-kmehltretter@gmail.com>
References: <20260908053817.26065-1-kmehltretter@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260907_223951_010896_7456E097 
X-CRM114-Status: GOOD (  17.21  )
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

virtio_vdpa relies on the core's synchronize_rcu() fallback for callback
synchronization. That covers IRQ handlers and sections with interrupts,
preemption or bottom halves disabled. virtio_vdpa does not enforce any
of those contexts when a vDPA driver invokes a callback.

Add an SRCU domain per device and enter it around the virtqueue and
config callbacks. Implement synchronize_cbs() with synchronize_srcu()
so it covers the callbacks regardless of the calling context.

SRCU uses per-CPU reader accounting, avoiding a single callback lock
shared by all queues. Cover the config callback too, as virtio-pci
does for its config vector.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/virtio/virtio_vdpa.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 6bcf4567a929..f9559b6b2e0b 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -12,6 +12,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
+#include <linux/srcu.h>
 #include <linux/uuid.h>
 #include <linux/group_cpus.h>
 #include <linux/virtio.h>
@@ -27,6 +28,7 @@
 struct virtio_vdpa_device {
 	struct virtio_device vdev;
 	struct vdpa_device *vdpa;
+	struct srcu_struct cb_srcu;
 	u64 features;
 };
 
@@ -114,8 +116,11 @@ static bool virtio_vdpa_notify_with_data(struct virtqueue *vq)
 static irqreturn_t virtio_vdpa_config_cb(void *private)
 {
 	struct virtio_vdpa_device *vd_dev = private;
+	int idx;
 
+	idx = srcu_read_lock(&vd_dev->cb_srcu);
 	virtio_config_changed(&vd_dev->vdev);
+	srcu_read_unlock(&vd_dev->cb_srcu, idx);
 
 	return IRQ_HANDLED;
 }
@@ -123,8 +128,22 @@ static irqreturn_t virtio_vdpa_config_cb(void *private)
 static irqreturn_t virtio_vdpa_virtqueue_cb(void *private)
 {
 	struct virtqueue *vq = private;
+	struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vq->vdev);
+	irqreturn_t ret;
+	int idx;
+
+	idx = srcu_read_lock(&vd_dev->cb_srcu);
+	ret = vring_interrupt(0, vq);
+	srcu_read_unlock(&vd_dev->cb_srcu, idx);
+
+	return ret;
+}
+
+static void virtio_vdpa_synchronize_cbs(struct virtio_device *vdev)
+{
+	struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
 
-	return vring_interrupt(0, vq);
+	synchronize_srcu(&vd_dev->cb_srcu);
 }
 
 static struct virtqueue *
@@ -440,6 +459,7 @@ static const struct virtio_config_ops virtio_vdpa_config_ops = {
 	.reset		= virtio_vdpa_reset,
 	.find_vqs	= virtio_vdpa_find_vqs,
 	.del_vqs	= virtio_vdpa_del_vqs,
+	.synchronize_cbs = virtio_vdpa_synchronize_cbs,
 	.get_features	= virtio_vdpa_get_features,
 	.finalize_features = virtio_vdpa_finalize_features,
 	.bus_name	= virtio_vdpa_bus_name,
@@ -454,6 +474,7 @@ static void virtio_vdpa_release_dev(struct device *_d)
 	struct virtio_vdpa_device *vd_dev =
 	       container_of(vdev, struct virtio_vdpa_device, vdev);
 
+	cleanup_srcu_struct(&vd_dev->cb_srcu);
 	kfree(vd_dev);
 }
 
@@ -467,6 +488,11 @@ static int virtio_vdpa_probe(struct vdpa_device *vdpa)
 	if (!vd_dev)
 		return -ENOMEM;
 
+	if (init_srcu_struct(&vd_dev->cb_srcu)) {
+		kfree(vd_dev);
+		return -ENOMEM;
+	}
+
 	vd_dev->vdev.dev.parent = vdpa->map ? &vdpa->dev :
 				  vdpa_get_map(vdpa).dma_dev;
 	vd_dev->vdev.dev.release = virtio_vdpa_release_dev;
@@ -489,10 +515,12 @@ static int virtio_vdpa_probe(struct vdpa_device *vdpa)
 	return 0;
 
 err:
-	if (reg_dev)
+	if (reg_dev) {
 		put_device(&vd_dev->vdev.dev);
-	else
+	} else {
+		cleanup_srcu_struct(&vd_dev->cb_srcu);
 		kfree(vd_dev);
+	}
 	return ret;
 }
 
-- 
2.39.5 (Apple Git-154)

