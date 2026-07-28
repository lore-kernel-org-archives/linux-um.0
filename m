Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FC3C531F9
	for <linux-um@archiver.kernel.org>; Tue, 28 Jul 2026 03:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hhgRhGArrVtTP2LqGzn/+hkznDNMa8RwY/fTzBi4mWI=; b=zHIPqHcwFy+qT9YdJS5ZNKvEKp
	FKfGG1X/yXyPwG16oQ4Lq9yY/hCCrLqRW0QPTcUHx5zgjid+uG5Fn5j3pTdftjBNYg+v6Dx49EVS5
	ZZ5Yd76ovqN4mED1VD2A7w9HyD/WsrEvBZBnOCg1ziz7j4TUvfuvGgN9JwggiWFsm3qkpVI4v+OQE
	DorI/T8fzTSG3Kqs0dx9zhic4WwF1KX4g3I3SYxzwwaP1bd8JelHY+6RYWaOEWxWY2+SgtARiMNjS
	DJ6K5CTbkbX/GiXwcP2Qmeyi+m82q+FZeDV9+6lYlEWL9kvjiFYl5Z3OmERbO/cxDqdS+xIz5tKfe
	bdg5OubA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woYkN-00000004LMF-1JnC;
	Tue, 28 Jul 2026 03:44:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woYkL-00000004LKw-04zm
	for linux-um@lists.infradead.org;
	Tue, 28 Jul 2026 03:44:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5704F68AFE; Tue, 28 Jul 2026 05:44:46 +0200 (CEST)
Date: Tue, 28 Jul 2026 05:44:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: x86@kernel.org, linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 0/8] x86: Remove cpu_has_xfeatures() and add AVX-512
 xor_gen()
Message-ID: <20260728034445.GF18902@lst.de>
References: <20260728021603.79870-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728021603.79870-1-ebiggers@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260727_204449_207839_8730D1B9 
X-CRM114-Status: UNSURE (   8.53  )
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

The whole approach looks nice from the user POV:

Acked-by: Christoph Hellwig <hch@lst.de>

I'll leave it to the x86 experts to make sure nothing is missed in
the nitty gritty details.


