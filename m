Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B38CD11DF
	for <linux-um@archiver.kernel.org>; Wed, 27 Mar 2024 09:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+jwn1CT7zNZoh3SNKYQ4fGkb0KdZ0cZLNqkBdEmkfNY=; b=YhNw3aRD/vH111miT5uQNjbm3G
	yNQ6mbwTsztvJU1nlGAyO8z5SrEPF/2OlpWorPneJc09QUDycFrDo5M7SK3dfEZ+/mSHXPIrv53eb
	i524LzMWtjbk7C/Ts+7QMzflytrQGzCGp5oD9rf2WjTJZvz6wOihU4ezFuwrd3Xk2CgDdqTb8vpY+
	tc1TpnB/7A7zu9rk8R6hwF5Dq8+X6xemFvm91BMaMrHW9IRRHMO/Hwthet1NEffgyzDEH653y3vg+
	pfEBxcpBtSu0/Hn2NeZ/+hWJgfeZR3wxIR56Swd3xhjqwt3pG3Lc1qzHo82F7xrMYMZuAjkE2lXTu
	WDgpeF1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpQ2d-00000008Iyq-3k2Q;
	Wed, 27 Mar 2024 09:57:55 +0000
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpQ2Y-00000008IuR-2iDr
	for linux-um@lists.infradead.org;
	Wed, 27 Mar 2024 09:57:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711533465; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=+jwn1CT7zNZoh3SNKYQ4fGkb0KdZ0cZLNqkBdEmkfNY=;
	b=HvaOMH071nOAdFnuvCM4FGzjuCiG5cx2qJ8aIGRSAmILpfT9S5gYT/BKXV6xwV8vyknTJhF+BCj8VAP7FxYhEtaZPOZuasGhjE3Zu0UFB8HzKzOv1EOi7/hPcu8mYz5JrGv5pYLtYXY3TBF0xk7OUQMm1Lm6dIpfPv/DrN95ymU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=26;SR=0;TI=SMTPD_---0W3OOYg9_1711533461;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3OOYg9_1711533461)
          by smtp.aliyun-inc.com;
          Wed, 27 Mar 2024 17:57:42 +0800
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
Subject: [PATCH vhost v6 0/6] refactor the params of find_vqs()
Date: Wed, 27 Mar 2024 17:57:35 +0800
Message-Id: <20240327095741.88135-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Git-Hash: f3c3b67ebbb4
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_025751_138527_A10F8AD4 
X-CRM114-Status: UNSURE (   8.17  )
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


