Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8053810BA453
	for <linux-um@archiver.kernel.org>; Fri, 27 Mar 2026 09:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XlE8K29BcOci/GJeK99hdrRjgIObqUNFNRdsO2zBvLY=; b=zSmILQB9I1S0B19i5Q9rkQ/hkW
	OC8web2OZcC9PJsVgouYFy31Rxci98Y877UDgKodSNLBjipgKRL1nDn7UQMLrnC6SyYeGkHf+S3Jh
	CIHYHEAcsosg8S3Snv/zeA0p1KXjBXo+bQlVUyasgOsJnujA24P/D8DDELTj/Iy19/QBWUCTB8VpQ
	tX/1IOlMx9WQ617GQ2U8A2kbdOo1pQg5pbjHJTQP2WQ98+Q0TyYHhHfW/U/cPYlLX9eZQfgaEkaBR
	/ASGCHlJ5c4qOGc1lbOrtoMSSyuN8V/nJSir9NoBt+xHT7eovlmLNlqcL0nuc/kbsN9KleSzr1RCg
	oLLMNjng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w635d-000000071mk-43Xz;
	Fri, 27 Mar 2026 09:02:49 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w635c-000000071mS-375K;
	Fri, 27 Mar 2026 09:02:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=XlE8K29BcOci/GJeK99hdrRjgIObqUNFNRdsO2zBvLY=; b=Ezsl29sITn/f6v+BkaP23xF4nn
	I28lCXCTdUOOq9RL8tWHqNtNikpRj+CiNxVRO+TDlruBmGF5aJ2UpJkZZAW92jPtulCPGQ5HEptdb
	IMFiSvBYOjeIvLnEPJNZ5gYTw0CwFk56Sw9/lxDhWvxI2j3loAUlJmi4kexWU6+UxUfcr80GQ2zuM
	uHicaPgeOvj9NTRR1Mf3YRm7ARjp6TFjrLFKPAWddm3+Lr7JkNVi+BsJAjdKQX/fHIEUkFUrOgK7l
	50jHVzK10fXhChl3azK89N48MJ84nPmzJ3ZFQybqwNfXRNzfuJ4pdwN8nvKl9PwyydikE0L5mNVwS
	QY3ZMJoA==;
Received: from flow-a1-smtp.messagingengine.com ([103.168.172.136])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w635Z-0000000A1mj-20aa;
	Fri, 27 Mar 2026 09:02:47 +0000
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 4A6471380181;
	Fri, 27 Mar 2026 05:02:39 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 27 Mar 2026 05:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774602159;
	 x=1774609359; bh=XlE8K29BcOci/GJeK99hdrRjgIObqUNFNRdsO2zBvLY=; b=
	GVzqQY5nceojm37M1XZpOPq3WUecXUQj9WVf3CfutP3dTobqmGMQjzRLgNhoVby6
	46aeZZINaK1f7YVuydM5TqNUI4j8vyRQzPpJA34i7ACZR1RSV4TO+hIb/Y1wlQAV
	e4naVPRom36f6nfcFXr2OjE1mhktO/8tDetlgDKx/ERP6X26MCzVLKwpghPIlA9u
	FgAZLJCBgZpz0FbarT4w54TicAqCn2qTr0Z2ZfdL6DznrwvGSdcVVRrirxDEue/H
	5fVwFvlMX5ysAAT1/mtv1Dd/8FtVIaDqWDOOvUgWKJ3vwJ4vCQKKNs+/aj1E6yt+
	+mz/Xbi/v8lcnLVbeJxZpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774602159; x=
	1774609359; bh=XlE8K29BcOci/GJeK99hdrRjgIObqUNFNRdsO2zBvLY=; b=i
	Exk1Qnjsvq2JnZ1+yT0ebsDIbgY2gqeRl0z1YUchEz9YmFAT5XKQHCu5+ZzfUzMA
	KUBEKUA267I42sL6kTGiC0o6muCrmy6qX1nLFaMFkw6x8TBMIldQ20mR85lgu/Dz
	dB2EG1eKMb571eSkAhGeN6NfTkTpx4Lu0/tgLzlYoDT4OZDwCv6fEL37252eYC4+
	1qR+fAEfE/kjUNCAyy4Q+SMie5NYypjDP+zkoB40j+zYPYlVZgSiYG+KFdyvrW7G
	OWPfc7ZhuIizFLxUKMgVQKKjnJY5rCQ68EF4nMVgcJw97GM4yWWv2nTfrHXCbuKd
	K8t0sfV8n6x5lC5qiobPQ==
X-ME-Sender: <xms:rUfGaePC1BrMnmTf9_OY6lvLvc1mUKp6M_A0RyuXLyRS-NOn6VKFDg>
    <xme:rUfGaXzAgfItBbTl9XynqmOmljqUaNK22QfAcW8j65Y-hka2CDyCF6HlPX-DBmYss
    eoR8l0vie_-ZAfZlP2omID4VIFPPLAESbv9Vf23rJ3uQmLsZXfiKPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdelkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepuefhhedvjedtudeiiefgvdeuuefhueehfefffeeutdeiudegleevleeivdefgfei
    necuffhomhgrihhnpehgihhthhhusgdrtghomhdpghhnuhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdr
    uggvpdhnsggprhgtphhtthhopeeguddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epjhgrmhhivgdrtghunhhlihhffhgvsegrrhhmrdgtohhmpdhrtghpthhtoheptggrthgr
    lhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtphhtthhopehmrghrkhdrrhhuth
    hlrghnugesrghrmhdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidr
    ohhrghdruhhkpdhrtghpthhtoheprghnthhonhdrihhvrghnohhvsegtrghmsghrihgugh
    gvghhrvgihshdrtghomhdprhgtphhtthhopegurghvihgusegurghvihgughhofidrnhgv
    thdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsoh
    hquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsihdrshgt
    hhhrvghflhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:rUfGaRCaBcqc7KdntZl0FsBnvOqvRVfnzmfBbmotVoydnvBrFXOcMg>
    <xmx:rUfGaZyWyK0ItY1fAukXgGQMxYnCWlJ_ttZ9LwB67jfvcP3jcgDiJg>
    <xmx:rUfGaeUWikKeRd3kQ5HcVz8AqFZRkLvV9rX5NscA0USMCL-N4mVGIQ>
    <xmx:rUfGaQXDnwGyrD4fd56NTxM2Fq_dVcdlQpFE1HUUfNw_jSb36M81IQ>
    <xmx:r0fGaasdsr7hoeyfiet3dxQz1PzdqR0Oy-FDo6Fl_eW5_GQ_HIxB6CTf>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 95B2C700069; Fri, 27 Mar 2026 05:02:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AUJnWW6OA6Vc
Date: Fri, 27 Mar 2026 10:02:17 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: "Russell King" <linux@armlinux.org.uk>,
 "Christian Schrefl" <chrisi.schrefl@gmail.com>,
 "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>,
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
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>
Message-Id: <93439e91-cf81-477b-b880-a813bb01ad7c@app.fastmail.com>
In-Reply-To: <CAMuHMdUUfVCBZFi2WoOYibJLVnyPY-joRDJDowgHwjN_DGeEzw@mail.gmail.com>
References: <20260322192159.88138-1-ojeda@kernel.org>
 <20260323000327.111235-1-ojeda@kernel.org>
 <acEP7tl8pqFA3tK8@shell.armlinux.org.uk> <acUGAsjYvNvTEO92@google.com>
 <CANiq72mzPpkELXis1CiSbKUmBXNQYMiMmjj-7-sYiLh4T_JSOQ@mail.gmail.com>
 <9cf5a94c-0f37-446c-b63d-ddac5674d220@gmail.com>
 <acVOL5Psz6kHlhq2@shell.armlinux.org.uk>
 <641592e3-2354-4238-9eb8-a1f5c2a13126@app.fastmail.com>
 <CAMuHMdUUfVCBZFi2WoOYibJLVnyPY-joRDJDowgHwjN_DGeEzw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Inline helpers into Rust without full LTO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260327_090245_818145_95CB4CD7 
X-CRM114-Status: UNSURE (   7.46  )
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

On Fri, Mar 27, 2026, at 08:56, Geert Uytterhoeven wrote:
>>
>> I noticed a similar issue with m68k-linux, which has a bitfield
>> alignment different from anything else on gcc, but uses the normal
>> behavior on clang.
>
> Ugh, I wasn't aware of that. Adrian, did you know?

To clarify, this illustrates what I mean here:

echo 'struct { short a : 3; short b :15; short c :14; } x; int y = sizeof(x);' | m68k-linux-gcc -xc - -S -o-

this produces '4' on m68k-linux-gcc, but '6' everywhere else. I originally
thought this was related to this 2009 change in both compilers

https://github.com/llvm/llvm-project/commit/830dfccfb2c06a1749938ce8cb78a1d6a295b942
https://gcc.gnu.org/cgit/gcc/commit/?id=2cd36c22d3d16e24f342829a989ac35f2f442656

but that only allowed bitfields to be marked as __attribute__((packed))
in order to get tightly packed fields and return '4' on all architectures,
while m68k-linux-gcc apparently has all bitfields implicitly packed unless they
are explicitly marked __attribute__((aligned(x))). This behavior is
independent of the -malign-int flag.

     Arnd

