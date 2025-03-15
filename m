Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B361C35FF3
	for <linux-um@archiver.kernel.org>; Sat, 15 Mar 2025 16:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xvTDNWCr1bMNnKENyAX+tMPkf6SKgIIgvshxR2S18NU=; b=nyDCNk0XYgjrXv8FSQLorXoqAJ
	FYsoLK5M+94TYTkPZGL2gcCPjsiSG2F6j8WucqUB+FmurUGYkHeqHQknvrF2GB7IMNtri24urtjLg
	BuzSgXvhOvndQMxb3J/ah5sGXh8ZhJpwkKD5Wbmb3qpZeWR0pnWhei5K/E+yvpxXaUi0txy2QRuYT
	6HLHb4QtnyTenEHu10lgpgf+Zlm238msOQaIvh/8wys7OJFaMbpSbdJ96snQWnGGrarKpZtjuTFXz
	rH6MP/YQJG99681EIKhSiVwe4mpb3yMynEqv/tGSy2QFybgajJGPt6SbUUYZvQ4EKBE5GvcjkPqC1
	NNzKL+Gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ttUEc-0000000Gaxf-3Pg8;
	Sat, 15 Mar 2025 16:19:38 +0000
Received: from out0-199.mail.aliyun.com ([140.205.0.199])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ttUEZ-0000000GawP-0iL8
	for linux-um@lists.infradead.org;
	Sat, 15 Mar 2025 16:19:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1742055567; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=xvTDNWCr1bMNnKENyAX+tMPkf6SKgIIgvshxR2S18NU=;
	b=HSepvHDtiy14yQsEL94+lF5tasGu4WSkv/utY3RPeESgaMO+s1BE431pHupAEPXTrjrwR2p6p5bA/v7JOYWuUyAQwZ86D7/Y32uuP3fppnpgfFRqnje2ugZH3mZgG/yOe8WBsz0H826cQcODXns5v4n3GekXTTVUe9CURzECYqs=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.buVCVLq_1742055559 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 16 Mar 2025 00:19:25 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 0/3] um: Add VFIO-based PCI passthrough support
Date: Sun, 16 Mar 2025 00:19:07 +0800
Message-Id: <20250315161910.4082396-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250315_091935_733662_F766238F 
X-CRM114-Status: UNSURE (   9.77  )
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

This patchset adds a new virt-pci driver to UML that allows users to
pass through host PCI devices to UML via VFIO. Currently, only MSI-X
capable devices are supported, and drivers are assumed to use MSI-X.

This driver has been tested with virtio-net-pci, virtio-blk-pci and
nvme in a QEMU virtual machine with virtual IOMMU enabled. Regression
testing for virtio_pcidev has only covered compile tests and partial
virtio probe/remove tests with a dummy vhost-user backend.

Here are some steps to try out this driver:

1. Enable IOMMU and bind PCI devices to the vfio-pci driver.

2. Launch a UML instance directly (assuming that the PCI devices to
   be passed through to UML are 0000:02:00.0 and 0000:03:00.0).

 $ ./linux mem=2G init=/bin/sh ubd0=$your_rootfs_image \
           vfio_uml.device=0000:02:00.0 \
           vfio_uml.device=0000:03:00.0

Note that, currently, it's not possible to allocate a large amount of
"physical" memory to the UML instance; otherwise, it may overlap with
IOMMU-reserved IOVA ranges (e.g. [0xfee00000, 0xfef00000)), causing
DMA mapping failures.

This patchset is based on the following patchset:
https://lore.kernel.org/all/20250306150747.2926434-1-tiwei.btw@antgroup.com/

v1:
- Add more details in the commit log;

RFC: https://lore.kernel.org/all/20250310074057.3977758-1-tiwei.btw@antgroup.com/

Tiwei Bie (3):
  um: Rewrite the sigio workaround based on epoll and tgkill
  um: virt-pci: Refactor virtio_pcidev into its own module
  um: Add VFIO-based virtual PCI driver

 arch/um/drivers/Kconfig         |  20 +-
 arch/um/drivers/Makefile        |   5 +-
 arch/um/drivers/random.c        |   2 +-
 arch/um/drivers/rtc_user.c      |   2 +-
 arch/um/drivers/vfio_kern.c     | 648 +++++++++++++++++++++++++++++
 arch/um/drivers/vfio_user.c     | 323 +++++++++++++++
 arch/um/drivers/vfio_user.h     |  44 ++
 arch/um/drivers/virt-pci.c      | 699 ++++++--------------------------
 arch/um/drivers/virt-pci.h      |  41 ++
 arch/um/drivers/virtio_pcidev.c | 628 ++++++++++++++++++++++++++++
 arch/um/include/shared/os.h     |   2 +-
 arch/um/include/shared/sigio.h  |   1 -
 arch/um/kernel/sigio.c          |  26 --
 arch/um/os-Linux/sigio.c        | 330 ++-------------
 14 files changed, 1866 insertions(+), 905 deletions(-)
 create mode 100644 arch/um/drivers/vfio_kern.c
 create mode 100644 arch/um/drivers/vfio_user.c
 create mode 100644 arch/um/drivers/vfio_user.h
 create mode 100644 arch/um/drivers/virt-pci.h
 create mode 100644 arch/um/drivers/virtio_pcidev.c

-- 
2.34.1


