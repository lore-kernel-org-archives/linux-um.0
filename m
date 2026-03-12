Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECBE105A59F
	for <linux-um@archiver.kernel.org>; Thu, 12 Mar 2026 13:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l8xdTzfmFI9blWnX69yppRL0CTG4tWAVHoV5RzxnJ4M=; b=PmbhtytWngpCKzbg+9vZWdlqW7
	w25KHJzOUREc8SIRF82oduOMoSaqG6lwr/yjFi7hGuToMwizFvOWk2NKz+Le66D6AdhS+AIQ90bYb
	Kh+ilkD9wrdRBZc3xdXWYLv/fkoqb9xGUkIKzbhgIQaKZrnEnc0Su6SrpsqVETsb0yId2V6qBO8pY
	g6qSQDlCLwHKjjpgYefjV9mFATN2WaYcrGg5S0aWxmpwk/7GAlFj7JgExoBnaonbkatzD37b9MvM2
	0+Ju9F3goGYGf7ZkaJxrYXdRh8+bsBZRvVAB57L4GGiadWW1Rt2SasCe0EEQ6dea4LY6axBcOq45x
	dGU/yhiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0gNL-0000000E9bv-0x2V;
	Thu, 12 Mar 2026 13:46:55 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0gNI-0000000E9bU-3dXi;
	Thu, 12 Mar 2026 13:46:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0023060145;
	Thu, 12 Mar 2026 13:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0435C4CEF7;
	Thu, 12 Mar 2026 13:46:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="aNowo7eU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1773323205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l8xdTzfmFI9blWnX69yppRL0CTG4tWAVHoV5RzxnJ4M=;
	b=aNowo7eUwaDEsiVlTqmEAkItMBfiAqnQpwNdW5+Iir3vEvTnk82QibP2d05ImlF0a165mh
	nmvWlvpeFzo1/3YJJgy9A68B3kA75iz0ORvDTg44s5evgsV+Q5arPoARsc9Mpj0kc03vTo
	y0krEtMS6grTzTv7HePJJwYz8b+7S/w=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d18605ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Mar 2026 13:46:44 +0000 (UTC)
Date: Thu, 12 Mar 2026 14:46:39 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
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
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org, linux-crypto@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-raid@vger.kernel.org
Subject: Re: [PATCH 26/27] random: factor out a __limit_random_u32_below
 helper
Message-ID: <abLDvwa7c3OXm_e2@zx2c4.com>
References: <20260311070416.972667-1-hch@lst.de>
 <20260311070416.972667-27-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

What Eric said. random.c is not "some library code" meant to be pulled
apart like this. If you think there are some good general purpose
arithmetic functions, by all means develop shared infrastructure in the
right place. But I think for this super simple/trivial _below function,
you can probably just place it additionally where you're using it,
without needing to touch random.c.

