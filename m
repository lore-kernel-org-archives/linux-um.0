Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53656C27C44
	for <linux-um@archiver.kernel.org>; Fri, 31 May 2024 07:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=X6ZSIyh1cBG1UFDOkvLStzuDyEP+AFeCGGHYkP7yPXE=; b=T5CHrrgzsXSDWl6KKD+QB3klae
	/7ZrPYf1xTbn2ZDlh1lV+KM8gXQsizcOVVjXqUooOz7nefRw61+mCTHDwmu+ssRNRR0VP0fIzAzqU
	bkssmQolgd1k2xe8znFsnfZb83yE9mTfBvtoDSyVD9eJygRrOWcZU28/JEyrTJ3yE4peRceoEDrsa
	z6g3phrTCsIAY64kdBLjrp4Dtfmr2cwZEK6AaR2TKvie5ISrX6Dugs9U844uGLwstJj7BiJfIAW6E
	xyYl2fWmEQVWrDA/a06Rkzl2Lnl1gx2Jo/QpcjFRI0QCkF6HIgsHqGPDcYhZxVFBg1BAZJlKKnzQu
	svzBZ17w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCx0L-00000009XWd-0IT5;
	Fri, 31 May 2024 07:48:49 +0000
Received: from 2a02-8389-2341-5b80-5ba9-f4da-76fa-44a9.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:5ba9:f4da:76fa:44a9] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCx0C-00000009XUr-41fW;
	Fri, 31 May 2024 07:48:43 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Josef Bacik <josef@toxicpanda.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	linux-um@lists.infradead.org,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	ceph-devel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-scsi@vger.kernel.org
Subject: convert the SCSI ULDs to the atomic queue limits API v2
Date: Fri, 31 May 2024 09:47:55 +0200
Message-ID: <20240531074837.1648501-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi all,

this series converts the SCSI upper level drivers to the atomic queue
limits API.

The first patch is a bug fix for ubd that later patches depend on and
might be worth picking up for 6.10.

The second patch changes the max_sectors calculation to take the optimal
I/O size into account so that sd, nbd and rbd don't have to mess with
the user max_sector value.  I'd love to see a careful review from the
nbd and rbd maintainers for this one!

The following patches clean up a few lose ends in the sd driver, and
then convert sd and sr to the atomic queue limits API.  The final
patches remove the now unused block APIs, and convert a few to be
specific to their now more narrow use case.

The patches are against Jens' block-6.10 tree.  Due to the amount of
block layer changes in here, and other that will depend on it, it
would be good if this could eventually be merged through the block
tree, or at least a shared branch between the SCSI and block trees.

Changes since v1:
 - change the io_opt value for rbd
 - fix a left-over direct assignent to q->limits
 - add a new patch to refactor the ubd interrupt handler
 - use an else if to micro-optimize the ubd error handling
 - also remove disk_set_max_open_zones and disk_set_max_active_zones
 - use SECTOR_SHIFT in one more place
 - various spelling fixes
 - comment formating fix

Diffstat:
 arch/um/drivers/ubd_kern.c   |   50 +++------
 block/blk-settings.c         |  238 +------------------------------------------
 drivers/block/nbd.c          |    2 
 drivers/block/rbd.c          |    3 
 drivers/block/xen-blkfront.c |    4 
 drivers/scsi/sd.c            |  222 ++++++++++++++++++++--------------------
 drivers/scsi/sd.h            |    6 -
 drivers/scsi/sd_zbc.c        |   27 ++--
 drivers/scsi/sr.c            |   42 ++++---
 include/linux/blkdev.h       |   52 +++------
 10 files changed, 210 insertions(+), 436 deletions(-)

