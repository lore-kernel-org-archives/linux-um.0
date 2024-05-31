Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D55A7C25B75
	for <linux-um@archiver.kernel.org>; Fri, 31 May 2024 12:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bVrFouBxNqnIkfq/4jNpLG9EcFBPuVt2joGYYI3zvnM=; b=e4jReO92ASaBU11PKyvVIFuVWf
	mHwXLtV5fA/8pGGwtQLXgjXmBPvEWC73tDFFcCoNz/tcw/D5ag+Hl2fta7EyncBXpTnmX0Q53MCJw
	xd66xW7x5Esm3qSiyaaPyq153LXdl2eI37esfnKIaAl3hyCvcG4pne51W+XvT8InP2I6vPLZHYAll
	MsiFAsWbikIeOldPTfjIBwcYkg0JRhdMV6KKVMJo1tTRbkj6pOofMsZr7flS/+ajmPAXHeSuIGcUb
	yIrSRo7DcHqQmI6RfFJx1bXA4pr7HIXzewoGbVeNk2Z8pK2ovQbNY8UxYABjKKAE6SDzGlCc989XQ
	ZUKhBoxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD1Ik-0000000ABEE-19SE;
	Fri, 31 May 2024 12:24:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD1Ih-0000000ABCe-0Ctm
	for linux-um@lists.infradead.org;
	Fri, 31 May 2024 12:24:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5085768BFE; Fri, 31 May 2024 14:23:56 +0200 (CEST)
Date: Fri, 31 May 2024 14:23:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Josef Bacik <josef@toxicpanda.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	Roger Pau Monn?? <roger.pau@citrix.com>,
	linux-um@lists.infradead.org, linux-block@vger.kernel.org,
	nbd@other.debian.org, ceph-devel@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org
Subject: Re: convert the SCSI ULDs to the atomic queue limits API v2
Message-ID: <20240531122356.GA24343@lst.de>
References: <20240531074837.1648501-1-hch@lst.de> <yq17cfadwd0.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq17cfadwd0.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240531_052403_268761_EA4F9267 
X-CRM114-Status: GOOD (  13.25  )
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

On Fri, May 31, 2024 at 08:07:54AM -0400, Martin K. Petersen wrote:
> If you have other block layer changes depending on this series we'll
> probably need a shared branch. I'll need to make several changes to sd.c
> to fix reported issues, including a couple in the zeroing/discard
> department.

Yes, I also want to move the various feature flags that currently
abususe queue->flags into the queue limits.  In the worst case I could
delay that for another merge window, but a shared branch would be
a lot nicer.


