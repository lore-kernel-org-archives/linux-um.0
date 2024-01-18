Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A9AC47DAF
	for <linux-um@archiver.kernel.org>; Thu, 18 Jan 2024 16:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J1ZHBh2IhHUk6R0mb0HwNUYRqWpgjfOFml5hWvgYMDU=; b=CR06pl8FoY7FIX72kvuabadh2o
	dyI+h16uSE1LU5QIWh3o6ZmX/vsF0y1WWA6QPXr8As1tFqgt4h4gOcShwvFhLHmMMCVmq1GaZJnrI
	0denTXTwrDISMU30cOIznxtp4Itsctmmpl6WmmegDip84dqc7xPLeQvKTvwFx+GZe6TJ6hSv2xbCm
	bVjqeh8av+ZFyjAaV/YdYAWTnZJDdSj9UY3pYCU6vT9ZyEFXa8yE4nTXeT0g+9Z0ykHEfepF0owb+
	QUUB0MlqQyQUIkX0mE1DWRoHa150u9m1l0HGyWL9dRJKoDjZxI9QNsZkfol5SX3gF6XqIdx5/qyVn
	s0f56H0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQV9s-003F08-2J;
	Thu, 18 Jan 2024 16:22:24 +0000
Received: from mail-yw1-f178.google.com ([209.85.128.178])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQV9o-003EyM-37;
	Thu, 18 Jan 2024 16:22:22 +0000
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5ff7a098ab8so13585827b3.3;
        Thu, 18 Jan 2024 08:22:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705594938; x=1706199738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1ZHBh2IhHUk6R0mb0HwNUYRqWpgjfOFml5hWvgYMDU=;
        b=dwQ9gfvdGrOBk2jR4Q7mZKoUQHnByPpI2Cs7sNJmrODgOqkanGVQlcO97SmdrGwmk7
         51KT/u8JGtvO+FqZJQ70jbCdqZKyEpUO8quY7EBOduNXND/otKlrsZLDdtGV+HV+UTYt
         jV3HJY59qgpDEmBXMM61SYl9wm5JENMsnHLPDGp2QD+YXAH6oyPepffUrfqfN8JhDFLY
         7eHT8D/vFsFiomEx2M7IOcU2FTCzgPu06C37n2jxChKFJbRRlOX5WlNlwO9g7sjFY/sx
         O6nBHsPpiQTd0JYyxJVjmgndT0djAC2BwvyK8+JB6KpZSLM8ZE8nxiWMwbOvTEo7yyKl
         +/0A==
X-Gm-Message-State: AOJu0YypKgbQwIrTxqZnVrDXYFbU5azkMdsGuNFrl5ejPc96bO9whShU
	SvPIW3ZZ3Emyf4FJif4A9QTTAKsv3J+ROXWeVETtPQ7TupgrZ0Q9BSXqWF8XvHU=
X-Google-Smtp-Source: AGHT+IHwGQ8sg/ceZVthWijG3+nDKap0xwA/Zr4XawL/ayRDg2ZPmO7wkpx7aRyuDUh+uzVvIC95qA==
X-Received: by 2002:a0d:f484:0:b0:5ff:7f77:8d97 with SMTP id d126-20020a0df484000000b005ff7f778d97mr1076122ywf.96.1705594938511;
        Thu, 18 Jan 2024 08:22:18 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id d77-20020a814f50000000b005ff98665f13sm28759ywb.95.2024.01.18.08.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 08:22:18 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc221f01302so3210884276.2;
        Thu, 18 Jan 2024 08:22:17 -0800 (PST)
X-Received: by 2002:a25:748a:0:b0:da0:3bfc:b915 with SMTP id
 p132-20020a25748a000000b00da03bfcb915mr1030675ybc.11.1705594937194; Thu, 18
 Jan 2024 08:22:17 -0800 (PST)
MIME-Version: 1.0
References: <20240112200750.4062441-1-sboyd@kernel.org> <20240112200750.4062441-2-sboyd@kernel.org>
 <ZaZtbU9hre3YhZam@FVFF77S0Q05N> <CAMuHMdU0qtMeX=7SY+32=30-QGMRniFVCCm217REJ1X+ZNJ=Aw@mail.gmail.com>
 <ZalCcivD0vXpQfr9@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZalCcivD0vXpQfr9@FVFF77S0Q05N.cambridge.arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Jan 2024 17:22:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVW+zBU-7OEpsMZKFfkFbyN98jatG0RsLuzZmXKWavNAA@mail.gmail.com>
Message-ID: <CAMuHMdVW+zBU-7OEpsMZKFfkFbyN98jatG0RsLuzZmXKWavNAA@mail.gmail.com>
Subject: Re: [PATCH 1/6] arm64: Unconditionally call unflatten_device_tree()
To: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, linux-um@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, 
	Frank Rowand <frowand.list@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240118_082220_999595_07AD19D3 
X-CRM114-Status: GOOD (  26.26  )
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

Hi Mark,

On Thu, Jan 18, 2024 at 4:23=E2=80=AFPM Mark Rutland <mark.rutland@arm.com>=
 wrote:
> On Tue, Jan 16, 2024 at 03:13:42PM +0100, Geert Uytterhoeven wrote:
> > On Tue, Jan 16, 2024 at 12:51=E2=80=AFPM Mark Rutland <mark.rutland@arm=
.com> wrote:
> > > On Fri, Jan 12, 2024 at 12:07:44PM -0800, Stephen Boyd wrote:
> > > > Call this function unconditionally so that we can populate an empty=
 DTB
> > > > on platforms that don't boot with a firmware provided or builtin DT=
B.
> > > > There's no harm in calling unflatten_device_tree() unconditionally.
> > >
> > > For better or worse, that's not true: there are systems the provide b=
oth a DTB
> > > *and* ACPI tables, and we must not consume both at the same time as t=
hose can
> > > clash and cause all sorts of problems. In addition, we don't want peo=
ple being
> > > "clever" and describing disparate portions of their system in ACPI an=
d DT.
> >
> > We'd get to the latter anyway, when plugging in a USB device where the
> > circuitry on/behind the USB device is described in DT.
>
> I don't understand what you mean there; where is the DT description of th=
e USB
> device coming from if the DTB hasn't been unflattened?

Either stored in (FLASH) ROM on the USB device, or loaded from
/lib/firmware/.  In both cases that would be handled by the USB driver
for the device.

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

