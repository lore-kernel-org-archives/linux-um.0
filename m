Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6E0C5CFC1
	for <linux-um@archiver.kernel.org>; Fri, 14 Aug 2026 19:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KNy3zowlMT+tLsRA+SoZOmN7eNITguXwatnKmgFbVTI=; b=34anmDdKavEy/KMdIYAJynhPi5
	eTYUKnLisXsSidiMBvrrV0Hwp2b3ZQy3MxAjE92UukClIyzkqzrohqV46FRUccOjw/I8uUS/GysJV
	yRWbp4s5QWDozcuRAymLf6MDtod6GG+xEW84VIExWYy99znAVeRspGoJ6uC7c7hcubDCVgclPhK0v
	56DhozJ+2ESVSxX5+sQmGtq3j+s/77ZPXBilOAB1Ra2xQ6h3l40DcI5Y8pGYywSADEvd90F9ydHO/
	G5e3qoi232Vwfen7UWsf0LfrmjVxjdTcGy8gX2iqPgmJayay1hXVrVDP3AeZVxJnwxDvj1dLR9UiM
	nIkFSBKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuy47-000000037Vm-3vXo;
	Fri, 14 Aug 2026 19:59:43 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuy45-000000037Vg-3sbr
	for linux-um@lists.infradead.org;
	Fri, 14 Aug 2026 19:59:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5449044EBC;
	Fri, 14 Aug 2026 19:59:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6C91F000E9;
	Fri, 14 Aug 2026 19:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786737581;
	bh=KNy3zowlMT+tLsRA+SoZOmN7eNITguXwatnKmgFbVTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f41BHtEY9QWcfs5mZVZMBXQG7ERql2GZ+deFnkGy94qFdgOo6EW5gSKtcdYhvdHxo
	 kFsbsDPp98t3kdnJkqATSzHvwzyRzwtKuWyYcs2P1BM6CdMw4QaMpci49U+SD3X1BT
	 GbOUdGjxTbqva58+ptL2I06qvBJh/msKrGtS8qWqO3FWNbHaUJDdqdZEHi3h46T/pU
	 hFqZEQ4xFhi7A1+Y1kNphctSsCHFJ03DVDGgS14eXeEostHhOCORGHYMp8sE/HUBA0
	 9x5ZuaORj5TASD/rklHrOcdf99MY6HyBA2d01mKXVRZb0JtofGiOz15Es6adIeLWGX
	 tFk423eVKtN9g==
Date: Fri, 14 Aug 2026 19:59:39 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 0/8] x86: Remove cpu_has_xfeatures() and add AVX-512
 xor_gen()
Message-ID: <20260814195939.GB2644249@google.com>
References: <20260813021506.55129-1-ebiggers@kernel.org>
 <20260814003517.GBan5ixaTArd0Sf6X3@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814003517.GBan5ixaTArd0Sf6X3@fat_crate.local>
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

On Thu, Aug 13, 2026 at 05:35:17PM -0700, Borislav Petkov wrote:
> On Wed, Aug 12, 2026 at 07:14:58PM -0700, Eric Biggers wrote:
> > This series consolidates and cleans up how the kernel handles CPU
> > feature flags for AVX and AVX-512 when the underlying OS or hypervisor
> > (if any) doesn't enable the required xstate features in XCR0.
> > 
> > Specifically, it makes the checks for xstate features be done in a
> > single place at boot time for both UML and native x86, instead of
> > everywhere kernel code wants to check for AVX or AVX-512 support.
> > 
> > Patch 8 then adds an AVX-512 optimized implementation of xor_gen() for
> > RAID, which had been blocked on confusion around cpu_has_xfeatures() and
> > its lack of implementation on UML.
> 
> Sashiko complains about a missing VZEROUPPER there in patch 8:
> 
> https://sashiko.dev/#/patchset/20260813021506.55129-1-ebiggers%40kernel.org

Yeah, missing vzeroupper is a common mistake...  All the other code in
lib/raid/ that uses ymm and zmm registers misses it too.  I've fixed
various instances of this in the crypto code before, but no one ever
checked the RAID code.  I guess I'll send out a v4 that fixes patch 8,
and also separate patches that try to fix all the existing instances of
missing vzeroupper.  Besides lib/raid/, some also have slipped in in
arch/x86/crypto/aria-* and net/netfilter/nft_set_pipapo_avx2.c.

- Eric

