Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029A8C624DB
	for <linux-um@archiver.kernel.org>; Sat,  5 Sep 2026 15:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z2bLrkBK78EZ1kRlLHpZelHwP/1fERAUtU0NobzNbNE=; b=J/3eb3CSIOvutlBV4sbYiBmflZ
	xEHiSNWIP5CtwZwO4rYnXPmzSMfdNaEsyZFU/GeUZFeF5s8a+8MaY/jkX7lh3M+Fye7J5/sAavHSi
	uzKGTii3h8XqwC3fI2t9Vs5t//Cu8F1aqiDRTTMucKuwSGFw2VnVMjkJf9AJ3aTt7aDSUYDOBiPWs
	G1xNtc369eV+fQ7By2njP3Yozc/lZ8eZtGZ5S13bOJUn5cITjs81ImTQWCDvQZoWga35HnskOUWxn
	DDKGA/j9KgCq2WLkW0CusuIWr1GbKKaipIVpzViFJuu9hh/TxCHLy42LQLPZQFN9atV0AErbPy3/U
	ZaM3ztbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2sCq-00000004BgI-2vdo;
	Sat, 05 Sep 2026 15:21:24 +0000
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2sCn-00000004Be2-0Hrr
	for linux-um@lists.infradead.org;
	Sat, 05 Sep 2026 15:21:23 +0000
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-495590dde14so28351435e9.0
        for <linux-um@lists.infradead.org>; Sat, 05 Sep 2026 08:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788621679; x=1789226479; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z2bLrkBK78EZ1kRlLHpZelHwP/1fERAUtU0NobzNbNE=;
        b=BFwjceyPckDteFqwzOgWqLGahoheWw0cx5SOeiIWti7Ji7IsCBfpA76PZQyYiamZao
         Ld/KRfIT4uJEo37+JB3gopk+uzmVlCJrD4IychuQUE/NWhaNIC2BNtFn53LWnW9QG/gV
         jimijjHY8NoUsTFGJ/jVSUhu9MglEMO4rzuqa5kCou174gAdpVUZBryJB0VT4yUhIL/z
         1wKCFWndE9+STedqobUoKgaRr1w9kkG/4+YVS/PjiEjIe63zJXiOD8+fi/4uBZx/LIdU
         zy1245A1ylGkQSancZxvGOad3GZsmDa8Vt4O4G5RBMeeHJJefmrREld3b5uJ6Y9hWuRY
         ONGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788621679; x=1789226479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z2bLrkBK78EZ1kRlLHpZelHwP/1fERAUtU0NobzNbNE=;
        b=A9B4qYk+nAeuAb1XtzjS5hy9u4y/tTxkkroePSZKVmg8tHnjFRNqbcKPb1Z9CBvcug
         DMYW/uH5koVZujFp7CIsRqgNZuHo18fLp8uAwdd+oH2Jxn7dOJHzYdp8fZIhkuYmtWbZ
         NiDdiaJ9UM/e1lz/8eokLFOgNR4pXABLoMC1jIcLpguG63Lc6IW6ScsdZDEpEqfVmzUx
         dSN8Vu5RED3HOeEUVZ+4V5Z3HI70lwSS/ye+PItyw3vTWHzAvG1WNWMCM74OHauExdhI
         ONC1vZpxPlCj+HoBhIVJqRPYLbkEgWtJXAPnB+QrWuVBbDtG/eb2Y4H14y8S+oUudqFT
         zhdg==
X-Forwarded-Encrypted: i=1; AKwUvBwNzn6xD/r/TCLQ+41jNIkcNY3s++OJ+ov/IhwBiJBNEIMTZF+DAJ5ov5OC80MNgu12y1NQtd2TfQ==@lists.infradead.org
X-Gm-Message-State: AFuF++lP2x2yamOBFF4svuzOkfjGXz7SPOjwechG5fhRtBOKs/wENefg
	xdsPr/VJ6z6O+GqEnM+/UuySeIteHNWiU+497w1YVL6wuVkaZMqfEdz7
X-Gm-Gg: AYBFou2GppID+Hj0RpG7DCci1SGdKCMMLXulgl/AswRG7/GDAyUyZ1vH7TltzjH1VpD
	RgBJkBRMspj7C87PISLpCdKVcYmQB1a2ExznR9GUqPzgU2Y7OJXPjcglHi0JowtUuB44WM8Zooz
	o9YPXwd+Wy+v1WDY28QnvU6G/cxkcBoAnDYgxyMT4qbwmH8pDd/MWOeOQSp3F6OgUbRu0dsGOJJ
	CSpkrpBkQStv8EU4Gp3UOMpSrUto6Sl0bDoSqzMCA9ngf/DdJAlJ0agoK/r9WSM/dUg+tZuOYD4
	zr3RVGgYdJt9slnn/sBR2ETPBUUyYPTi/2kPdQu9iAXTp71ITL1uF2wuVM5ZEGjqDfXazuKcyjh
	A+YZLROmB2csRvlZVFld0+6HBWk342Wui6h7HN+YMpPlHZpQUt2e1WkqRgQ7LyS5rFh6yYUv2iM
	CIWhl10WvJpzkaM3UzV7OZHmXDkgcm4RZw29dCAnwiH96894q4/KGBhWAJVC//eWTJVtuclcK8C
	v4G37rVHZn95w1CpQ20SmVeOJGrF2dRePdu6asMqgkYwmDNPe/IFESEUkXSu4m6PLLpZghTMgIQ
	1aveMLkuTQ1g4KzQdgxtssiYRwKxV3V0UTEM+Nb1yHLAn8Z/Aug2GUMYHf/Rxk8pcnA=
X-Received: by 2002:a05:600c:64c8:b0:495:4d5c:903e with SMTP id 5b1f17b1804b1-49cf81f692bmr245105885e9.7.1788621678914;
        Sat, 05 Sep 2026 08:21:18 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf75ce49esm267779515e9.1.2026.09.05.08.21.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 08:21:18 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] virtio_input: stop callbacks before unregistering input device
Date: Sat,  5 Sep 2026 17:20:58 +0200
Message-Id: <20260905152059.89560-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260905152059.89560-1-kmehltretter@gmail.com>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260905_082121_123690_CBD97513 
X-CRM114-Status: GOOD (  11.50  )
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

virtinput_remove() unregisters the input device before resetting the
virtio device. virtinput_recv_events() drops vi->lock around input_event(),
so clearing vi->ready does not stop a callback that passed the entry check.
It can still use vi->idev, requeue buffers and kick the queue.

Reset first, as virtinput_freeze() already does. With the preceding core
change, reset waits for callbacks before input_unregister_device() can
free vi->idev. Recheck vi->ready after taking the lock again: keep draining
completed events so an input packet is not truncated, but stop requeueing
buffers and kicking the queue.

With evdev attached, input_unregister_handle() currently waits for an RCU
grace period, which also waits out IRQ callbacks. This masks the lifetime
bug on PCI and MMIO, but does not protect sleepable callbacks on other
transports.

Fixes: 271c865161c5 ("Add virtio-input driver.")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/virtio/virtio_input.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index deec24e8e682..7b654af0a42c 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -49,9 +49,12 @@ static void virtinput_recv_events(struct virtqueue *vq)
 				    le16_to_cpu(event->code),
 				    le32_to_cpu(event->value));
 			spin_lock_irqsave(&vi->lock, flags);
+			if (!vi->ready)
+				continue;
 			virtinput_queue_evtbuf(vi, event);
 		}
-		virtqueue_kick(vq);
+		if (vi->ready)
+			virtqueue_kick(vq);
 	}
 	spin_unlock_irqrestore(&vi->lock, flags);
 }
@@ -350,8 +353,9 @@ static void virtinput_remove(struct virtio_device *vdev)
 	vi->ready = false;
 	spin_unlock_irqrestore(&vi->lock, flags);
 
-	input_unregister_device(vi->idev);
+	/* Callbacks use vi->idev. */
 	virtio_reset_device(vdev);
+	input_unregister_device(vi->idev);
 	while ((buf = virtqueue_detach_unused_buf(vi->sts)) != NULL)
 		kfree(buf);
 	vdev->config->del_vqs(vdev);
-- 
2.39.5 (Apple Git-154)

