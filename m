Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D1AC7EE31
	for <linux-um@archiver.kernel.org>; Tue,  6 Jun 2023 08:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tbpM6YCLMCRanQq/fnXxmkXQyplcqvebTmhwCxoFI/A=; b=xWkylWRMSfwFYb
	l/ORfpFggCABGp9zZKzZyMLbfSG9ytwuLfyKYOlfgcheWTwiPxZQgbwPTEr+B6JfK9diJSn9kM1Pm
	yvUbbG/X31CVG2Klmy0fqXi3dw/FknOPO+Y+e21Maw3u0hbjcchwWJd6KNt5DjhGn1CahnX64DBv4
	H7JZhhADd7H1wzwP3iQGUCCvesmU5anKV0j1tGC+zK7P+mmbXh79Z+1El+MhCM0Y00YWJ81y9IJax
	w5eObazhEHVlpbpkgxAJVJW+wgu3R9NqUUiBD8X/8NrjGFhefCzIYQuueAB14rFOx9pbzbq6cBASN
	GqBjU8gn2MKKtjA4utNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6SK2-000rFr-18;
	Tue, 06 Jun 2023 08:45:46 +0000
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1q6RJx-000aH6-0p;
	Tue, 06 Jun 2023 07:41:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Richard Weinberger <richard@nod.at>,
	Josef Bacik <josef@toxicpanda.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Phillip Potter <phil@philpotter.co.uk>,
	Coly Li <colyli@suse.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	dm-devel@redhat.com,
	linux-block@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 31/31] fs: remove the now unused FMODE_* flags
Date: Tue,  6 Jun 2023 09:39:50 +0200
Message-Id: <20230606073950.225178-32-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230606073950.225178-1-hch@lst.de>
References: <20230606073950.225178-1-hch@lst.de>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

FMODE_NDELAY, FMODE_EXCL and FMODE_WRITE_IOCTL were only used for
block internal purposed and are now entirely unused, so remove them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/fs.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index ad1d2c9afb3fa4..8045c7ef4000c2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -119,13 +119,6 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 #define FMODE_PWRITE		((__force fmode_t)0x10)
 /* File is opened for execution with sys_execve / sys_uselib */
 #define FMODE_EXEC		((__force fmode_t)0x20)
-/* File is opened with O_NDELAY (only set for block devices) */
-#define FMODE_NDELAY		((__force fmode_t)0x40)
-/* File is opened with O_EXCL (only set for block devices) */
-#define FMODE_EXCL		((__force fmode_t)0x80)
-/* File is opened using open(.., 3, ..) and is writeable only for ioctls
-   (specialy hack for floppy.c) */
-#define FMODE_WRITE_IOCTL	((__force fmode_t)0x100)
 /* 32bit hashes as llseek() offset (for directories) */
 #define FMODE_32BITHASH         ((__force fmode_t)0x200)
 /* 64bit hashes as llseek() offset (for directories) */
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
