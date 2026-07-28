Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4838EC53219
	for <linux-um@archiver.kernel.org>; Tue, 28 Jul 2026 23:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7Rf8r0g+YlfII72vupDIEDYAxSFoTywGzyQaBsA2xuc=; b=LEAVmvqENnW7R1UrXcOF8T4veL
	oXpg11jPl5XUl9tkVoHBjcNJbw3kZCIuW6eZz1cgUsOlpk5mqlLxMBj4K4DWzALoE20D0qGfX/PDS
	LQiD+987J3bH5OtKblylFovfIeGSh42K6rcmkYkb+pQ8HQASALLZts9KxldkmLc58f9dJm1AYuO7T
	zHEJsjtQEMlLI96+Grxzi3E4fqMPg37VKAWa4J/BSlbQdNeTzKGDq2xPpDi7o+QDA3K3gy8RXVDA+
	2ZEePUggek59jVSBoBtj6D8LtfUJ1bdz/7j6frDju2lTS+Xs9msJjUtuhbZgXJkBYzaOAjUA72Uz0
	V37AmHlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1worPR-00000006Uf4-3FH8;
	Tue, 28 Jul 2026 23:40:29 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1worPQ-00000006Ueu-1ENG
	for linux-um@lists.infradead.org;
	Tue, 28 Jul 2026 23:40:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 64EC160A66;
	Tue, 28 Jul 2026 23:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BC21F000E9;
	Tue, 28 Jul 2026 23:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785282027;
	bh=7Rf8r0g+YlfII72vupDIEDYAxSFoTywGzyQaBsA2xuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OfFsplAdU70PzXIlVdB0Es0e0zUjLgTMe8cWC98F+PBq7CLjij+Vx4rfhjM7IdRM6
	 /xzGeQTnzeunHj3LNDV9/ORKghm9DzEkAWDd5t4UpZ3lMbg8ZU0Nij3OdRXqG+ZJ6C
	 N9eW4mWM0zZBfomBhDhfghGKh20i0aHqZazmCcoXjzjM6pYoSHz1zaUV2OsM0CgBQS
	 74myIJiY+C6Lk6ppdVbBESRLFNs9GM85MV6zttNl8EC1f2vgu7KxoT7i0hCBL5rcUG
	 6SWMxaCpIUMibtroSoUxaycBDOanVMc8/pj2D2NiApLnm2BZk4yIo6q1wGWku7pn/a
	 je+c9fA9YcsOw==
Date: Tue, 28 Jul 2026 16:40:25 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: x86@kernel.org, linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 3/8] crypto: x86 - Stop using cpu_has_xfeatures()
Message-ID: <20260728234025.GB3277@quark>
References: <20260728021603.79870-1-ebiggers@kernel.org>
 <20260728021603.79870-4-ebiggers@kernel.org>
 <20260728103018.00938ac6@pumpkin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728103018.00938ac6@pumpkin>
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

On Tue, Jul 28, 2026 at 10:30:18AM +0100, David Laight wrote:
> On Mon, 27 Jul 2026 19:15:58 -0700
> Eric Biggers <ebiggers@kernel.org> wrote:
> 
> > Checking both boot_cpu_has(X86_FEATURE_AVX*) and cpu_has_xfeatures() has
> > never really been needed in practice, and it's never been universally
> > done (e.g., lib/raid/ omits cpu_has_xfeatures()).  Nevertheless, both
> > x86 and UML now explicitly clear the AVX and AVX-512 flags if their
> > xfeatures are missing, which should remove any remaining doubts.
> > 
> > Thus, remove all the calls to cpu_has_xfeatures(), as well as the
> > related checks of boot_cpu_has(X86_FEATURE_OSXSAVE).
> > 
> > In a few cases there was no corresponding boot_cpu_has(X86_FEATURE_AVX*)
> > check, so add the missing ones.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > ---
> ...
> > --- a/arch/x86/crypto/aria_gfni_avx512_glue.c
> > +++ b/arch/x86/crypto/aria_gfni_avx512_glue.c
> > @@ -196,24 +196,15 @@ static struct skcipher_alg aria_algs[] = {
> >  
> >  static int __init aria_avx512_init(void)
> >  {
> > -	const char *feature_name;
> > -
> >  	if (!boot_cpu_has(X86_FEATURE_AVX) ||
> >  	    !boot_cpu_has(X86_FEATURE_AVX2) ||
> 
> Doesn't AVX2 require AVX support?
> 
> >  	    !boot_cpu_has(X86_FEATURE_AVX512F) ||
> >  	    !boot_cpu_has(X86_FEATURE_AVX512VL) ||
> 
> And (less sure) AVX512xxx require AVX2?
> 
> So the extra checks could be reduced.

Yes, but this patch is just intended to clean up the xfeatures and
OSXSAVE checks.  Further cleanups would be separate patches.

- Eric

