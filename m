Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4CBC27C4F
	for <linux-um@archiver.kernel.org>; Wed, 26 Jun 2024 03:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q35hat2STPhlr4DAn4+ABXn/NxJWaK5wgb5DlM6xpCg=; b=rjcnqpFPqCHjFi/Q/uKFTOjPT8
	f/3pYh1CkhkyZm34p5SdJ3nYju1fE+irIzetedXF6r2HiSrQDypkMKqsvecQBVKf+DrQp/azlX3wx
	P/npqnrSDgj6xqpKanoV4wSVv5XocGQ/XEqVSpu7ZfbTAkIcKxYrsABTqOqioYkxWEquhRAkoSqh/
	lFDXmshX6TMAQCSNHKw10Ze2N9gR+I+u1ajXV4xCgS9gEUV/wcGX48JFtJzFTNSxNr6XmHTIq4fr/
	OhaMnkz8lH5/58b6f8ddBySwV8umC41WWsLXOYJsACaGN6eACN5WbQqje/rPyj4ywzdNhymtN1ltN
	aADdg+Yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMJVi-00000005EdQ-1nhO;
	Wed, 26 Jun 2024 03:39:54 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMJVe-00000005Ecx-3HCZ;
	Wed, 26 Jun 2024 03:39:50 +0000
Date: Tue, 25 Jun 2024 20:39:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>, Christoph Hellwig <hch@lst.de>,
	oe-lkp@lists.linux.dev, lkp@intel.com, Jens Axboe <axboe@kernel.dk>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org, linux-um@lists.infradead.org,
	drbd-dev@lists.linbit.com, nbd@other.debian.org,
	linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux.dev,
	xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
	nvdimm@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, ying.huang@intel.com,
	feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [axboe-block:for-next] [block]  1122c0c1cc:  aim7.jobs-per-min
 22.6% improvement
Message-ID: <ZnuNhkH26nZi8fz6@infradead.org>
References: <202406250948.e0044f1d-oliver.sang@intel.com>
 <ZnqGf49cvy6W-xWf@infradead.org>
 <Znt4qTr/NdeIPyNp@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Znt4qTr/NdeIPyNp@xsang-OptiPlex-9020>
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

On Wed, Jun 26, 2024 at 10:10:49AM +0800, Oliver Sang wrote:
> I'm not sure I understand this test request. as in title, we see a good
> improvement of aim7 for 1122c0c1cc, and we didn't observe other issues for
> this commit.

The improvement suggests we are not sending cache flushes when we should
send them, or at least just handle them in md.

> do you mean this improvement is not expected or exposes some problems instead?
> then by below patch, should the performance back to the level of parent of
> 1122c0c1cc?
> 
> sure! it's our great pleasure to test your patches. I noticed there are
> [1]
> https://lore.kernel.org/all/20240625110603.50885-2-hch@lst.de/
> which includes "[PATCH 1/7] md: set md-specific flags for all queue limits"
> [2]
> https://lore.kernel.org/all/20240625145955.115252-2-hch@lst.de/
> which includes "[PATCH 1/8] md: set md-specific flags for all queue limits"
> 
> which one you suggest us to test?
> do we only need to apply the first patch "md: set md-specific flags for all queue limits"
> upon 1122c0c1cc?
> then is the expectation the performance back to parent of 1122c0c1cc?

Either just the patch in reply or the entire [2] series would be fine.

Thanks!


