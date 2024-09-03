Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA77CD37AA
	for <linux-um@archiver.kernel.org>; Tue,  3 Sep 2024 17:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=37evq7OXVd1o3LryU5tBnSFjiHmbXWuaq7kxeMtQ1tU=; b=Rwj//syT+Ppu7S2oR2esKybrT/
	bCfiq2JS6FY9KjzEvWw+UKBCo8+Z9UbV0zaioDrTyNRWsgdtuD//yZW2gfPgAodL1r82D19O2iHSO
	Zp8ShGgE9RPCokuM+xroRp1kQFSjd1JxDwRs+TtSoIJWel6HmXBfFRE6yCQYSlGOre0u6cWC8DKZz
	EkRywUQhbHbAPRx0YNcA37av0xDqn/4J0PT44aAAZdl2/HvmFznSgzEbL071lJQxafPtrTFgBb+ue
	KTPt8VFONHy43gMo1cPa5iFvqznlZ0SfWYEgAhzI6ASNcXEzjfS53kEFVrVIzff/YRk53AGeZzadZ
	DnT/Jrtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slXkE-00000001NtC-0Av2;
	Tue, 03 Sep 2024 17:55:10 +0000
Received: from fout8-smtp.messagingengine.com ([103.168.172.151] helo=pfout8-smtp.messagingengine.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slXkB-00000001Nsd-0HJv
	for linux-um@lists.infradead.org;
	Tue, 03 Sep 2024 17:55:08 +0000
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id F1D7713804C2;
	Tue,  3 Sep 2024 13:55:05 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-05.internal (MEProxy); Tue, 03 Sep 2024 13:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1725386105;
	 x=1725472505; bh=37evq7OXVd1o3LryU5tBnSFjiHmbXWuaq7kxeMtQ1tU=; b=
	Moo2wn3Y6WCs1URJbxvK5gtu1ZToa7Zni3vxmE7obzQyRJn20r6WyvC8N1mtKBzr
	KZH/LoPhTOQpCggk3Hok4R0oPTHD5mjQLQ7ln6evNRvneQXl5lg/FiXdUQnh3YoL
	42QIvYA0qO6zCJYrSAciDBmHEAMC3gDywagFgeL9mxAe1mpxxbaK8IYYQe5p+wu2
	nJarnfvLVpgt1/o1lZPsJwbp4kPOLq79yjxC2wQB5x0R5p3N9t8ZyowTYp7vmP38
	Ov+iZ6ciNYzuPDf7vBjw8HnA1mYyM9wjYWI1iy6YAAUYuu2ag41m0O8chUfAjGZI
	WLH4wdpI0r95308Z3B6E5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725386105; x=
	1725472505; bh=37evq7OXVd1o3LryU5tBnSFjiHmbXWuaq7kxeMtQ1tU=; b=O
	Kci0VBmFXv6/+sVXOuqU4tP/J/aP5vCYWtQclpXo5zcw21hK17LVCpTsH5kn8wAS
	A0cybhaOCzrd96lcRRTJqFvzKZGnOlpEc/EWR8kMCs2R6r6kx7arFurMeIwUoNdF
	qdwj4TRrKYTWODDxZsWXPOx6/4UogwJNaprgkUJ99NWgNhESG/Skng6y9q9Wg6ej
	JcIVtpedGrkB5XlsPA9SkJDDTEEICY/ZMcUZr+OBroPFAA2fALELkFc/mYSvDNsL
	SKXTkfs8wuTSabjS6kTXVNhg42RoxTiAZYvPSZlJUwkpBMZE7cyHz05bMMuisl9R
	KnGcLM/jbbVK2hkd1FEGQ==
X-ME-Sender: <xms:eU3XZkeEcPm2N_fIACF3sWlRA7fx7YTTJSUTHkt0htHoJAiE-oylTA>
    <xme:eU3XZmM4KhfyeuTLS12g5pR2gH_GZmOEyuhhC9m1rKDMaVEM9KFeSMQgbmtt9hOK6
    OqBpIwVZGLjKg24T2E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehhedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdflihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgse
    hflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeejheefuddvtdfggfdvffek
    teehhfelgfdvvedvkeeuffefkeehheegvefhveetjeenucevlhhushhtvghrufhiiigvpe
    dunecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghho
    rghtrdgtohhmpdhnsggprhgtphhtthhopeegtddpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepthhssghoghgvnhgusegr
    lhhphhgrrdhfrhgrnhhkvghnrdguvgdprhgtphhtthhopehmrghrkhdrrhhuthhlrghnug
    esrghrmhdrtghomhdprhgtphhtthhopegrnhhtohhnrdhivhgrnhhovhestggrmhgsrhhi
    ughgvghgrhgvhihsrdgtohhmpdhrtghpthhtohepnhhitgholhgrshesfhhjrghslhgvrd
    gvuhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegr
    lhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghoqhhunhdrfh
    gvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhighhuvghlrdhojhgvuggrrdhs
    rghnughonhhishesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:eU3XZlhMR5hSOSE7wF6lDgDyrnutKD2EF9GKEiaqWzvJRzIo-rMN2A>
    <xmx:eU3XZp_99dpfkzk8G_1WmY9G5YXDGtVu7mqZjxXEySvjb4YGFG4Pjw>
    <xmx:eU3XZgubcSmwKeA2j0cL6SRW_KNh_FL5bI9KbTLu4hLKUrkCX-VYyw>
    <xmx:eU3XZgGCta-RgpGuud7BhfyxZYDQmth0-_xvPgAsMauDtBEfrDf2lg>
    <xmx:eU3XZisFZK27rMpmFnW2pejSCaE8ngfxf4dAhYjYTZGret47doCBW3xG>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 23E241C207BB; Tue,  3 Sep 2024 13:55:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Tue, 03 Sep 2024 18:54:44 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
Cc: "Masahiro Yamada" <masahiroy@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nicolas Schier" <nicolas@fjasle.eu>,
 "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Wedson Almeida Filho" <wedsonaf@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@samsung.com>,
 "Alice Ryhl" <aliceryhl@google.com>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Jonathan Corbet" <corbet@lwn.net>, "Alex Shi" <alexs@kernel.org>,
 "Yanteng Si" <siyanteng@loongson.cn>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>,
 "Justin Stitt" <justinstitt@google.com>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org,
 rust-for-linux@vger.kernel.org,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 llvm@lists.linux.dev
Message-Id: <e7d4e600-d8a0-42d6-8bf5-6877f52b2d18@app.fastmail.com>
In-Reply-To: <CANiq72mKZukJ+V_fXtvfBxN-WVBBOr1pZJ3iKrWgagTrJC4pdg@mail.gmail.com>
References: <20240903-mips-rust-v1-0-0fdf0b2fd58f@flygoat.com>
 <20240903-mips-rust-v1-2-0fdf0b2fd58f@flygoat.com>
 <CANiq72mKZukJ+V_fXtvfBxN-WVBBOr1pZJ3iKrWgagTrJC4pdg@mail.gmail.com>
Subject: Re: [PATCH 2/3] MIPS: Rename mips_instruction type to workaround bindgen issue
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240903_105507_201535_9BEF7321 
X-CRM114-Status: GOOD (  10.60  )
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



=E5=9C=A82024=E5=B9=B49=E6=9C=883=E6=97=A5=E4=B9=9D=E6=9C=88 =E4=B8=8B=E5=
=8D=886:43=EF=BC=8CMiguel Ojeda=E5=86=99=E9=81=93=EF=BC=9A
> On Tue, Sep 3, 2024 at 7:15=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygoa=
t.com> wrote:
>>
>> We have a union and a type both named after mips_instruction,
>> rust bindgen is not happy with this kind of naming alias.
>
> For this sort of thing, you may be able to add it to the block list at
> `rust/bindgen_parameters`, so that you don't need to change any C
> code.

Thanks for the tip!

Given that it's trivial to avoid in C code I'd still prefer to fix the a=
ctual
code.=20

Thanks
>
> I hope that helps!
>
> Cheers,
> Miguel

--=20
- Jiaxun

