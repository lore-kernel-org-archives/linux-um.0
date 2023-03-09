Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0BCC61DA4
	for <linux-um@archiver.kernel.org>; Thu,  9 Mar 2023 23:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:Cc:From:Subject:References:
	In-Reply-To:MIME-Version:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HasQoX8zCPZWw+MMAVHr0RBfxPV+DzQP3f+sFGJGQ5Y=; b=Q6tc/MGk40BuA/
	OYpe4kA/ZgfXp0i2sb6uJ1pjiZqQAvJa+JgETba8IYdfkp2m39SaTIKWmkBxdfNCAy0a7XNuvbGDJ
	DBPDEuStiTS3U3G0GMP4LTup8iT/pd+sTBGg+13bBlc7gkuVEU5bCtIBHsZFaN5ojmtzPje/gvIIS
	n6TcB6/4EGciR063Zdh+VtM9KZiBD8vms/33VdOADVch8R+swIVlQeU9KQZjJ3BW6tAE6aEv7NHrY
	jkx8fIXz07IAKWtgwhsCA3jkOuRHQdVlgwJvbt9QGaewHxxrpL9pe1A4f2j/2irJoiLbRUGmxTYSc
	C7gtZVpD+ht9bqR0sAhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paPR4-00CJGV-St; Thu, 09 Mar 2023 23:12:34 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paPR1-00CJFr-B6
	for linux-um@lists.infradead.org; Thu, 09 Mar 2023 23:12:32 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id E1DABB820E1;
	Thu,  9 Mar 2023 23:12:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831E8C433EF;
	Thu,  9 Mar 2023 23:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678403545;
	bh=f+qMFQyBJuGy7W7kgvaRQla+UTKn55+cGr82WqQnciU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=b2++4c//Y55ZukR8/hTB2Y009ekLicBGFc1mqBFO4WOH+oyM5+NrQKdQPGUksC/m4
	 gKe6mfII8jgFrcHGdXYYlj2wJXUWY8M09dvExa8pPv2o2n3pNroC6O9+ohqvW5sIz0
	 4Tl3KOPN2THBScSXZ/jYdHyafdYUmi6QVZNR4ieT2DXclG66la4fAp6EDWvt5Ye07x
	 heUP0TlcA9ydJnRZeCxtpw3xxv3/1mkqwU9eZdYgQl8oaHiZREXByz2+60yuKvdxR6
	 dX+TaEUaufA3v4s8mW/tdMRL0B0jWjcA2rWDOUwcG8EdDJn76NJw5Bteb5ulwff3qw
	 JWDQA6Fnv2kxg==
Message-ID: <377046f369227a11fbf9e67c3c122d79.sboyd@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABVgOSkxOxpaHVtq1YpvNEshTZ3nic1p7NjV5DPdz066=tiS-A@mail.gmail.com>
References: <20230302013822.1808711-1-sboyd@kernel.org> <20230302013822.1808711-2-sboyd@kernel.org> <CABVgOSkxOxpaHVtq1YpvNEshTZ3nic1p7NjV5DPdz066=tiS-A@mail.gmail.com>
Subject: Re: [PATCH 1/8] dt-bindings: Add linux,kunit binding
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, Brendan Higgins <brendan.higgins@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Vincent Whitchurch <vincent.whitchurch@axis.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, devicetree@vger.kernel.org, linux-um@lists.infradead.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
To: David Gow <davidgow@google.com>
Date: Thu, 09 Mar 2023 15:12:23 -0800
User-Agent: alot/0.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230309_151231_564505_21A09BF4 
X-CRM114-Status: GOOD (  15.91  )
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

Quoting David Gow (2023-03-02 23:14:55)
> On Thu, 2 Mar 2023 at 09:38, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Document the linux,kunit board compatible string. This board is loaded
> > into the Linux kernel when KUnit is testing devicetree dependent code.
> 
> As with the series as a whole, this might need to change a little bit
> if we want to either use devicetree overlays and/or other
> architectures.
> 
> That being said, I'm okay with having this until then: the only real
> topic for bikeshedding is the name.
> - Is KUnit best as a board name, or part of the vendor name?
> - Do we want to include the architecture in the name?
> Should it be "linux,kunit", "linux-kunit,uml", "linux,kunit-uml", etc?

I think I will drop this patch. I have overlays working. I hijacked
of_core_init() to load the testcase data from drivers/of/unittest-data
and made a container node for kunit overlays to apply to.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
