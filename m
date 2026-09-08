Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284C7C79FAB
	for <linux-um@archiver.kernel.org>; Tue,  8 Sep 2026 05:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PyvGIpKH+MV7CFSZeFmHniXCtrADstZbtULW+SJuxFg=; b=tD2nECObgK792x7lY8S5OGwcJB
	ZRNebrIwKF9qbwM0Qj5pUqvy8fxXh1M7B0OtiNRyFjiclqWaftPoUtSOHKNNeB2ac+GSB3agoPkru
	WhAhG3NlC7tmVuq+am+g6uFQmmbICUqyNK8HPEKaNd0RD876ZgTfG9dwN9b9if6w3Om96OvA2Iyi8
	0TRtj+MLezN8nvuda6i+q2Q2Ek2EQ8cVxUx66cHTj+LI2wiCE8s+jlSeGCDcPyy1rebQlY+R2gg1a
	USAY2hxOxt8Mwzvj7rBcIA53y54fskPjW6tjPwIDsKRoM+/f67YbtFnplirFzd706TryBU5aQOp31
	mTPIGyMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3oYe-000000085a6-3V02;
	Tue, 08 Sep 2026 05:39:48 +0000
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3oYc-000000085Wn-2DjI
	for linux-um@lists.infradead.org;
	Tue, 08 Sep 2026 05:39:47 +0000
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-495590dde14so59962275e9.0
        for <linux-um@lists.infradead.org>; Mon, 07 Sep 2026 22:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788845985; x=1789450785; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PyvGIpKH+MV7CFSZeFmHniXCtrADstZbtULW+SJuxFg=;
        b=ldfFYszzoDa/okN5JXAFZN+wNHZ7656e9eT3QkSlhXztAzAIl899EmJKDtXWp6ZbG1
         WakRi3ep02/2WtE+zxHM7vBY/PqLPcDx+JRiQPiTiYglkLD85BEwNFKanTwTPJKAWQAZ
         7TL6XZjrnEV4q/y9xbva8q48V+DFBy9jklgNhXboPjkIp+8Va0eg8/MXfmAezWi2CsYc
         K0A12c6rcc7EXj9S/3ca+/IgfArloBv7HgvMFVmurNkg4EUrKWUzMyQM6WDKB+7RYWxm
         VH6MvoJo2/2zc+w4wDTbpNIcAdCkhY8upCGi2IxLOXwWCobzYzR1+00tG1LNMwMWb3Bu
         Audg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788845985; x=1789450785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PyvGIpKH+MV7CFSZeFmHniXCtrADstZbtULW+SJuxFg=;
        b=kpC6E3hyAEsWNJRbivY84d3FzoNWSvuiYr369H9+4GR/B55gOfI0PJTp7fr2mgvjF0
         nZCltkk8iacHQ4XW32SyMW2Cz40BC2WQCQ28LQuE62Do6CPWdPSSdCrK4NKh3U/gKfLj
         jeNSKJIhS9hXw1RMOjyTgTtLsZOWhgRC7HgfE0ezsDmRSgR9UvYCNGa4+C/oGWNMUlI3
         ydOTY3EyfUGfBF8FwjNezhnPrC/fvUdD3N1zD2uGdbXV4gtauKj5srcFYmv6d8mDJz+P
         fsZBy0n+u3KQsVlBzhfzRdw/B6r4AJvnNP1RjFhhX5o7c4vSEF3z7yRaQil6mAUNvllm
         uhNw==
X-Forwarded-Encrypted: i=1; AKwUvByi4hwlUHWZbFCpXhisaIX6snjudKjDpdpqffuNm/tZ/ujX2100h6ckGI7GSQYjgAGc5kt57R+92Q==@lists.infradead.org
X-Gm-Message-State: AFuF++nrUknm1b5pazU6jkMefPultbz31KIl5ZL57tzqWL4fu8O/IeQy
	mZjTkZlG0lTyvTS7FQiiyjS5E6xgYAPSLxMl2u6tt4v3iiFNU2ZBxbO/
X-Gm-Gg: AYBFou0YOUqiesCZZSm4wV0iiukOCBxxoYyhK4mcu88GlBt3GFKzhw0mXFg3t/434qT
	tHE91WjF+5Ytq++JqXgmN+uaIHnFLLUhVs+Lv2Uf2o7g+0qe5ZhqlY30y6fDXogFxahq2XcK/ic
	9tAZa6+5S9VYezNeVL6N8oLp2+nRYuim3MDYrvSWqsPmHV0JMMTDz5lk+abh6rGf8pZQl0KyWgo
	qjhtc9oOwaczPMQw+iOnNWmi4Gdw8Jo5vzZC4wrlE6l6TjKzk5NP1TtrR5x4ObSBKsKz8pwAUlC
	MebiipDZ26WMtZd7djuw2f+8hMO1DNRH1qSVoPG7y52kdgoUQARrZhmyML2GZEkDrL3pUSs7Yuq
	Z0UJmYh2oNnwLzazwyynyDkoeiKJtqmxh2Mb9txqg5PHHB4rQRfPZv1tGn3msUoNCSFl5dQIUqe
	+HxIah1DbLovclapyzDiUbQ4AFB2Pux4U8LWDx/3Ko1gmR2sCA1S6sGvvYad1DkmCdHEvqHpppz
	QIWCjTFu1/4fRCWfNqSpVfBDc6XuB1raGJxD7cVoAsuu8MtlhN+js8iMNv0z5QD3FmUy5mloAO4
	gC6QpOpQDSneCwoES+/ojFFW6aMpwA4=
X-Received: by 2002:a05:600c:a0a:b0:49c:e1f1:3dd5 with SMTP id 5b1f17b1804b1-49cf81e6cebmr470253545e9.4.1788845984552;
        Mon, 07 Sep 2026 22:39:44 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-117-170-066.95.117.pool.telefonica.de. [95.117.170.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm523841335e9.13.2026.09.07.22.39.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 22:39:44 -0700 (PDT)
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
Subject: [PATCH v3 4/6] um: virtio_uml: implement synchronize_cbs()
Date: Tue,  8 Sep 2026 07:38:15 +0200
Message-Id: <20260908053817.26065-5-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260908053817.26065-1-kmehltretter@gmail.com>
References: <20260908053817.26065-1-kmehltretter@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260907_223946_588713_CF754E1E 
X-CRM114-Status: GOOD (  10.82  )
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

virtio_uml invokes virtqueue callbacks from vu_interrupt() and
vu_req_interrupt(), which share vu_dev->irq. The core's
synchronize_rcu() fallback already covers these IRQ handlers.

Implement synchronize_cbs() with synchronize_irq() to synchronize with
that IRQ instead of waiting for an RCU grace period.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 arch/um/drivers/virtio_uml.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 7425a8548141..1f2e62e29a27 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -20,6 +20,7 @@
  *
  * Based on Virtio MMIO driver by Pawel Moll, copyright 2011-2014, ARM Ltd.
  */
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -869,6 +870,14 @@ static void vu_reset(struct virtio_device *vdev)
 	vu_dev->status = 0;
 }
 
+static void vu_synchronize_cbs(struct virtio_device *vdev)
+{
+	struct virtio_uml_device *vu_dev = to_virtio_uml_device(vdev);
+
+	if (vu_dev->irq != UM_IRQ_ALLOC)
+		synchronize_irq(vu_dev->irq);
+}
+
 static void vu_del_vq(struct virtqueue *vq)
 {
 	struct virtio_uml_vq_info *info = vq->priv;
@@ -1121,6 +1130,7 @@ static const struct virtio_config_ops virtio_uml_config_ops = {
 	.reset = vu_reset,
 	.find_vqs = vu_find_vqs,
 	.del_vqs = vu_del_vqs,
+	.synchronize_cbs = vu_synchronize_cbs,
 	.get_features = vu_get_features,
 	.finalize_features = vu_finalize_features,
 	.bus_name = vu_bus_name,
-- 
2.39.5 (Apple Git-154)

