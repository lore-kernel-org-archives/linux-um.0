Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A956CAC5B3
	for <linux-um@archiver.kernel.org>; Wed, 24 Sep 2025 11:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8jb3EmJHOwAdkojmIjPqDHZa58n3wYX161nLGH6EK/8=; b=MGU6MSbL+5JWArqIJUZ74FkLNJ
	+DRSLqvsQog1tOkyBQRSHnH1khkBwsXQtyjEGWYmia2z5XabP6MSDmj3X1RQ85AluJgmlLEQF7P/8
	lFpyR3hjnYHPs/naCpOkdaqyl0bJVvmHgLFsmMvP3c/Rd8uYVhEjTOTMfrLgiAJhwKz4+CbJi9qOP
	cpbdpunJbuJtctqBtMTk8OI07/VDKqcl9dkww3KUg+NuZ9E+VhVSnwEDQJ0s1HMQmidHz4T4TtD+8
	DtNtLbmPNyAaRt2r6yfm2MmPEtWkDzjOXBVkgXvb1anPLL0pb49SlvtUlFToW1rWNQyEDPXC0bs05
	i0GEI+mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1NHo-0000000GkjP-0mK6;
	Wed, 24 Sep 2025 11:03:48 +0000
Received: from fout-b1-smtp.messagingengine.com ([202.12.124.144])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1NHk-0000000GkgZ-1FHc
	for linux-um@lists.infradead.org;
	Wed, 24 Sep 2025 11:03:45 +0000
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id A47251D00107;
	Wed, 24 Sep 2025 07:03:42 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 24 Sep 2025 07:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758711822;
	 x=1758798222; bh=8jb3EmJHOwAdkojmIjPqDHZa58n3wYX161nLGH6EK/8=; b=
	sg2/n1GkkHAkkymHZC5B0VViG7BHavGb3EmtPTalauCQWPxofJycgm+KBd6MDWw8
	49TzjE17Wa4MiTnTO4eRcshDmlFiLBJDWsvoYsXVaH0UP3Zyz+vcA4GtHqsa0gdo
	orKO9bDvqwnxg3dIzC4Vi/1e3twwmsqv7UtJXX9P1Ex2NO0BvATpGNQrpWmC8jlS
	w5RuSD7863WRmsWbaM+ABJMssdH0AoU5FuJkL6WMB2ZDC6nFWq8c+SmL4DHRvNW1
	FSns91GeSL3j4T53TriQOrRcB9liM0rDZ+DqvJVkrzBhglHkKVpa/yMDnDzWU4He
	dep/1J7sWbi/8bb6AnJg6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758711822; x=
	1758798222; bh=8jb3EmJHOwAdkojmIjPqDHZa58n3wYX161nLGH6EK/8=; b=N
	dn8VqGRkYx3Pma/EBu4KfrVZoWdlmkcLohs9LC2/txSdJN5fZpd7KAi5+/pwsGiQ
	su6Zm+x9dgsqD1zj+Z/YgAY5SIsfLSG+befkTZPZyGRmx0ne3o4d7nR2OeEU2XGh
	UB5mDvFm0nU38i3aNHJYSp6UJ342S5reuLOwByXFXuo3emLy4Rk6/byTtsJ/XMdQ
	T8mq4tH2IpaErLNJqb0Vs8n4jVNJ0IgmDPc4hlkBzlm2GLbntxdKu7NIc5Gsnkvl
	RMmMVE5jTjNPDROgZ2JxP0xe0dx3K5jjZ0Q6lu28lSoJYYvnPQMN1uZWKMhp9PEu
	KJi//MsGwDU4cRw4vbHRw==
X-ME-Sender: <xms:DdDTaC8_t3mjd1ca1yrhG3a88IGSSUW6YfuLIGnl9OvBOi8znjcQ6A>
    <xme:DdDTaNj0rFLDLhblP0TWEcOM29qHy9tymCdOwfE2nFIsyskIzjfyZ1InwmVZRsINN
    M3zSKx8BrnlYyFpRLot2d4lHvTl4i35mLMv76DQC128T4ZGsa1fNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifeeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvffeiffeuteevgfdtffduiedvgfegleeiteduueekgfffteefvdegffevieduueen
    ucffohhmrghinhepudeiqdhrtgdurdgrshenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphht
    thhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehthhgvhhgrjhhimhgvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhitggrrhhkohhlsehgohhoghhlvgdrtgho
    mhdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhope
    hgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhu
    mheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihgrmhdrhh
    hofihlvghtthesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghssehs
    ihhpshholhhuthhiohhnshdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:DdDTaMewBAftm_7vrZZzklPk0qvmueZA-aZhBjCCWvPF78s2EKK0pQ>
    <xmx:DdDTaKMM_p2RjZZvKvfEf5gNmHZ2U9xd3F5j_ukPvckU7sHUSQ2MaA>
    <xmx:DdDTaPsjjQfWEGLsA8uozdijZ5fZ_BN9tDWqy5Nu1EMkViBxVkW7BA>
    <xmx:DdDTaDC0gw2E_ePuyejYTiqd7ajQtTjBCJZYWfGsvBgzTszCNGNeuA>
    <xmx:DtDTaF2wN4VQRU1YIljIVLV3F9nuxA7GzuTpNaJLjDDanKik0gNrPHUs>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 79228700065; Wed, 24 Sep 2025 07:03:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AxP-iOAFlspw
Date: Wed, 24 Sep 2025 13:03:11 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Hajime Tazaki" <thehajime@gmail.com>,
 "Johannes Berg" <johannes@sipsolutions.net>
Cc: "Geert Uytterhoeven" <geert@linux-m68k.org>, linux-um@lists.infradead.org,
 "Ricardo Koller" <ricarkol@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Message-Id: <b55251bf-625e-48c3-8c60-eb4f8358f397@app.fastmail.com>
In-Reply-To: <m2zfak7mnd.wl-thehajime@gmail.com>
References: <cover.1758181109.git.thehajime@gmail.com>
 <4a9dde10c586883d20a8201ca7d76e6d7d52eaf4.1758181109.git.thehajime@gmail.com>
 <a58620ecefa207e141a435c36492647c3d5bd3df.camel@sipsolutions.net>
 <m28qib8g1r.wl-thehajime@gmail.com>
 <6b1abe384237c8129e8043ecdfdad77758d2fd2f.camel@sipsolutions.net>
 <m27bxu949d.wl-thehajime@gmail.com>
 <CAMuHMdWAdhiY=MiG5JtboffSo_=D7TD5vFM6Ui5E8eS_VJiJ=g@mail.gmail.com>
 <23adb61e95275251e459513a03ab7d2bcf1f2e07.camel@sipsolutions.net>
 <m2zfak7mnd.wl-thehajime@gmail.com>
Subject: Re: [PATCH RESEND v11 10/13] um: nommu: a work around for MMU dependency to
 PCI driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_040344_819737_1A0F8E48 
X-CRM114-Status: GOOD (  22.14  )
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

On Wed, Sep 24, 2025, at 01:51, Hajime Tazaki wrote:
> On Wed, 24 Sep 2025 02:13:47 +0900, Johannes Berg wrote:
>> On Tue, 2025-09-23 at 17:42 +0200, Geert Uytterhoeven wrote:
>> > > 
>> > > currently, drivers/pci/Kconfig (CONFIG_PCI) marks as depends on MMU,
>> > > so we cannot select it when CONFIG_MMU=n.
>> > 
>> > That is a fairly recent change, see commit 8fe743b5eba0abfb ("PCI:
>> > Add CONFIG_MMU dependency") in v6.16-rc1.  As this is not a "hard"
>> > dependency, perhaps it should be reverted, iff you are willing to take
>> > care of the casual breakage?
>> 
>> Why though? UML with PCI can't really be a functional thing, only a
>> testing thing, and testing PCI on !MMU when that is actually impossible
>> in non-simulation is pointless?
>
> currently nommu UML doesn't come with using PCI except building under
> kunit (ARCH=um), but I have in my mind to use it under !MMU
> environment, so would be an option in the future.
>
> and this series doesn't include PCI w/ !MMU.
>
> so, I would propose the modification to revert the MMU dependency when
> time has come.

The reason why it's currently disabled is that it was causing extra
work to fix build failures in random PCI drivers that individually
have a CONFIG_MMU dependency. Since we know that none of the NOMMU
boards we support uses PCI, this was an easy way to avoid work.

While there are still developers that care about NOMMU Linux
and test it on the platforms they use, the NOMMU build failures
usually end up in code that are irrelevant for their use cases,
so neither the platform owners nor the driver authors care deeply
about fixing that combination.

If you want to be able to use PCI drivers on UML-NOMMU,
you can probably use

config PCI
       depends on MMU || UML

so it will be ignored by the build bots on other architectures.
You'll still have to decide whether to fix driver code when
regressions in PCI drivers happen, add 'depends on !UML'
to individual drivers, or just live with randconfig failures.

      Arnd

