Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55007C25B7E
	for <linux-um@archiver.kernel.org>; Fri, 31 May 2024 05:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fz4Bv4M5AAT14OTvNn8yFGaSkoztSkte1YX9/kljUAw=; b=YnazTGI2NmQPg2iOoGF6dIF3/Z
	oAaUNcypJ9qPk48WYPPPQAeKsEBRj+iXgD0FjfcZg5V9GfTHjDfUmgeV8rGTyac+mGgLdjZMFiaQK
	V065gAsDMF0H3MCWP85QIH9hBdNP+T9ZU1SGt+yIPgFtq5ORiLGcQpiDhchD+rzjmAFdUYl3FTPfY
	P2mIpf1dRh6m3pZNDCJxFrEusvTcK5SPPuuuBFzx6Mg0cCu9ZX8eIouz2KFOIUn8Im5yZiNIUPZdN
	YnLHAnTsq6La90vrtA91MR1D6Y1Wx/z3YsqFy4aanyB5SwIgo7APrHHLTcd71SQzbuZzpwIEYSWJb
	5/9Gr/ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCvEJ-00000009Jaj-47WH;
	Fri, 31 May 2024 05:55:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCvEG-00000009Ja8-1bkw
	for linux-um@lists.infradead.org;
	Fri, 31 May 2024 05:55:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D3CD568BFE; Fri, 31 May 2024 07:54:56 +0200 (CEST)
Date: Fri, 31 May 2024 07:54:56 +0200
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
Message-ID: <20240531055456.GC17396@lst.de>
References: <20240529050507.1392041-1-hch@lst.de> <20240529050507.1392041-3-hch@lst.de> <CAOi1vP-F0FO4WTnrEt7FC-uu2C8NTbejvJQQGdZqT475c2G1jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOi1vP-F0FO4WTnrEt7FC-uu2C8NTbejvJQQGdZqT475c2G1jA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_225504_590510_E77DA6FF 
X-CRM114-Status: GOOD (  19.02  )
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

On Thu, May 30, 2024 at 09:48:06PM +0200, Ilya Dryomov wrote:
> For rbd, this change effectively lowers max_sectors from 4M to 64K or
> less and that is definitely not desirable.  From previous interactions
> with users we want max_sectors to match max_hw_sectors -- this has come
> up a quite a few times over the years.  Some people just aren't aware
> of the soft cap and the fact that it's adjustable and get frustrated
> over the time poured into debugging their iostat numbers for workloads
> that can send object (set) size I/Os.
> 
> Looking at the git history, we lowered io_opt from objset_bytes to
> opts->alloc_size in commit [1], but I guess io_opt was lowered just
> along for the ride.  What that commit was concerned with is really
> discard_granularity and to a smaller extent io_min.
> 
> How much difference does io_opt make in the real world?  If what rbd
> does stands in the way of a tree-wide cleanup, I would much rather bump
> io_opt back to objset_bytes (i.e. what max_user_sectors is currently
> set to).

The only existing in-kernel usage is to set the readahead size.
Based on your comments I seems like we should revert io_opt to
objset to ->alloc_size in a prep patch?


