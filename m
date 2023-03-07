Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19AFC6FA99
	for <linux-um@archiver.kernel.org>; Tue,  7 Mar 2023 22:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:Cc:From:Subject:References:
	In-Reply-To:MIME-Version:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gypN0isShdWOK7ZXJrFLft2FHL5UnJOjgL/+y2H2+Ys=; b=fOyccUpUWjhmDe
	hCJVQxCUFn9U4Wpk4cnI4hCQN+2eGF3HMj7Uya2YitJLujvX7W9i+ssB9tzWuRVEPVORoFvfZ9mdC
	ChSfRMw1BhT/fFVUYCGNryQ3q4TdKn06h0SXxNdvZCyG49+91XJJReF1IgA9eNHN9Q1XaRY0LB2HW
	A7iia2vtnm9CJXtIFJhJ4U6PaXfj1FJlRnYoToOpsEdLUjBKhO/MX0qOfOd+eCYlLb6z5Xo7wKXBb
	8qB6tBvTSYFN4pZ+DTA1BwFEr5ZwqhUJmUr/PJ2e71kHiNoiOqBklrbsSU7Bby7Wty+RTALZ+8Q1L
	COgDCkB71RwTun5QTsLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZfvo-002id4-HZ; Tue, 07 Mar 2023 22:37:16 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZfvm-002ibe-02
	for linux-um@lists.infradead.org; Tue, 07 Mar 2023 22:37:15 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 663A7B81A8C;
	Tue,  7 Mar 2023 22:37:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F1AC4339B;
	Tue,  7 Mar 2023 22:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678228629;
	bh=yV79Mc+v/FOShDjIEWDI434bJNFY5/ObJuF77GytpaE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=WeeJ6fRxvuoPXWuThLtc3lz/XAnCkWIo6kOH9FgzeiJIEbbgekicuM0h80f7aWkaG
	 JyNa6ivjBtTMrtx7HgQm4i4+8B5YcszdpHBeZ/pdWcANJfi/eDvnPQz/sa4r7JzyEI
	 mOz1d4bhN7IkRq5OZPq00YJqnkFjRA9PNhMam2rO/T0ixEjQuHyMnIv+d50qgHpri8
	 j0tOX6fM8A/4VA5er2WociJwN80RV0r7VSZugesRxHpLj5fIPVMxs116xAck4wIrBR
	 HNgJanRuB5sfsWnZMSeTqNd9GCHmuL6eC8tBHUI/HOybZGT3EHU1KGysHQsDuDMwAc
	 7HMwqonU7WfMQ==
Message-ID: <aed13be6944e4ab9cc1f567aeb3df171.sboyd@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230303143835.hxvkujrdxh7345ah@houat>
References: <20230302013822.1808711-1-sboyd@kernel.org> <20230303143835.hxvkujrdxh7345ah@houat>
Subject: Re: [PATCH 0/8] clk: Add kunit tests for fixed rate and parent data
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Vincent Whitchurch <vincent.whitchurch@axis.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, devicetree@vger.kernel.org, linux-um@lists.infradead.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
To: Maxime Ripard <maxime@cerno.tech>
Date: Tue, 07 Mar 2023 14:37:06 -0800
User-Agent: alot/0.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230307_143714_230021_3CB58B10 
X-CRM114-Status: GOOD (  23.94  )
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

Quoting Maxime Ripard (2023-03-03 06:38:35)
> Hi,
> 
> On Wed, Mar 01, 2023 at 05:38:13PM -0800, Stephen Boyd wrote:
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
> > 
> > I Cced everyone to all the patches so they get the full context. I'm
> > hoping I can take the whole pile through the clk tree as they almost all
> > depend on each other. In the future I imagine it will be easy to add
> > more test nodes to the clk.dtsi file and not need to go across various
> > maintainer trees like this series does.
> 
> That's really great, thanks!
> 
> I wanted to have a look at how we could possibly do this for DRM, I
> guess I have a starting point now :)
> 

Cool, thanks. You're on Cc now.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
