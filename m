Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04382C79F99
	for <linux-um@archiver.kernel.org>; Tue,  8 Sep 2026 05:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Ry5IsRI3u6+OA2QrlJEuTetR9sltFKry3tbM/33hEE=; b=Kq9oUsDlnaORV3VD7MB88CRYms
	573VVHVXHTYsj6A5LMn9TaZFQibCt8ACSXSKtfqTMuxfz5toJZPdz8iuW5KchUqkKAjKgn2Xbeh92
	3G2DvJWj0+svk3uOkX0YWZHZ27lHvTeXwi+ZyNCeqbkaat0YZ41zpMr4NvQIjeA2t0pD2lCN80UpX
	QPd7bd1YVIwcBCyi5sI1IWlFrGG0TE7ephtwkkZ5S7gx4PVCtGQHdufvwNmG3eTGHRBzjsnCHQD+1
	3m3TNMNmr59iiEd/CbDIbWg3S3UDql5fR/ehX0gxCxagGt8kxZV+0CMKJd0H1zWnDFOIWaSTBk6on
	yKSwYpuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3oYZ-000000085Vm-2QH3;
	Tue, 08 Sep 2026 05:39:43 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3oYX-000000085Ut-0OpE
	for linux-um@lists.infradead.org;
	Tue, 08 Sep 2026 05:39:42 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-49b96837ca3so33542935e9.3
        for <linux-um@lists.infradead.org>; Mon, 07 Sep 2026 22:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788845979; x=1789450779; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Ry5IsRI3u6+OA2QrlJEuTetR9sltFKry3tbM/33hEE=;
        b=ouvACr71D8It8oFE+l2EzQpotpuymBpD03ddrstLfO6MY6CSCj8woZnJjWiffkwO95
         BWJ+2THmUwLoCBWsSZVLU2cSxeSC46nCXPAUmDHXm4hyEo1dB+WH7PSYRe1IQAXl1uPX
         K22ewRJyBKlgoQiFqwSVWz9h+Vp04dqtIeGbJU+ou0twljIh1jq4NOslN/iFyNdVDojH
         uCe81/6C8qX+zqCqHB/MiWbBS3Ld/c2+WbzejaWUyKLZzJdjsP1gNwdz73ZpPjSAdpgh
         CQMgm26xhieKz1S/XQEmRx1TDRwvwne07QMcymlBH2INpxYaeU+QocmjmqhOF/3zbszY
         MD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788845979; x=1789450779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Ry5IsRI3u6+OA2QrlJEuTetR9sltFKry3tbM/33hEE=;
        b=As2lJ8n+vfEslfDFJ+RhxGozm9MjglQqhBkz8ynCnEHlxV791PB6LKi1A2eSzmJY4Q
         VCkQT2p5JlhUyTtgw7JH1ycg6b8QwYNr0f5jEEkBsys4Pxfpzer42BFuuZJ/cueROvCL
         uKZdXDwFiZDuBr/189g61jJhjA5XKSHgKC9/ccIV1fYKyDaOXMVMIb4Fuv9RIxsVJN9l
         aR/RYys0SlwmX6HCV7Wup0DahM6ncVlBGsUjykAbAu2xVKCcVrf0atD4EodSMB4L6vZi
         oh4wX+Pd10UV29ktxPTZdmHIApjJUuEW/Eo9RDYnU/nOsi8OnQnlvWYFVHw8TYBUV0sq
         35ng==
X-Forwarded-Encrypted: i=1; AKwUvBxS80bazwbyC+pkxltkBS+oKfbYFAoVA1OClUpurFjP8HUTB0SnXZVItP5mByjQxknwgVwnBfERDw==@lists.infradead.org
X-Gm-Message-State: AFuF++mZ9R4gbSYyJhv9FhS7BudlsSyp7tZ82dWaSftL48mremSQ9IKn
	udjxKlyXUQRu8+KFk45GXXIjnUtn8xHSFF8T7BiixFvYd3mVKMwHmxiY
X-Gm-Gg: AYBFou2JJKv+1tnDg8GVveFqTjcNkIr2l/fSYEoU1cisTdrzWx/J+lhk6F+SNMruKZt
	nD7OJoEhNZm5JToQI/qGgR+hZj8bpUwzh7dT8vPjXp4eMPb9JuSz447ptvsEYZrtYPJ7rkxQs+4
	QUod4tGItFzunClC9zmDaw93cHuAghPhW29S9gUQVnnyK+cmmBqmllUhQ7Vg/NXbFzvcUmlEvgt
	1nV1K+/Bs56gvXS3xyBiwRxgoYGLNenVlCy7bX32Ena+dI9WUfaFniX/uSZ0vfCErixI9OucGnJ
	w9MyBAexVofEmccOYKPdZASzIZLKyi8wnZDP56U2JNyr96Jj3atKfee5Q0O52na+ZbS+2S0WDEu
	9jHjtStrKpmVTbWV0pK13ZIKoZKtY7lKleFp8Fw4GvHAqylXLq56tXdpd4CVxtiMoEArYtV3oyn
	SzTSKoODoIVvSvgRXfV5rFq4lom0pAU6CgL3ZMHHW9KkRYvy4noUMfst+cYnbvMJUtZBENR5vJI
	6MfokwVhXB4BySB7uQiX77vG8Hino0YMr0KLSTOBT9Gfe3goETRtALCA122FK+mBm2Y4Q1l/jo+
	2ZBE3m+oe7kTTrIJS7IiS6nO9DAcdUcwJLuVyAd8yQ==
X-Received: by 2002:a05:600c:6748:b0:49c:fc6c:bdfa with SMTP id 5b1f17b1804b1-49cfc6cbfa2mr234336305e9.17.1788845978942;
        Mon, 07 Sep 2026 22:39:38 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-117-170-066.95.117.pool.telefonica.de. [95.117.170.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm523841335e9.13.2026.09.07.22.39.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 22:39:38 -0700 (PDT)
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
Subject: [PATCH v3 1/6] virtio_ccw: fix synchronize_cbs() after interrupt fallback
Date: Tue,  8 Sep 2026 07:38:12 +0200
Message-Id: <20260908053817.26065-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260908053817.26065-1-kmehltretter@gmail.com>
References: <20260908053817.26065-1-kmehltretter@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260907_223941_151331_AD27860D 
X-CRM114-Status: GOOD (  14.41  )
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

virtio_ccw_synchronize_cbs() assumes the device uses adapter interrupts
when vcdev->airq_info is not NULL. If registering adapter indicators
fails, virtio_ccw_find_vqs() falls back to classic interrupts but can
leave airq_info set.

With VIRTIO_HARDEN_NOTIFICATION enabled,
virtio_ccw_int_handler() invokes callbacks under vcdev->irq_lock.
synchronize_cbs() instead takes the indicator area lock, so it does
not synchronize with those callbacks.

Use vcdev->is_thinint, which the fallback clears, to select the lock.
Keep the airq_info check because is_thinint can be set before the
first find_vqs() call, when airq_info is still NULL.

Fixes: 3a232277c1ac ("virtio-ccw: implement synchronize_cbs()")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/s390/virtio/virtio_ccw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index bab6cad3fd5c..b90299205698 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -1062,7 +1062,7 @@ static void virtio_ccw_synchronize_cbs(struct virtio_device *vdev)
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
 	struct airq_info *info = vcdev->airq_info;
 
-	if (info) {
+	if (vcdev->is_thinint && info) {
 		/*
 		 * This device uses adapter interrupts: synchronize with
 		 * vring_interrupt() called by virtio_airq_handler()
-- 
2.39.5 (Apple Git-154)

