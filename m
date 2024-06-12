Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AA7C27C53
	for <linux-um@archiver.kernel.org>; Wed, 12 Jun 2024 15:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8g5RuG5vzLyx15pAARj76I7+Ubgo01o3nP0FIwUsoIo=; b=QtR6Nrun/8HV0giav1fUvx7oIL
	ePwvng0YRKcoVtljFXtLZHVy2+gJRCJiKN7S9pyOan157P5/KeGibR30QnKIkVslZGWhkDEP7WDO6
	7KKfDU/Xg5hF96qpz/Pi8KMs5rb7zKori+TkMV++MXDEVfnA6m9jYKD5d+XPcq7WPpv27eESidga2
	DbHpwTxGKrgAca8g8bb2bvRe6fcESzU095LZIW8KK+uh42Oa6zUJNLhu+TCHArPNqBL19Cl3FLrQW
	icnZrCp3umJt8aGzX/YeUH3i+xRQamgp0oQLuKdOhT2IwCR+mmYqTo1liwoz3TT4JEF/MGxByZGnH
	8HcYvKJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHPSs-0000000D3pK-2YW2;
	Wed, 12 Jun 2024 15:00:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHPSm-0000000D3je-1bZS;
	Wed, 12 Jun 2024 15:00:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9E11668AFE; Wed, 12 Jun 2024 17:00:30 +0200 (CEST)
Date: Wed, 12 Jun 2024 17:00:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Richard Weinberger <richard@nod.at>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Josef Bacik <josef@toxicpanda.com>, Ming Lei <ming.lei@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
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
Subject: Re: [PATCH 10/26] xen-blkfront: don't disable cache flushes when
 they fail
Message-ID: <20240612150030.GA29188@lst.de>
References: <20240611051929.513387-1-hch@lst.de> <20240611051929.513387-11-hch@lst.de> <ZmlVziizbaboaBSn@macbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmlVziizbaboaBSn@macbook>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_080036_588385_C610925B 
X-CRM114-Status: GOOD (  22.35  )
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

On Wed, Jun 12, 2024 at 10:01:18AM +0200, Roger Pau Monné wrote:
> On Tue, Jun 11, 2024 at 07:19:10AM +0200, Christoph Hellwig wrote:
> > blkfront always had a robust negotiation protocol for detecting a write
> > cache.  Stop simply disabling cache flushes when they fail as that is
> > a grave error.
> 
> It's my understanding the current code attempts to cover up for the
> lack of guarantees the feature itself provides:

> So even when the feature is exposed, the backend might return
> EOPNOTSUPP for the flush/barrier operations.

How is this supposed to work?  I mean in the worst case we could
just immediately complete the flush requests in the driver, but
we're really lying to any upper layer.

> Such failure is tied on whether the underlying blkback storage
> supports REQ_OP_WRITE with REQ_PREFLUSH operation.  blkback will
> expose "feature-barrier" and/or "feature-flush-cache" without knowing
> whether the underlying backend supports those operations, hence the
> weird fallback in blkfront.

If we are just talking about the Linux blkback driver (I know there
probably are a few other implementations) it won't every do that.
I see it has code to do so, but the Linux block layer doesn't
allow the flush operation to randomly fail if it was previously
advertised.  Note that even blkfront conforms to this as it fixes
up the return value when it gets this notsupp error to ok.

> Overall blkback should ensure that REQ_PREFLUSH is supported before
> exposing "feature-barrier" or "feature-flush-cache", as then the
> exposed features would really match what the underlying backend
> supports (rather than the commands blkback knows about).

Yes.  The in-tree xen-blkback does that, but even without that the
Linux block layer actually makes sure flushes sent by upper layers
always succeed even when not supported.


