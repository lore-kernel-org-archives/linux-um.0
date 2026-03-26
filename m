Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E4410AB82A
	for <linux-um@archiver.kernel.org>; Thu, 26 Mar 2026 21:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/RfNIxQKYIUQw14uhGh95D145k5nMWsOXW6Q5/pdSXY=; b=FID3ifsC6T/J+t4XI0OqgVSVJU
	cFjAdzG2ipNVZ4b7eeTA4eOSc6Xdot48EHdCRA25mzQx5FrtQmnzgkHzboytVBO9fF/CO4QYGqDRO
	882e6ZagiVIrccSLeeazp28oU+UxWQ/J2cYIpokM2ydor+LyZLayZuSd/FpH93N0HX4K0iKweQi6g
	tCWgT2j/y5jUM2cb2DCgyo2Xa61JsbYqf+7kT4hP6ybTnnVaXIIOJu/bkWbn446RiMX0jCBzUU3yD
	O6tncOTQf2XhoE1LdhXKmfjhpgQdQqGSe2PCqs5RvV0DWMNKGe8IecbDS9N/yMvspY60U4o25JzY6
	orHn2Nxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5sL0-00000006Fp9-425e;
	Thu, 26 Mar 2026 21:33:58 +0000
Received: from fout-b5-smtp.messagingengine.com ([202.12.124.148])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5sKx-00000006FoD-31I3;
	Thu, 26 Mar 2026 21:33:57 +0000
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 539C31D00217;
	Thu, 26 Mar 2026 17:33:52 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 26 Mar 2026 17:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774560832;
	 x=1774647232; bh=/RfNIxQKYIUQw14uhGh95D145k5nMWsOXW6Q5/pdSXY=; b=
	IqMDVtdy9g3dNXgBMcJk+Fp8v+OY7nMFAksZR5I3dKQs/pgnaPLGfcCyGhi4aVyc
	s89Zcud45a2CiZ9yyMK4PuF1EOB8yUb3WVnIvT4GofP2S47gqvcYCpFmJOfaK5Y+
	KOc+agOMOn6DJ2PfKjMqOMaLTktYz8TexeDDdslrrZ3Y5yiTURS/f35oGGD+09Y6
	sXrfaZKwKn7C5lupvsFmk0x81toqerRu418G0pUGq6hC1uP/9jYxwWbyZf+bazou
	6XnYpjG6S0tQVQAdhhBFbX8WBzAqxLBnZAjvxsLffwRfy/BTApMN9h5uREDwD0zQ
	m1wi5i+tYDinsj7+okztaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774560832; x=
	1774647232; bh=/RfNIxQKYIUQw14uhGh95D145k5nMWsOXW6Q5/pdSXY=; b=L
	Lg61lWUQRpa5QRAliKcb5POX6yAcwUI0CN1HB0waBRaDhO0KKDghAxEPcbdyiiY9
	fXZn41nDBH8tNiGNBBJ5Mxk2Wl4Zgozj9uQK/7Si3ail04diJxgnNwqD1f16bx1N
	KA4N7tNulPLr1ULFKid2JB+H3cj5O9FBHHin6MNDLmC6AuDl9ZMFuZPbqt+J5mAS
	xc5d44SI0INI9Q4j+2/a27p/4WC8ylhPqB2qiVdtXSqzyVNHQt46QjNRHTLM3wDw
	gZtHREbrzp1lm4wQ9ROzSksT8ZUVo1lNiKxBBMO98KVE1JjBSkCG8SQSvO8h0Vje
	vY3hn/uAhrdrVmoZMWaTQ==
X-ME-Sender: <xms:P6bFaZLAEEBV3bwCDeAZPmOSFJwnzpkHCftpSnS8W1WdOa0CTq6GQw>
    <xme:P6bFaf_9S1JQLWU0MdN0d9J9bDLLmp1dF-WUzWA4LusG4x5Pn1IejQHX74hxqxXZY
    bTc6bEPtn7nGWANqBVfLEHUSFUZyNR5skKizikSigPJc2R8Qfd_bW4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdekgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepfeelpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehjrghmihgvrdgtuhhnlhhifhhfvgesrghrmhdrtghomhdprhgtph
    htthhopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhrtghpthhtohep
    mhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugiesrg
    hrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegrnhhtohhnrdhivhgrnhhovhes
    tggrmhgsrhhiughgvghgrhgvhihsrdgtohhmpdhrtghpthhtohepuggrvhhiugesuggrvh
    hiughgohifrdhnvghtpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhr
    tghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptg
    hhrhhishhirdhstghhrhgvfhhlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:P6bFabzGQvj2wxAZfO7oFq_v1ja8RKR7HYucMtfA26YKLazWNFrATQ>
    <xmx:P6bFaYrjXYtdlUeYWsmgjMA4oDcGRCKW-jMdtK9pnhtU3nqkJuf8Wg>
    <xmx:P6bFaRzgw_OcbHg_6LazXrPsPveaVBX5aOIxtPlylfA7b7UQRUcdjw>
    <xmx:P6bFaaol0MvBm8Edvwg7LeY9Kw5WWM57FN7B_4SvuL6j84f9MqF_Ug>
    <xmx:QKbFaY2XZ5RWYMQAUukqG2sMMwP8B1UHXdInUhfkcbGuv_wfeoAAs7Wj>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6AE92700065; Thu, 26 Mar 2026 17:33:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AUJnWW6OA6Vc
Date: Thu, 26 Mar 2026 22:33:14 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Russell King" <linux@armlinux.org.uk>,
 "Christian Schrefl" <chrisi.schrefl@gmail.com>
Cc: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>,
 "Alice Ryhl" <aliceryhl@google.com>, "Ard Biesheuvel" <ardb@kernel.org>,
 "Jamie Cunliffe" <Jamie.Cunliffe@arm.com>,
 "Will Deacon" <will@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Miguel Ojeda" <ojeda@kernel.org>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, acourbot@nvidia.com,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>,
 "Danilo Krummrich" <dakr@kernel.org>, "David Gow" <david@davidgow.net>,
 "Gary Guo" <gary@garyguo.net>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Justin Stitt" <justinstitt@google.com>,
 linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-um@lists.infradead.org, llvm@lists.linux.dev,
 "Benno Lossin" <lossin@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>, mmaurer@google.com,
 "Bill Wendling" <morbo@google.com>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Nicolas Schier" <nicolas.schier@linux.dev>,
 "Nicolas Schier" <nsc@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Richard Weinberger" <richard@nod.at>, rust-for-linux@vger.kernel.org,
 "Trevor Gross" <tmgross@umich.edu>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Message-Id: <641592e3-2354-4238-9eb8-a1f5c2a13126@app.fastmail.com>
In-Reply-To: <acVOL5Psz6kHlhq2@shell.armlinux.org.uk>
References: <20260322192159.88138-1-ojeda@kernel.org>
 <20260323000327.111235-1-ojeda@kernel.org>
 <acEP7tl8pqFA3tK8@shell.armlinux.org.uk> <acUGAsjYvNvTEO92@google.com>
 <CANiq72mzPpkELXis1CiSbKUmBXNQYMiMmjj-7-sYiLh4T_JSOQ@mail.gmail.com>
 <9cf5a94c-0f37-446c-b63d-ddac5674d220@gmail.com>
 <acVOL5Psz6kHlhq2@shell.armlinux.org.uk>
Subject: Re: [PATCH v2 0/3] Inline helpers into Rust without full LTO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260326_143355_797515_A78A2806 
X-CRM114-Status: GOOD (  11.90  )
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

On Thu, Mar 26, 2026, at 16:18, Russell King (Oracle) wrote:
> On Thu, Mar 26, 2026 at 03:31:26PM +0100, Christian Schrefl wrote:
>> On 3/26/26 2:47 PM, Miguel Ojeda wrote:
>> > On Thu, Mar 26, 2026 at 11:10=E2=80=AFAM Alice Ryhl <aliceryhl@goog=
le.com> wrote:
>
> I'm not sure if this is still true, but I believe it used to be the ca=
se
> that the -linux-gnueabi target has one behaviour for enums (fixed size)
> whereas -none-eabi, the size of the type depends on the range of values
> included in the enum.

I checked Debian's arm-none-eabi-gcc, which indeed still has this behavi=
or:

$ echo 'enum { A, B } x =3D sizeof(x);' | arm-none-eabi-gcc -xc - -O2 -o=
- -S | grep -A1 x:
x:
	.byte	1

and I see the same thing for the hexagon target in clang, but none
of the other targets that Linux runs on. In particular, clang always
behaves like linux-gnueabi even when targeting plain eabi.

$ echo 'enum { A, B } x =3D sizeof(x);' | clang --target=3Darm-none-eabi=
 -xc - -O2 -o- -S | grep -A1 x:
x:
	.long	4

I noticed a similar issue with m68k-linux, which has a bitfield
alignment different from anything else on gcc, but uses the normal
behavior on clang.

        Arnd

