Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96EBCEED63A
	for <linux-um@archiver.kernel.org>; Thu, 12 Sep 2024 18:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GlMyCZu9+Lsqxl/xIEpOnb3yyyCsAgN++PzCZFz7wRw=; b=EoIslYj68FKwb11I0bRZjznRAT
	YAH8TbAn1HuS9Vvn23ozXW13GvpSu/mFDyZw+qYtUsPXOkTb1kkTUPZhKmvm6UxNlbv2amkv55BTo
	xHr6F9f+IrEm8WFivRxY4UggS92jfBnntM4V1nDI8ymjhGMidX/O3fssn4w325yF/9RAMZ8djuifi
	xws1VgVSJupnEQ+eDgvAgykTMLC+nShEMh0RiyQSfr6PU39NUPRrNHMNLUf93X4Dg91D5qbxq2rKR
	HPbmI4GQGqEokPjLbFZlZ3NOssc9nWqEdPpApZmmMu30jVaPMginR4RDmDy3yHh/X+0yw4CLUDWxb
	aMInhBoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soooh-0000000Dxk9-0nJ1;
	Thu, 12 Sep 2024 18:45:19 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soogZ-0000000DweN-2Q2p
	for linux-um@bombadil.infradead.org;
	Thu, 12 Sep 2024 18:36:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=GlMyCZu9+Lsqxl/xIEpOnb3yyyCsAgN++PzCZFz7wRw=; b=Xqn7J6rYZqZmcicmqhhCo5Km34
	yuxcq7MHodaODL/pQKx6TzmpL+undXNoBeuTt1jmLE+S2aUrrLBWvqCH1KSvdHBfLgEQyUP2RHG7M
	lC42ZhDTWchkqnSiQcj5n8S6h3KgmC0hvltSvRlxoI5ircPW2LkulSlTjyFYZqpFoZBefjN46bDXl
	WNtz7wqrA6N0tT6VbLt36qYmJotq/gMHjsgB4BgExaDkwbY4TxOJJ/mJ2EzDwDSrLWgXMYl5F2x3T
	6N6XCg2isdYPm9RZkZsDy2LH1oNaPRX7wCu3ITw7f2SeyGSiPWw8XoJuZJJI5VlPYf17DAOyoWy3p
	nnEwq2RA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1soogX-00000009o66-0Opm;
	Thu, 12 Sep 2024 18:36:53 +0000
Date: Thu, 12 Sep 2024 19:36:52 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Richard Weinberger <richard@nod.at>
Cc: Li Zetao <lizetao1@huawei.com>,
	anton ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um <linux-um@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] hostfs: Convert hostfs_writepage to use folio
Message-ID: <ZuM0xHQqSpen_xxY@casper.infradead.org>
References: <20240820025045.13339-1-lizetao1@huawei.com>
 <731546887.37035.1726165368713.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <731546887.37035.1726165368713.JavaMail.zimbra@nod.at>
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

On Thu, Sep 12, 2024 at 08:22:48PM +0200, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
> > Von: "Li Zetao" <lizetao1@huawei.com>
> > An: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegreys.com>, "Johannes Berg"
> > <johannes@sipsolutions.net>
> > CC: lizetao1@huawei.com, "linux-um" <linux-um@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>
> > Gesendet: Dienstag, 20. August 2024 04:50:45
> > Betreff: [PATCH -next] hostfs: Convert hostfs_writepage to use folio
> 
> > convert to use folio, so that we can get rid of 'page->index' to
> > prepare for removal of 'index' field in structure page [1].

Ideally, we would not do this, instead converting hostfs to use
writepages instead of writepage.  I haven't done this work; would
someone like to do it?

> > static int hostfs_writepage(struct page *page, struct writeback_control *wbc)
> > {
> > -	struct address_space *mapping = page->mapping;
> > -	struct inode *inode = mapping->host;
> > +	struct folio *folio = page_folio(page);
> > +	struct address_space *mapping = folio->mapping;
> > +	struct inode *inode = folio_inode(folio);

Don't use folio_inode() here, leave it as it was.

> > -	if (page->index >= end_index)
> > +	if (folio->index >= end_index)
> > 		count = inode->i_size & (PAGE_SIZE-1);
> > 
> > -	buffer = kmap_local_page(page);
> > +	buffer = kmap_local_folio(folio, 0);

These two lines assume that hostfs remains a non-large-folio filesystem.
I'm not sure what the plans are for hostfs.


