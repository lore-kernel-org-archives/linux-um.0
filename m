Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 033D4C87FCA
	for <linux-um@archiver.kernel.org>; Sun, 10 Aug 2025 07:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EpwULXc7N4PVrAxnhzJUCLFsDhMEPa8K20pRMtf9QU4=; b=kimtDtm/poxZU4X0k+tHaLIggv
	N0DhFX761FI4zOvnYuwzN4fPWZoP2gdpyVP/kjmIX89ixdwNR1wTyBY4xydcAO/ukWpg+pCdVv+zW
	14slkQJtFd79WMwZzp8zhuc55Ykxg14HqRKJyGWQviREkNQ6PvBwsfLSYdVUcGogodLMXWeDUm2sG
	GaYdhANcq2qLjzyu5lX6dfRB/bAHPn4QNhUe+mNmRdRAF4poVR3tBuOBQGyM8H/JUaD3HdzFA1T+t
	ACv8FV8yjCdbcb5iras+5pxo7TqHF+ni2BIyPBjslLnlOY3jWHbUXCortbr6I6x1xGco878IS37xv
	EU/rLduw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul0Ou-00000005OD5-42i7;
	Sun, 10 Aug 2025 07:23:28 +0000
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul0MN-00000005NyS-0AaF;
	Sun, 10 Aug 2025 07:20:52 +0000
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-333be1f3f46so3744421fa.2;
        Sun, 10 Aug 2025 00:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754810449; x=1755415249; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpwULXc7N4PVrAxnhzJUCLFsDhMEPa8K20pRMtf9QU4=;
        b=i8MGhypvlkdgMRx3hu80ydyE7/CsUwDcGDHK55vUo+ufb+n1Y/LvVNbtHR4eHZA1Jl
         uGjafYbYyezkxDVktxGzoZR9b3zQsbQkn3TqzvUcbgQoIvdFqBqgljt2LnomaZtp3ltO
         OtrxwgghnOPYFNhY49OHG6tpDUOmSE30gfKvA483Br10ge1jQhH6Ho3rhZlSNVdPED5H
         xuPMqUBhhJQpXR9riZUH2v4vnp4GocBkLv39nY2EWTMz1k3sb44ypMi/ftq8VhtKwy1C
         ZjkvgT6Ukrd4kngWKkYf8M3yWndm/iVt8vFrM2eeUdtIiF/q/0xYmp6R0apCpAFneVZj
         t6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754810449; x=1755415249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpwULXc7N4PVrAxnhzJUCLFsDhMEPa8K20pRMtf9QU4=;
        b=LAQBhhbMZOMcPMNLFMhctpW5UQGl+BeRhWv+WM22AGLbppslbxWH2rzAKh6/r8urgy
         yi/qPAd0oZBohNsRluSZJP3bE8hTzrZWRz1eDV2f+mbM+37nWe1nNkD35EmrUL7rwZLD
         WcGZ8MJ9W6ZO9ZDAlqOhnOZKJEz2yrjp7uTcmPdm2CVBdo6J1AQD9z9sbhPuqWY4YTqm
         8FXqs4wZlP0lv62+w9nOAf8dO2rVCpL+B/sbcfs6F1jF6ClRJaT9ncq4vBCETzM7t5hJ
         O4WVt5MSgxD6Y05FJLPzzAymPwMAHTSVBdEeU7VSejp6NI5ES2p5pX2txRgW9k51XRyq
         G5Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVqLpV5z168FhQQXEir3i31idMWG1KvV9Ip5IXCqa7dEsmtB5WvnPtIYfkFOiEzKotAKkkoQOvfv0w=@lists.infradead.org, AJvYcCXGBLtaPVBsHML170LR8wqZC7G4uCZq3a1d32AO4JtNnttLXLNH8W6SFWKEcr+IPcRSWIBvA1UzkwqPt2IjaCbl@lists.infradead.org, AJvYcCXIK0AvU5TR8Jr+sbf/V5OlWLXQAarhS7m22Z4M2ZjLq/hryUX0F/p7aI58JYqAj6UBgefbePLpkwCXfSg=@lists.infradead.org
X-Gm-Message-State: AOJu0YzvDdQW+sQNFqUmlUcvR94C+dp2GCvk3IGq+kgUBZYi58w0cENc
	p6id1tFRVqxNwgiK1ALvDAJQ1XX1BgesbG9ElapK1euuOX4Ny+5qiUSSej99/Iw0F+ORSj/QbDv
	kKCESU/cjApqaUbnUrkEb0DNIU8DidTo=
X-Gm-Gg: ASbGncu2LN2Mk1QFMtitoT5M+wPPGKCjRMGMQL8RQCSXr6OIWFo6gXVtH9okc75ATpj
	aQd9/D9NfqY5WsbIfbpwAm4O3zOh8zyM1hhUl0yhbpJNRj/wvXTSLqPK5Yd1AP6X4VcvsDuXOG7
	XINsl03MU6IB2q5lIoM2bYJQqatzQCSbPBcL/KjeEVmfWsvOQD7iWst6Uu3MtS9aA3jWWNnaswo
	27bzqzdtzl0Coig0KfA0frp4qQF/r0kpdlgTz4=
X-Google-Smtp-Source: AGHT+IEATVB+zShs5UtXixRak2GiQ/zc6xtl1NlPiWHkLLcdmonSWNJDigg98acT6MlYwLuyv4giEoaQ9ZJ5gULbnFg=
X-Received: by 2002:a2e:96cc:0:b0:32f:425b:3278 with SMTP id
 38308e7fff4ca-333a22ede04mr18232851fa.25.1754810448509; Sun, 10 Aug 2025
 00:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250807194012.631367-1-snovitoll@gmail.com> <20250807194012.631367-2-snovitoll@gmail.com>
 <22872a3f-85dc-4740-b605-ba80b5a3b1bc@csgroup.eu> <CACzwLxjnofD0EsxrtgbG3svXHL+TpYcio4B67SCY9Mi3C-jdsQ@mail.gmail.com>
 <af677847-e625-43d7-8750-b2ce4ba9626c@csgroup.eu>
In-Reply-To: <af677847-e625-43d7-8750-b2ce4ba9626c@csgroup.eu>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Sun, 10 Aug 2025 12:20:31 +0500
X-Gm-Features: Ac12FXxZS7GKPiKLVRILyIcM2smc0R0yETsf0Ytt07yeIUtr59o1Bn8VVZobpbU
Message-ID: <CACzwLxjr+Z+xUj-936rcWDSqEwfUP7bRB1xcqZQKGE7ux-gEXQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] kasan: introduce ARCH_DEFER_KASAN and unify static
 key across modes
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: ryabinin.a.a@gmail.com, bhe@redhat.com, hca@linux.ibm.com, 
	andreyknvl@gmail.com, akpm@linux-foundation.org, zhangqing@loongson.cn, 
	chenhuacai@loongson.cn, davidgow@google.co, glider@google.com, 
	dvyukov@google.com, alex@ghiti.fr, agordeev@linux.ibm.com, 
	vincenzo.frascino@arm.com, elver@google.com, kasan-dev@googlegroups.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250810_002051_081918_4A00C70A 
X-CRM114-Status: GOOD (  30.01  )
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

On Fri, Aug 8, 2025 at 10:03=E2=80=AFPM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 08/08/2025 =C3=A0 17:33, Sabyrzhan Tasbolatov a =C3=A9crit :
> > On Fri, Aug 8, 2025 at 10:03=E2=80=AFAM Christophe Leroy
> > <christophe.leroy@csgroup.eu> wrote:
> >>
> >>
> >>
> >> Le 07/08/2025 =C3=A0 21:40, Sabyrzhan Tasbolatov a =C3=A9crit :
> >>> Introduce CONFIG_ARCH_DEFER_KASAN to identify architectures [1] that =
need
> >>> to defer KASAN initialization until shadow memory is properly set up,
> >>> and unify the static key infrastructure across all KASAN modes.
> >>
> >> That probably desserves more details, maybe copy in informations from
> >> the top of cover letter.
> >>
> >> I think there should also be some exeplanations about
> >> kasan_arch_is_ready() becoming kasan_enabled(), and also why
> >> kasan_arch_is_ready() completely disappear from mm/kasan/common.c
> >> without being replaced by kasan_enabled().
> >>
> >>>
> >>> [1] PowerPC, UML, LoongArch selects ARCH_DEFER_KASAN.
> >>>
> >>> Closes: https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3=
A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D217049&data=3D05%7C02%7Cch=
ristophe.leroy%40csgroup.eu%7Cfe4f5a759ad6452b047408ddd691024a%7C8b87af7d86=
474dc78df45f69a2011bb5%7C0%7C0%7C638902640503259176%7CUnknown%7CTWFpbGZsb3d=
8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbC=
IsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DUM4uvQihJdeWwcC6DIiJXbn4wGsrijjRcHc=
55uCMErI%3D&reserved=3D0
> >>> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> >>> ---
> >>> Changes in v5:
> >>> - Unified patches where arch (powerpc, UML, loongarch) selects
> >>>     ARCH_DEFER_KASAN in the first patch not to break
> >>>     bisectability
> >>> - Removed kasan_arch_is_ready completely as there is no user
> >>> - Removed __wrappers in v4, left only those where it's necessary
> >>>     due to different implementations
> >>>
> >>> Changes in v4:
> >>> - Fixed HW_TAGS static key functionality (was broken in v3)
> >>> - Merged configuration and implementation for atomicity
> >>> ---
> >>>    arch/loongarch/Kconfig                 |  1 +
> >>>    arch/loongarch/include/asm/kasan.h     |  7 ------
> >>>    arch/loongarch/mm/kasan_init.c         |  8 +++----
> >>>    arch/powerpc/Kconfig                   |  1 +
> >>>    arch/powerpc/include/asm/kasan.h       | 12 ----------
> >>>    arch/powerpc/mm/kasan/init_32.c        |  2 +-
> >>>    arch/powerpc/mm/kasan/init_book3e_64.c |  2 +-
> >>>    arch/powerpc/mm/kasan/init_book3s_64.c |  6 +----
> >>>    arch/um/Kconfig                        |  1 +
> >>>    arch/um/include/asm/kasan.h            |  5 ++--
> >>>    arch/um/kernel/mem.c                   | 10 ++++++--
> >>>    include/linux/kasan-enabled.h          | 32 ++++++++++++++++++----=
----
> >>>    include/linux/kasan.h                  |  6 +++++
> >>>    lib/Kconfig.kasan                      |  8 +++++++
> >>>    mm/kasan/common.c                      | 17 ++++++++++----
> >>>    mm/kasan/generic.c                     | 19 +++++++++++----
> >>>    mm/kasan/hw_tags.c                     |  9 +-------
> >>>    mm/kasan/kasan.h                       |  8 ++++++-
> >>>    mm/kasan/shadow.c                      | 12 +++++-----
> >>>    mm/kasan/sw_tags.c                     |  1 +
> >>>    mm/kasan/tags.c                        |  2 +-
> >>>    21 files changed, 100 insertions(+), 69 deletions(-)
> >>>
> >>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> >>> index f0abc38c40a..cd64b2bc12d 100644
> >>> --- a/arch/loongarch/Kconfig
> >>> +++ b/arch/loongarch/Kconfig
> >>> @@ -9,6 +9,7 @@ config LOONGARCH
> >>>        select ACPI_PPTT if ACPI
> >>>        select ACPI_SYSTEM_POWER_STATES_SUPPORT if ACPI
> >>>        select ARCH_BINFMT_ELF_STATE
> >>> +     select ARCH_DEFER_KASAN if KASAN
> >>
> >> Instead of adding 'if KASAN' in all users, you could do in two steps:
> >>
> >> Add a symbol ARCH_NEEDS_DEFER_KASAN.
> >>
> >> +config ARCH_NEEDS_DEFER_KASAN
> >> +       bool
> >>
> >> And then:
> >>
> >> +config ARCH_DEFER_KASAN
> >> +       def_bool
> >> +       depends on KASAN
> >> +       depends on ARCH_DEFER_KASAN
> >> +       help
> >> +         Architectures should select this if they need to defer KASAN
> >> +         initialization until shadow memory is properly set up. This
> >> +         enables runtime control via static keys. Otherwise, KASAN us=
es
> >> +         compile-time constants for better performance.
> >>
> >
> > Actually, I don't see the benefits from this option. Sorry, have just
> > revisited this again.
> > With the new symbol, arch (PowerPC, UML, LoongArch) still needs select
> > 2 options:
> >
> > select ARCH_NEEDS_DEFER_KASAN
> > select ARCH_DEFER_KASAN
>
> Sorry, my mistake, ARCH_DEFER_KASAN has to be 'def_bool y'. Missing the
> 'y'. That way it is automatically set to 'y' as long as KASAN and
> ARCH_NEEDS_DEFER_KASAN are selected. Should be:
>
> config ARCH_DEFER_KASAN
>         def_bool y
>         depends on KASAN
>         depends on ARCH_NEEDS_DEFER_KASAN
>
>
> >
> > and the oneline with `if` condition is cleaner.
> > select ARCH_DEFER_KASAN if KASAN

Hello,

Have just had a chance to test this.

lib/Kconfig.kasan:
        config ARCH_NEEDS_DEFER_KASAN
                bool

        config ARCH_DEFER_KASAN
                def_bool y
                depends on KASAN
                depends on ARCH_NEEDS_DEFER_KASAN

It works for UML defconfig where arch/um/Kconfig is:

config UML
        bool
        default y
        select ARCH_NEEDS_DEFER_KASAN
        select ARCH_DEFER_KASAN if STATIC_LINK

But it prints warnings for PowerPC, LoongArch:

config LOONGARCH
        bool
        ...
        select ARCH_NEEDS_DEFER_KASAN
        select ARCH_DEFER_KASAN

$ make defconfig ARCH=3Dloongarch
*** Default configuration is based on 'loongson3_defconfig'

WARNING: unmet direct dependencies detected for ARCH_DEFER_KASAN
  Depends on [n]: KASAN [=3Dn] && ARCH_NEEDS_DEFER_KASAN [=3Dy]
  Selected by [y]:
  - LOONGARCH [=3Dy]


config PPC
        bool
        default y
        select ARCH_DEFER_KASAN if PPC_RADIX_MMU
        select ARCH_NEEDS_DEFER_KASAN

$ make ppc64_defconfig

WARNING: unmet direct dependencies detected for ARCH_DEFER_KASAN
  Depends on [n]: KASAN [=3Dn] && ARCH_NEEDS_DEFER_KASAN [=3Dy]
  Selected by [y]:
  - PPC [=3Dy] && PPC_RADIX_MMU [=3Dy]


> >
>
> I don't think so because it requires all architectures to add 'if KASAN'
> which is not convenient.
>
> Christophe

