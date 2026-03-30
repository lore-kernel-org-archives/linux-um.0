Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DF7FF493A
	for <linux-um@archiver.kernel.org>; Mon, 30 Mar 2026 04:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wamVM0zYr8WZHFMloqOz+25gc/vBvTSbereH3lC8cH8=; b=qBKXsvxc3PD0ufLZXGDu7t2/8n
	lud/0kpBB0tf5V0o6bRYzQpPENiHCgB4yuX0tivqIleQlXF0yV8P6uUr7uvAjgo9BejgMAdg9fhuq
	OdV3WMQ90odTHs13/nH48wotDiVamp7X35+DOjvDalFcFZ3fpC2zpZdk5JFGUeL8gQ8t05a3RC/qv
	8Vhru8A5LgviWW7yJgF0jNC5kIahL710Dli8F4DXoRyDcKYynB14jazbM3PuTdewGd0Lq+dGozBGe
	yCosfrD9gBzUUcFFpG73vlwfCfk8k45kyOLumuyH7imyFJzzT4I7SZl2Ccvi8HTp7AIw2pvHVmTPq
	HprHAPXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w73ve-0000000Aa6d-2w8V;
	Mon, 30 Mar 2026 04:08:42 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w73vY-0000000Aa5s-2sWY;
	Mon, 30 Mar 2026 04:08:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 80C04419B5;
	Mon, 30 Mar 2026 04:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE31C2BCB0;
	Mon, 30 Mar 2026 04:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774843715;
	bh=+A5NQMhCBBRKzoUSudLKLJZAfA7+8FwRJRitDmnyubY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rk5v/EL75EZ+hbfqEshAQz2QQe+iuSZNg84JSHBgQeHC7MQpiAlomNcv0214mZuA/
	 gbjlTaVuay4FRB4MdNSX8Dc51tayHV0e0emc/xX42elGiN+vJjajX0Mj+DjRgCotku
	 NJi0Cx4TsK5vFwnV0mTb3dWliU8/DvykqoMFl4Ne60JHqqLvWC6hKlA59DG+0Ub0mK
	 i/RlQXksnWCqxo0T2LZaEiVWOLa6KPURQ9Z4xB+WBPWlEQnWDb+1w70onILoyinJz8
	 gZZx9gSRcK/J1hwQTRHyR8albh/f2o81y7CxFJD3rwa1khO6zG0Hxaks+qBoOStyxZ
	 Du8I3EdOFGAig==
Date: Sun, 29 Mar 2026 21:07:24 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
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
Subject: Re: cleanup the RAID5 XOR library v4
Message-ID: <20260330040724.GA647721@sol>
References: <20260327061704.3707577-1-hch@lst.de>
 <20260329213119.GA2106@quark>
 <20260329155126.a01a5729b7d8376712182851@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329155126.a01a5729b7d8376712182851@linux-foundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260329_210836_768784_1EBF6095 
X-CRM114-Status: GOOD (  21.32  )
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

On Sun, Mar 29, 2026 at 03:51:26PM -0700, Andrew Morton wrote:
> > 
> > Reviewed-by: Eric Biggers <ebiggers@kernel.org>
> 
> Great, thanks, added to all changelogs.
> 
> > But yes, as Andrew mentioned there are two "xor: add a better public
> > API" patches.  They should be folded together.
> 
> I folded them.
> 
> I'm a bit wobbly about upstreaming all this for 7.1-rc1.  It hits on a
> lot of stuff and I don't think we've heard a lot from the affected
> maintainers.
> 
> otoh, we're unlikely to learn much from an additional nine weeks in
> linux-next so at some point one has to forge ahead and rely on seven
> weeks of -rc to address any remaining niggles.  And I'm confident that
> Christoph will support his work well.
> 
> But still, hearing some reassuring words about this would be
> appreciated ;)

The architecture-optimized crypto and CRC code has been the same way.
I've been working on it across architectures, and most of the arch
maintainers don't pay much attention to it.

I've seen engagement from a few of them, for example s390.  But as a
general rule it's a separate group of people working on this code.

I think seeing the same for lib/raid/ is expected.  So while the arch
maintainers are always welcome to chime in, I don't think we need to
wait for all of them, as then we'd be waiting forever.

Re testing, I've been running the crypto, CRC, and now the XOR KUnit
tests in QEMU for 8 architectures (arm, arm64, mips, powerpc, riscv,
s390, sparc, and x86), and over 40 variants within those (e.g. varying
CONFIG_64BIT, CONFIG_CPU_BIG_ENDIAN, and QEMU's "-cpu" flag).  They are
all passing, including the XOR test that Christoph added in this series.

(So I guess feel free to add:

    Tested-by: Eric Biggers <ebiggers@kernel.org>

to all the patches in this series as well.)

That still doesn't cover all the arch-optimized code, due to me missing
various combinations or QEMU not supporting them.  But it's something.

I'm also hoping that with the move to standard KUnit tests, we'll get a
larger group of people, including projects like KernelCI, that simply
run *all* the kernel's KUnit tests on whatever platforms they care
about.  That approach is more scalable.

- Eric

