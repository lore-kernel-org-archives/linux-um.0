Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C691110BA435
	for <linux-um@archiver.kernel.org>; Fri, 27 Mar 2026 08:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5ep9g2m9wnZ/qw5uP60q9XJwKT04QFSPHpz8SR3TFGU=; b=iItVTg1HN+tDImdhqPJ0Uq+J+O
	dOR4KM4YqzIzVgJ8+ncRwQkwfRLORZyV0EQNkyN56KVFLDhCAtQXCDxQ3PYJDch4hVyLMDwgZgO+D
	rz7b+VotjUSK0xH9TzGxrEsySAw32PRjukuKzhjNXtZ/GJHx4TXhw1gz2ch9bqypbOU8SiFMj3ulV
	fs2/Dqle7krJkZPkAOPQjNhmfyLJe9fpwIbmKPAPISLdAkytx3qoCky5tYMKJf/iIKzlsn9dXH0V7
	sOabqmf09KPaSxhoqBwEMREmoMBgDBRsRRdvtizFVxUmCQDxh7zvbcBUtSdUGhQlRc4X9QLZr2wFo
	3IX6YVlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6298-00000006vn6-1ZqW;
	Fri, 27 Mar 2026 08:02:22 +0000
Received: from mail-dl1-x1236.google.com ([2607:f8b0:4864:20::1236])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6294-00000006vl3-0SDK
	for linux-um@lists.infradead.org;
	Fri, 27 Mar 2026 08:02:19 +0000
Received: by mail-dl1-x1236.google.com with SMTP id a92af1059eb24-12714f01940so143318c88.0
        for <linux-um@lists.infradead.org>; Fri, 27 Mar 2026 01:02:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774598537; cv=none;
        d=google.com; s=arc-20240605;
        b=QA8vcxY/V4j4jDV0GsXJQZf34REZIp8LEmBYKKsPJw8mGElgDc96MbRbftoFh6p2xh
         uJExnoQhfNqj6/Ys4ziDKuwnDgljKdCCObKz4tF8swQOXrBbub2CYMOTne6s0M2JxFF1
         ftWc5ZFZxbcagvwfY6xsIlroEWmgLssybSG9eOe0Neh+QGpgyT97dnKhH60wI32vXnW/
         H0P1jgnEmDRCkKbEqGwCKLCkGyp5lyXvvu2+nJprSFvl1ALp/kCgDvXuSx/6L3vur1eg
         NjhJkWncBdyqwRzcOuSWg9nUwEgEkRY+ylJxYqd8csd9UPAo68WccmZ3zapfiZ4OVCQi
         aedg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5ep9g2m9wnZ/qw5uP60q9XJwKT04QFSPHpz8SR3TFGU=;
        fh=LFrPvWnrUw+WtKChiEW80TkWOAil17vcbwsPXEqwjkA=;
        b=I4gBR1ND/wf+H4sKLFotSlcukKpLGsv/CrOXU9LJwBdBQrYAHrdQI+mlGHddnXF9FE
         J+yvJIhVVffuQRQmiWuiLw0auih/utdLalCLCYEyT+jtT5sfNxDVib/Dx1cRqkj0D6qN
         AIkxfnKHvEx8yXJd4zfQ1HAg0dSxHiIiiwVnhNECqRhjA46loiDMPaDEDtYqi7LtZCOi
         ZsWwEHQsozTPBRhTSSNij139j+oeCLvp88/9AbmNPa6zelNFQt6diOpFUE2G4WzCJh58
         wMUDeywi5Ff48OYn0YsuMnsLdawF8ExdwP2K0bgl6YGk0wBNebtVBsNT8JlAtwyrpqV2
         yxBw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774598537; x=1775203337; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ep9g2m9wnZ/qw5uP60q9XJwKT04QFSPHpz8SR3TFGU=;
        b=ouhKD8WIUezfHoEpyasPFTUZwHo5eEFGgCOFAxenrCCRU84lRKprD/pd3/UJeL9z5P
         uM8PvKTepz3A8r9ZlmgWwpjULg5k4P9H6B248lPzKHRfZZrOx5WTaUgTtfmH9/c0Wg3Y
         mdYMBEylzCx3Zfg0qGcNNtcVYE8klNX4+zusnAP9B2hwqeVhbzvJE9C91ma1YD7ta3/5
         983i66wogS3kLcSFAD/IcXFOW0qwnuR0ZhUiJV9Oy5N/YQRHWYCxhQpPWbq5AKwtq3/X
         DJteRhU98VM9j8F0mbtAD/oNCdvXW98+dmnru3awV/gwrA0d3pryFBIx+NuGKzUTo8E+
         iDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774598537; x=1775203337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5ep9g2m9wnZ/qw5uP60q9XJwKT04QFSPHpz8SR3TFGU=;
        b=jK5BHQ7aQbzKhg9C1kedCB9c4Q1nlmUwVEXINqD15Y0Hi1iDsNdd4cIg8qZkxnD/2t
         NcsTGb926V+0qBr1KtCZa/oY49rOfrcva+vxe0cpCT6Q5bjOWIpy4Qwf1/xedQhx2TtT
         +/W2Qcjti/wO9jOnkief3HIGER9JDUPtRpYREL1n/H+L3QtINBNjeMT3uouedN8+4Pkg
         5nDMYljoZEaQYP5KOPXxsaYAfSLrcKGjRr0sTCoVlgjiiuFeH05uZGNVZTx8iTAowSDk
         ZG9OXjLwgcP5eXXEK2pw3l3ElwrygvlHWocb1yPLppez176w809fT/32AkhtWDIQ/dpP
         FZ+g==
X-Forwarded-Encrypted: i=1; AJvYcCXR9fOEU8HhHjZbc2Aa5tU7PMshgJbeDd92TBldjuyy0op8cXf23YeJlwzab+W3zAXM4HMv5hYfsw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxMa1sFF7YwmlbQDhS8xOEYaGviaJy+LvnwfZL9+2ECagz+Pz73
	gnIHPE9fMHJCPaRLivUAI2rmdZ5ODyAMC0AMKdltrXbv9j/t/XRfr9Cjf2F+h/8gXVClEgGoaty
	7CSthrHAVmS+LOHDzQrlFiVBLCl5tWx4=
X-Gm-Gg: ATEYQzw4DmL70nFghD3/RjBDfMO3ffEExUKjEN7spckswXqp1XlTFs6KCdWK2SJRuWr
	GgoRECZsRvE41XLCwozHS/xH0VWMuR5k8E1Mr9iagsulsEQ3RDv2aNkZpu2bLYG6klOayklz2TZ
	WnILN/MKEnc7rQLQ7pHpOjTri+f56nMonFd5tEwOPPNXRMA6BiU5ms3YilXLS7B2NlGC2cfiMDS
	/J3FOGvHc61/3GApFg8sq4EnRiiwjO0eeAYiHdSJXAHEzLAApkDW5DQWVKCoNbmA6H3ZaIhxZHT
	g+O/jSr+xjdQFi95WwvAaNepMCLkkdre0wjk4DbKviJvSDu2yu7lKMPmg3ehXKFTHtmI2Bse22G
	0EkpNjnx7/mwfren2JjPFY0A=
X-Received: by 2002:a05:7022:618a:b0:12a:6cde:fd0c with SMTP id
 a92af1059eb24-12ab2906c98mr371178c88.7.1774598537022; Fri, 27 Mar 2026
 01:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260322192159.88138-1-ojeda@kernel.org> <20260322194616.89847-1-ojeda@kernel.org>
 <7ad8bdf9-5eff-4443-ad15-c05355d793d1@app.fastmail.com>
In-Reply-To: <7ad8bdf9-5eff-4443-ad15-c05355d793d1@app.fastmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 27 Mar 2026 09:02:04 +0100
X-Gm-Features: AQROBzCrGdIlIe2CkDWKMkYFmP8XiqVc047zlhYRt_gjOqAGZtEWFJuOGnDO47I
Message-ID: <CANiq72nz6zB0jGahw4Eh-i-Rew1kQ0g_qcZ68Whw==MyjhYaJw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Inline helpers into Rust without full LTO
To: Arnd Bergmann <arnd@arndb.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Danilo Krummrich <dakr@kernel.org>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev, 
	driver-core@lists.linux.dev, acourbot@nvidia.com, 
	Andrew Morton <akpm@linux-foundation.org>, Alice Ryhl <aliceryhl@google.com>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, David Gow <david@davidgow.net>, Gary Guo <gary@garyguo.net>, 
	Johannes Berg <johannes@sipsolutions.net>, Justin Stitt <justinstitt@google.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-um@lists.infradead.org, Russell King <linux@armlinux.org.uk>, llvm@lists.linux.dev, 
	Benno Lossin <lossin@kernel.org>, Mark Rutland <mark.rutland@arm.com>, mmaurer@google.com, 
	Bill Wendling <morbo@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Nicolas Schier <nsc@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Richard Weinberger <richard@nod.at>, rust-for-linux@vger.kernel.org, 
	Trevor Gross <tmgross@umich.edu>, "Uladzislau Rezki (Sony)" <urezki@gmail.com>, Will Deacon <will@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260327_010218_164271_8CA1A0E9 
X-CRM114-Status: UNSURE (   9.87  )
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

On Thu, Mar 26, 2026 at 10:13=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrot=
e:
>
> I have an older patch to drop CONFIG_NO_DMA entirely, which
> may be better here, since we know that nobody cares about the
> empty stubs.

In case it helps / for future reference: the patch I sent to Marek is
already in mainline: commit 2cdaff22ed26 ("dma-mapping: add missing
`inline` for `dma_free_attrs`").

Cheers,
Miguel

