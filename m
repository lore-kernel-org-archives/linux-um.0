Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4786C4828D
	for <linux-um@archiver.kernel.org>; Mon,  5 Feb 2024 19:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pg0vleuARG2tQFPXTpmZPKI66XOaTEWhuPP2csZ8T84=; b=vVHY313zxFd4cqPqzLSqvtUVxt
	A1Gnl9nG/O7vu+on4aVB0RZG60jDmoeboxhJrvl6sFigoWPvTratK6NuEgRtR9IZXRm8Ccs0lfuMG
	lMh95wrECh7nTkFcKTs+CaLkSUHTucrk61h848zPdyq+dl75byWOKJfu4JMwdCieOLWVPS6D0heDw
	qcJjvgYuRuf9+Isggktw2c/CYLp+R0XLh5xGa5nDm98Btaf7eV9JYhqvdwPhd1kRdDhzgagKv9N90
	2nTWRCCVSRpPjFJDBaz9xsHrpvNPiGDAQ38WmVT4BLdJOLYqcwyM2/fnh3ph4Iog0Bsoh841F3VeI
	5CK+rEgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX54I-00000004uMs-2Ozo;
	Mon, 05 Feb 2024 19:55:50 +0000
Received: from mail-yw1-f175.google.com ([209.85.128.175])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX54E-00000004uL7-1pe4;
	Mon, 05 Feb 2024 19:55:48 +0000
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6041c6333cdso38548917b3.2;
        Mon, 05 Feb 2024 11:55:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707162944; x=1707767744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pg0vleuARG2tQFPXTpmZPKI66XOaTEWhuPP2csZ8T84=;
        b=ZfB61jx23oaw7iIPrq6rKhKR8Euj/iqoN0f5AjYuk07DXhXspc8IYPkp5sGkbqAdGD
         d4XKCa6AJrwB+IwGvQutAJF51ueWN3Stbh2nkT/R45eFamIYoBMOsmwPocmmLvwJbebJ
         XvoCUzlAJW1F/LatJz2Un8Rvs+5UKW+A8phprm3pHr/UGtNCEKrVWJzNtAnP2pp8BnB9
         xTRzoa2HYWwbMXudkfgftcm7kjCfWy6Q3lXYLCN/oQwz78DRndf6sjfTv8vCOZDCzY49
         RJLuZZXEVBoAb6icY5fp4cNVhcSxsZsE+f86+sCQhga8a5N4Cc8flJlpCCjZ6HZMUoEl
         AeAw==
X-Gm-Message-State: AOJu0YyXZX+wKLmi+1K8cOogtdBcOQvnsGM0C1MMg/+wJoaVk0O6hCFB
	f25hB0gNPmYLlHZoGBGXhXzLQzqnUJN44B0+V4Jd/o5LiKjaOq6zL9RFEMldnuY=
X-Google-Smtp-Source: AGHT+IGwhlcUnOP75O+VbbMPNNijizi642jqLl9uE3gHg+DdTNVWzhjcNPxsMjfkOevfd7FVxvT+Eg==
X-Received: by 2002:a81:524d:0:b0:5e8:fd1e:dadf with SMTP id g74-20020a81524d000000b005e8fd1edadfmr650141ywb.20.1707162944323;
        Mon, 05 Feb 2024 11:55:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU2yMBQ8EMbO9nkTGJRN4PS5S2lnFyLCN+lvePntLC5cy+mIG66ByieCa9stn4lNkByEkbqrGd1pwkuL1RoR57VIRcm9NO+ghQ1kuyRT8kUWJXemqv8CqAPpkXxtxoMcGSmXsK/F6DpweSGU9uVTz00vWg=
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id hc8-20020a05690c480800b006040dfa5615sm102130ywb.65.2024.02.05.11.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 11:55:44 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-60406f4e1d0so41718097b3.1;
        Mon, 05 Feb 2024 11:55:44 -0800 (PST)
X-Received: by 2002:a81:aa0f:0:b0:5ee:7299:e2cf with SMTP id
 i15-20020a81aa0f000000b005ee7299e2cfmr562941ywh.52.1707162942877; Mon, 05 Feb
 2024 11:55:42 -0800 (PST)
MIME-Version: 1.0
References: <20240202195909.3458162-1-sboyd@kernel.org> <20240202195909.3458162-8-sboyd@kernel.org>
 <CABVgOS=A8BQ6HHpBKFqg-N10ckk2XYavaS-MPXvZ0wenrVm=1g@mail.gmail.com> <89892ecd6b1b043db58258705c32b02b.sboyd@kernel.org>
In-Reply-To: <89892ecd6b1b043db58258705c32b02b.sboyd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 5 Feb 2024 20:55:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUuP5Ya2gU3V_ET=Ji_+yx+jr7eCch5uDJSqvQN9jJM3g@mail.gmail.com>
Message-ID: <CAMuHMdUuP5Ya2gU3V_ET=Ji_+yx+jr7eCch5uDJSqvQN9jJM3g@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] of: Add KUnit test to confirm DTB is loaded
To: Stephen Boyd <sboyd@kernel.org>
Cc: David Gow <davidgow@google.com>, Rob Herring <robh+dt@kernel.org>, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_115546_559344_005FAECD 
X-CRM114-Status: GOOD (  25.76  )
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

Hi Stephen,

On Mon, Feb 5, 2024 at 8:19=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> wrot=
e:
> Quoting David Gow (2024-02-02 20:10:17)
> > On Sat, 3 Feb 2024 at 03:59, Stephen Boyd <sboyd@kernel.org> wrote:
> > > Add a KUnit test that confirms a DTB has been loaded, i.e. there is a
> > > root node, and that the of_have_populated_dt() API works properly.
> > >
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Frank Rowand <frowand.list@gmail.com>
> > > Cc: David Gow <davidgow@google.com>
> > > Cc: Brendan Higgins <brendan.higgins@linux.dev>
> > > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > > ---
> >
> > This looks pretty good to me test-wise, though it still fails on m68k.
> > (Everything else I tried it on works, though I've definitely not tried
> > _every_ architecture.)
> >
> > aarch64: PASSED
> > i386: PASSED
> > x86_64: PASSED
> > x86_64 KASAN: PASSED
> > powerpc64: PASSED
> > UML: PASSED
> > UML LLVM: PASSED
> > m68k: FAILED
> > > $ qemu-system-m68k -nodefaults -m 1024 -kernel .kunit-all-m68k/vmlinu=
x -append 'kunit.enable=3D1 console=3Dhvc0 kunit_shutdown=3Dreboot' -no-reb=
oot -nographic -serial stdio -machine virt
> > > [11:55:05] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D dtb (2 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > > [11:55:05] # dtb_root_node_found_by_path: EXPECTATION FAILED at drive=
rs/of/of_test.c:18
> > > [11:55:05] Expected np is not null, but is
> > > [11:55:05] [FAILED] dtb_root_node_found_by_path
> > > [11:55:05] # dtb_root_node_populates_of_root: EXPECTATION FAILED at d=
rivers/of/of_test.c:28
> > > [11:55:05] Expected of_root is not null, but is
> > > [11:55:05] [FAILED] dtb_root_node_populates_of_root
> > > [11:55:05]     # module: of_test
> > > [11:55:05] # dtb: pass:0 fail:2 skip:0 total:2
> > > [11:55:05] # Totals: pass:0 fail:2 skip:0 total:2
> > > [11:55:05] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D [FAILED] dtb =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>
> Ah yeah I forgot to mention that. m68k fails because it doesn't call the
> unflatten_(and_copy)?_device_tree() function, so we don't populate a
> root node on that architecture. One solution would be to make CONFIG_OF
> unavailable on m68k. Or we have to make sure DT works on any
> architecture. Rob, what do you prefer here?

I guess the latter?
Alpha, hexagon, parisc, s390, and sparc are also lacking calls
to unflatten.*device_tree().

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

