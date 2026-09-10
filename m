Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26AAEC79F9F
	for <linux-um@archiver.kernel.org>; Thu, 10 Sep 2026 08:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mG/4AGN6tjfd63G18lYs6f5vejXgChWS/qvpHpogEEE=; b=p58ojLTqfIAvrZpatpz5QKSI+d
	Z+7Gti10hCeDVDQ8XVPj0kZ03+5DU+vpNXr/Cz9Bj0Z8hqLnI7fQWYye8kuxhuQfHW5MWCs4plkGF
	LF702sYQUzsImMgZ2XVgbAUVQ8x2f5x+ZwTEi3anB76Cic1QTOp6/oLQ8BXoq1svR041bE6/Bzctj
	U+5/MYlEHBCgOtoUjE7A2pZpNBdb1lmOc7bP+D/8UI1lA0UKyNlbWWxvn+hrOqfYvnBQCYMJawlvL
	9NJyF8CBsEhvk5Tec8AHDSRWYGukf6ZRN6ycysJRU8aGyo055pI17upt4xSSO5WrP4yGn88ifxiTi
	ZYWHXi/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4aII-0000000DllG-29Xo;
	Thu, 10 Sep 2026 08:38:06 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4aIG-0000000Dlk6-3Rfv
	for linux-um@bombadil.infradead.org;
	Thu, 10 Sep 2026 08:38:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mG/4AGN6tjfd63G18lYs6f5vejXgChWS/qvpHpogEEE=; b=eJEcYmwbeaU9Von9rzUqN922Y8
	/LYSnBHA1uZsh91UEF2DJYRHPrVy6B3UjC1uMfbSG/lv5mtiTb6822MmMms6UJOEgFw+3SQmSLxOQ
	gTlmt4Ie9xzj3O60Eu+hEM0VlmsLaEyW+OBlBB33IkfTG85xxvnoYRCrrf2SfDWmmU48b1NkProQ+
	3AUxJZ/JMOZre/1eZRS8kr96tLtZSXxE9WiXuoA5swejH8Qx8FpzP5awusmh0mlCYhHJExWjM5ih/
	9pcwde1UfS8NSNe1H5bwiI7sac7PnJPz+UDBPcoiT/upywFCOkNt9tzc9T/xq9TpaU7/Fo5s5G44y
	DPP6Sxnw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x4aIF-00000002CmU-1F4p;
	Thu, 10 Sep 2026 08:38:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B502E30056B; Thu, 10 Sep 2026 10:38:01 +0200 (CEST)
Date: Thu, 10 Sep 2026 10:38:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: x86@kernel.org, linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 6/8] x86/fpu: Remove cpu_has_xfeatures()
Message-ID: <20260910083801.GU4121339@noisy.programming.kicks-ass.net>
References: <20260901145740.42337-1-ebiggers@kernel.org>
 <20260901145740.42337-7-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901145740.42337-7-ebiggers@kernel.org>
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

On Tue, Sep 01, 2026 at 07:57:38AM -0700, Eric Biggers wrote:
> The only remaining caller of cpu_has_xfeatures() is
> print_xstate_features(), which uses it only to check and get the name of
> a single feature.
> 
> Remove it and just inline the needed code into print_xstate_features().
> 
> This also makes the "unknown xstate feature" entry at index XFEATURE_MAX
> of xfeature_names[] unnecessary, so remove that too.
> 
> Acked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---

Turns out there are a few new ones in tip/perf/core, so if you merge
tip/x86/fpu and tip/perf/core things no longer build.

I'm not entirely sure how to go about fixing this. Some seem trivial
enough, but others, like XFEATURE_MASK_OPMASK I don't readily see a
replacement for.

Boris, can you have a look? For now I'm reverting this patch locally.

