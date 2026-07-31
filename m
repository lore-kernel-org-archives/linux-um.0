Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FE5C54F54
	for <linux-um@archiver.kernel.org>; Fri, 31 Jul 2026 04:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hCLoVsnUPhjp19VpF9y6ZtQmmiA8lZG/ujd0igS9H+w=; b=Af0Bk6ppDn3qazr2IVKABRd3LH
	JLWdhKrO1tFPPLHukFcXM5RLN/NjrYnB6MqOuDBLeCgE4P2a9jmEBRyTxuDQNgjbryA1CFdwzedUf
	Jqk+pBzmSYrv1EXxLhuup7FS+dUUmbxbcdNnglflrOvTVtjxZp4sLwCuyu2ctvXTE+oNNxsRprxOj
	ftCXwPQML9w85hkfRSEtVopVwGMEKWTOzoj0yjCfmR4Gv3uY1kpfCXyaPeVogd3ubx2FadmvHWlMh
	P7Wr3tdZ9/u6IRFdp3l3mhVRtDg+GsKqZb+8TFIoqObufU1b8qowO5OAqvSaKxZgOiAC6epjyl0v3
	Nml1cAVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpepQ-0000000Bjsh-05Aw;
	Fri, 31 Jul 2026 04:26:36 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpepM-0000000BjsK-0IPQ
	for linux-um@lists.infradead.org;
	Fri, 31 Jul 2026 04:26:34 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4C4DA40E0140;
	Fri, 31 Jul 2026 04:26:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5cb-p_dWtpMB; Fri, 31 Jul 2026 04:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1785471976; bh=hCLoVsnUPhjp19VpF9y6ZtQmmiA8lZG/ujd0igS9H+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YdHAlaXkCQVaaMMlwD7b8axkKFYAhg+v5bSykHNwltIobbg6PcfIKpkuQIp2OFLCb
	 VVHyijh9l29mqNyB6IxxZb16T+UdsGePK85JElKnIz36b5JIL6fJjEhhTNWTYHDEG4
	 6HQkXcdmGvRNtn81ETBxZ+qBN5wGR/y6yN08Tah4NifOeG6qDWZXcjOeenaZcGwldr
	 JWvzJBwpSB9n5iWL9zgPto8uDo/EiJzRpUFudwUy4lp1wU1iZWaj7WoDOJ5KbmQ3kd
	 9kr2VLBdtqGDlle2co6m36ZdkL8iJxjiw/uYN9UclRstRS8gSfvOKOo3e52NYADEwM
	 tixI6veVVNMnpNyTROTf6ZDlNDO8/y6B38MUFKluV0KLt5G4jfJn7854TdOmiZ5SCC
	 QDy4N7kxxzQBgvY3bGfMZVLfKp/NG4DE6XWrtAPK9kJNqHAbzNLyJnawtjzBCGIEX9
	 s7j8DlaRHZmleuM3Gaclph6Apvu+abTitcfplCwF8AtQp52F5F+Qk9S6oW/zSETkJ9
	 bjcw68/GfKGQINwv3w5REjW2vErdXqwto5j1mHGhqQIU5E3Bkt1YxbCuXYNsVC5Qf7
	 uFcLmMoRH3k8ciwxP8ksG/C+5P+0kr0cGDdKSLotMVI6mlALWdS2Gct+B8jkgX1wux
	 iUnFL+1SGcn4ITEWYEpTnqzk=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C45E240E00B8;
	Fri, 31 Jul 2026 04:26:07 +0000 (UTC)
Date: Thu, 30 Jul 2026 21:26:03 -0700
From: Borislav Petkov <bp@alien8.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: x86@kernel.org, linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 4/8] lib/crypto: x86: Stop using cpu_has_xfeatures()
Message-ID: <20260731042603.GOamwj2xjDHtpFfL9u@fat_crate.local>
References: <20260728021603.79870-1-ebiggers@kernel.org>
 <20260728021603.79870-5-ebiggers@kernel.org>
 <20260730231944.GLamvcEBNkNIXjQt26@fat_crate.local>
 <20260730234742.GB2459987@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260730234742.GB2459987@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_212632_286910_BFCEF75B 
X-CRM114-Status: GOOD (  14.64  )
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

On Thu, Jul 30, 2026 at 11:47:42PM +0000, Eric Biggers wrote:
> cpu_feature_enabled() turns into an alternative (code patching), which
> doesn't make much sense in any of the places you're asking for it to be
> used,

It is the interface to use for checking X86_FEATURE flags. The fact that it
alternative-patches doesn't really matter.

> I suppose that the static keys that are conditional on only one CPU
> feature can be replaced with cpu_feature_enabled(), which should be
> equally efficient.  However, many of the keys are conditional on two or
> more features.

Yes, they all can be converted to cpu_feature_enabled(). Just forget the
efficiency angle and think of this as us unifying the interfaces to a single
one instead of the zoo we have right now.

> After that, there would be a mix of both versions.  So sure, it could
> make sense to use cpu_feature_enabled() everywhere anyway,

Yap, that's the goal.

> I'm not sure it's clearly better than the status quo, though.

Yes, it is. See above.

Once everything is converted, there will be a single cpu_feature_enabled() and
all users will not care whether to use boot_cpu_has(), this_cpu_has(),
cpu_has(c, ...), static_cpu_has() and so on.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

