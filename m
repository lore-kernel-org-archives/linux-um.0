Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56293C53219
	for <linux-um@archiver.kernel.org>; Tue, 28 Jul 2026 23:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rSZ4EZdIcRdfM0sSFblZMIqtReqX+mJVV6LvsiMMjS4=; b=xiZsDTZpjE8/twwlkBpYOJ63yN
	nvRuKquLFYieHr3Jj5bVTi6/JjBAEUQ9cK3L4YVosh7L9H2z0sJjmtOqCONwUENBwfmBcEYVTD/OS
	+5Jjm+kFRFE7iKWSZrDzYV2T1jboZ5JJvP4STsAN20JMyHb6MNM4zK0m/0Iuja5LED2D4kxVYgYQt
	8Ai+Ed2HFwWC6Hsyvs6kvxAeYGPEr4EgEfLlHp7HPDRAuK6CLtWdkG4mxWntaQ52uyL1ZWLOq2tYL
	B+1CfaCKMhmq5MzgEdYkCn/uiHG1SgB3IIOsdR1Ri3mUmdG3PneAoxEr9+E9xK5siBuoy75JZQvGd
	s6shWsEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1worWf-00000006UrV-1eP8;
	Tue, 28 Jul 2026 23:47:57 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1worWc-00000006Ur7-2i0K
	for linux-um@lists.infradead.org;
	Tue, 28 Jul 2026 23:47:56 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9780640E00E6;
	Tue, 28 Jul 2026 23:47:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id N2YSIUGj4ISB; Tue, 28 Jul 2026 23:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1785282458; bh=rSZ4EZdIcRdfM0sSFblZMIqtReqX+mJVV6LvsiMMjS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GK4kPxgXotMXlZPW3zhJC8bWtnAYYkkC2uUIW+/hRRmuhtZBn6CT8Tvz4znYANNkG
	 jE5WfzpwSZ8v6c1vErnMGlDIBkyavfRuQuXpdzvoCVmMzwJrDCcL1oDt2EgNDaJjFm
	 XvM2kw3BGJY6nvI27gbrFE0Siiv//xwgd/Hctr5k+L11c3DzJk+zMOqkE9034uq89A
	 Csx3l+1TG7L2j+iITJTpyJiE+y9cfym85bo/LzX4aihWwK8p32I+GTkDxxg5KibrT9
	 rwK7BCUUxZS7X52mxecaD5wC5G4on9hnH03O7u08DfEd07NHOv7Pcw9nhyLgAd39T6
	 D/skCRPQBHoJnKUYtyV6GbwWLR4Wi0jYWZ7MhNXR+gxNuVKzUxl+7sr+duTyT857Lo
	 qfJI9RwcUFCUIoEbIcXK8efw3vxco18z5MueueLNwvvPPYVEjkNfWmfs1EZ9+UsFpq
	 q1fWkuhKUIV2gs2iqmk/AtMGlAnkwLQ//Bw6KEfk6Gyr94DCO/ZFa4tIZDFaJRNypW
	 gJ1hPX6QmspD/fSxdzEKdIudCXxi8M0u8LleX4lkDWl5Xe8PbYfsR7miMnX5SzHE2q
	 kusZ2PRApVBzmQRfCOiU8fP5JsfSLY2iRPMOOYj5xpEl9YLYh54TaxvgHNy/grUh16
	 chKGhaBOMb3iuONHN55P2fKM=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 18C8B40E00C3;
	Tue, 28 Jul 2026 23:47:29 +0000 (UTC)
Date: Tue, 28 Jul 2026 16:47:26 -0700
From: Borislav Petkov <bp@alien8.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: x86@kernel.org, linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/8] x86/fpu: Check for missing AVX and AVX-512 xstate
 bits
Message-ID: <20260728234726.GCamk_jnl3LtfGbxoC@fat_crate.local>
References: <20260728021603.79870-1-ebiggers@kernel.org>
 <20260728021603.79870-2-ebiggers@kernel.org>
 <20260728052727.GCamg9v5WxNieTMUwE@fat_crate.local>
 <20260728054532.GA99797@sol>
 <20260728182007.GBamjy17zynlWm2gQT@fat_crate.local>
 <20260728183447.GB3355536@google.com>
 <20260728225936.GBamk0WK38PByPFkxz@fat_crate.local>
 <20260728233430.GA3277@quark>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260728233430.GA3277@quark>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_164754_846561_CA622B36 
X-CRM114-Status: GOOD (  15.41  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Tue, Jul 28, 2026 at 04:34:30PM -0700, Eric Biggers wrote:
> I don't know what your suggestion is.  Are you still asking for the
> function to be renamed to clear_cpu_caps_xft()?  Note that the
> abbreviation "xft" doesn't appear anywhere else in arch/x86/.  Maybe you
> want the argument inverted?  I don't know what you want, sorry.

That's fine - I'll take a look at the final version after having gone through
the whole pile and then holler if I still see a need.

> The UML update is in this series.  See patch 2.  Maybe you don't care
> about UML but many people do.  kunit.py uses it by default, for example.

So I've heard.

> fpu__init_system_xstate() is already a function called once on the boot
> CPU.  Is your suggestion that the feature clearing should be once per
> CPU instead of just on the boot CPU?

Yes, we need it to run on every CPU if we're going to enforce the same
xfeatures and CPUID bits configuration everywhere.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

