Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACB0CAC585
	for <linux-um@archiver.kernel.org>; Mon,  8 Sep 2025 20:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hjkBXLakCAW8SDkTXur5T0KLhtwghv0ugvjIac4M9HE=; b=y/TBOSj+IV/NO41op5HxAXDORj
	CvfVjeCBfoeO4eL9TVvXi8jOn0wLAn2goh9bTcPVOJL1/o3Kk4GeUGTTRauzMN6UfT06CIVqyK6Tk
	Dm9dnoe1XwDKL4+syc2MDidgfY3FR/fKa45vHKm4yZTwl5chdSu/8entwDLBatac3sGqOkDK9is/y
	s+GsL4GPcUK30A+bKDBVewdaOGYkyQzseG5TCCGuf5FYfrGZtOtyjBwo2deZUGUVmVogu8e6HzaDt
	QZnsLwTZ3txnSgOtaVfmqeYPJAIOmHaJPODq7meqUKS0eKq0lBQatLza2AoDTPfNEydGWc4weTrvK
	T2lRnovg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvibX-00000002EBL-46XC;
	Mon, 08 Sep 2025 20:36:47 +0000
Received: from mail-vk1-f182.google.com ([209.85.221.182])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvf7g-00000000vrL-02vE
	for linux-um@lists.infradead.org;
	Mon, 08 Sep 2025 16:53:46 +0000
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-544bac3caf2so4195399e0c.0
        for <linux-um@lists.infradead.org>; Mon, 08 Sep 2025 09:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757350422; x=1757955222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjkBXLakCAW8SDkTXur5T0KLhtwghv0ugvjIac4M9HE=;
        b=LYshAyjxQVJA9khqozdpp9zbXrdMn5DAP+ZBXYEHlo2isCtUNTFXIQ8BImR8VlqH4y
         drx+YJoG/HeYeMAuEGIIOl/PfPHziNGp0MwISy9fH9oYj+FX5Don0N+flz9rqeWOUlhC
         CBjt6mme7ev+qu0GZkIHvFrcFYN64vwfPr4I2+htUbTgFT5n8DwNQ6EVSY2vJ42lLvQj
         M05kl6aED4C3v3e5ljUUbNhGNz0lJhYmLQ7HiHluTcMuinEUIzifUA9JPOKjbgc9mH6s
         VHQaQb0txh3+/bU2cnlPORhorFa4xf5+/v2Ydort0yGK0R2TIK9PJDQIasVF9kAUr+wa
         I3vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYDRoc1ZghnT+EW/wKL1GN+tDmBWkwiA0iDiiui2EvMy558G1iUkuvUdpnE1FL7IUtMpCxMjt1MQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyzCjT/4s8yEH7p3xhWC6jCehQSPmNoE5Xnstn+DcuR53Arl3tn
	8CCFoZqDtai5jm1MH9SSfy3iGBLWKKxpbbhgDtFq9L4qMhogJr1BeXC582mrMeCV
X-Gm-Gg: ASbGnctjO/PITNxa7enkbBimsM6CgRrDcSivYVxu6wqMX3vcGW8TgqtVo6uEW7WE4FN
	5uqzlZf6gzDREMqlwDgXstMwVzGRpWtXgeWdPS3wQp+2+qr3pduq/liE7Nrjs0rh8KnsjT2F6Fr
	SKQYkXk5ZoavDEaKCJQrkgDHZw42P+utK66ojNUUD07CtuaeYovm6R/NvkNThW4Ftd7wwS4kbKH
	AZgLIECPWXvWsYgzolm7YhlR3oap1L0Dkf/p3HT/geul9ToZ2kaKMHk962yjpRHzznY8mu4AC0I
	U2/KIziyzcRLjZqiwSljABBr2q1PoSxG59ebK7IpCriGhQu5pwYnHl91BTX9mk4D5UadhXPnGCT
	xok/59LD86awwvbSIrbdyw3ypXi3NOsmJbNKfcUwShZiHl2X6ZUYdvU6EVj0guwB0zgCNug0=
X-Google-Smtp-Source: AGHT+IEwVYhTTSFceLAXiqX9xqcsm7EWx/I2tBCYw+y5fKKDNHLlhi9Prk3EM6h3xkC7sI4xtKyHNg==
X-Received: by 2002:a05:6122:25e8:b0:53b:fb9:6fd3 with SMTP id 71dfb90a1353d-545f0e47bb0mr3466317e0c.7.1757350422489;
        Mon, 08 Sep 2025 09:53:42 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5449bc6668esm12272666e0c.0.2025.09.08.09.53.42
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 09:53:42 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-528a601a3cbso3399464137.1
        for <linux-um@lists.infradead.org>; Mon, 08 Sep 2025 09:53:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUi3+StIudYhvwyLGcORwnXtqG1uXpRTvlH6Rf5ewMchCFLqPmu7wArrhwUsyKsCMlrqli6Zd3m5g==@lists.infradead.org
X-Received: by 2002:a05:6102:837:b0:519:534a:6c36 with SMTP id
 ada2fe7eead31-538ee110d66mr3147822137.14.1757350421953; Mon, 08 Sep 2025
 09:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250908-kunit-uml-pci-v2-1-d8eba5f73c9d@linutronix.de>
In-Reply-To: <20250908-kunit-uml-pci-v2-1-d8eba5f73c9d@linutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 8 Sep 2025 18:53:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX6raywNiuDG0zzYQu35YpfSHoE4KSsJLcDfeSqZAac+Q@mail.gmail.com>
X-Gm-Features: AS18NWCOgGkOzhjvanqfDUP1q6zt0NU9rXDim1ALfm6PZrsbbVsOgLivd9-1uTg
Message-ID: <CAMuHMdX6raywNiuDG0zzYQu35YpfSHoE4KSsJLcDfeSqZAac+Q@mail.gmail.com>
Subject: Re: [PATCH RESEND v2] kunit: Enable PCI on UML without triggering WARN()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250908_095344_083876_7206462A 
X-CRM114-Status: GOOD (  26.36  )
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

Hi Thomas,

On Mon, 8 Sept 2025 at 09:04, Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
> Various KUnit tests require PCI infrastructure to work. All normal
> platforms enable PCI by default, but UML does not. Enabling PCI from
> .kunitconfig files is problematic as it would not be portable. So in
> commit 6fc3a8636a7b ("kunit: tool: Enable virtio/PCI by default on UML")
> PCI was enabled by way of CONFIG_UML_PCI_OVER_VIRTIO=3Dy. However
> CONFIG_UML_PCI_OVER_VIRTIO requires additional configuration of
> CONFIG_UML_PCI_OVER_VIRTIO_DEVICE_ID or will otherwise trigger a WARN() i=
n
> virtio_pcidev_init(). However there is no one correct value for
> UML_PCI_OVER_VIRTIO_DEVICE_ID which could be used by default.
>
> This warning is confusing when debugging test failures.
>
> On the other hand, the functionality of CONFIG_UML_PCI_OVER_VIRTIO is not
> used at all, given that it is completely non-functional as indicated by
> the WARN() in question. Instead it is only used as a way to enable
> CONFIG_UML_PCI which itself is not directly configurable.
>
> Instead of going through CONFIG_UML_PCI_OVER_VIRTIO, introduce a custom
> configuration option which enables CONFIG_UML_PCI without triggering
> warnings or building dead code.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

Thanks for your patch!

> --- a/lib/kunit/Kconfig
> +++ b/lib/kunit/Kconfig
> @@ -106,4 +106,11 @@ config KUNIT_DEFAULT_TIMEOUT
>           If unsure, the default timeout of 300 seconds is suitable for m=
ost
>           cases.
>
> +config KUNIT_UML_PCI

Where is the consumer of this symbol?

> +       bool "KUnit UML PCI Support"
> +       depends on UML
> +       select UML_PCI
> +       help
> +         Enables the PCI subsystem on UML for use by KUnit tests.
> +
>  endif # KUNIT
> diff --git a/tools/testing/kunit/configs/arch_uml.config b/tools/testing/=
kunit/configs/arch_uml.config
> index 54ad8972681a2cc724e6122b19407188910b9025..28edf816aa70e6f408d9486ef=
ff8898df79ee090 100644
> --- a/tools/testing/kunit/configs/arch_uml.config
> +++ b/tools/testing/kunit/configs/arch_uml.config
> @@ -1,8 +1,7 @@
>  # Config options which are added to UML builds by default
>
> -# Enable virtio/pci, as a lot of tests require it.
> -CONFIG_VIRTIO_UML=3Dy
> -CONFIG_UML_PCI_OVER_VIRTIO=3Dy
> +# Enable pci, as a lot of tests require it.
> +CONFIG_KUNIT_UML_PCI=3Dy
>
>  # Enable FORTIFY_SOURCE for wider checking.
>  CONFIG_FORTIFY_SOURCE=3Dy

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

