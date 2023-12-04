Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 475F6C10DC1
	for <linux-um@archiver.kernel.org>; Mon,  4 Dec 2023 08:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kY+CsRJEEo8Q3tTpuc3VLCmHuuBh/DLnsioFtgQtvB4=; b=EuCM1Mpi6h/IOhKNFudqIEJuNH
	TwnyPYeCiifiaXwJZZdne1AFsGRKQdZPCAPF1HbcA26I7kIb35fakhu9ugK0GJYKKl5SOU2mZv7br
	uvbfVeqO7Dz1TVRizREwTjvudQAiv2eSEEZBUF8/ULvcABcRfKCSdjUp0aX1f2UdkNGzD6Sd9+rbl
	bNFZiT4Ip/EtSf7mS0ywtrbMHBusoRGvISp+olQVHjEFA5fhHmKCseksyj6BoiLG2HxYAa3SLWGKC
	8/ijq8jCVoZsroKT6izGcBdwHASDSKrDDQ+bX4wNDZKR59ur8zrP1izv5uL9rhzI0rU0ClL3zR2k6
	zABOQiHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA4hA-003LBP-2C;
	Mon, 04 Dec 2023 08:52:52 +0000
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA4h3-003L9K-0A
	for linux-um@lists.infradead.org;
	Mon, 04 Dec 2023 08:52:51 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1701679948; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=BRlhcA2L63eWYuVYAgQ64WgcGRg9HDsp1W7wIuCmKFTZxls3JVtTBIg+ztMldFzDvf
    xrwvt6C4qrLvMLxRHWkeqHFadAXprlM9+O/WGLYqQ1bNSrn/oz77uxL2/S2zKzLzQXU9
    N/ZXB6gscFebIUu/KsocZdP4SsxpRwniZPP3io51YPvq95/Wcz1HryJgxc0k45iy6C67
    rOe+VAF5jc8myinEl0Um0InDX5rvEmhZTjTRwQC0GJXUiYqPwbwD+fnSINMHr4EevNDx
    tBrEt++ziPIse+/72r61KTm7bqA5CubtJ0XpQXws9MZ/MTXHJeDIudqgnC9JmEw8R7XF
    FVLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1701679948;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kY+CsRJEEo8Q3tTpuc3VLCmHuuBh/DLnsioFtgQtvB4=;
    b=GOcNlYImASKt+WOIKa+O5f9twTpv73ntPpo9dlSPuP2aFKmqNo4lNJHxsKAJ5huess
    asxBiULoVPKlcUOyIq/GIYpbh7Ba1h1P0OF2ZAeJSb5DP3Y0c9zIraIbrz0goTf4RNN+
    ++C4z9x9710UW34TUjqek87yPnwNJ+LSbJ+gqj51EfL3pHw7s3ZNzDiwbCPqDdlUoRkx
    mHOnGcIaM3MrfJDYhcYO68X5NbxODZ/g6tdH+WSfHpQyLoZwo3QfbMAQClOsJMurwzOV
    Bf3jHmXd1/TRGPUto5f8FdntAefF4SmCHu+KnDoT412SmMmdtUvTkWVUclYyiTC6Waz1
    EvAw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1701679948;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kY+CsRJEEo8Q3tTpuc3VLCmHuuBh/DLnsioFtgQtvB4=;
    b=f7G0hgD21cAM4VYrKkFisFzhxR0zPMht/+elB7qeyZ+KJq+102sh2EARQVYYp0T7Pq
    VZKcqKMgPyY+lZ7Xiz4FTnHeTtKZY7lwhmqu1DcRg5kkqQAQfMJrMUTlg7zXm9/VlXgu
    r3alnvKYATkBPG19eTnDamuCIoh8a0nI5oVPgo4+npKj7D8RsY2lpGwHOgY0wd5mElWB
    l3NP6wbASqT7X97QVhxqeWAnEDJTTDCO9YHBN2oR/ieZ7hgf9kYqlDG6TXg/G/CEQZxb
    INYcKP6Q03RLeITSRxIBFUMTYQW6AyCWIghhwbyW/qhTkPJzMu+uh2aBhgNmdQeOi9Ue
    UfIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1701679948;
    s=strato-dkim-0003; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kY+CsRJEEo8Q3tTpuc3VLCmHuuBh/DLnsioFtgQtvB4=;
    b=yybkppYniG53waKRe1oHjGYY7omK81MI5UBWnbGVI7WnCY9uuu0lPGJuTMfzsMwq3O
    1dj5obVz5kpBHR++SJBg==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9y2gdNk2TvDz0d0u1qzE="
Received: from tauon.chronox.de
    by smtp.strato.de (RZmta 49.9.7 AUTH)
    with ESMTPSA id jc800bzB48qRGVN
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 4 Dec 2023 09:52:27 +0100 (CET)
From: Stephan Mueller <smueller@chronox.de>
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>,
 linux-um@lists.infradead.org, Johannes Berg <johannes@sipsolutions.net>
Cc: linux-crypto@vger.kernel.org
Subject: Re: jitterentropy vs. simulation
Date: Mon, 04 Dec 2023 09:52:27 +0100
Message-ID: <1947100.kdQGY1vKdC@tauon.chronox.de>
In-Reply-To: <8ddb48606cebe4e404d17a627138aa5c5af6dccd.camel@sipsolutions.net>
References: <e4800de3138d3987d9f3c68310fcd9f3abc7a366.camel@sipsolutions.net>
 <7db861e3-60e4-0ed4-9b28-25a89069a9db@kot-begemot.co.uk>
 <8ddb48606cebe4e404d17a627138aa5c5af6dccd.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_005245_569453_9D90522C 
X-CRM114-Status: GOOD (  18.47  )
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

Am Freitag, 1. Dezember 2023, 19:35:11 CET schrieb Johannes Berg:

Hi Johannes,

> [I guess we should keep the CCs so other see it]
> 
> > Looking at the stuck check it will be bogus in simulations.
> 
> True.
> 
> > You might as well ifdef that instead.
> > 
> > If a simulation is running insert the entropy regardless and do not
> > compute the derivatives used in the check.
> Actually you mostly don't want anything inserted in that case, so it's
> not bad to skip it.
> 
> I was mostly thinking this might be better than adding a completely
> unrelated ifdef. Also I guess in real systems with a bad implementation
> of random_get_entropy(), the second/third derivates might be
> constant/zero for quite a while, so may be better to abort?
> 
> In any case, I couldn't figure out any way to not configure this into
> the kernel when any kind of crypto is also in ...

The reason for the Jitter RNG to be dragged in is the Kconfig select in 
CRYPTO_DRBG. Why does the DRBG require it?

The DRBG seeds from get_random_bytes || jitter rng output. It pulls an equal 
amount of data from each source where each source alone is able to provide all 
entropy that the DRBG needs. That said, the Jitter RNG can be designated as 
optional, because the code already can handle the situation where this Jitter 
RNG is not available. However, in FIPS mode, we must have the Jitter RNG 
source.

That said, I could fathom to change CRYPTO_DRBG to remove the select 
CRYPTO_JITTERENTROPY. But instead, add the select to CRYPTO_FIPS.

This change would entail a new log entry when a DRBG instance initializes:

pr_info("DRBG: Continuing without Jitter RNG\n");

I would assume that this change could help you to deselect the Jitter RNG in 
your environment.

Side note: do you have an idea how that Jitter RNG perhaps could still be 
selected by default when the DRBG is enabled, but allows it being deselected 
following the aforementioned suggestion?

Ciao
Stephan



