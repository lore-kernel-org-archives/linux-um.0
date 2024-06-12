Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8BAC27C53
	for <linux-um@archiver.kernel.org>; Wed, 12 Jun 2024 05:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2eTtg+apIvpzWCygfIvXjIBO/25LyPrdxg++Wsa42Bg=; b=sIFOTea5Kdgmvnr189emDZxjg/
	PFGSD65xf274JHTL3BJwjbjWCCYoa81NTIkcP6B2gWIupLrfp8WLf/NZRyWAde9//Jm6oMuj/araf
	1JYTF79CIgVVq2jE7P+6zzgijzuTMM6jMdVf6H5DZJMD/c1EC2BpS5aQFSGipa7oJPANgFd6bR705
	f8fc+PbreMjYNbt8R+Oj25HSTPn5YzleIr9qklIbPGj/GgXBCsTtEar9WM/hnJpHeLX17w1Y1zy/9
	8p/CAiVYvDsf8bCBG3a2h/dREfBNNMHbq3U0jE6arm6DuIEWR7iZGYAnH+JEx7I0B51wUm7IjilZQ
	MGWmIudQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHG6q-0000000B5We-1Z8w;
	Wed, 12 Jun 2024 05:01:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHG6m-0000000B5Vq-3EBs;
	Wed, 12 Jun 2024 05:01:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 775D868C4E; Wed, 12 Jun 2024 07:01:10 +0200 (CEST)
Date: Wed, 12 Jun 2024 07:01:09 +0200
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
Subject: Re: [PATCH 19/26] block: move the nowait flag to queue_limits
Message-ID: <20240612050109.GA26959@lst.de>
References: <20240611051929.513387-1-hch@lst.de> <20240611051929.513387-20-hch@lst.de> <4845aae8-ad03-407e-bf31-f164b8f684d4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4845aae8-ad03-407e-bf31-f164b8f684d4@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_220116_973941_515E8163 
X-CRM114-Status: GOOD (  11.86  )
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

On Tue, Jun 11, 2024 at 05:16:37PM +0900, Damien Le Moal wrote:
> > @@ -1825,9 +1815,7 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
> >  	int r;
> >  
> >  	if (dm_table_supports_nowait(t))
> > -		blk_queue_flag_set(QUEUE_FLAG_NOWAIT, q);
> > -	else
> > -		blk_queue_flag_clear(QUEUE_FLAG_NOWAIT, q);
> > +		limits->features &= ~BLK_FEAT_NOWAIT;
> 
> Shouldn't you set the flag here instead of clearing it ?

No, but the dm_table_supports_nowait check needs to be inverted.
 

