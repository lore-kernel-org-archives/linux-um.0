Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474F6C79FAA
	for <linux-um@archiver.kernel.org>; Tue,  8 Sep 2026 05:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RUNN4pXUiIqbT553r7BwzJCI10zpfzMw6DzVR+9Z+tQ=; b=QklT05l0CiI/kBFFsbjQt3Sl5g
	v88IMDgTkNFVCoVbVsKtWEw8IO3//6IQSoXlKPhMuGsxvZ4HZIYKi5ItBh4+cK9rRo8JJwm2BfG5c
	Pbaqo+1tDzZbzBT5bI2HABRR20FH4T2evkvnDw22/shraq4bq1G9VW4wDIfbWwTIEmHU1O0fBLrmT
	FK+BCL2W/gMVrsccFcL1HtCL9YSGLiHdvFxhzn2AKLNWoO0mKG4Sw2WJWz85yr242BbyX5CbO5pkP
	9f9x/dU/EttmBZjGg8jSuzKtFaMMr+aXXlt+CCPqzUtMsL7MZJuCOVfkQB5NZgydLRj9nZ4Mc0/Pb
	JM7/biXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3oYa-000000085WF-2hAL;
	Tue, 08 Sep 2026 05:39:44 +0000
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3oYY-000000085VH-32r5
	for linux-um@lists.infradead.org;
	Tue, 08 Sep 2026 05:39:43 +0000
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-49b0d8bc2aaso53071135e9.0
        for <linux-um@lists.infradead.org>; Mon, 07 Sep 2026 22:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788845981; x=1789450781; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RUNN4pXUiIqbT553r7BwzJCI10zpfzMw6DzVR+9Z+tQ=;
        b=afSc3Dr7fe/bPuFIP7fHc8FRUzrUlpc8SgSsBXSM1pN+bkyaXPGk3jzQ/9Zcqmt8AU
         YwxzZxr8IArribmbHmxqI52Vf3iAY+JCcQzUyVQb/Ak7Oz0TyzICTq/ImDPsXi6zXABd
         lIidmSPAqiNiE5ptb+g8gKtwo+177mKw8AKFVXxjN4/vM1P+P6zXVQYq5OVLiF+TjHfG
         +kaGxMuNsvFIWfYu6GjPbxDqu6xbpQADh6RZfyDDQgDb6FJ4Kc92h28mQDPYwf+xAQ7Z
         rF4F5blUXOZemVaKhcmp7yYxr/wR6OWguZkd+dTnOp0xcSKQeH2spjjXZUMD6tfRTtPF
         43XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788845981; x=1789450781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RUNN4pXUiIqbT553r7BwzJCI10zpfzMw6DzVR+9Z+tQ=;
        b=XECq6GYfGnVUd/Ub1Ov5WTCMeyJxz8VhXkap5oDpaaCKY9CbtlRB0OWxtBqkNfwBdX
         shXjwqeUUDxJg2jp3vC7cIddRjiiynymAEI5eyDxS5WM1G5Ekjk/80sxjSPMNo04sAM6
         ArOECE44YILVW4QqvvQGj6IextxvdpX3bYIiO/ccEAuEKeEYukOVjjVSoQCtuXw7AXLT
         1zEyVHsLZb1houJan5nX055ALo2G6fwvGcO5vBKbG4xC1lbgyJ3du3ZI3Iq4/y3TH4Zc
         C+zDmucX8xMXus2J8b8QxBBOvqmF1616dsXBKu6PkWzQI7DDHhczyF9UOn+fjdL0vu61
         1wYg==
X-Forwarded-Encrypted: i=1; AKwUvBwq13JmFkP2IAnAxwtqeeBjnf26ckAe4KGzcxC2XCw3xvDVEZyyPlPmyula15kXX8tXj0NkQ8x7VA==@lists.infradead.org
X-Gm-Message-State: AFuF++kDSi+JAoyLgcyrmpg0Xq/oJEaUWtUQiINGrKvvgUYEqIiWDGZU
	SbCujfvhez2mnvcpYp7WNP9SaDNVz1FzTHZargLID3lTlXIjSQ7CyajF
X-Gm-Gg: AYBFou0Uva7dVnGPr7QWYteN2jKoRiaS4CdZu0KILDRRN/3VInon5+P6FrBKgU+bBdA
	Fu+HTzjN1HtOIRC7I/cgX1sM25VHfEvRq/JbnpdRx/HZsHi1NrJpDge1g5at2+XEOhMF+lnFNQc
	MaGZW77Ye3qeogoOCbI7t0v4jduBO6ylddvSW72YwSrASzowdiyf8YEjP3sTLmahLPz2My0waJv
	Xifwgf58n+hhFI+d3qSf2IYRu/p+HHjFVxekkcvJxQxfUgvgfwHnLdjzlslTPwOrUfd1EIQBMfK
	qa05EUVEtSKpXZZSS8+HoGan5KE59bbgThHMS+EnsEm5BBiA9MDUF08R08tLBfNmx/nXDuYsY97
	/AhdtvS5RAJfLGLg3mhFhGrhhVZLezy7dshVLlJVBtnh2/q+2yfk7Lnobqba6viGd7cK3PZsc1y
	2qOybhHBK0vtUJYRts34GPtRD9mYnd0e2HYtXUEfxHvrkNIY7rsb+IPc6C3dMukp9VZoHhygiVF
	W7dUUpfmYZk4/JgrwwTYRXk+OzSFZz8XTzLQJsDBUNHNqWlpT4gdT5/wvzEYygXaxq9S136etac
	swXAz0uXigFNNG/TnuSE9AcsE4vYC9c=
X-Received: by 2002:a05:600c:3b21:b0:49c:ee01:8c53 with SMTP id 5b1f17b1804b1-49cf820ab3dmr263600185e9.2.1788845980825;
        Mon, 07 Sep 2026 22:39:40 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-117-170-066.95.117.pool.telefonica.de. [95.117.170.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm523841335e9.13.2026.09.07.22.39.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 22:39:40 -0700 (PDT)
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
Subject: [PATCH v3 2/6] virtio_ccw: always take irq_lock in the classic interrupt handler
Date: Tue,  8 Sep 2026 07:38:13 +0200
Message-Id: <20260908053817.26065-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260908053817.26065-1-kmehltretter@gmail.com>
References: <20260908053817.26065-1-kmehltretter@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260907_223942_793007_AB2E55A1 
X-CRM114-Status: GOOD (  11.78  )
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

virtio_ccw_int_handler() takes vcdev->irq_lock around its
vring_interrupt() calls only when VIRTIO_HARDEN_NOTIFICATION is enabled.

The virtio shutdown path calls synchronize_cbs() even when notification
hardening is disabled. virtio_reset_device() now does so after the
transport reset too.

For classic interrupts, synchronize_cbs() takes vcdev->irq_lock for
writing, but the interrupt handler does not take the matching read
lock in that configuration. synchronize_cbs() can return while a
callback is still running.

Take the read lock unconditionally so the write side can synchronize
with the callbacks.

Fixes: 8bd2fa086a04 ("virtio: break and reset virtio devices on device_shutdown()")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/s390/virtio/virtio_ccw.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index b90299205698..552d77998012 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -1204,13 +1204,11 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
 			vcdev->err = -EIO;
 	}
 	virtio_ccw_check_activity(vcdev, activity);
-#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
 	/*
 	 * Paired with virtio_ccw_synchronize_cbs() and interrupts are
 	 * disabled here.
 	 */
 	read_lock(&vcdev->irq_lock);
-#endif
 	for_each_set_bit(i, indicators(vcdev),
 			 sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
 		/* The bit clear must happen before the vring kick. */
@@ -1219,9 +1217,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
 		vq = virtio_ccw_vq_by_ind(vcdev, i);
 		vring_interrupt(0, vq);
 	}
-#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
 	read_unlock(&vcdev->irq_lock);
-#endif
 	if (test_bit(0, indicators2(vcdev))) {
 		virtio_config_changed(&vcdev->vdev);
 		clear_bit(0, indicators2(vcdev));
-- 
2.39.5 (Apple Git-154)

