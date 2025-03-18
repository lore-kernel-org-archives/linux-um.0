Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7503C282EC
	for <linux-um@archiver.kernel.org>; Tue, 18 Mar 2025 10:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RU1GG8P/fyn/N99uW51RxZ6VdojKLsD0tL5X3G1oLKI=; b=EsUZlU4uNB1xzSnodFE8vsUGRW
	ZpskvkpJ0QVVlDPyjgCn5XQX0PUL/0eqhkluQuz33LnidsmjERu/z9Miv4aYo68fHFQtdA2FeWkiL
	P38nu4LEVAtyUHURWJC0F3yCAjTV9eCjlATebBxaHBZYkhjy84sY6hh2/P+InsLnIA7G/Tr35rBqI
	bwl4fwsP7usO/rItRDkEFKLSAvbduq9rV4N6hzXKSQ531CNWMTaLYAbRgWFtCNOo2bF7dCwq8PaBC
	riAIvxNxYiWlZu89oYY07vBljg4GXvE0toW3/udu5atuagjr7/23SLrtM+i0Y1j9ch68jPEeteyVf
	72NCecfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuU0H-00000005T1A-1Oel;
	Tue, 18 Mar 2025 10:16:57 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuTxz-00000005SW6-201B
	for linux-um@lists.infradead.org;
	Tue, 18 Mar 2025 10:14:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=RU1GG8P/fyn/N99uW51RxZ6VdojKLsD0tL5X3G1oLKI=;
	t=1742292875; x=1743502475; b=k2IFakppTQUP4z0DWa37aJTyOpCTra7x5ommyhhyJEn+yk5
	3tu2IRuQrLhnPkh6UJsKVgZDJpn3xSTGLNGfURIa4HgFCTycWaXVy/D4gp5s1XfAqcoITzOthSJjJ
	mpKsxYCXM/LBGycCw03JSu+pFPh5nFoL6FuIv3fSwvm2P4WBKUQPl1/yFvrnOnludFXjgh9KnsOq7
	0497pN0gkG9deMzxmus9L8PE4XHsvcHoPV3upWL5PiRkdT3tsCqocWsGQjqCKeof3IY3qlPkk7Wmk
	qsPVkUz8gyLfXTShfOuDA3l7YqzzQM5hYsaPDPEWWecgNSA05iGgybCojI1B647w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tuTxt-0000000FD90-1rsq;
	Tue, 18 Mar 2025 11:14:29 +0100
Message-ID: <1a1ea09ae8cd82db0b8c3205bfd179bacfce4700.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] rust: pass correct target to bindgen on Usermode
 Linux
From: Johannes Berg <johannes@sipsolutions.net>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, David Gow
	 <davidgow@google.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov
	 <anton.ivanov@cambridgegreys.com>, linux-um <linux-um@lists.infradead.org>
Cc: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>, Miguel Ojeda
	 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng	
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	 <bjorn3_gh@protonmail.com>, Benno
 Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich	 <dakr@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers	 <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt	 <justinstitt@google.com>,
 rust-for-linux@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Date: Tue, 18 Mar 2025 11:14:28 +0100
In-Reply-To: <CANiq72nnwopFAdETMhgkCfN9dj+JJZQ=K1BKz_A_xUViis7Avg@mail.gmail.com>
References: <20250208-rust-kunit-v1-0-94a026be6d72@weissschuh.net>
	 <20250208-rust-kunit-v1-1-94a026be6d72@weissschuh.net>
	 <CABVgOSnwkDihbRzYF3uh3At_x0MgOB42_E8sUAD8moKwx+zjRw@mail.gmail.com>
	 <CANiq72nnwopFAdETMhgkCfN9dj+JJZQ=K1BKz_A_xUViis7Avg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_031435_520414_25E63EC1 
X-CRM114-Status: GOOD (  15.40  )
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

On Tue, 2025-03-18 at 11:10 +0100, Miguel Ojeda wrote:
> On Tue, Mar 18, 2025 at 9:07=E2=80=AFAM David Gow <davidgow@google.com> w=
rote:
> >=20
> > Is there anything holding this up for the upcoming merge window?
> >=20
> > Miguel: I'm assuming you'd rather take this (and possibly [1] as well)
> > via Rust, but if it goes in via the uml tree, that'd be fine by me,
> > too.
>=20
> We try to get arch maintainers involved (and everyone else, of
> course), i.e. it is up to them. But I see only the list was Cc'd, not
> them directly, for some reason -- doing it here.

The list is fine, but the patch wasn't even CC'ed there, so we don't
have it in our patchwork:
https://patchwork.ozlabs.org/project/linux-um/list/

> Ideally, maintainers get involved and pick their own Rust-related
> patches, but I can also do so with an Acked-by from them, which would
> be nice.

I was just picking up um patches, but given that it was a series, and
changes rust/ rather than arch/um/, I think it's probably better if you
do it, so:

Acked-by: Johannes Berg <johannes@sipsolutions.net>

johannes

