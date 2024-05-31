Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AD0C25B75
	for <linux-um@archiver.kernel.org>; Fri, 31 May 2024 06:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+oSRivoHERW9JkWCGM6Z1/ZgP9/vqgXaR/iTPe0s1Ww=; b=KUPhPEEQmMptEHcWW74FEjOKaQ
	KF2TX0a4fJrNfdyPkuow6Nxne9LNovY3nT3ZCY50lPL8PVx92IyhIHtdk6h+7PCRyyX0rZLN43i0H
	pxjjsDn7epKwRh8pq+HKD0NjjLfSMS9zu/kPPlmDq8jf9f/vdPOewoZ7E1DzURayD0F7DHTXusmJ3
	H0CPJHyiIYpsjgCUlKdLEIbheaOse6B2HKN6Q71mhbKhwIAri+GZE8LFLrSw6QUTMe3GEwKGvRts8
	PgvzyMPJf3Ypvd59e0o1nxU+uVhLzNWeQDJ5LoAw1pX5gBW37sGWXuCZftxMu7TdeDTmtZ76cMNr3
	cDVN3zFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCwBQ-00000009RNF-3l9K;
	Fri, 31 May 2024 06:56:12 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCwBO-00000009RMh-0jnV
	for linux-um@lists.infradead.org;
	Fri, 31 May 2024 06:56:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CC83168BEB; Fri, 31 May 2024 08:56:00 +0200 (CEST)
Date: Fri, 31 May 2024 08:56:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Josef Bacik <josef@toxicpanda.com>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	Roger Pau Monn?? <roger.pau@citrix.com>,
	linux-um@lists.infradead.org, linux-block@vger.kernel.org,
	nbd@other.debian.org, ceph-devel@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 02/12] block: take io_opt and io_min into account for
 max_sectors
Message-ID: <20240531065600.GA18681@lst.de>
References: <20240529050507.1392041-1-hch@lst.de> <20240529050507.1392041-3-hch@lst.de> <CAOi1vP-F0FO4WTnrEt7FC-uu2C8NTbejvJQQGdZqT475c2G1jA@mail.gmail.com> <20240531055456.GC17396@lst.de> <CAOi1vP-VXeOH-kShRKv-b=id1zN9tLiqOo8EKpOWoJuQp_Pm1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOi1vP-VXeOH-kShRKv-b=id1zN9tLiqOo8EKpOWoJuQp_Pm1g@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_235610_385531_0D40D6B1 
X-CRM114-Status: GOOD (  12.52  )
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

On Fri, May 31, 2024 at 08:48:12AM +0200, Ilya Dryomov wrote:
> We should revert io_opt from opts->alloc_size to objset_bytes (I think
> it's what you meant to say but typoed).

Yes, sorry.

> How do you want to handle it?  I can put together a patch, send it to
> ceph-devel and it will be picked by linux-next sometime next week.  Then
> this patch would grow a contextual conflict and the description would
> need to be updated to not mention a behavior change for rbd anymore.

If that works for you I'd much prefer to include it with this series.
I'd be happy to write it myself.


