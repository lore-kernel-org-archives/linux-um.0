Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE3EC54F4C
	for <linux-um@archiver.kernel.org>; Tue, 28 Jul 2026 05:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/WvQzs9YepCJcng+hHY8F+2scwCSw2dfE4FzGWyO5dg=; b=qiQ9+uWvmiHXT0ss+tzylZZgdf
	GTGyjx+hM8RbvqBE3Sdy5o11vsSxo40Mx+PdUV+m4pxXOBOgwnqyovpddaoZbPW9liwvL1a958WBO
	MXlOIVBzj0G4VQY0iLqeurDk5+mlO/ZDTGGdIvxk50IYsPY0B5Xu97Dfn21vYaE0o1Fwx4mAm6GOF
	/eMsp9/ygw9Bbif3GpWymXZSbVpmScD6zLibDdrILvlD2len5fZj+zrVcd83KvR4gJqz3QhFHcmUq
	8kaFDyt4U0sYseaclJHQaoz1LEUBGIglwuDCcvW4kpjFdOPeT5D1vZZ28WtCjTgMVj+Xkp1HUzgR4
	ubTQcUyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woaf5-00000004UYR-1T4w;
	Tue, 28 Jul 2026 05:47:31 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woaf3-00000004UYL-2wPv
	for linux-um@lists.infradead.org;
	Tue, 28 Jul 2026 05:47:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 60F096013A;
	Tue, 28 Jul 2026 05:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEEF31F000E9;
	Tue, 28 Jul 2026 05:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785217647;
	bh=/WvQzs9YepCJcng+hHY8F+2scwCSw2dfE4FzGWyO5dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J/wFEFj+O0iRwvaDbNvQ5HxxU5s7m3c1yqItx22/2mL56DTnTev0+GIpWnab3sNzA
	 phXBUloWblfcosZe357mj2tNsXZzwvHHpeaOyq1I9kEoCPua2xTzz1AMCG5bfOlWm4
	 7o95g3wZ615OORPKnPnuBjMR1/TL2rekOe+BtYMzzPZgbtPtkpw2U95cMwHFnt+1zT
	 9nJ9X1/2/zq8EPe1MdOGRCOnnnXqQyJ+sFO3HL94K+iIj3PqZM0ukmKhcOKq9mVR5p
	 +HVUaYWCfTEzBwbwVpnJreQany677gtBW5mPk8Xr9YjFLKI8BExrKcqIAPtJbYyQs1
	 0q5dIWiM9BRrg==
Date: Mon, 27 Jul 2026 22:45:32 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/8] x86/fpu: Check for missing AVX and AVX-512 xstate
 bits
Message-ID: <20260728054532.GA99797@sol>
References: <20260728021603.79870-1-ebiggers@kernel.org>
 <20260728021603.79870-2-ebiggers@kernel.org>
 <20260728052727.GCamg9v5WxNieTMUwE@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728052727.GCamg9v5WxNieTMUwE@fat_crate.local>
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

On Mon, Jul 27, 2026 at 10:27:27PM -0700, Borislav Petkov wrote:
> > @@ -812,12 +829,14 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
> >  
> >  	if (!boot_cpu_has(X86_FEATURE_FPU)) {
> >  		pr_info("x86/fpu: No FPU detected\n");
> > +		clear_cpu_caps_with_missing_xfeatures(0);
> >  		return;
> >  	}
> >  
> >  	if (!boot_cpu_has(X86_FEATURE_XSAVE)) {
> >  		pr_info("x86/fpu: x87 FPU will use %s\n",
> >  			boot_cpu_has(X86_FEATURE_FXSR) ? "FXSAVE" : "FSAVE");
> > +		clear_cpu_caps_with_missing_xfeatures(0);
> 
> Also, I'm not really clear on the usage here: if the CPU doesn't have FPU or
> XSAVE, we pass in xfeature 0 which is XFEATURE_FP in both cases. And then we
> clear AVX and AVX-512.
> 
> The 0 is basically forcing the checks in the function to match, i.e., it looks
> to me like we're defining a new interface but then we're misusing it so that
> those basic CPU flags are cleared.

*xfeatures* 0, not *xfeature* 0.  It's a bitmask.

> What are we even protecting against here?
> 
> AVX and AVX-512 code needs to check whether it has FPU and XSAVE support?
> 
> I.e., we're protecting against some weird guests?
> 
> I wanna say, we should not protect but let them crash'n'burn in big big flames
> which can be seen from a mile away.
> 
> Or do you have a sensible use case in mind which we really wanna protect
> against and this all actually makes sense?

Hypervisors that set AVX CPUID bits without their prerequisite
xfeatures.  Or the host OS, in the case of the UML patch.

There are about 25 sites where kernel code is checking for this.  This
is just checking it at the architectural level instead.

We could try taking the position that this is not supported at all and
just delete all the cpu_has_xfeatures() checks without replacing them
with anything, and see what bug reports we receive (other than all the
AI ones which we'd need to just ignore).  This would mean just taking
patches 3-8.  Is that what you'd prefer?

- Eric

