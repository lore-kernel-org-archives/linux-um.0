Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7257ECDE008
	for <linux-um@archiver.kernel.org>; Fri, 26 Jun 2026 05:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=tSjT7eGYckASYqUHi0sczUGvF3
	KHSsRzdU5NLdNdtAehADjqG9bSMIYHzJ1kxQBvPNNwH+ZUH2QOYdJwgJt46CaXHgdPbVDgX6YCaoe
	b1628KWenLYHFnqXx5vYqvQDX9bgbA/4KZpwRKJL0a8/IkUQpItw/LUvHdw0QXXzan1QLmoB2ao2k
	WlovFfvzV1rWzxs6wXqQeDURRMTTCmtJqZ5/1DJQjkW7P65CwGgSqKH9dtQZVF3cFzOtk8txYKjVJ
	+T45KShYokob+BbteSJMKsPdxj9t7gAUUucMnLgWpzG4iKIm0+Vc1L/K0/YvH5tg2SAnotYw2rcvA
	7ukW8rBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wczIi-0000000AX2H-0uYw;
	Fri, 26 Jun 2026 05:40:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wczIg-0000000AX1i-0JoZ
	for linux-um@lists.infradead.org;
	Fri, 26 Jun 2026 05:40:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8ECF868B05; Fri, 26 Jun 2026 07:40:23 +0200 (CEST)
Date: Fri, 26 Jun 2026 07:40:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: x86@kernel.org, linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 7/8] lib/raid/xor: x86: Remove redundant
 X86_FEATURE_OSXSAVE check
Message-ID: <20260626054023.GB9629@lst.de>
References: <20260626043731.319287-1-ebiggers@kernel.org> <20260626043731.319287-8-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626043731.319287-8-ebiggers@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260625_224026_257743_1D2C5A3E 
X-CRM114-Status: UNSURE (   7.92  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


