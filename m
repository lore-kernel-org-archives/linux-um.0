Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB12ACFD31C
	for <linux-um@archiver.kernel.org>; Mon, 24 Nov 2025 07:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s8+iYPcWI2cddaAf5HGDey5M4eeRKOeY9STUQfUYtpQ=; b=TVVwYBZg+i/MkEv8SlOEbzPb/J
	yQcXgO9LQN2qp0YuYOfYA37/vmXWTHn3VYkSM0njj1pfoQ5Npr1eE5kvlHoeXzZu8mg3rjlAlod80
	9dPRk0bf6UvGIqCwrHDXCrdaDaGXKqk9nUcbMA5980JM/sR2Rqn4dBOGdPjn4Bn9uvrew92uL7WH1
	8UMYiYH20hpHK+uUDaffEPns9IwxvvNXQ/AV3ok+gbUW/OUx3PCLEN7etgPHm4OCUoK5rN0oyYR7t
	sUx9solOvxSxhFihnQDAeDVAJvKm33omfqBk4Eoks5zB0zanWIsoneO399v6jfM+NHVtnFNg/enAp
	mgNHa5Aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNRKX-0000000BET3-3fnR;
	Mon, 24 Nov 2025 07:49:49 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNRKV-0000000BESE-0H1H
	for linux-um@lists.infradead.org;
	Mon, 24 Nov 2025 07:49:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=s8+iYPcWI2cddaAf5HGDey5M4eeRKOeY9STUQfUYtpQ=;
	t=1763970586; x=1765180186; b=aKBTDZYuA4uFAa2FDXCI49e/d50o6OXUFDb36S4q1SH8XPt
	NyGrWUB9lmu5fZ+Uh7PD6eCSGtqkQ8eTtmAPJejT4m1dxIWW+UJdaBG71CH2mJO9Xd6xvy0wReAms
	YDzdBVqjPENrfNokLko7aHGIYRQfeYjGlw+F6EovsPZax6AkMljons0MGr8+8Uz4FW/Ww8GAjhHt1
	bfy8rgL6FlIVHGPrjyc3AvvK3ZGsaYGOz5RtC7eC1cQCCCYWAcFs2WB1lkm+ZWYxyTsSHsvgt+grC
	VI86SZEsxSuMc21gzj5OcT2Zpx+rKA7sUVjx/aFuOFbpQH6JLL1Jx+X+9Q+whPGQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vNRKK-00000008JVI-1WqF;
	Mon, 24 Nov 2025 08:49:36 +0100
Message-ID: <bfb512e24f365695534313b375fc0c38d0a843b2.camel@sipsolutions.net>
Subject: Re: [PATCH] arch: um: Don't rename vmap to kernel_vmap
From: Johannes Berg <johannes@sipsolutions.net>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, David Gow
	 <davidgow@google.com>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov
	 <anton.ivanov@cambridgegreys.com>, Miguel Ojeda <ojeda@kernel.org>, Paolo
 'Blaisorblade' Giarrusso
	 <blaisorblade@yahoo.it>, Alice Ryhl <aliceryhl@google.com>, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Date: Mon, 24 Nov 2025 08:49:35 +0100
In-Reply-To: <CANiq72=MXHZ2XswxkfzLqUEPwriNy=_sxAQpOYoYW8iNgyuJ8Q@mail.gmail.com> (sfid-20251123_180818_160099_E5AEF588)
References: <20251122083213.3996586-1-davidgow@google.com>
	 <CANiq72=MXHZ2XswxkfzLqUEPwriNy=_sxAQpOYoYW8iNgyuJ8Q@mail.gmail.com>
	 (sfid-20251123_180818_160099_E5AEF588)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251123_234947_135004_97D0F141 
X-CRM114-Status: GOOD (  22.81  )
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

On Sun, 2025-11-23 at 18:07 +0100, Miguel Ojeda wrote:
> On Sat, Nov 22, 2025 at 9:32=E2=80=AFAM David Gow <davidgow@google.com> w=
rote:
> >=20
> > In order to work around the existence of a vmap symbol in libpcap, the
> > UML makefile unconditionally redefines vmap to kernel_vmap. However,
> > this not only affects the actual vmap symbol, but also anything else
> > named vmap, including a number of struct members in DRM.
> >=20
> > This would not be too much of a problem, since all uses are also
> > updated, except we now have Rust DRM bindings, which expect the
> > corresponding Rust structs to have 'vmap' names. Since the redefinition
> > applies in bindgen, but not to Rust code, we end up with errors such as=
:
> >=20
> > error[E0560]: struct `drm_gem_object_funcs` has no fields named `vmap`
> >   --> rust/kernel/drm/gem/mod.rs:210:9
> >=20
> > Since, as far as I can tell, we no longer actually link to libpcap, it
> > should be safe to just remove this define unconditionally.
> >=20
> > (If it's not, we can possibly either disable DRM Rust bindings under
> > UML, or move the redefinition of vmap behind some config option.)
> >=20
> > We also take this opportunity to update the comment.
> >=20
> > Signed-off-by: David Gow <davidgow@google.com>
>=20
> Nice, thanks for this!
>=20
> Yeah, I guess we would otherwise need to do the same kind of "wild"
> macro replacement in Rust code to support this or conditional
> compilation, and neither sounds good.
>=20
> If it is not actually needed, then this sounds like a win-win.
>=20
> It seems it was indeed gone in commit:
>=20
>     12b8e7e69aa7 ("um: Remove obsolete pcap driver")

Indeed, that was just missed during the removal, we can't link to
libpcap any more.

How do we want to take this patch in, and where is it needed? I hadn't
planned to send a UML PR to -rc still, but I guess I _can_ if needed?
But if anyone else wants to line it up through a tree (rust related?)
that has pending work anyway, that seems fair too. In which case:

Acked-by: Johannes Berg <johannes@sipsolutions.net>

Or it's not that urgent because all this came up in -next now? I didn't
really see (or fully understand) all the build bug reports.

johannes

