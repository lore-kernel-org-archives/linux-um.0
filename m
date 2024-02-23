Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F28DC54798
	for <linux-um@archiver.kernel.org>; Fri, 23 Feb 2024 18:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g8ozxIYpNeV++Xsgd+mlsS2xseyNL5RfngVertNGOyg=; b=ViDub9qXke6kFB6MlGnkh3Dlcx
	3GLYJ1m0Z4dYyF6E920KoqzxsVlUrvPVmQWENCCYUlapcIt3uQnPvgUv3PmEs9ZhbizT0tD2J5RM0
	wH2tWiLYV9kg7m3sbND08iflBX3V7cWGSO9wKaC9nORM8WNGGRQMaGvMv7husQJnkBTbTIdIBDWIH
	GHXFbQv7FAaDLYA9HeG7Kw7f/0Nh5+yyXq68QT5QV8/n/lCszmgAb7b6ThoFfF4HbTLCxXXhwV1p/
	7uq0yaY1u/M+ZJlJHPpEiVnwFrQwnyCWpd3e4W31WO7HtB4sCdKOgl472a8X5kW6eiyJuZhNmflE0
	ELMm33ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rda7p-0000000An72-06JU;
	Fri, 23 Feb 2024 18:18:21 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rda6t-0000000Amvv-25qK;
	Fri, 23 Feb 2024 18:17:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id C193FCE2DD6;
	Fri, 23 Feb 2024 18:17:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AEC2C433C7;
	Fri, 23 Feb 2024 18:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708712237;
	bh=1TaQyLnLQWa4xzlGMl4VRuz8CCdT4fApVc8elKczvLU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PzGS5lJZFKajBhQA28OnjPbLn8f0WYXVCF/WAHYDI7cak3vKJOM3LkRQgJvNlRpag
	 YNWeP7IJoNSbj1T8FLbiI5yfAxrT7QFgWAnuLTajbXYtbLL5W4qEA9TmvnjKfuRVKO
	 1WnOX3VDVhBZws5CuuNSHWXxWT8ku+jXPwb8AH/BuhoasuhE793yagK5Jygu3advXS
	 9ytiKylf1R14hBlHBZS8QKNhqg25kmhDtFBY+9zw+NhZj80ckyJLZI7yE39gWPA4RD
	 hzZop//Po7dRpba0uORnQe5MgpNsJujHfDWaqVgp2Aq8eotXRUvS71jdSyhxdpI/sC
	 kAqqjF57jN4rg==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-512e39226efso1652280e87.0;
        Fri, 23 Feb 2024 10:17:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX/xj6DOjDaJ79rKSkUK9py7RtdsuV4kpPiRf2Pfg3/MxXBsc29vTqkRL+xiamOHztjQ+oXQSY15ELUETHapYiE/dCQqeeJ8W3B/pm1BX4tC766jpAuSzxIDXrfG/zUo/LKZ+zYDs7c97RDlED8iIciFAQ=
X-Gm-Message-State: AOJu0YzLdSvqJIPmRidJdTuOy7AdenKe6tm27tGg2vcLq5odcr+m9Pxh
	RoVXE/WZviUMCHuinhoXaQweto2VWYjISH1/zYSNI/4c3g+F3YHLlcz4kF6EYZKMYesiKVxg3vd
	VKyLPhprAL0jnjUjACJwupG5Rmg==
X-Google-Smtp-Source: AGHT+IFnlf/NYg+53odk3xSf/t++OSDfbNnyCI3vytiLL/BpWyZMCTDy8ukEbtAnd0c2SbNSwHy+1Ji8o9g9IN5a9mg=
X-Received: by 2002:a05:6512:3741:b0:512:acc8:7c36 with SMTP id
 a1-20020a056512374100b00512acc87c36mr307071lfs.58.1708712235214; Fri, 23 Feb
 2024 10:17:15 -0800 (PST)
MIME-Version: 1.0
References: <20240217010557.2381548-1-sboyd@kernel.org> <20240217010557.2381548-6-sboyd@kernel.org>
 <20240223000317.GA3835346-robh@kernel.org> <20240223102345.GA10274@willie-the-truck>
In-Reply-To: <20240223102345.GA10274@willie-the-truck>
From: Rob Herring <robh@kernel.org>
Date: Fri, 23 Feb 2024 11:17:02 -0700
X-Gmail-Original-Message-ID: <CAL_JsqJSeSHeWV3YJE9n2NuY+s_iE6f7N5C_oguEJn7jTZ20xA@mail.gmail.com>
Message-ID: <CAL_JsqJSeSHeWV3YJE9n2NuY+s_iE6f7N5C_oguEJn7jTZ20xA@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] arm64: Unconditionally call unflatten_device_tree()
To: Will Deacon <will@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240223_101725_462545_25293FA4 
X-CRM114-Status: GOOD (  21.38  )
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

On Fri, Feb 23, 2024 at 3:23=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Thu, Feb 22, 2024 at 05:03:17PM -0700, Rob Herring wrote:
> > On Fri, Feb 16, 2024 at 05:05:54PM -0800, Stephen Boyd wrote:
> > > Call this function unconditionally so that we can populate an empty D=
TB
> > > on platforms that don't boot with a firmware provided or builtin DTB.
> > > When ACPI is in use, unflatten_device_tree() ignores the
> > > 'initial_boot_params' pointer so the live DT on those systems won't b=
e
> > > whatever that's pointing to. Similarly, when kexec copies the DT data
> > > the previous kernel to the new one on ACPI systems,
> > > of_kexec_alloc_and_setup_fdt() will ignore the live DT (the empty roo=
t
> > > one) and copy the 'initial_boot_params' data.
> > >
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Frank Rowand <frowand.list@gmail.com>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: <linux-arm-kernel@lists.infradead.org>
> > > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > > ---
> > >  arch/arm64/kernel/setup.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > Catalin, Will, Can I get an ack on this so I can take the series via th=
e
> > DT tree.
>
> Mark had strong pretty strong objections to this in version one:

Yes, I had concerns with it as well.

> https://lore.kernel.org/all/ZaZtbU9hre3YhZam@FVFF77S0Q05N/
>
> and this patch looks the same now as it did then. Did something else
> change?

Yes, that version unflattened the bootloader passed DT. Now within
unflatten_devicetree(), the bootloader DT is ignored if ACPI is
enabled and we unflatten an empty tree. That will prevent the kernel
getting 2 h/w descriptions if/when a platform does such a thing. Also,
kexec still uses the bootloader provided DT as before.

Rob

