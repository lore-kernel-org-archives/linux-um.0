Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAE6E7BD83
	for <linux-um@archiver.kernel.org>; Mon, 16 Feb 2026 10:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fPpuQghjjBLmwcDQFbY9dhkiK1rjd17YsAWDWoD7RXA=; b=gXhxZ/d3kdIm3ye8ql9F8A44DR
	8o1VCLXkjc8G03t4dMRtqJX/FNSsvigOjY9mpBuax9Aw2w7cLfcPdKIF73hUgIS2yQVQIvxvZorJQ
	pTwi0on0E9srLURDpVOdVRJYhKioxauL56umNOtGMEgGwMqjlm4PYlVW46ypnp7vdUlR1vTDrwpZZ
	poA/gN4ahgb36KfJUtQPc4NGKEtChHMkEIxuVjrquIOwN9Niss+tOODgZfVo83GoDDwgmX9Fcwcfe
	R+uo1EUtmJck13HdADHsnAG+v4DqFJcyD7H3Heencbuuqa76ePmjNQyAJcw1fP8d44W+fmzoRYm62
	hJBdl/SQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrvhN-00000006KuA-2oPX;
	Mon, 16 Feb 2026 10:19:25 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrvhI-00000006Ktr-0iy9
	for linux-um@lists.infradead.org;
	Mon, 16 Feb 2026 10:19:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=fPpuQghjjBLmwcDQFbY9dhkiK1rjd17YsAWDWoD7RXA=;
	t=1771237160; x=1772446760; b=U95qVV+QnrOUlN1NS8gRzadeLjRkhn94gdWGiBr2dm0q5Bo
	MO3+PSBEOI3y6C6XigSwXVQPVbGraitf6k1nNJRYcfAAKviBM9MbTBTSxe8DOCIxC8FPX3/ONQuRl
	LHqB6Vjf+Pe/Kde9opuJ+M6JSjRfVWkK1ljKSeD6jJHQSR4OpqqAWl49NZxVRg5QyKDQKJSvOIzi7
	s3o5F9IDse5xjTeqwDxC8/Zl5/Ovn0AmR5AAmFWm2fMxUF3GJV+hLN8dXoAnlB2GZNxo390NMop1A
	8Kw7yjQpAQqj46EwXnStDyV9h2EaHdDkwrNLlAoyxKzk8GP24q5RbYgaMdsrrwOQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vrvh8-0000000APgG-009C;
	Mon, 16 Feb 2026 11:19:10 +0100
Message-ID: <9fc2586e16c2a0fa3599432b19fa7049e561a7f6.camel@sipsolutions.net>
Subject: Re: Mainline UML Rust stable io.rs unused imports
From: Johannes Berg <johannes@sipsolutions.net>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, David Gow
	 <davidgow@google.com>, Danilo Krummrich <dakr@kernel.org>, Alice Ryhl
	 <aliceryhl@google.com>, Daniel Almeida <daniel.almeida@collabora.com>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov	
 <anton.ivanov@cambridgegreys.com>, driver-core@lists.linux.dev, linux-um	
 <linux-um@lists.infradead.org>, rust-for-linux
 <rust-for-linux@vger.kernel.org>
Date: Mon, 16 Feb 2026 11:19:08 +0100
In-Reply-To: <CANiq72khOYkt6t5zwMvSiyZvWWHMZuNCMERXu=7K=_5tT-8Pgg@mail.gmail.com> (sfid-20260215_134720_322640_B137859C)
References: <CANiq72khOYkt6t5zwMvSiyZvWWHMZuNCMERXu=7K=_5tT-8Pgg@mail.gmail.com>
	 (sfid-20260215_134720_322640_B137859C)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260216_021920_225068_520A7C5C 
X-CRM114-Status: UNSURE (   8.19  )
X-CRM114-Notice: Please train this message.
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

On Sun, 2026-02-15 at 13:47 +0100, Miguel Ojeda wrote:
> Hi all,
>=20
> In mainline and next, for UML with Rust stable (but not with Rust
> minimum), I am seeing:
>=20
>       RUSTC L rust/kernel.o - due to target missing
>     error: unused import: `define_read`
>        --> rust/kernel/io.rs:229:16
>         |
>     229 | pub(crate) use define_read;
>         |                ^^^^^^^^^^^
>         |
>         =3D note: `-D unused-imports` implied by `-D warnings`
>         =3D help: to override `-D warnings` add `#[allow(unused_imports)]=
`
>=20
>     error: unused import: `define_write`
>        --> rust/kernel/io.rs:262:16
>         |
>     262 | pub(crate) use define_write;
>         |                ^^^^^^^^^^^

Not sure I understand, the cfg() seems to only be fore 64-bit, but it
_is_ possible to build UML without IO accessors at all, since it's just
virtual, but I don't see how that would reflect in io.rs.

Not sure I can say anything else about it, sorry.

johannes

