Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8B2C5DF81
	for <linux-um@archiver.kernel.org>; Mon, 24 Aug 2026 14:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t/e3PpeaK5U5W4RUHXokLB2sTjS30zI1NNFQptTXikg=; b=bLJsho8dYelSeDZUhQ12q1dztz
	BADWkgL+f8QIGcNu9PBAC8u60vOlGI9MBr4eT8F9/s0K7D6/57AIWVeFbiSZBRI4v7HmSHba9vTil
	OzOZND44hHPID7QKAFu4Zd1NEGuEFwr0WLEW+dCxeBG/3kiRYAp2SrfmmolmxjO34VCeOU4QN6sji
	0zgGzeccnzMoVX0bLxa57o+VO/w0c1WTMKy6GwEArXo31S3sS3pFfZJq5PHbMRzKar3mgZkO6cqTw
	iQLatVC5vBA5Hj4oYcpfiaFg+T2ipL2SvpBG58lQlBTkEU6XglTZxF6ejrRvVepA2+C4GJ3NG9aJj
	hPCqHJpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyVYP-0000000GlWT-0tlK;
	Mon, 24 Aug 2026 14:21:37 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyVYH-0000000GlV1-1wNq
	for linux-um@lists.infradead.org;
	Mon, 24 Aug 2026 14:21:32 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5E2FE40E01DA;
	Mon, 24 Aug 2026 14:21:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LzNTmVnQVH8u; Mon, 24 Aug 2026 14:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1787581264; bh=t/e3PpeaK5U5W4RUHXokLB2sTjS30zI1NNFQptTXikg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UanfX7oZ2ZFw/3sXBjtsg/+UhPYwDAw620awwueeX2K4PsnVlOd0Y+urAQaR3Z31C
	 dMWn+kCZNnA6m8wg4VAGqYAEvcA4JDAilb6j0AYZuruDq1dp8TlM4cZsh4xTqPD8Lr
	 NPIFoML1IjJuFasrIMWfvojJSVLxvfjUeMyKOQHh9ZTWOhhE/HvcRz4pj90eYBzUvr
	 ix5xbnLzU7mKboLPD83sHNvVXIxOJG6tBoukWhRV+t4Tt/obRuQWjoN0KP54uVHoJl
	 EbfUyPHeot8VLEo7E7nUSSb2m1yunqq4HYOK5mjGxSjTF9QvA0YwW+EqlkwgMM7vuO
	 lZLOzM7LStqQdL+a19ZkRZgclcQBhCWCMDvie3vHNYqAKSEaH75/sFmwXNDuEHmBBC
	 S9PbZyftDzsqw1q8nSdx5hHLzdH0XLlDPd4WBHzxGenmpvQIXDysPfIVetamlMz5wP
	 dUDLLAL6TYSf6rFRKrBHaK68RrKo9+gBNoJGAxPfi6/mFhhijl67BmSGAGoMSYaKaK
	 vskhGBL9RagruMHxV0zOKnnm3BcFvxLUWw8Bksghe92P/R3tanZM/a19qzwddhqM6V
	 UbrTjuNdCuDpTDsye02+ceyX9zxm/H63o5aipbNF5VnXnagVZPzPA7Bl1LGAFN9whK
	 NJFvVr/eu64paiQVu7H++X/I=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D5A4340E016E;
	Mon, 24 Aug 2026 14:20:50 +0000 (UTC)
Date: Mon, 24 Aug 2026 07:20:48 -0700
From: Borislav Petkov <bp@alien8.de>
To: Fabian Franz <fabian@isomorphic-ai.com>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Nikolay Borisov <nik.borisov@suse.com>,
	"Xin Li (Intel)" <xin@zytor.com>, Ingo Molnar <mingo@kernel.org>,
	Claude Fable 5 <noreply@anthropic.com>,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
	Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [PATCH REGRESSION] um: Fix cpu_feature_enabled() build breakage
Message-ID: <20260824142048.GBaoxTQKUUtmflxuyB@fat_crate.local>
References: <20260823201521.2576344-1-fabian@isomorphic-ai.com>
 <a02b160a-874f-491c-987b-4d7eb0d35a9f@leemhuis.info>
 <20260824092300-3e9a9d58-b273-421b-a4bf-5609ccb9ab49@linutronix.de>
 <CAKbYdNEK0TUy+W5g_yGuP-JCC9CQwmeO0q95rYhcebZYB9vLUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKbYdNEK0TUy+W5g_yGuP-JCC9CQwmeO0q95rYhcebZYB9vLUw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_072129_663594_09576240 
X-CRM114-Status: GOOD (  16.30  )
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

On Mon, Aug 24, 2026 at 11:22:33AM +0100, Fabian Franz wrote:
> >
> > Thanks for this pointer.
> >
> > > https://lore.kernel.org/all/20260819-uml-timex-fix-v1-1-f690b514fc9f@linutronix.de/
> >
> > Indeed, both our fixes seem to be for the same breakage.
> >
> > Personally I prefer my patch, as it reverts the specific change which
> > introduced the breakage into the tree. Franz' change does not look incorrect
> > but is a larger change and should go through a regular release cycle.
> 
> I also prefer your patch. It is much simpler and doesn't require
> changing the cpu flags at all.
> 
> However, getting the minimal patch for um in ASAP would also be good,
> as a broken master is not nice for development.

It happens during the merge window.

UML folks, you wanna take Thomas' patch or should I route it through tip?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

