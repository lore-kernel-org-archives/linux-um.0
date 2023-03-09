Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD8F1C64EC4
	for <linux-um@archiver.kernel.org>; Thu,  9 Mar 2023 23:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:Cc:From:Subject:References:
	In-Reply-To:MIME-Version:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Rf2FhpVtwQbgkrGdux9VnOg97VZRmt2hyec/b/snvVk=; b=uuXHzOpNeruzX6
	G2+JTyGnM2Pv91UvfIuAlL8lCwnepv3/T8G3LM1h2uQRA8zuTznVBOhaixPYnA9tiC6PABEzeHXg0
	7oy2lyHL/r3FmMyPtNpLOwx1HOqlGsUf2OWWHa/rKeQaY999AGV3O0o6pKJMKU6BeGSQeW68iloUY
	X7MZmaOJWJjd2YKyVUj/H5VfqrfX+AaUvYu5BMn2NqSPKbAPAIIA0sHGDR4jn1r+BSLGdXeaEQ1Pf
	Z54Sy0c6ttFh4d4/EW26GX7CQrRz4rty//8boKkNFgmXoGcjQd/9uteDhcSr8Idsf+dWsCIkvtb3v
	JW2NUog32hUAUnHUV2+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paPjE-00CLH3-RN; Thu, 09 Mar 2023 23:31:20 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paPjC-00CLGc-LU
	for linux-um@lists.infradead.org; Thu, 09 Mar 2023 23:31:20 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id EFCA561D20;
	Thu,  9 Mar 2023 23:31:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAACC433EF;
	Thu,  9 Mar 2023 23:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678404677;
	bh=XMIAuFTCpQukpN84ROT6/ts6CvHL1L9jkDiOtPUHxqg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=aB6+rxR9vvN8i7vqNPjuqyqyRpDmMYWpaEQYkCUUzn7hgI6slmXltotVW87pLPAaS
	 R/siBnKOm1dxwMeFEFYA2zjQr7hbbk459jZQXxHlfQC2PHCDUXLTaNddLcrCnp2xQM
	 wuYuSgHnkwV722udtWhO9NskDC9Udui9+fyZUL7fef8gyD/VfGRzdPfPk+AF9RKbhu
	 WCXHmnwcac3WdDU86szAdMTdoAMbl7gxNlwbxGTN/rgYvZvf4/tGwKytI/AzaKEbP3
	 1pzYdg/vm/uEzBFAiHB0sjh10QSveGGgsKX5HW/PqI8ZRrXazA3giR6Fzi4QqwsILS
	 4T1vyZoV0T28Q==
Message-ID: <dea61f59ea83c772b693b18db43c3eb7.sboyd@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230303143528.2dovipmqlms74vp2@houat>
References: <20230302013822.1808711-1-sboyd@kernel.org> <20230302013822.1808711-4-sboyd@kernel.org> <CABVgOSmR0_u8Tw0E8C1mRFxSiGKwdKG5ka_+X_36Hj4VNLdg2g@mail.gmail.com> <20230303143528.2dovipmqlms74vp2@houat>
Subject: Re: [PATCH 3/8] kunit: Add test managed platform_device/driver APIs
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, Brendan Higgins <brendan.higgins@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Vincent Whitchurch <vincent.whitchurch@axis.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, devicetree@vger.kernel.org, linux-um@lists.infradead.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
To: David Gow <davidgow@google.com>, Maxime Ripard <maxime@cerno.tech>
Date: Thu, 09 Mar 2023 15:31:15 -0800
User-Agent: alot/0.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230309_153118_764489_4C73AF0A 
X-CRM114-Status: GOOD (  18.94  )
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

Quoting Maxime Ripard (2023-03-03 06:35:28)
> On Fri, Mar 03, 2023 at 03:15:31PM +0800, David Gow wrote:
> > 
> > DRM has a similar thing already (albeit with a root_device, which is
> > more common with KUnit tests generally):
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/drm/drm_kunit_helpers.h
> > 
> > But that's reasonably drm-specific, so it makes sense that it lives
> > with DRM stuff. platform_device is a bit more generic.
> 
> I'd be very happy to get something from the core to address the same
> thing.
> 
> I think the main thing we needed that isn't covered by this patch is we
> wanted the device to be bound to its driver, so with probe being called
> before calling the test (see 57a84a97bbda).
> 

Can you clarify? This patch makes a poor attempt at waiting for the
platform driver to bind, but in reality it may not be bound by the time
the driver register function returns.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
