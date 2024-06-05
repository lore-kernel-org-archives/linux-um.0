Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61EEC25B76
	for <linux-um@archiver.kernel.org>; Wed,  5 Jun 2024 18:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uwUrfu/yzS/YNseKipCZSPaE2sZQzojPJmfSYmfQ2II=; b=lY0Wvi+4NN6PY8d5ifN682C86v
	sufDclRPpMwK1L0SsmeNlyvyCxtDvGTiNsuNOyOZISNqzIEU7jTcACdd39VbE/KhBB5+6cxVbQjl0
	skH+n53mIvWboDFXu8R0Ri18YhfQnHWu1qanpgurw3yUmZlphGlmfbXofKhgxVQpjk2M2Pbpm9uRs
	tZiQ0MZwN491vFxWTtaq0mpRr7IAPeEQg2iKHRMrRsUXjlzx1Tan7zsccdhvlRZoRTgNHuQYG5fFB
	eoCEkYeUTNY6J8FzwjewndjlVWDxh2FCierMWBuVG7QGYZt8sthA3jY9pVH7SAZxn6CjZtfJBxtNM
	vzCH7Wng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEuyC-000000074TD-111x;
	Wed, 05 Jun 2024 18:02:44 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEuy8-000000074QE-2GT9
	for linux-um@lists.infradead.org;
	Wed, 05 Jun 2024 18:02:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=uwUrfu/yzS/YNseKipCZSPaE2sZQzojPJmfSYmfQ2II=;
	t=1717610554; x=1718820154; b=t+5Ci8C2peLMrX96AuFHHM54i3YVYZCBnWJShFHSDQnf9XM
	MFIgiptGSnhzw0fhQA/z9oHCeUNyfPWCKz+JZ94bcSdlh+K6WpPVMgcmyVyYbc6sxy1mLgWodcZlz
	6mLxTGfcXZ8iGLc59lpsXBvOg0+rSvxhzNDAdsac5ePlgcxJtW8YSw8G+1+tewDpHipRrPnHIkItF
	sAEz8IeO3T0pvIGBPUHqmkhk0tAVYt/KQ+jMmcIER/c/PiTPZXxbeKA2BmGckNz5PSgIywX8GOitV
	nR4g0kmj5Fcf6MBTPQBZwTvP/7wdXctHoVl2yk7cTR1MrCeliNCN8lZkW0YTOGOA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sEuxm-0000000ErED-3wIf;
	Wed, 05 Jun 2024 20:02:19 +0200
Message-ID: <b46fd359f62fc7c50790fb19a8814c89a10a7c1c.camel@sipsolutions.net>
Subject: Re: [PATCH] arch: um: rust: Add i386 support for Rust
From: Johannes Berg <johannes@sipsolutions.net>
To: Ard Biesheuvel <ardb@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Cc: David Gow <davidgow@google.com>, Brendan Higgins
 <brendan.higgins@linux.dev>,  Rae Moar <rmoar@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,  Miguel Ojeda
 <ojeda@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Masahiro Yamada
 <masahiroy@kernel.org>,  Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>,  kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org,  linux-um@lists.infradead.org,
 rust-for-linux@vger.kernel.org, x86@kernel.org,  Wedson Almeida Filho
 <wedsonaf@gmail.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun
 Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice
 Ryhl <aliceryhl@google.com>, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, llvm@lists.linux.dev
Date: Wed, 05 Jun 2024 20:02:17 +0200
In-Reply-To: <CAMj1kXHa58Zcq3extXw4VXGnpVHbd5urzCGnh_oCo-BLMxMrJQ@mail.gmail.com>
References: <20240604224052.3138504-1-davidgow@google.com>
	 <20240605062234.GE279426@thelio-3990X>
	 <CAMj1kXHa58Zcq3extXw4VXGnpVHbd5urzCGnh_oCo-BLMxMrJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_110240_722707_0BC50309 
X-CRM114-Status: UNSURE (   8.87  )
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

On Wed, 2024-06-05 at 19:59 +0200, Ard Biesheuvel wrote:
>=20
> > > -ifdef CONFIG_X86_64
> > > +ifneq ($(or $(CONFIG_X86_64),$(CONFIG_X86_32)),)
> >=20
> > These configurations are mutually exclusive, so would it look more
> > readable to have it be:
> >=20
> >=20
> > ifeq ($(CONFIG_X86_32)$(CONFIG_X86_64),y)
> >=20
>=20
> Or simply
>=20
> ifdef CONFIG_X86

No, we're talking about ARCH=3Dum, so CONFIG_X86 isn't set, but
CONFIG_X86_{32,64} are set as the "sub" or "host" arch. :)

johannes

