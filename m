Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6C8C27C5E
	for <linux-um@archiver.kernel.org>; Tue, 11 Jun 2024 05:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TlR7PRp+u5hS4flrPhjEy1O/hrDwGDVPHXo9O/rdBRs=; b=o5l7G1T8HFneB/fnrtxjFkW/ol
	32bJGIDCZg3cb/iwA0PcR/n9hEDQOzTjLNR91Ppz44q/J0DF25jZ2ZDLiMI2ChgUMhDC/+tZ7Lkw9
	HtEew/X2IgHBPQoNNIuLSxHQnSZx7TjfmFUXDIziyq4Ypu35mWKy1fsJD1c7ffGtoegacvthWaC+G
	aKSr0optsu84IJPwfOQ9fHJ/fu3T9ERjxxJYpJNiKBb8eub8emaTngvSFRoXvU5P7w89O7i8XZolc
	P89jp5XT6e6jQ6vZ7iYfzMquAdHRToxMqj6zMeaA6YDLYE4Qo0X/ebQ5B+2PqPKc4mexdaTKEohaW
	/7Ef4WEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGuTE-00000007at3-0LuH;
	Tue, 11 Jun 2024 05:55:00 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGuTA-00000007aqg-1nh6;
	Tue, 11 Jun 2024 05:54:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A7EA968BEB; Tue, 11 Jun 2024 07:54:53 +0200 (CEST)
Date: Tue, 11 Jun 2024 07:54:53 +0200
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
Subject: Re: [PATCH 03/26] loop: stop using loop_reconfigure_limits in
 __loop_clr_fd
Message-ID: <20240611055453.GA3384@lst.de>
References: <20240611051929.513387-1-hch@lst.de> <20240611051929.513387-4-hch@lst.de> <ca5a3441-768a-4331-a1c2-a4bdadf2f150@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca5a3441-768a-4331-a1c2-a4bdadf2f150@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_225456_635718_24909E5A 
X-CRM114-Status: GOOD (  10.98  )
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

On Tue, Jun 11, 2024 at 02:53:19PM +0900, Damien Le Moal wrote:
> > +	/* reset the block size to the default */
> > +	lim = queue_limits_start_update(lo->lo_queue);
> > +	lim.logical_block_size = 512;
> 
> Nit: SECTOR_SIZE ? maybe ?

Yes.  I was following the existing code, but SECTOR_SIZE is probably
a better choice here.


