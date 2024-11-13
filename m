Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25A5D41C30
	for <linux-um@archiver.kernel.org>; Wed, 13 Nov 2024 10:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bSgVRiYR7fQmsN6xkSW2NUSMa3DrW919md6sDkd/rfg=; b=XpNTL+PMXP3/r/rfKVcz7UGSjM
	EXnhZMOp6QlcUiXUV1QIbznK3k9fOIyuDOvn0DfTlnshUuYGVLGkXfdxi0gvsqe4351gV7E4N4Sk3
	z1pjB5GtnGNT/UT8r4sY855FfJxiPebSlucq6iSnXcZ8qGaZ6NEolcaQkP6DV4Nm4MA+Y4JhOYqTg
	LNgcQM11ygM5cdWKDEHqE97+6RXAvKxmh8Z6qOLLvEvnh1e5aL1rZKTcpCse9mUnV/wBYWPYYe+Ee
	quG9561unNxZaxZ7iD4EpPAqHsDXhHktc+9wlQLuQ+Ivw0b+Nsbi18imwkVOGxCyd54fBnT5XeoOT
	btTzZCXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBAka-00000006TJ8-14q8;
	Wed, 13 Nov 2024 10:37:28 +0000
Received: from mail-yb1-f169.google.com ([209.85.219.169])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBAar-00000006ROc-1qaT
	for linux-um@lists.infradead.org;
	Wed, 13 Nov 2024 10:27:26 +0000
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e2915f00c12so6691144276.0
        for <linux-um@lists.infradead.org>; Wed, 13 Nov 2024 02:27:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731493643; x=1732098443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSgVRiYR7fQmsN6xkSW2NUSMa3DrW919md6sDkd/rfg=;
        b=TzO9VIVXnSTc2PeyrOfOaJKoh5z4Kgj/GAcSRou5hXwvAqP+7wOd90QdPSh1caQbRl
         cFx8Mx3dJWkwn1hJc750t3fWTkSRM9cP1pvVZXkNtLK5WXLAHrDop6nK/EOEA20XKXEH
         rlwiM9cKaHU7rVoLtGUFgNMwuMlBIHGgZnuGm1ieGHCl5xPrTJcMtx7lvEdx0rUkK1kK
         oZfgmlkOxf/qEVV080Yrn4lj6DcB3Rn+4lHnBK00mH8NJMwNm7S+MzY+vVgUEu9FsqVd
         Qjl5q7IskFA50yXKxOQ0F1OfEJzlL79L1ZMShdN868eRgJGlmYd7VCK/IdRMDa2C76B4
         V7Lw==
X-Forwarded-Encrypted: i=1; AJvYcCW1TWIM7F2j/Pkpssw8cIURPy9PyFk9uAQL+aS8zwLgJklmcdAfdapAetpCDP9XbfkqEtzAfol+mw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwzUY37/WdyDU4DlvfQiav7WTF4zZa/Ahi150EoE9/6afv+l3yd
	EpojXW0xpE7GyGomGQIrcHjLv7B8u2xsS1t4aznUH3hQGVnP06Tc+QB4eAeA
X-Google-Smtp-Source: AGHT+IEuPas0WvpzWluEjx2FG+JYigLZelT9ltI8pT4Ta6HJ+RyLACKOHM5jfyNOPfumXIOC5JxLaQ==
X-Received: by 2002:a05:6902:e05:b0:e28:f31f:5f72 with SMTP id 3f1490d57ef6-e337f859d2amr17141431276.19.1731493643412;
        Wed, 13 Nov 2024 02:27:23 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e336ef20671sm3227090276.20.2024.11.13.02.27.22
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 02:27:22 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6ea8419a57eso71579797b3.1
        for <linux-um@lists.infradead.org>; Wed, 13 Nov 2024 02:27:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVhIHyRIkiLS6MdcWvqL/wqO0AFsl4yjxJKJF3a2M6N31Ek2XH8osMqa/vpBpVYw2iB3DeBZmIWLA==@lists.infradead.org
X-Received: by 2002:a05:690c:3681:b0:6e3:da91:3e16 with SMTP id
 00721157ae682-6eadddb0e10mr208300817b3.22.1731493641988; Wed, 13 Nov 2024
 02:27:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1731290567.git.thehajime@gmail.com> <ea2a3fb86915664d54ba174e043046f684e7cf8c.1731290567.git.thehajime@gmail.com>
 <CAMuHMdU+Lyj3C-P3kQMd6WfyjBY+YXZSx3Vv6C2y9k__pK45vg@mail.gmail.com>
 <m2pln0f6mm.wl-thehajime@gmail.com> <CAMuHMdXC0BbiOjWsiN1Mg8Jkm03_H6_-fERSnFEB2pkW_VWmaA@mail.gmail.com>
 <8bbfe73f7f1ef9f1a4674d963d1c4e8181f33341.camel@sipsolutions.net> <f262fb8364037899322b63906b525b13dc4546c2.camel@sipsolutions.net>
In-Reply-To: <f262fb8364037899322b63906b525b13dc4546c2.camel@sipsolutions.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 13 Nov 2024 11:27:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVRB46fyFKjZn3Zw2bb8_mqZasqh-J7vse-GQkA3_OQDg@mail.gmail.com>
Message-ID: <CAMuHMdVRB46fyFKjZn3Zw2bb8_mqZasqh-J7vse-GQkA3_OQDg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/13] x86/um: nommu: elf loader for fdpic
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org, ricarkol@google.com, 
	Liam.Howlett@oracle.com, ebiederm@xmission.com, kees@kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_022725_501030_565DF8DE 
X-CRM114-Status: GOOD (  25.02  )
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

Hi Johannes,

On Wed, Nov 13, 2024 at 9:37=E2=80=AFAM Johannes Berg <johannes@sipsolution=
s.net> wrote:
> On Wed, 2024-11-13 at 09:36 +0100, Johannes Berg wrote:
> > On Wed, 2024-11-13 at 09:19 +0100, Geert Uytterhoeven wrote:
> > >
> > > > > > -       depends on ARM || ((M68K || RISCV || SUPERH || XTENSA) =
&& !MMU)
> > > > > > +       depends on ARM || ((M68K || RISCV || SUPERH || UML || X=
TENSA) && !MMU)
> > > > >
> > > > > s/UML/X86/?
> > > >
> > > > I guess the fdpic loader can be used to X86, but this patchset only
> > > > adds UML to be able to select it.  I intended to add UML into nommu
> > > > family.
> > >
> > > While currently x86-nommu is supported for UML only, this is really
> > > x86-specific. I still hope UML will get support for other architectur=
es
> > > one day, at which point a dependency on UML here will become wrong...
> > >
> >
> > X86 isn't set for UML, X64_32 and X64_64 are though.
> >
> > Given that the no-MMU UM support even is 64-bit only, that probably
> > should then really be (UML && X86_64).
> >
> > But it already has !MMU, so can't be selected otherwise, and it seems
> > that non-X86 UML
>
> ... would require far more changes in all kinds of places, so not sure
> I'd be too concerned about it here.

OK, up to you...

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

