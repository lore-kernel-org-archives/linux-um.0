Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D91C87FCA
	for <linux-um@archiver.kernel.org>; Sun, 10 Aug 2025 07:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=to3a2j5jgrrDRsoCDy9JGxvNqhRLdP/C+mURmWO4ysI=; b=jWFxATDOOk1FglaOdzdDsV3Ea4
	Fzo8IkBs9k8KpFZTbYpLMkBOu58xa4UoDbgNogQOhHnXSYKgMBA1U8D6eqIfLT2hl0EaYBFf2q0IO
	k41Kl8clrAaGzF2veiDI7rX3/ed1z0x0czts05G3vdyInQ11lh12zFgQspOwlBxDnPCefRpckt8qG
	UaJpOnRxkX5048zaehOOW3+IEoYfq4M3JkG0V5jsbtE+uZ+OZWyA1iSsA2n/vp0oxZ+XyZK4pDivo
	pVE1+XyXDMVCW5lnmuoqR7groybnFcGBtsTHmYNJbBe3MV/pxqx8sjLzZBkBsf4TzxQO04y8347m3
	adxCcglg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul0aB-00000005P83-3XO9;
	Sun, 10 Aug 2025 07:35:07 +0000
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul0Xc-00000005Ott-3Coi;
	Sun, 10 Aug 2025 07:32:30 +0000
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-55b93104888so4356308e87.1;
        Sun, 10 Aug 2025 00:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754811147; x=1755415947; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=to3a2j5jgrrDRsoCDy9JGxvNqhRLdP/C+mURmWO4ysI=;
        b=Oj1y3AToM1O7P4KX5gKRQSXJLLA0GS348TkN54J8VqWWpB/lVuJMlTk7RjpIzKA/lS
         ZQJCaX9fwXAYeyiWTglzPi6gK43W3YgyxEL6SQFVwp50A3TfU+PA3Yr1PCt/n6Y+qfVs
         SeydK8oOz1R9/ts30ayAk6EZ81WX96paMrFZeF6WBkA52EaFUoqBdw0h9tdhRLKqnv1F
         56w2bVF+eBiSXGE0+DZnyOEaRSqppzSTP53LBgE5DefGEGTNqL0+gJTsZsuKqFUT478T
         YfadTnhIlKKg6m7wC7DhD1TSBXU8IGeUhi/LgEdrxz3y/5CiSQJvFXH+XOBpl6Xmvavu
         WlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754811147; x=1755415947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=to3a2j5jgrrDRsoCDy9JGxvNqhRLdP/C+mURmWO4ysI=;
        b=IuCjDMg0koqeNBvVgyRN+NrP6JknIY+MiFRI6Rs8zBt1VPIswVeTRWTX8jWct07Doy
         NJXa8xG6v8FyY94X7HN28yg5ndmyAwl1ECsXRG8hzrdD7f7SyxTO/OA+g/xxE7e/fcmq
         Izh9Z1HXOh9TzB+Ui4990gH2JMl6fxIZ3lSgqNW4oUPTvXt0tG/5fl9vW7gXIXq/DFUQ
         Z7RuhP06+GRNffDbXepLmRtbQOAPw0k5ypPiN1OfM2RKz5E29C2WqxI7s2ATzoasLgXv
         Mj589sOs3Y5idFhW0eWKf3U1CPUhqQuIhXQ65WtzlWRNN9ahU1W3qkmey33faGq8ZAnb
         G9xA==
X-Forwarded-Encrypted: i=1; AJvYcCVaS+RnyBospS/txKEdp5orCcRxoB90Cn1/NMVogF/ZoAgNvJ0R+gC/eGQN66c14oAw4fg3tGW/L8FpoSw=@lists.infradead.org, AJvYcCVasYxSfXh+zDhYG7/v8NGz82/8JJIu0cRUCE2Iy/uC1CmPxdKukL/KyXAjcwkbBL4Aa2M77b3olng=@lists.infradead.org, AJvYcCWXbPVKCPGKgdJgQ40XvAeSNI5xgrDsllr6fx+A75fibTI9TDPkdBCecARfGDKMJabazVji2CW5nMwLkXxBMWKI@lists.infradead.org
X-Gm-Message-State: AOJu0YyX6ezV0nWI2FqMX9CXwgO5BVk9C7TwAdcyztVhXdmjvC9O66JO
	VB0eZfyXMb/bmyzoX8c0Q81ntguBT0mGJv9p1uPLPK/zCrGgU4RmdCcQJgi2XK7TJNXxq9ooPFd
	5LHr60uvlAZAYgCg1uyWE0e58/6gOuemgrWzlEUA1bQ==
X-Gm-Gg: ASbGncsvxv/duvXe4ptjd/KEiGys8BFgrgiZTCm38qVIJnwj/CWeO4GloyuUKHcrftU
	nn3tK2wGmUGHn120nWeCmwbYDzK7Hy9ll/DMD7Y/L2qeR7LgQeqLqOC7zR5L9P0MP1go8uHWIT4
	8HrutxytGnAu0cSW5Bf9M34UCH6AUDjXukFL6kZ3rWanFC6mW6lrOH2pImR/jQcgjRj8euIm1OJ
	igLHpAHtJYAx1v8UgQe5wXlCPUZ1DzLLr6ITvy3a3r+i7PFaA==
X-Google-Smtp-Source: AGHT+IHSiW6flEmK0NWVDywJ0JDvDzDflYl3FPZq6Arom7yJiee4WZtdkHowtUkS6j3k/g3AhngqPPQBa36CQfXo8jE=
X-Received: by 2002:a05:6512:1052:b0:553:2480:2308 with SMTP id
 2adb3069b0e04-55cc00eb7eemr2065404e87.21.1754811146600; Sun, 10 Aug 2025
 00:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250807194012.631367-1-snovitoll@gmail.com> <20250807194012.631367-2-snovitoll@gmail.com>
 <22872a3f-85dc-4740-b605-ba80b5a3b1bc@csgroup.eu> <CACzwLxjnofD0EsxrtgbG3svXHL+TpYcio4B67SCY9Mi3C-jdsQ@mail.gmail.com>
 <af677847-e625-43d7-8750-b2ce4ba9626c@csgroup.eu> <CACzwLxjr+Z+xUj-936rcWDSqEwfUP7bRB1xcqZQKGE7ux-gEXQ@mail.gmail.com>
In-Reply-To: <CACzwLxjr+Z+xUj-936rcWDSqEwfUP7bRB1xcqZQKGE7ux-gEXQ@mail.gmail.com>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Sun, 10 Aug 2025 12:32:08 +0500
X-Gm-Features: Ac12FXzPCnTCatZw8a7ccc080L84VXsdNPtKeE-8RXfhfS3owZfq0geCNjkMt-Q
Message-ID: <CACzwLxi5AKT_81ej4AZ1ztsncBDY4jDJCyWboF0X9-kiH_=NMA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] kasan: introduce ARCH_DEFER_KASAN and unify static
 key across modes
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: ryabinin.a.a@gmail.com, bhe@redhat.com, hca@linux.ibm.com, 
	andreyknvl@gmail.com, akpm@linux-foundation.org, zhangqing@loongson.cn, 
	chenhuacai@loongson.cn, glider@google.com, dvyukov@google.com, alex@ghiti.fr, 
	agordeev@linux.ibm.com, vincenzo.frascino@arm.com, elver@google.com, 
	kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org, 
	davidgow@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250810_003228_807933_757F8DB0 
X-CRM114-Status: GOOD (  34.27  )
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

On Sun, Aug 10, 2025 at 12:20=E2=80=AFPM Sabyrzhan Tasbolatov
<snovitoll@gmail.com> wrote:
>
> On Fri, Aug 8, 2025 at 10:03=E2=80=AFPM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
> >
> >
> >
> > Le 08/08/2025 =C3=A0 17:33, Sabyrzhan Tasbolatov a =C3=A9crit :
> > > On Fri, Aug 8, 2025 at 10:03=E2=80=AFAM Christophe Leroy
> > > <christophe.leroy@csgroup.eu> wrote:
> > >>
> > >>
> > >>
> > >> Le 07/08/2025 =C3=A0 21:40, Sabyrzhan Tasbolatov a =C3=A9crit :
> > >>> Introduce CONFIG_ARCH_DEFER_KASAN to identify architectures [1] tha=
t need
> > >>> to defer KASAN initialization until shadow memory is properly set u=
p,
> > >>> and unify the static key infrastructure across all KASAN modes.
> > >>
> > >> That probably desserves more details, maybe copy in informations fro=
m
> > >> the top of cover letter.
> > >>
> > >> I think there should also be some exeplanations about
> > >> kasan_arch_is_ready() becoming kasan_enabled(), and also why
> > >> kasan_arch_is_ready() completely disappear from mm/kasan/common.c
> > >> without being replaced by kasan_enabled().
> > >>
> > >>>
> > >>> [1] PowerPC, UML, LoongArch selects ARCH_DEFER_KASAN.
> > >>>
> > >>> Closes: https://eur01.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D217049&data=3D05%7C02%7C=
christophe.leroy%40csgroup.eu%7Cfe4f5a759ad6452b047408ddd691024a%7C8b87af7d=
86474dc78df45f69a2011bb5%7C0%7C0%7C638902640503259176%7CUnknown%7CTWFpbGZsb=
3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFp=
bCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DUM4uvQihJdeWwcC6DIiJXbn4wGsrijjRc=
Hc55uCMErI%3D&reserved=3D0
> > >>> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> > >>> ---
> > >>> Changes in v5:
> > >>> - Unified patches where arch (powerpc, UML, loongarch) selects
> > >>>     ARCH_DEFER_KASAN in the first patch not to break
> > >>>     bisectability
> > >>> - Removed kasan_arch_is_ready completely as there is no user
> > >>> - Removed __wrappers in v4, left only those where it's necessary
> > >>>     due to different implementations
> > >>>
> > >>> Changes in v4:
> > >>> - Fixed HW_TAGS static key functionality (was broken in v3)
> > >>> - Merged configuration and implementation for atomicity
> > >>> ---
> > >>>    arch/loongarch/Kconfig                 |  1 +
> > >>>    arch/loongarch/include/asm/kasan.h     |  7 ------
> > >>>    arch/loongarch/mm/kasan_init.c         |  8 +++----
> > >>>    arch/powerpc/Kconfig                   |  1 +
> > >>>    arch/powerpc/include/asm/kasan.h       | 12 ----------
> > >>>    arch/powerpc/mm/kasan/init_32.c        |  2 +-
> > >>>    arch/powerpc/mm/kasan/init_book3e_64.c |  2 +-
> > >>>    arch/powerpc/mm/kasan/init_book3s_64.c |  6 +----
> > >>>    arch/um/Kconfig                        |  1 +
> > >>>    arch/um/include/asm/kasan.h            |  5 ++--
> > >>>    arch/um/kernel/mem.c                   | 10 ++++++--
> > >>>    include/linux/kasan-enabled.h          | 32 ++++++++++++++++++--=
------
> > >>>    include/linux/kasan.h                  |  6 +++++
> > >>>    lib/Kconfig.kasan                      |  8 +++++++
> > >>>    mm/kasan/common.c                      | 17 ++++++++++----
> > >>>    mm/kasan/generic.c                     | 19 +++++++++++----
> > >>>    mm/kasan/hw_tags.c                     |  9 +-------
> > >>>    mm/kasan/kasan.h                       |  8 ++++++-
> > >>>    mm/kasan/shadow.c                      | 12 +++++-----
> > >>>    mm/kasan/sw_tags.c                     |  1 +
> > >>>    mm/kasan/tags.c                        |  2 +-
> > >>>    21 files changed, 100 insertions(+), 69 deletions(-)
> > >>>
> > >>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > >>> index f0abc38c40a..cd64b2bc12d 100644
> > >>> --- a/arch/loongarch/Kconfig
> > >>> +++ b/arch/loongarch/Kconfig
> > >>> @@ -9,6 +9,7 @@ config LOONGARCH
> > >>>        select ACPI_PPTT if ACPI
> > >>>        select ACPI_SYSTEM_POWER_STATES_SUPPORT if ACPI
> > >>>        select ARCH_BINFMT_ELF_STATE
> > >>> +     select ARCH_DEFER_KASAN if KASAN
> > >>
> > >> Instead of adding 'if KASAN' in all users, you could do in two steps=
:
> > >>
> > >> Add a symbol ARCH_NEEDS_DEFER_KASAN.
> > >>
> > >> +config ARCH_NEEDS_DEFER_KASAN
> > >> +       bool
> > >>
> > >> And then:
> > >>
> > >> +config ARCH_DEFER_KASAN
> > >> +       def_bool
> > >> +       depends on KASAN
> > >> +       depends on ARCH_DEFER_KASAN
> > >> +       help
> > >> +         Architectures should select this if they need to defer KAS=
AN
> > >> +         initialization until shadow memory is properly set up. Thi=
s
> > >> +         enables runtime control via static keys. Otherwise, KASAN =
uses
> > >> +         compile-time constants for better performance.
> > >>
> > >
> > > Actually, I don't see the benefits from this option. Sorry, have just
> > > revisited this again.
> > > With the new symbol, arch (PowerPC, UML, LoongArch) still needs selec=
t
> > > 2 options:
> > >
> > > select ARCH_NEEDS_DEFER_KASAN
> > > select ARCH_DEFER_KASAN
> >
> > Sorry, my mistake, ARCH_DEFER_KASAN has to be 'def_bool y'. Missing the
> > 'y'. That way it is automatically set to 'y' as long as KASAN and
> > ARCH_NEEDS_DEFER_KASAN are selected. Should be:
> >
> > config ARCH_DEFER_KASAN
> >         def_bool y
> >         depends on KASAN
> >         depends on ARCH_NEEDS_DEFER_KASAN
> >
> >
> > >
> > > and the oneline with `if` condition is cleaner.
> > > select ARCH_DEFER_KASAN if KASAN
>
> Hello,
>
> Have just had a chance to test this.
>
> lib/Kconfig.kasan:
>         config ARCH_NEEDS_DEFER_KASAN
>                 bool
>
>         config ARCH_DEFER_KASAN
>                 def_bool y
>                 depends on KASAN
>                 depends on ARCH_NEEDS_DEFER_KASAN

Setting Kconfig.kasan without KASAN works fine for 3 arch that selects
ARCH_DEFER_KASAN:

config ARCH_DEFER_KASAN
       def_bool y
       depends on ARCH_NEEDS_DEFER_KASAN

Going to send v6 soon.

P.S.: Fixed email of David Gow.

>
> It works for UML defconfig where arch/um/Kconfig is:
>
> config UML
>         bool
>         default y
>         select ARCH_NEEDS_DEFER_KASAN
>         select ARCH_DEFER_KASAN if STATIC_LINK
>
> But it prints warnings for PowerPC, LoongArch:
>
> config LOONGARCH
>         bool
>         ...
>         select ARCH_NEEDS_DEFER_KASAN
>         select ARCH_DEFER_KASAN
>
> $ make defconfig ARCH=3Dloongarch
> *** Default configuration is based on 'loongson3_defconfig'
>
> WARNING: unmet direct dependencies detected for ARCH_DEFER_KASAN
>   Depends on [n]: KASAN [=3Dn] && ARCH_NEEDS_DEFER_KASAN [=3Dy]
>   Selected by [y]:
>   - LOONGARCH [=3Dy]
>
>
> config PPC
>         bool
>         default y
>         select ARCH_DEFER_KASAN if PPC_RADIX_MMU
>         select ARCH_NEEDS_DEFER_KASAN
>
> $ make ppc64_defconfig
>
> WARNING: unmet direct dependencies detected for ARCH_DEFER_KASAN
>   Depends on [n]: KASAN [=3Dn] && ARCH_NEEDS_DEFER_KASAN [=3Dy]
>   Selected by [y]:
>   - PPC [=3Dy] && PPC_RADIX_MMU [=3Dy]
>
>
> > >
> >
> > I don't think so because it requires all architectures to add 'if KASAN=
'
> > which is not convenient.
> >
> > Christophe

