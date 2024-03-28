Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB049C54E64
	for <linux-um@archiver.kernel.org>; Thu, 28 Mar 2024 08:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RRwgpt8H+JeOfUF5M0fnLgI8P6UgcZIx9pzBvnK+1IM=; b=3+cqtwCgx6gVap02YbpLzeu9QN
	NodtoFvCO3yYqq2fbLYNAfSB8dVJapd1XPWMKTFxSka4zf11b+SDQYg6gAHLbjJ7G6sFDh9d+bRtG
	XZnoLFroqN9jPqrMxvsKBPBApeiSTBgftFq8h2LpKRIUqkqkzUzudBqZH/0UDzj6JjV5v3rBTyy7l
	I9Og9Dhl+sYaWj343qlFEh0Qn1ZlUEskUgS/qJ4pb+ENVyl+k7TaZdKWgyCKOppYWG6nH45FaEIYq
	OKsa3M5E3cQLTi/BKrRiYZ/EdQIKdhH1tuljzpy2ZKBCZwb65vxrbjzSbJkHGrSt9LknizeBkccOf
	w3GKyLOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpkjy-0000000D09z-0wAZ;
	Thu, 28 Mar 2024 08:04:02 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpkjt-0000000D034-07EG
	for linux-um@lists.infradead.org;
	Thu, 28 Mar 2024 08:03:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711613032; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=RRwgpt8H+JeOfUF5M0fnLgI8P6UgcZIx9pzBvnK+1IM=;
	b=HRcpcgSFVsQ61v/iyCjLPH3joHNru1WTqpKM+X1zVk0cxzKIWRzVsBy4POAJvLg5hehehpfbSBQAVIZyP1yH1z2q5SA3vrriwff3kr3/koEtoc+sN2lRv/LvzPKVtwvYtbLKvKjE+t4ZyyCSDURoR5e/dZVknnfb9RJ6VvUlnGg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=26;SR=0;TI=SMTPD_---0W3Sg6Fp_1711613029;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3Sg6Fp_1711613029)
          by smtp.aliyun-inc.com;
          Thu, 28 Mar 2024 16:03:50 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux.dev
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
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
	"Michael S. Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-um@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH vhost v7 0/6] refactor the params of find_vqs()
Date: Thu, 28 Mar 2024 16:03:42 +0800
Message-Id: <20240328080348.3620-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Git-Hash: fc2c3bb8a235
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_010357_604123_27DBC692 
X-CRM114-Status: UNSURE (   8.11  )
X-CRM114-Notice: Please train this message.
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

This pathset is splited from the

     http://lore.kernel.org/all/20240229072044.77388-1-xuanzhuo@linux.alibaba.com

That may needs some cycles to discuss. But that notifies too many people.

But just the four commits need to notify so many people.
And four commits are independent. So I split that patch set,
let us review these first.

The patch set try to  refactor the params of find_vqs().
Then we can just change the structure, when introducing new
features.

Thanks.

v7:
  1. fix two bugs. @Jason

v6:
  1. virtio_balloon: a single variable for both purposes.
  2. if names[i] is null, return error

v5:
  1. virtio_balloon: follow David Hildenbrand's suggest
    http://lore.kernel.org/all/3620be9c-e288-4ff2-a7be-1fcf806e6e6e@redhat.com
  2. fix bug of the reference of "cfg_idx"
    http://lore.kernel.org/all/202403222227.Sdp23Lcb-lkp@intel.com

v4:
  1. remove support for names array entries being null
  2. remove cfg_idx from virtio_vq_config

v3:
  1. fix the bug: "assignment of read-only location '*cfg.names'"

v2:
  1. add kerneldoc for "struct vq_transport_config" @ilpo.jarvinen

v1:
  1. fix some comments from ilpo.jarvinen@linux.intel.com







Xuan Zhuo (6):
  virtio_balloon: remove the dependence where names[] is null
  virtio: remove support for names array entries being null.
  virtio: find_vqs: pass struct instead of multi parameters
  virtio: vring_create_virtqueue: pass struct instead of multi
    parameters
  virtio: vring_new_virtqueue(): pass struct instead of multi parameters
  virtio_ring: simplify the parameters of the funcs related to
    vring_create/new_virtqueue()

 arch/um/drivers/virtio_uml.c             |  36 +++--
 drivers/platform/mellanox/mlxbf-tmfifo.c |  23 +--
 drivers/remoteproc/remoteproc_virtio.c   |  37 +++--
 drivers/s390/virtio/virtio_ccw.c         |  38 ++---
 drivers/virtio/virtio_balloon.c          |  48 +++----
 drivers/virtio/virtio_mmio.c             |  36 +++--
 drivers/virtio/virtio_pci_common.c       |  69 ++++-----
 drivers/virtio/virtio_pci_common.h       |   9 +-
 drivers/virtio/virtio_pci_legacy.c       |  16 ++-
 drivers/virtio/virtio_pci_modern.c       |  37 +++--
 drivers/virtio/virtio_ring.c             | 173 ++++++++---------------
 drivers/virtio/virtio_vdpa.c             |  51 ++++---
 include/linux/virtio_config.h            |  76 +++++++---
 include/linux/virtio_ring.h              |  93 +++++++-----
 tools/virtio/virtio_test.c               |   4 +-
 tools/virtio/vringh_test.c               |  28 ++--
 16 files changed, 382 insertions(+), 392 deletions(-)

--
2.32.0.3.g01195cf9f


