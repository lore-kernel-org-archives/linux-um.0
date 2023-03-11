Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5417C61DA4
	for <linux-um@archiver.kernel.org>; Sat, 11 Mar 2023 06:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LVWgNDg25z6088/bFSh+ktySrJ0ySwho4Z42Zv0nJlk=; b=L7qiA4QFfraObQ
	S1EJDiLdPbrtNbL8i8qHUs4Y0vtaL7BFehxXMZfvt1ofQhyac6iuwSPotkndsQlnGTlJtW3SzBA32
	/rOeS2S9Cl6HYryEhSqqOUj1CqYntoU2Bbko+iV9x1yHY2da9WuTdkfTj6bwYKVdcVS6t7va4KQ1B
	Ss5z5gXNMMC1rNB3Gs3gKcmFFxFeJ4wuF/JvejGvO2PMj4iq8gJsBJvXYPKjeYh4pW/q8zce25n6m
	WU5T6Gvb+KW0gnjE1Vy45oPLj9ubdjqB3tN7HUs2P1IqtWcHu+GCJlFkNSXctwPCCMRYOompvgWDM
	zLXkKszT9t2rAQKiRXEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pasmL-00HJEA-KV; Sat, 11 Mar 2023 06:32:29 +0000
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pasmH-00HJCb-VK
	for linux-um@lists.infradead.org; Sat, 11 Mar 2023 06:32:27 +0000
Received: by mail-wr1-x435.google.com with SMTP id bw19so6938398wrb.13
        for <linux-um@lists.infradead.org>; Fri, 10 Mar 2023 22:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678516336;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6lmrU4eTdH1LlrPfEXYDhzp3lUOoppeHdlpzZNoxfe8=;
        b=nLq7Xb4NF24D7H3GBjsYHagIbHndwNT+61zuD0Nlg2PmcM+4idvhH1kpGl36ZO3lWa
         /eR/XYw4MXooepkTU6nJU+3AVZtCTGd1Af/8FkuzbQI5LqnUJhXGjxDD82N5qKelAIqy
         XmoZW7shdO7q/JUuV2JXQ5JhgvBN9wgra0Gf5uXqUmVd3S02t20EZINF9RnJd3QCTRbT
         1qyTclKhFybjQfHvGM0jOE94DVvxGY6ns2vn49mdPV9WnwRppLtwnHkmUEjsS6xGs25K
         i1NtAmKBILjC7GfdpQHt0i0y2wPwnzanFUPn6SM2euF6DuNrTjvR/KreaZqFfWfj7kbx
         iJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678516336;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6lmrU4eTdH1LlrPfEXYDhzp3lUOoppeHdlpzZNoxfe8=;
        b=40ljk3Nu7advQRxQP3agq4hzDFRHFcxLQOoEmcOSjf1oHjXrRCNaoynKBgMNkuy/BJ
         JQ72nEFnfkuAQxYIqbSd1kMUAFYV6SbXm9Ouki4gX2JUxIG0uXRsybih3fHKDzfA4pOi
         feMBQz89jcnWFwM+ovRwwCgBt3RaQ68NwBFREygc3lDJYPE/+F9FwNMDEPm2YN3oYlhO
         cEUoXVscauWwplw8DPLU+QJx8CFE+X3zSDNnTcNCeVED9fakn0vtBevxQNBVRpVmCpld
         cVQ9iGcVXVMKh1Yt4r8ldovLzGTnGakwl7hlPN6xR+bOUUp0zAykHl5UazI8tb1gfm0r
         RNwQ==
X-Gm-Message-State: AO0yUKVy+sKdybVZCxFsosAWWe2zpYv0Jv97O+qcvkVOFwX8za46SIpS
	susZWcYTEFN5rJ2SZ7XBRki7S3Os6+L8eSOLAyjVLQ==
X-Google-Smtp-Source: AK7set8S2emKWNLgFkZRnoOWd+fhiVrrKPr/wP5P1ol0gsAdT7wLI36gea8rEw4xa3hE8VAdoqwkQ2QNeNlyrP+Shvo=
X-Received: by 2002:a5d:4e06:0:b0:2c5:a38f:ca2f with SMTP id
 p6-20020a5d4e06000000b002c5a38fca2fmr921405wrt.4.1678516336462; Fri, 10 Mar
 2023 22:32:16 -0800 (PST)
MIME-Version: 1.0
References: <20230302013822.1808711-1-sboyd@kernel.org> <20230302013822.1808711-5-sboyd@kernel.org>
 <CABVgOSkahumU6T+rCVx+k7Y9=iMszveseVYE0wfKjXwkNJpFxQ@mail.gmail.com> <77b315f6b89eb256c516ee08b1c17312.sboyd@kernel.org>
In-Reply-To: <77b315f6b89eb256c516ee08b1c17312.sboyd@kernel.org>
From: David Gow <davidgow@google.com>
Date: Sat, 11 Mar 2023 14:32:04 +0800
Message-ID: <CABVgOSk4gEob3rokKF_p2Bcd_Sj3ikUN4R-HPHyTR0Eoo==85g@mail.gmail.com>
Subject: Re: [PATCH 4/8] clk: Add test managed clk provider/consumer APIs
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
X-CRM114-CacheID: sfid-20230310_223226_037481_81D6EECA 
X-CRM114-Status: GOOD (  44.55  )
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

On Sat, 11 Mar 2023 at 07:21, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting David Gow (2023-03-02 23:15:35)
> > On Thu, 2 Mar 2023 at 09:38, Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Unit tests are more ergonomic and simpler to understand if they don't
> > > have to hoist a bunch of code into the test harness init and exit
> > > functions. Add some test managed wrappers for the clk APIs so that clk
> > > unit tests can write more code in the actual test and less code in the
> > > harness.
> > >
> > > Only add APIs that are used for now. More wrappers can be added in the
> > > future as necessary.
> > >
> > > Cc: Brendan Higgins <brendan.higgins@linux.dev>
> > > Cc: David Gow <davidgow@google.com>
> > > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > > ---
> >
> > Looks good, modulo bikeshedding below.
>
> Cool!
>
> > >
> > > diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> > > index e3ca0d058a25..7efce649b0d3 100644
> > > --- a/drivers/clk/Makefile
> > > +++ b/drivers/clk/Makefile
> > > @@ -17,6 +17,11 @@ ifeq ($(CONFIG_OF), y)
> > >  obj-$(CONFIG_COMMON_CLK)       += clk-conf.o
> > >  endif
> > >
> > > +# KUnit specific helpers
> > > +ifeq ($(CONFIG_COMMON_CLK), y)
> > > +obj-$(CONFIG_KUNIT)            += clk-kunit.o
> >
> > Do we want to compile these in whenever KUnit is enabled, or only when
> > we're building clk tests specifically? I suspect this would be served
> > better by being under a CLK_KUNIT config option, which all of the
> > tests then depend on. (Whether that's the existing
> > CONFIG_CLK_KUNIT_TEST, and all of the clk tests live under the same
> > config option, or a separate parent option would be up to you).
>
> I was thinking of building it in with whatever mode CONFIG_KUNIT is
> built as. If this is a module because CONFIG_KUNIT=m, then unit tests
> would depend on that, and this would be a module as well. modprobe would
> know that some unit test module depends on symbols provided by
> clk-kunit.ko and thus load clk-kunit.ko first.
>

Personally, I'd rather have this behind CONFIG_CLK_KUNIT_TEST if
possible, if only to avoid needlessly building these if someone just
wants to test some other subsystem (but needs CONFIG_COMMON_CLK
enabled anyway). I doubt it'd be a problem in practice in this case,
but we definitely want to keep build (and hence iteration) times down
as much as possible, so it's probably good practice to keep all tests
behind at least some sort of "test this subsystem" option.

> >
> > Equally, this could be a bit interesting if CONFIG_KUNIT=m. Given
> > CONFIG_COMMON_CLK=y, this would end up as a clk-kunit module, no?
>
> Yes, that is the intent.
>
> >
> > > +endif
> > > +
> > >  # hardware specific clock types
> > >  # please keep this section sorted lexicographically by file path name
> > >  obj-$(CONFIG_COMMON_CLK_APPLE_NCO)     += clk-apple-nco.o
> > > diff --git a/drivers/clk/clk-kunit.c b/drivers/clk/clk-kunit.c
> > > new file mode 100644
> > > index 000000000000..78d85b3a7a4a
> > > --- /dev/null
> > > +++ b/drivers/clk/clk-kunit.c
> > > @@ -0,0 +1,204 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * KUnit helpers for clk tests
> > > + */
> > > +#include <linux/clk.h>
> > > +#include <linux/clk-provider.h>
> > > +#include <linux/err.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/slab.h>
> > > +
> > > +#include <kunit/resource.h>
> > > +
> > > +#include "clk-kunit.h"
> > > +
> > > +static void kunit_clk_disable_unprepare(struct kunit_resource *res)
> >
> > We need to decide on the naming scheme of these, and in particular if
> > they should be kunit_clk or clk_kunit (or something else).
> >
> > I'd lean to clk_kunit, if only to match DRM's KUnit helpers being
> > drm_kunit_helper better, and so that these are more tightly bound to
> > the subsystem being tested.
> > (i.e., so I don't have to scroll through every subsystem's helpers
> > when autocompleting kunit_).
>
> Ok, got it. I was trying to match kunit_kzalloc() style. It makes it
> easy to slap the 'kunit_' prefix on existing auto-completed function
> names like kzalloc() or clk_prepare_enable().

Yeah: my rule of thumb at the moment is to keep the kunit_ prefix for
things which are generic across the whole kernel (and tend to be
implemented in lib/kunit), and to use suffixes or infixes (whichever
works best) for things which are subsystem-specific.

> I wasn't aware of drm_kunit_helper. That's a mouthful! We don't call it
> slab_kunit_helper_kzalloc(). Maybe to satisfy all conditions it should
> be:
>
>         clk_prepare_enable_kunit()
>
> so that kunit_ autocomplete doesn't have a big scroll list, and clk
> subsystem autocompletes, and we know it is kunit specific.


Sounds good to me.

Cheers,
-- David

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
