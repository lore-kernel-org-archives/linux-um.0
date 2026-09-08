Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B52C79F9E
	for <linux-um@archiver.kernel.org>; Tue,  8 Sep 2026 05:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E0xn/sQ1syzuU4VFJfjc1woEjzltXnI10QEuTRC1ag8=; b=aeL9jLWNk7UNvhEzFcqkLpd8Pf
	/iPCOHALit+lHzFoVSqbbvzDfVK8M0zyt2F8T4SKBRPyyMFtUxoUyUGY3Rbp9O3htJKlNLbpAEL0X
	RHBV9dk9YK/riHQ3E1I8GlEN/QU9G05bLH3KDOkbznlU81cKG0j8LZ9DD6rpezOqI2dLLUkcdmyt0
	AbopzikcqBq3w3pXBqcSwLmj+zdsS9Uxm2FypV5YgCU8fYed3xo/P/JaFyYeayTWxrqCA84c1ECOi
	Dlp+tfAAwGpxsBucfYURKit6m4J9463beBsmsXhdU2tcjmE2sLNnpOshItq8ub1wTnh0Aksy8Zbkn
	dnrGjZYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3oYc-000000085YD-3DIg;
	Tue, 08 Sep 2026 05:39:46 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3oYa-000000085Vl-3udA
	for linux-um@lists.infradead.org;
	Tue, 08 Sep 2026 05:39:46 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-49cdc81f40eso30820045e9.2
        for <linux-um@lists.infradead.org>; Mon, 07 Sep 2026 22:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788845983; x=1789450783; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E0xn/sQ1syzuU4VFJfjc1woEjzltXnI10QEuTRC1ag8=;
        b=N1HwbMGUuKANhimmR7qmkVCMEA2j0ZZl+EF6BxRyDK8Ky3ErCXihFH4XdUxQzGxnrC
         Erh0q+TRGOZyWA+DW2r3z5G4aC0gnNvT9KC3dJYeto/Exs71KQw2TVYQyWJe1XM2YLhw
         FeCp0JKmLgbF9c2NzrNnwm/pf6xoRfHF2BKvzfKD+gHcXyClXkwbKm6KJuNpJGjAl/kr
         LFpr9a7fU30PFBGdnjFHuM2ytI/ka/yHpPRXhjg8m4GmLrW+Kmwv0pjyLVHvy72BOiNz
         yBkfQI2IP4LaK6Q1z2S/L6Mugth0QaPRovbIt0AKV8TehWQqFS2xMn78tE4N3NuZQtc2
         wyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788845983; x=1789450783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E0xn/sQ1syzuU4VFJfjc1woEjzltXnI10QEuTRC1ag8=;
        b=sJu0+ZvDV9k5DUqerMkzXtR6l5cqarDQ8TOsxxGQzLCAN48zo/8hcpqaLumE8srnpt
         GtaJp6E8XWX0WkEJLyL9v/bX6NcYY+zhPS28R3ZG/7k9lnwDsAq3icjbtvxtPvSBKNBq
         bC4rk/kZ3SIBig5PiV2y+KYDYYtbmn03k8pJDaFbq0Cq+n+mqwwQRc9eylRAXWcaSH//
         IbUINNidaQxX9r26z/1DJ9HCtqzn+A271+/scXx1kcqOeUDsiHg0wc53Z50hlm7AAGov
         fxQO0Sd5P2pojREVr1QzavTZJsNfuzia9AqTwKUtUm5fisacTIrCbSfWrW2LMK7tv+b5
         6LOA==
X-Forwarded-Encrypted: i=1; AKwUvBxO6JxJDV/0TgpLi0/b6OqlW4WNcV5LFNoTE9yC0J2qzRgcWLNuoqcUUVznv6uMmqbqMQD1TrFBNw==@lists.infradead.org
X-Gm-Message-State: AFuF++ngGu4r0syTslAvC8IoUikdL/4RHbh+K9USlRgQScv9XypiiV2f
	mXd0zUkvHIkDedL/O1cWdNO6uuqjCHwX8f6MDv8Yb3JCudC0aLmONSVb
X-Gm-Gg: AYBFou0I0eznUkmakdpg4+/3lz18CJOYxiBOv4bmbFLqgYCduGrIUd4m5UNLUeIE0m3
	ICJWchH31a3PmPnp6a056IngB4fDYuhqbbnGPK3Uk3s0VM4LOVJVBzAsFz1sQt4ZwYEF4iZs9xq
	vAAQXifCRFtvjaUnH1HXH6vgHk8UGQwrHmqdJzBbP407IcAIspGOtObss4F+ab1HCb/VA9/jtIj
	2ESc9AAPZicG/riQqCQLPToaftU8o++r99euOAK64SqdzRUdhQauzW7G2xAg7Hd5sNN6pybpQ5y
	H2XxbrfiI2h5epRnVJRv0d31OcZd4lHBhkZBsADj88Y3GMsrCH4dckfa6U80pyWmTyYvG1hE8jI
	Nkw6h4EnygNub3p/75O+F9gM3BV8+HjM+il1V9k3nKckeFfSmqoaUo+tvzyBqRvzzRHz4uzvMZA
	Pvwfg1Qezgm7Ca/1KZ8TQfFOMwD3qrJ8ZSUlClnwNi46sGmowTBkkUXbfnoJNkQmIosTUd6/d3f
	b8eJvTvFK/Ejb5CuNAKrDUTVBdKMWCZSwSFoyJPFjK+3sLlWXs0Ej3ZVOWvRr8kZTHTcYPreaUS
	hw83NlgER3VbZ+JTsGHKtwgEqnJbB0k=
X-Received: by 2002:a05:600c:3f12:b0:49c:c8de:96a9 with SMTP id 5b1f17b1804b1-49cf7fdd2dfmr526948265e9.2.1788845982788;
        Mon, 07 Sep 2026 22:39:42 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-117-170-066.95.117.pool.telefonica.de. [95.117.170.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm523841335e9.13.2026.09.07.22.39.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 22:39:42 -0700 (PDT)
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
Subject: [PATCH v3 3/6] remoteproc: implement synchronize_cbs() for virtio devices
Date: Tue,  8 Sep 2026 07:38:14 +0200
Message-Id: <20260908053817.26065-4-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260908053817.26065-1-kmehltretter@gmail.com>
References: <20260908053817.26065-1-kmehltretter@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260907_223945_014201_5561F62F 
X-CRM114-Status: GOOD (  22.07  )
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

Platform drivers invoke rproc_vq_interrupt() from hard-IRQ handlers,
threaded handlers, and work items. Because rpmsg callbacks may sleep,
the virtio core's synchronize_rcu() fallback does not synchronize with
callbacks across all these contexts. A device reset can therefore
complete while a callback is still running.

Add an SRCU domain per rproc. Protect both the queue lookup and
vring_interrupt() with it, and synchronize the domain in the new hook.

__rproc_virtio_del_vqs() can race with rproc_vq_interrupt() too. Clear
all queue pointers and synchronize the SRCU domain before freeing the
queues, so callers that already found a queue can finish using it.
Read rvring->vq once to avoid a second load after deletion starts.

The SRCU domain has the same lifetime as struct rproc. Its cleanup can
sleep, so document that rproc_free() and rproc_put() must not drop the
last reference from atomic context.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/remoteproc/remoteproc_core.c   | 12 ++++++++
 drivers/remoteproc/remoteproc_virtio.c | 37 +++++++++++++++++++++-----
 include/linux/remoteproc.h             |  3 +++
 3 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index f003be006b1b..6756f2fe4ec5 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2367,6 +2367,7 @@ static void rproc_type_release(struct device *dev)
 
 	dev_info(&rproc->dev, "releasing %s\n", rproc->name);
 
+	cleanup_srcu_struct(&rproc->vq_srcu);
 	idr_destroy(&rproc->notifyids);
 
 	if (rproc->index >= 0)
@@ -2464,6 +2465,11 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 	if (!rproc)
 		return NULL;
 
+	if (init_srcu_struct(&rproc->vq_srcu)) {
+		kfree(rproc);
+		return NULL;
+	}
+
 	rproc->priv = &rproc[1];
 	rproc->auto_boot = true;
 	rproc->elf_class = ELFCLASSNONE;
@@ -2526,6 +2532,9 @@ EXPORT_SYMBOL(rproc_alloc);
  *
  * If no one holds any reference to rproc anymore, then its refcount would
  * now drop to zero, and it would be freed.
+ *
+ * Context: Any context, but the last reference must not be dropped from
+ * atomic context.
  */
 void rproc_free(struct rproc *rproc)
 {
@@ -2541,6 +2550,9 @@ EXPORT_SYMBOL(rproc_free);
  *
  * If no one holds any reference to rproc anymore, then its refcount would
  * now drop to zero, and it would be freed.
+ *
+ * Context: Any context, but the last reference must not be dropped from
+ * atomic context.
  */
 void rproc_put(struct rproc *rproc)
 {
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index d5e9ff045a28..7fefb4bd7adc 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -23,6 +23,7 @@
 #include <linux/err.h>
 #include <linux/kref.h>
 #include <linux/slab.h>
+#include <linux/srcu.h>
 
 #include "remoteproc_internal.h"
 
@@ -88,15 +89,23 @@ static bool rproc_virtio_notify(struct virtqueue *vq)
  */
 irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int notifyid)
 {
+	irqreturn_t ret = IRQ_NONE;
 	struct rproc_vring *rvring;
+	struct virtqueue *vq;
+	int idx;
 
 	dev_dbg(&rproc->dev, "vq index %d is interrupted\n", notifyid);
 
+	idx = srcu_read_lock(&rproc->vq_srcu);
+
 	rvring = idr_find(&rproc->notifyids, notifyid);
-	if (!rvring || !rvring->vq)
-		return IRQ_NONE;
+	vq = rvring ? READ_ONCE(rvring->vq) : NULL;
+	if (vq)
+		ret = vring_interrupt(0, vq);
 
-	return vring_interrupt(0, rvring->vq);
+	srcu_read_unlock(&rproc->vq_srcu, idx);
+
+	return ret;
 }
 EXPORT_SYMBOL(rproc_vq_interrupt);
 
@@ -153,7 +162,7 @@ static struct virtqueue *rp_find_vq(struct virtio_device *vdev,
 
 	vq->num_max = num;
 
-	rvring->vq = vq;
+	WRITE_ONCE(rvring->vq, vq);
 	vq->priv = rvring;
 
 	/* Update vring in resource table */
@@ -165,14 +174,20 @@ static struct virtqueue *rp_find_vq(struct virtio_device *vdev,
 
 static void __rproc_virtio_del_vqs(struct virtio_device *vdev)
 {
+	struct rproc *rproc = vdev_to_rproc(vdev);
 	struct virtqueue *vq, *n;
 	struct rproc_vring *rvring;
 
-	list_for_each_entry_safe(vq, n, &vdev->vqs, list) {
+	list_for_each_entry(vq, &vdev->vqs, list) {
 		rvring = vq->priv;
-		rvring->vq = NULL;
-		vring_del_virtqueue(vq);
+		WRITE_ONCE(rvring->vq, NULL);
 	}
+
+	/* Synchronize with rproc_vq_interrupt() callers that found a queue. */
+	synchronize_srcu(&rproc->vq_srcu);
+
+	list_for_each_entry_safe(vq, n, &vdev->vqs, list)
+		vring_del_virtqueue(vq);
 }
 
 static void rproc_virtio_del_vqs(struct virtio_device *vdev)
@@ -242,6 +257,13 @@ static void rproc_virtio_reset(struct virtio_device *vdev)
 	dev_dbg(&vdev->dev, "reset !\n");
 }
 
+static void rproc_virtio_synchronize_cbs(struct virtio_device *vdev)
+{
+	struct rproc *rproc = vdev_to_rproc(vdev);
+
+	synchronize_srcu(&rproc->vq_srcu);
+}
+
 /* provide the vdev features as retrieved from the firmware */
 static u64 rproc_virtio_get_features(struct virtio_device *vdev)
 {
@@ -330,6 +352,7 @@ static const struct virtio_config_ops rproc_virtio_config_ops = {
 	.find_vqs	= rproc_virtio_find_vqs,
 	.del_vqs	= rproc_virtio_del_vqs,
 	.reset		= rproc_virtio_reset,
+	.synchronize_cbs = rproc_virtio_synchronize_cbs,
 	.set_status	= rproc_virtio_set_status,
 	.get_status	= rproc_virtio_get_status,
 	.get		= rproc_virtio_get,
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 7c1546d48008..93a182b1868a 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -41,6 +41,7 @@
 #include <linux/cdev.h>
 #include <linux/completion.h>
 #include <linux/idr.h>
+#include <linux/srcu.h>
 #include <linux/of.h>
 #include <linux/rsc_table.h>
 
@@ -256,6 +257,7 @@ enum rproc_features {
  * @mappings: list of iommu mappings we initiated, needed on shutdown
  * @bootaddr: address of first instruction to boot rproc with (optional)
  * @rvdevs: list of remote virtio devices
+ * @vq_srcu: SRCU domain for the virtqueue callbacks of @rvdevs
  * @subdevs: list of subdevices, to following the running state
  * @notifyids: idr for dynamically assigning rproc-wide unique notify ids
  * @index: index of this rproc device
@@ -298,6 +300,7 @@ struct rproc {
 	struct list_head mappings;
 	u64 bootaddr;
 	struct list_head rvdevs;
+	struct srcu_struct vq_srcu;
 	struct list_head subdevs;
 	struct idr notifyids;
 	int index;
-- 
2.39.5 (Apple Git-154)

