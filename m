Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56780C55167
	for <linux-um@archiver.kernel.org>; Thu, 30 Jul 2026 23:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xrsrA5hdxEbnY/PY6miFkgtDkZsZTMS1qxp1CY3BX8g=; b=TSkao4vpZOSUgO3z5mCzU4ReWE
	JgIIY1UXxUNs2anjE2+sZCHvZX0335fRWv9aP42HXaIMp1kXhymlehxglCNI3S0BqnrSR2cupXhnA
	DC+EImXY6cWPgFYiC/VAa6y8RsY0r1d0yfcGXtzPLxo3EnXA7UuP6C8IiN2X3twGua5bHtvF4j3ko
	Cgg1OTua4R3jxGaoA3TReebjrvIT4vY/4hP/hobNBHQsxkaZLTwT9BYb99dxhcG67kCVvigrtKoxM
	wfXan6DU9YgrPjWvRvJ/W8tPwgHMSWqj2gRd/6W8qY2wDo90/lWl0YQPMCxvybyctGYUDkXnHKD46
	Obv2pVIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpaTb-0000000BWLX-0Xbw;
	Thu, 30 Jul 2026 23:47:47 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpaTY-0000000BWLM-3Tc2
	for linux-um@lists.infradead.org;
	Thu, 30 Jul 2026 23:47:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 05C8043D7C;
	Thu, 30 Jul 2026 23:47:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9642F1F000E9;
	Thu, 30 Jul 2026 23:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785455263;
	bh=xrsrA5hdxEbnY/PY6miFkgtDkZsZTMS1qxp1CY3BX8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j5x42nHUUyiMogr8sLB2u9ZNYiotqMJ+M3F/nZEy8Xq2PuolTkw3FqmAvzLkIxJVd
	 lHg3hw9tOoNVWCNgLSCz6FLZaAwail6I4WikbcqJFnxZ4zi8alu6gUJCfh/U2AK92b
	 7GPnlHQM6AAciDE048HukSJnVKuV6DkRPmSHezpSEPV+OYeVfY6tel24cuf7y563+6
	 3ZO9ANYnDMJGCqYzy9T3dNq8AiMco2GwKmwDYcakuMUzZq5KMwk0neRO5nRipzyq7+
	 v6pFZunylM1y7cJWZtm9oGLVj+tyAjOSnldR5gcaLMEi0reFh+v7VYRyi4j+jW8BGW
	 9WxnWPId8u6dQ==
Date: Thu, 30 Jul 2026 23:47:42 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 4/8] lib/crypto: x86: Stop using cpu_has_xfeatures()
Message-ID: <20260730234742.GB2459987@google.com>
References: <20260728021603.79870-1-ebiggers@kernel.org>
 <20260728021603.79870-5-ebiggers@kernel.org>
 <20260730231944.GLamvcEBNkNIXjQt26@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730231944.GLamvcEBNkNIXjQt26@fat_crate.local>
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

On Thu, Jul 30, 2026 at 04:19:44PM -0700, Borislav Petkov wrote:
> On Mon, Jul 27, 2026 at 07:15:59PM -0700, Eric Biggers wrote:
> > Checking both boot_cpu_has() and cpu_has_xfeatures() has never really
> > been needed in practice, and it's never been universally done (e.g.,
> > lib/raid/ omits cpu_has_xfeatures()).  Nevertheless, both x86 and UML
> > now explicitly clear the AVX and AVX-512 flags if their xfeatures are
> > missing, which should remove any remaining doubts.
> > 
> > Thus, remove all the calls to cpu_has_xfeatures().
> > 
> > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > ---
> >  lib/crypto/x86/blake2s.h  | 4 +---
> >  lib/crypto/x86/chacha.h   | 3 +--
> >  lib/crypto/x86/nh.h       | 4 +---
> >  lib/crypto/x86/poly1305.h | 7 ++-----
> >  lib/crypto/x86/sha1.h     | 4 +---
> >  lib/crypto/x86/sha256.h   | 4 +---
> >  lib/crypto/x86/sha512.h   | 3 +--
> >  lib/crypto/x86/sm3.h      | 3 +--
> >  8 files changed, 9 insertions(+), 23 deletions(-)
> > 
> > diff --git a/lib/crypto/x86/blake2s.h b/lib/crypto/x86/blake2s.h
> > index f8eed6cb042e4..0f7c51f055c8f 100644
> > --- a/lib/crypto/x86/blake2s.h
> > +++ b/lib/crypto/x86/blake2s.h
> > @@ -55,8 +55,6 @@ static void blake2s_mod_init_arch(void)
> >  	if (boot_cpu_has(X86_FEATURE_AVX) &&
> >  	    boot_cpu_has(X86_FEATURE_AVX2) &&
> >  	    boot_cpu_has(X86_FEATURE_AVX512F) &&
> > -	    boot_cpu_has(X86_FEATURE_AVX512VL) &&
> > -	    cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM |
> > -			      XFEATURE_MASK_AVX512, NULL))
> > +	    boot_cpu_has(X86_FEATURE_AVX512VL))
> >  		static_branch_enable(&blake2s_use_avx512);
> >  }
> 
> You could add a patch at the end or I can do it which does
> 
> 	s/boot_cpu_has/cpu_feature_enabled/
> 
> as latter is the interface we use now everywhere.
> 
> But yeah, it should be a separate patch.

cpu_feature_enabled() turns into an alternative (code patching), which
doesn't make much sense in any of the places you're asking for it to be
used, as they just check the features once at module init time to toggle
static keys.

I suppose that the static keys that are conditional on only one CPU
feature can be replaced with cpu_feature_enabled(), which should be
equally efficient.  However, many of the keys are conditional on two or
more features.

After that, there would be a mix of both versions.  So sure, it could
make sense to use cpu_feature_enabled() everywhere anyway, even when not
helpful.  I'm not sure it's clearly better than the status quo, though.

- Eric

