Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DCEC3ABBE
	for <linux-um@archiver.kernel.org>; Thu,  8 May 2025 23:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0qizmcVgeWhq7Q3Ee4oIEwFn2+ipGsqmBbwSEApIvT0=; b=4roiY4Pzw5MIDmvAM9cRWDHZyL
	99e7fdbi7mMXzhzrDy2RFdAIt5y/iXTJNCM2hMGgHoHKts26plGcuXI4Xv9Y+ijc5mRTI5nyLvx34
	1RCsw9mr3dACbrgVdfNP+LwnzTuL+/KPTqOMsCYRdidumrUuRzo3wN5Z7G6b9qrh8ve00ruTgxUdi
	wKzOMhdSjJypOxzmosstGpmOBN69SOKeal9VIGDPUshj53ioNZBsZt6Vncv9j+l+ZLYQG1b9fTRzR
	TP15GZylRr9OgjP8MzaMsp2b4zwZ3fxUf4X3OeHhCOg/t6Xlt6LLkeOVeb+t7sH9sUszraNMmgKx5
	xLCkhBmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDAT1-00000001xzL-3AHS;
	Thu, 08 May 2025 23:15:51 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDARC-00000001xl0-0vqp
	for linux-um@lists.infradead.org;
	Thu, 08 May 2025 23:13:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D28B14AE33
	for <linux-um@lists.infradead.org>; Thu,  8 May 2025 23:13:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92749C4CEF1
	for <linux-um@lists.infradead.org>; Thu,  8 May 2025 23:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746746037;
	bh=hjPlZNVH1QsTW+M1ibi+er/DnxeysWRGy0qKT0ckYOM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cxyT0rr9MzRsBjXfiR3d9/RD/v6CwvFNI4+FIvHDOSYVn07m2rsABHxIo2RfWF+EO
	 nfUISpFUR5RMo/mCkpQgjmSxwICfszeTibf1HUXGJTOfAKL1WPeDMMMQBmQg5gaVPG
	 EvvbLJ2R94TX4pYp8XmBmFx7UnP+aRi/ifTgu2PcRKmxmE5ET6yXIIHSfunAE2ArtC
	 xhh3ZsbexARUbPLSsQ+ZZlVYEbphGDtpY4uc9MWnbN8JuZNItRuYr4i9DuV9fcQbKy
	 SpeTiVVP8PPHEHqJLtqr7/7uRqum7TxYO22PSTchi01xUlOXtm10AEEdR5k9mzqUsV
	 WoQ/JMMKukbJg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54e816aeca6so2105858e87.2
        for <linux-um@lists.infradead.org>; Thu, 08 May 2025 16:13:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVq8x9EsSvNBelICr+TWnuOV6e597AcORkhEIIcGcHgCNfD40wbmquCX4coAkDUQ3+imYPEBXN+yA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx6RVO1pzi0F+4L0M/SlCtXIYnu25hpvD6UzEIPTXey0ByL7GZi
	3i33NFxtPKKzfpa0YnsBa8hh3BIZzSZe9X1g9MR96yn/Or/7EYQ4N2R/gVv+zQqhXzqdsVVsIdq
	Ohl8e4pkioP3CoQC9FHRigwKkQ3g=
X-Google-Smtp-Source: AGHT+IEu52aNEDzMGo5FyZKwbvtEiRvPDMJolT/k9kW20bfY6GvKL48TekDncNdE3idOerShQ5l7uSs7KgVNI0hwK08=
X-Received: by 2002:a05:6512:4201:b0:54e:81ec:2c83 with SMTP id
 2adb3069b0e04-54fc67c2180mr349351e87.18.1746746035073; Thu, 08 May 2025
 16:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250502224512.it.706-kees@kernel.org> <CAK7LNAQCZMmAGfPTr1kgp5cNSdnLWMU5kC_duU0WzWnwZrqt2A@mail.gmail.com>
 <202505031028.7022F10061@keescook> <CAK7LNAQehmFgB3kJtrkVhUKM1NEXGQrfJ3v3piToh7YV7-3ccw@mail.gmail.com>
 <202505080953.789B3381@keescook>
In-Reply-To: <202505080953.789B3381@keescook>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 9 May 2025 08:13:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQpGXmWNhoE9wLoP01dn2o7KjhedoqHXm474CoCgwHp2Q@mail.gmail.com>
X-Gm-Features: ATxdqUFSFahQS2gL_GajBAPbhaxcYoPZIWvSTLFfjfLaxGsmrigaOf0HpL69dgs
Message-ID: <CAK7LNAQpGXmWNhoE9wLoP01dn2o7KjhedoqHXm474CoCgwHp2Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Detect changed compiler dependencies for full rebuild
To: Kees Cook <kees@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Justin Stitt <justinstitt@google.com>, Marco Elver <elver@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_161358_298859_2335B6A2 
X-CRM114-Status: GOOD (  41.99  )
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

On Fri, May 9, 2025 at 1:56=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Fri, May 09, 2025 at 01:44:09AM +0900, Masahiro Yamada wrote:
> > On Sun, May 4, 2025 at 2:37=E2=80=AFAM Kees Cook <kees@kernel.org> wrot=
e:
> > >
> > > On Sat, May 03, 2025 at 06:39:28PM +0900, Masahiro Yamada wrote:
> > > > On Sat, May 3, 2025 at 7:54=E2=80=AFAM Kees Cook <kees@kernel.org> =
wrote:
> > > > >
> > > > >  v2:
> > > > >   - switch from -include to -I with a -D gated include compiler-v=
ersion.h
> > > > >  v1: https://lore.kernel.org/lkml/20250501193839.work.525-kees@ke=
rnel.org/
> > > >
> > > >
> > > > What do you think of my patch as a prerequisite?
> > > > https://lore.kernel.org/linux-kbuild/20250503084145.1994176-1-masah=
iroy@kernel.org/T/#u
> > > > Perhaps, can you implement this series more simply?
> > > >
> > > > My idea is to touch a single include/generated/global-rebuild.h
> > > > rather than multiple files such as gcc-plugins-deps.h, integer-wrap=
.h, etc.
> > > >
> > > > When the file is touched, the entire kernel source tree will be reb=
uilt.
> > > > This may rebuild more than needed (e.g. vdso) but I do not think
> > > > it is a big deal.
> > >
> > > This is roughly where I started when trying to implement this, but I
> > > didn't like the ergonomics of needing to scatter "touch" calls all ov=
er,
> > > which was especially difficult for targets that shared a build rule b=
ut
> > > may not all need to trigger a global rebuild. But what ultimately pus=
hed
> > > me away from it was when I needed to notice if a non-built source fil=
e
> > > changed (the Clang .scl file), and I saw that I need to be dependency
> > > driven rather than target driven. (Though perhaps there is a way to
> > > address this with your global-rebuild.h?)
> > >
> > > As far as doing a full rebuild, if it had been available last week, I
> > > probably would have used it, but now given the work that Nicolas, you=
,
> > > and I have put into this, we have a viable way (I think) to make this
> > > more specific. It does end up being a waste of time/resources to rebu=
ild
> > > stuff that doesn't need to be (efi-stub, vdso, boot code, etc), and t=
hat
> > > does add up when I'm iterating on something that keeps triggering a f=
ull
> > > rebuild. We already have to do the argument filtering for targets tha=
t
> > > don't want randstruct, etc, so why not capitalize on that and make th=
e
> > > rebuild avoid those files too?
> >
> >
> > efi-stub, vdso are very small.
> >
> > Unless this turns out to be painful, I prefer
> > a simpler implementation.
> >
> > You will see how .scl file is handled.
> >
> > See the below code:
> >
> >
> > diff --git a/Kbuild b/Kbuild
> > index f327ca86990c..85747239314c 100644
> > --- a/Kbuild
> > +++ b/Kbuild
> > @@ -67,10 +67,20 @@ targets +=3D $(atomic-checks)
> >  $(atomic-checks): $(obj)/.checked-%: include/linux/atomic/%  FORCE
> >         $(call if_changed,check_sha1)
> >
> > +rebuild-$(CONFIG_GCC_PLUGINS)          +=3D $(addprefix
> > scripts/gcc-plugins/, $(GCC_PLUGIN))
> > +rebuild-$(CONFIG_RANDSTRUCT)           +=3D include/generated/randstru=
ct_hash.h
>
> These are in $(objtree)

Yes.

> > +rebuild-$(CONFIG_UBSAN_INTEGER_WRAP)   +=3D scripts/integer-wrap-ignor=
e.scl
>
> This is in $(srctree)

Yes.

> > +
> > +quiet_cmd_touch =3D TOUCH   $@
> > +      cmd_touch =3D touch $@
> > +
> > +include/generated/global-rebuild.h: $(rebuild-y)
> > +       $(call cmd,touch)
>
> Is this rule going to find the right versions of the dependencies?

I think so, but please test it.


> > --- a/Makefile
> > +++ b/Makefile
> > @@ -558,7 +558,8 @@ USERINCLUDE    :=3D \
> >                 -I$(srctree)/include/uapi \
> >                 -I$(objtree)/include/generated/uapi \
> >                  -include $(srctree)/include/linux/compiler-version.h \
> > -                -include $(srctree)/include/linux/kconfig.h
> > +                -include $(srctree)/include/linux/kconfig.h \
> > +                -include $(objtree)/include/generated/global-rebuild.h
>
> Instead of adding a new file, why not just touch compiler-version.h?

Because the compiler-version.h is in $(srctree), which might be
in the read-only file system.


> But whatever the case, sure, I can live with this. :)
>
> -Kees
>
> --
> Kees Cook



--=20
Best Regards
Masahiro Yamada

