Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077F4CD37AB
	for <linux-um@archiver.kernel.org>; Tue,  3 Sep 2024 17:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y+arkmin7IrtnrxC716PfKvGm9iZOGIbnIg+bOi+aIo=; b=2FpKRLVvodupkJDVCArxTZMbbU
	VBVTbZQiwAIv1E/W00k9wRFawMMlUe+JzqP6YEOSaE37xWzx5WCUqbPqCCNONolWH3dZJVpkcpIlg
	HZrqyTTiPrhlGCMDhKIj3niyiHbCwXHlJennkWON6TrKA4d+uNlYxE11AajzMOAkZKjFx7s5elfl6
	H7QhVbAu5SWclM9+UaMsNX8f2CqMQrKXoUUXeS2TNX4SeGrZyuVJljuxSf28xQ62ehTPe64N9zIyJ
	YZgZCEzj3jSKEmslSzJcfbkM75DyoZ1kthf1VykFGv2zv/FEgJNojn4lh0w/HwfdzKXf9wEzfy/aZ
	8dJrn8eA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slXix-00000001NhU-2x1U;
	Tue, 03 Sep 2024 17:53:51 +0000
Received: from fhigh4-smtp.messagingengine.com ([103.168.172.155] helo=pfhigh4-smtp.messagingengine.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slXiu-00000001Ngy-0zjg
	for linux-um@lists.infradead.org;
	Tue, 03 Sep 2024 17:53:49 +0000
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 68C06114042B;
	Tue,  3 Sep 2024 13:53:47 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-05.internal (MEProxy); Tue, 03 Sep 2024 13:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1725386027;
	 x=1725472427; bh=y+arkmin7IrtnrxC716PfKvGm9iZOGIbnIg+bOi+aIo=; b=
	U+bGjh8mdTAX1nzhGvj+0KSvst8EoKfRs6jE51nKSJ8fkXSgx2kHZ3QK1Ji+Ac8/
	ArbK1e9Vfs8kGh46HonmvHicVv0kEP4lKf8z2wVt01W/5TCkLLRt8l2Mmc6lMjm9
	DnB/OdIA3kif5lUsipJuR9vqueuoC00VsOQO3+i+hADNrRzxMbyxd3DGpKLQzLCF
	SisJDuebPSoUIjmAc6IAH562bAmn23yKHYAzwYhTsyJlgG/jlrTkxLcAwCJU/a2i
	yJKz+dwOyr2qnqixnHOokSgSbXqJDenulQTE7nSYV9Ru4usRF/kQIwFyBPYwGsXo
	eud5c2qjisMXQ5UHCnJ8WA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725386027; x=
	1725472427; bh=y+arkmin7IrtnrxC716PfKvGm9iZOGIbnIg+bOi+aIo=; b=S
	+xtKE2Ou84B1JGoS6guNadUxWhMtdy9byp9zUGNukT0bBdhu07nlbFl6CmOVfJVb
	XLMCprHFkIJtSA+nXcy8+6OIBdZsIPZ0Rqw5bKXfouXGPool0WXZYU/y1VA7mvMr
	K9rL0vR8jHn2cYOzRnLvDAo4FJEVzb3Rq5eScHDnrUVzO/fHEELIwPp/3WeDQ2hl
	0HHrkkvNM6awC4098fJeKQdhKvdbsASH+e6AZ60i+Q3ZKm14ltpW4h7fTvCLcZpH
	n7YKxr881Z0amsmyOrk31GNF5WlsYUhL23pH54hLYkokGG1G4qLV4C1/72EMEizg
	QS1181wTlQ+Vs4xkdefPQ==
X-ME-Sender: <xms:KU3XZjw3f-PUZ0bP3mhPNMXw-gBRMSSIGMI7Tr1-4XfgdIVSRzX_ZQ>
    <xme:KU3XZrSIEGQfYSJb7elFqAkxFuHNzFHfudWXvdf8MkzZG8rcuRTzS6uVJSUSinQEP
    9M3pom12jE7N6RoX7s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehhedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdflihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgse
    hflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeejheefuddvtdfggfdvffek
    teehhfelgfdvvedvkeeuffefkeehheegvefhveetjeenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghho
    rghtrdgtohhmpdhnsggprhgtphhtthhopeegtddpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepthhssghoghgvnhgusegr
    lhhphhgrrdhfrhgrnhhkvghnrdguvgdprhgtphhtthhopehmrghrkhdrrhhuthhlrghnug
    esrghrmhdrtghomhdprhgtphhtthhopegrnhhtohhnrdhivhgrnhhovhestggrmhgsrhhi
    ughgvghgrhgvhihsrdgtohhmpdhrtghpthhtohepnhhitgholhgrshesfhhjrghslhgvrd
    gvuhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegr
    lhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghoqhhunhdrfh
    gvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhighhuvghlrdhojhgvuggrrdhs
    rghnughonhhishesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:KU3XZtVELIuUWCjB_H51B0bfjCfgu0bPZJNxAqTK5EhbY3OFeiqxjw>
    <xmx:KU3XZtgY8HYJZDlDu4TDqyiRptkB-pOCwWZqRgwlAtOvEes_JE0qZw>
    <xmx:KU3XZlBo8M38s5af9pRPjW4nmajpsAzHjwYsdoxHt222G_HSj4EoKg>
    <xmx:KU3XZmLmureBvPCrTZgXFqiC3sV5NVBZM_zU_QQfewZk2c6CmcovtA>
    <xmx:K03XZjyodlcgDb3CrMYIhVRYNxMGQUVulZi4axGDqisfa6lJe-qC8_s1>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id ACD5B1C207BB; Tue,  3 Sep 2024 13:53:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Tue, 03 Sep 2024 18:53:25 +0100
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
Message-Id: <d9591a84-9a0f-4046-9b2a-437061f6882b@app.fastmail.com>
In-Reply-To: <CANiq72=z1yJm-B_ie=GfueOF1qksaSD9txgFU1YQo2tZx0qQPg@mail.gmail.com>
References: <20240903-mips-rust-v1-0-0fdf0b2fd58f@flygoat.com>
 <20240903-mips-rust-v1-3-0fdf0b2fd58f@flygoat.com>
 <CANiq72=z1yJm-B_ie=GfueOF1qksaSD9txgFU1YQo2tZx0qQPg@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: Enable for MIPS
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240903_105348_376927_C05881E9 
X-CRM114-Status: GOOD (  11.65  )
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
=8D=886:44=EF=BC=8CMiguel Ojeda=E5=86=99=E9=81=93=EF=BC=9A
> On Tue, Sep 3, 2024 at 7:15=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygoa=
t.com> wrote:
>>
>> We don't use builtin target as there is no sutiable baremetal
>> target for us that can cover all ISA variants supported by kernel.
>
> Since we should try to go away from using `target.json`: what was not
> possible to enable via e.g. `-Ctarget-features` or other flags? i.e. I
> see the `+mips*` features there in the supported list, and from a
> quick test the data layout also seems to match, but I assume I missed
> something.
>
> If it is not possible, then we should definitely ping upstream Rust ab=
out it. :)
Hi Miguel,

Thanks for your review!

Triples defined for MIPS bare-metal target is surprisingly lacking, we d=
o have
little-endian 32-bit bare-metal target mipsel-unknown-none but big-endia=
n and
64 bit variants are missing.

Also, those triples all assumed +mips32r2 as baseline ISA, but kernel ac=
tually needs
some other ISA variant features.

Thanks
>
> Cheers,
> Miguel

--=20
- Jiaxun

