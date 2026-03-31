Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449ED1061B37
	for <linux-um@archiver.kernel.org>; Tue, 31 Mar 2026 11:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=45JgVcq0EgVfNtDgS04MgTxf5U+SjaNRaHQGB6s03l8=; b=blYNRYWPbSbHefU3uRz7lS7Of9
	XRq1o27xiqRqvQd49MqyPQIwy+7ojcYUdft9iZkoZE7LA0341jL+6c0D5QC1iDC1Whr4s3JPsXsXw
	Bk4qJzNjALKg6+zdwaxH+4/tK7t/cryC18W8vqj20UITgh+7Zb0cDUE8Xx6qr/rJqXw6KHlym5t1w
	qtYCKdnQ7/aUeZycLv6TzTHzlMafg2cMdX/nuuDqMue3ARQh0nUWKav3Hg/YgcMHGhydwJk4Q+S4n
	elklNTh4uIJK904CfkBDXdw8YJ5pTQCBrwlDpCyFet3Da+MdXYrdjHmvy0L6K+g+gNqnRlc8SML7M
	egQammBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7XWJ-0000000Ctj0-2bEV;
	Tue, 31 Mar 2026 11:44:31 +0000
Received: from fout-a4-smtp.messagingengine.com ([103.168.172.147])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7XWG-0000000CtiJ-3ygK;
	Tue, 31 Mar 2026 11:44:30 +0000
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 062CAEC0235;
	Tue, 31 Mar 2026 07:44:27 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 31 Mar 2026 07:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774957467;
	 x=1775043867; bh=45JgVcq0EgVfNtDgS04MgTxf5U+SjaNRaHQGB6s03l8=; b=
	Jxap8/9S4qYqMwrKvG6LkL4qmDzEcuGMGDJ3Cz2bZ0vxUUfbPt7c1qTw+rKEDpy+
	H96GkWp6u3KcKGr2qct0JUN/2X9EmZCHETETy4o/MQnOwTCKCxywAKErWV01t/tS
	AoB2WNCyADBh/I9ydKmyNcfSk8ifT5ztBoh/vqUAviwELJGFfA0crVeDB4mK11WL
	ahkiAwGQbh1GkVlIRlDvp2kBiECEdrZZ9pCtAZL7MoOKBwYlnwTHGMo5EVr3xqyk
	bkBC7R4FFB5K20KVin1XLG6iOgUZ4X6ut43zPKpdCsTq4lcYKZLpTsWfI9o1mQ45
	GxMWe28tebPtm8H9rPSwPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774957467; x=
	1775043867; bh=45JgVcq0EgVfNtDgS04MgTxf5U+SjaNRaHQGB6s03l8=; b=k
	uLyiPMoH1o8hur4JjSJuRWTEfIETsH7xtk6oTrvGkWtl/WpnqWZdsuVd4dFow7CJ
	t+EYzO1ktwqkE+meCgWhVgE0SUn45Sx6RnyYx7a5iqlTvHIrhneDetOw102WDFrn
	tHoOlJFw1F4AQROF04cLDYAraPS84KvCc3xdral9L9YKzdr540GQnAUdmYLN9qMU
	smmRyd0iv77Vr4+N8sj8wYfQMhws9jKeyqvdga6in+0k1BsP5d042X5ThI3t95oK
	2SeiZr3KvLiL1X8b8C/UbrsQoECRWzBT0Au56Ghgdk8zvRuOf+vArZ4A2c0rdx8k
	ITZ0Aq5KQmVCecXlXCtyw==
X-ME-Sender: <xms:mbPLaafs0nlOk9Q4g9puvZHHMG2cSvGX_65TGc17KWG9rifVmyVbAg>
    <xme:mbPLafCg7zZEDtKSpnR3PPX8iUEmuKvzcvuZ-KilZn-zxuKNxNjbUVlrscqT1UKdy
    5ehLghXHQayIclsu-xXgnbc_PNokmr2xsbYb9aMGM3Phjf5uTlVm-4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    foggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcuuegv
    rhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrhhnpe
    dvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrg
    hrnhgusgdruggvpdhnsggprhgtphhtthhopeefledpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepjhgrmhhivgdrtghunhhlihhffhgvsegrrhhmrdgtohhmpdhrtghpthhtoh
    eptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtphhtthhopehmrghr
    khdrrhhuthhlrghnugesrghrmhdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlh
    hinhhugidrohhrghdruhhkpdhrtghpthhtoheprghnthhonhdrihhvrghnohhvsegtrghm
    sghrihgughgvghhrvgihshdrtghomhdprhgtphhtthhopegurghvihgusegurghvihgugh
    hofidrnhgvthdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphht
    thhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrih
    hsihdrshgthhhrvghflhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:mbPLaXWL4_RbtfLfnHQs8C4tG0ngXTCPv9euc-VB1lto6tqFQyGNcw>
    <xmx:mbPLaU_cG1WcSE-QSkVD9ElI1dukFUPpc53IiCbdiAif50XEkb-z1Q>
    <xmx:mbPLaf3Jw7KAvwSkj2NhSKaJwucaNeK5yqjANIhVWRFTYuRZjmC46w>
    <xmx:mbPLaXfgUsSfpDNbiUxt6RT2rhVcYFtkTJ_DCYi6UKM2ewPiID8SDQ>
    <xmx:m7PLaYahyRZ4gPZWSFwm_OyhnRUM4xeu34i4uTLr4s-lisp1T7JlXocj>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 31988700065; Tue, 31 Mar 2026 07:44:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AUJnWW6OA6Vc
Date: Tue, 31 Mar 2026 13:44:04 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christian Schrefl" <chrisi.schrefl@gmail.com>,
 "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>, "Alice Ryhl" <aliceryhl@google.com>
Cc: "Ard Biesheuvel" <ardb@kernel.org>,
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
Message-Id: <a2c18fec-8ca2-490b-bd9f-bac79672c2f4@app.fastmail.com>
In-Reply-To: <f159850d-5fe6-4329-9703-b355305fd106@gmail.com>
References: <20260322192159.88138-1-ojeda@kernel.org>
 <20260323000327.111235-1-ojeda@kernel.org>
 <acEP7tl8pqFA3tK8@shell.armlinux.org.uk> <acUGAsjYvNvTEO92@google.com>
 <CANiq72mzPpkELXis1CiSbKUmBXNQYMiMmjj-7-sYiLh4T_JSOQ@mail.gmail.com>
 <9cf5a94c-0f37-446c-b63d-ddac5674d220@gmail.com>
 <acVOL5Psz6kHlhq2@shell.armlinux.org.uk>
 <CANiq72=b+cr7Stxph_hXQTmD5crCvwWTqdaGKOJ7W1-66v4i_w@mail.gmail.com>
 <f159850d-5fe6-4329-9703-b355305fd106@gmail.com>
Subject: Re: [PATCH v2 0/3] Inline helpers into Rust without full LTO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260331_044429_289206_1FB01C60 
X-CRM114-Status: GOOD (  14.17  )
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

On Mon, Mar 30, 2026, at 23:09, Christian Schrefl wrote:
> On 3/26/26 6:30 PM, Miguel Ojeda wrote:
>> On Thu, Mar 26, 2026 at 4:18=E2=80=AFPM Russell King (Oracle)
>> <linux@armlinux.org.uk> wrote:
>>>
>>> I'm not sure if this is still true, but I believe it used to be the =
case
>>> that the -linux-gnueabi target has one behaviour for enums (fixed si=
ze)
>>> whereas -none-eabi, the size of the type depends on the range of val=
ues
>>> included in the enum.
>>>
>>> Certianly, when Arm Ltd were proposing EABI, EABI had the latter
>>> behaviour, and I think there were cases where Linux used "enum" in
>>> its UAPI.
>>=20
>> Short enums? I see `c-enum-min-bits` in the armv7a-none-eabi built-in
>> `rustc` target, and indeed:
>>=20
>>     #![no_std]
>>=20
>>     #[repr(C)]
>>     enum T {
>>         A,
>>         B,
>>     }
>>=20
>>     pub static S: usize =3D core::mem::size_of::<T>();
>>=20
>> is 1 for that one, and 4 for the other.
>
> I guess we could use a custom target spec, but I'm not
> sure if that is worth the hassle of adding another one.

The kernel Makefile forces the Linux enum behavior using

arch/arm/Makefile:CFLAGS_ABI    :=3D-mabi=3Daapcs-linux -mfpu=3Dvfp
ifeq ($(CONFIG_CC_IS_CLANG),y)
CFLAGS_ABI      +=3D -meabi gnu
endif
KBUILD_RUSTFLAGS +=3D --target=3Darm-unknown-linux-gnueabi

regardless of the compiler. I think this should be safe
for any combination of C and rust compilers.

     Arnd

