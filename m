Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E03C3064D
	for <linux-um@archiver.kernel.org>; Tue,  2 Jul 2024 07:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yRJduJ4b13YGEVnBaImf8MBMoj+rPcyZfPfJ5uybrn0=; b=4ws0KXcned3Dn8ILOlsqqG8c8M
	Y0S+/LT4TxsYhnoFJnEOAExQrwBUL+v1L/+LMwv0fBG/RXx7YPaqio5cFe9cDVWNOZ76gBHOQ2ha1
	CiBcnNiTzy9xJGknZd0HoYBHg6soCqB5OtFfNQWuyEAzTSx5IjVSvk8vPwy6Zz1piIRSzeIUdwQq1
	8Zt6oTxqiLCcae0mKolYzZwvuyv9SJmgFeb+gOywI94CTWk0f5lq18FvvSC2jSM9PIo2cXbJDEDx6
	gG9NTkSl6UwCyCqHsSgRcIEBwYfv65CXQm/gIWFLTJCuCmXhfXD46S8kCusJdRosi0NkMaPXaKiiu
	duFRelxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOXzm-00000005s6H-2smR;
	Tue, 02 Jul 2024 07:32:10 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOXzk-00000005s56-0D5a;
	Tue, 02 Jul 2024 07:32:08 +0000
Date: Tue, 2 Jul 2024 00:32:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Jens Axboe <axboe@kernel.dk>,
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
Message-ID: <ZoOs9wdR1yBPB-7J@infradead.org>
References: <202406250948.e0044f1d-oliver.sang@intel.com>
 <ZnqGf49cvy6W-xWf@infradead.org>
 <Znt4qTr/NdeIPyNp@xsang-OptiPlex-9020>
 <ZnuNhkH26nZi8fz6@infradead.org>
 <ZnzP+nUrk8+9bANK@xsang-OptiPlex-9020>
 <ZnzwbYSaIlT0SIEy@infradead.org>
 <ZoJnO09LBj6kApY7@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoJnO09LBj6kApY7@xsang-OptiPlex-9020>
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

On Mon, Jul 01, 2024 at 04:22:19PM +0800, Oliver Sang wrote:
> from below, it seems the patchset doesn't introduce any performance improvement
> but a regression now. is this expected?

Not having the improvement at least alleviate my concerns about data
integrity.  I'm still curious where it comes from as it isn't exactly
expected.


