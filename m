Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A03D41C15
	for <linux-um@archiver.kernel.org>; Wed, 13 Nov 2024 08:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A//o7AUbFlR1hR/WSlBOYJvvqpE2fTFXB/MVLNsxfNA=; b=Hu22WhyFURXeOrGagAko8yIcKA
	JUEdrNKVbUQqeFAIxGqDE1xQUr2SgL1W/u4jitGxNT16l0v6Bn3Bz/wfsHct5fZXnKGtq69Px4jef
	4129E7VhER/FBURJjlllvbP9+NeD/bBEwZDJLLAeQWjOH48Sn++5k9nc5Fn6P5jsseBihk8xNFnYa
	jgGpm9yQPPa/jUYvRBzTfM/hWeXpepjmEFz5fPEBWQNal98HPe9zVxQrs5Jg0jB3sPPL7lRfG07It
	hes2+kA0dk4LNXGJOGqam527NPXrWjmbx7vMAPFBmX3ECxNWqosnsMubfH2SPTC/qczYFRNct+kOs
	xVElnTGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tB8bU-000000065Jb-2Mnr;
	Wed, 13 Nov 2024 08:19:56 +0000
Received: from mail-yw1-f177.google.com ([209.85.128.177])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tB8bR-000000065Iu-28aT
	for linux-um@lists.infradead.org;
	Wed, 13 Nov 2024 08:19:55 +0000
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e5e5c43497so52105047b3.3
        for <linux-um@lists.infradead.org>; Wed, 13 Nov 2024 00:19:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731485992; x=1732090792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A//o7AUbFlR1hR/WSlBOYJvvqpE2fTFXB/MVLNsxfNA=;
        b=qJvenJ/Cn7ZIVQGEnuaOfmUNO0zY79HAo2JPMXIA33hyQVzQmsTa0bN8ATFxD6MleB
         JeY2y+ucLf6O3NUMZmx2Re+FgMTDkOwwV+f5IzOogftaI3ijUZzULs2e7FJMKAMEBrFx
         pYbQ3SPt75sNqjuT2PEnEYTt4WQ4HoFtm20rfEJAWF4AKaG0xkca7pz37/E5Oy0WRTeC
         0TAr0dluQi6/k06H60895jGnVsy5APkeL+RObCzCisOSYMEKRGkBA5gElDVxCzD688jo
         ED9RL8vcl6SljSO+UzX2wLWb2jnhMO30Nr+FmMCgwd0exI5Uq4olC9+lYrEKqkcg7B7Z
         xDYw==
X-Gm-Message-State: AOJu0YwIbnRGVrIB6/I0OjJMv9asoQHGRHwXZLwjO1xJA3vGWyKZXiHK
	9rRhdftZDZiDmEH3iKV6jU42zzuCp6tc1Zn5+ceh+v6MJrEKUBcf263P+ap7
X-Google-Smtp-Source: AGHT+IFwM+k+wLjZCp8FrUJbJBy2apDnO4i+ILQoXrw6g/K7o0BkOKbqBOyQUmQNCl/gXtGP/jDjLQ==
X-Received: by 2002:a05:690c:3582:b0:6e3:116c:ebf3 with SMTP id 00721157ae682-6ecb345f3e4mr26763527b3.28.1731485991789;
        Wed, 13 Nov 2024 00:19:51 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eaceb7b1fcsm30430277b3.118.2024.11.13.00.19.51
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 00:19:51 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e28fe3b02ffso6215027276.3
        for <linux-um@lists.infradead.org>; Wed, 13 Nov 2024 00:19:51 -0800 (PST)
X-Received: by 2002:a05:690c:3582:b0:6e3:116c:ebf3 with SMTP id
 00721157ae682-6ecb345f3e4mr26763207b3.28.1731485991068; Wed, 13 Nov 2024
 00:19:51 -0800 (PST)
MIME-Version: 1.0
References: <cover.1731290567.git.thehajime@gmail.com> <ea2a3fb86915664d54ba174e043046f684e7cf8c.1731290567.git.thehajime@gmail.com>
 <CAMuHMdU+Lyj3C-P3kQMd6WfyjBY+YXZSx3Vv6C2y9k__pK45vg@mail.gmail.com> <m2pln0f6mm.wl-thehajime@gmail.com>
In-Reply-To: <m2pln0f6mm.wl-thehajime@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 13 Nov 2024 09:19:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXC0BbiOjWsiN1Mg8Jkm03_H6_-fERSnFEB2pkW_VWmaA@mail.gmail.com>
Message-ID: <CAMuHMdXC0BbiOjWsiN1Mg8Jkm03_H6_-fERSnFEB2pkW_VWmaA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/13] x86/um: nommu: elf loader for fdpic
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, ricarkol@google.com, Liam.Howlett@oracle.com, 
	ebiederm@xmission.com, kees@kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_001953_570784_9BD5C387 
X-CRM114-Status: GOOD (  24.94  )
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

On Tue, Nov 12, 2024 at 11:07=E2=80=AFPM Hajime Tazaki <thehajime@gmail.com=
> wrote:
> On Tue, 12 Nov 2024 21:48:28 +0900,
> > On Mon, Nov 11, 2024 at 7:28=E2=80=AFAM Hajime Tazaki <thehajime@gmail.=
com> wrote:
> > > As UML supports CONFIG_MMU=3Dn case, it has to use an alternate ELF
> > > loader, FDPIC ELF loader.  In this commit, we added necessary
> > > definitions in the arch, as UML has not been used so far.  It also
> > > updates Kconfig file to use BINFMT_ELF_FDPIC under !MMU environment.
> > >
> > > Cc: Eric Biederman <ebiederm@xmission.com>
> > > Cc: Kees Cook <kees@kernel.org>
> > > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: Jan Kara <jack@suse.cz>
> > > Cc: linux-mm@kvack.org
> > > Cc: linux-fsdevel@vger.kernel.org
> > > Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
> > > Signed-off-by: Ricardo Koller <ricarkol@google.com>
> >
> > Thanks for your patch!
> >
> > > --- a/fs/Kconfig.binfmt
> > > +++ b/fs/Kconfig.binfmt
> > > @@ -58,7 +58,7 @@ config ARCH_USE_GNU_PROPERTY
> > >  config BINFMT_ELF_FDPIC
> > >         bool "Kernel support for FDPIC ELF binaries"
> > >         default y if !BINFMT_ELF
> > > -       depends on ARM || ((M68K || RISCV || SUPERH || XTENSA) && !MM=
U)
> > > +       depends on ARM || ((M68K || RISCV || SUPERH || UML || XTENSA)=
 && !MMU)
> >
> > s/UML/X86/?
>
> I guess the fdpic loader can be used to X86, but this patchset only
> adds UML to be able to select it.  I intended to add UML into nommu
> family.

While currently x86-nommu is supported for UML only, this is really
x86-specific. I still hope UML will get support for other architectures
one day, at which point a dependency on UML here will become wrong...

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

