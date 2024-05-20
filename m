Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B069C25B79
	for <linux-um@archiver.kernel.org>; Mon, 20 May 2024 15:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FM6Di0WLmMMq8YahgRhRsJZgZG5Vzs66qBjSKEkyVWY=; b=nw/5TxJ0OmAdUr9oU29lUgLKUE
	+mKOvsVHz4ScQfc4wkigp++b3g7LimZUd6nuDZ+q19dy6xoDd1ZRZwgZoBg3nk0KmLbxE5B5k2xn1
	kV/8xXZTnV6I1f22kcpT+4NelG0g29gT0isfULIkeP3NEb3SUm/Y+BgRQitCuVUgfWZ7z3UFVccdb
	wzbkgK2RbecJ6FjYBTiGZzFFcJICWQyMrGVJWaFMIl/Ywlw7zg8OGitO5E5cB5woXVOOD/1NeNq86
	aGF4NmqzT0r7rNfHvjeanEMe2COwKbcrfcw1L+OBzHeCKMaNj27QYgYHW62xv7kPO95czuu6q7tcu
	iT/4B1HQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s94oz-0000000Ep7T-1WEg;
	Mon, 20 May 2024 15:21:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s94ov-0000000Ep4p-0oEI
	for linux-um@lists.infradead.org;
	Mon, 20 May 2024 15:21:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0FBE768BFE; Mon, 20 May 2024 17:20:50 +0200 (CEST)
Date: Mon, 20 May 2024 17:20:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: Christoph Hellwig <hch@lst.de>, richard@nod.at,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ubd: Remove unused mutex 'ubd_mutex'
Message-ID: <20240520152049.GB398@lst.de>
References: <20240505001508.255096-1-linux@treblig.org> <20240506070648.GA6506@lst.de> <ZktoVIG500he350_@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZktoVIG500he350_@gallifrey>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240520_082101_400042_5C1A5E11 
X-CRM114-Status: UNSURE (   9.59  )
X-CRM114-Notice: Please train this message.
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

On Mon, May 20, 2024 at 03:12:20PM +0000, Dr. David Alan Gilbert wrote:
> * Christoph Hellwig (hch@lst.de) wrote:
> > Looks good:
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Thanks Christoph; any ideas who might take this?

Probably Richard who is alredy on Cc.


