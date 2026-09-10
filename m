Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB5FC79F9F
	for <linux-um@archiver.kernel.org>; Thu, 10 Sep 2026 14:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FK+j2G59O6ul73//uvAAAdQWhLiKdDpmn+7SecJshMg=; b=fLwCCbLxRuNfzGtI2siQniyr7G
	qFTOebJR9xzHmN5+ecJY38ZZm04caPbXgnF2/msEOXiB/JnBP2GC3TjGjyNOdDRpfoSvtyR9bePRS
	YEaFzzMOtn5New0EIaSBx9P1g5St3C8mHG2dVauYZv9sgHRCWDANFiN0floD/9ttgBwzib06IAnz5
	cAPfuQfvMDiNeepbdJFj45ay2fzOiP2PkXuVvQkBIKRdVwFyDcOHIXCaAeOn28jhR5C0k+ziynmay
	9S4h4TAYdXoDCMrLRAcZpLyE+fOk4vp2ToPKP9E5Z4RIoHYuxgVWCZSFrOMyO1Y8mN1c0A3bV4Lu/
	E2A9+4QA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4gFW-0000000Ehtd-2Elc;
	Thu, 10 Sep 2026 14:59:38 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4gFV-0000000EhtU-0Eug
	for linux-um@lists.infradead.org;
	Thu, 10 Sep 2026 14:59:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 328CF600E2;
	Thu, 10 Sep 2026 14:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9871F000FF;
	Thu, 10 Sep 2026 14:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789052375;
	bh=FK+j2G59O6ul73//uvAAAdQWhLiKdDpmn+7SecJshMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kZ7xHOSpWAqcLGxA8bC9w6/r5GnM/pOPfZ5pShSmT0+o+nNiquU3wTYupRR2kX1Wg
	 skUIdKWSAdlz9E+Za1miyJQscx2Uu1qrQ7Y2vZkaDoetB23Vf9slRG+tYbDtNW3wRt
	 WHmmLZIyWEZaFXyqcAlE5Zy2eZUtSVdF+4uqad1TVpAOCH1CgLN6hLhE0IPSGy656h
	 nsXpPnxSlIAbykIbhnCpUC/9zdlV8ag+ipshzTp2XWe8+lENWEqF1bCURuT5rNh0d/
	 FSJjkAPQtkONWai0JxLM69GVIRhSspwKFm/rBKoxu/2VAOekACyPalmnystZgGRO9n
	 PYfwL5rBbgaqA==
Date: Thu, 10 Sep 2026 09:59:33 -0500
From: Eric Biggers <ebiggers@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
	linux-um@lists.infradead.org, linux-raid@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 6/8] x86/fpu: Remove cpu_has_xfeatures()
Message-ID: <20260910145933.GB5719@quark>
References: <20260901145740.42337-1-ebiggers@kernel.org>
 <20260901145740.42337-7-ebiggers@kernel.org>
 <20260910083801.GU4121339@noisy.programming.kicks-ass.net>
 <20260910142301.GAaqK9RVdjjmpwX876@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910142301.GAaqK9RVdjjmpwX876@fat_crate.local>
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

On Thu, Sep 10, 2026 at 07:23:01AM -0700, Borislav Petkov wrote:
> On Thu, Sep 10, 2026 at 10:38:01AM +0200, Peter Zijlstra wrote:
> > Boris, can you have a look? For now I'm reverting this patch locally.
> 
> Yeah, I'll zap it from the x86/fpu lineup and then we can see how to fix up
> everything later.

How about just applying patches 1-5 and 7-8, and deferring the actual
removal of cpu_has_xfeatures() to the next cycle?

> I'm not entirely sure how to go about fixing this. Some seem trivial
> enough, but others, like XFEATURE_MASK_OPMASK I don't readily see a
> replacement for.

XFEATURE_MASK_OPMASK is just part of the AVX-512 state and it will be
implied by X86_FEATURE_AVX512F.

- Eric

