Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B56C48291
	for <linux-um@archiver.kernel.org>; Fri,  2 Feb 2024 09:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=peR8A4izAqgzsimxR/4ieXlIWtvCe7qrSUa+LFRRffU=; b=4pqQjIbpYO4Qt4+xuDLYQx12Rd
	5DyDPkbCafBGtDSIFIFZexaz114Rc2iTESiM5YX8yGlNHrFBwcddOdSigveQYj7KbjrAsVB/l9Odc
	8TdEhogA2jwhxSMx1y+Xz5DQJoOT99ye7JEp4v9ac8svZ/s/glAh8BfIjTmvBHCZWZAxs2HhkgKYb
	qRBK24XrXU6JoeT2z90cKUaTXPy4PwlZWUKo9zbmnq5evn/SDAtYRQND44LCBQQvaWL7qY3q/i5R+
	AXtj6HBQPnlCLn8gzmKG7EvI3XqpnKftysPCGoD16ImPT5qf25Svkm4xJC9zZVBp7o9fU39nParIi
	Qx32RLOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVq1j-0000000B0L8-3PZq;
	Fri, 02 Feb 2024 09:40:03 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVq1f-0000000B0Hq-34Mp
	for linux-um@lists.infradead.org;
	Fri, 02 Feb 2024 09:40:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706866795; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=peR8A4izAqgzsimxR/4ieXlIWtvCe7qrSUa+LFRRffU=;
	b=f9pJDUkyCq9Aq7iTJ9WEJiy8LiYP6i88lIIhl3oDW8hhrXP4ozIdAS/NyASNTJRBE3M1TdInxJIDAJw8cQMFLkqGX+eYEIewot3x9jCKDTuM/MqDSIJESIFgLNNHBU1vloze/iFsv71nqaRoPaXPunIco9sEkwiEOCdyu5mHYAs=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=36;SR=0;TI=SMTPD_---0W.wc6kr_1706866791;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.wc6kr_1706866791)
          by smtp.aliyun-inc.com;
          Fri, 02 Feb 2024 17:39:52 +0800
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
	Benjamin Berg <benjamin.berg@intel.com>,
	linux-um@lists.infradead.org,
	netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH vhost v1 00/19] virtio: drivers maintain dma info for premapped vq
Date: Fri,  2 Feb 2024 17:39:32 +0800
Message-Id: <20240202093951.120283-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
MIME-Version: 1.0
X-Git-Hash: 4c7bacd05cb8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240202_013959_966824_754869EF 
X-CRM114-Status: GOOD (  10.61  )
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

Please review.

Thanks

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
  virtio_ring: reuse the parameter struct of find_vqs()
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
 drivers/net/virtio_net.c                 | 291 +++++++---
 drivers/platform/mellanox/mlxbf-tmfifo.c |  24 +-
 drivers/remoteproc/remoteproc_virtio.c   |  31 +-
 drivers/s390/virtio/virtio_ccw.c         |  33 +-
 drivers/virtio/virtio_mmio.c             |  30 +-
 drivers/virtio/virtio_pci_common.c       |  59 +-
 drivers/virtio/virtio_pci_common.h       |   9 +-
 drivers/virtio/virtio_pci_legacy.c       |  16 +-
 drivers/virtio/virtio_pci_modern.c       |  24 +-
 drivers/virtio/virtio_ring.c             | 698 ++++++++++++-----------
 drivers/virtio/virtio_vdpa.c             |  45 +-
 include/linux/virtio.h                   |  13 +-
 include/linux/virtio_config.h            |  48 +-
 include/linux/virtio_ring.h              |  82 +--
 tools/virtio/virtio_test.c               |   4 +-
 tools/virtio/vringh_test.c               |  28 +-
 17 files changed, 848 insertions(+), 618 deletions(-)

--
2.32.0.3.g01195cf9f


