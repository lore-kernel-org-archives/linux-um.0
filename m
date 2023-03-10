Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9887C74A4B
	for <linux-um@archiver.kernel.org>; Fri, 10 Mar 2023 08:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tyXKfW9CQOyRaRrL1kWDE7D8h831osTee6vCSKrSA9k=; b=CLHhKvAGm5/+F2
	xcOaNvL1XAg43VwPBNhq1KCwtRYyw1M52kE/ozeoo9XmaYo5fWHGaiQwbHZq8q1XDQNh2JjPV3h8m
	LuGRLd3TIG2kIa+xnqV93A9/e+etjfV19LaKlQwrq0QbQT+sdqgI6Frl+KXIrQqObu/hLVwr4jS7o
	WPI7CNf7A4/2h+wQsyFVjFQYRbgGZ7jp473zzoLEW7ZGn0OXGd1HQ5xO8iFAy4q8ffnjOxWnmVFYm
	xNmgP2rxdstBeYuURi8YmOkBpxp3Ial656PRdTFCHDae9BSIN/5NaPbr6dorFndLw9Z6WO1F2Tk+K
	RDSo6mRFzzXys/us/hwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paXq7-00DZ6C-PO; Fri, 10 Mar 2023 08:10:59 +0000
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paXpG-00DYad-Uz
	for linux-um@lists.infradead.org; Fri, 10 Mar 2023 08:10:08 +0000
Received: by mail-wr1-x431.google.com with SMTP id bx12so4203840wrb.11
        for <linux-um@lists.infradead.org>; Fri, 10 Mar 2023 00:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678435800;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wJVAKKHINtuSuDJu3EqDjp+q9iC1svWYPRp9peikZs8=;
        b=rrydp6AieROjsxXxzjQcjhFOtXm2HtCj7wFPfwDH6X6Dwr9hmufph/O5n5yoqpDtcX
         Q9rxhQtJ6Xoteqian3hzAPvqjJ5zI+GPGeG6QnPxBNEhHdIYiXCKmbTjphowwoPGs/BE
         h+y7vUuFtFmUbpLOcKbFXH0nZndQ4Vt+q4arQ2In0Dc0KcscRW2fEsPpNqXd/DZ0FwUo
         HCbr//Z1f5/BreIjLdVfHfHBjgC7TmXAcjbpSm0o+IgN1weY7pg1MxTLwcK44mf5Mg3W
         DaGM5DhCE9n4t1PSfowfsvUh9dgyfDKpSNFH5dRnkb02Urmc7Zf/ywCDIWdEAAMG9dq4
         mUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678435800;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wJVAKKHINtuSuDJu3EqDjp+q9iC1svWYPRp9peikZs8=;
        b=Son0XtHtA8tg0WkxfI8QtwB6+8KW3m+aM54mIgRrRCQHomo61uO03PDdvdneu7CRdP
         6qHZKaIICKPG3U4x/PEgMq03accm/xewoa2UYwwdK6ta62qkFPgrXfcp/cE18edO0pNh
         T2NAdC5GsDtXaG5QZJZwyrG8I9pM0lrpZSmh+h8r3aUVCPHDKkXktRwRu5mUIg9ywaVO
         rPNZ8/E+jsa4ykOBO21buU9r0gETsqhZsyQ0rml/UT7e1Nx+034C2YXPf1iq0EYcp8Wt
         E/fGg9zdl4ziqUIJEerl8hyin1aS27UWZxBj16MLzePolzk12ejf3eizIE1O7rFhDPgM
         0FMQ==
X-Gm-Message-State: AO0yUKVCZGOfrg0UaVntoniSfWsk45mrM1QDQwxRMdlmYZL+uP45BXCU
	bd5CArzEuoryct5wWN31gzIZHbMaqrG6z0BoyaLJkQ==
X-Google-Smtp-Source: AK7set/oX+Ou8MHsmEa5YUMjHQpxJqSO/uHVuTi9gb3Gx6kcmU5e2McI3sFT9YkqQ1MIxlwwDDsmoLE8DYvex/r7MOE=
X-Received: by 2002:a5d:4403:0:b0:2c6:ed0b:614e with SMTP id
 z3-20020a5d4403000000b002c6ed0b614emr5436803wrq.2.1678435800053; Fri, 10 Mar
 2023 00:10:00 -0800 (PST)
MIME-Version: 1.0
References: <20230302013822.1808711-1-sboyd@kernel.org> <20230302013822.1808711-3-sboyd@kernel.org>
 <CABVgOSkomwwgKZ9N0_0YMDL--QaZiTV7ONgSRABU2Ph1Z0CG-g@mail.gmail.com> <a97c9bb3a5addfb34af8ccabaa513026.sboyd@kernel.org>
In-Reply-To: <a97c9bb3a5addfb34af8ccabaa513026.sboyd@kernel.org>
From: David Gow <davidgow@google.com>
Date: Fri, 10 Mar 2023 16:09:48 +0800
Message-ID: <CABVgOSkJ4mw_DtFzn5EwcsuYixWY_j13YotxEYqWhO+ZCL1KPg@mail.gmail.com>
Subject: Re: [PATCH 2/8] of: Enable DTB loading on UML for KUnit tests
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
X-CRM114-CacheID: sfid-20230310_001007_038907_A5AA637B 
X-CRM114-Status: GOOD (  44.31  )
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

On Fri, 10 Mar 2023 at 07:19, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting David Gow (2023-03-02 23:15:04)
> > On Thu, 2 Mar 2023 at 09:38, Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > To fully exercise common clk framework code in KUnit we need to
> > > associate 'struct device' pointers with 'struct device_node' pointers so
> > > that things like clk_get() can parse DT nodes for 'clocks' and so that
> > > clk providers can use DT to provide clks; the most common mode of
> > > operation for clk providers.
> > >
> > > Adding support to KUnit so that it loads a DTB is fairly simple after
> > > commit b31297f04e86 ("um: Add devicetree support"). We can simply pass a
> > > pre-compiled deviectree blob (DTB) on the kunit.py commandline and UML
> > > will load it. The problem is that tests won't know that the commandline
> > > has been modified, nor that a DTB has been loaded. Take a different
> > > approach so that tests can skip if a DTB hasn't been loaded.
> > >
> > > Reuse the Makefile logic from the OF unittests to build a DTB into the
> > > kernel. This DTB will be for the mythical machine "linux,kunit", i.e.
> > > the devicetree for the KUnit "board". In practice, it is a dtsi file
> > > that will gather includes for kunit tests that rely in part on a
> > > devicetree being loaded. The devicetree should only be loaded if
> > > CONFIG_OF_KUNIT=y. Make that a choice config parallel to the existing
> > > CONFIG_OF_UNITTEST so that only one devicetree can be loaded in the
> > > system at a time. Similarly, the kernel commandline option to load a
> > > DTB is ignored if CONFIG_OF_KUNIT is enabled so that only one DTB is
> > > loaded at a time.
> >
> > This feels a little bit like it's just papering over the real problem,
> > which is that there's no way tests can skip themselves if no DTB is
> > loaded.
>
> Hmm. I think you're suggesting that the unit test data be loaded
> whenever CONFIG_OF=y and CONFIG_KUNIT=y. Then tests can check for
> CONFIG_OF and skip if it isn't enabled?
>

More of the opposite: that we should have some way of supporting tests
which might want to use a DTB other than the built-in one. Mostly for
non-UML situations where an actual devicetree is needed to even boot
far enough to get test output (so we wouldn't be able to override it
with a compiled-in test one).

I think moving to overlays probably will render this idea obsolete:
but the thought was to give test code a way to check for the required
devicetree nodes at runtime, and skip the test if they weren't found.
That way, the failure mode for trying to boot this on something which
required another device tree for, e.g., serial, would be "these tests
are skipped because the wrong device tree is loaded", not "I get no
output because serial isn't working".

Again, though, it's only really needed for non-UML, and just loading
overlays as needed should be much more sensible anyway.

> >
> > That being said, I do think that there's probably some sense in
> > supporting the compiled-in DTB as well (it's definitely simpler than
> > patching kunit.py to always pass the extra command-line option in, for
> > example).
> > But maybe it'd be nice to have the command-line option override the
> > built-in one if present.
>
> Got it. I need to test loading another DTB on the commandline still, but
> I think this won't be a problem. We'll load the unittest-data DTB even
> with KUnit on UML, so assuming that works on UML right now it should be
> unchanged by this series once I resend.

Again, moving to overlays should render this mostly obsolete, no? Or
am I misunderstanding how the overlay stuff will work?

One possible future advantage of being able to test with custom DTs at
boot time would be for fuzzing (provide random DT properties, see what
happens in the test). We've got some vague plans to support a way of
passing custom data to tests to support this kind of case (though, if
we're using overlays, maybe the test could just patch those if we
wanted to do that).


Cheers,
-- David

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
