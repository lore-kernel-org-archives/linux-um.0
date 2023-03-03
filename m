Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74340C678D4
	for <linux-um@archiver.kernel.org>; Fri,  3 Mar 2023 14:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ywDtr/TdqsH39VuoUmfg1Dtl36pa5obtrnlq/L6VJVE=; b=nRY+rRYHjIGqJW
	qAOcj3/CAQVsrLDhz80oqJL2gPgF7PJpGZDMZjD7BuhmiPPjzQ2s0T6KzJK98CFjMEDnQtLf9qjct
	AJX2WEcnwqpAFX9SrJqa8IlU968h06Wf4kNHJsqPNSzTPpJn+6ppIhN2HtRrfNtIquJY31pr7pbRs
	0LaP05N1yhEmR98ZHm7qmc9rKeQxON3BdW8PDKOqK0wxPQGIXOBw+KOD9wMMIu12wkmReJzfiee0W
	w5qbiyif62f/K7TQPmW0b6lBR6VSfSm5ZTAUI9anNIgvFqVFYwMflp0qRLr1jcmYPq1H+y7EFNzBq
	N1PnfeYXoG7AEOU5TdOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pY6Vc-006cSf-U9; Fri, 03 Mar 2023 14:35:44 +0000
Received: from new1-smtp.messagingengine.com ([66.111.4.221])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pY6VY-006cQ4-Sd
	for linux-um@lists.infradead.org; Fri, 03 Mar 2023 14:35:42 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.nyi.internal (Postfix) with ESMTP id 76ECD58206E;
	Fri,  3 Mar 2023 09:35:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 03 Mar 2023 09:35:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1677854132; x=1677861332; bh=EhQ9pFjZXP4HTv7ya9gpFDV+YiUqRp+E8wi
	r3tCHXho=; b=I1headauudJSswX9EvaMaMq8BcWzxWf1GaVo8Wlw4FdySSolnyJ
	TA6uUxYnw+dJBczt/cQHmUGM0xE1M/w2OmW+SnSGEpJTCzVCCo1pUuq2F155BLp8
	u27ubW7A0hzJmJsej7z8xMbyZVV89dMs9I10LaSzt5PYlFi8duBYsojDOBz/xBZy
	MRrjwGMGgPdEE3riBCJM8SIfAYTpSK9nfM2qRwrc4YiK4xBq697RlT46sceAib5y
	J8Mi7v6p/BMKMyQJ8PIXgdAp9BaNCb7/ZrCW2+vHgeRlkmTeJPysYO5kNI8x35wE
	2g1myqJgxY6PPJtNNV+h8NnlBspDFm2i9qA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1677854132; x=1677861332; bh=EhQ9pFjZXP4HTv7ya9gpFDV+YiUqRp+E8wi
	r3tCHXho=; b=Trcg1C7+2n3zXd+Vk5nrLVQ9hvyeM23w9il2QRgPkTdtwBHNmOY
	RBkjbOHXWpfW2xJq902uqJFWcD5y6HST8uXHKuSVc6vh94yH3dkKID70ma+RbsCf
	6py3z7vMm7lXNxi5wJwH742NhN0NP+XGurZkPMIkPD9BxYMBy1dRZlDqhJNbjCYh
	5iM93OEFXWsBLHexd4tQ+PLnEyhzTG/XHWPEyveRApVtPct8oBY/T9f8OL04Q+xm
	MNvjkwWl6oLh+hq7EE2lr/GBgboGQIs/ReWQmHph7OYTWwSI+HRsqIjH7+/wunXf
	RwWL8QZADXkRoAoKITIBqoyqf7hn7P1Pzeg==
X-ME-Sender: <xms:swUCZB1rnweLZk35aHZiBgQWFd-oQS0q4y7Ma-f2gJ1tk6biV4p_Hg>
    <xme:swUCZIHFzqXPPzmmIzzZ8hbg8cu0hT6v9WDLAMa2qvNbZmz6_fgLUPXbYk3nsoO1S
    yzmgkFIx8dmUN1DofE>
X-ME-Received: <xmr:swUCZB5WyEYUImTMYsXup4NV2rGqlQ4CXRbFaXA3rvitzHJ1MtjSdfh1-yc7HfAJomfXhRJ-_TntgLzh0LWjcYD5iNeOtUs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelledgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtqhertddttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepiedtueffveeiueeftdduvdffffffgeffgfekiefhleelkedtlefhvefh
    udduhffgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgv
    tghh
X-ME-Proxy: <xmx:swUCZO0KN82qNQan-BTftrLDKnylngDMU3kB73-c4kbYIkWqmm5zEA>
    <xmx:swUCZEFZAKmu-VEfiiDvSkw-voCWXL5yTI1_bUG7e_svIUf71SL0Ww>
    <xmx:swUCZP8CKWwnn4NXwiUhJ2CvoZJcEA141NSgtQxxD3V1QOU_R9XBSw>
    <xmx:tAUCZK7yubatAcs36FTKgZwEIF0ZKZ47INAM8_nfsLoYZtA1K_JHFw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Mar 2023 09:35:30 -0500 (EST)
Date: Fri, 3 Mar 2023 15:35:28 +0100
From: Maxime Ripard <maxime@cerno.tech>
To: David Gow <davidgow@google.com>
Cc: Stephen Boyd <sboyd@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	patches@lists.linux.dev,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, linux-um@lists.infradead.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH 3/8] kunit: Add test managed platform_device/driver APIs
Message-ID: <20230303143528.2dovipmqlms74vp2@houat>
References: <20230302013822.1808711-1-sboyd@kernel.org>
 <20230302013822.1808711-4-sboyd@kernel.org>
 <CABVgOSmR0_u8Tw0E8C1mRFxSiGKwdKG5ka_+X_36Hj4VNLdg2g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CABVgOSmR0_u8Tw0E8C1mRFxSiGKwdKG5ka_+X_36Hj4VNLdg2g@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230303_063541_174715_6E90E6ED 
X-CRM114-Status: GOOD (  22.19  )
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

On Fri, Mar 03, 2023 at 03:15:31PM +0800, David Gow wrote:
> On Thu, 2 Mar 2023 at 09:38, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Introduce KUnit resource wrappers around platform_driver_register(),
> > platform_device_alloc(), and platform_device_add() so that test authors
> > can register platform drivers/devices from their tests and have the
> > drivers/devices automatically be unregistered when the test is done.
> >
> > This makes test setup code simpler when a platform driver or platform
> > device is needed. Add a few test cases at the same time to make sure the
> > APIs work as intended.
> >
> > Cc: Brendan Higgins <brendan.higgins@linux.dev>
> > Cc: David Gow <davidgow@google.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >
> > Should this be moved to drivers/base/ and called platform_kunit.c?
> > The include/kunit/platform_driver.h could also be
> > kunit/platform_device.h to match linux/platform_device.h if that is more
> > familiar.
> 
> DRM has a similar thing already (albeit with a root_device, which is
> more common with KUnit tests generally):
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/drm/drm_kunit_helpers.h
> 
> But that's reasonably drm-specific, so it makes sense that it lives
> with DRM stuff. platform_device is a bit more generic.

I'd be very happy to get something from the core to address the same
thing.

I think the main thing we needed that isn't covered by this patch is we
wanted the device to be bound to its driver, so with probe being called
before calling the test (see 57a84a97bbda).

Maxime

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
