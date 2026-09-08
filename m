Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F506C79F9E
	for <linux-um@archiver.kernel.org>; Tue,  8 Sep 2026 05:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=69M0Zjk6fuHd53vao9gFafQcNB6wevMJ2l/Q6J8x1Ec=; b=XVoJiraZTv1B032cm+qeFgZWOI
	x2syXZ5uE8PhExxITM5HQRI5vdHlFXv0cKnH3U2wWYSwqOx9bSKFFaLNxJTnuRXlWDoadLah+a7Yl
	RQhi/Ur13OplFj54RFm9C4qDlFRvh0c+6ZnNodydG1gXaJSPSU4qsG0jncP+KJvdXc9P5kXwJ1pMa
	CFWx4/RCtYCKEsJDdensFgNezYgG/b5CupKbwCk1OP/TJCib13IRbh2/3kME7XK2kEKfjWl5wn17V
	6lg8MvJWavQZGjv2Mhq8QOY2Y5DCD3vVSIDNiATtocHgI++TT7/dqxLh8euYPLrrIxhmPsIyAYdE2
	G6b9c7Uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3oYY-000000085VN-2EMF;
	Tue, 08 Sep 2026 05:39:42 +0000
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3oYV-000000085UM-1aET
	for linux-um@lists.infradead.org;
	Tue, 08 Sep 2026 05:39:40 +0000
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-49b96837ca3so33542765e9.3
        for <linux-um@lists.infradead.org>; Mon, 07 Sep 2026 22:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788845977; x=1789450777; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=69M0Zjk6fuHd53vao9gFafQcNB6wevMJ2l/Q6J8x1Ec=;
        b=jYQd69xoQVQsRUaBQ+m73hfWXREo7T1f328PesO3UAFW/wJQmazdtLWtBYR/c7Ybt4
         rVo2gIqrUgEtqEFPFai5CSLgsIaYaUL11oCALvBS7mphmFBXvtogiE/rio+Z+MoxVAkz
         Db7q84JT3h2GhDOTpSkSxzFMSc52HKmz1uvfr92EqkrVp0KTPbOcQ4OggGkiZI/2973l
         OU3TlSQffIkCxOw94Bg1ymotRFWIymGq2+Y3ZnBDT7AWotNA5iI7B66KXLp8kzEJFHsG
         Bx9FHB1Q0kKjKnOBAlkMnBs2fiD2AzhS6b6y0EFCRt0RGEXqysds5lF4ZVEMHsoK91rz
         8I/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788845977; x=1789450777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=69M0Zjk6fuHd53vao9gFafQcNB6wevMJ2l/Q6J8x1Ec=;
        b=YSYSxK1tyMSLzORtE+Ka9Kh93EchXXB5rBoqMx1HCRkJdsfE8KUXlPr6zgRZXUZ7KV
         t+9u06ygybjaFoag8Jjx87sc+54egdq/l/KORC/ZdraPaw/L9ldAYdpNXUjH6f8/FTLY
         sBPcY1hxFdXlAgMEoF8PnQ9OfdBDIz6niyE4YEriFngr9bKSh5qP2UxSoQQD6XUPKGJi
         k+oOZ44NYkZH739J0skhJ+WY3n0MK0c+GiQf5gDQeLhgA/0gqPOgTSTaXLmNAg+EWiQI
         +7ZlUKh0XeTke6yTLb6GnFWsYhtrnap6EpLq18bPLlSVufqY3njQ9B2fvAy0+WjLKnSf
         vVLA==
X-Forwarded-Encrypted: i=1; AKwUvBztkz5ux6wIVo/V6uI13Hm0nTCDN9SZC+5wn7bGxtzwsESaK7/RUcJBr2KsbjyyaDKWVXP9m9tOXw==@lists.infradead.org
X-Gm-Message-State: AFuF++kiH/FgSGcfozkgzAiwrCi+RvODK0M4H+mOT8+Fz4s6g8b+Npk6
	Qo0N8Gih55LvGjMR2D5SkyFmgR9J037hDscf2UbZGOhlxlm71ZuOTn92
X-Gm-Gg: AYBFou3PQTHxEnefs4NZP92mw1iPyriQLSQPIkZfdb/cSVI5kqkJD/uelLeFmG26Iv5
	J+apNIhAITE5q5llzlVvXE/K50PCnME5IicImub8CwBaIJxX75Mk1ln8of7pXiYBN0ipHpR9Yfb
	PDsSagtEyiWEYhyCY6kWTkw3EETA2j/QGXRbCoX1Jpoiu49N9xG/Xk+hXsfF5gQsJC8kjvbvUPv
	3h/W+37keoR2eFjRTgqBwKVaEus3YdM6JrCH9KPZG8YVFD07Za64lTV0tfX7rMflG+Vjd8R2mDM
	wN7MtlEK4QRSy0zYVQX6VnUSgynm47aY6yLVdH65ET76sCK0BHFIpPSzVVSNd4sdodpSGuXiJmC
	KKeXi6k9juFFzANoTLa7n48BRhUrB0NAJteYBmAdJF5qxfA/1Qkdr0ppGiboNC0o0Df/028bkIT
	Uz7SeS05GYqzc05V7gjKKJ4N5rmcPJ945kNk+N67aL0S04bdSFIWRIGBJWuDP33Wgrs7W62VaGL
	1+luwC+oZ7+frejkK0hTHfAvi7J63kJGSLB0mqo3kEmqL0PJF+pvJQmQ/15VNq7Vq5aDB50/uWh
	e5JzkN8RSKYGRPMS0F42TwXMTGTrgXH82sKI6d1www==
X-Received: by 2002:a05:600c:4e46:b0:49b:910c:7703 with SMTP id 5b1f17b1804b1-49cf823f160mr260148885e9.9.1788845977155;
        Mon, 07 Sep 2026 22:39:37 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-117-170-066.95.117.pool.telefonica.de. [95.117.170.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm523841335e9.13.2026.09.07.22.39.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 22:39:36 -0700 (PDT)
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
Subject: [PATCH v3 0/6] virtio: fix and add callback synchronization hooks
Date: Tue,  8 Sep 2026 07:38:11 +0200
Message-Id: <20260908053817.26065-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260907_223939_445989_A1B0ADDD 
X-CRM114-Status: GOOD (  18.47  )
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

This is v3 of the callback synchronization series. It is based on
Michael S. Tsirkin's linux-next branch at f49e6cf91942 ("virtio:
synchronize callbacks after device reset"), which already contains the
core change and the virtio_input teardown reorder from v2.

Patches 1 and 2 fix two bugs in virtio-ccw's existing
synchronize_cbs() hook. After a fallback from adapter to classic
interrupts it selects the wrong lock, and the classic interrupt handler
only takes the matching lock when notification hardening is enabled.
Patch 3 adds SRCU tracking for remoteproc callbacks, which can sleep.
Patches 4 and 5 replace the RCU fallback with synchronization against
the UML IRQ and the TmFIFO callback locks. The fallback already covers
these IRQ handlers and spinlock sections. Patch 6 adds SRCU tracking
in virtio_vdpa so callback synchronization does not depend on the
context in which the vDPA driver invokes the callback.

The UML, TmFIFO and remoteproc reset paths do not themselves prevent
new virtqueue callbacks. UML and TmFIFO only clear a status field, and
remoteproc does not wait for the remote side to acknowledge the reset.
Without notification hardening or driver-specific teardown protection,
callbacks can still start after reset. The new synchronization hooks
do not fix that. The TmFIFO hook also does not synchronize with the
rest of the FIFO work item outside the callback locks.

The virtio_input loop change from v2 (continue instead of break, so
events the device already completed are still delivered) and the
event buffer leak are sent separately.

Changes in v3:
- Rebased on Michael's linux-next branch. Dropped the core change and
  the virtio_input patch, which are there already.
- Split the virtio-ccw fixes out of the core patch, one per bug, and
  the transport patch into one patch per transport. The CCW and TmFIFO
  changes are functionally unchanged from v2.
- Patch 2: added a Fixes tag and described the existing shutdown
  case. Removed the dependency note on the core reset change.
- remoteproc: read the queue pointer once in rproc_vq_interrupt(), and
  synchronize with callbacks in __rproc_virtio_del_vqs() before
  freeing the queues (Sashiko). Place vq_srcu next to rvdevs so the
  hunk also applies to mainline, which added attach_work after index.
- virtio_uml: compare against UM_IRQ_ALLOC instead of a bare negative
  check.
- virtio_vdpa: use SRCU instead of a per-device rwlock, so the
  callback tracking uses per-CPU counters, and cover the config
  callback (Sashiko).
- Rewrote the commit messages. Corrected the RCU fallback description
  for UML, TmFIFO and the vDPA simulators. Dropped the claimed simulator
  reset race: the simulators disable bottom halves around virtqueue
  callbacks and serialize reset with the worker's mutex.

Changes in v2:
- Moved callback synchronization from virtio-pci into the core, as
  Michael suggested, and added the missing synchronize_cbs() hooks.

Testing: the changed objects build with W=1 without warnings, with
clang on arm64, x86-64 and s390 and with gcc on SMP UML, and the
patches also apply to current mainline and linux-next. The runtime
tests from v2 were not repeated on this version: the input, rebind and
shutdown checks on arm64 MMIO and x86 PCI covered code that is
unchanged here, and the remoteproc and virtio_vdpa hooks have only
been build-tested. No remoteproc, TmFIFO or s390 hardware was
available.

v2: https://lore.kernel.org/r/20260905152059.89560-1-kmehltretter@gmail.com
v1: https://lore.kernel.org/r/20260818040433.66986-1-kmehltretter@gmail.com

Karl Mehltretter (6):
  virtio_ccw: fix synchronize_cbs() after interrupt fallback
  virtio_ccw: always take irq_lock in the classic interrupt handler
  remoteproc: implement synchronize_cbs() for virtio devices
  um: virtio_uml: implement synchronize_cbs()
  platform/mellanox: mlxbf-tmfifo: implement synchronize_cbs()
  virtio_vdpa: implement synchronize_cbs()

 arch/um/drivers/virtio_uml.c             | 10 +++++++
 drivers/platform/mellanox/mlxbf-tmfifo.c | 15 ++++++++++
 drivers/remoteproc/remoteproc_core.c     | 12 ++++++++
 drivers/remoteproc/remoteproc_virtio.c   | 37 +++++++++++++++++++-----
 drivers/s390/virtio/virtio_ccw.c         |  6 +---
 drivers/virtio/virtio_vdpa.c             | 34 ++++++++++++++++++++--
 include/linux/remoteproc.h               |  3 ++
 7 files changed, 102 insertions(+), 15 deletions(-)


base-commit: f49e6cf919425cc55f10fd7cda7e0fc895df4cc0
-- 
2.39.5 (Apple Git-154)

