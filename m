Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC19C64EC4
	for <linux-um@archiver.kernel.org>; Thu,  9 Mar 2023 23:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:Cc:From:Subject:References:
	In-Reply-To:MIME-Version:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C8y5fc22aQIfyONuGIErW/LcWiH7AdyGN3Ji9lEeg+Q=; b=wxlx1rYN5Q0bmp
	WcJO/SnIICsV2+6A4s7b2cOUWLUwk1SJxc9Y2TOLt8MPyHUElQiiaKgf+wuePhIm42wLg//Vjpozd
	VNQW6pzDcgpR44AsHqegMzhxUH7uzy73cdJ8+U6x4xhOzJWd3o8dEddOCd4yxqqnx3YkIhKJmq9/W
	OY5NSbbZ27hrXwrICENDKX2k7vr8bLjtBS2QnV8oadZanVRIl6Zq20cGPj7D+DI/PQVI3Yemj/bN2
	qihDH3vtAaP4NWtNCQGgfRTXfFBszfySReD4TxXzFL9Gdx6MMc1yDf08wDgSTw/1NqtFM2Xxpbc9o
	BlxedPDA4s98tJh/ULug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paPXv-00CJzH-94; Thu, 09 Mar 2023 23:19:39 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paPXo-00CJxs-Ow
	for linux-um@lists.infradead.org; Thu, 09 Mar 2023 23:19:37 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 54BBE61B4A;
	Thu,  9 Mar 2023 23:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C63C433EF;
	Thu,  9 Mar 2023 23:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678403971;
	bh=0e1IQuJM6EOb5pF3dOal+TY0fflstRFeaSOPVjTl6rk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=WTw9lhTBdv/hpDwi8v6P1+xgoHMQ7K073snH/DjLyODMeuVcXMzZGRpayl1GqnXoJ
	 TZYGx8IxRtunqcCzWkBB6vQJL3Q5wLiw/8x3Wu0p3Z2mVv91oHLmZs5/LCvu1hckJ5
	 Y86jbRH1E4b0eJdKv69OKTZRAINlbhkeJZpDSnCnDEmjqKqHqSQcRFj7LAfkQbVnSu
	 /otSYFe7xyEcx56wLYqqQOARY2LAu0Q8Z8eytpjalU4xjE1a3795SxKFvJkFZ/ikxg
	 9sNl5bhX7Noy1mCyAkdVnKi30/W6I6REzK1i6YmEDpzYZWqYfkTGlRhU6Zl4smKtiL
	 6lAp7OvgRe6mQ==
Message-ID: <a97c9bb3a5addfb34af8ccabaa513026.sboyd@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABVgOSkomwwgKZ9N0_0YMDL--QaZiTV7ONgSRABU2Ph1Z0CG-g@mail.gmail.com>
References: <20230302013822.1808711-1-sboyd@kernel.org> <20230302013822.1808711-3-sboyd@kernel.org> <CABVgOSkomwwgKZ9N0_0YMDL--QaZiTV7ONgSRABU2Ph1Z0CG-g@mail.gmail.com>
Subject: Re: [PATCH 2/8] of: Enable DTB loading on UML for KUnit tests
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, Brendan Higgins <brendan.higgins@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Vincent Whitchurch <vincent.whitchurch@axis.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, devicetree@vger.kernel.org, linux-um@lists.infradead.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
To: David Gow <davidgow@google.com>
Date: Thu, 09 Mar 2023 15:19:29 -0800
User-Agent: alot/0.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230309_151932_907140_59220CD0 
X-CRM114-Status: GOOD (  31.29  )
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

Quoting David Gow (2023-03-02 23:15:04)
> On Thu, 2 Mar 2023 at 09:38, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > To fully exercise common clk framework code in KUnit we need to
> > associate 'struct device' pointers with 'struct device_node' pointers so
> > that things like clk_get() can parse DT nodes for 'clocks' and so that
> > clk providers can use DT to provide clks; the most common mode of
> > operation for clk providers.
> >
> > Adding support to KUnit so that it loads a DTB is fairly simple after
> > commit b31297f04e86 ("um: Add devicetree support"). We can simply pass a
> > pre-compiled deviectree blob (DTB) on the kunit.py commandline and UML
> > will load it. The problem is that tests won't know that the commandline
> > has been modified, nor that a DTB has been loaded. Take a different
> > approach so that tests can skip if a DTB hasn't been loaded.
> >
> > Reuse the Makefile logic from the OF unittests to build a DTB into the
> > kernel. This DTB will be for the mythical machine "linux,kunit", i.e.
> > the devicetree for the KUnit "board". In practice, it is a dtsi file
> > that will gather includes for kunit tests that rely in part on a
> > devicetree being loaded. The devicetree should only be loaded if
> > CONFIG_OF_KUNIT=y. Make that a choice config parallel to the existing
> > CONFIG_OF_UNITTEST so that only one devicetree can be loaded in the
> > system at a time. Similarly, the kernel commandline option to load a
> > DTB is ignored if CONFIG_OF_KUNIT is enabled so that only one DTB is
> > loaded at a time.
> 
> This feels a little bit like it's just papering over the real problem,
> which is that there's no way tests can skip themselves if no DTB is
> loaded.

Hmm. I think you're suggesting that the unit test data be loaded
whenever CONFIG_OF=y and CONFIG_KUNIT=y. Then tests can check for
CONFIG_OF and skip if it isn't enabled?

> 
> That being said, I do think that there's probably some sense in
> supporting the compiled-in DTB as well (it's definitely simpler than
> patching kunit.py to always pass the extra command-line option in, for
> example).
> But maybe it'd be nice to have the command-line option override the
> built-in one if present.

Got it. I need to test loading another DTB on the commandline still, but
I think this won't be a problem. We'll load the unittest-data DTB even
with KUnit on UML, so assuming that works on UML right now it should be
unchanged by this series once I resend.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
