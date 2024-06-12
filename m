Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784C9C27C53
	for <linux-um@archiver.kernel.org>; Wed, 12 Jun 2024 04:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R/Oorwj8U7soC4tSMKrO6rikT2iGvWWw4aa2QVYh2Mk=; b=bHzQp13eAbfF3gIL9jkErumUEw
	FmLW+0SHi6Gn6VPVTdS9Wjcig+4L/FNE9rGMt4AXUxKMFxjrSC4JoIL4kFx/qNONLQ6RzK8uUDr+k
	H9g5HeUm8gMWLMn1Zol+bxmh/SDN0m1TnXCNAg/mg0ujAz5Cl3tSKLguZ7trwF3zmZOvffZIoc9TY
	A5kcmnyqWAFjHSM0Gk2GSt8zfGq6QlVk4Wc81cAXCS5A0yhS3pvaaB4tnOiI0ge04SVCNOu9gCqYS
	dYjjOE3q/q8dObeE4RJ1AYFGxGnZkbnpzIDPZrAwZPl6+esA/bXnX9S0lvicuDkbBALHiaJI5v5dV
	rPeG6CTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHG0K-0000000B4gz-0Nl8;
	Wed, 12 Jun 2024 04:54:36 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHG0G-0000000B4gA-1IyH;
	Wed, 12 Jun 2024 04:54:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6904768BEB; Wed, 12 Jun 2024 06:54:29 +0200 (CEST)
Date: Wed, 12 Jun 2024 06:54:29 +0200
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
Subject: Re: [PATCH 13/26] block: move cache control settings out of
 queue->flags
Message-ID: <20240612045429.GB26776@lst.de>
References: <20240611051929.513387-1-hch@lst.de> <20240611051929.513387-14-hch@lst.de> <d21b162a-1fd3-4fd1-a17f-f127f964bdf1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d21b162a-1fd3-4fd1-a17f-f127f964bdf1@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_215432_547905_B03232BD 
X-CRM114-Status: GOOD (  13.96  )
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

On Tue, Jun 11, 2024 at 04:55:04PM +0900, Damien Le Moal wrote:
> On 6/11/24 2:19 PM, Christoph Hellwig wrote:
> > Move the cache control settings into the queue_limits so that they
> > can be set atomically and all I/O is frozen when changing the
> > flags.
> 
> ...so that they can be set atomically with the device queue frozen when
> changing the flags.
> 
> may be better.

Sure.

If there was anything below I've skipped it after skipping over two
pages of full quotes.


