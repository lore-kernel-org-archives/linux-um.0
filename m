Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F49C5CFDB
	for <linux-um@archiver.kernel.org>; Wed, 12 Aug 2026 19:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U+gt0iEPzsWX4i8iCLvPkbDr9lrluiFQAHkh4aUzvKU=; b=uFbKA+Jn7MjoOgb7PxGIpdufMz
	6rhaMPaZqBjLLxMMNHS5Pm/0VrNyr6WM/XTIGUqn1JZtbyP7seXV9csvJ5qhqkMyQ7PgskRj3x5uN
	704YCIMcEGWveqRtcZcVeqh0ISHzX/6CVpqGh4wUivq/H4ZoqYnYVaYq6J1TQEQUrbsybwhBoT01x
	D6OA/Nc/z+Emj9wmKEORjcOEhX8eRAwuA8zTTcP9hsUqIBQZCjMGHLj29llz0Q5j5QVF4RNPYi08v
	CAIV2B8uaLmtYWCNns7jW4PxIKwoRbKhJg3lrpXKkeFd8vqibHoYSlowzsOGLtisYZJ/0Hh3uJxQT
	4/2p0Ttg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuEoB-0000000Gubr-36a7;
	Wed, 12 Aug 2026 19:40:15 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuEo9-0000000GubR-2lrn
	for linux-um@lists.infradead.org;
	Wed, 12 Aug 2026 19:40:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1C41740BD9;
	Wed, 12 Aug 2026 19:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC92F1F000E9;
	Wed, 12 Aug 2026 19:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786563613;
	bh=U+gt0iEPzsWX4i8iCLvPkbDr9lrluiFQAHkh4aUzvKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=odicFeqEpKsz8g/dwV0mnxBfc2Ps4uIwbMfPegtg2t/bnoN4lZHMQWYjs5AjENrpl
	 26DljbHUx5OWFMOhADqP8s/FpnKz8oeNHbctv0Q+H2BZNs0kFhjBat+BEfNM7O3eR7
	 8SQD6x4bCBk4/eZUI2iC2SUArqfq+9KZ72P4Ua9q2WysFqRYFJHsyYNq7I7DEzC/D5
	 Uqz9oT2g8TLfnlVd3bBR8r/17CaVk8LfniMMITIvKrMbZcBXgbM0OGocx4NjlOjiTO
	 NlR7SOapNWkc/whazI+6JbZZoSBlACcMrKODJXZkMJVVgDV7ADa/X2fgzkag8amb7f
	 9rLG+rx/j9IzA==
Date: Wed, 12 Aug 2026 19:40:11 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/8] x86/fpu: Check for missing AVX and AVX-512 xstate
 bits
Message-ID: <20260812194011.GA3734410@google.com>
References: <20260728021603.79870-1-ebiggers@kernel.org>
 <20260728021603.79870-2-ebiggers@kernel.org>
 <20260728052727.GCamg9v5WxNieTMUwE@fat_crate.local>
 <20260728054532.GA99797@sol>
 <20260728182007.GBamjy17zynlWm2gQT@fat_crate.local>
 <20260728183447.GB3355536@google.com>
 <20260728225936.GBamk0WK38PByPFkxz@fat_crate.local>
 <20260728233430.GA3277@quark>
 <20260728234726.GCamk_jnl3LtfGbxoC@fat_crate.local>
 <20260812174826.GAanyx6vUWv5GLX2AZ@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812174826.GAanyx6vUWv5GLX2AZ@fat_crate.local>
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

On Wed, Aug 12, 2026 at 10:48:26AM -0700, Borislav Petkov wrote:
> On Tue, Jul 28, 2026 at 04:47:26PM -0700, Borislav Petkov wrote:
> > On Tue, Jul 28, 2026 at 04:34:30PM -0700, Eric Biggers wrote:
> > > I don't know what your suggestion is.  Are you still asking for the
> > > function to be renamed to clear_cpu_caps_xft()?  Note that the
> > > abbreviation "xft" doesn't appear anywhere else in arch/x86/.  Maybe you
> > > want the argument inverted?  I don't know what you want, sorry.
> > 
> > That's fine - I'll take a look at the final version after having gone through
> > the whole pile and then holler if I still see a need.
> 
> Ok, here's something ontop of yours. It is tested only in a guest but it
> should show the intention.
> 
> The first call in:
> 
> 	if (!boot_cpu_has(X86_FEATURE_FPU)) {
> 
> is not needed because that is caught earlier:
> 
> [    0.553199] x86/fpu: Giving up, no FPU found and no math emulation present
> 
> and we stop there.

Interesting, so the !boot_cpu_has(X86_FEATURE_FPU) check is dead code
since ab05214025ee ("x86/fpu: Remove MATH_EMULATION and related glue
code").  Sure, there's no need to add anything to there then, though we
should do a separate patch that removes it.

> The second one can then simply do:
> 
>                 /* Disable all dependent flags too */
>                 setup_clear_cpu_cap(X86_FEATURE_XSAVE);
> 
> because that'll clear all dependent flags and we should be good there:

Sure, that works.  I'm not sure it's actually easier to understand than
what I proposed; it's kind of contradictory to call
"setup_clear_cpu_cap(X86_FEATURE_XSAVE)" when we just verified it is
clear.  But the comment mentioning that it's actually for clearing
dependent flags helps.  If you prefer this way, let's do this.

> and then the rest is streamlined into fpu__init_system_xstate() where all
> sanity checking should be performed, as I mentioned intially.

It's functionally equivalent, but yes we can write it this way if you
prefer.  Is it okay if I fold your diff (minus the pr_info()) into this
patch?  (I'll also add FW_BUG to the error messages as Thomas
requested.)

- Eric

