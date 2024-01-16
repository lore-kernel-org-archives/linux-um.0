Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB7CC47077
	for <linux-um@archiver.kernel.org>; Tue, 16 Jan 2024 14:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0sqbUk2C6b7oHNAWGCQckjFoAuDgEH4C3P1gTqqawwA=; b=fWrIUnzod03YIRrQiLzoFf7uVZ
	WnPIqrilBSVMWu7eyEdvUCNBCVuGcDDxMFWNd/1tbhWDiG+7WzR/gtKUMYcbCZGJaXO96n4kTMsmd
	vLBDrwbEQ+OIthogos0kkhu61m1mPqJFfTlMr/eWCwINxDxWNeTQ4GOapFcFWTOCmDV8QMoOJHL4t
	pG1USP/UJs6DymAVBWV4ciWxzEfdnHpjlcIOoq4cEk0vuf1m8vHB/hM6OiXjS6uY0IaX3zg2wJfUp
	7FiUe8CA8OiX5GfvOR16Fbm5r4w8rmRj7juNAxh5GxwHb6ORrrIPj/tw9mHg52vzkRQ9WLpyj9WqF
	Ibw96e5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPkCW-00CGlw-1x;
	Tue, 16 Jan 2024 14:14:00 +0000
Received: from mail-yb1-f179.google.com ([209.85.219.179])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPkCT-00CGl5-2X;
	Tue, 16 Jan 2024 14:13:59 +0000
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc221f01302so741580276.2;
        Tue, 16 Jan 2024 06:13:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705414435; x=1706019235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sqbUk2C6b7oHNAWGCQckjFoAuDgEH4C3P1gTqqawwA=;
        b=AS9sTSPKaxViYtu/k3LFGDZW4FsTW9N+e0fWQlhvSlpv7wavIQIn25b5iIp/8yYnAa
         Op5TSKFu6vXFZ0Vn8kYrP/sBVKOFO9oZV4GwQxiD4d/4y25D0XYGzmwOe8KeMFsIuYL2
         sePDOfBJNzE20ql/z2Dnm4aqEqW1Rw6MlJLcjXJJYA2Tx1S+ULZgKAOr5PEg1OfjzIY4
         2y8/nxGeYWH3Ql2TA5bjYCKzomp4BQkOuUfGU7F8IXNf8XUFHfWEHTR+3QbGfuz4yWZW
         O8ejVuspm+f/yrtSd2F/XZCMUoValVcCba5pZMAawECwI2lj2aXmWSHQP5XY5xuHpxM6
         oUhA==
X-Gm-Message-State: AOJu0YxkS6mDL2WX7riQc/eVTzjrJRNIfFS4Md9PqiuQbfUugtlBtNyX
	BQpuy8coS/m95rURqM6GxF89+ElmqlTE2A==
X-Google-Smtp-Source: AGHT+IGLf1iHSyAvHvzp/PD8JN1fyjWB1EEuD2eSJlu6IfFdLxf/bFgmlAl4ImgJAYx6GZdxA1BQbw==
X-Received: by 2002:a5b:b89:0:b0:dc2:303b:db26 with SMTP id l9-20020a5b0b89000000b00dc2303bdb26mr252667ybq.80.1705414434990;
        Tue, 16 Jan 2024 06:13:54 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id c18-20020a5b0152000000b00dc220621c06sm641276ybp.43.2024.01.16.06.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 06:13:54 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5f8cf76ef5bso87108487b3.0;
        Tue, 16 Jan 2024 06:13:54 -0800 (PST)
X-Received: by 2002:a05:690c:1d:b0:5f6:e8c8:9b6c with SMTP id
 bc29-20020a05690c001d00b005f6e8c89b6cmr6746864ywb.46.1705414434365; Tue, 16
 Jan 2024 06:13:54 -0800 (PST)
MIME-Version: 1.0
References: <20240112200750.4062441-1-sboyd@kernel.org> <20240112200750.4062441-2-sboyd@kernel.org>
 <ZaZtbU9hre3YhZam@FVFF77S0Q05N>
In-Reply-To: <ZaZtbU9hre3YhZam@FVFF77S0Q05N>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 16 Jan 2024 15:13:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU0qtMeX=7SY+32=30-QGMRniFVCCm217REJ1X+ZNJ=Aw@mail.gmail.com>
Message-ID: <CAMuHMdU0qtMeX=7SY+32=30-QGMRniFVCCm217REJ1X+ZNJ=Aw@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20240116_061357_825395_6C8CA41D 
X-CRM114-Status: GOOD (  19.74  )
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

On Tue, Jan 16, 2024 at 12:51=E2=80=AFPM Mark Rutland <mark.rutland@arm.com=
> wrote:
> On Fri, Jan 12, 2024 at 12:07:44PM -0800, Stephen Boyd wrote:
> > Call this function unconditionally so that we can populate an empty DTB
> > on platforms that don't boot with a firmware provided or builtin DTB.
> > There's no harm in calling unflatten_device_tree() unconditionally.
>
> For better or worse, that's not true: there are systems the provide both =
a DTB
> *and* ACPI tables, and we must not consume both at the same time as those=
 can
> clash and cause all sorts of problems. In addition, we don't want people =
being
> "clever" and describing disparate portions of their system in ACPI and DT=
.

We'd get to the latter anyway, when plugging in a USB device where the
circuitry on/behind the USB device is described in DT.

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

