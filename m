Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34528C79F9F
	for <linux-um@archiver.kernel.org>; Thu, 10 Sep 2026 14:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oazBnerJKBXfynp5uGUgQGCP5CJIKWsROgSUMUbl4yM=; b=hZ5RmJFFhfoaPAQr9gIgklIsxL
	L0EDdURCCrkDO5CD705wM1TG3THVHvgLA0/MsVeskqamxLKfG6OlBXcfxFQeOVmYLxczxj4qAKH36
	a2mxckrfEb8i6G9oItHJJfjBTQiHiXRP5eVjWSjjxPGvHqcLfMtLrHpT4LRM7exSauVbR0Ccko5YA
	Wbeqqig+1g5kR3vkIKFAin5lO34iwOah/rRxyTbhwMhkXLc0qzk9Xo+CCUdiBIP8mc1GryvshcAbm
	KOIm8Yr5CHZODWYIADGvqVeAO6zV6bjmJB5mgXkc7NvGCJgjetazaI86q/1pnzACCRh0pTDRZU5uq
	LWslmm+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4fga-0000000EcdG-3azz;
	Thu, 10 Sep 2026 14:23:32 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4fgX-0000000EccK-2Iyc
	for linux-um@lists.infradead.org;
	Thu, 10 Sep 2026 14:23:31 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 60AA540E01DD;
	Thu, 10 Sep 2026 14:23:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JlEgMq8cfcwl; Thu, 10 Sep 2026 14:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1789050195; bh=oazBnerJKBXfynp5uGUgQGCP5CJIKWsROgSUMUbl4yM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D1meaicjse+es/+8OSM9lXaQVJ22Ma8RICYFH+AKCVCVtmrIEV50ALRE1EIaKXaaO
	 zUz983449jzmJzwfllrEDiPSDk+NDzDt+n1J1sBFavIj4kDdN+zE1YnIgBs7H2P9d9
	 mcpPTfbPDTeZhklPoT7pWxFmOlGoT2vOzbv3eajeBP9g5rNGK7Fi7UKYqB5a1Dqps4
	 TJfhj9EJoZj0FXuAyFeuAW+NCHjPB+CS3YcAOkioiBkz2YiABsTfCueSf+mW+SXIRx
	 qd3em2EQ7l9u8pSKrzT5Bqv2ho1agTxx1RoeUrWB2BV2RUMg0ebjNa17HUu3ON6e7d
	 nVQ02h/1AaLAfriIgs+TNjHxHc+VY+GYOnoJlk9GHbPu7kJ9EIo9C9aXnVgb6PMn5I
	 TKLe8CXssgvuYzAeUvwc7XpkVWQhlNr6WtXZQ6zPvxC3czTysE75mmR9JgLSludc01
	 1jfcf4ruW7Sj6u1EXYE6F7d6I/nXg2uAX21EqH7q/0TjlUrFh9mNPOlWGo2XQaEgBf
	 VVRYB/lMQNCa0cxitws60mOodDHxp3zYn2kXrIdPVxWA9YtML9eXV8QLl0rAjh0pOi
	 Nix2IeAnQJxv2yvHcIHqSV6yddrGQEXRc186uIkRWFaEwGdEqRt8KtrIDHxe1wse9W
	 jiiPVvzzi4wMbo+xQmcAma3s=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::3a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C01DB40E00E8;
	Thu, 10 Sep 2026 14:23:05 +0000 (UTC)
Date: Thu, 10 Sep 2026 07:23:01 -0700
From: Borislav Petkov <bp@alien8.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Eric Biggers <ebiggers@kernel.org>, x86@kernel.org,
	linux-um@lists.infradead.org, linux-raid@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 6/8] x86/fpu: Remove cpu_has_xfeatures()
Message-ID: <20260910142301.GAaqK9RVdjjmpwX876@fat_crate.local>
References: <20260901145740.42337-1-ebiggers@kernel.org>
 <20260901145740.42337-7-ebiggers@kernel.org>
 <20260910083801.GU4121339@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260910083801.GU4121339@noisy.programming.kicks-ass.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260910_072329_767809_57B55F07 
X-CRM114-Status: UNSURE (   8.56  )
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

On Thu, Sep 10, 2026 at 10:38:01AM +0200, Peter Zijlstra wrote:
> Boris, can you have a look? For now I'm reverting this patch locally.

Yeah, I'll zap it from the x86/fpu lineup and then we can see how to fix up
everything later.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

