Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43562C53219
	for <linux-um@archiver.kernel.org>; Tue, 28 Jul 2026 23:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GA8Cjue73khWU1u690hjOwBxhnZ4D3q3cW0aqZVFhvs=; b=LkkUmbO9fxp2KYt2T5ZZ0a96F5
	bmYyFIlVC/GWTinA05x3r6UlIYcmCOm+1e8n6OEeeksXKrn3c8lNZbNzXMTYsVGAXg0U4Xyg9btXL
	yUNKUlnNXlXgZsCpaynfvfvFcrumgKdIAJRF8ejm4ccLBiMuQHJJMQqKyxgeSyaaXaqS1gCLzSeLZ
	3JH/aYWMw0r9D4pMPplfKGZSDzKIWxq66YNALaaLVfF1/jtgkeRR5Pta2PMp1JRYa4F8/ejnJKAMh
	UuacHPh9vi4UGL9wDhGjTRlf0pWq/xYMJ/iSgG75JJpziZObgaq0jgAdxPP5owBpV8TWIYHwdabCd
	CjN+z3EA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woqmM-00000006STw-1ukO;
	Tue, 28 Jul 2026 23:00:06 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woqmJ-00000006SSr-0uur
	for linux-um@lists.infradead.org;
	Tue, 28 Jul 2026 23:00:05 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A370540E00E6;
	Tue, 28 Jul 2026 22:59:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lKnZIAl4nQYC; Tue, 28 Jul 2026 22:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1785279588; bh=GA8Cjue73khWU1u690hjOwBxhnZ4D3q3cW0aqZVFhvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J68eP7LlHrG6v5oSBozwc5EacTGjgi+lie1fEA9jsCVMEvaGTO6qy3kJaaVzAfWhB
	 0kp5n9quFUa2Kf1oOc6N/cQg5kMkfdwjzw6N9OpF36LqGrkkBWvxG6pG4UP641pGvB
	 zI7o8RdtzIrgOxnh4E06yg36Ik3zq/b51E3Wm0oQ4vfOKC13vi1jQM2QxV56ljHrCx
	 Dx+2cJr/k+TtabKWgZYf/s7PDOtbUjNk+A3rqPo8St6bE6SzPLIgg1RtJqQ1szXjKu
	 zUY7wHcD2TiI5ItcoWhRH81X0fgxCc6rKGvJ9gFYDMFgSSpJuC7W6hSQFOzvuLN6Op
	 nsqbr0AcT/lH+hXFYyzGI/jEZEUtRtAZDX3b84NF2wOAD6kDhvgKS9AItI3YnT4og7
	 QhTRnUoU+RfSKB9+835QuaP0Raj/+H7966Oo2yDibM/vJe45qviGg1RcWinT4JkriL
	 5M2a/8p0bGEPOlQC7C6Mkl6FnbKK/dqbpQmlbExkc8IajrYKfDpEFULNG2rAzRkfnu
	 y5hXJTy/vxDSFM/9WTHB+t/sDoCSrS2dzhEm5IFtW3rKXZ8BU4k8Dk9oVT3f0B0YH2
	 kHfZ04igC5y9tscEtVLRpeilRrBlIjRwsHQbpoqpgVNpp9RHWNpzH21/J0pBS3UddZ
	 7E0kg8Pzs2yO9H0kVQIfLKzs=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 079B140E00C3;
	Tue, 28 Jul 2026 22:59:39 +0000 (UTC)
Date: Tue, 28 Jul 2026 15:59:36 -0700
From: Borislav Petkov <bp@alien8.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: x86@kernel.org, linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/8] x86/fpu: Check for missing AVX and AVX-512 xstate
 bits
Message-ID: <20260728225936.GBamk0WK38PByPFkxz@fat_crate.local>
References: <20260728021603.79870-1-ebiggers@kernel.org>
 <20260728021603.79870-2-ebiggers@kernel.org>
 <20260728052727.GCamg9v5WxNieTMUwE@fat_crate.local>
 <20260728054532.GA99797@sol>
 <20260728182007.GBamjy17zynlWm2gQT@fat_crate.local>
 <20260728183447.GB3355536@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260728183447.GB3355536@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_160003_417610_ED87BA4A 
X-CRM114-Status: GOOD (  17.47  )
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

On Tue, Jul 28, 2026 at 06:34:47PM +0000, Eric Biggers wrote:
> The argument is the bitmask of xfeatures that are present.  0 is an
> empty bitmask, i.e. no xfeatures are present.

Ok, so what does that mean when you see it in the code:

	clear_cpu_caps_with_missing_xfeatures(0)

clear the CPU caps with missing xfeatures bitmask 0?

> I can rename it to xfeatures_present and/or document the argument
> explicitly in the function comment, if that would help.

I guess. I like the documentation aspect.

> I'm not sure what this question is asking, but UML indeed doesn't
> implement cpu_has_xfeatures().  Currently most of the AVX optimized code
> isn't enabled on UML, which avoids this limitation.  The RAID code is
> different though, as it's enabled on UML.

You brought up the UML example upthread. I'm trying to figure out why we care
about the UML case. I'm also assuming that case will be fixed with whatever we
end up doing here.

> First, the code being added *is* to fpu__init_system_xstate().  Do you
> think it needs to be moved later in the function, and if so why?

Lemme try again:

there where we sanity check the xfeatures mask, at that same place we can
sanity check the X86_FEATURE flags we have set in our internal representation
of CPUID flags. At exactly the same place. And we warn and clear the ones are
wrong.

> Second, clearing xfeatures is the opposite of what's needed.

I meant clearing X86_FEATURE flags. Basically what you started doing.

All I'm proposing is having the *whole* X86_FEATURE clearing concentrated in
a single function so that it is called once per CPU and then we're done.

That's it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

