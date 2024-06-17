Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98954C27C77
	for <linux-um@archiver.kernel.org>; Mon, 17 Jun 2024 04:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SlbhBELGZGAJu2VFwZ/I2ZGLJJVkDBqymt5pZ+CCoj8=; b=hOjSC22FlW9/UKsCqnM8esybqd
	/++Id/aYMbd9d+5KlrarDQ9omJ8Ym3YHsDFnh00rOmoeWYvA8tFXOhxf4gSz9FWqdjiz/k76bl5ai
	FJ1PGFrgszNyWXUNf3PPJf8V0kvB3ySFI5wYtI+jeYSJJ0MM/Lk+KxfQNYmJYKxw5CVNH1RV6GnuE
	l9RW4oNfEYXhLF6UZ8oleTym0XVHjytww8QUjlixE4jL9dmn3r6yIJt6jnCaB3Rxdo/tVNTWfM7r1
	ftI4rggWs/96SaSyxOOdjNQnZI+aYS73QBocKs7NjZVfoWnxNRFMvgJxIVIGDZJgVankxMUP9+WdM
	G79WkaOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJ4Ng-00000009A0I-2c4y;
	Mon, 17 Jun 2024 04:54:12 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJ4Nd-000000099y5-02tA;
	Mon, 17 Jun 2024 04:54:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EB40668B05; Mon, 17 Jun 2024 06:53:56 +0200 (CEST)
Date: Mon, 17 Jun 2024 06:53:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Richard Weinberger <richard@nod.at>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Josef Bacik <josef@toxicpanda.com>, Ming Lei <ming.lei@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
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
Subject: Re: [PATCH 02/26] sd: move zone limits setup out of
 sd_read_block_characteristics
Message-ID: <20240617045356.GA16277@lst.de>
References: <20240611051929.513387-1-hch@lst.de> <20240611051929.513387-3-hch@lst.de> <40ca8052-6ac1-4c1b-8c39-b0a7948839f8@kernel.org> <20240613093918.GA27629@lst.de> <5a697233-0611-459d-b889-2e0133bbb541@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a697233-0611-459d-b889-2e0133bbb541@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240616_215409_514253_8528D16C 
X-CRM114-Status: GOOD (  15.22  )
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

On Mon, Jun 17, 2024 at 08:01:04AM +0900, Damien Le Moal wrote:
> On 6/13/24 18:39, Christoph Hellwig wrote:
> > On Tue, Jun 11, 2024 at 02:51:24PM +0900, Damien Le Moal wrote:
> >>> +	if (sdkp->device->type == TYPE_ZBC)
> >>
> >> Nit: use sd_is_zoned() here ?
> > 
> > Actually - is there much in even keeping sd_is_zoned now that the
> > host aware support is removed?  Just open coding the type check isn't
> > any more code, and probably easier to follow.
> 
> Removing this helper is fine by me.

FYI, I've removed it yesterday, but not done much of the cleanups suggest
here.  We should probably do those in a follow up up, uncluding removing
the !ZBC check in sd_zbc_check_zoned_characteristics.


