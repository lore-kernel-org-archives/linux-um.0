Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90ABBCD6E4C
	for <linux-um@archiver.kernel.org>; Mon,  1 Jun 2026 08:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TPtsZBA/bIRb3KioLFVLd9QQe/Cx4iWr2XPTlM5ix80=; b=oMlr/82+udLHQr8ueab+B2prZk
	sBqgw8AhFrTmcewcem06gTdHJhsF1fJYUID2rIoCcTMGh2FPfAG1mPdtOBJU5kei2NgyDjnXi5tIP
	yV8RKOJ4eJTAFkyb7wOuI21FnADi/HkNZhl0QDIOAJZ+5r+/joV3IXmZpaieyaemMyEph00DNW/JU
	xEBqRzRKgMinU7d7zSqVovvLESQhSNzbr7GQCpnROIt+ni88KOpZj3ej/ZKTKQvR9r7IumNSouW1x
	vogmTFDma5qMOmdAJIP54e1OTtJIMTRkb1NpuKcpyHP/Q67rybIXTnN2UHW90pfFmKGQLO9MBBLJN
	kCJ59shA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTy3c-0000000AMfT-18YY;
	Mon, 01 Jun 2026 08:31:36 +0000
Received: from mail-ua1-f53.google.com ([209.85.222.53])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTy3Z-0000000AMei-2VCm
	for linux-um@lists.infradead.org;
	Mon, 01 Jun 2026 08:31:34 +0000
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-9639fa0636bso1444308241.0
        for <linux-um@lists.infradead.org>; Mon, 01 Jun 2026 01:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780302692; x=1780907492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TPtsZBA/bIRb3KioLFVLd9QQe/Cx4iWr2XPTlM5ix80=;
        b=XLlReu4HC7HQqdV5K9c0ZzhOWMnZKOyJWVrkW7YZ8uxg8CnQV6oDs60he9pn53vMRJ
         MhNVFswEPWwNDaTJEodWjJaOUe/kMNipxlRlCK6UWR5/8KMB8797L48ZlP/a9ijk7bZ3
         yec5yFS5TOcJvBhfQAdpSRdOxWD5P7Nm0JTzXOC0FppHllznc21z+iTkJv50Cyp1JFQc
         HQLG3LAjBIolRFp/vV+xfFomPXuwOEzSNywBm0Fsr4wqlErXJQ78JGfSo/NkbAMLqBvi
         u2Nz2DmGQ5h3yK8GAC2lc/TQgUtpMYBQ/dgZ6qIpbrJmlZXLQ8F4i2dV12uJfQ02Zs5j
         0k3Q==
X-Forwarded-Encrypted: i=1; AFNElJ9+CC3pwP74NLb1pH8aH4ITkfFL1figLK4MlIgJNswqgtdjK8Hvoyx2iwMZufEFjhtIOsbEn5F6yw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyAh+1L+e93YRlgSXrM8mrAnPtxRlX+hw4nSxsrtKes/VEwZl/V
	pgl5YPc+Ebp8MMaJr/wiKY3Ycoq4EiznCF1cUOTtfOVJIQX/I03MvhfvFibkjNMu
X-Gm-Gg: Acq92OENDeefCeJ+uHawCLeqGF+7xR+ezg789r8so/GEGnbXtcLzsFUnxZllbFmJwpq
	CemdA/9FR+fZPPPQjwAvDSEeiCOi5vEXo+ewdjDSB83KlnoOBlYM1YACn9A2rrTY3o5FROSZI4Y
	0krKnb/bznKL7rq7XKf9jlLEeIcWdcAT9LwRJPhR9MgEq+UgOVsJgx3UvOThZ/pB5uHZw+16Fnl
	FX1SIyVfD9lDxA7BV64EQfF4LnLeDgMGFOe8f7DV5gdsxYWMiQtGl03E5l8aw2M6kLskMpHVeUJ
	mHyFAbPMJxpKWtm82W2ERQ0qH+iT8qvhDqOh3X8CnRy2+40KYZYOFHoB3d2EsOnR6BvrPrYfESL
	bi8iWhsiha/7X/7uq3L4WWv2da6ZhtxL6hrmTnVD5MWI6ykZKf4zyoij0rAm0w0NLrfZ77sBTZn
	iBRS94GHZ64UZ61YwX1C70Rhh2nf67ijFCYRG7gxW5frlAt9A5ZhpUnDGaW8RgXh9+/C8Y1tJM+
	tY=
X-Received: by 2002:a05:6102:fa0:b0:631:cb9b:f9bb with SMTP id ada2fe7eead31-6c639bab354mr3370024137.13.1780302691746;
        Mon, 01 Jun 2026 01:31:31 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6bfc81a9db3sm6564080137.8.2026.06.01.01.31.30
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 01:31:30 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-59ecd51117dso972068e0c.1
        for <linux-um@lists.infradead.org>; Mon, 01 Jun 2026 01:31:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+JMGtI9S3jM8Ops0iTzpd8tYaczbnbcGJJWeoBCLroxDI6oRaTGrzft1AZbFCvPhp16dG11pEWCw==@lists.infradead.org
X-Received: by 2002:a05:6122:1254:b0:59c:ee04:9a7d with SMTP id
 71dfb90a1353d-59cee04aae2mr1681188e0c.3.1780302689941; Mon, 01 Jun 2026
 01:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260522141959.1071595-1-arnd@kernel.org> <20260522141959.1071595-2-arnd@kernel.org>
In-Reply-To: <20260522141959.1071595-2-arnd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 1 Jun 2026 10:31:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWroJRgr-p7CXLf08EJkbPxhro1WVYGe0pQ8Zu__jMobA@mail.gmail.com>
X-Gm-Features: AVHnY4KWXYTB5g0TdehWfdwuQ5DRSyoLl63rEUU9Hj76l0FzaOdLlp8NtlfTB2M
Message-ID: <CAMuHMdWroJRgr-p7CXLf08EJkbPxhro1WVYGe0pQ8Zu__jMobA@mail.gmail.com>
Subject: Re: [PATCH 1/8] x86: remove ts5500 platforms support
To: Arnd Bergmann <arnd@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Alexander Usyskin <alexander.usyskin@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org, 
	"Savoir-faire Linux Inc." <kernel@savoirfairelinux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_013133_636929_856CCF81 
X-CRM114-Status: GOOD (  15.93  )
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

Hi Arnd,

On Fri, 22 May 2026 at 16:20, Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Support for =C3=89lan was removed in 7.1, but the ts5500 platform
> still depends on it. Remove this one as well, not that it
> cannot be used any more.

https://www.embeddedts.com/products/TS-5500

   "Retired. Last Time Buy. This product is being retired. We will
    have a Last Time Buy until 01/07/26. Supplies are limited."

but

   "Available with Linux 2.4 kernel"

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

