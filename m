Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF099C79F9F
	for <linux-um@archiver.kernel.org>; Thu, 10 Sep 2026 15:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ggfuCidWjl1FJRJIK2RNc9iSgXfrieeLUmrFlZQVRGw=; b=ivR5RkCYT9PMDuG1uNXzse7oxo
	njwOL0/OOxI0cytCuzPWMgHDjeoXd96GFG/3U5vDVZXY0iDPin35Tf9gcF8xNPmDqwG9MTyV+lhSO
	ALWhJUVMi+sSksOLYXnO+1TdUFQMxLrZOp+9/wIzYP1FZrTBVqaCDLGP1qZVwO6OdHs3ukYTfabvH
	jiIotYcu8K5l4KyKxSczvROidHIu1RH0xVHmFSGy+oPycXSN9PRzGzY0Kj4Hg9v+RXoAefEY6wLDf
	1DUAtfXlK4bZjSshguNxGUuH3nZrvOfpmzB8/yo28+L5LOCPtM+lJEkLJUKUZLnRVIS87844eOKM3
	nHGRYnow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4gxF-0000000Eqz1-31cC;
	Thu, 10 Sep 2026 15:44:49 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4gx8-0000000EqvB-1H51
	for linux-um@lists.infradead.org;
	Thu, 10 Sep 2026 15:44:48 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9045740E01ED;
	Thu, 10 Sep 2026 15:44:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xWqO-b47gyZP; Thu, 10 Sep 2026 15:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1789055059; bh=ggfuCidWjl1FJRJIK2RNc9iSgXfrieeLUmrFlZQVRGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EYrhsW+Vi/NIPYQqx0qONq+iIuEX1lJtruEq7JxSA2YCeB6ozvDHXvYkoY+GrBdQA
	 lARnF+s90K1pIyh65RE1e01bQnOeUoY6uivpIVlsKFCuiTu/fl6QYJMZi0SdMWirss
	 AXbaSlcQcwz0u8sfgZWAyW7sQ+gey3jH01HcuAJ9ZjioBI4DQhlCdZgnsYd4Ou+JXV
	 6jUxXT0Y9fVLhurzXO+g3Tlu302nelO3m9/sSI5Njnf0hL4FpfZVUqLvfajxNd1Fh6
	 I89cHkFTEF88MDtwMhc7yaY5E49CvoiybRH5gzxsr+t6YOtVvssfs6AQ5y3V3XKwAs
	 gIxw1YVxf2dPZJDpXN3r3Hh+VWV0+WnIvpI+0a6lruy4Hf60POSqBxY/mbQhphASe+
	 Sxs46vpaGhix0/Xkebkb3p+cxrBmUDR9vuDbTgDLQHCMgZbxhVLM3va9toRgW4K0Yp
	 6W8ftcKQ2ft22iBR5eANBxMW480rfMe47RJFkKV7YogKYJxfhpa4xOp8d07UOhHucq
	 pWkep1KiQMiiF4AVNsWMSHFZHsEwQuk30j/u4xl+BJtQcHtm8DnbJdG1TiA+N74miw
	 QxVvkW0sPt/WD9fYWXwORoZI7FrmiOcQH/EGtf4HH7DLCAfofBF4Cd1K24acHdLVGi
	 gaWvW79roKfWgc4UwzrfG09A=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::3a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1EF8240E01DD;
	Thu, 10 Sep 2026 15:44:09 +0000 (UTC)
Date: Thu, 10 Sep 2026 08:44:07 -0700
From: Borislav Petkov <bp@alien8.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
	linux-um@lists.infradead.org, linux-raid@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 6/8] x86/fpu: Remove cpu_has_xfeatures()
Message-ID: <20260910154407.GCaqLQR1uy639wTGAx@fat_crate.local>
References: <20260901145740.42337-1-ebiggers@kernel.org>
 <20260901145740.42337-7-ebiggers@kernel.org>
 <20260910083801.GU4121339@noisy.programming.kicks-ass.net>
 <20260910142301.GAaqK9RVdjjmpwX876@fat_crate.local>
 <20260910145933.GB5719@quark>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260910145933.GB5719@quark>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260910_084442_499940_4102E8A6 
X-CRM114-Status: GOOD (  10.98  )
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

On Thu, Sep 10, 2026 at 09:59:33AM -0500, Eric Biggers wrote:
> How about just applying patches 1-5 and 7-8, and deferring the actual
> removal of cpu_has_xfeatures() to the next cycle?

Yeah, just did that, will push out tip/master after some testing.

> XFEATURE_MASK_OPMASK is just part of the AVX-512 state and it will be
> implied by X86_FEATURE_AVX512F.

Right, I wouldn't mind if we zap those cpu_has_xfeatures() in perf/core now
but then it'll need to merge x86/fpu... so perhaps waiting for the next cycle
is better.

I'm putting it on my todo, unless you wanna do it. :-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

