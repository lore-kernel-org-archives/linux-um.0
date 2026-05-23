Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CEECD4F54
	for <linux-um@archiver.kernel.org>; Sat, 23 May 2026 08:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i9N/95A/Qq2bBhi9MEP97bwNmBebXjIW5RFDkklcsZ4=; b=IgOrZ/JWTOYOB287rCAHNpnf2Q
	6SaQv2nN0cmq1ccgjv3Rvw11KmIywFP5Xr0NT9ZFoW9VO0S4mYKalbeKSEg7a2XUUSUgumoZtoAGR
	cH99U4gjIoK9N4M/V1aoE4zeIDr2twAgkwSvBbsbMdiZHHxcxTd0R2jpIYixX40lDpuze5vbEBJhz
	SGWMuxCW743GLb4MzqBUC+ll3+NcxSJq1clTYCsjriTpMO4JsdjbKxNp7EETx3qX7ye8+hnCMJwvR
	bEYyZBwsNHJH1m+jhiB5ecG6OI0CJWSX7YRP9zEQIMDjwJKI1EcSl1DckHIhtPJwJMtBQlnRlMbIS
	14anixpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQi6x-0000000CyMH-0H6n;
	Sat, 23 May 2026 08:53:35 +0000
Received: from fhigh-a8-smtp.messagingengine.com ([103.168.172.159])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQi6t-0000000CyLf-3Y7F
	for linux-um@lists.infradead.org;
	Sat, 23 May 2026 08:53:33 +0000
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 17BBF140014D;
	Sat, 23 May 2026 04:53:30 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Sat, 23 May 2026 04:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779526410;
	 x=1779612810; bh=i9N/95A/Qq2bBhi9MEP97bwNmBebXjIW5RFDkklcsZ4=; b=
	f4x+L8FxJrecIwsAJlX7ieZgMrPLKA3ieSF8Di3Ho4bOeJ9+xY+fGfL0K+yj5yzr
	2i/V4BJEdXKmHvwypW3SMj0VuNBYGjtRFkr5NRIIuhv7mm71pAimGdKDZd216C9G
	sOddyI3VKpZx9MxtH0FPZAbJI8Uenddc9XAOycd+DPgtZaj6mqrJtYIfqhZRD8qb
	nRd3wN6ehPs8UsJ/thdsuM6xrRA3UOZ4+6y6NIVKRuOu3cndmoNOmpBjttCMtxkP
	4ATv+QiFZVjAOYsW/ppLDxAnvhuM8mth71dprPtdBslWD6VhLpNuwnQ2/BnDtTcU
	YZdf+d3fjaCKP/hp25UNpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779526410; x=
	1779612810; bh=i9N/95A/Qq2bBhi9MEP97bwNmBebXjIW5RFDkklcsZ4=; b=m
	mN7s1X06zi6LBqiHSZ6ZpNuiPMiC7f5U/wRlYCBHAcWKlDpICWhk5ADgvGnALdtS
	7suBSUFsXIkOgRnOHyOwsq+G2U190s8V67sFlbknLeVrhVFuR0qhf9GKM3/vlHoJ
	ffKJA+zslMbabLBvCq5se7eEdKAcqc03MmbCi3jFIli5x6OBL8BwNo7Kuo46nGDm
	OYgTVb83RchsD1aLCzxkE/kjnlzFO/JsLVk0cBPs03sZSbQSGFyescSE8/ZS0B9r
	WhZErOUPN+E+Z1He5riC9/GxWwUQ3ni8wYxQOw+RRtg4D38XLMrtwc36rY/rK41x
	NzatTmoMAo9PJ+lQRoGww==
X-ME-Sender: <xms:B2sRagPAGBhz7keY5Aj3YwiLAXn9s0P8XcjHat7JO1CC8PGchuS3Ng>
    <xme:B2sRahxHX_drMMe2c-gL0ciHDNOx7gWZx-8SYISutlkoUCUdGFQcUdW9g8DChv7ST
    S2APQq0hR4lUFxqTUXi24GeyzOganKeBQQgh0quveb5HcbbNCSGU-0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduhedviedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvdefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopegrnhhtohhnrd
    hivhgrnhhovhestggrmhgsrhhiughgvghgrhgvhihsrdgtohhmpdhrtghpthhtohepghgr
    rhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepuggrvhhiugdrlhgrihhghhhtrd
    hlihhnuhigsehgmhgrihhlrdgtohhmpdhrtghpthhtohephihurhihrdhnohhrohhvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorh
    hgpdhrtghpthhtoheprghlvgigrghnuggvrhdruhhshihskhhinhesihhnthgvlhdrtgho
    mhdprhgtphhtthhopegrnhhthhhonhihrdhlrdhnghhuhigvnhesihhnthgvlhdrtghomh
    dprhgtphhtthhopehprhiivghmhihslhgrfidrkhhithhsiigvlhesihhnthgvlhdrtgho
    mh
X-ME-Proxy: <xmx:B2sRaoojv8oIYa3Y4fZFjQkU1dq7CF3jUTmZg1vMpHMWYsskRXqQng>
    <xmx:B2sRaqPEmUIdOUAk5foMiMnzQT8NnzUopKrFserl5CnDW8sQCbcXng>
    <xmx:B2sRatPHYfBCHRA_GeXI_jPvOWIwKsTEIMHgY_3BD1_PFZzd8nw-Gg>
    <xmx:B2sRak2a_mUBSWn3kDwlkWQ8jZb4gBQxv4kRqGkxB2iQ8b2hs7fVPw>
    <xmx:CmsRasW5q0gyysCmFQCs1H15vAPhxrhTR8Hai6_lUwViOxjBZQahruc8>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B0350182007A; Sat, 23 May 2026 04:53:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AnN1zSbkQxM3
Date: Sat, 23 May 2026 10:51:41 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "David Laight" <david.laight.linux@gmail.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Ingo Molnar" <mingo@redhat.com>, "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Thomas Gleixner" <tglx@kernel.org>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Peter Zijlstra" <peterz@infradead.org>,
 "Will Deacon" <will@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, "Yury Norov" <yury.norov@gmail.com>,
 "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
 "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
 "Alexander Usyskin" <alexander.usyskin@intel.com>,
 "Anthony L Nguyen" <anthony.l.nguyen@intel.com>,
 "Przemek Kitszel" <przemyslaw.kitszel@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Message-Id: <9789e44c-cad6-4fb9-b684-ed132347a92d@app.fastmail.com>
In-Reply-To: <20260522223349.155dfe20@pumpkin>
References: <20260522141959.1071595-1-arnd@kernel.org>
 <20260522141959.1071595-9-arnd@kernel.org> <20260522223349.155dfe20@pumpkin>
Subject: Re: [PATCH 8/8] x86: simplify 32-bit instruction set selection
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260523_015332_279064_F9A15183 
X-CRM114-Status: GOOD (  14.94  )
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

On Fri, May 22, 2026, at 23:33, David Laight wrote:
> On Fri, 22 May 2026 16:19:59 +0200
> Arnd Bergmann <arnd@kernel.org> wrote:
>
>> From: Arnd Bergmann <arnd@arndb.de>
> ...
>> Change the CPU selection to build everything with either -march=i586
>> or -march=i686 and make the specific options only change the -mtune=
>> parameter where this was previously handled by -march=. Note that
>> the only -mtune= options that gcc or clang understand for x86-32
>> are i486, pentium, pentiumpro, pentium4, atom, geode, k6 and athlon,
>> the other ten are just aliases for one of them.
>
> Hmmm... That rather implies there is nothing for anything designed
> in the last 20 years.
> No wonder code generation choices look strange at times.

I think this is correct: I can only think of two 32-bit x86
cores designed in the past 20 year: Quark is basically a i486
pipeline and rarely used with Linux these days. RDC Emkore
is still used in low-end SoCs like Vortex86EX2 but never
gained GCC support.

> You don't want to pick p4, so I guess either p-pro or athlon?

If you have a p4, why wouldn't you pick that option?

Most other 32-bit Intel cores (Pentium II, Pentium III,
Pentium-M, Yonah/Core) are indeed iterations of
Pentium Pro, picking the more specific Kconfig option
has never had any effect on gcc tuning parameters.

If you want a kernel that can run more more than one
CPU, CONFIG_X86_GENERIC will still do that, but that
is likely measurably worse on the more sensitive cores
like k6/nx686 or geode/cx5x86.

> But neither is really anything like even Sandy bridge.

Sandy Bridge was well into the 64-bit era. Even when that was
new, you wouldn't have run a 32-bit kernel on it (or cared
about CPU optimizations if you did). For x86-64 there is no
CPU selection and we just always build with -mtune=generic.
Thisi works well with any out-of-order microarchitecture.

       Arnd

