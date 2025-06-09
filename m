Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC0B2C5B552
	for <linux-um@archiver.kernel.org>; Mon,  9 Jun 2025 18:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S/FjFxKpAdC4u4b3cIdM5daWkH+0O6bOnA8sgvinuo8=; b=RfQU1Zr5YKj5/Hqr0qHD4XXOOT
	G08ixbSsl+S2Mhm2eTpZQ5/ZPrhVeSpOwssyrD5IBomkGw9T2wR2nE8v6MWQvcj09V1qpZLmYGQoc
	M1F9PTNBrbd0VHUBuZ5u0RZEmk/o2AYaQOLze2t7dYug4wk8y+CeJhROTwoMuBNqDvXaPkKOyc3sA
	HcNDxgRGPrIlAGwnGaz021CE08kaNDBcUE6qvfR3vJ7mpf5tD8Ep0bStfP6AdHWESMAXQ3251Pl3Q
	vfdBkKxZ1XfyrpnTmEyJbpqy/fxEfX/+IuodYHkrfFu7y/91OQ+WS1Xu+X4hbyj+RQ9QpU5a6HGi3
	zu+Z8WxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOhSy-00000004vUO-07Bj;
	Mon, 09 Jun 2025 18:43:28 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOgDu-00000004njX-3SqG
	for linux-um@lists.infradead.org;
	Mon, 09 Jun 2025 17:23:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=S/FjFxKpAdC4u4b3cIdM5daWkH+0O6bOnA8sgvinuo8=;
	t=1749489830; x=1750699430; b=Z5QBvqLfjdbHShzJvFUIs5rQodjKwR00Go+EHMpvWCOJOVF
	Q1URcrOirCXsg+BDFOE2sQWYDCAURIJZ2Q78BBNkptfrzzzJnKfP3rybT+9iDJKy7pMKOnkGtlLvh
	wpSA5e2U2i+/o4ns5JYz/MPM3JLtyIRi6yOrp0groIsESPWmXtz8UWxddEDB4rWTrKNba9nTTyQOO
	hUIIESBxz95PrPFhOIOY4w+cBWKlr3boZ0g1EPP36TBQu9QaVOutek1H6h/4BqJoZO1/BeZe/dsnR
	BX/yAlLVyyHRM2A38o1mdk5/Sd1+Mi9QbLbavAfxEx5Z+WlekppPaEhbFqUKcU8Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uOgDr-0000000EeVH-2QqQ;
	Mon, 09 Jun 2025 19:23:47 +0200
Message-ID: <e8a409845399538585e547b361a4210c21b5215f.camel@sipsolutions.net>
Subject: Re: [PATCH] um: fix execve stub execution on old host OSs
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>, Yonting Lin
	 <linyongting@gmail.com>, development@efficientek.com
Cc: linux-um@lists.infradead.org
Date: Mon, 09 Jun 2025 19:23:46 +0200
In-Reply-To: <370a1b96fb029ef2afe7fcaf4b9daad40804a730.camel@sipsolutions.net> (sfid-20250609_191550_661037_A6821748)
References: <20250112140736.1fcb25c3@crass-HP-ZBook-15-G2>
			 <20250607042248.87877-1-linyongting@gmail.com>
			 (sfid-20250607_062301_404489_59405A7C) <6b4428e5ec42c926fcc9b6d2fdb9202fc6e87fe8.camel@sipsolutions.net>
		 (sfid-20250608_203858_438156_E309C860) <370a1b96fb029ef2afe7fcaf4b9daad40804a730.camel@sipsolutions.net>
	 (sfid-20250609_191550_661037_A6821748)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250609_102350_862017_2DE7C14D 
X-CRM114-Status: GOOD (  19.04  )
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

On Mon, 2025-06-09 at 19:15 +0200, Johannes Berg wrote:
> On Sun, 2025-06-08 at 20:38 +0200, Benjamin Berg wrote:
> > >=20
> > > But my host kernel is 5.4 and fails to compile these pieces of
> > > codes because
> > > there is no this syscall in my older kernel.
> > >=20
> > > I was wondering if you are working on this issue. If not, I will
> > > try to=20
> > > make a draft solution to review.
> >=20
> > I was not yet aware of that problem. Most likely only the one in
> > start_up.c is a problem for you. All the other ones probably pick
> > up
> > the correct definition from the Linux tree already.
> >=20
> > One can probably solve it by moving the code into another file. Or
> > maybe by adding an entry for __NR_close_range into common-offests.h
> > and
> > using that.
>=20
> Seems though we might need to add checking for close_range to the
> seccomp init though, it's actually (much) newer than seccomp. Or just
> not rely on it?

That check is what is failing now :-)

We already introduced close_range use earlier, but in ptrace mode it is
just about hygiene rather than actually being safety relevant. So we
just accept the syscall failure there.

Benjamin

