Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D12EC54E41
	for <linux-um@archiver.kernel.org>; Thu, 29 Feb 2024 07:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=V/QiwEFi+hLqHtGYF26e8Bge+srwrBYJXlThf9c9akc=; b=mF3dM37mK9EqdtGLkkf5Pov9fs
	q7dCVKtE4dg9nCms57VS46aH2+IYkBpJb8xt/vNjG5paCF6oNCGqbbvIeoJIEqaUsvjWiVt1JXGk7
	YWg/txtb/O03jbTv8bFyTKAppRuyvVfu8nfuj11r7OKlNGiFi7Me79CNG6SJnad4itZd+jN78vQPA
	x7T84If9XHxt1a0XzU8etMhhxMwmMUrB7EW5wlIAtfxrqVbD8P/z3BKdPfP18vu5LHV205kxVFN9t
	OnMe/WuD/fREvQMJ66PlOUrpzS67VrG9Rn8STl3FVh2A/L+JMgDuhtfHANn6BtcPrtFJmQerOJxK8
	aUDZYaoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfaiy-0000000CRwj-3gwE;
	Thu, 29 Feb 2024 07:21:00 +0000
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfaiu-0000000CRtU-2xT2
	for linux-um@lists.infradead.org;
	Thu, 29 Feb 2024 07:20:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709191250; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=V/QiwEFi+hLqHtGYF26e8Bge+srwrBYJXlThf9c9akc=;
	b=QBcMm4xDIafd6P4zumpEopBYIW6Mi+L6e91INdSrThyp/RAn4j+s9+VD2TGIXZTwq+1mYN232QajVOq7+qdNxRMjeJR9GLXgSbUbOWEEm0gwvrrfpceoB/bLfBqPtsLoHtweNyg3jDc4IDh7a8c8c6LKzk5HA+4Jz6UTZJ48sEU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=35;SR=0;TI=SMTPD_---0W1SCLWW_1709191244;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W1SCLWW_1709191244)
          by smtp.aliyun-inc.com;
          Thu, 29 Feb 2024 15:20:45 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux.dev
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
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
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-um@lists.infradead.org,
	netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH vhost v3 00/19] virtio: drivers maintain dma info for premapped vq
Date: Thu, 29 Feb 2024 15:20:25 +0800
Message-Id: <20240229072044.77388-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
MIME-Version: 1.0
X-Git-Hash: e3a3e51d6b70
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240228_232057_624291_F23A536E 
X-CRM114-Status: GOOD (  12.03  )
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

As discussed:
http://lore.kernel.org/all/CACGkMEvq0No8QGC46U4mGsMtuD44fD_cfLcPaVmJ3rHYqRZxYg@mail.gmail.com

If the virtio is premapped mode, the driver should manage the dma info by self.
So the virtio core should not store the dma info.
So we can release the memory used to store the dma info.

But if the desc_extra has not dma info, we face a new question,
it is hard to get the dma info of the desc with indirect flag.
For split mode, that is easy from desc, but for the packed mode,
it is hard to get the dma info from the desc. And for hardening
the dma unmap is saft, we should store the dma info of indirect
descs.

So I introduce the "structure the indirect desc table" to
allocate space to store dma info with the desc table.

On the other side, we mix the descs with indirect flag
with other descs together to share the unmap api. That
is complex. I found if we we distinguish the descs with
VRING_DESC_F_INDIRECT before unmap, thing will be clearer.

Because of the dma array is allocated in the find_vqs(),
so I introduce a new parameter to find_vqs().

Note:
    this is on the top of
        [PATCH vhost v1] virtio: packed: fix unmap leak for indirect desc table
        http://lore.kernel.org/all/20240223071833.26095-1-xuanzhuo@linux.alibaba.com

Please review.

Thanks

v3:
    1. fix the conflict with the vp_modern_create_avq().

v2:
    1. change the dma item of virtio-net, every item have MAX_SKB_FRAGS + 2
        addr + len pairs.
    2. introduce virtnet_sq_free_stats for __free_old_xmit

v1:
    1. rename transport_vq_config to vq_transport_config
    2. virtio-net set dma meta number to (ring-size + 1)(MAX_SKB_FRGAS +2)
    3. introduce virtqueue_dma_map_sg_attrs
    4. separate vring_create_virtqueue to an independent commit



Xuan Zhuo (19):
  virtio_ring: introduce vring_need_unmap_buffer
  virtio_ring: packed: remove double check of the unmap ops
  virtio_ring: packed: structure the indirect desc table
  virtio_ring: split: remove double check of the unmap ops
  virtio_ring: split: structure the indirect desc table
  virtio_ring: no store dma info when unmap is not needed
  virtio: find_vqs: pass struct instead of multi parameters
  virtio: vring_create_virtqueue: pass struct instead of multi
    parameters
  virtio: vring_new_virtqueue(): pass struct instead of multi parameters
  virtio_ring: simplify the parameters of the funcs related to
    vring_create/new_virtqueue()
  virtio: find_vqs: add new parameter premapped
  virtio_ring: export premapped to driver by struct virtqueue
  virtio_net: set premapped mode by find_vqs()
  virtio_ring: remove api of setting vq premapped
  virtio_ring: introduce dma map api for page
  virtio_ring: introduce virtqueue_dma_map_sg_attrs
  virtio_net: unify the code for recycling the xmit ptr
  virtio_net: rename free_old_xmit_skbs to free_old_xmit
  virtio_net: sq support premapped mode

 arch/um/drivers/virtio_uml.c             |  31 +-
 drivers/net/virtio_net.c                 | 283 ++++++---
 drivers/platform/mellanox/mlxbf-tmfifo.c |  24 +-
 drivers/remoteproc/remoteproc_virtio.c   |  31 +-
 drivers/s390/virtio/virtio_ccw.c         |  33 +-
 drivers/virtio/virtio_mmio.c             |  30 +-
 drivers/virtio/virtio_pci_common.c       |  59 +-
 drivers/virtio/virtio_pci_common.h       |   9 +-
 drivers/virtio/virtio_pci_legacy.c       |  16 +-
 drivers/virtio/virtio_pci_modern.c       |  38 +-
 drivers/virtio/virtio_ring.c             | 698 ++++++++++++-----------
 drivers/virtio/virtio_vdpa.c             |  45 +-
 include/linux/virtio.h                   |  13 +-
 include/linux/virtio_config.h            |  48 +-
 include/linux/virtio_ring.h              |  82 +--
 tools/virtio/virtio_test.c               |   4 +-
 tools/virtio/vringh_test.c               |  28 +-
 17 files changed, 847 insertions(+), 625 deletions(-)

--
2.32.0.3.g01195cf9f


