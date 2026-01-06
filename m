Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62930C47BFC
	for <linux-um@archiver.kernel.org>; Tue,  6 Jan 2026 14:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yRizhhNfGDPf+obLvJF1oJPLNKdk3U2GKiBJdz/rTRY=; b=tAGP/yoCoJGq/8yIqeRXkkR5sP
	4Pr3ml605bZ47Rqw4+64F6ETK5Fy25aCGyXEaS3IRUsRPXj3MWVjmqtgwJrDF3XQfO1+wEJR+Rl6L
	N2oKY4ITRi+KruWBSBiJg9wl1MXq4L0X/FJap4DsKaZijlaqfbyfSRCQm+wmKbRqRNKxf05RZnWyj
	7LLhyN1yZH1cLJWsDtxA28QX8Fugc8mz+oELwQ+Ga18KRTjRaeH6PbimWSm/yQ2da4QUnyiygfD7U
	WlEShiRZSjoogo2jDXx1eiE/72/FWW3VMhI0xuZwj6Pw+X+J+Qh0+YKBYSpprfUJp2Jt8xWlttcZ4
	WQ1bbEAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd7vf-0000000DGzN-3SjI;
	Tue, 06 Jan 2026 14:20:59 +0000
Received: from mailout.nod.at ([116.203.167.152] helo=lithops.sigma-star.at)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd7vc-0000000DGxl-2FDV
	for linux-um@lists.infradead.org;
	Tue, 06 Jan 2026 14:20:58 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 54EBF2B03EC;
	Tue,  6 Jan 2026 15:20:45 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id duGiDergfFXx; Tue,  6 Jan 2026 15:20:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id C3F3A2ABFDC;
	Tue,  6 Jan 2026 15:20:43 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yRMMhCJ3y2FK; Tue,  6 Jan 2026 15:20:43 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 8CC6C99FB4;
	Tue,  6 Jan 2026 15:20:43 +0100 (CET)
Date: Tue, 6 Jan 2026 15:20:43 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-um <linux-um@lists.infradead.org>, x86 <x86@kernel.org>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, tglx <tglx@linutronix.de>, 
	mingo <mingo@redhat.com>, bp <bp@alien8.de>, 
	dave hansen <dave.hansen@linux.intel.com>, hpa <hpa@zytor.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	dakr <dakr@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Rust for Linux Kernel <rust-for-linux@vger.kernel.org>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Message-ID: <1064740857.79527.1767709243348.JavaMail.zimbra@nod.at>
In-Reply-To: <20260106034034.60074-1-boqun.feng@gmail.com>
References: <aVxcAZe6AEXEfx3G@tardis-2.local> <20260106034034.60074-1-boqun.feng@gmail.com>
Subject: Re: [PATCH] arch: um/x86: Select ARCH_SUPPORTS_ATOMIC_RMW for
 UML_X86
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF144 (Linux)/8.8.12_GA_3809)
Thread-Topic: arch: um/x86: Select ARCH_SUPPORTS_ATOMIC_RMW for UML_X86
Thread-Index: sJnRvj0jz0HhSO1GSUr6a5CWkGpv6Q==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260106_062056_857654_FBBB277C 
X-CRM114-Status: UNSURE (   6.85  )
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

----- Urspr=C3=BCngliche Mail -----
> Von: "Boqun Feng" <boqun.feng@gmail.com>
> An: "linux-um" <linux-um@lists.infradead.org>, "x86" <x86@kernel.org>
> CC: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegre=
ys.com>, "Johannes Berg"
> <johannes@sipsolutions.net>, "tglx" <tglx@linutronix.de>, "mingo" <mingo@=
redhat.com>, "bp" <bp@alien8.de>, "dave
> hansen" <dave.hansen@linux.intel.com>, "hpa" <hpa@zytor.com>, "Miguel Oje=
da" <ojeda@kernel.org>, "Boqun Feng"
> <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>, "Bj=C3=B6rn Roy Ba=
ron" <bjorn3_gh@protonmail.com>, "Benno Lossin"
> <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice R=
yhl" <aliceryhl@google.com>, "Trevor Gross"
> <tmgross@umich.edu>, "dakr" <dakr@kernel.org>, "linux-kernel" <linux-kern=
el@vger.kernel.org>, "Rust for Linux Kernel"
> <rust-for-linux@vger.kernel.org>, "FUJITA Tomonori" <fujita.tomonori@gmai=
l.com>
> Gesendet: Dienstag, 6. Januar 2026 04:40:34
> Betreff: [PATCH] arch: um/x86: Select ARCH_SUPPORTS_ATOMIC_RMW for UML_X8=
6

> x86 atomic instructions are used for um on UML_X86, therefore atomics
> on UML_X86 support native atomic RmW as x86 does, hence select
> ARCH_SUPPORTS_ATOMIC_RMW.
>=20
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
> UM & x86 maintainers,
>=20
> I need this to avoid a build error for Rust atomics since Rust currently
> only support Atomic<i8/i16> on ARCH_SUPPORTS_ATOMIC_RMW archs. I will
> add it to my upcoming PR if I get some Acked-by, thanks!
>=20
> arch/x86/um/Kconfig | 1 +
> 1 file changed, 1 insertion(+)

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard

