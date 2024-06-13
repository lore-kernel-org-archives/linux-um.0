Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 076C6C27C4F
	for <linux-um@archiver.kernel.org>; Thu, 13 Jun 2024 20:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ULWkbbB/Ba2zTcxEXHNh/JybJCOg3HoCv6YwNpHEtEQ=; b=QuYBfcaZie7HIwVcSSp4Knu35L
	KkvZ4cyghl7laZXwrbAlo6po8bfTIdSBSRCy4x4QnQ6s/MyvQL7ccFsEwp4p1XWqZe9v+Mg6pGloh
	H63CiBzSRMOG4Im6iuUuiejRBLKCdeFgPi/5WwmSXRP4xK0GHAnv4MfK4XVqEckB5gchpefKqAVaT
	jARSzZjY+Kn4jAANxL9PyRQR50g0hjl2XLP4tQ1Ft60PJi64jigipbV4zXoBI6JcvxWueBcrg7n+W
	Zusry1HjAMQMGsWBL+qJnwsscAtparFHPsQDW955RlTw6H+flrujkogpYlsIJkr+HUuzqel6dXFba
	oszObCjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHr18-00000000Pvr-0IXL;
	Thu, 13 Jun 2024 20:25:54 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHr14-00000000PuV-3ltu
	for linux-um@lists.infradead.org;
	Thu, 13 Jun 2024 20:25:53 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 7CB1961966A0;
	Thu, 13 Jun 2024 22:25:45 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Wa49bRMWQqQj; Thu, 13 Jun 2024 22:25:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 1B1DA61966B5;
	Thu, 13 Jun 2024 22:25:45 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id u3JPqG5GZGqO; Thu, 13 Jun 2024 22:25:45 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id D6A5661966A0;
	Thu, 13 Jun 2024 22:25:44 +0200 (CEST)
Date: Thu, 13 Jun 2024 22:25:44 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: davidgow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	tglx <tglx@linutronix.de>, mingo <mingo@redhat.com>, 
	Miguel Ojeda <ojeda@kernel.org>, hpa <hpa@zytor.com>, 
	masahiroy <masahiroy@kernel.org>, 
	Jamie Cunliffe <Jamie.Cunliffe@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	kunit-dev <kunit-dev@googlegroups.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-um <linux-um@lists.infradead.org>, 
	Rust for Linux Kernel <rust-for-linux@vger.kernel.org>, 
	x86 <x86@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	bp <bp@alien8.de>, dave hansen <dave.hansen@linux.intel.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>
Message-ID: <965895223.231524.1718310344716.JavaMail.zimbra@nod.at>
In-Reply-To: <CANiq72mXWERtFSqQRtcgP28aLokwZmXaBiqcrn_zoASawjfdsQ@mail.gmail.com>
References: <20240529093336.4075206-1-davidgow@google.com> <CANiq72mXWERtFSqQRtcgP28aLokwZmXaBiqcrn_zoASawjfdsQ@mail.gmail.com>
Subject: Re: [PATCH] arch: um: rust: Use the generated target.json again
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: arch: um: rust: Use the generated target.json again
Thread-Index: sd4HK7HM+iXRR4lpujN6qFDOxf77yA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240613_132551_189625_C68AC994 
X-CRM114-Status: UNSURE (   4.89  )
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
> Von: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
>> Fixes: f82811e22b48 ("rust: Refactor the build target to allow the use o=
f
>> builtin targets")
>> Signed-off-by: David Gow <davidgow@google.com>
>=20
> I guess this should go through UML, but please let me know otherwise

Yeah, that's the plan.

> Tested-by: Miguel Ojeda <ojeda@kernel.org>
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
>=20
> Should this have a
>=20
> Cc: stable@vger.kernel.org
>=20
> too?

Ok!

Thanks,
//richard

