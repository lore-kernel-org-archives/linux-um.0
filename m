Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDEDC54E4A
	for <linux-um@archiver.kernel.org>; Tue, 27 Feb 2024 11:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y4Tv6sdcFEpWvZL/hYJEF+Ju7qt4AFqMkWFUs5NrLKU=; b=xL2ISCmaw2nAVoTemGFRSYASO8
	s8vkEF910oSoegQ/cx3BXXfHmXGwp/v+XL6d6sj/OnDMGD8uh1+YPW3EMOUHdWtv3U3TDLDZEjWI6
	d39sssuKiqp/qxKEQ1yRZ8iltgR+5HAk+v0NxpIYjyJXX/NB1PyWAon83LYcAROK15igGKJjWo65R
	/NjzuTd/BYyJHkOWAtawYeFEq8Jbr87UElPxdZM3vRJXViFV/drsxFlNHv+IYAiiELcVXpqToJ3NO
	Jnj6bsoq8erBCGvzSv+NwrxrP0gyWRd81D+rFFO0H0dtAc+mCmp5HCB+IQ9o/PWGlCHiV88A4NNyv
	qfal7VRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1revOV-00000004tok-41JO;
	Tue, 27 Feb 2024 11:13:07 +0000
Received: from mail-io1-f54.google.com ([209.85.166.54])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1revOQ-00000004tmz-2Sb5;
	Tue, 27 Feb 2024 11:13:03 +0000
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7bb5fda069bso239957639f.0;
        Tue, 27 Feb 2024 03:13:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709032379; x=1709637179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4Tv6sdcFEpWvZL/hYJEF+Ju7qt4AFqMkWFUs5NrLKU=;
        b=Fx/UWjTBB0vV69yjYR/HYeGmigEYxo2ktBhygY/pRRgiKCyzIjatzT/qR47y/DEHJb
         4GqZGNoMJ6EMYYrlvLCU5hb0k5L1S/LHeTz+hwERkPGPSV6Fla1MXRL6ijN4fuBLGbrA
         nZXkBLEeyQfPtBHXoStniY5bxeKdFPUlmaqNHtGSqAkw6YUcmjw5VqpoTY7OX7kqGBhj
         OxvuBY9hbOFGy9lDSk5RTIozwMWTCUwmT9gdOnKoBSIYlhSfcvVmMX6jVRWFCnC+Omnp
         N01asSEyzGkNC0jqtm/cR7Ads7xIEq2bev5SP8ByWhhKT9wQs6ARWGA7BhaOZceCX6Ki
         zKfg==
X-Forwarded-Encrypted: i=1; AJvYcCUZg+7vOj93i0126wNMhUtg4Y60YYzSa7WTMOHnu45HhEgKg/7LH9tzjbLpbIuJSlKQ/lf+3oE7NiZLrx42tB4J0nGv5iSs8q3+BT+Ji4Ly1z52L7GvJEKUdvyMFfsR+PWX/tKLZRf0M3/nZggTzs9gkXSgbQKB5oi1pOpcYkMK6JcKjvlzbk/M0KBLUiZWyZauTZ1/jrd/vkJfBlcz7md6V5gx1Rl8KwQcye/Wt1UWSMDtAPsy8zk=
X-Gm-Message-State: AOJu0YyEq1fvyCPYQJOtDeRKQa0cKel8NSmicpe0CNzXDcRcwyblC/Ae
	EEg/iv+e6xcTsgCiCK7ferqVlrdCxxiQQWsmxwgPOfpQSQnWem8Dq4RBr+xueW2Qvw==
X-Google-Smtp-Source: AGHT+IGzhwvYBWxQVYC8fUrv+Wj9OZAam2OMs89EA17nhi4LxFLRrIwjApYg51vCmebPSi5o29yGZg==
X-Received: by 2002:a05:6602:3f88:b0:7c7:b815:ff93 with SMTP id fb8-20020a0566023f8800b007c7b815ff93mr10704981iob.17.1709032379015;
        Tue, 27 Feb 2024 03:12:59 -0800 (PST)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com. [209.85.166.49])
        by smtp.gmail.com with ESMTPSA id eo4-20020a0566024b0400b007c7a55ea0b6sm1729890iob.48.2024.02.27.03.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 03:12:58 -0800 (PST)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7bb5fda069bso239956639f.0;
        Tue, 27 Feb 2024 03:12:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUYiFtN8XQcQclMGSJpkIj4Z7EiAqN1UO1yVlBZImKZxT3LzidKlaE0Kw5aUZUmLTFnomHsDLD7Azes7phP84nEUUoGvK6+GpHyhYmCP/6uHuGJpp+sEE6AgO2iPlr1saseFUx9umjd5RZkzwiOIEbAXr0cUhgGaSKKAFmJ8EZPQh4pP/gRIXrOCUkgh+LzlA3piG+qUepUiVO7Wv99/ljzVhp2p9Gjwp74drEnrZWLokWiBQC9hbU=
X-Received: by 2002:a5b:ecc:0:b0:dc6:c32f:6126 with SMTP id
 a12-20020a5b0ecc000000b00dc6c32f6126mr1607871ybs.22.1709032357452; Tue, 27
 Feb 2024 03:12:37 -0800 (PST)
MIME-Version: 1.0
References: <20240226161414.2316610-1-arnd@kernel.org> <20240226161414.2316610-4-arnd@kernel.org>
 <CAMuHMdWRBQF95fJ+NkPUdvpu5VfRm2WyTnvdqB1Xe7d4vsvY2g@mail.gmail.com> <164616c2-94f6-40e8-86e0-850dc8da212e@app.fastmail.com>
In-Reply-To: <164616c2-94f6-40e8-86e0-850dc8da212e@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Feb 2024 12:12:24 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQYPtL0J4Phm81S1qWpi7no=1r4uStbLd8zbjn7fcWQw@mail.gmail.com>
Message-ID: <CAMuHMdXQYPtL0J4Phm81S1qWpi7no=1r4uStbLd8zbjn7fcWQw@mail.gmail.com>
Subject: Re: [PATCH 3/4] arch: define CONFIG_PAGE_SIZE_*KB on all architectures
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Kees Cook <keescook@chromium.org>, 
	Anna-Maria Gleixner <anna-maria@linutronix.de>, Matt Turner <mattst88@gmail.com>, 
	Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, guoren <guoren@kernel.org>, 
	Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Palmer Dabbelt <palmer@dabbelt.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Andreas Larsson <andreas@gaisler.com>, 
	Richard Weinberger <richard@nod.at>, x86@kernel.org, Max Filippov <jcmvbkbc@gmail.com>, 
	Andy Lutomirski <luto@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Kieran Bingham <kbingham@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, 
	"linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_031302_636178_56F588DE 
X-CRM114-Status: GOOD (  30.19  )
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

CC Greg

On Tue, Feb 27, 2024 at 11:59=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrot=
e:
> On Tue, Feb 27, 2024, at 09:54, Geert Uytterhoeven wrote:
> >> diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
> >> index 9dcf245c9cbf..c777a129768a 100644
> >> --- a/arch/m68k/Kconfig.cpu
> >> +++ b/arch/m68k/Kconfig.cpu
> >> @@ -30,6 +30,7 @@ config COLDFIRE
> >>         select GENERIC_CSUM
> >>         select GPIOLIB
> >>         select HAVE_LEGACY_CLK
> >> +       select HAVE_PAGE_SIZE_8KB if !MMU
> >
> > .... if you would drop the !MMU-dependency here.
> >
> >>
> >>  endchoice
> >>
> >> @@ -45,6 +46,7 @@ config M68000
> >>         select GENERIC_CSUM
> >>         select CPU_NO_EFFICIENT_FFS
> >>         select HAVE_ARCH_HASH
> >> +       select HAVE_PAGE_SIZE_4KB
> >
> > Perhaps replace this by
> >
> >     config M68KCLASSIC
> >             bool "Classic M68K CPU family support"
> >             select HAVE_ARCH_PFN_VALID
> >   +         select HAVE_PAGE_SIZE_4KB if !MMU
> >
> > so it covers all 680x0 CPUs without MMU?
>
> I was a bit unsure about how to best do this since there
> is not really a need for a fixed page size on nommu kernels,
> whereas the three MMU configs clearly tie the page size to
> the MMU rather than the platform.
>
> There should be no reason for coldfire to have a different
> page size from dragonball if neither of them actually uses
> hardware pages, so one of them could be changed later.

Indeed, in theory, PAGE_SIZE doesn't matter for nommu, but the concept
of pages is used all over the place in Linux.

I'm mostly worried about some Coldfire code relying on the actual value
of PAGE_SIZE in some other context. e.g. for configuring non-cacheable
regions.

And does this impact running nommu binaries on a system with MMU?
I.e. if nommu binaries were built with a 4 KiB PAGE_SIZE, do they
still run on MMU systems with an 8 KiB PAGE_SIZE (coldfire and sun3),
or are there some subtleties to take into account?

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

