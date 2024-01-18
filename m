Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2941C47DB3
	for <linux-um@archiver.kernel.org>; Thu, 18 Jan 2024 16:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Si052lwaQIxGIdPAiTDPdKrWDfItm8neDWdgcw4uLug=; b=c3U4n/SIyF2pAACVDSrDmcBmUc
	n8W2Hj2K+u5JvEgulLR1vt16Mr1d7Z+aeqNu3hyzau83KtP+7Xl7Uv2NZ9UDda84bOWaFQ+YJgvRQ
	78th2e7IVGLM1L4iOUEkxkDsIxMT+e+3Gx1l6zqBCrHL5Nu+pvpIcjOMuvSHod41fvAnj/P4037e5
	oI6wCo8VbheooobHvr8Wz3YK2eI0i84O5s64fB9ISk5vI9evS0UTxt3tD/tnGlTFSd7FskW6jz5zF
	M992ldmk76NsXPwF+CpFJ8tHimzrFJyXpU/9uWZV84Rz+KNsLNSuYZOTlFuboJ/9y3/LRbYjBQZBf
	c79JsuHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQVBD-003FKT-2c;
	Thu, 18 Jan 2024 16:23:47 +0000
Received: from mail-yw1-f172.google.com ([209.85.128.172])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQVBA-003FIn-1O;
	Thu, 18 Jan 2024 16:23:45 +0000
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5f2d4aaa2fdso127764527b3.1;
        Thu, 18 Jan 2024 08:23:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705595022; x=1706199822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Si052lwaQIxGIdPAiTDPdKrWDfItm8neDWdgcw4uLug=;
        b=rlwsc2SGilCSq+EssgfG/dLbdBoLC/ZyEgSbV+8wT2EtuLKMEqe52E7NUH9h0OM2Uj
         X0vr+4l9G9s8dDwmcCq3dfx2hOIoYJvZnbiIe52dJBeHTywNYE+j4Ep4aRU4t79ZGpL9
         /yA1/S4B0YLXGDfUkRaoGIWvM87hZUYSBtnxlKximT6DVQBVUsGHmryytm0BCb/z8X+x
         SUsx/JffwZ9D/2yvW3l8BvQz1fBD+sxqYXDtk/VBSWfbsUHlNQEk/0CXXMy5fKpVE6EU
         mPVUb/7EfBTnObi4cXU5cZADeN45oMd3Rh7jhQnc4BjLiW+iRMcLOTVq10+aewWPFPeP
         1F8w==
X-Gm-Message-State: AOJu0Yw3Aufm/rvgjpnONGrcj1ZLM05/W12aYm+/rs/3AP9EtvlI10Xo
	5IA2vFrw3ws9UniB3GCXBdz3zSlZNvuu7k8sSXiPhTmiMoLga8T+Smayb7l7eVY=
X-Google-Smtp-Source: AGHT+IHZmyzhzvGHgbFp0uDsiwU4lw5qyt5kWhqs3n8gVCoiHIO3sVU+yWGb2pN3ZNAjvsX7jA13/w==
X-Received: by 2002:a0d:ff02:0:b0:5ff:6564:77a9 with SMTP id p2-20020a0dff02000000b005ff656477a9mr946824ywf.95.1705595020895;
        Thu, 18 Jan 2024 08:23:40 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id i72-20020a816d4b000000b005ff68b6a096sm1455218ywc.94.2024.01.18.08.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 08:23:40 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5ec7a5a4b34so130969577b3.0;
        Thu, 18 Jan 2024 08:23:40 -0800 (PST)
X-Received: by 2002:a0d:c201:0:b0:5f4:97a:ac87 with SMTP id
 e1-20020a0dc201000000b005f4097aac87mr963234ywd.60.1705595019879; Thu, 18 Jan
 2024 08:23:39 -0800 (PST)
MIME-Version: 1.0
References: <20240112200750.4062441-1-sboyd@kernel.org> <20240112200750.4062441-2-sboyd@kernel.org>
 <ZaZtbU9hre3YhZam@FVFF77S0Q05N> <434b21afe1899b1567f3617261594842.sboyd@kernel.org>
 <ZalDM90KoQ2Il0j7@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZalDM90KoQ2Il0j7@FVFF77S0Q05N.cambridge.arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Jan 2024 17:23:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXkwDA4WAe5qYujeP0sF+h-950GZNkg+6kERr6SSmfz6A@mail.gmail.com>
Message-ID: <CAMuHMdXkwDA4WAe5qYujeP0sF+h-950GZNkg+6kERr6SSmfz6A@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20240118_082344_468551_8F3F81C8 
X-CRM114-Status: GOOD (  28.57  )
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

On Thu, Jan 18, 2024 at 4:27=E2=80=AFPM Mark Rutland <mark.rutland@arm.com>=
 wrote:
> On Tue, Jan 16, 2024 at 05:27:18PM -0800, Stephen Boyd wrote:
> > Quoting Mark Rutland (2024-01-16 03:51:14)
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
> > >
> > > It is a very deliberate choice to not unflatten the DTB when ACPI is =
in use,
> > > and I don't think we want to reopen this can of worms.
> >
> > Hmm ok. I missed this part. Can we knock out the initial_boot_params in
> > this case so that we don't unflatten a DTB when ACPI is in use?
>
> Why is that better than just not calling unflatten_device_tree(), as we d=
o
> today?
>
> The cover letter says this is all so that we can run DT tests for the clk
> framework; why can't that just depend on the system being booted with DT =
rather
> than ACPI? We have other tests which are architecture and/or configuratio=
n
> dependent...

There is definitely a merit in running (platform-independent) DT tests
on any platform, whether the platform actually uses DT to boot or not.

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

