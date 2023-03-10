Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEC7C6FA99
	for <linux-um@archiver.kernel.org>; Fri, 10 Mar 2023 07:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qNVI4YMuO2GS4F2mdFoegBku7sj/2n/cDBcpqqmjunw=; b=G7Riy61rZ/m7qi
	G4LIfWNQZjkyY5aJRUvfn//5p3A8Ot2+N4vdXjjsWLqRmKNm03qZ38HfYoLyfV4Lm55y7Nu63xqyf
	fFs2iJ5MtykoohHJwk7IaSrrVR8N74b7EuzbgxKspNyClMvuXN1YLGplrRX5AH/JaqH6D8UOrmOfc
	T4QxL+RQC55VcEwettiRiod/XNrQGVBdXG6WXlnrLYUoeCyK7EpXymvO7ACzz+BAcUzxs8dOcNvws
	FQehREMJk167scj+tSdwyF5cpY5Z+c6evqvNmP3FkadELQ02uohOoD3p6QOoY6jdMNbNUQmqk+3xo
	30+iHqa/d5iBvzhyEIxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paXUS-00DSqk-Vb; Fri, 10 Mar 2023 07:48:37 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paXUP-00DSpK-Nq
	for linux-um@lists.infradead.org; Fri, 10 Mar 2023 07:48:35 +0000
Received: by mail-wm1-x334.google.com with SMTP id t25-20020a1c7719000000b003eb052cc5ccso5322505wmi.4
        for <linux-um@lists.infradead.org>; Thu, 09 Mar 2023 23:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678434508;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BUDFtqMWsthDMffvpAoMPW6y3w7gutRliueCUvQ1lFA=;
        b=c6uhtTrlFvX2BM8B+Ij5mKWKymjeCvxSSmfGjwYSjVIxzqXYqP0SfOHZbK741oT7wk
         NlxxCK1gj7+WYqCqxLHjNmwHAMPxA6AdgeB34pBQHICdqg1jH8WCuE4H/e5ROaw9ND1T
         lZbnKpoTm/BtattMX8rP3s1T8PlvxgJdWJYSXe72miYt/JQjJlsJYXa50BRfatV47R9O
         Gj7MjEHfW8ERZcfYLfJgqMxXPMaKRnWz+oh2dAzB+dKNrKPuBzWIXA51XCcNivWXyxQB
         tbumrMp/BpwZfMBTg35Td7IcZXcaxrc8+FwhutpNMfHGfg+X7LRU/BcJh0hT3SqXoEvo
         weGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678434508;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BUDFtqMWsthDMffvpAoMPW6y3w7gutRliueCUvQ1lFA=;
        b=SJ9tBz2SQnH6dyhjj3QwBO8/nhi5s8YIj9rAKWHZfnuvwrHec7PwYGpfXmAWzGBUQa
         UgfaExe9A7/65fnwQORSX4K8CxNkXotrn6QsJdwNemhvScDmj7l0iEycIy1sonWtuToJ
         yiSn3hBsfdRr9idxmM7a/+9xm2D9JcvbBGISFuiWUDt+5YptON50DWkQCqXWvK0qVoGl
         qv2OhgbSrm5ualzkeiluh/TRLvlr6rL8Ha3ipzWQyEQX23/bxVE1HE99EDzg26BMxvq7
         9eN5xusEDY+Ul0UDBqUc1bfW9K0Q/3aeqZ0fmvLuQQJwOjqTSICwwMjo2gcd5eiZxK3b
         6Saw==
X-Gm-Message-State: AO0yUKXj6jumTUieD+EMF4NrsSCW/tOKA/iSMWzL9YmQ/YIQTA3Je6rY
	A+uM/863+izQMMzii/Uayx36h4ds6m1Hahfol6JEaA==
X-Google-Smtp-Source: AK7set94tVYBFQ1almKq6L6E58IH8EKll1s7tduKC7DwGESChOPVpHL44fz+HerWj+MZWnIFNyPsKsUfV78uSRoksBg=
X-Received: by 2002:a1c:7910:0:b0:3eb:4cbe:1e87 with SMTP id
 l16-20020a1c7910000000b003eb4cbe1e87mr290872wme.3.1678434508065; Thu, 09 Mar
 2023 23:48:28 -0800 (PST)
MIME-Version: 1.0
References: <20230302013822.1808711-1-sboyd@kernel.org> <2ce31cd1-7a0e-18ac-8a5b-ed09d6539241@gmail.com>
In-Reply-To: <2ce31cd1-7a0e-18ac-8a5b-ed09d6539241@gmail.com>
From: David Gow <davidgow@google.com>
Date: Fri, 10 Mar 2023 15:48:15 +0800
Message-ID: <CABVgOS=6mLLYDr3ZOmv6iBQKPdFxTGDFP+uy9xgTHvdc03=vPw@mail.gmail.com>
Subject: Re: [PATCH 0/8] clk: Add kunit tests for fixed rate and parent data
To: Frank Rowand <frowand.list@gmail.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	patches@lists.linux.dev, Brendan Higgins <brendan.higgins@linux.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, Rob Herring <robh+dt@kernel.org>, 
	Christian Marangi <ansuelsmth@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, devicetree@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230309_234833_818360_BC1E2923 
X-CRM114-Status: GOOD (  36.56  )
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

On Sat, 4 Mar 2023 at 23:50, Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 3/1/23 19:38, Stephen Boyd wrote:
> > This patch series adds unit tests for the clk fixed rate basic type and
> > the clk registration functions that use struct clk_parent_data. To get
> > there, we add support for loading a DTB into the UML kernel that's
> > running the unit tests along with probing platform drivers to bind to
> > device nodes specified in DT.
> >
> > With this series, we're able to exercise some of the code in the common
> > clk framework that uses devicetree lookups to find parents and the fixed
> > rate clk code that scans devicetree directly and creates clks. Please
> > review.
>
> I would _really_ like to _not_ have devicetree tests in two locations:
> DT unittests and kunit tests.
>

I agree we don't want to split things up needlessly, but I think there
is a meaningful distinction between:
- Testing the DT infrastructure itself (with DT unittests)
- Testing a driver which may have some interaction with DT (via KUnit)

So, rather than going for a "devicetree" KUnit suite (unless we wanted
to port OF_UNITTEST to KUnit, which as you point out, would involve a
fair bit of reworking), I think the goal is for there to be lots of
driver test suites, each of which may verify that their specific
properties can be loaded from the devicetree correctly.

This is also why I prefer the overlay method, if we can get it to
work: it makes it clearer that the organisational hierarchy for these
tests is [driver]->[devicetree], not [devicetree]->[drvier].

> For my testing, I already build and boot four times on real hardware:
>
>   1) no DT unittests
>   2) CONFIG_OF_UNITTEST
>   3) CONFIG_OF_UNITTEST
>      CONFIG_OF_DYNAMIC
>   4) CONFIG_OF_UNITTEST
>      CONFIG_OF_DYNAMIC
>      CONFIG_OF_OVERLAY
>
> I really should also be testing the four configurations on UML, but at
> the moment I am not.
>
> I also check for new compile warnings at various warn levels for all
> four configurations.
>
> If I recall correctly, the kunit framework encourages more (many more?)
> kunit config options to select which test(s) are build for a test run.
> Someone please correct this paragraph if I am mis-stating.

We do tend to suggest that there is a separate kconfig option for each
area being tested (usually one per test suite, but if there are
several closely related suites, sticking them under a single config
option isn't a problem.)

That being said:
- It's possible (and encouraged) to just test once with all of those
tests enabled, rather than needing to test every possible combination
of configs enabled/disabled.
- (Indeed, this is what we do with .kunitconfig files a lot: they're
collections of related configs, so you can quickly run, e.g., all DRM
tests)
- Because a KUnit test being run is an independent action from it
being built-in, it's possible to build the tests once and then just
run different subsets anyway, or possibly run them after boot if
they're compiled as modules.
- This of course, depends on two test configs not conflicting with
each other: obviously if there were some tests which relied on
OF_OVERLAY=n, and others which require OF_OVERLAY=y, you'd need two
builds.

The bigger point is that, if the KUnit tests are focused on individual
drivers, rather than the devicetree infrastructure itself, then these
probably aren't as critical to run on every devicetree change (the DT
unittests should hopefully catch anything which affects devicetree as
a whole), but only on tests which affect a specific driver (as they're
really intended to make sure the drivers are accessing / interacting
with the DT properly, not that the DT infrastructure functions).

And obviously if this KUnit/devicetree support ends up depending on
overlays, that means there's no need to test them with overlays
disabled. :-)

>
> Adding devicetree tests to kunit adds additional build and boot cycles
> and additional test output streams to verify.
>
> Are there any issues with DT unittests that preclude adding clk tests
> into the DT unittests?
>

I think at least part of it is that there are already some clk KUnit
tests, so it's easier to have all of the clk tests behave similarly
(for the same reasons, alas, as using DT unittests makes it easier to
keep all of the DT tests in the same place).

Of course, as DT unittests move to KTAP, and possibly in the future
are able to make use of more KUnit infrastructure, this should get
simpler for everyone.


Does that seem sensible?

-- David

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
