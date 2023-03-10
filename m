Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8F3C6FD19
	for <linux-um@archiver.kernel.org>; Fri, 10 Mar 2023 08:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ESjRGTxWHtmrONc7804wtD/YQm2xYX72gCj0060Z1Cs=; b=xH3Ojue52LxG78
	Qz9XDO506RazAoCHazPm5Cub29pL78VlHJZdxZn4cJcUNFmaiB4nF8oUZ7e4P8aNcAEFM386LoxII
	VeZmVlnQArE40meOwLITG8HMf7dvDTAKU/M99fVvw2++5jfBbXSdfeH65fJWovk8O5OTz8Y/gtAeK
	o13mUuHJxqr0TF9fK821FoW80pHJJQVe/OGIKOSLTh2w9BpGyQ5lSyp1LcwJV8+4fDm8UbMlt6vCO
	bzwnUGefC/IwNbDD/H6kjZMM3DIFRsS9VXZfY9+ADNn5TR9owMDdEzyDiYG5nheYjl73RrU+0qw2g
	Vt/9x7BtFmPEIRz6jySw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paXyK-00Dc7q-4n; Fri, 10 Mar 2023 08:19:28 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paXyG-00Dc6o-0x
	for linux-um@lists.infradead.org; Fri, 10 Mar 2023 08:19:26 +0000
Received: by mail-wm1-x331.google.com with SMTP id az36so2830079wmb.1
        for <linux-um@lists.infradead.org>; Fri, 10 Mar 2023 00:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678436360;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e3+IejGerSkWVmYYthQksOk85z2qGIusABFoD8foBbU=;
        b=WIyaXheqnXnNzAG3ZpDrMShk0xBME1mI7nZjH2KgOK59dTBG1gaB04q55SdmETCjvP
         zMbKix1GeHqTX1SoM3+vrKysTljd2ZHbbNwZz0v1vCtTAgVPxsgQjQH1HDwzgEznIvTn
         vOqZbsq/rEQlWkYl4tEZVoYrawpl+8Q7+4MvRV08RPemY6CFxk9a010PtG3zauuOJZUm
         E0yLy45n6feN5/Q67wcYWHLvIYsvNVSDlwWHYiqJl4WHFpKX/zyAmqaZLppWbSAtuod/
         LJdjpfux/3MjVbjaEtaDC09SvVu4W/NQJBXPborM5cL88zTu0Z0PqoIFmw0szevnBJAO
         UXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678436360;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e3+IejGerSkWVmYYthQksOk85z2qGIusABFoD8foBbU=;
        b=MpKz/1G4tagGbM9XU/UF5kamjGO/MnBqaVCQRkhEghI11cpRs+fiOTvDzclt08JCL4
         ZOfroCC17ZHIIddkFR9yaHx75iztWLlj3INgcWXbBaW++cTDdmF6EFOBkfXRCCyXmxff
         WTcTFq8b+Vuq/uJJ3pNAGdK83mTJOaUC546lo9mY8OWefmT2umDeorYL1HV4Z8pRvb+h
         FfSgo5JtMwsVdQN4aKoCyL12zaLi+lDgn51bNCiuEmeEx0FMhSBoeRrUTcqPVOM13tKn
         v5iniWAOLqYJZgjhdFmszdpr3azyHIcUu1VYOvfhz8YnhRHDF+gNidFRilBGNCNh/Gnv
         JwGQ==
X-Gm-Message-State: AO0yUKWCTXaTinxB1UkD3xtJRqJ074dPcME/HoizXNaych3SQ4pnErgr
	mLogLQoQusR98y0kDT1LYQ2QdApo9RdoR6RxdNwQwg==
X-Google-Smtp-Source: AK7set9rSovQkv6G8/2uFWd8dZCJdhTjKOFXRnj4/glBjRHWFtuXEHSglc64lK3dRxU/gLKgbKiUpRiWGZkosiiA86U=
X-Received: by 2002:a7b:c2a9:0:b0:3df:97b0:ba02 with SMTP id
 c9-20020a7bc2a9000000b003df97b0ba02mr578544wmk.3.1678436360078; Fri, 10 Mar
 2023 00:19:20 -0800 (PST)
MIME-Version: 1.0
References: <20230302013822.1808711-1-sboyd@kernel.org> <20230302013822.1808711-4-sboyd@kernel.org>
 <CABVgOSmR0_u8Tw0E8C1mRFxSiGKwdKG5ka_+X_36Hj4VNLdg2g@mail.gmail.com> <b0d4d450a7ad9b39336771b74b48f086.sboyd@kernel.org>
In-Reply-To: <b0d4d450a7ad9b39336771b74b48f086.sboyd@kernel.org>
From: David Gow <davidgow@google.com>
Date: Fri, 10 Mar 2023 16:19:08 +0800
Message-ID: <CABVgOSmVJyG2X6aPzWGe9G-hUy8C7nWAqUnNoh-a5DFou6rkQA@mail.gmail.com>
Subject: Re: [PATCH 3/8] kunit: Add test managed platform_device/driver APIs
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, patches@lists.linux.dev, 
	Brendan Higgins <brendan.higgins@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, Rob Herring <robh+dt@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, devicetree@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230310_001924_088388_1C149F3E 
X-CRM114-Status: GOOD (  53.55  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Fri, 10 Mar 2023 at 07:25, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting David Gow (2023-03-02 23:15:31)
> > On Thu, 2 Mar 2023 at 09:38, Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Introduce KUnit resource wrappers around platform_driver_register(),
> > > platform_device_alloc(), and platform_device_add() so that test authors
> > > can register platform drivers/devices from their tests and have the
> > > drivers/devices automatically be unregistered when the test is done.
> > >
> > > This makes test setup code simpler when a platform driver or platform
> > > device is needed. Add a few test cases at the same time to make sure the
> > > APIs work as intended.
> > >
> > > Cc: Brendan Higgins <brendan.higgins@linux.dev>
> > > Cc: David Gow <davidgow@google.com>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > > ---
> > >
> > > Should this be moved to drivers/base/ and called platform_kunit.c?
> > > The include/kunit/platform_driver.h could also be
> > > kunit/platform_device.h to match linux/platform_device.h if that is more
> > > familiar.
> >
> > DRM has a similar thing already (albeit with a root_device, which is
> > more common with KUnit tests generally):
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/drm/drm_kunit_helpers.h
> >
> > But that's reasonably drm-specific, so it makes sense that it lives
> > with DRM stuff. platform_device is a bit more generic.
> >
> > I'd probably personally err on the side of having these in
> > drivers/base/, as I think we'll ultimately need similar things for a
> > lot of different devices, and I'd rather not end up with things like
> > USB device helpers living in the lib/kunit directory alongside the
> > "core" KUnit code. But I could be persuaded otherwise.
>
> Ok no problem. I'll move it.
>
> >
> > >
> > > And I'm not super certain about allocating a driver structure and
> > > embedding it in a wrapper struct. Maybe the code should just use
> > > kunit_get_current_test() instead?
> >
> > I think there are enough cases througout the kernel where
> > device/driver structs are needed that having this makes sense.
> > Combined with the fact that, while kunit_get_current_test() can be
> > used even when KUnit is not loaded, actually doing anything with the
> > resulting struct kunit pointer will probably require (at least for the
> > moment) KUnit functions to be reachable, so would break if
> > CONFIG_KUNIT=m.
>
> Wouldn't it still work in that case? The unit tests would be modular as
> well because they depend on CONFIG_KUNIT.
>

Yeah, the only case where this starts to get hairy is if the tests end
up in the same module as the thing being tested (which sometimes
happens to avoid having to export a bunch of symbols: see, e.g.
thunderbolt and amdgpu), and then someone wants to build production
kernels with CONFIG_KUNIT=m (alas, Red Hat and Android).

So that's the only real place where you might need to avoid the
non-'hook' KUnit functions, but those drivers are pretty few and far
between, and most of the really useful functionality should be moving
to 'hooks' which will be patched out cleanly at runtime.

> >
> > So, unless you actually find kunit_get_current_test() and friends to
> > be easier to work with, I'd probably stick with this.
> >
>
> Alright thanks.
>
> > > diff --git a/lib/kunit/platform_driver.c b/lib/kunit/platform_driver.c
> > > new file mode 100644
> > > index 000000000000..11d155114936
> > > --- /dev/null
> > > +++ b/lib/kunit/platform_driver.c
> > > @@ -0,0 +1,207 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Test managed platform driver
> > > + */
> > > +
> > > +#include <linux/device/driver.h>
> > > +#include <linux/platform_device.h>
> > > +
> > > +#include <kunit/resource.h>
> > > +
> > > +struct kunit_platform_device_alloc_params {
> > > +       const char *name;
> > > +       int id;
> > > +};
> >
> > FYI: It's my plan to eventually get rid of (or at least de-emphasize)
> > the whole 'init' function aspect of KUnit resources so we don't need
> > all of these extra structs and the like. It probably won't make it in
> > for 6.4, but we'll see...
>
> Will we be able to get the error values out of the init function? It's
> annoying that the error values can't be returned as error pointers to
> kunit_alloc_resource(). I end up skipping init, and doing it directly
> before or after calling the kunit_alloc_resource() function. I'll try to
> avoid init functions in the allocations.

Yeah, that's largely why the plan is to get rid of them: it just made
passing things around an enormous pain.
Just doing your own initialisation before adding it as a resource is
usually the right thing to do.

There's also going to be a simpler kunit_defer() wrapper around it,
which would just allow you to schedule a cleanup function to be called
(without the need to keep kunit_resource pointers around, etc), for
the cases where you don't need to look up resources elsewhere.

But just doing your own thing and calling kunit_alloc_resource() is
probably best for now, and should map well onto whatever this ends up
evolving into.

Cheers,
-- David

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
