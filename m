Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A75C282DE
	for <linux-um@archiver.kernel.org>; Mon, 10 Mar 2025 07:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LsAukRC4i0Y8KRah3NxPhKAanFF6SxQlWqKWfkx6t3Y=; b=LkH0ijRD5xWWe5j5oEuK6WKdtc
	F33djEAFTzitGimM749hS2PmrGgfqXjtYuz/L3FJRzviJa88u+8Ns97IyOVZsZ4uDpCLLykkPadLE
	IVN0IO5g2oPXRcIkh5l1U9Ja7GM1S1LVgcryjSUC/msYjuOYsbPq+hfyM1R0oA0pPl15WH8+R4i9B
	MKNyUNbdGP27YtKSQa84i6GaFpXaJSAWJYrUiF0ImZNgl4RRVjzojewVCA9g14Mbb5O9XeUM+iR37
	UKd48thn8HfBA0/PnPOf9+dkgjS12NN4NlDcme+Z5Wvj+EjEkOBDv9n0GruA4K8P/82w2RVg0yb8X
	G/BqP/PQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trXnj-00000001mve-2HYJ;
	Mon, 10 Mar 2025 07:43:51 +0000
Received: from out0-214.mail.aliyun.com ([140.205.0.214])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trXlC-00000001mXG-2SkK
	for linux-um@lists.infradead.org;
	Mon, 10 Mar 2025 07:41:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1741592468; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=LsAukRC4i0Y8KRah3NxPhKAanFF6SxQlWqKWfkx6t3Y=;
	b=ZyyGk4SI5yM/d87uKTXhp+tvf7cjJKo1Pkq/iqROD/cLnJ959XcXNyeWtKU0Nx/DnXOKuQcRJ2VQaM1iIXo/NdQuPPYAG8avJgYkFm9QD+2Hmq+irWJi1sdZv2sYaIw312FBVxTrZeOr3UNN8nSvGmsvSgEmkC7o4H2tA44VIPg=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.bp9kbdC_1741592460 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 10 Mar 2025 15:41:06 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [RFC PATCH 0/3] um: Add VFIO-based PCI passthrough support
Date: Mon, 10 Mar 2025 15:40:54 +0800
Message-Id: <20250310074057.3977758-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250310_004115_135416_1A986FFE 
X-CRM114-Status: UNSURE (   8.10  )
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
testing for virtio_pcidev has been limited as I haven't been able to
find a virtio_pcidev vhost-user backend implementation.

This patchset is based on the following patchset:
https://lore.kernel.org/all/20250306150747.2926434-1-tiwei.btw@antgroup.com/

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


