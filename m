Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D28C79F85
	for <linux-um@archiver.kernel.org>; Sat,  5 Sep 2026 15:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tpulPZddhuPwIKcjBWNAE6zpuXjOxSBLaTnXCz35ckk=; b=pMexJgG5ST3UmKxRJrL/wzlXpt
	10CnIycweG/7sviXXdJjsAAZRfutxcPCeM1En/cTauZKz+XbSHzy60E0vs0KDefaPH3N2ftjg9I5m
	GWBDAK4a3hpJbV7k+BkTyGPOr2h4thaPneZm57TM1/xYVeO4CRbl4RUANx72wt4AYdMtXmdTJ8Fp0
	sbQ+7iTsYQDN0/0Ru7vLLP56iwOB1Ahg7GsWBjxBH7pGKsedUEil0ktTASA1ANEss/XD2FZVsMqaA
	5R3PiuOo67IyaX76BoE0DEoVebAGvsTIX27LrqZ1JDIpY90Zi8MHLFR3guxjPIS71a1Iu0YLd2sTH
	3910Lp3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2sCn-00000004Bee-1zWD;
	Sat, 05 Sep 2026 15:21:21 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2sCl-00000004BdU-1hql
	for linux-um@lists.infradead.org;
	Sat, 05 Sep 2026 15:21:20 +0000
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-499ac87c92bso22935495e9.1
        for <linux-um@lists.infradead.org>; Sat, 05 Sep 2026 08:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788621677; x=1789226477; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tpulPZddhuPwIKcjBWNAE6zpuXjOxSBLaTnXCz35ckk=;
        b=sV2j8PePlzmOBVFqhZsqKIduwMT4HZgcPojLBzh7gpIS5WI/s2KtUZp2Ie3Fi7H7Ve
         Oo5oHwbsxnOV3mQUtQi+24o/e1Y7fCly3eM6BcvWGRjf0MpW9rCZqvjsHh5sF0Fi8J6/
         qe5wL7PeF1zapaj+gBX9CTCtj1F6pyLkb8vUsVbiOxvyhKz0fJjc0lFx4cGQJXpQWozr
         MfW5RGa/1//fPC5oQg9f/3L6PR5e1m6giIkeJKFg4I1uQ7eom+t+Jd1ZtyyEHYDuCP8r
         LA2i1TrcSBbObQc3LAv64zGh8ncNaDwZ3EnPvLswM2vCJGFPilUxZ5Syj+qKWvOLqn6U
         5DpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788621677; x=1789226477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tpulPZddhuPwIKcjBWNAE6zpuXjOxSBLaTnXCz35ckk=;
        b=HqcVorL9Vxxu2V/nT9KCoF2m9MA4M300YhHB9vWkwOVF6QtTWhAUKEL5uzyejDEBuM
         qiu5sNUCPgvXXbAMcfkkkQRH/BuIuU4AA4aY9cUQY31J5BvEe1BaKvtjPjSxlTi9eHVS
         FgU3f4T7gI326W9CHtP4nKxyzem+FCSbdtxrbYz/Xz4jrsxf10sgDhx+Jgg5jVNmCnOw
         9PoBPndPGYibcaV3vFJPzL4AioX/mwVW3EnhW3EuzrJMBuC9S7z+IKV29TNWVfYkAzIs
         mYNLGWhKlqfCxYabLBsSEtY0Ja+OiFrTbkkjVWNKtj3I80hKbXlBtYm26o0U4BSlUzJB
         h9Xg==
X-Forwarded-Encrypted: i=1; AKwUvBxHNU7OJ7L29EfRw3e71IyvVvnzvPaSGhYeRALlFIz0g8MtRzMRye1jHHnw/554gaSnRsRd+PPG3w==@lists.infradead.org
X-Gm-Message-State: AFuF++kOZCmt+XKpSEi9LOCWNkJTALc9nW8ojSHkHJ743Xk+/5+tRsjW
	Sdmr59QlgivhrHJTT201obvZOlmve+VUieKnyBJe28HND5zmwsGPKP3x
X-Gm-Gg: AYBFou0XtLfbo91mB87L8EBywDgAWuaHR++ZOV+Hw6VNlXs1rPAU/uwPyi3fHBC5r7t
	hRf9cIiBh38rsVFmdvBQLHmzMNtMMeWtq6PfRNwF+Iq/wdJQQ9xu0JOq0Y0bzTl2Li4KKKX3F/P
	ZNNpB2h/1xoR15oiPNapjpAVQF4U2xliZjnFGqIJPXtafqbDVKSDOBlx4gpnL6xe0AL6r2Nu9qk
	vCcFaSbEKI1qoVmbX27A66MmbIYsvwjSLpCeCJcjk2/Xuw/GS1MY7sEnGr/hQaiuJ8y00JZn60u
	7YKsZYc1rcb4/LNlrH7TCOttHh5vuy61prfEEfGWMTY5PNVxK/oCyk2eEzwJXtp7RkXqxLwscZX
	afW9k/dUeck39NtaQ01fVtCz8jSNsAnrOxtnGIrSIZS2Q1o0mTzi5+zCxJ7olbjXC6Sp3kik5wW
	7o4el3Ar6RPZVg1iT8xOAukISdvOhimD39F2Hkxy76mqyqSmxlUKdkLsICfVfplrTbtsrkgFT9q
	87dIh5vN3az5GCr6LRasIuirpVg3ZB9/FCtC4RJsoYVom1QE9nPYR3Kl3j5d8ILL5iM/m1NgqlH
	Qasy9vXexvl7u46+wZNox9Q2JMxGtreld5M1ek3QZ1jMaZB5BOkMIv6r3nMXnZ4TirI=
X-Received: by 2002:a05:600c:6209:b0:49c:fed6:cd3f with SMTP id 5b1f17b1804b1-49cfed6cd4dmr81095545e9.23.1788621677280;
        Sat, 05 Sep 2026 08:21:17 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf75ce49esm267779515e9.1.2026.09.05.08.21.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 08:21:16 -0700 (PDT)
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
Subject: [PATCH v2 1/3] virtio: synchronize callbacks during device reset
Date: Sat,  5 Sep 2026 17:20:57 +0200
Message-Id: <20260905152059.89560-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260905152059.89560-1-kmehltretter@gmail.com>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260905_082119_484092_70CA6080 
X-CRM114-Status: GOOD (  16.72  )
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

virtio_reset_device() promises that vq callbacks have finished when it
returns. virtio-pci waits in vp_reset(), but other transports can return
with a callback still running.

Call virtio_synchronize_cbs() after config->reset() and drop the duplicate
waits from both PCI reset methods. Add the wait to virtio_device_shutdown()
too, since it calls config->reset() directly. Keep the pre-reset call under
CONFIG_VIRTIO_HARDEN_NOTIFICATION so callbacks see vq->broken.

Always take irq_lock in the classic virtio-ccw interrupt handler so it
pairs with synchronize_cbs even without notification hardening. Use
is_thinint to choose the lock: airq_info can stay allocated after a
fallback to classic interrupts.

The transport reset must still stop new callbacks before this wait.

Fixes: d9679d0013a6 ("virtio: wrap config->reset calls")
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/s390/virtio/virtio_ccw.c   | 6 +-----
 drivers/virtio/virtio.c            | 2 ++
 drivers/virtio/virtio_pci_legacy.c | 2 --
 drivers/virtio/virtio_pci_modern.c | 3 ---
 include/linux/virtio_config.h      | 6 +++---
 5 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index bab6cad3fd5c..552d77998012 100644
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
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 75bb4ffe3b87..ad1c50b8a94e 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -264,6 +264,7 @@ void virtio_reset_device(struct virtio_device *dev)
 #endif
 
 	dev->config->reset(dev);
+	virtio_synchronize_cbs(dev);
 }
 EXPORT_SYMBOL_GPL(virtio_reset_device);
 
@@ -424,6 +425,7 @@ void virtio_device_shutdown(struct virtio_device *dev)
 	 * Some devices get wedged if this happens, so reset to make sure it does not.
 	 */
 	dev->config->reset(dev);
+	virtio_synchronize_cbs(dev);
 }
 EXPORT_SYMBOL_GPL(virtio_device_shutdown);
 
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index d9cbb02b35a1..8115aa39e01e 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -98,8 +98,6 @@ static void vp_reset(struct virtio_device *vdev)
 	/* Flush out the status write, and flush in device writes,
 	 * including MSi-X interrupts, if any. */
 	vp_legacy_get_status(&vp_dev->ldev);
-	/* Flush pending VQ/configuration callbacks. */
-	vp_synchronize_vectors(vdev);
 }
 
 static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 6d8ae2a6a8ca..c9e21317c51a 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -559,9 +559,6 @@ static void vp_reset(struct virtio_device *vdev)
 		msleep(1);
 
 	vp_modern_avq_cleanup(vdev);
-
-	/* Flush pending VQ/configuration callbacks. */
-	vp_synchronize_vectors(vdev);
 }
 
 static int vp_active_vq(struct virtqueue *vq, u16 msix_vec)
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 69f84ea85d71..8684a1e268ee 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -71,9 +71,9 @@ struct virtqueue_info {
  *	Returns 0 on success or error status
  * @del_vqs: free virtqueues found by find_vqs().
  * @synchronize_cbs: synchronize with the virtqueue callbacks (optional)
- *      The function guarantees that all memory operations on the
- *      queue before it are visible to the vring_interrupt() that is
- *      called after it.
+ *      Wait for running callbacks to complete. Memory operations on the
+ *      queue before this call must be visible to vring_interrupt() calls
+ *      that follow it.
  *      vdev: the virtio_device
  * @get_features: get the array of feature bits for this device.
  *	vdev: the virtio_device
-- 
2.39.5 (Apple Git-154)

