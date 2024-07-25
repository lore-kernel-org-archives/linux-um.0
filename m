Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691E3C3DA49
	for <linux-um@archiver.kernel.org>; Thu, 25 Jul 2024 13:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TOmpyDcm1CthrtcJk0B6SRkKyBUOYq6t4Cca/cnKfwU=; b=4IYQ92oWTWaXOhkiMZxYYCM455
	kNFgF1PHizAIXUs9CFuBIwwGRF9VhA5Au3llf/qrFxeeOLOFndCC8AusoPwnFrZd9NlQ8YLTcYbqJ
	aS31kl7XXDvZj9ny1xJ2dL9fm29XS7ujyj7JmJKCGp0mDPcGCwovxYGY5w7v8gGrJ+VUdEbRVFSHt
	LdYyKl2wkZZqkS2S5XwUawcqqY6AV0VZbC3RRsNmHqar7eCh6cHM1FUKohxbqAaDBs1uHOOF2Txz7
	CS3zS7g7GDZVSl8/VZXA3xqXKbqh9mtdGW8Oi2FISzt8ttFeDcLnEp4at1rnpNAinxGa9lfbB6w62
	bPr6XKRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWy5D-000000010M1-2jaA;
	Thu, 25 Jul 2024 13:00:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWy52-000000010Fw-29Nf;
	Thu, 25 Jul 2024 13:00:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C4CD1227A8E; Thu, 25 Jul 2024 15:00:09 +0200 (CEST)
Date: Thu, 25 Jul 2024 15:00:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Wouter Verhelst <w@uter.be>
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
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 14/26] block: move the nonrot flag to queue_limits
Message-ID: <20240725130008.GA22625@lst.de>
References: <20240617060532.127975-1-hch@lst.de> <20240617060532.127975-15-hch@lst.de> <ZqI4kosy20WkLC2P@pc220518.home.grep.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqI4kosy20WkLC2P@pc220518.home.grep.be>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240725_060024_819639_08BB032A 
X-CRM114-Status: GOOD (  14.37  )
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

On Thu, Jul 25, 2024 at 01:35:46PM +0200, Wouter Verhelst wrote:
> NBD actually exports a flag for rotational devices; it's defined in
> nbd.h in the NBD userland source as
> 
> #define NBD_FLAG_ROTATIONAL     (1 << 4)        /* Use elevator algorithm - rotational media */
> 
> which is passed in the same flags field which also contains the
> NBD_FLAG_SEND_FLUSH and NBD_FLAG_SEND_FUA flags.
> 
> Perhaps we might want to look at that flag and set the device to
> rotational if it is specified?

Yes, that sounds good.  Can you send a patch?


