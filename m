Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E0DC54FAA
	for <linux-um@archiver.kernel.org>; Wed, 28 Aug 2024 13:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KWjiXUmmEV93LF5mPfA43uk7dNEjWIw+zBwu8kWYnKU=; b=UZ9gmtmiDd0GqKhgKEcgIl3YEa
	qWoQDulA1FuqDPl5E+XVZlgi5acgy+EvpRKO8tjTCdr1hHR895Qu1RHF3x4Cqa7Fdp6kbkB2tOYUx
	kGlph0HJsReJSbKANPqgNaY6HuX6MPpNOpF2PrmOm3zfof1roLwgJXlkBjqbAOEoXQxfBYLJi3ugR
	62sJJl+rGQWXuxT3CcNV/1XNF1bBJQBQv+es6mHOBk7xx1WvcsNNXeB+iuRdMDSNYvMuS5gBVbiy7
	p/lj/Or6pzyGNGVViDwvCWCTe+WH93JahFxpRtb1tStW0+YkaEU66mnsIa/FDOYwr/5EHsEXHgfQx
	UHCLRYlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjIHo-0000000FRMK-0pJa;
	Wed, 28 Aug 2024 13:00:32 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjIG8-0000000FQmE-3NPh
	for linux-um@lists.infradead.org;
	Wed, 28 Aug 2024 12:58:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=KWjiXUmmEV93LF5mPfA43uk7dNEjWIw+zBwu8kWYnKU=;
	t=1724849928; x=1726059528; b=XBT5l3ysQ3EK0uV+dIogJKcvtVF29LMgmS+FPN1sGqXQ/O8
	Pa733AIEJwTmPkEOTBzPh3iacGAk/cvmPmCZ833KThx7TZd/e1e88jXTbemLA4qErbPlfAKEZeqdb
	9I5aN80tGOdkB/IymjuTk0z2I1k6DDioOS3vGhYOsAIdhyg1IV4LkmgpBHqZmhjC3GPsTUg8pEwjA
	J2IVeCerNA7smv/zO3Iw0vYIp8GH/5KQUArWNH8XNS2wENvPBRUPfX0E7gdOk7l0oRdjeOhvswUv1
	YPqMLEV2Q4Qopl9bvtkjx/HKd9iHwDY+iLu5Tb+FNkDqsEigDFSpc0J1z8vmR7GQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sjIG4-000000079YR-05cK;
	Wed, 28 Aug 2024 14:58:44 +0200
Message-ID: <d66103380179771d0655288a4d0d95e990876132.camel@sipsolutions.net>
Subject: Re: [PATCH] um: make personality(PER_LINUX32) work on x86_64
From: Johannes Berg <johannes@sipsolutions.net>
To: Maciej =?UTF-8?Q?=C5=BBenczykowski?= <maze@google.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard
 Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>,  linux-um@lists.infradead.org,
 x86@kernel.org
Date: Wed, 28 Aug 2024 14:58:43 +0200
In-Reply-To: <CANP3RGdxrKHsERYG+yW5fpRUrahkBJbHCKD24v182ZNKuJgfwg@mail.gmail.com>
References: <20240813234755.3615697-1-maze@google.com>
	 <efbb6394805f11de27cace9817418744d8e69506.camel@sipsolutions.net>
	 <CANP3RGdxrKHsERYG+yW5fpRUrahkBJbHCKD24v182ZNKuJgfwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240828_055848_877721_B4019C8E 
X-CRM114-Status: GOOD (  18.67  )
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

On Mon, 2024-08-19 at 11:46 -0700, Maciej =C5=BBenczykowski wrote:
> On Mon, Aug 19, 2024 at 5:23=E2=80=AFAM Johannes Berg <johannes@sipsoluti=
ons.net> wrote:
> >=20
> > On Tue, 2024-08-13 at 16:47 -0700, Maciej =C5=BBenczykowski wrote:
> > > Without this patch:
> > >   #!/usr/bin/python3
> > >   import ctypes
> > >   import os
> > >   personality =3D ctypes.CDLL(None).personality
> > >   personality.restype =3D ctypes.c_int
> > >   personality.argtypes =3D [ctypes.c_ulong]
> > >   PER_LINUX32=3D8
> > >   personality(PER_LINUX32)
> > >   print(os.uname().machine)
> > > returns:
> > >   x86_64
> > > instead of the desired:
> > >   i686
> > >=20
> >=20
> > But ... why should it work? UML has no 32-bit compat support anyway.
>=20
> Well, that's certainly a fair point.
> On 'native' x86_64 this works even for 64-bit processes though.
> I wonder if that, in itself, is a feature or a bug...
>=20
> In my case I was writing some debug code (to print the environment
> some test code is running in, since I think it was failing due to
> running 32-bit code in PER_LINUX32 on 64-bit arm) and testing (the
> test code) on x86_64 UML.  I was surprised to discover the difference
> in UML vs my host desktop.
>=20

Alright, I have no idea. This doesn't really seem to do anything else,
so I'm not sure what the point is... It _was_ introduced for compat
though, but obviously the binary doesn't suddenly change to a 32-bit
binary when you do this :)

Maybe the x86 maintainers have any other comments?

johannes

