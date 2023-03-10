Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0AEC6FA99
	for <linux-um@archiver.kernel.org>; Fri, 10 Mar 2023 23:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:Cc:From:Subject:References:
	In-Reply-To:MIME-Version:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6NDds0FjsKTXwO40jU6AZ2KBPehIu91rcGWHeZIyIyE=; b=epeP7tYC256MUi
	4VXRMTZpuRMriOlhvMFLA44VkWYojJp/LOlD9wJlZpwdq9qwdm/qV4CSYygYqM8F5Pp1WZhpP1muT
	rh2PiMxObxvVzkbA0L7l+njko80duOG9x2bxN8GMzKM7r8SpDLRClNkvXu+4BgpfsZl1fdSTkIvac
	/e1b8EqBLgs5GFPEa+FAiQhUj1RM9RNrUxsngbF87kH98eowizjkv17jyDLc9cSexXdoIzErs8l02
	xbAh0zSHX7gCz3hpN7rio6iCF92LQeFbf0BiDYI8/9sQ6kn1pkTOpMVXmsW+cTN03GfpkYOSKeO8h
	lAHm3kccGdudNRsogyoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pamHN-00Gfki-Nj; Fri, 10 Mar 2023 23:36:05 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pamG4-00Gesq-3E
	for linux-um@lists.infradead.org; Fri, 10 Mar 2023 23:34:45 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 7DED8B82450;
	Fri, 10 Mar 2023 23:34:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183E9C433D2;
	Fri, 10 Mar 2023 23:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678491281;
	bh=uSd0tEmCWXupTOgTFvb2AvRm/aeTqjIy6WaKA0Y9qqo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=UCctW/WRBbQbVKQrrWl4XjTtfmz2ED/hswy7+PYcUnUJr5RPbyg06ckgY8EWIma3Z
	 /ZbzFocRpIsFlElSvJvQZhJ5ZWzFHUSJN1NSEpnxEG08/8z2nx+75kq7JMCEMcwaYz
	 rhMHlAJXsB8BZyt5qXpe6ByYBhtKa8/hmriG+PKHWUuUgTDOhEyR8pSDqzVjNjGafW
	 FD/nAeBTaiVUFjVZZHXUBqotSs/g7dnbuJ681VXJ/j4uHbTqso1JV60Nb3pZgfcILz
	 YTC/x8bfFFy7zG1R0gtpCvHsXbrq+reclJRfW1cxNYHH84sEoOsYhytZ+X9/RF9jZy
	 mtwZ/AZxg3mkQ==
Message-ID: <d64a086ddcb7c5ca5abecab0ca654259.sboyd@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABVgOSkJ4mw_DtFzn5EwcsuYixWY_j13YotxEYqWhO+ZCL1KPg@mail.gmail.com>
References: <20230302013822.1808711-1-sboyd@kernel.org> <20230302013822.1808711-3-sboyd@kernel.org> <CABVgOSkomwwgKZ9N0_0YMDL--QaZiTV7ONgSRABU2Ph1Z0CG-g@mail.gmail.com> <a97c9bb3a5addfb34af8ccabaa513026.sboyd@kernel.org> <CABVgOSkJ4mw_DtFzn5EwcsuYixWY_j13YotxEYqWhO+ZCL1KPg@mail.gmail.com>
Subject: Re: [PATCH 2/8] of: Enable DTB loading on UML for KUnit tests
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, Brendan Higgins <brendan.higgins@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Vincent Whitchurch <vincent.whitchurch@axis.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, devicetree@vger.kernel.org, linux-um@lists.infradead.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
To: David Gow <davidgow@google.com>
Date: Fri, 10 Mar 2023 15:34:38 -0800
User-Agent: alot/0.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230310_153444_453335_0ADD3834 
X-CRM114-Status: GOOD (  41.31  )
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

Quoting David Gow (2023-03-10 00:09:48)
> On Fri, 10 Mar 2023 at 07:19, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> >
> > Hmm. I think you're suggesting that the unit test data be loaded
> > whenever CONFIG_OF=y and CONFIG_KUNIT=y. Then tests can check for
> > CONFIG_OF and skip if it isn't enabled?
> >
> 
> More of the opposite: that we should have some way of supporting tests
> which might want to use a DTB other than the built-in one. Mostly for
> non-UML situations where an actual devicetree is needed to even boot
> far enough to get test output (so we wouldn't be able to override it
> with a compiled-in test one).

Ok, got it.

> 
> I think moving to overlays probably will render this idea obsolete:
> but the thought was to give test code a way to check for the required
> devicetree nodes at runtime, and skip the test if they weren't found.
> That way, the failure mode for trying to boot this on something which
> required another device tree for, e.g., serial, would be "these tests
> are skipped because the wrong device tree is loaded", not "I get no
> output because serial isn't working".
> 
> Again, though, it's only really needed for non-UML, and just loading
> overlays as needed should be much more sensible anyway.

I still have one niggle here. Loading overlays requires
CONFIG_OF_OVERLAY, and the overlay loading API returns -ENOTSUPP when
CONFIG_OF_OVERLAY=n. For now I'm checking for the config being enabled
in each test, but I'm thinking it may be better to simply call
kunit_skip() from the overlay loading function if the config is
disabled. This way tests can simply call the overlay loading function
and we'll halt the test immediately if the config isn't enabled.

> 
> > >
> > > That being said, I do think that there's probably some sense in
> > > supporting the compiled-in DTB as well (it's definitely simpler than
> > > patching kunit.py to always pass the extra command-line option in, for
> > > example).
> > > But maybe it'd be nice to have the command-line option override the
> > > built-in one if present.
> >
> > Got it. I need to test loading another DTB on the commandline still, but
> > I think this won't be a problem. We'll load the unittest-data DTB even
> > with KUnit on UML, so assuming that works on UML right now it should be
> > unchanged by this series once I resend.
> 
> Again, moving to overlays should render this mostly obsolete, no? Or
> am I misunderstanding how the overlay stuff will work?

Right, overlays make it largely a moot issue. The way the OF unit tests
work today is by grafting a DTB onto the live tree. I'm reusing that
logic to graft a container node target for kunit tests to add their
overlays too. It will be clearer once I post v2.

> 
> One possible future advantage of being able to test with custom DTs at
> boot time would be for fuzzing (provide random DT properties, see what
> happens in the test). We've got some vague plans to support a way of
> passing custom data to tests to support this kind of case (though, if
> we're using overlays, maybe the test could just patch those if we
> wanted to do that).

Ah ok. I can see someone making a fuzzer that modifies devicetree
properties randomly, e.g. using different strings for clock-names.

This reminds me of another issue I ran into. I wanted to test adding the
same platform device to the platform bus twice to confirm that the
second device can't be added. That prints a warning, which makes
kunit.py think that the test has failed because it printed a warning. Is
there some way to avoid that? I want something like

	KUNIT_EXPECT_WARNING(test, <call some function>)

so I can test error cases.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
