Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA81C4345F
	for <linux-um@archiver.kernel.org>; Wed, 24 Apr 2024 09:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cYH6nuPV+ukxc4q3ctbCjioUc9rbgmodHni+uxe6ecQ=; b=qnfhUdDWrbXSTzCJVefr3caGrz
	1XlQKd8+QTV5sTU1ya488uJekyxdkFt0F871gcHZbYWBlPpmQeoGMTG4+BL9j5XH2oA3yDDgtAbeh
	WpB5FGL9+1iHl/2ayE7Md+eAcX675ZwkAfIaCaJbq7HVuNtz+kdVQTYjKt/YfMDZMZp8LxUDs+KvA
	wG0b91VuGd0j/DkbZC+MAJucd0DfOIgIB1cNVQIjLjBLBg7jcgJIxgOrxBuPRmpcFXTdFOezGR5mD
	/FK8uh1kvWbW97sJN2Za3GxqaFsrSCXVWDvsISeV9G3dL8f4IcSBDj9rJO8Z4dpoRx+r2JghhI3Q0
	EC9TyhnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzYjA-00000003SSL-0Axi;
	Wed, 24 Apr 2024 09:15:44 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzYj5-00000003SNX-0h56
	for linux-um@lists.infradead.org;
	Wed, 24 Apr 2024 09:15:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713950136; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=cYH6nuPV+ukxc4q3ctbCjioUc9rbgmodHni+uxe6ecQ=;
	b=a3LTDPm6Kj6ndGbHcZyvvaDUw3olXRYr3W1eiQJkp2HfVqkEeKA+PcLIOhlslpuTXif26VeQEV7NdEpvUAMG5FAaNMpUG3QK4peQhXP4iVBS5z4yJPP3GYNfHXL9UdvSsG3rbTv3K6qSa7elDk0L56Ln0qQeb+Z6UqgQYuh0P44=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=26;SR=0;TI=SMTPD_---0W5BsEmF_1713950133;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W5BsEmF_1713950133)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 17:15:34 +0800
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
Subject: [PATCH vhost v9 0/6] refactor the params of find_vqs()
Date: Wed, 24 Apr 2024 17:15:27 +0800
Message-Id: <20240424091533.86949-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Git-Hash: bdb00f35db89
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_021539_407177_50D00653 
X-CRM114-Status: UNSURE (   8.51  )
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

v8:
  1. rebase the vhost branch

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
 drivers/virtio/virtio_balloon.c          |  48 +++---
 drivers/virtio/virtio_mmio.c             |  36 +++--
 drivers/virtio/virtio_pci_common.c       |  69 ++++-----
 drivers/virtio/virtio_pci_common.h       |   9 +-
 drivers/virtio/virtio_pci_legacy.c       |  16 +-
 drivers/virtio/virtio_pci_modern.c       |  37 +++--
 drivers/virtio/virtio_ring.c             | 177 ++++++++---------------
 drivers/virtio/virtio_vdpa.c             |  51 +++----
 include/linux/virtio_config.h            |  76 +++++++---
 include/linux/virtio_ring.h              |  93 +++++++-----
 tools/virtio/virtio_test.c               |   4 +-
 tools/virtio/vringh_test.c               |  28 ++--
 16 files changed, 384 insertions(+), 394 deletions(-)

-- 
2.32.0.3.g01195cf9f


