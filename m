Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5E2103E2EA
	for <linux-um@archiver.kernel.org>; Wed, 11 Mar 2026 22:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RikSZ/qDz/BbXcsdorYocnARDwttAwV1n5wEGZVbyw4=; b=sJVsr/Zawhq1up6a/2KL5j7igp
	sT3HxHUXE7EKNm6HSkJgHwt62FMRuuqWPVotwoVOmhleKG5qoheIHXh5Sf43i9lEy4rlqsgQMls4y
	2c2kPgcnofs0uP0P/ZyQd49BbG4ONkTLUXchAC/kmWAlkqmYXF6EvGXW+fMYLldNzCSXoNLUobsDM
	widkeLfDZ8PPMtrMHu7Hk8L7SZKFIAjmglXx4mrSWIqc4Fqj1T7/22NzHrfN+Gu/6WNHsCj72YO37
	MM5WaHx16vj4IqAZ6z6AcxGo9O/MzKldDRqm/x1+NI59wVcw6YEG9wwo5XxIZw516ylel/WQ3qyOd
	O3fcW6lA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0S3o-0000000Cfyc-0ppt;
	Wed, 11 Mar 2026 22:29:48 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0S3m-0000000Cfxx-2Wnk;
	Wed, 11 Mar 2026 22:29:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 09C1160137;
	Wed, 11 Mar 2026 22:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE76C4CEF7;
	Wed, 11 Mar 2026 22:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773268184;
	bh=FgOgwczmQ2Bn8aQ6V7k6mV2cKfvqhgutLP2bKVPQV1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XVPRVNpvrEBCZfWDW7blZ/upwHpfW8r44adFDbQ9bqeAbE8tC29oaEaQ8vjeQ+tPU
	 mARZBZJPJk6kFf9lwAhvGI5tLCuVe7+kxaw2+PA6JC27+0GnVdnSnTLyyUBGR4Znih
	 Lefvu2tkgKCMq9MOzDesAIoaw9j5jxb0bMeShkfuCzECCfCa7va+9Rr9WWMzBI4sLU
	 yaVBgR/l4aivWBLEYBYBUfr1ZDHxJqaH8qoXXfscfY8+2H/qsRA/Z+s3gZNwp/2o4c
	 9dpn+BpceXOQVRRjDdqUqLKCA1GjUs5fm7wevN7gzXqGXlu5b/ClrM3m7JL3NeMrNJ
	 XLRZxZaMD4nlg==
Date: Wed, 11 Mar 2026 15:29:35 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
	Li Nan <linan122@huawei.com>, Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [PATCH 26/27] random: factor out a __limit_random_u32_below
 helper
Message-ID: <20260311222935.GA3161@quark>
References: <20260311070416.972667-1-hch@lst.de>
 <20260311070416.972667-27-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311070416.972667-27-hch@lst.de>
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

On Wed, Mar 11, 2026 at 08:03:58AM +0100, Christoph Hellwig wrote:
> Factor out the guts of __get_random_u32_below into a new helper,
> so that callers with their own prng state can reuse this code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I think I'd prefer that the test just uses the mod operation instead,
like many of the existing tests do:

    prandom_u32_state(&rng) % ceil

Yes, when ceil isn't a power of 2 the result isn't uniformly
distributed.  But that's perfectly fine for these tests, especially with
the values of ceil being used being far smaller than U32_MAX.

There's been an effort to keep the cryptographic random number generator
(drivers/char/random.c and include/linux/random.h) separate from the
non-cryptographic random number generator (lib/random32.c and
include/linux/prandom.h).  This patch feels like it's going in a
slightly wrong direction, where random.c gains a function that's used
with both cryptographic and non-cryptographic random numbers.

And if someone actually needs a fully unform distribution, then they'd
probably want cryptographic random numbers as well.

So I'm not sure the proposed combination of "fully uniform
non-cryptographic random numbers" makes much sense.

Plus the '% ceil' implementation is much easier to understand.

- Eric

