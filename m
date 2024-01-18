Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E51C4707B
	for <linux-um@archiver.kernel.org>; Thu, 18 Jan 2024 08:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t8e3GAGk3S+G/Tg/kgQzOivmxsVaFHTxxZt1lcCM6Y4=; b=TXmPpM+34k0j9D5Q9YmVamJSWC
	l6K3eLWYAlD/wxLCVqLcNdRP+O7GQuuRucbcRTm16dWChDjk9Ixtn0EESIMh/S6yDeWwNJkELRT9J
	jHp63YYvM6nczYVMbShHpt4QWmZz5FldvxsGXvKqt0GiilmpoK0GTqmoTxFxjClMW+eRmIMTkb6B3
	sfUXfht6k3thwFMTgf+wUs6sXK6NIgLQIB0buSyWOsbqUOimj1OfIiFYZO5gHV89Cac2KBYn550TK
	7OlG2kDiiLoPFfVNWTRxXekOygb4EYKSBWMT/IOXRfLrj+aXbHwRPN/38Y/B0aXD9JEwzN6N2lLyL
	AUK+BFKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQO2L-002Avm-1p;
	Thu, 18 Jan 2024 08:46:09 +0000
Received: from mail-yw1-f180.google.com ([209.85.128.180])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQO2H-002Atm-0g;
	Thu, 18 Jan 2024 08:46:08 +0000
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5f00bef973aso123974197b3.0;
        Thu, 18 Jan 2024 00:46:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705567562; x=1706172362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t8e3GAGk3S+G/Tg/kgQzOivmxsVaFHTxxZt1lcCM6Y4=;
        b=tJE8YII6NxQxBxZkallZVnNMff+bVPQ6//sCMo1Z4bYjgK13wJyLwvfHBUMZXZm7ys
         0OfDtOYd9Wq2zse7n/ur0oiJb+YF5cNUMdw0Fpl1E3WaGSkbk216FtW4inpkL+hFsUtP
         leCvZH4pwPGHTlD9rKMvj5Vlc4YXlqPJBf2jpcO7RUyptXnOMlHzGUdJzsdQ8oPPOdp0
         ulVub/2dHuSb7emzsTOOk6ur5DLCoTRr9qHLQxPbmgpnmAYoLjjixDJyGDLMlxmkE3zW
         w3RBBpPzpdUP35QfT99KN8NHJNJGTmHJ5q/k6oGbyWk4B23RDjN+GUggcemFTyQXRkSi
         86TQ==
X-Gm-Message-State: AOJu0YyNt/IFCh+1BbFeF5z2/GxIVK/LIEHQydSd5vmT7y4LpU8hdySh
	WS2RDsJyuYOqUsDZWfI9eyXwiJNiEwXCl5nTpvR+HcDM+iYHeDPbc0s3+wrSywI=
X-Google-Smtp-Source: AGHT+IE/WW8l26Ped+w3HXWUCeIoLK2ETlBgPBmke3QQdb3hhv5umzv0cybVGNvR76V2adZ9EzivuA==
X-Received: by 2002:a0d:f941:0:b0:5e8:ecff:bd45 with SMTP id j62-20020a0df941000000b005e8ecffbd45mr426619ywf.60.1705567561975;
        Thu, 18 Jan 2024 00:46:01 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id cl27-20020a05690c0c1b00b005f48b0ce126sm6391490ywb.62.2024.01.18.00.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 00:46:01 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc22597dbfeso2880806276.3;
        Thu, 18 Jan 2024 00:46:01 -0800 (PST)
X-Received: by 2002:a5b:949:0:b0:dc2:41de:b744 with SMTP id
 x9-20020a5b0949000000b00dc241deb744mr333386ybq.32.1705567560920; Thu, 18 Jan
 2024 00:46:00 -0800 (PST)
MIME-Version: 1.0
References: <20240112200750.4062441-1-sboyd@kernel.org> <20240112200750.4062441-5-sboyd@kernel.org>
 <20240115203230.GA1439771-robh@kernel.org> <cdaadf62222a705cda198dd96dc7c73d.sboyd@kernel.org>
 <20240117174114.GA2779523-robh@kernel.org>
In-Reply-To: <20240117174114.GA2779523-robh@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Jan 2024 09:45:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXg1Y7mwHKTYi_j7a_XGdMJ7Aa7u5dEv5+xsLe8=BMaRw@mail.gmail.com>
Message-ID: <CAMuHMdXg1Y7mwHKTYi_j7a_XGdMJ7Aa7u5dEv5+xsLe8=BMaRw@mail.gmail.com>
Subject: Re: [PATCH 4/6] of: Create of_root if no dtb provided by firmware
To: Rob Herring <robh@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	devicetree@vger.kernel.org, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240118_004605_266248_F9776913 
X-CRM114-Status: GOOD (  44.74  )
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

Hi Rob,

On Wed, Jan 17, 2024 at 6:41=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
> On Tue, Jan 16, 2024 at 05:18:15PM -0800, Stephen Boyd wrote:
> > Quoting Rob Herring (2024-01-15 12:32:30)
> > > On Fri, Jan 12, 2024 at 12:07:47PM -0800, Stephen Boyd wrote:
> > > > diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> > > > index da9826accb1b..9628e48baa15 100644
> > > > --- a/drivers/of/Kconfig
> > > > +++ b/drivers/of/Kconfig
> > > > @@ -54,9 +54,14 @@ config OF_FLATTREE
> > > >       select CRC32
> > > >
> > > >  config OF_EARLY_FLATTREE
> > > > -     bool
> > > > +     bool "Functions for accessing Flat Devicetree (FDT) early in =
boot"
> > >
> > > I think we could instead just get rid of this kconfig option. Or
> > > always enable with CONFIG_OF (except on Sparc). The only cost of
> > > enabling it is init section functions which get freed anyways.
> >
> > Getting rid of it is a more massive change. It can be the default and
> > kept hidden instead? If it can't be selected on Sparc then it should be
> > hidden there anyway.
>
> The easier option is certainly fine for this series. I just don't want
> it visible.
>
> > > >       select DMA_DECLARE_COHERENT if HAS_DMA && HAS_IOMEM
> > > >       select OF_FLATTREE
> > > > +     help
> > > > +       Normally selected by platforms that process an FDT that has=
 been
> > > > +       passed to the kernel by the bootloader.  If the bootloader =
does not
> > > > +       pass an FDT to the kernel and you need an empty devicetree =
that
> > > > +       contains only a root node to exist, then say Y here.
> > > >
> > > >  config OF_PROMTREE
> > > >       bool
> > [...]
> > > > @@ -195,6 +191,17 @@ static inline int of_node_check_flag(const str=
uct device_node *n, unsigned long
> > > >       return test_bit(flag, &n->_flags);
> > > >  }
> > > >
> > > > +/**
> > > > + * of_have_populated_dt() - Has DT been populated by bootloader
> > > > + *
> > > > + * Return: True if a DTB has been populated by the bootloader and =
it isn't the
> > > > + * empty builtin one. False otherwise.
> > > > + */
> > > > +static inline bool of_have_populated_dt(void)
> > > > +{
> > > > +     return of_root !=3D NULL && !of_node_check_flag(of_root, OF_E=
MPTY_ROOT);
> > >
> > > Just a side comment, but I think many/all callers of this function co=
uld
> > > just be removed.
> > >
> > > I don't love new flags. Another possible way to handle this would be
> > > checking for "compatible" being present in the root node. I guess thi=
s
> > > is fine as-is for now at least.
> >
> > Ok. I can add a check for a compatible property. That's probably better
> > anyway. Should there be a compatible property there to signal that this
> > DT isn't compatible with anything? I worry about DT overlays injecting =
a
> > compatible string into the root node, but maybe that is already
> > prevented.
>
> I worry about DT overlays injecting anything...
>
> I don't think it is explicitly forbidden, but I have asked that any
> general purpose interface to apply overlays be restricted to nodes
> explicitly allowed (e.g. downstream of a connector node). For now, the
> places (i.e. drivers) overlays are applied are limited.
>
> We could probably restrict the root node to new nodes only and no new
> or changed properties.

Changing (<wild dream>or appending to</wild dream>) the root
"compatible" and/or "model" properties is useful in case of large
extension boards, though.  This is also the case for DTBs created from
a base DTB and one or more overlays using fdtoverlay.

For the latter, see also the following threads, where you weren't
(but probably should have been) CCed:

[1] "[PATCH v9 2/2] arm64: boot: Support Flat Image Tree"
     https://lore.kernel.org/all/20231202035511.487946-3-sjg@chromium.org
[2] "Proposal: FIT support for extension boards / overlays"
    https://lore.kernel.org/all/CAPnjgZ06s64C2ux1rABNAnMv3q4W++sjhNGCO_uPMH=
_9sTF7Mw@mail.gmail.com

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

