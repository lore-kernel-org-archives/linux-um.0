Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59502C36002
	for <linux-um@archiver.kernel.org>; Wed,  9 Apr 2025 19:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q7Q4vnZxipqxBE7b5KNTkx//7Z3Iiwcu0vonfeK0zkA=; b=KoSLgnC24tevTC28hRcbkKozdJ
	37fbBtu27F1nIOa1u13lBiyNZr1toVEedmoe+YDx6BMDLZ90nccofwp8ngmlO1VZqjVy3g2Q2d/eT
	NrOYs/MuwDIdsQW02VINY6uqJ5jrgRbeNuKWU7pdzT1MQtI/0xyjrhGJm4AsVNQbPsgSFsZ9t7B+U
	udoJvWGEl7tf7Ngm4Q/yO35iygqqn9s2WzqPqohekWvdymtt5ZiDa1CVUWJoYS+4NuttGshkeTNsg
	9UOZnYR4TJyVdreDhZcMFkrw6ZGIPGAoXEzwqdIxxUojsI8s3+Zks/sOvhhgT7v9sWbbQI+WdUlTU
	Mq9y0I5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2am9-00000008GuM-3uHS;
	Wed, 09 Apr 2025 19:07:53 +0000
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2am6-00000008Gtm-3mQr
	for linux-um@lists.infradead.org;
	Wed, 09 Apr 2025 19:07:52 +0000
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 7D8281380166;
	Wed,  9 Apr 2025 15:07:49 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-12.internal (MEProxy); Wed, 09 Apr 2025 15:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1744225669;
	 x=1744312069; bh=q7Q4vnZxipqxBE7b5KNTkx//7Z3Iiwcu0vonfeK0zkA=; b=
	CYpfg/wT4OyA9T/uEuKIC+zTRLwceHAnwiqQ38fMKpyCDQiH6hztZil0K/PkqDmK
	rZ0WASxrjtDSUlYCxt511twyz30Jk88OyXrUr1am5UQ26pkmt5EOjohq+8lrazVO
	VwnWBMOQYPEbEZMoIGBwCwIKIlXNzjd3FvBd+HezfCiEUF55dOX5at6dYqIbzxtF
	xM3e9RhAtfbZk7/hKgXx1WZpdZWt+FOIOObgNfBD738i8DKUpG9FRiPKcy9X0AUs
	+FT5g5+/t7HoD/+hY2NEFsMhvTYU1bTM9iqO3/BK/JKtechDrcZZ/wIKZqPrcJS3
	Q5Sb16K8M46pYhchVEf5aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744225669; x=
	1744312069; bh=q7Q4vnZxipqxBE7b5KNTkx//7Z3Iiwcu0vonfeK0zkA=; b=W
	Gw//NOx0cNuV/xeR4dfhptnL0xkHWgDY256AqNNPxTKNhKsJtMt4B8xBWv9TjjwF
	/cvuGeg+A1yS5tRIyM0n7DpOKJGRYJXOnaxX0M4yfl4ckP4KauvvqIHIsqn90UIV
	Sflt8oEheH6JQxcnaGC/v9hGROJ/Uq7YyNaHNjbsfL5X8GeaA/dBG0L+MLqfzH7G
	qI/3n4Tuah8XhBziALH9h0fbBj34P7wEHdLws/xHQ7oIkCsYBB4NMEQcbr8FIxq1
	Q0p5plYE1QBrpMPiuguqhZ8cU8ghZ8YHZ01Ryv7QRnK29b1floNf8VNWS3Di+1O/
	BPOdVlIrBwSCkI3zrkqkw==
X-ME-Sender: <xms:hMX2Z2tSn9zCt2v3eNvJN6vN8gVn9Rx7-8K7RcGIfrtDDjz5mcZ0DA>
    <xme:hMX2Z7dVfCD9Te5Ln82JBbSCeM9DF0ZswfVqt9oKCh2opQZhsZ5syMvHL6Of7WeAk
    u8f3pYLPUUPQF5TLzM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeikedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertder
    tdejnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhepvdfhvdekueduveffffetgfdvveefvdelhedv
    vdegjedvfeehtdeggeevheefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    udefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhtohhnrdhivhgrnhhovh
    estggrmhgsrhhiughgvghgrhgvhihsrdgtohhmpdhrtghpthhtoheplhhoghgrnhhgsegu
    vghlthgrthgvvgdrtghomhdprhgtphhtthhopehfuhhjihhtrgdrthhomhhonhhorhhise
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhighhuvghlrdhojhgvuggrrdhsrghnugho
    nhhishesghhmrghilhdrtghomhdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepughinhhguhihvghnsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    humheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehrihgthhgr
    rhgusehnohgurdgrth
X-ME-Proxy: <xmx:hMX2ZxxBBzjNZvGOjTwKXdp3d3rjjPU_-j-_gdtjv5gLfmYIj1B38Q>
    <xmx:hMX2ZxNNSfJuvAxDp9xO0SWnE-fS-BXNmQC58QhzWw6zdg6N_mdO1g>
    <xmx:hMX2Z2-nPMiDODoA32x8v_0dKdjR_nnG-oLQHkp3Q9M4e6aKkVE78Q>
    <xmx:hMX2Z5Wge92GtyaDEGLI183cU08bOwRg4SO1HkNtRsT7GqRIXWthog>
    <xmx:hcX2Z7N9Ktx2fDKJkAO2JgajqSKTD_M2mC25xHyhiM5sboGm52Uxnvkx>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 62B552220074; Wed,  9 Apr 2025 15:07:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: Tbf81c49526c64944
Date: Wed, 09 Apr 2025 21:07:17 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
Cc: "FUJITA Tomonori" <fujita.tomonori@gmail.com>,
 "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>, linux-um@lists.infradead.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 "Logan Gunthorpe" <logang@deltatee.com>,
 "Stephen Bates" <sbates@raithlin.com>, "Danilo Krummrich" <dakr@kernel.org>,
 "Dinh Nguyen" <dinguyen@kernel.org>
Message-Id: <ab0490cc-ce86-4492-a088-fd2ae03f1475@app.fastmail.com>
In-Reply-To: <CAMuHMdWtgSjxeGYJVNzeWPOCd9nUWeKQnCtFQaROQ1o=r_-QwQ@mail.gmail.com>
References: <20250409061129.136788-1-fujita.tomonori@gmail.com>
 <CANiq72mbci8kxEx5jrq=HVc6WKuJqq8NCLzNsjH1wFcJNoHm+w@mail.gmail.com>
 <CAMuHMdWtgSjxeGYJVNzeWPOCd9nUWeKQnCtFQaROQ1o=r_-QwQ@mail.gmail.com>
Subject: Re: [PATCH v1] um: fix incompatible argument type in iounmap()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_120751_401550_049320A0 
X-CRM114-Status: GOOD (  12.38  )
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

On Wed, Apr 9, 2025, at 19:07, Geert Uytterhoeven wrote:
>
> On Wed, 9 Apr 2025 at 16:48, Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>> On Wed, Apr 9, 2025 at 8:16=E2=80=AFAM FUJITA Tomonori
>> <fujita.tomonori@gmail.com> wrote:
>> >
>> > Align iounmap() signature with other architectures.
>>
>> Most indeed have `volatile`, but nios2 and m68k don't -- Cc'ing them
>> just in case.
>
> Indeed. Apparently the volatile keyword has not always been there...
> Why does iounmap() need the volatile keyword?
> Why does pci_iounmap() not have the volatile keyword?

In the old days, a lot of drivers marked MMIO pointers
as 'volatile void *' rather than 'void __iomem *', so iounmap()
and the readl() family of accessors need to be compatible
with that type to avoid a warning.

By the time we introduced pci_iomap()/pci_iounmap(), this was
no longer common, so they never needed it.

In theory we could go through all the old drivers and
also remove the 'volatile' markers from struct members that
store __iomem pointers, but there is no practical benefit to
that.

     Arnd

