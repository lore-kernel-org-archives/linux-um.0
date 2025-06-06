Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E22C61DB2
	for <linux-um@archiver.kernel.org>; Fri,  6 Jun 2025 12:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=v1o3Y756hneMoIzpsZS2BT1VddlgiBGLAQ5qB0tg/bo=; b=FQuWXcjAFSRFW8Ew+tVy637ZuW
	Qzv/xd2dtbQVqg55xpDUGpUzEsvDZLvFIbPEuu5C75J8eMRLk/RLXCFhtz2PD7f7GRDXpb1RQ65aG
	Oz3h20Ri2PjmpiIxrTF8Jg/upOkOWXAp7wcQa4Gu6E5eHsP3q0lonX+BY9SoGexyRc/PXUesrEvbH
	OR3TF718pH5STnSCiKlineV1DRDVvV88jOokAmUYvtvjFvdkSVoan1ndadJZZNRXk5Bq0ro5mzsYY
	QH8kHq30/3q8uwol3eeC2lF4hxE1DS/zSFcpT7jx87vzKeDdJecn56WOKGK7vlgdyfNQ5GLYrXL3/
	kESynyOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNWRN-00000000GzJ-2Ook;
	Fri, 06 Jun 2025 12:44:57 +0000
Received: from out0-221.mail.aliyun.com ([140.205.0.221])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNWRJ-00000000Gnx-43Sp
	for linux-um@lists.infradead.org;
	Fri, 06 Jun 2025 12:44:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1749213886; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=v1o3Y756hneMoIzpsZS2BT1VddlgiBGLAQ5qB0tg/bo=;
	b=XDxPGqNxVskNZNEAegYW5AS+ltCdja3+yTC1UhXZYHGeF+y7XMh7czs0a7E132XYKUmxYGGYa9Qv5JfbgtCHv0PhNZCglr12e7n9mCVSDx48hRnTBLmpaURUetr3ZfdPxRmWpxuthmAgtUF4BJpF+EurJMb2c2qobWwfTXmFlCM=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.dD3Yx.R_1749213875 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 06 Jun 2025 20:44:42 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 0/4] um: Misc fixes
Date: Fri, 06 Jun 2025 20:44:24 +0800
Message-Id: <20250606124428.148164-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250606_054454_482646_7C5C733B 
X-CRM114-Status: UNSURE (   5.45  )
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

Tiwei Bie (4):
  um: ubd: Add missing error check in start_io_thread()
  um: virtio_pcidev: Rename UM_PCI_STAT_WAITING
  um: vfio: Prevent duplicate device assignments
  um: Use correct data source in fpregs_legacy_set()

 arch/um/drivers/ubd_user.c      |  2 +-
 arch/um/drivers/vfio_kern.c     | 14 ++++++++++++++
 arch/um/drivers/virtio_pcidev.c |  8 ++++----
 arch/x86/um/ptrace.c            |  2 +-
 4 files changed, 20 insertions(+), 6 deletions(-)

-- 
2.34.1


