Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F6C2CAC58E
	for <linux-um@archiver.kernel.org>; Sat, 13 Sep 2025 06:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XCvwV5WoqoYVySUmFtMHQmX2ZgogkxDxtUeViriH4AA=; b=oLa9o73RCtiW/IbrZznCpob7G3
	aoLBiu7negerluDsnSVQEFi4nx5djo9xFprCdTkUCeRzzbxKB4qoXhs/9y7/e0nUbWEDMGMrivbxW
	yWw7IvgEzA06GDVUTBrIQTnuHckX89NsCeio4nwCiXzrfkyIyGOykZr7lboz13nyUQ+djXFXTKdgH
	FgEBpUaDkkIt6wZZYtIe3BaByvgoWlL0XfVEev55OlVWq+sHZxygBQK7puPNilcFipLKR59Enpp1K
	LlxKgMSYdDXt/9zc0aZsmPls92i7i1gyjnniVNHTWQHUN/zOQRhaH9BKRbVoQba/xaQMCV+N/w2pp
	LhTlqddQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxJWs-0000000DUNW-2unf;
	Sat, 13 Sep 2025 06:14:34 +0000
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxJWq-0000000DUMT-2sO0
	for linux-um@lists.infradead.org;
	Sat, 13 Sep 2025 06:14:34 +0000
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-722d5d8fa11so21929616d6.3
        for <linux-um@lists.infradead.org>; Fri, 12 Sep 2025 23:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757744070; x=1758348870; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCvwV5WoqoYVySUmFtMHQmX2ZgogkxDxtUeViriH4AA=;
        b=SBtkSNAcZL+fReyUaHoHeCvqKtFGDwdEUN55erdwik5relkKpVF9v9cGTpcN3j45SZ
         UvihoJj4e9yT57uCC289wAsfj0nfIPC5VWvfEYZTvz8h85CyEqKoKsukZyyteti26Y7t
         AQTvI32HOVNN9/nR8Rj7mmXSxFUtyYNzmUwtrmSTIx9KYB7TfuHiMyFmo1W+8akkTh7h
         HfM6QofrvKcmQ6b0tX7RvNoqcoMF40276Vi7dWbqaU+7KkBpRv1/PtBsiSsu5eEEwt7u
         UkpUGH+cbomP5czwoVCsOFV44bTFErY+ywAlGzwCuLASe5ZhoTpcD6209reb823kS/ao
         k5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757744070; x=1758348870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XCvwV5WoqoYVySUmFtMHQmX2ZgogkxDxtUeViriH4AA=;
        b=t2RUOB460EulAZ4reooygpEVelhbc6U+ECLK81ncHJEdSyTVpFAHlI56FPTd1HUEyd
         /2q2au7tYWUBBKWBfcTcelG/urcXRyFwK4G+qM/8I5DBoll+pynNSWkZyP6xMkQD06hc
         gRP8t88dtVdTlf69c87futSha/jTTTXSJ5TuLBz9Wi5a371gHuKqfE7IiwlmALpjrtfu
         XNtFs27jtc9IDKpSTkTjU18s2b0xKIjvJNSZAMyJZYr93mmrUhPw3QAi4ogb1Ib2w1gy
         I6bDfTk+BOA1X5DwTQODAtDIhUZI39BSMwgErFr3Ud4EnGTXCZeHJMIOzq3aOy6E8fyD
         F/gg==
X-Forwarded-Encrypted: i=1; AJvYcCWCAeeyhpfZAn7QEtmD5ch5WwjexcnSjlRxENlsm56FDVTSMylmyEfpfIpo/J1oIq/IJwu4HIhp7w==@lists.infradead.org
X-Gm-Message-State: AOJu0YzFWLJwC4o8xri3eV6eJuS74H4NqCBMPQBBCnKNO7S7ZEAOJJJU
	HYElvkJpIPHZXbNnVYkweb3lsGWhuQHo+GTarBDm0wiQ4tHLlFmLfww1eNPmB/PFrcUtz89NfNN
	cwXl//LmXiocg7las5rpf98oa4Ux/cRouAs/ohOgy
X-Gm-Gg: ASbGncubXWDHzy/wA4h5fkHF3g1AnyFpHE9gywXPzyQM7iGcI/37lJy+0vs3Ps54NJr
	TMYUizi+LBose2v+YuWKHppC9ungDNCL/+Hsqc2lZjZTaznZDYx3/U1LbB7ZnkhkY2p/o4vJf8Z
	Jv6dx8UbbPH6ew/xouEUBljW3HK8ZO74liUJEYVpACbxTVSB3JX5QsgZFXKeqlUWq2PqPnA8ekH
	4K8ghefy4CfTMx3nwUZM7x7tsXsChirFw==
X-Google-Smtp-Source: AGHT+IHJrx6ozvbMDWYDP71LNjU3nqhgVJjdnL9fmTR9g9kuYNj5UraKu8PJNDMK54JfJxbFZNaR1S+PCFRCKfHmv5I=
X-Received: by 2002:ad4:5cea:0:b0:766:ab7c:3e89 with SMTP id
 6a1803df08f44-767c5621b4bmr71883766d6.64.1757744070327; Fri, 12 Sep 2025
 23:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250908-kunit-uml-pci-v2-1-d8eba5f73c9d@linutronix.de>
In-Reply-To: <20250908-kunit-uml-pci-v2-1-d8eba5f73c9d@linutronix.de>
From: David Gow <davidgow@google.com>
Date: Sat, 13 Sep 2025 14:14:18 +0800
X-Gm-Features: AS18NWAwSSI4FfaR6_Z8Utcpxcsk0azDBC1iBVWsOW6hluo678X_JayUhmQMwFs
Message-ID: <CABVgOSmCNs2DQbyj=MAm-LHBRbEiCO1Adb-mSt+fbgOa8v4iYA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2] kunit: Enable PCI on UML without triggering WARN()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250912_231432_753968_AF7F410D 
X-CRM114-Status: GOOD (  24.55  )
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

On Mon, 8 Sept 2025 at 15:03, Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
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
> ---

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

> Changes in v2:
> - Rebase onto v6.17-rc1
> - Pick up review from Johannes
> - Link to v1: https://lore.kernel.org/r/20250627-kunit-uml-pci-v1-1-a622f=
a445e58@linutronix.de
> ---
>  lib/kunit/Kconfig                           | 7 +++++++
>  tools/testing/kunit/configs/arch_uml.config | 5 ++---
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> index c10ede4b1d2201d5f8cddeb71cc5096e21be9b6a..1823539e96da30e165fa8d395=
ccbd3f6754c836e 100644
> --- a/lib/kunit/Kconfig
> +++ b/lib/kunit/Kconfig
> @@ -106,4 +106,11 @@ config KUNIT_DEFAULT_TIMEOUT
>           If unsure, the default timeout of 300 seconds is suitable for m=
ost
>           cases.
>
> +config KUNIT_UML_PCI
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
>
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250626-kunit-uml-pci-a2b687553746
>
> Best regards,
> --
> Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
>

