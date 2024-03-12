Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA5DC54E68
	for <linux-um@archiver.kernel.org>; Tue, 12 Mar 2024 14:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FXmOsnx/ac8DtMDdTaI7xWpzg70Sr5+vs/F3ep2Teoo=; b=m6WI0WVhnI5sXGnrrka2ThbZQj
	cN5Cb/lT86yMiKFT/LhHMkUCvTVaRyYCtvEMkCUAOyv1Y+gKYn2R0qYvXEre21g+73p4zn9VWTxaS
	LYU4XE12CFv0ztgl2af6J9uoNuKlVLHbfaihFkI6wTka13DchoxyhWp14mx62dYbJOdoenilQP71D
	achlZmacCUFTf4IZHjmGYghVdTylDsrxEr6Ex6EFui2I2A53VKhgC3zLNCB9q04lSsV617GZ/6yEF
	SJn28LttC1oFzvwCcL9qBdlvrQ+dpaY+2GR594QetzenOUerHYOGPeMH4Mj3MHjdKOzwj0M4ZI6yG
	msHuG5tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk3K9-00000006Aut-0JG6;
	Tue, 12 Mar 2024 14:41:49 +0000
Received: from mail-yb1-f176.google.com ([209.85.219.176])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk3K6-00000006Att-45IH;
	Tue, 12 Mar 2024 14:41:48 +0000
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-db3a09e96daso4788468276.3;
        Tue, 12 Mar 2024 07:41:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710254505; x=1710859305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXmOsnx/ac8DtMDdTaI7xWpzg70Sr5+vs/F3ep2Teoo=;
        b=UgS5OjJmh3cPBEkaa2V7bvGRGx5dfPHJMUq2YLT8eu3Kws8flelsv0lLJ5M3leaPpw
         nHuSFJ6tZJ8y9s8wqajwaQLv+IQMC5wtXjBm1R03GJuUq6+U7RoPkejO1m2EBYnWVtEK
         nLQpqfQ6cox8iQOINyQj5rRr9jibaxH5VMVlJbe2TOxDqhD0ICE5XiwXL5L5P4rd7g3U
         0s5NbEwi5D4RNV+7sSAFkwhi6C+YTkUaVIl9OPh9aEkX5rav/uNxmwjsAQT5+GoAaEtr
         Kp8kRKxbcfVZVoBAnxyz7CvKwWmLJDIWk/MY8BYDfaNxXCpMuDq4UHXilzJG+g5SY9RT
         au3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8NKvo9k1hmdsrkhwTQpG52i970R7Vp74BKepHoMzyh8Bkn89zuVkoMx3eM+1l74xuGK6fMXajCa9gR2oaL9NuR+NQJyS0dpdQeAVQw8e5jBEF/5buXLGFk7Og9mk1pcKAACHtEJMlnuj+pFtWRqog9xU=
X-Gm-Message-State: AOJu0YyTAGMt8/FC5yWf/D3lI55kEfNs80M+sjjWqmy/whL0vNlKITR+
	nrzYoLZ0uGerH/NmXUv27vYNYzcnKW1bMRWddtWYnYkq2smKNmpCBLvmYxJgt/Q=
X-Google-Smtp-Source: AGHT+IHIbphOsJ36vh9zUPAA2qCaYOXNCztCpfyhkg+RfK/aGxJdFmaJX+bUSCOSGgKTXT5Xu+/seg==
X-Received: by 2002:a5b:a83:0:b0:dcc:3a3:9150 with SMTP id h3-20020a5b0a83000000b00dcc03a39150mr6452317ybq.22.1710254504988;
        Tue, 12 Mar 2024 07:41:44 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id a15-20020a25938f000000b00dcd25ce965esm1671802ybm.41.2024.03.12.07.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 07:41:44 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso5092407276.0;
        Tue, 12 Mar 2024 07:41:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUMHtlBy4iKf9mgwvpFDSwfGguXDoMIUbzFb6ZVdJ0UtWDYQyDmiGWFZibKstWUaALK6qOG+nx/mDY9QZsPcGWmv8kufWJJve/mNLAvwI2p94aDlBhNXslOgU4PLt0lfaNDq15bmqQ3c6JmSgfUspHQP5s=
X-Received: by 2002:a25:4886:0:b0:dbe:9509:141c with SMTP id
 v128-20020a254886000000b00dbe9509141cmr6367424yba.30.1710254504263; Tue, 12
 Mar 2024 07:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240217060843.GA16460@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <CAL_Jsq+Feu9NnzTNx=XU5vgHhibGAQXvkuTeWbpu8gJ3rVrzcw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+Feu9NnzTNx=XU5vgHhibGAQXvkuTeWbpu8gJ3rVrzcw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 12 Mar 2024 15:41:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUKa-KdWfYswEpFvj3RjQPM+ThhU85myfBGVkXxZqbHWw@mail.gmail.com>
Message-ID: <CAMuHMdUKa-KdWfYswEpFvj3RjQPM+ThhU85myfBGVkXxZqbHWw@mail.gmail.com>
Subject: Re: [PATCH 2/7] of: Create of_root if no dtb provided by firmware
To: Rob Herring <robh+dt@kernel.org>
Cc: Saurabh Singh Sengar <ssengar@linux.microsoft.com>, Frank Rowand <frowand.list@gmail.com>, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	"Gabriel L. Somlo" <gsomlo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240312_074147_037932_BE17B1B7 
X-CRM114-Status: GOOD (  35.24  )
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

CC broonie
CC somlo

On Wed, Feb 21, 2024 at 3:06=E2=80=AFPM Rob Herring <robh+dt@kernel.org> wr=
ote:
> On Fri, Feb 16, 2024 at 11:08=E2=80=AFPM Saurabh Singh Sengar
> <ssengar@linux.microsoft.com> wrote:
> > On Fri, Feb 16, 2024 at 05:05:51PM -0800, Frank Rowand wrote:
> > > When enabling CONFIG_OF on a platform where 'of_root' is not populate=
d
> > > by firmware, we end up without a root node. In order to apply overlay=
s
> > > and create subnodes of the root node, we need one. Create this root n=
ode
> > > by unflattening an empty builtin dtb.
> > >
> > > If firmware provides a flattened device tree (FDT) then the FDT is
> > > unflattened via setup_arch(). Otherwise, the call to
> > > unflatten(_and_copy)?_device_tree() will create an empty root node.
> > >
> > > We make of_have_populated_dt() return true only if the DTB was loaded=
 by
> > > firmware so that existing callers don't change behavior after this
> > > patch. The call in the of platform code is removed because it prevent=
s
> > > overlays from creating platform devices when the empty root node is
> > > used.
> > >
> > > [sboyd@kernel.org: Update of_have_populated_dt() to treat this empty =
dtb
> > > as not populated. Drop setup_of() initcall]
> > >
> > > Signed-off-by: Frank Rowand <frowand.list@gmail.com>
> > > Link: https://lore.kernel.org/r/20230317053415.2254616-2-frowand.list=
@gmail.com
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Signed-off-by: Stephen Boyd <sboyd@kernel.org>

Thanks for your patch, which is now commit 7b937cc243e5b1df ("of:
Create of_root if no dtb provided by firmware") in dt-rh/for-next
(next-20240312 and later).

On my OrangeCrab FPGA running Linux on LiteX/VexRiscv-V, the attached
OLED display now fails to probe:

    -ssd130x-i2c 0-003c: supply vcc not found, using dummy regulator
    -[drm] Initialized ssd130x 1.0.0 20220131 for 0-003c on minor 0
    +ssd130x-i2c 0-003c: incomplete constraints, dummy supplies not allowed
    +ssd130x-i2c 0-003c: error -ENODEV: Failed to get VCC regulator

> > > @@ -1645,6 +1635,21 @@ static inline bool of_device_is_system_power_c=
ontroller(const struct device_node
> > >       return of_property_read_bool(np, "system-power-controller");
> > >  }
> > >
> > > +/**
> > > + * of_have_populated_dt() - Has DT been populated by bootloader
> > > + *
> > > + * Return: True if a DTB has been populated by the bootloader and it=
 isn't the
> > > + * empty builtin one. False otherwise.
> > > + */
> > > +static inline bool of_have_populated_dt(void)
> > > +{
> > > +#ifdef CONFIG_OF
> > > +     return of_property_present(of_root, "compatible");
> >
> > This adds the strict check for compatible which makes compatible
> > to be mandatory for root nodes. So far, DeviceTree without compatible
> > property in root nodes can work. Do we want to make this documented
> > somewhere ?
>
> It already is in the DT spec and schemas.

How many systems in the wild violate this?

Apparently the DTS generated by LiteX does not have a root compatible
(and model) property, hence of_have_populated_dt() returns false.
While my gateware and DTS is quite old, a quick look at recent
litex_json2dts_linux.py history shows this is still true for current LiteX.

Now, how is this related to the failure I am seeing?

drivers/regulator/core.c has:

    static bool have_full_constraints(void)
    {
            return has_full_constraints || of_have_populated_dt();
    }

and

    static int __init regulator_init_complete(void)
    {
            /*
             * Since DT doesn't provide an idiomatic mechanism for
             * enabling full constraints and since it's much more natural
             * with DT to provide them just assume that a DT enabled
             * system has full constraints.
             */
            if (of_have_populated_dt())
                    has_full_constraints =3D true;

            ...
    }
    late_initcall_sync(regulator_init_complete);

(The latter looks a bit futile, as have_full_constraints() already
 contains a check for of_have_populated_dt()?)

When have_full_constraints() returns false, any dummy regulator will
fail to probe.

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

