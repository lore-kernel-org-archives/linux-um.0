Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8EC0C5478C
	for <linux-um@archiver.kernel.org>; Tue, 27 Feb 2024 08:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LF4kXg8LPe/h8pV/74EqYHGgPgOEfsUWLG6ibzoE1S0=; b=R67llyc3cnwA3sDLl4ofMI/KB0
	zIMDVt2i1hDUD6JB/uJ2q5l6Utp5t88gPEJYuVNTmC1eAO18jafzU1iaYFXL3/0aUJxtgouYmrvxL
	vX03N3xr0M7SR9BIBkpb2doEmlJg9EmXx645CHfABhNSj6CkSnDr/ukyDcRazUni9PTB+qAAbGGEH
	OKG7l84EP1Om74FJLLCWkp8T3qxnuJuU8KkXqLWjAZ8UIr0ntMlKJG0Ewd975S0LpobHd4eSH+82W
	53MTCXd7W+CErPP/D9ssTcNgcwNwv0FbNmjDsmuQqH53V2dNYfiQqqGrjIyX8aEb4niFR77aNpW8o
	R+lKMwYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1retFH-00000004PZU-1L8P;
	Tue, 27 Feb 2024 08:55:27 +0000
Received: from mail-pf1-f180.google.com ([209.85.210.180])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1retFC-00000004PVg-2xUV;
	Tue, 27 Feb 2024 08:55:24 +0000
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6da202aa138so2635462b3a.2;
        Tue, 27 Feb 2024 00:55:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709024119; x=1709628919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LF4kXg8LPe/h8pV/74EqYHGgPgOEfsUWLG6ibzoE1S0=;
        b=CKyJQOTh5EEr0PmLlVxtnmopwqr2ZYDk+CNr5//kMZIrge53zz0JH0fQVGlG//S44n
         n7p1Ah715/+2d2Unv53mut85txmudbPevS3u00Irgm+zrYaO5WEBbuBhlaLe72DcTlYQ
         BMKjo207iMDD5c0NRg74l+V+R5quOjoCMHbixIYEdvyB/+ckOzyz8ledCwU/3oj0F+xc
         t3jibcYrzP4WwBYMcqg2y6gXbRE2SK3zV8aj76d9rFdyGmys1rDK/NZqZXG+v2d3fvSx
         9nuRU3UV3OBOECZV75AbLBYwU6HxfWsPBjRpb7qXsj2oGe/5PuQYL5V+NmHLYljK6bEk
         iWHA==
X-Forwarded-Encrypted: i=1; AJvYcCVLNgVkNkL5bZCRzc7r/Aqb4Fp5+906n+TtPhe1bWSMsKl9M1o+ov25jpMy4yO6umIKbgEqUNQppWZtPi8sX81etV0NOiYxmS14x2e4K00UU65VRtGn9O6lEtkiZKNP0guo5uuDS9fwk3MIGhjlaQbjummfvvIMlhFXo5OkiyrUTvZAaBKKng1U4sai53dNopV39OsXmmQaIs83lJqjZEGnfijcFVU4aPvAYt07g64FpDelSyyM9wc=
X-Gm-Message-State: AOJu0YzAPVW0u4/ao7ycabzKfdG6QVc0za+2wv0PhchHZH5Yx+aXrSJ3
	qXmJKeINjp3JTerBIbBaaqd4rep65T4q9L885gSdCGl1uVDI7WlgTEJQig8hUX19hA==
X-Google-Smtp-Source: AGHT+IGhW/2kP/IsRHJQ27M/f0ypZS+oxnC8tPIR8VMRPHsGk5BXe+0dPgXX1Ujjxoa200e0pYTuhQ==
X-Received: by 2002:a62:cf04:0:b0:6e4:625a:f03 with SMTP id b4-20020a62cf04000000b006e4625a0f03mr9372321pfg.15.1709024118771;
        Tue, 27 Feb 2024 00:55:18 -0800 (PST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com. [209.85.215.177])
        by smtp.gmail.com with ESMTPSA id gu17-20020a056a004e5100b006e4e584ed59sm5361650pfb.116.2024.02.27.00.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 00:55:18 -0800 (PST)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso3429187a12.2;
        Tue, 27 Feb 2024 00:55:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVOBXVJfLco/o9zyxUZSdFC48o4Cd12UkGy0rVFCiBu2Y4lowBdmqqhliGFSiwyjg3VvKJ2oGG6GzWS9ivw5GJDbAWe7RbyRVA3bJMun8rFZoh+K22B+LraS7K+Bps94rEPhkI+fEqipIvb8s4dTF0oQE0y8YAoHqf1AFMIXzn5NFGDJEKKJmpfu+gyTqdmFyGNQaAQvEu40hMyRNiojWHOgJu4z0uGzAju1vRO7JEjC9J3MUIKSMc=
X-Received: by 2002:a25:71c3:0:b0:dcf:2b44:f38d with SMTP id
 m186-20020a2571c3000000b00dcf2b44f38dmr1589302ybc.49.1709024097788; Tue, 27
 Feb 2024 00:54:57 -0800 (PST)
MIME-Version: 1.0
References: <20240226161414.2316610-1-arnd@kernel.org> <20240226161414.2316610-4-arnd@kernel.org>
In-Reply-To: <20240226161414.2316610-4-arnd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Feb 2024 09:54:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWRBQF95fJ+NkPUdvpu5VfRm2WyTnvdqB1Xe7d4vsvY2g@mail.gmail.com>
Message-ID: <CAMuHMdWRBQF95fJ+NkPUdvpu5VfRm2WyTnvdqB1Xe7d4vsvY2g@mail.gmail.com>
Subject: Re: [PATCH 3/4] arch: define CONFIG_PAGE_SIZE_*KB on all architectures
To: Arnd Bergmann <arnd@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Kees Cook <keescook@chromium.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Arnd Bergmann <arnd@arndb.de>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Michal Simek <monstr@monstr.eu>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Palmer Dabbelt <palmer@dabbelt.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Andreas Larsson <andreas@gaisler.com>, 
	Richard Weinberger <richard@nod.at>, x86@kernel.org, Max Filippov <jcmvbkbc@gmail.com>, 
	Andy Lutomirski <luto@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Kieran Bingham <kbingham@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_005522_753415_6A273E54 
X-CRM114-Status: GOOD (  23.89  )
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

On Mon, Feb 26, 2024 at 5:15=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Most architectures only support a single hardcoded page size. In order
> to ensure that each one of these sets the corresponding Kconfig symbols,
> change over the PAGE_SHIFT definition to the common one and allow
> only the hardware page size to be selected.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch!

> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -84,12 +84,15 @@ config MMU
>
>  config MMU_MOTOROLA
>         bool
> +       select HAVE_PAGE_SIZE_4KB
>
>  config MMU_COLDFIRE
> +       select HAVE_PAGE_SIZE_8KB

I think you can do without this...

>         bool
>
>  config MMU_SUN3
>         bool
> +       select HAVE_PAGE_SIZE_8KB
>         depends on MMU && !MMU_MOTOROLA && !MMU_COLDFIRE
>
>  config ARCH_SUPPORTS_KEXEC
> diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
> index 9dcf245c9cbf..c777a129768a 100644
> --- a/arch/m68k/Kconfig.cpu
> +++ b/arch/m68k/Kconfig.cpu
> @@ -30,6 +30,7 @@ config COLDFIRE
>         select GENERIC_CSUM
>         select GPIOLIB
>         select HAVE_LEGACY_CLK
> +       select HAVE_PAGE_SIZE_8KB if !MMU

.... if you would drop the !MMU-dependency here.

>
>  endchoice
>
> @@ -45,6 +46,7 @@ config M68000
>         select GENERIC_CSUM
>         select CPU_NO_EFFICIENT_FFS
>         select HAVE_ARCH_HASH
> +       select HAVE_PAGE_SIZE_4KB

Perhaps replace this by

    config M68KCLASSIC
            bool "Classic M68K CPU family support"
            select HAVE_ARCH_PFN_VALID
  +         select HAVE_PAGE_SIZE_4KB if !MMU

so it covers all 680x0 CPUs without MMU?

>         select LEGACY_TIMER_TICK
>         help
>           The Freescale (was Motorola) 68000 CPU is the first generation =
of

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

