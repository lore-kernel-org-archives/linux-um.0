Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F940C02188
	for <linux-um@archiver.kernel.org>; Mon, 20 Jan 2025 09:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GifyBYqwhbXXiciRpSVP6GZLq9+XbKa4YYeydloaZ78=; b=dtPUn50ynerAJbtH685wbvTByZ
	SUlXGVnH1Nkcy+E5SUZP+J48TfgLOdNrpNDPmmSNqb0rkMLD5ruA4kVxY/kTEqoQkv2LrmLT/A3v7
	dRTp6nVU4o2vgC4SA93aXbucLpj38wwr2Qw2ddl0kzi0wd7FX30Hz8UXTO9oelaI4Qp4LC4f9ybj0
	GV2Uq6f+9zGxVXrgnsDFULuxDhGptAI22qB8gCbJuH4sYiuoSkXr0M/ISGeGMUXrYjfN4cJZ8ktEE
	AuzNKXvS/ys80T0vdCwN3/6d40MgcZLBeC70Ux8BGkQkgjMlJ0ISwvL368R0aDrKOX9yP/opuxkQd
	0bOb7J9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tZoZ9-00000005Ged-3xnU;
	Mon, 20 Jan 2025 09:59:31 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tZoWU-00000005FxU-3nRa
	for linux-um@lists.infradead.org;
	Mon, 20 Jan 2025 09:56:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=GifyBYqwhbXXiciRpSVP6GZLq9+XbKa4YYeydloaZ78=;
	t=1737367004; x=1738576604; b=CKyttcI6OUNWqnhH7vmIhJfMiH+1HkEHhvNMURahAi6IeO5
	63kJVBUONoMBx9fjfUrrS/fXNzxgQ2BD7fvPprp7MRbQF6Ebw9yECyp1GJ0pZBPZYG+0z+36qjS6C
	3+pFQDfiFP5KnBJd90qGtLf3ihsbnZMuDIBgfgjAGIegCp/FYh2qC2ltVKpJxI8UrDsUqSr46K2XU
	DNYLWzRd2WtWQCOft44CN7Y+Xsug7cUMYOtKWdkXecYoVoxu/e+ND5UbTDzvrY9eTwMRP0Kqg+LaA
	9WRUU7oeRrju9yCZ3EM3y7OOx/UL+k6IllGtm2OMYBxqvNR7yAcrO3NXSdFqMd8g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tZoWL-00000003SKL-3y65;
	Mon, 20 Jan 2025 10:56:38 +0100
Message-ID: <3ab03a41da31bd20a0c386559c102a153db86ff1.camel@sipsolutions.net>
Subject: Re: UML failing at "Failed to initialize default registers" on
 kernel 5.10
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Thomas Meyer <thomas@m3y3r.de>, development@efficientek.com, linux-um
	 <linux-um@lists.infradead.org>
Cc: Richard Weinberger <richard@nod.at>, Johannes Berg
	 <johannes@sipsolutions.net>, Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Date: Mon, 20 Jan 2025 10:56:36 +0100
In-Reply-To: <74506C86-D705-4B68-8779-BB839B305B9B@m3y3r.de>
References: <20250119172535.42b4bca5@crass-HP-ZBook-15-G2>
	 <74506C86-D705-4B68-8779-BB839B305B9B@m3y3r.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250120_015646_954061_C691736D 
X-CRM114-Status: GOOD (  17.76  )
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

On Mon, 2025-01-20 at 07:07 +0100, Thomas Meyer wrote:
>=20
>=20
> Am 20. Januar 2025 00:25:35 MEZ schrieb Glenn Washburn
> <development@efficientek.com>:
> > Hi Benjamin,
> >=20
> > After applying the close_range patch, I'm now getting a failure at
> > runtime where the last line printed from UML is "Failed to
> > initialize
> > default registers". The host is on Debian 11 at kernel 5.10.216.
> > I've
> > bisected the issue and it looks like the bad commit is: 3f17fed2149
> > ("um: switch to regset API and depend on XSTATE").
> >=20
> > On another machine which is on Debian 12 and kernel 6.1.119 the UML
> > binary compiled from v6.13-rc1 runs fine.
> >=20
> > I notice that the bad commit appears to be using ptrace in a
> > different
> > way. Perhaps there is a difference in how ptrace operate from 5.10
> > to
> > 6.1 kernels. I've tried debugging this without much success, as GDB
> > can't be used. Any idea on what's going on here?
>=20
> What processor does those machines have?

Some relatively old CPU or maybe inside a VM?

I would guess it is the same problem as reported by
https://lore.kernel.org/all/20241203070218.240797-1-sj@kernel.org/

Please try applying
https://patch.msgid.link/20241204074827.1582917-1-benjamin@sipsolutions.net
and check whether that fixes it.

Benjamin

