Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B655C3DA6E
	for <linux-um@archiver.kernel.org>; Fri,  5 Jan 2024 08:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eQxq/aChg7d6JUqV5QLuB7VFY6WGAPEHKk/j1lpPPfQ=; b=IjPJLIQk47KXVu6KGUlJVt7Uua
	sbxt21CSVRTmXYhbFogg8ckK3H8rdcCC5D3zIhYQAnNte9ym9XQlQmYH4VKvV6FeDbFAI6v5Fnp2g
	5+3guiBuDL2/3z1naWJV1hdv4YD81EDYsV6ysViiypxeegCWNw9PwCtAoC4Fq13zEetTHliL5Um7B
	ZZyTFlNit2mNaVYjA8Ncjofc/k/Kdm7orref4bwEiYL9dyeAskdh3kGJqwGyI9jc0KmbLplGY+3aw
	RVLT/Aa97Fx8cnh8uX4AlkjY54cPzm2Y9yMKpCcMsJ+tRgWTFaa1GNtz68Wz3E2YJAgNWz/6xkHE7
	BAsH+F4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLg02-00GJ2O-2R;
	Fri, 05 Jan 2024 08:56:18 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLg00-00GJ1C-0f
	for linux-um@lists.infradead.org;
	Fri, 05 Jan 2024 08:56:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=eQxq/aChg7d6JUqV5QLuB7VFY6WGAPEHKk/j1lpPPfQ=;
	t=1704444975; x=1705654575; b=FBbuABCsH770cN/esq7EEhyJDMuMIUG84TWtMTogFIyjWrL
	iuoV88nN57KbyvcINy7oph30L9n3vw8d6pqESIQBsSP3IE45+cLg2aXwdgbA7fwKnWuwAaIrgb4XJ
	sNfwzl09NeJkategNL64crE+WI9WvAnEyV032QLED8H0tXdV5EZaM1886lGgZk747dVnsJQYSMEM3
	UwqbMC1U01Uw9HWNVEXcYbj2ZaKZJViW5BWTiXItC0AnFKlPyxfJOMkQkGmU3mfIZZX0zlWH15vot
	KVN/W6sIn+MNBbqmQk6Ne+M4x1mP/8600RQo75t5K+489yKp/Ufeq5HbhsNn8KYQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rLfzw-00000005wGf-1Zp0;
	Fri, 05 Jan 2024 09:56:12 +0100
Message-ID: <29561023e97b362aa81aba2a33931897bea59bdd.camel@sipsolutions.net>
Subject: Re: [PATCH v3 04/11] um: Don't use vfprintf() for os_info()
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Berg <benjamin@sipsolutions.net>, Richard Weinberger
	 <richard.weinberger@gmail.com>
Cc: linux-um@lists.infradead.org
Date: Fri, 05 Jan 2024 09:56:11 +0100
In-Reply-To: <a75fb1e3b92f748a81e032b5138e2cdccc4d2c92.camel@sipsolutions.net>
References: <20231110110348.1815612-1-benjamin@sipsolutions.net>
	 <20231110110348.1815612-5-benjamin@sipsolutions.net>
	 <CAFLxGvxads6JaAgm2MvXKKJrJiYGk1oLa2EDC0YLemcQ866cvg@mail.gmail.com>
	 <a75fb1e3b92f748a81e032b5138e2cdccc4d2c92.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240105_005616_241560_4C3B7172 
X-CRM114-Status: GOOD (  10.72  )
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

On Fri, 2024-01-05 at 09:12 +0100, Benjamin Berg wrote:
> > Another option is giving the helper threads more memory, we don't have
> > that many.
> > Did you explore this option already?
>=20
> I had not really considered that.
>=20
> One thing though is that userspace_tramp calls os_info while working
> with the stub stack. So that also means setting STUB_DATA_PAGES to 2.
> But, I suspect we may want to do that anyway eventually to fit the ever
> increasing mcontext size for all the AVX512 registers and such.

That'll probably happen eventually regardless ...

> As I said, I think that is fine to do.

But I'm not sure it's a good solution to give more stack space to the
threads and think/hope that glibc won't make more assumptions about the
amount of space it can use ... who knows if it uses alloca() inside
somewhere, for example? After all, userspace stacks are multiple
megabytes by default?

johannes

