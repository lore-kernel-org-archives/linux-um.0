Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240D7D10399
	for <linux-um@archiver.kernel.org>; Fri, 25 Oct 2024 15:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FG34UmyXAT04DoNkH82y96vBUnCYUqsqFnRbXL+A/jE=; b=edEVRswTip0kdqv7ZczdUqKxbn
	2f3oikVHfkaP+tenr02emkb//EAiZcTcBBc/LxfKEQf6mJZ0Xnmp5TvJcnulo5ft5NUNBAuCHikUV
	AbAsC8Xs6O/7F38AZT7F0XA42AGQWFh59up2swle6dmVk2loyVv1NO8qkR/8+PtDDsYZYnPs0ONEZ
	3jv7NnHGUx6NSlaLF55rc9w1YxHXQFCN4kRBOpZ2/ztZg31+G/MVwD5eSzPoxNDicwhZAtvBekCg+
	zDh6Z4U9U5P8Lw7/JRplZOaxb+Eg56IccqK33TDaDxraU21xrIgf05Qjc7POEhLP9pJYhHF1MfCni
	p98csrig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4MS6-00000004I3z-31GE;
	Fri, 25 Oct 2024 15:42:14 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4MDZ-00000004F5r-3yIa
	for linux-um@bombadil.infradead.org;
	Fri, 25 Oct 2024 15:27:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=FG34UmyXAT04DoNkH82y96vBUnCYUqsqFnRbXL+A/jE=; b=eoGUo/SAP2mmavVabei0lZ9Gun
	lhImTrmN4m435S4IIhmb1pozsDw8V+MWp7jWErxb71PzZGOXb1EGuhtAQcwjYVuCoeMJ1EsBUdGnQ
	vnSNtXeRVBuWI8nLgFbeLAeSSGwtftRYIhGMTQXY2eHaial52Znxd9SOfcjX+NIINunfH4TKvXTK2
	sUPksfsq1HytrH78FSqhqyTEdO3BS/nXhz+K2ZaLPQyf2oZa6PPj9RP3ktntVNFYlfWuurQ5HGb8q
	22JaxT/bCMBQ4wzE0kDz77lSThFLbHtkuA02Gn+vBPXd/dJr+/IzC0prDrK74E4QAPjUiZqw7LrNA
	bC3XwhjQ==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4MDW-00000008y2f-2uIv
	for linux-um@lists.infradead.org;
	Fri, 25 Oct 2024 15:27:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=FG34UmyXAT04DoNkH82y96vBUnCYUqsqFnRbXL+A/jE=;
	t=1729870030; x=1731079630; b=O/nfzbSGFuQaWHAwUbAjnkNMRZFbCm2MWNZviih4ellVCQP
	jRp6T7Y6qAdvgAFOWqdZeyfQej9Ggb1yQUOcP7tR342e2wnNGAeKAfK6wD8kSs54Zy8UQq0F5w0oR
	Ewp2ZWcO6ZmEnudsauLXkyk8DBX7C7tjxmP8EG76eLri3+x61AP3habtu3F8I9aMwBxyzG3kpAOXo
	yl6o9XRLHssDS0FpBJAqbOt2MiKd4IJSyusEcDVvltlvPg+BCTHXBd9frTG9QkyeO9z65W70p57Jy
	x8si2HEonLoS9xJ/rcomdX62i7zz9L1AE6vwRePZE0WfrVfeprmAn8FenqenoHRA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t4MDV-00000004apq-0m9G;
	Fri, 25 Oct 2024 17:27:09 +0200
Message-ID: <e711d2ed2ecc455e6de5b9fd7e904ad34c978b1e.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 13/13] um: nommu: plug nommu code into build system
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, ricarkol@google.com
Date: Fri, 25 Oct 2024 17:27:08 +0200
In-Reply-To: <m2msisnxiw.wl-thehajime@gmail.com>
References: <cover.1729770373.git.thehajime@gmail.com>
	 <82a7ee8b31c51edb47e144922581824a3b5e371d.1729770373.git.thehajime@gmail.com>
	 <ce4a00dadcaf888ff1bf7887b3af722a385e694e.camel@sipsolutions.net>
	 <m2msisnxiw.wl-thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_162710_954555_3C8E9EAD 
X-CRM114-Status: GOOD (  15.86  )
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

On Fri, 2024-10-25 at 22:05 +0900, Hajime Tazaki wrote:
> On Fri, 25 Oct 2024 18:33:06 +0900,
> Johannes Berg wrote:
> >=20
> > On Thu, 2024-10-24 at 21:09 +0900, Hajime Tazaki wrote:
> > >=20
> > >  config MMU
> > > -	bool
> > > +	bool "MMU-based Paged Memory Management Support"
> > >  	default y
> >=20
> > "if !64bit" or something
>=20
> not sure if I understand correctly but where do you suggest to add "if
> !64bit" in this block ?

config MMU
	bool "..." if 64BIT

was what I was thinking, since you cannot allow !MMU on 32-bit.

As you wrote it, the user would get prompted on both 32 and 64 bit, and
get an invalid configuration on 32-bit if they turn off MMU.

> > > +config ARCH_FORCE_MAX_ORDER
> > > +	int "Order of maximal physically contiguous allocations"
> > > +	default "10" if MMU
> > > +	default "16" if !
> >=20
> > Should there even a be user prompt for it?
> > Perhaps "if EXPERT" or something?
>=20
> I think it's already user-editable=C2=A0

It is now, but it didn't even exist before, so nobody would've been
asked. I'm not sure it's _too_ useful to ask the users though? When
would they know how to set it? (Perhaps also add some help text? I'm
guessing it's related to the size of binaries or so?)

> but your suggestion is to limit with 'if EXPERT' ?

Or maybe it should just not be user editable at all?

johannes

