Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A75FEFB6F
	for <linux-um@archiver.kernel.org>; Fri, 27 Feb 2026 23:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OapKvdiEwQYu8NOR3j/Rtm7Hb+46RUg9fRdsdH5rsws=; b=Hlt7bisJK3Bb06T9xC2rM7altr
	WmmBQbeb1RLpQfX7+jeT37Vo2DF1vGdcHYS87AbvRq6+l82GyNI2SXdlYg4VSJNcO11mrYQWIMecU
	1zLbJx1tGBF/P85F1ixbze6BdPAzw5mqATpgDeCv8woE+DCAIdOX5/OMH4kt47pb6i5g0xoShpx3c
	8LDnAB6lMu+3frlLrIcflGMP/Rp38lGE+8fNPMDM5FBZ4KPKbtx7I2EtDwdarGlc9qp3CLTssvCSh
	NqqFPBBHbccbD+B4w3lWVaVLo74eVLzlarDKvJM2U9MQOPO0foOwVXmBk4nJmB+C1HwwBcfeqjeXM
	6O/bED0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw7gG-00000009Hpx-0oQP;
	Fri, 27 Feb 2026 23:55:36 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw7gE-00000009HpL-0nQL;
	Fri, 27 Feb 2026 23:55:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9859C6111B;
	Fri, 27 Feb 2026 23:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97119C116C6;
	Fri, 27 Feb 2026 23:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772236532;
	bh=9epsKT1Tqv7365SBQ+LgdgBkS+QLvJq0YDfqzGCQppg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XVTF8TDa48poxgWx9OMrHOWcWeX+DIvF8W0Cz9PzVZzIIYVyeCBp8CVqVCQqnKv6k
	 5zzYRJst/PHEWqq92j85maQBi7plq+GNVhfHcc+9Pog+YMNqi1zTL7+4Ehtq9UJ7o9
	 QJHa0cD62wS9Zi36AMnb9/VkZXXyv/qc0FNC/OF8hsDCWgrlGfX7gqqn/VNAfN6Fee
	 CkNTC4E/BHSyzLgTwiN6IqzHfjJo9okaT9JcgxYGTsEHUQc31er3WUHfK/2Gx865yY
	 ogRz41c7RbSVwCM0hpH/O2zyx2nKKDpUW5eh/FdyMQPRe2Q68ih/qS1f7bbUEX5IYc
	 3kMoxNtkaet5g==
Date: Fri, 27 Feb 2026 15:55:29 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
	Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>,
	Li Nan <linan122@huawei.com>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [PATCH 18/25] x86: move the XOR code to lib/raid/
Message-ID: <20260227235529.GA31321@quark>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-19-hch@lst.de>
 <20260227143016.GH1282955@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227143016.GH1282955@noisy.programming.kicks-ass.net>
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

On Fri, Feb 27, 2026 at 03:30:16PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 26, 2026 at 07:10:30AM -0800, Christoph Hellwig wrote:
> > Move the optimized XOR code out of line into lib/raid.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  arch/x86/include/asm/xor.h                    | 518 ++----------------
> >  arch/x86/include/asm/xor_64.h                 |  32 --
> >  lib/raid/xor/Makefile                         |   8 +
> >  .../xor_avx.h => lib/raid/xor/x86/xor-avx.c   |  14 +-
> >  .../xor_32.h => lib/raid/xor/x86/xor-mmx.c    |  60 +-
> >  lib/raid/xor/x86/xor-sse.c                    | 476 ++++++++++++++++
> 
> I gotta ask, why lib/raid/xor/$arch/ instead of something like
> arch/$arch/lib/xor ?

Similar to lib/crypto/ and lib/crc/, it allows the translation units
(either .c or .S files) containing architecture-optimized XOR code to be
included directly in the xor.ko module, where they should be.

Previously, these were always built into the core kernel even if
XOR_BLOCKS was 'n' or 'm', or they were built into a separate module
xor-neon.ko which xor.ko depended on.  So either the code was included
unnecessarily, or there was an extra module.

Technically we could instead have the lib makefile compile stuff in
arch/, but that would be unusual.  It's much cleaner to have the
directory structure match the build system.

If we made this code always built-in, like memcpy(), then we could put
it anywhere.  But (like many of the crypto and CRC algorithms) many
kernels don't need this code, and even if they do it may be needed only
by 'm' code.  So it makes sense to support tristate.

- Eric

