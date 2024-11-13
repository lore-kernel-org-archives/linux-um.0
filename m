Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65763D462A2
	for <linux-um@archiver.kernel.org>; Wed, 13 Nov 2024 13:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DFSXxFcMQ2EECeEkU2Stj5CZ/EJogh6o/NiDrc32KvE=; b=xXI6KgBww5+gg+j9NKp3Q/XCd2
	SOMDSQ+5tc1+tZkldZW3tRZHZHkte3LIYmF6EuyIeno4Zj7CjYjnbg1LglkycqBqt+1v9UddE0xr+
	FFogzhupSlRutgUKb0H7l7bxxw25CxLuMJtPN9u52T4jzBCgbdUzjwZzhWUwoaEo41O0sXu7GO8dp
	5uG6BvSwVeKwGfljHLmZxga8bodR9fR+27PWBS27+o8Sr0d9tuwgDU8Cqm0J2t8OfHzxox/kVnHkB
	5ThxvLlJMVxVkSZfe+kvmxvka+KOkyIxN7TouAChxEPiqU03CA90OrMSfi9Y7ESFqB9s9HKMrPyCB
	gDV05Qwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBDq6-000000070LX-0uiB;
	Wed, 13 Nov 2024 13:55:22 +0000
Received: from mail-yw1-f173.google.com ([209.85.128.173])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBDq4-000000070Kf-1DnF
	for linux-um@lists.infradead.org;
	Wed, 13 Nov 2024 13:55:21 +0000
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6ea5b97e31cso6445417b3.1
        for <linux-um@lists.infradead.org>; Wed, 13 Nov 2024 05:55:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731506117; x=1732110917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFSXxFcMQ2EECeEkU2Stj5CZ/EJogh6o/NiDrc32KvE=;
        b=FPv/bjZRATibtbioeYAnmd4zLM3xMHitEkk7txCpjfpd1H+LYaNkjcBsPw1LFlnMiT
         WTJTu10xpMjUu+Gq+1pFvPIqsB868YKpktKlhsUyc+ZThA+BcO8dXla+mcTr7wX3RjSi
         IUN9FQ7EiEhsyYY5naP4g1+Pci0jgQhcoFJtmHFWOiWBBdafeA0tVl/gAPQgfsEYs+E1
         Vb9rLzSzSElqnrgDwx7s0OURPS2vNgLRp+IcZL7DAkv1a1ALDkvRh/RJQZM0S4OtwLFf
         4sU0Od8j2Nw9U8q99l4xFLtEiwTIO9N7++b9SI0QpCiSwfRagnLHSjlB0UWxs19Nd28x
         rzhw==
X-Forwarded-Encrypted: i=1; AJvYcCXSI20md/K0LXfRhvl7alWN9vl000/2JVosNzew//QNt+aYP5Wzyb99T6z300Pc5jAXj86k5AQ8RQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxV8mJk+ab49rx74VTUz26KSK4cS1wXAv2BqtiXSyhew4Ymp87V
	XB3/CyWlcgZUU1JRpWpQ9iWM4LlQPUKR8Y9HahU9Gbn7IDZrIgBpjxTD8D55
X-Google-Smtp-Source: AGHT+IEpACW7QkktiW6oBnCDzrQw1f3W0fkMwruKFuz81eKsQTlB1IkgpXHU9ZYiZhBd2uw+/2do7A==
X-Received: by 2002:a05:690c:39f:b0:6e3:ceb:9e49 with SMTP id 00721157ae682-6eadc18ed23mr158777907b3.16.1731506117184;
        Wed, 13 Nov 2024 05:55:17 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eace8f1c65sm30758267b3.51.2024.11.13.05.55.15
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 05:55:15 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e29047bec8fso624282276.0
        for <linux-um@lists.infradead.org>; Wed, 13 Nov 2024 05:55:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVN7aDc7KHIRdsNoqmHynvPx79STHApr0HZ8I4gpX9BWL0iD2FHrh97Cf24yqvjGabjjqerbikcEw==@lists.infradead.org
X-Received: by 2002:a05:690c:74ca:b0:6db:da0e:d166 with SMTP id
 00721157ae682-6eade45bda3mr168692847b3.12.1731506114746; Wed, 13 Nov 2024
 05:55:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1731290567.git.thehajime@gmail.com> <ea2a3fb86915664d54ba174e043046f684e7cf8c.1731290567.git.thehajime@gmail.com>
 <CAMuHMdU+Lyj3C-P3kQMd6WfyjBY+YXZSx3Vv6C2y9k__pK45vg@mail.gmail.com>
 <m2pln0f6mm.wl-thehajime@gmail.com> <CAMuHMdXC0BbiOjWsiN1Mg8Jkm03_H6_-fERSnFEB2pkW_VWmaA@mail.gmail.com>
 <8bbfe73f7f1ef9f1a4674d963d1c4e8181f33341.camel@sipsolutions.net>
 <f262fb8364037899322b63906b525b13dc4546c2.camel@sipsolutions.net>
 <CAMuHMdVRB46fyFKjZn3Zw2bb8_mqZasqh-J7vse-GQkA3_OQDg@mail.gmail.com> <m2o72jff2a.wl-thehajime@gmail.com>
In-Reply-To: <m2o72jff2a.wl-thehajime@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 13 Nov 2024 14:55:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXKAz0bxBGrbbHD6haeCbhYh=pCb4stox1fOifCvyCwpw@mail.gmail.com>
Message-ID: <CAMuHMdXKAz0bxBGrbbHD6haeCbhYh=pCb4stox1fOifCvyCwpw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/13] x86/um: nommu: elf loader for fdpic
To: Hajime Tazaki <thehajime@gmail.com>
Cc: johannes@sipsolutions.net, linux-um@lists.infradead.org, 
	ricarkol@google.com, Liam.Howlett@oracle.com, ebiederm@xmission.com, 
	kees@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	Greg Ungerer <gerg@linux-m68k.org>, Rich Felker <dalias@libc.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_055520_352957_3F485AA4 
X-CRM114-Status: GOOD (  32.27  )
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

Hi Tazaki-san,

On Wed, Nov 13, 2024 at 2:17=E2=80=AFPM Hajime Tazaki <thehajime@gmail.com>=
 wrote:
> On Wed, 13 Nov 2024 19:27:08 +0900,
> Geert Uytterhoeven wrote:
> > On Wed, Nov 13, 2024 at 9:37=E2=80=AFAM Johannes Berg <johannes@sipsolu=
tions.net> wrote:
> > > On Wed, 2024-11-13 at 09:36 +0100, Johannes Berg wrote:
> > > > On Wed, 2024-11-13 at 09:19 +0100, Geert Uytterhoeven wrote:
> > > > >
> > > > > > > > -       depends on ARM || ((M68K || RISCV || SUPERH || XTEN=
SA) && !MMU)
> > > > > > > > +       depends on ARM || ((M68K || RISCV || SUPERH || UML =
|| XTENSA) && !MMU)
> > > > > > >
> > > > > > > s/UML/X86/?
> > > > > >
> > > > > > I guess the fdpic loader can be used to X86, but this patchset =
only
> > > > > > adds UML to be able to select it.  I intended to add UML into n=
ommu
> > > > > > family.
> > > > >
> > > > > While currently x86-nommu is supported for UML only, this is real=
ly
> > > > > x86-specific. I still hope UML will get support for other archite=
ctures
> > > > > one day, at which point a dependency on UML here will become wron=
g...
> > > > >
> > > >
> > > > X86 isn't set for UML, X64_32 and X64_64 are though.
> > > >
> > > > Given that the no-MMU UM support even is 64-bit only, that probably
> > > > should then really be (UML && X86_64).
> > > >
> > > > But it already has !MMU, so can't be selected otherwise, and it see=
ms
> > > > that non-X86 UML
> > >
> > > ... would require far more changes in all kinds of places, so not sur=
e
> > > I'd be too concerned about it here.
> >
> > OK, up to you...
>
> Indeed, this particular patch [02/13] intends to support the fdpic
> loader under the condition 1) x86_64 ELF binaries (w/ PIE), 2) on UML,
> 3) and with) !MMU configured.  Given that situation, the strict check
> should be like:
>
>    depends on ARM || ((M68K || RISCV || SUPERH || (UML && X86_64) || XTEN=
SA) && !MMU)
>
> (as Johannes mentioned).
>
> on the other hand, the fdpic loader works (afaik) on MMU environment so,
>
>    depends on ARM || (UML && X86_64) || ((M68K || RISCV || SUPERH || XTEN=
SA) && !MMU)
>
> should also works, but this might be too broad for this patchset (and
> not sure if this makes a new use case).

AFAIK that depends on the architecture's MMU context structure, cfr.
the comment in commit 782f4c5c44e7d99d ("m68knommu: allow elf_fdpic
loader to be selected"), which restricts it to nommu on m68k.  If it
does work on X86_64, you can drop the dependency on UML, and we're
(almost) back to my initial comment ;-)

> anyway, thank you for the comment.
> # I really wanted to have comments from nommu folks.

I've added some in CC...

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

