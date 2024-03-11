Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CFBC54E66
	for <linux-um@archiver.kernel.org>; Mon, 11 Mar 2024 07:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=B/vgOfJBc0D/jF4kmbmspaO6Yw6G39IlnXaT1uAqGck=; b=vDaoSsmE0wMjj5dQzqpHDVUYn3
	KS3sMzCw+6Iu9oTnC3KtkgcBAtmDxWCbg1f+qbMrwFztbs8XlrOqfkfmd2qlYgdnvmGGcUE6lt7oY
	kzcjjNymgVYyLCwR6QWyMBYd2uVM4Ml+ctYvFXxZbe4DweII6Y+vQjMpPXFbowWA4ogjEeyPzdN5m
	ym57HNFu9uDA8tLTxWCvSVcxsMS/DM3O2ADn0Y7S0Xjg/0eZeRbWfaeFexy07YZLqDlodyxuvLPOG
	HkYx60mYcbTxbe3bsnTZ98mlvARV4cwc3/Ae8YIbSt7Bqu8DHb3Y4r2/7wt3OIaP0jvsbTgJmQE3d
	KJhzGXPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjZyS-00000000Ta9-0gI7;
	Mon, 11 Mar 2024 07:21:28 +0000
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjZyM-00000000TXt-2H2Z
	for linux-um@lists.infradead.org;
	Mon, 11 Mar 2024 07:21:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710141676; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=B/vgOfJBc0D/jF4kmbmspaO6Yw6G39IlnXaT1uAqGck=;
	b=jDp2KdD4rmAGNnpqqX2zHsH1cEcqCKm5i8phd+CuU6IVMz70QJfvijJy7lIozsZEW7F8BRoiL3h6Iv3jpbhcfGwam2Jfldbh11Xnk82SeHbUsezm2tzI1Lnfro3gL0vhCIxa62EvZz4Nz/eVQwmIAQy9XizTblOr/T6p9thztEc=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=25;SR=0;TI=SMTPD_---0W2CL6Hl_1710141673;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W2CL6Hl_1710141673)
          by smtp.aliyun-inc.com;
          Mon, 11 Mar 2024 15:21:14 +0800
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
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-um@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH vhost v2 0/4] refactor the params of find_vqs()
Date: Mon, 11 Mar 2024 15:21:09 +0800
Message-Id: <20240311072113.67673-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
MIME-Version: 1.0
X-Git-Hash: a38f8a85b807
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240311_002123_150216_53CFF193 
X-CRM114-Status: UNSURE (   7.06  )
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

v2:
  1. add kerneldoc for "struct vq_transport_config" @ilpo.jarvinen

v1:
  1. fix some comments from ilpo.jarvinen@linux.intel.com


Xuan Zhuo (4):
  virtio: find_vqs: pass struct instead of multi parameters
  virtio: vring_create_virtqueue: pass struct instead of multi
    parameters
  virtio: vring_new_virtqueue(): pass struct instead of multi parameters
  virtio_ring: simplify the parameters of the funcs related to
    vring_create/new_virtqueue()

 arch/um/drivers/virtio_uml.c             |  31 ++--
 drivers/platform/mellanox/mlxbf-tmfifo.c |  24 ++--
 drivers/remoteproc/remoteproc_virtio.c   |  31 ++--
 drivers/s390/virtio/virtio_ccw.c         |  33 ++---
 drivers/virtio/virtio_mmio.c             |  30 ++--
 drivers/virtio/virtio_pci_common.c       |  60 ++++----
 drivers/virtio/virtio_pci_common.h       |   9 +-
 drivers/virtio/virtio_pci_legacy.c       |  16 ++-
 drivers/virtio/virtio_pci_modern.c       |  38 +++--
 drivers/virtio/virtio_ring.c             | 173 ++++++++---------------
 drivers/virtio/virtio_vdpa.c             |  45 +++---
 include/linux/virtio_config.h            |  77 ++++++++--
 include/linux/virtio_ring.h              |  93 +++++++-----
 tools/virtio/virtio_test.c               |   4 +-
 tools/virtio/vringh_test.c               |  28 ++--
 15 files changed, 359 insertions(+), 333 deletions(-)

--
2.32.0.3.g01195cf9f


