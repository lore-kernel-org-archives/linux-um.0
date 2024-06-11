Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A101C25B76
	for <linux-um@archiver.kernel.org>; Tue, 11 Jun 2024 05:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bTeryOZFDpWKIAzHaXxAErZzQDziggFI7A4RWKacyro=; b=q8v5uGzn+x+AB4zr2Cb1T92Pmp
	GcOxxMGXTdtb/w/TngtAtCDdM/LrtHazR4ra3MatkH/KvSVxOvffbVzpUtfLFn6b11SLl/KmUCJGZ
	CqMxpYQGaHlvxVS29CcVNvH50bvx5DuGNGf6qcbUV1hspXns+MjGvmU1onG3d1uU8xGZJ4E2xUOc5
	TvcByhcRuzCLTMUv6iuqodaBCnrxxhdhe0499YS48p0m/0KPL8vOxnjdm9zCCF3s9XbGeYaYz0Llr
	Ihr1hZiLgklwubCiO0V/CYOxfh5ghzorfkPIBqr7ZZzJeMnUdOWDMRm/CVZEsyrMDbFQqt0j4Z13s
	X0lyXjAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGuXw-00000007buU-3KNH;
	Tue, 11 Jun 2024 05:59:52 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGuXt-00000007bsb-3PBG;
	Tue, 11 Jun 2024 05:59:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B1AFB68C4E; Tue, 11 Jun 2024 07:59:46 +0200 (CEST)
Date: Tue, 11 Jun 2024 07:59:46 +0200
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
Subject: Re: [PATCH 06/26] loop: also use the default block size from an
 underlying block device
Message-ID: <20240611055946.GA3777@lst.de>
References: <20240611051929.513387-1-hch@lst.de> <20240611051929.513387-7-hch@lst.de> <27e76310-1831-473e-803a-e0294b91463c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27e76310-1831-473e-803a-e0294b91463c@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_225950_028626_A54B9E7C 
X-CRM114-Status: GOOD (  11.12  )
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

On Tue, Jun 11, 2024 at 02:58:56PM +0900, Damien Le Moal wrote:
> > +	if (S_ISBLK(inode->i_mode))
> > +		backing_bdev = I_BDEV(inode);
> > +	else if (inode->i_sb->s_bdev)
> > +		backing_bdev = inode->i_sb->s_bdev;
> > +
> 
> Why not move this hunk inside the below "if" ? (backing_dev declaration can go
> there too).

Because another use will pop up a bit later :)


