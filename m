Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FCBCD4847
	for <linux-um@archiver.kernel.org>; Wed,  4 Sep 2024 07:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sz6ZXnptgCPAXnQbA/qYwtmPVRCJO0RfwwN0oTEtnVE=; b=FuUHaIa0qEMmy/YYJHmremqLYX
	a3ON62EEQFXFtoRNNZoB7OUfXec3Zq6m4x7oYgBqIy+mKkad2qB10PPY5Mo+5H/BVPgMz+QYuy9WX
	Teen7p5TkRjITQ1Nem2pgG21zvKKoqQttclfAVxeojtKaJt/IqQr5nddoer2UrNAVH0T9v2R+1DOo
	O4IlUOGVF25If6iuE+FJSNBAXF1IquM+t58aMeKfzhWSzdfY9Hk9tpgVf09NR4ZNeDT23chb6FQAB
	pvQef5o+UgzZkinCuATAvrL5oLm4HCYutowKrhSFuSPwEj+lW9Sd7zUMsuUurTKkM4jeNJx1mGS9O
	Y9oCjkQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slkb1-00000003DgS-2seQ;
	Wed, 04 Sep 2024 07:38:31 +0000
Received: from fout8-smtp.messagingengine.com ([103.168.172.151])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slkay-00000003Dfx-1G5A
	for linux-um@lists.infradead.org;
	Wed, 04 Sep 2024 07:38:30 +0000
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id CA46F138017F;
	Wed,  4 Sep 2024 03:38:26 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-05.internal (MEProxy); Wed, 04 Sep 2024 03:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1725435506;
	 x=1725521906; bh=sz6ZXnptgCPAXnQbA/qYwtmPVRCJO0RfwwN0oTEtnVE=; b=
	rfNHq06S+/FbiJrjcoOAISVrJY1dv8k4g+acB71qeIe0yoy8tEYuiuX6duhHot0X
	pnl4Iv+jSo1NbgXY27Sm6bOV4qZGIbsxcYq1KA6O7qp3Gv/QXwLbfO8thQJHWS3Q
	4cLKRt7uqNAaIKrt2TBz5bcums1IZHW3zWq2AysZvWT1FXBRMTYO6Ug7R8MAVuoB
	3rWV9jPuGkruOmjZMEU/e+2OAMc/GE9oK8kvjNfq6TMiuw5V9pqid8KdfeXQEG0s
	Y1tdgKvxCvK0hle8lBgZUObKDBQqSNtQDQJN6p+CK2QxAVMDWch6RSMqs0CL2BEM
	99k/hnes1guZnUoy8uSlpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725435506; x=
	1725521906; bh=sz6ZXnptgCPAXnQbA/qYwtmPVRCJO0RfwwN0oTEtnVE=; b=B
	iFOEq1sVqpbBj1w9LMAEZgDjMzrAxYO5IHVpeDFFhntFPf128oUA/18aSRhUV9lt
	SjTwO1VpWlAVLcHFnIK53Uh65HRATfjliGXh4mjrwEVBt7ypXoKoq7z6ztq4VmKS
	j9oWFRgn4sfUWeeZbX7j/P4W3nU0xEzcO4z3m0NAdClE47/ikZ0WlI1KHqSqrgiy
	STUHs83TLL2fjm39nos9JCPme3s5LawmO/KM9/Q2AQZakvZ67FNHsfftPHcObHoz
	MmaLCMTA2TfvqKjTLC+pmp68EZbbIoTFXuDQWfGlk09BUpDTn4jOwgURKst5b4IF
	p5c/y86CfrkJwoV8fqdTg==
X-ME-Sender: <xms:cA7YZpsfXod5rMH1QTlm0kTIPWxJqwPiszVY5eBC46ewJFhh3iw5CQ>
    <xme:cA7YZifTUghUpf-WKUM0pFh-ulBKmpAalims9KaeyULKphrFiIFxxqcDgax3OHQUi
    ywmBY4QNB45dm8KCc0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehiedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdflihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgse
    hflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeevueffteefkeehhfdthfel
    feffjedvffekgfeiuedugeekgeejvedtffeiledtueenucffohhmrghinhepghhithhhuh
    gsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomhdpnhgspghrtghpthhtoh
    epgedtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsphesrghlihgvnhekrdgu
    vgdprhgtphhtthhopehtshgsohhgvghnugesrghlphhhrgdrfhhrrghnkhgvnhdruggvpd
    hrtghpthhtohepmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtohep
    rghnthhonhdrihhvrghnohhvsegtrghmsghrihgughgvghhrvgihshdrtghomhdprhgtph
    htthhopehnihgtohhlrghssehfjhgrshhlvgdrvghupdhrtghpthhtohepghgrrhihsehg
    rghrhihguhhordhnvghtpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilh
    drtghomhdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgt
    phhtthhopehmihhguhgvlhdrohhjvggurgdrshgrnhguohhnihhssehgmhgrihhlrdgtoh
    hm
X-ME-Proxy: <xmx:cA7YZsxJTWa516B1amj6UWURaphYpQG7A_CZANJjeHUVSV9pyNfcWg>
    <xmx:cA7YZgMgKTSMs2eNfwkAsPGl3QfC0ElKD-WFY0SQxWw9BMzetozcJQ>
    <xmx:cA7YZp8XTYFkwebvCNZsdfsBNO62gvaU4g82IG_p09N7BGZtG4pzAA>
    <xmx:cA7YZgWFhnrDB95x5DNuYD5ky5Bo6vtbXwU8siGEdfpJ0b4-IAyzCQ>
    <xmx:cg7YZu8KItrX9IUQjFOMUxdHGLKL6ymyzV556PeKCfMCW0g4shDq4p8v>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 680AD1C207BB; Wed,  4 Sep 2024 03:38:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Wed, 04 Sep 2024 08:38:04 +0100
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
Message-Id: <a6959bc0-f0bb-425b-b3b1-3123d3b809b5@app.fastmail.com>
In-Reply-To: <CANiq72mvTTgyTjDCWBz_kOdY1f4gopAtWxyC4P4c+Lr0YVkzLA@mail.gmail.com>
References: <20240903-mips-rust-v1-0-0fdf0b2fd58f@flygoat.com>
 <20240903-mips-rust-v1-3-0fdf0b2fd58f@flygoat.com>
 <CANiq72=z1yJm-B_ie=GfueOF1qksaSD9txgFU1YQo2tZx0qQPg@mail.gmail.com>
 <d9591a84-9a0f-4046-9b2a-437061f6882b@app.fastmail.com>
 <CANiq72m5iFcqRU_qdUCZkoV8ayPhtQQq3TTEDRUYfMEsnNqTDg@mail.gmail.com>
 <6f6f04d7-55b3-4714-9bcd-cb4e1ae6c86a@app.fastmail.com>
 <CANiq72mvTTgyTjDCWBz_kOdY1f4gopAtWxyC4P4c+Lr0YVkzLA@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: Enable for MIPS
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_003828_615184_10050EBF 
X-CRM114-Status: GOOD (  15.10  )
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
=8D=888:01=EF=BC=8CMiguel Ojeda=E5=86=99=E9=81=93=EF=BC=9A
> On Tue, Sep 3, 2024 at 8:32=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygoa=
t.com> wrote:
>>
>> Ahh thanks for the elaboration.
>
> You're welcome!
>
>> However, kernel supports many ISA variants that are not defined by an=
y rust target
>> triple, I'm not really sure if it's appropriate to define them all in=
 upstream.
>
> They need to be in upstream Rust somehow, because upstream Rust does
> not want to stabilize `target.json` since it is too tied to LLVM (as
> far as we have been told). Whether that is via `-Ctarget-feature`, or a
> new `-Cglobal-target-feature`, or specific flags like `-Zfixed-x18`
> (originally `-Ctarget-feature=3D+reserve-x18`), or (many) new target
> triples for different combinations, or something else, it depends on
> the case and what upstream Rust wants to do.
>
> That is why we should tell them what is needed, ideally in a new issue
> in upstream Rust, and link it in
> https://github.com/Rust-for-Linux/linux/issues/355 (please see that
> list for similar examples).

Seems like this topic is covered by an existing issue

Reported at:
https://github.com/rust-embedded/wg/issues/792#issuecomment-2328133517

Thanks!
>
> I hope that explains a bit more the context.
>
> Cheers,
> Miguel

--=20
- Jiaxun

