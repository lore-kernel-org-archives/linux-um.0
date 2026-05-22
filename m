Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96964CD5BB3
	for <linux-um@archiver.kernel.org>; Fri, 22 May 2026 16:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=grDKpp8JVlHzmuoytB0c4ASzqprybdr1MnlZeaoJ2dc=; b=If9EOY7d04snODJeUkcita+jVz
	h5GBKsQq3tCl054PO704jPz6uTNTcvqnQ6Yz+MFwHT2T+KHLndshOuyOdofNhy0mPOerSoDoWYi8M
	1506wwY44nVDb4Jy4le7eH+DxalkQAkWdrZCcoFLBfeSds/TEaRpS/vsPamkIfF19XcpBddwaWHsE
	+XAxXHZZt87vbC9BkcCxBTFRKAbP7jWDMX4e4xEW2eIx0da2rbmTGRvq19BSGgwm5Cg+q45Fp1e5Y
	nprvPV3/Y+rHSuPWRqqGSBtmlkd7OygqpTdFL7v1p87HOtPo3Il6DE6whaX76HhsUmM4ezVuE+gxH
	WkKiX9gA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQSTr-0000000BO61-02Ts;
	Fri, 22 May 2026 16:12:11 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQSTo-0000000BO0D-0GnF
	for linux-um@lists.infradead.org;
	Fri, 22 May 2026 16:12:09 +0000
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-82fbf5d4dc2so5315368b3a.1
        for <linux-um@lists.infradead.org>; Fri, 22 May 2026 09:12:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779466326; cv=none;
        d=google.com; s=arc-20240605;
        b=IBl6qOEaHnf2jO97SEwavjqBSs6eSG6lpgCcGBQtN39+rOTFZ7hUIx23/ZtMZG9TuH
         pt9yXig60cwgAVhfvL1G0/FMnZ6R3JP2+AgaTdHdiRIREO50qwyjEJyY0+g9glUNwpQ8
         LoC1Szb2zx8/+ZPYAYGfqJ1uggVaMK1Yy7kAdgwXfLUFl0JMPH2YFaSstzmJwooXAOVE
         ggQNhMrObxxPr2CIR/iGPX8pNQqwkdSv067hAdiy/+O9D87ozeumjh7BuYf/taOrpX1F
         +3CoM2YVxGcfZ+y46jHZEd/AyD5uHLN3UOyazdp3CZSrEwdj4SX0kNDN0ysKseUDJftF
         KXTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=grDKpp8JVlHzmuoytB0c4ASzqprybdr1MnlZeaoJ2dc=;
        fh=jOmjMIFzci/wGnLjZ+ZtI8a88eJXJBTyO6Cb1ZJbqNY=;
        b=ZoBogReQCJTSHUn+D3BVPYyvlgTytdIa+iDzH23mZFK5ulamc46V7VsgxDpn3kszDe
         IBIfwNcT+sFERxAWc5o/MQJS1aI7VtYyXgm01jQFnCVuLe7X0EQmA41OjIikGroKvx8t
         MW+b0L/IZUD6Fmb56g48LbPc9nfimFY1kEXS7SVaLrFTwJ3mYJ/gm+hAx7yScvvjcrbX
         W4VIwo/2FLgvFtX1hsS6XSjEScuBgjm8BXiLiczE4cedqreDek82nLC32SLqx3AQNKF9
         wgffvSFi1W4DCEaHB8PTrFqL7a67qGLjXN5jHAVDoVG11Pgs5xngDzZMT+5wuovQSuiX
         v6eA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779466326; x=1780071126; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=grDKpp8JVlHzmuoytB0c4ASzqprybdr1MnlZeaoJ2dc=;
        b=dOLZaVLj7KA2WV+y/krjN3LzuInUNbXtwLX4z0qQWEUWGnC01Bzj/Y8NdjaW/idwJ4
         F+5eQmmkL6MiRTEyLoLmuUDLCS4iqcyq+zoz3iGuGrr4MnxFm1aUBriQ7EXdra4roN/6
         i5uHI2w2dHhLRI9QD/C2b3E8LzUWST47n0z/oGTF0aUclkFdXPB/tBySjm7NiKvMK4XG
         785okHfKxL17nvn3bhZbYMi8OrwocyxIPk1flZiLKRRw7tfH9Lm6+Uw0oG2fddj+9xcS
         3KcbhUOUoe7v4BuL9kHGKfAi9ufIsD0QMGmT3f2gKLASo/o1rhn1IiU0o+9hKQvBt8ui
         isHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779466326; x=1780071126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=grDKpp8JVlHzmuoytB0c4ASzqprybdr1MnlZeaoJ2dc=;
        b=e5Dncj++3WzER4PStH+zj3kLS3sN2pGii81sy5Gf7HBEWrn7oWnaZIv1Q/0N0G2oVn
         15WrVGhM/BvjEM8qEifoCOhIcM6yUdBuYvoPmfSvpkp5W9cO1C6is3cHJvvcXrWUHipk
         JGWb8EpVeSCcd1Az4MRq/RFU+xc6PzfGkiMyt/opcgc9Adx0MW7YGOPayn/Igb4vOpDR
         V/Slf1tuQbRK9ZgG4v+uHrdupADfqnR/VZvisp1zOXQAQrFEcjZe6yEpXhCU3TBG+gQA
         23bV43awe+kkz3B4ozjN1s1aeFAou7uaDaHDzs0HJ5cUaaIG3JbO+hOknc0ihdMmKuiO
         vbOg==
X-Forwarded-Encrypted: i=1; AFNElJ9aCT5FqlPJzuZkBOJ7MYVmdbL5oRSgWW/TZ2ZNcWIcVcGazkEU7uZF5DRgN1lhYOAULFA+MvVcqg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyPw3ktehtbg51yOvVDLNU7AcY8z0/sc8vtMMc6mG+sHYEIeivM
	KbadANy1sbKolIDEV4Oe7OF/hxKn0gFrZIFni3DA1qNTFko5bY4NAimuR/H1bz37LqBNCTrnMXN
	LbtpM9BN5c0UUPkZjX48DWEibSVng3w==
X-Gm-Gg: Acq92OE3ecj+h1f5afJurYPk9IHhPK5QRKV03sfo8zb0IX8gy+HR/Cp9X6Eu+yjarRk
	aVAJY3ScFmc0h06H2DSmKZOFFdp4rbgT7LREaIbiJsCpFKQhwnIZF8xE+EsfGZYC6iisetNBkGG
	sgcpPKaPKkIMDiEs28UjXJAiqNZXZuRlB67QsNtnDALTGIvtlCi9KJYyDhpokVZHT2eHIJuIXNP
	tsu7ZVPgqehcFBwIyfcU9qEzkb8G45gvDBIEP9ZS+tIrAE7QsLbP9rU8TkivoBZJ/TyLdPGAkHu
	IsA8HpfukrfrzOWJ/44ORO7iJFaUKreVbuzciN4l
X-Received: by 2002:a05:6a00:3003:b0:82c:d986:e917 with SMTP id
 d2e1a72fcca58-8415f56374bmr4379678b3a.22.1779466326474; Fri, 22 May 2026
 09:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260522141959.1071595-1-arnd@kernel.org> <20260522141959.1071595-4-arnd@kernel.org>
In-Reply-To: <20260522141959.1071595-4-arnd@kernel.org>
From: Brian Gerst <brgerst@gmail.com>
Date: Fri, 22 May 2026 12:11:51 -0400
X-Gm-Features: AVHnY4JVeqEoaT_BiZ4moL6wP6KKgM_jYngI2Yt25yzAzMyv9iGaZRlOM4apgb0
Message-ID: <CAMzpN2h6pidPtLr8rLbVNjs_KSsOuvqbs3k3aJH1KhNxT80uPA@mail.gmail.com>
Subject: Re: [PATCH 3/8] x86: make TSC usage unconditional
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
	linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_091208_173296_0472595E 
X-CRM114-Status: GOOD (  21.32  )
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

On Fri, May 22, 2026 at 10:44=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wr=
ote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> There are multiple levels of functionality of the TSC that are checked
> for: built into the kernel, present in the CPU, reliable and probably
> more.
>
> Since the TSC-less CPUs are no longer supported in the kernel,
> remove all checks for CONFIG_TSC and X86_FEATURE_TSC and assume
> it's always there. Unfortunately the tsc_clocksource_reliable
> checks are still required though.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  Documentation/virt/kvm/x86/timekeeping.rst |  1 -
>  arch/x86/Kconfig                           |  1 -
>  arch/x86/Kconfig.cpu                       |  1 -
>  arch/x86/events/msr.c                      |  5 ----
>  arch/x86/include/asm/timex.h               |  3 ---
>  arch/x86/include/asm/trace_clock.h         |  8 -------
>  arch/x86/include/asm/tsc.h                 | 13 ----------
>  arch/x86/kernel/Makefile                   |  4 ++--
>  arch/x86/kernel/apic/apic.c                | 23 +++++++-----------
>  arch/x86/kernel/apic/io_apic.c             | 22 +----------------
>  arch/x86/kernel/cpu/centaur.c              |  2 --
>  arch/x86/kernel/cpu/common.c               |  4 +---
>  arch/x86/kernel/cpu/proc.c                 | 15 +++++-------
>  arch/x86/kernel/i8253.c                    |  3 ---
>  arch/x86/kernel/tsc.c                      | 28 ++--------------------
>  arch/x86/lib/kaslr.c                       | 20 ++++------------
>  arch/x86/xen/time.c                        |  2 --
>  drivers/net/ethernet/intel/igc/igc_ptp.c   |  4 ++--
>  drivers/ptp/Kconfig                        |  2 +-
>  tools/power/cpupower/debug/kernel/Makefile |  5 +---
>  20 files changed, 29 insertions(+), 137 deletions(-)
>
> diff --git a/Documentation/virt/kvm/x86/timekeeping.rst b/Documentation/v=
irt/kvm/x86/timekeeping.rst
> index 21ae7efa29ba..e8519451000d 100644
> --- a/Documentation/virt/kvm/x86/timekeeping.rst
> +++ b/Documentation/virt/kvm/x86/timekeeping.rst
> @@ -471,7 +471,6 @@ The following feature bits are used by Linux to signa=
l various TSC attributes,
>  but they can only be taken to be meaningful for UP or single node system=
s.
>
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -X86_FEATURE_TSC                        The TSC is available in hardware
>  X86_FEATURE_RDTSCP             The RDTSCP instruction is available
>  X86_FEATURE_CONSTANT_TSC       The TSC rate is unchanged with P-states
>  X86_FEATURE_NONSTOP_TSC                The TSC does not stop in C-states
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index a188ed90b1ca..2fd99a5b4a68 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -683,7 +683,6 @@ config X86_INTEL_QUARK
>         depends on X86_32
>         depends on X86_EXTENDED_PLATFORM
>         depends on X86_PLATFORM_DEVICES
> -       depends on X86_TSC
>         depends on PCI
>         depends on PCI_GOANY
>         depends on X86_IO_APIC
> diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
> index f4a12b74bed3..fe0246477345 100644
> --- a/arch/x86/Kconfig.cpu
> +++ b/arch/x86/Kconfig.cpu
> @@ -261,7 +261,6 @@ config X86_USE_PPRO_CHECKSUM
>
>  config X86_TSC
>         def_bool y
> -       depends on (MWINCHIP3D || MCRUSOE || MEFFICEON || MCYRIXIII || MK=
7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || =
M586MMX || M586TSC || MVIAC3_2 || MVIAC7 || MGEODEGX1 || MGEODE_LX || MATOM=
) || X86_64

Can't you just delete this config option since it's no longer relevant?

