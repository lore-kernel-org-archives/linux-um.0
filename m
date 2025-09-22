Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44451CAC592
	for <linux-um@archiver.kernel.org>; Mon, 22 Sep 2025 17:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JqGwuLdtfhO757m4LeuXnKCWOoq71+1IP2gYTz8bM8s=; b=tbf8p/ipuNYg37g3QDu+T9W5We
	rlMCUqLfBeCNna86sX51rYArh9n6QhiwV8j+1n+7jXsL1jaALEtCxzoG5vwDPEB2y7qCbM5D++pkW
	xNkriZ1pfG0E/QpnQC9cU28a6NI3G/7cpVImj1RKYMPmUSyUNF33n6/bGfh14A8FDnS0eo5NEkRpH
	ZUIF4sOoaG6BfORgub0DSJuZX6+8xmaH4N2K17q9b7INEbwW0TnSReGfzklWN+UOcEXf0R2Zid1p2
	SvLQIKQtpbtdqpM6vedzO78tjG+syKUaJy0n19yjsM3LyagPZ3HSHTELqOBwF6cibL5wri7GoGEou
	qhdXxwpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0k0n-0000000B41C-3lX4;
	Mon, 22 Sep 2025 17:07:37 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0k0l-0000000B40N-1kJH
	for linux-um@lists.infradead.org;
	Mon, 22 Sep 2025 17:07:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JqGwuLdtfhO757m4LeuXnKCWOoq71+1IP2gYTz8bM8s=;
	t=1758560855; x=1759770455; b=HM9GRtq7NoraaZm8z9APFSd/K08Co+xsUPua/TM4ILN+3KK
	W4z5OTnZIWdvxg5H9VHHAzh4Ncq1gKSLtP8wlrB6Xkf0uLmWvZBbzT/0riH5XJh422razYGYYZzIw
	10h0QT9F9B9mhsURcSJ1d4qfCPDzmWaMRU/04Z+Srktb1Tbn8RscG5OJ5tzR3G/5y8F1pt+a+trTe
	tImsggKavDUMXdBF5NW/RxFkgAPEIe4Jpk3bPlb57o7AqZWp2CtyF8pKD+rsBmKQ3boaLgAUZ61LA
	ViAEg3ny5ksejdkI1YOZ85HbQDvXkYeabbIqNKXgD3Hoxy7w5SuPjp33YrdZ1gbA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v0k0e-00000004sVf-2Dfv;
	Mon, 22 Sep 2025 19:07:28 +0200
Message-ID: <96ae8e726480a36a37d472106b761a141394e845.camel@sipsolutions.net>
Subject: Re: [PATCH v2 03/10] um: vdso: Implement __vdso_getcpu() via syscall
From: Johannes Berg <johannes@sipsolutions.net>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Tiwei Bie <tiwei.bie@linux.dev>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, benjamin@sipsolutions.net, arnd@arndb.de, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	tiwei.btw@antgroup.com
Date: Mon, 22 Sep 2025 19:07:27 +0200
In-Reply-To: <61ae09df-d65b-4c9d-a0c1-7de915246590@t-8ch.de> (sfid-20250922_180452_263852_EC16D5FF)
References: <1568f254-7963-4015-91ed-7630d5d87881@t-8ch.de>
	 <20250922045020.48158-1-tiwei.bie@linux.dev>
	 <495a5594-8ac6-4b7d-be6b-7c176b741c21@t-8ch.de>
	 <76b5ba35f864764100c9a5a00d50d8fa4276cd98.camel@sipsolutions.net>
	 <21755635-74d4-4fa4-8ffd-371c17630fdf@t-8ch.de>
	 <366bb558c3fd23b9a80008d923f29ed0234e17b9.camel@sipsolutions.net>
	 <61ae09df-d65b-4c9d-a0c1-7de915246590@t-8ch.de>
	 (sfid-20250922_180452_263852_EC16D5FF)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_100735_453866_B5037320 
X-CRM114-Status: GOOD (  31.29  )
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

On Mon, 2025-09-22 at 18:04 +0200, Thomas Wei=C3=9Fschuh wrote:

> > I don't know if I'd say "just overhead" - depends on which path is more
> > optimised in a typical libc implementation? I'd basically think it's
> > identical, no? You either link to the vDSO, or a __weak same function i=
n
> > the libc?
>=20
> The code also needs to be built and maintained.

Yeah, fair, though the vDSO doesn't really do anything, and if we do
want to use it then having a working version beats having to re-do it
from scratch, which=20

>  AFAIK __weak is only for
> the compile-time linker. The vDSO call will be an indirect call.

yeah, I looked at the links you'd sent earlier only later ...

> > > > I mean ... on the one hand, sure, it doesn't really do much after t=
his,
> > > > but OTOH it lets userspace actually use that path? So might be usef=
ul.
> > >=20
> > > What advantage does userspace have from it?
> >=20
> > Right now, none? But it's easier to play with if you have the
> > infrastructure, and I'm not convinced there's a _disadvantage_?
>=20
> So far that hasn't happened. The disadvantages are the ones from above,
> nothing critical. But of course it is your subsystem and your call to mak=
e.

Yeah, kind of agree, though I'd like to actually use it - especially in
time-travel mode - but haven't really gotten time to add it. Having it
maintained in-tree is a bit nicer in case of global updates, but yeah,
ultimately it's not really all that important either way.

I guess we could get getrandom() pretty easily by taking the x86 one.

I actually have half a patch somewhere that rejiggers the UM vDSO to be
more like normal architectures, using lib/vdso/gettimeofday.c and making
the build more regular etc. Maybe I should dig that up and try to make
it work entirely - it was part of a previous attempt of adding the time-
travel thing I mentioned.

> > Huh, hm, yeah I forgot about that ... 32-bit. Yeah, agree we should jus=
t
> > kill that. I'm not even sure it works with the host kernel trapping
> > there? Oh well.
>=20
> Ack, do you want me to send a patch? This was my real gripe with the UM
> vDSO. I want to enable time namespaces for all architectures but these
> need to be handled in the vDSO properly. For the 64-bit stub vDSO it's
> not a problem as the syscalls will work correctly.
> But the interaction with the weird 32-bit logic on the other hand...

I guess? But I'm confused by what you say about it being related to time
namespaces, the vsyscall stuff doesn't really _do_ anything, assuming it
works at all? It's not like the host actually could be doing anything
other than syscalls there, which are intercepted? If it were doing
anything else, it wouldn't work in UML in the first place?

johannes

