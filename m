Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C958C5DF66
	for <linux-um@archiver.kernel.org>; Fri, 14 Aug 2026 00:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s4whABqcvLZBqYt2AF3I5iHUkpSSVuAbE9B4+2NQSuA=; b=CVJAzEQAmMtBRXLl8+YYPjl7Kg
	f8f7DmWg2a4M0Y5IThbOOuGKSP0OqEjfP2JJ4guCwc2Nt1Fs/gt5ZuZDnG9/RY1CIxsJ7/S2uAS+r
	YL6yiHOZKxeMVr63FKMSPQZ+kEyz/v1nx2uu5mmlAw7iy/9tw3lO/dfAhsZok4F1lmAD5RDm0fHsh
	qGjE7LVjLwD+pmLJlIoy8laYzcI69U7VOd9Q3AhKqR7WXUnBOl0GqXAiJ1SfLguL/LmUyljaA4Zds
	etGJEEohXFVGnVmzDa11PPcvuXDQuja5cB5kz0WdOIi//4itKMrhMEtXj7BfkWU5DjVEF54MxqkQs
	7Tsj5JrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuftz-00000001lzO-38Vk;
	Fri, 14 Aug 2026 00:36:03 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuftv-00000001lyo-0CUL
	for linux-um@lists.infradead.org;
	Fri, 14 Aug 2026 00:36:01 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E94C640E0031;
	Fri, 14 Aug 2026 00:35:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NvIvzpUUnXDM; Fri, 14 Aug 2026 00:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1786667729; bh=s4whABqcvLZBqYt2AF3I5iHUkpSSVuAbE9B4+2NQSuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xt98E0gbcBvul2ZQZcLWwQ5acfXZXvWs4JojSzhUpv84WHQZqehIWYwBzvoCt+XhF
	 x8rv+eKtKf3PGy4bVy8gCblj6e9fbBZKBmJ7zYB4SwG+U0rXHcA8nHLHhgjOr/qkGl
	 O+Aa8rpN1H2eG6qYtF4ywR5A9yVeo+j1pXjhC192VHXwRwiRuTpvFwjJg/58v8tBlO
	 iDzULM6jjUiWjmqa6dHqLR6/2dx2ilDiIjEsuruPmkNtqG1gIaisUDbIK96zi9jk18
	 6Mvv2UZ9s+6EdFrxElmNWJxkDeo7Ahy9rscBF4pLiAJB3T/9+egdKY2WwE4/Pmkv9x
	 g6zEOPF8k4M3PxpKUkUytIMkHaTelhUQvuLUJk2sx3bVt6gT6RN/bB5nabISpvOjNP
	 A2GrB5ovG8wjRDcvx6CyZr9hhRJHTipVAT/PH7nulS2Jrf9WMsKscR5vD5ZuMUGxqE
	 AuRuBOgfVCo2s0zNKGAB1l7FC5yFjJ27C+dhsxuVpnPkS5dAHf+/Mg308F12aiuU9E
	 rKnP0uVpPoczg4NGe7NYhF38m3y/pD23F+RClGJTFdkAOEpkuUGGBO2x3jvvFiVjoj
	 RSIfYTqmyPvSc1lBXYCRjN1wZAaTs+CFuy+Icdi1onJug24Tf7p+2ORCGVHsw4+mak
	 we45huGjhTdaTDIzcdWWUfFI=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 44B5440E0171;
	Fri, 14 Aug 2026 00:35:21 +0000 (UTC)
Date: Thu, 13 Aug 2026 17:35:17 -0700
From: Borislav Petkov <bp@alien8.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: x86@kernel.org, linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 0/8] x86: Remove cpu_has_xfeatures() and add AVX-512
 xor_gen()
Message-ID: <20260814003517.GBan5ixaTArd0Sf6X3@fat_crate.local>
References: <20260813021506.55129-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260813021506.55129-1-ebiggers@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260813_173559_269536_7C2F25BA 
X-CRM114-Status: GOOD (  12.67  )
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

On Wed, Aug 12, 2026 at 07:14:58PM -0700, Eric Biggers wrote:
> This series consolidates and cleans up how the kernel handles CPU
> feature flags for AVX and AVX-512 when the underlying OS or hypervisor
> (if any) doesn't enable the required xstate features in XCR0.
> 
> Specifically, it makes the checks for xstate features be done in a
> single place at boot time for both UML and native x86, instead of
> everywhere kernel code wants to check for AVX or AVX-512 support.
> 
> Patch 8 then adds an AVX-512 optimized implementation of xor_gen() for
> RAID, which had been blocked on confusion around cpu_has_xfeatures() and
> its lack of implementation on UML.

Sashiko complains about a missing VZEROUPPER there in patch 8:

https://sashiko.dev/#/patchset/20260813021506.55129-1-ebiggers%40kernel.org

Otherwise, LGTM.

I can queue them all into tip after the merge window opens.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

