Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C400C79F99
	for <linux-um@archiver.kernel.org>; Tue,  8 Sep 2026 05:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iPvq113vaLkp19diB9PBTYq+aXRuG2muF34cABuckMo=; b=EjJJCWNzU9+I7jhp8cFfuo4RRk
	zARdoeZafG8iHlvJhNyyNoXDLAcNyLSSbBPt48PuQafrQ+1tx7E6SGJvY9vk/Hq3SbxdjmhygznZd
	gegtE0FXwiM8QaHDDzrKbdMD5ZiG5R//7YM8jFiRHf2b6fyFJvBd0ddtS8ddbASJRANpxviDUXh+a
	1rgxrFFNslIcSbLbyZK9/ou3aTWED5RXAVk66vANOizuJl14LqUFC9qh3D6Vsly4uZAp5jNpYEcP3
	Z7BbDC/9ofQDkGSVasMHKGtUNpJB7Oc+kMXQw7Bg0xiFZmDBNuBBtESnY/35cTfUtMLa4FevbVtnl
	yvGbbUPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3oYj-000000085d7-3mjf;
	Tue, 08 Sep 2026 05:39:53 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3oYe-000000085Yb-06Cr
	for linux-um@lists.infradead.org;
	Tue, 08 Sep 2026 05:39:52 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-49b8ce9b733so34093705e9.1
        for <linux-um@lists.infradead.org>; Mon, 07 Sep 2026 22:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788845986; x=1789450786; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iPvq113vaLkp19diB9PBTYq+aXRuG2muF34cABuckMo=;
        b=b8KPYfUa2OJ51Mesw8C8f9VlsNiu5dCB3BVG+CcFtS5GzQJwmEyAsoeRC0cCazhW19
         LMTqzYh0C2pvqeqOQLexurG6yO8kstL6Gfzz2Udw849YRjLEFNF3GPHhP3WAHJRjAbfG
         D+X5m6aOBfJBAo5T0L9QF9HcbXtfArohocHQKFhkDXxubMhqiprYxaC/yzZr150MPG+7
         4tOKbF9t3WSj7jATfMmF+3GUQF20YcyteGZ0sAaxpfjzm6aBeJnN75ScFBdJzkjnMzz3
         dAy/HxfU8GHxTuIgjOikUMfu6PTTVCDEP3/FnBelBivImfR+ox3s1FzVj44GDuDCLm1p
         9IQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788845986; x=1789450786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iPvq113vaLkp19diB9PBTYq+aXRuG2muF34cABuckMo=;
        b=SUHbPt4qRXU2KUnX4Y4NAHKaoZPInilm/4mfILjuyBiVP4VhDJjiy/Hf+7FrWhMOQg
         p7Q96S/EHGZcj4t/ZGdeKUmNiD1WurE9OOtuNSyNeoE3qE5NR9VspktH7wknJ0ShPbap
         ZU2eietoxz0vxn6Ik8D6/15pTuZCqBkE4/FzJA1YNhRWfm+JZt7naNxGAkYlvhtC8EYW
         EWEzo8ILKo3nnYoMs281chIlBzTHGZSsRH24hfBnoEaqK/DCamKK+HlFZlSQM7miC0JJ
         Kk4PAp9ZOrIEEV+1GPAIV2+lRJlYoPdv9/BSHTALouVn5SsoUvTAfbRB4mverYNEeQ+o
         TI7Q==
X-Forwarded-Encrypted: i=1; AKwUvBwDqE0l7ov3qTC0r9/NXK3/T7KnMOzS2MeB9ZZI3YSMTq+7rzN5tsBVRkDF0oVTOqiyrqQx9SRe/w==@lists.infradead.org
X-Gm-Message-State: AFuF++nkk/E6ajKZ5iCVLEJKPTLrZp/6nUSSzZYK/PWfDTYyC0LFmTur
	VpnRreuEwpK9qS2CSemhxF6n9zTpuVBnWSWxHqayfJY3lWFy2YShjzB1
X-Gm-Gg: AYBFou06LIixB6+Zu7A/pZskVn3ZLjcaK7k3uFdm/AZzZAZ7Fv2SiImAwCRESOZtwSa
	ICOyOm3nivhdqy+KMwwvL5etJJeA/XX9wy+0dTOmUMPdTQZj9QYCdGghyQzyozPDAPv/mvIwRpv
	pvyHSClK0VLCJFot8Zp7JjNO95RGZ7cmTlXVC0uCfFAYKQbDW11i5aqpdIlciwhAL/rjWiXBmyt
	6e3D4w0gdYKYLwudJYD1doSEVNyzzFNUH0J/cgGlQvf5xgb7fFMMH+J6ZtwhMWCl/cJGdld+BWD
	guBqEKmW2DrwmInPFFhln6XjIG3LLampjlex8krWiK8GJ+7fpHszkvTuSdQdplHMglnzGN+eKg6
	qPp1XFOYqtXJjKxBXVwABNuJQ2HwziH/cm024+OEXyMADTQcu7Kn0wWRd06qJUOdwoSG9YICkqC
	LiQ7x1BguqSbaZl1LGhBZfKjkBbL2WYSui3RzNyqFnIMqxfjzuNLcRkrae40gw2h7ECcXepT7nT
	JDK3uQYzhLQx5JaHxeHSGBcjugHvz8Tb6NwjX90tCmBma4mN+qJ4rf3eoVDYNHSfd/O14dVNunY
	MrzM/VQFOSbFUSaenL3VwfCfI6LTY4Jq+rQdzpb4nNI=
X-Received: by 2002:a05:600c:620b:b0:49c:fa20:cc07 with SMTP id 5b1f17b1804b1-49cff19cbf4mr203278645e9.30.1788845986284;
        Mon, 07 Sep 2026 22:39:46 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-117-170-066.95.117.pool.telefonica.de. [95.117.170.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm523841335e9.13.2026.09.07.22.39.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 22:39:45 -0700 (PDT)
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
Subject: [PATCH v3 5/6] platform/mellanox: mlxbf-tmfifo: implement synchronize_cbs()
Date: Tue,  8 Sep 2026 07:38:16 +0200
Message-Id: <20260908053817.26065-6-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260908053817.26065-1-kmehltretter@gmail.com>
References: <20260908053817.26065-1-kmehltretter@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260907_223948_086116_DDBB5B33 
X-CRM114-Status: GOOD (  13.12  )
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

TmFIFO invokes virtqueue callbacks from its FIFO work item under
spin_lock_irqsave(). The core's synchronize_rcu() fallback already
covers those sections.

Implement synchronize_cbs() using the existing per-direction locks
instead of waiting for an RCU grace period. fifo->spin_lock[0] covers
the transmit callbacks, including the callback from the timeout
handler. fifo->spin_lock[1] covers the receive callbacks. Take and
release each lock in turn to synchronize with callbacks running
under that lock.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/platform/mellanox/mlxbf-tmfifo.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index 3c6408581373..664bec20a7ae 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -1135,6 +1135,20 @@ static void mlxbf_tmfifo_virtio_reset(struct virtio_device *vdev)
 	tm_vdev->status = 0;
 }
 
+/* Synchronize with callbacks running in the FIFO work item. */
+static void mlxbf_tmfifo_virtio_synchronize_cbs(struct virtio_device *vdev)
+{
+	struct mlxbf_tmfifo_vdev *tm_vdev = mlxbf_vdev_to_tmfifo(vdev);
+	struct mlxbf_tmfifo *fifo = tm_vdev->vrings[0].fifo;
+	unsigned long flags;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(fifo->spin_lock); i++) {
+		spin_lock_irqsave(&fifo->spin_lock[i], flags);
+		spin_unlock_irqrestore(&fifo->spin_lock[i], flags);
+	}
+}
+
 /* Read the value of a configuration field. */
 static void mlxbf_tmfifo_virtio_get(struct virtio_device *vdev,
 				    unsigned int offset,
@@ -1179,6 +1193,7 @@ static const struct virtio_config_ops mlxbf_tmfifo_virtio_config_ops = {
 	.find_vqs = mlxbf_tmfifo_virtio_find_vqs,
 	.del_vqs = mlxbf_tmfifo_virtio_del_vqs,
 	.reset = mlxbf_tmfifo_virtio_reset,
+	.synchronize_cbs = mlxbf_tmfifo_virtio_synchronize_cbs,
 	.set_status = mlxbf_tmfifo_virtio_set_status,
 	.get_status = mlxbf_tmfifo_virtio_get_status,
 	.get = mlxbf_tmfifo_virtio_get,
-- 
2.39.5 (Apple Git-154)

