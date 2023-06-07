Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB19C7EE29
	for <linux-um@archiver.kernel.org>; Wed,  7 Jun 2023 12:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G+sDmS8qDtOih8Hz0HeEYfXz7hU8vBs/kGelyL/kgCY=; b=g58Iy3akqS8O3w
	Vynsi4Rw7/yY4p3N+rvgvkhLXpGiXr5nyqP6i6cdCKZzFI0ZK9I26Lbt9ktCckCKfZ+cCVEozTDms
	aaZZqccnohRTm6Msw68G+fXWw6Vo3bbkuI7kq1rbw6u072BjgGaxTcTY/jwR6HsiBiK4rXMcXByoz
	Ck/cT+C0rvXgS3CEpg85JxchP89hHsEYTw/HbpHRzRPJ2Ohq54WMRpErr4uvctUw6L5x+6GrIa8sU
	izRiwDQiqU1V6qa9ON43yRYxKmnO8XKyTRchhQb5/u7ttyygWugURsbUqqn27HI1pACTJpeD9hHKY
	Uk+CxCqj1zxW/AOazHLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6s7u-005pff-19;
	Wed, 07 Jun 2023 12:18:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6s7q-005pd4-0L;
	Wed, 07 Jun 2023 12:18:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AC1196732D; Wed,  7 Jun 2023 14:18:50 +0200 (CEST)
Date: Wed, 7 Jun 2023 14:18:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Richard Weinberger <richard@nod.at>,
	Josef Bacik <josef@toxicpanda.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Phillip Potter <phil@philpotter.co.uk>, Coly Li <colyli@suse.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
	linux-block@vger.kernel.org, linux-um@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 30/31] block: store the holder in file->private_data
Message-ID: <20230607121850.GA14396@lst.de>
References: <20230606073950.225178-1-hch@lst.de> <20230606073950.225178-31-hch@lst.de> <20230607-verjagen-weise-4fb3d76a6313@brauner>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230607-verjagen-weise-4fb3d76a6313@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_051854_289769_D6D87729 
X-CRM114-Status: GOOD (  18.61  )
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

On Wed, Jun 07, 2023 at 11:24:55AM +0200, Christian Brauner wrote:
> On Tue, Jun 06, 2023 at 09:39:49AM +0200, Christoph Hellwig wrote:
> > Store the file struct used as the holder in file->private_data as an
> > indicator that this file descriptor was opened exclusively to  remove
> > the last use of FMODE_EXCL.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> 
> Feels a bit odd to store the object itself but anyway,
> Acked-by: Christian Brauner <brauner@kernel.org>

We could literally store anything we want.  The only reason I picked the
file is because: a) we have it around and b) that allows passing it
to blkdev_put without a branch in blkdev_release.

If you prefer something else I can change it.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
