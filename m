Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A39C53219
	for <linux-um@archiver.kernel.org>; Tue, 28 Jul 2026 03:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zcISkZrkhxCtl6AVbUTUJqsi5MmFJa+RTncRXpQ5qI4=; b=HxVluy9ZYz+axcrnmud8Ug4akK
	l2xdw1oFaA6GHCwU7Z+Lcy6Gm9OpDecr+K387sHczOk6VMR1rK8iTZWUXKY8CuFYN+sAmqnHDnaqE
	PD8dOdRBH+fYoPmQ2XBat/D7OwMareziJUTrK/aHF4b1WObSjJSjaSM7egVqsf9zi0d8+tE3MgdBC
	l/LB6cvcngXwfqHB9Pc+06E/cxzp7XVel5hMkkOSnZM3MZc9k+mK9ICquOOnTJY/y1zXhIg9nAwgK
	c3U6bZmCuJWTPNg5Uqlr0Kiu3iDHlz9cravkZBo5xbqYNdvgoB2f3aD4oFjbbGzpU+IvvtfHvfYB3
	iR7pPi0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woYjj-00000004LG8-0xw2;
	Tue, 28 Jul 2026 03:44:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woYjh-00000004LFn-0INm
	for linux-um@lists.infradead.org;
	Tue, 28 Jul 2026 03:44:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BF36368AFE; Tue, 28 Jul 2026 05:44:04 +0200 (CEST)
Date: Tue, 28 Jul 2026 05:44:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: x86@kernel.org, linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH v2 8/8] lib/raid/xor: x86: Add AVX-512 optimized
 xor_gen()
Message-ID: <20260728034404.GE18902@lst.de>
References: <20260728021603.79870-1-ebiggers@kernel.org> <20260728021603.79870-9-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728021603.79870-9-ebiggers@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260727_204409_262984_FB204C90 
X-CRM114-Status: UNSURE (   7.86  )
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

Stick to the xor: prefix here as well please.


