Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9E1C27C5E
	for <linux-um@archiver.kernel.org>; Tue, 11 Jun 2024 05:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZFkiA7a2TeiDh3d0WMWpjTzJ9ahZn80L20bwLnNnJlg=; b=y57/eQ015EXjOe3xTqtiABtsxa
	aizGt2Pqm6eaWqMYTLIhRCIOyyHHJY6X+UC/8lW4XWMiph5we7l6uXXvG2ZbX4tlJbw5v4CoSL3P6
	rpKUz8K+cjkv/tQ1QkpLiDE0RtJ4gha3jL5SjqghhifI9+2IDSifehIYpC1Px9jHKDzkwUF1yLwjA
	BGIrE6yH+XEUFfaIDEALwuMhnjyGz/SSZxFVSkzmcLQTxO4+O3TK/J0cI9qzwaiOjsxs9ewy7t38r
	SiWjWebk+Uz88greblvXcQRScClQhJKoAPyGxTwa/okuA/B/ZTYv+7lYohRMCaQvGkNACb2bm9CnM
	6ehAoo9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGuXL-00000007bgK-13fA;
	Tue, 11 Jun 2024 05:59:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGuXH-00000007be2-2gNL;
	Tue, 11 Jun 2024 05:59:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B7C0F68CFE; Tue, 11 Jun 2024 07:59:06 +0200 (CEST)
Date: Tue, 11 Jun 2024 07:59:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Richard Weinberger <richard@nod.at>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph B??hmwalder <christoph.boehmwalder@linbit.com>,
	Josef Bacik <josef@toxicpanda.com>, Ming Lei <ming.lei@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Roger Pau Monn?? <roger.pau@citrix.com>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-m68k@lists.linux-m68k.org, linux-um@lists.infradead.org,
	drbd-dev@lists.linbit.com, nbd@other.debian.org,
	linuxppc-dev@lists.ozlabs.org, ceph-devel@vger.kernel.org,
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
	linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org, nvdimm@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 05/26] loop: regularize upgrading the lock size for
 direct I/O
Message-ID: <20240611055906.GA3640@lst.de>
References: <20240611051929.513387-1-hch@lst.de> <20240611051929.513387-6-hch@lst.de> <dabc33cd-feb9-4263-8f6e-4d2ab3d71430@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dabc33cd-feb9-4263-8f6e-4d2ab3d71430@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_225912_066603_A8897FA1 
X-CRM114-Status: GOOD (  11.91  )
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

On Tue, Jun 11, 2024 at 02:56:59PM +0900, Damien Le Moal wrote:
> > +	if (!bsize)
> > +		bsize = loop_default_blocksize(lo, inode->i_sb->s_bdev);
> 
> If bsize is specified and there is a backing dev used with direct IO, should it
> be checked that bsize is a multiple of bdev_logical_block_size(backing_bdev) ?

For direct I/O that check would be useful.  For buffered I/O we can do
read-modify-write cycles.  However this series is already huge and not
primarily about improving the loop driver parameter validation, so
I'll defer this for now.

