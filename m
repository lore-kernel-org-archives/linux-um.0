Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90AEBC6FA99
	for <linux-um@archiver.kernel.org>; Fri, 10 Mar 2023 23:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:Cc:From:Subject:References:
	In-Reply-To:MIME-Version:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gbny/rJwBz7YPtQVU5PWSX/gbgJFB2iSqz8F9+ExprA=; b=QpUIignrLSL2PD
	GGmb/UPNQvoRAVFA/4Uzd5uEnAfKE1ZAek7y3VpMpNXrnQNR6MFN8IwzwQT+RWFQ0nRDHfl2ociQI
	Ups1J76VNroFjAIpso99yISA/p99eTl4T5KPe6Mq9djOEmcKqyx7/IzNILFabe6HoWJ16qOK59iNP
	Dk9iPS9GQYVx2Bbddku4Cd+9k+JTQgt8sLHkwl8KBmL3SpYzb+I0e0xvEnHoujD0ddXDnwL2e9wbT
	wkeGD87rV3YH1apd9Q5N0IPIKVZWdpAPbik9LAeN3gyFG2rgmeu9KLjJZ1/Eu/XJ3zmAP2lu18VCq
	ojR3YL2BBVFHR0V6ixIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pam3M-00GbPc-Qy; Fri, 10 Mar 2023 23:21:36 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pam3J-00GbP0-DT
	for linux-um@lists.infradead.org; Fri, 10 Mar 2023 23:21:35 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 16B82B8244D;
	Fri, 10 Mar 2023 23:21:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CB6C433D2;
	Fri, 10 Mar 2023 23:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678490489;
	bh=Npny9ESbzIr4YnzQ03Gj3yQ775wdrfEdkosmTVaC0Uw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=EIVro1bu+N3OK/q5OEERqChLs25DFQCNhj78gEv8fI8l0BIBByNN1mFCkamda+yhK
	 dLzFUW1UtR1ojJGlSZ4KsUPueDd1wbdRhqx985fisdjBgM8vr3X/eZg4XtNEcPa7/G
	 gZ4Pfo28UVWrqvEoYmaZ8Yey6Ov1Yf97tR29NPBKMjvs4sXT+Ejjny2BSX70iqYPDC
	 RsYZHJnXfbcHlRJu+KoxkLjBDTSkBh/LwZAFdnefQiBHdrp0DSgA4FlJ9G9yNnnNAS
	 N2fq1RI9yFhA4SV8nIuKaaIAKfCy06anbGm3vWJi/WmQrzdwblSGslTTdLBkdgoZ5I
	 0WzTNMHlXfhWA==
Message-ID: <77b315f6b89eb256c516ee08b1c17312.sboyd@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABVgOSkahumU6T+rCVx+k7Y9=iMszveseVYE0wfKjXwkNJpFxQ@mail.gmail.com>
References: <20230302013822.1808711-1-sboyd@kernel.org> <20230302013822.1808711-5-sboyd@kernel.org> <CABVgOSkahumU6T+rCVx+k7Y9=iMszveseVYE0wfKjXwkNJpFxQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] clk: Add test managed clk provider/consumer APIs
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, Brendan Higgins <brendan.higgins@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Vincent Whitchurch <vincent.whitchurch@axis.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, devicetree@vger.kernel.org, linux-um@lists.infradead.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
To: David Gow <davidgow@google.com>
Date: Fri, 10 Mar 2023 15:21:27 -0800
User-Agent: alot/0.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230310_152133_784221_951CB6E6 
X-CRM114-Status: GOOD (  34.26  )
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

Quoting David Gow (2023-03-02 23:15:35)
> On Thu, 2 Mar 2023 at 09:38, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Unit tests are more ergonomic and simpler to understand if they don't
> > have to hoist a bunch of code into the test harness init and exit
> > functions. Add some test managed wrappers for the clk APIs so that clk
> > unit tests can write more code in the actual test and less code in the
> > harness.
> >
> > Only add APIs that are used for now. More wrappers can be added in the
> > future as necessary.
> >
> > Cc: Brendan Higgins <brendan.higgins@linux.dev>
> > Cc: David Gow <davidgow@google.com>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> 
> Looks good, modulo bikeshedding below.

Cool!

> >
> > diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> > index e3ca0d058a25..7efce649b0d3 100644
> > --- a/drivers/clk/Makefile
> > +++ b/drivers/clk/Makefile
> > @@ -17,6 +17,11 @@ ifeq ($(CONFIG_OF), y)
> >  obj-$(CONFIG_COMMON_CLK)       += clk-conf.o
> >  endif
> >
> > +# KUnit specific helpers
> > +ifeq ($(CONFIG_COMMON_CLK), y)
> > +obj-$(CONFIG_KUNIT)            += clk-kunit.o
> 
> Do we want to compile these in whenever KUnit is enabled, or only when
> we're building clk tests specifically? I suspect this would be served
> better by being under a CLK_KUNIT config option, which all of the
> tests then depend on. (Whether that's the existing
> CONFIG_CLK_KUNIT_TEST, and all of the clk tests live under the same
> config option, or a separate parent option would be up to you).

I was thinking of building it in with whatever mode CONFIG_KUNIT is
built as. If this is a module because CONFIG_KUNIT=m, then unit tests
would depend on that, and this would be a module as well. modprobe would
know that some unit test module depends on symbols provided by
clk-kunit.ko and thus load clk-kunit.ko first.

> 
> Equally, this could be a bit interesting if CONFIG_KUNIT=m. Given
> CONFIG_COMMON_CLK=y, this would end up as a clk-kunit module, no?

Yes, that is the intent.

> 
> > +endif
> > +
> >  # hardware specific clock types
> >  # please keep this section sorted lexicographically by file path name
> >  obj-$(CONFIG_COMMON_CLK_APPLE_NCO)     += clk-apple-nco.o
> > diff --git a/drivers/clk/clk-kunit.c b/drivers/clk/clk-kunit.c
> > new file mode 100644
> > index 000000000000..78d85b3a7a4a
> > --- /dev/null
> > +++ b/drivers/clk/clk-kunit.c
> > @@ -0,0 +1,204 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * KUnit helpers for clk tests
> > + */
> > +#include <linux/clk.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/err.h>
> > +#include <linux/kernel.h>
> > +#include <linux/slab.h>
> > +
> > +#include <kunit/resource.h>
> > +
> > +#include "clk-kunit.h"
> > +
> > +static void kunit_clk_disable_unprepare(struct kunit_resource *res)
> 
> We need to decide on the naming scheme of these, and in particular if
> they should be kunit_clk or clk_kunit (or something else).
> 
> I'd lean to clk_kunit, if only to match DRM's KUnit helpers being
> drm_kunit_helper better, and so that these are more tightly bound to
> the subsystem being tested.
> (i.e., so I don't have to scroll through every subsystem's helpers
> when autocompleting kunit_).

Ok, got it. I was trying to match kunit_kzalloc() style. It makes it
easy to slap the 'kunit_' prefix on existing auto-completed function
names like kzalloc() or clk_prepare_enable().

I wasn't aware of drm_kunit_helper. That's a mouthful! We don't call it
slab_kunit_helper_kzalloc(). Maybe to satisfy all conditions it should
be:

	clk_prepare_enable_kunit()

so that kunit_ autocomplete doesn't have a big scroll list, and clk
subsystem autocompletes, and we know it is kunit specific.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
