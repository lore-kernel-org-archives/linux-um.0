Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1EECCD37AB
	for <linux-um@archiver.kernel.org>; Tue,  3 Sep 2024 17:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IAESczAqoTkqwd1sElm2y6U2dzgfrcTnXqQTQycwhtw=; b=fTiNaXBIWu8oXtAI35B2RYla4y
	y2qSuS8/T05CtNuyYqYnqeax0RGOjfLjYWL0k+CNYb6bMGOOhpLcBLG7/oJ5yKvpfkc879/0Y9KvP
	U65H5cpYTZhrj4z918qi+iuu8W2yuaT4zqcbBe857XZ9M/6MHPI/xi2dxD6ZE7O3j7fa27se8ysYT
	tHWaN2lNSOcAHdtfMSJvQZ139qYPEdazceOw09BhPczTmaL3O/3xVsVf9hPD2SnzveYi1con7zxl0
	ZspefcTJM4m0sRmmrBMToP4V861GaOf1DGhlqgrse+sCUQnXGpUkRsBVQHT5MdkYhPEWIVmJ9LpPY
	4Nd2wlOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slXn7-00000001OKV-2mK0;
	Tue, 03 Sep 2024 17:58:09 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slXn4-00000001OJy-196A
	for linux-um@lists.infradead.org;
	Tue, 03 Sep 2024 17:58:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=IAESczAqoTkqwd1sElm2y6U2dzgfrcTnXqQTQycwhtw=;
	t=1725386285; x=1726595885; b=SWl6yIwwlZoj8dRYSBtpmBe5x/OWoAmxVj6LleiBCCmV6iJ
	UoXWsJ+j8Km92UZKiy0iQCRcvZw+gMVz8dgwTcY3GIb0NrGbBvu5bxMRnsZSIfoVP2ZIRgiu1OyGP
	qb01e4ReDYR3BNd8QRR3iwnrzeG8gnI6yBqRRU2UVhM4BLqPrbBJFALePANqNdjmaRX2NgFgUdNt5
	4j5uo1RUXGyZl98ree0wWgUq9E0NFhp7YCZfGWpm50eOwqK22drXxf/2NwN26MZnnoFmOC06srp+o
	DFElhVRVBm+W9nbah82nLaA1gWKTYs7yF0fEJUMeXa9SvMsCcveVMMT/FM+PS/2g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1slXmU-00000002un7-3JPR;
	Tue, 03 Sep 2024 19:57:31 +0200
Message-ID: <a163db239ffe31fbe1921f8b0bfdcfa47fd355f0.camel@sipsolutions.net>
Subject: Re: [PATCH 1/3] rust: Introduce HAVE_GENERATE_RUST_TARGET config
 option
From: Johannes Berg <johannes@sipsolutions.net>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, Masahiro Yamada
 <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas
 Schier <nicolas@fjasle.eu>, Richard Weinberger <richard@nod.at>, Anton
 Ivanov <anton.ivanov@cambridgegreys.com>, Thomas Gleixner
 <tglx@linutronix.de>,  Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,  x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Miguel Ojeda <ojeda@kernel.org>,  Alex
 Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice
 Ryhl <aliceryhl@google.com>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jonathan Corbet <corbet@lwn.net>,  Alex Shi <alexs@kernel.org>, Yanteng Si
 <siyanteng@loongson.cn>, Nick Desaulniers <ndesaulniers@google.com>, Bill
 Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org, rust-for-linux@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, llvm@lists.linux.dev
Date: Tue, 03 Sep 2024 19:57:29 +0200
In-Reply-To: <20240903-mips-rust-v1-1-0fdf0b2fd58f@flygoat.com>
References: <20240903-mips-rust-v1-0-0fdf0b2fd58f@flygoat.com>
	 <20240903-mips-rust-v1-1-0fdf0b2fd58f@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240903_105806_474720_A2A38BA1 
X-CRM114-Status: UNSURE (   9.41  )
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

On Tue, 2024-09-03 at 18:14 +0100, Jiaxun Yang wrote:
>=20
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -32,6 +32,7 @@ config UML
>  	select TTY # Needed for line.c
>  	select HAVE_ARCH_VMAP_STACK
>  	select HAVE_RUST
> +	select HAVE_GENERATE_RUST_TARGET if X86_32 || X86_64
>=20

There are no other sub-arches support for UML, I don't see much point in
adding the dependency here.

johannes

