Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23258C678D5
	for <linux-um@archiver.kernel.org>; Tue,  7 Mar 2023 21:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:Cc:From:Subject:References:
	In-Reply-To:MIME-Version:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZEp8o4N5pzcU4KLugIgLVVegRO/KJ0MzjtxpDpnzjU4=; b=ZY7+dS/k2gpFAO
	6OpWG8d0E3cUAU+skmQXsgA4HpmOZPHV7FvjH34GRbou4byRLZ7IZ2R5h48jfnzOmZwUfR2Ny207U
	6NHRMl/A+Z0dbSOxW3V9TTbyom6BCBks57quKJzMwbaCx+c+d6YXv4Njl1kdrDKOJgWK6ctM4djRr
	5JpSOYQ6CAAqo3+P2EjM8ZsdRPArm4a47qm0kjLoxheHF0qs6RgE7Mm9OHqf9C9yWN/02ni4cpBJ/
	JXbXB/XLgerhfCxVf1V0mAuyPVo966cO/77O7mGe5Xi0wCZC1O064ZUx70OWyYUl6qCJDLVufkn0x
	JPK+KSlZwFROCK2IAV7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZfFh-002XwX-OV; Tue, 07 Mar 2023 21:53:45 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZfFe-002Xw5-K6
	for linux-um@lists.infradead.org; Tue, 07 Mar 2023 21:53:44 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 22218B81A43;
	Tue,  7 Mar 2023 21:53:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB433C433EF;
	Tue,  7 Mar 2023 21:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678226016;
	bh=bXpDeJ+bKqyuyw9K1wlhaLEENKYmniVFEPD3+zmo9AE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=cEPL0PxrcCqhhfdpdMP7T5do0b0u55fgRXA6AcSKDTG4rmjAqKHUVagowIbRwdMNq
	 sjKhcK17x1oo/PIKeTLhHF8JQWXmZSdA0PQslle7OaCrGH8d/4dctj9hnhnCndVw//
	 flpnsEOOTge3smiTgjaXXwCzzL4QIoVRR0JvQVBW7cGXUId8Y0pEzl3mmnmXqVi+g4
	 YHJNuNfYEi7H0352Txc/VaRpjDzKNbDFyvkie34CBWIrXVnT9E4NkTM3i8o/pOa9dx
	 lqTd3WCct8W/Cu43Z3HyoIHfgppFM9A/7RJDQEF4CBe0iVWLNtV8YZDnO4zf/168SX
	 o6uh9K7Puc4Yw==
Message-ID: <509072932692550449632f714c6ccb29.sboyd@kernel.org>
MIME-Version: 1.0
In-Reply-To: <5e26a786-400a-cd6c-8771-d94a8020839d@gmail.com>
References: <20230302013822.1808711-1-sboyd@kernel.org> <CABVgOSnpMNCtEEsJV28OzUoxdDuiT4a2T0avP0AYf9xFW1jxrw@mail.gmail.com> <CAL_JsqJMd3Fi0ZBObdyE1VDKTH1_+smuGDymHnKOkVH2HB3jJQ@mail.gmail.com> <3759b28cca7ab751296d4dd83f2dcc51.sboyd@kernel.org> <5e26a786-400a-cd6c-8771-d94a8020839d@gmail.com>
Subject: Re: [PATCH 0/8] clk: Add kunit tests for fixed rate and parent data
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, Brendan Higgins <brendan.higgins@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J.Wysocki <rafael@kernel.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Vincent Whitchurch <vincent.whitchurch@axis.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, devicetree@vger.kernel.org, linux-um@lists.infradead.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
To: David Gow <davidgow@google.com>, Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>
Date: Tue, 07 Mar 2023 13:53:34 -0800
User-Agent: alot/0.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230307_135342_990591_0ECB498B 
X-CRM114-Status: GOOD (  20.66  )
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

Quoting Frank Rowand (2023-03-04 07:04:48)
> On 3/2/23 13:27, Stephen Boyd wrote:
> > 
> > But perhaps this design is too much of an end-to-end test and not a unit
> > test? In the spirit of unit testing we shouldn't care about how the node
> > is added to the live devicetree, just that there is a devicetree at all.
> > 
> > Supporting overlays to more easily test combinations sounds like a good
> > idea. Probably some kunit_*() prefixed functions could be used to
> 
> In an imaginary world where overlay support was completed, then _maybe_.
> 
> To me, the most important  environment to test is where the devictree
> data is populated in early boot from an FDT.  This is the environment
> that drivers currently exist in.
> 
> Populating devicetree data via an overlay adds in the functioning of the
> overlay apply code (and how the rules behind that functioning may differ
> from devicetree data populated in early boot from an FDT).

For the purposes of clk unit tests I don't care where the devicetree
nodes come from. All I care about is that they're rooted in the live
devicetree for the system and that they have platform devices attached
to them. The clk unit tests will assert that the overlay has been
applied and that should be sufficient to make sure the tests has
satisfied pre-conditions.

If these were end-to-end tests then I would agree that making the nodes
be loaded during early boot from an FDT would be the right approach.
That would test the integration of early DTB loading and code that runs
on the FDT. These aren't integration tests though, so when the nodes are
created and unflattened doesn't matter.

I'll introduce various unit tests around the kunit specific overlay
application API so that I know it makes platform devices and they have
device nodes attached to them. And those same tests should be able to
confirm that devices are destroyed when the overlay is removed.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
