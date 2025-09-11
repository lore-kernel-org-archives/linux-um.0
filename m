Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A6ACA1016
	for <linux-um@archiver.kernel.org>; Thu, 11 Sep 2025 08:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SdyRmw9p5x1dwU7eSbbWZaY8BxsvaFQgaS8zXojilmg=; b=Vi61jl9JphlI9Lj4Uey2D2oSB6
	tJZqL1EnjybPrP1oo4gD/ZMzXDHGlbNz9EWgWUQfaDfcRiQmhYUjgdl7Aq103u6CkulLi7kIDlOyC
	cQ8bMLPfzg7TnnvxH0ZklTkf1ujg/VnZ+yDqC6maxz3pCdjrxueH1FdTJFGjwgwxWbXaLBdE+BRd4
	QiB/SzrBLef33EVFw76AgzVTYc/dX19z8GaRb7XKXsWpnTkTTswd89L30G9MJpsGG3tpNY/1CM7uo
	z6pnP24QYgRqBRTY/989uUHyBqWHLU6zPuIJUnUdlPSV/UxHbAajmvCFsPUbOT+Cl5O8lWZ1k/pWy
	kNVt2X8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwcKc-00000001iud-1uTO;
	Thu, 11 Sep 2025 08:07:02 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwcKZ-00000001itK-2h9m
	for linux-um@lists.infradead.org;
	Thu, 11 Sep 2025 08:07:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SdyRmw9p5x1dwU7eSbbWZaY8BxsvaFQgaS8zXojilmg=;
	t=1757578019; x=1758787619; b=jQdvL/XwJRPSzvFIBQOL8uzUnhlMu/VSj26OHP+DTmVFpG3
	8LCzHWL+/kHS6Np5n8zNL07tG7Y/uw5iHuCkyddYfU9qzRrIfR822+cbSmxe73VaGIyWGa/XZNiY6
	V5416OjaBcFdhfg/8X1I3WkXYf7uvZA+ghD9vtubvWKDdskhknejsfA2wJL7Az+8VzmIG57KqAwC9
	fFx1ZEX5NaO8V2CWRi+V3x4X1s3oW1ddgFeEwwEUpea3fj7XMKuFyAp6A37xl1gNIwwe9wtlKxVZ2
	Bl6hpUmCH2nfSq0vVaWOZ10pxlQk6fE0GYimtG63xBBzK97I9O5dS8a93QW2tEeA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uwcKU-0000000Etn4-280i;
	Thu, 11 Sep 2025 10:06:54 +0200
Message-ID: <75ba2109fcdfb8a1629fdf5f6b4e58694b975c9f.camel@sipsolutions.net>
Subject: Re: [PATCH v2 04/10] um: Turn signals_* into thread-local variables
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Tiwei Bie <tiwei.bie@linux.dev>, johannes@sipsolutions.net
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	tiwei.btw@antgroup.com
Date: Thu, 11 Sep 2025 10:06:53 +0200
In-Reply-To: <3c4bc989c4f10609eab699b26e8331bc878c2a0a.camel@sipsolutions.net>
References: <f402a7b5ddfe92a8fbbc1460102cac7b5a5864b5.camel@sipsolutions.net>
		 <20250911043434.2897892-1-tiwei.bie@linux.dev>
	 <3c4bc989c4f10609eab699b26e8331bc878c2a0a.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_010659_678774_1BC53BDC 
X-CRM114-Status: GOOD (  20.77  )
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

Hi,

On Thu, 2025-09-11 at 09:37 +0200, Benjamin Berg wrote:
> Hi,
>=20
> On Thu, 2025-09-11 at 12:34 +0800, Tiwei Bie wrote:
> > On Wed, 10 Sep 2025 14:15:28 +0200, Johannes Berg wrote:
> > > On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> > > > From: Tiwei Bie <tiwei.btw@antgroup.com>
> > > >=20
> > > > Turn signals_enabled, signals_pending and signals_active into
> > > > thread-local variables. This enables us to control and track
> > > > signals independently on each CPU thread. This is a preparation
> > > > for adding SMP support.
> > >=20
> > > [...]
> > >=20
> > > > +static __thread int signals_enabled;
> > >=20
> > > How much glibc infrastructure does __thread rely on? More
> > > specifically:
> > > Some time ago we had a discussion about building UML as a nolibc
> > > binary,
> > > what would that mean for the __thread usage here?
> >=20
> > We would need to parse TLS data (PT_TLS) from the ELF file
> > ourselves
> > and properly set up TLS when creating threads using clone().
>=20
> I guess right now we cannot use PER_CPU variables in these files.
> However, my expectation that this is possible when using nolibc, and
> then it should be simple enough to replace the __thread.

That said, I do believe that the allocations from the libc itself are
problematic. A lot of the mappings from UML are there already (i.e. the
physical memory is mapped). However, I believe the vmalloc area for
example is not guarded.

So when pthread allocates the thread specific memory (stack, TLS, ...),
we really do not know where this will be mapped into the address space.
If it happens to be in an area that UML wants to use later, then UML
could map e.g. vmalloc data over it.

Now, it could be that (currently) the addresses picked by pthread (or
the host kernel) do not actually clash with anything. However, I do not
think there is any guarantee for that.

Benjamin

