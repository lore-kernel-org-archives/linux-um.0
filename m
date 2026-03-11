Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D860FFD0636
	for <linux-um@archiver.kernel.org>; Wed, 11 Mar 2026 07:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Hc8oVC0rraqJ+8Vr8bqmJfI6i82OBNZtjhcVJAFoc/s=; b=T1B7MakLV4qsYH2dnVepORBpdF
	VynstJzm7pD/5XmKT+JfiAiPlGnYOeTNdxvc6eEfjnVgWZh2pWJkA4Q1YqGjnC7StcK5wbfTl/k63
	2/3/83ml4aqMPcjALSqeDosOAgn9CqvUMpAGK0rGDvZBxJ7OhL99Q+EOCCtJbKG7AnMDQBt3c8He2
	JYAIHyosc6vie0di2e44m5FE00MkssqdEc6wD+oyAPNbqisg35KxKHlK3IyGrucEL81l1WlEh4EFe
	mso1xpZ9NkxKtIUeX869EKal4RS7DoPkwcG/9U7GHIewu4xcXFyZGT3brNvObAAbm2rkoNS6zOeVP
	oQG9JTWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0DcS-0000000Ay8W-0FL2;
	Wed, 11 Mar 2026 07:04:36 +0000
Received: from [212.243.42.10] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0DcK-0000000Ay6i-41SA;
	Wed, 11 Mar 2026 07:04:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
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
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dan Williams <dan.j.williams@intel.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fnnas.com>,
	Li Nan <linan122@huawei.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-raid@vger.kernel.org
Subject: cleanup the RAID5 XOR library v2
Date: Wed, 11 Mar 2026 08:03:32 +0100
Message-ID: <20260311070416.972667-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi all,

the XOR library used for the RAID5 parity is a bit of a mess right now.
The main file sits in crypto/ despite not being cryptography and not
using the crypto API, with the generic implementations sitting in
include/asm-generic and the arch implementations sitting in an asm/
header in theory.  The latter doesn't work for many cases, so
architectures often build the code directly into the core kernel, or
create another module for the architecture code.

Changes this to a single module in lib/ that also contains the
architecture optimizations, similar to the library work Eric Biggers
has done for the CRC and crypto libraries later.  After that it changes
to better calling conventions that allow for smarter architecture
implementations (although none is contained here yet), and uses
static_call to avoid indirection function call overhead.

A git tree is also available here:

    git://git.infradead.org/users/hch/misc.git xor-improvements

Gitweb:

    https://git.infradead.org/?p=users/hch/misc.git;a=shortlog;h=refs/heads/xor-improvements

Changes since v1:
 - use lockdep_assert_preemption_enabled()
 - improve the commit message for the initial um xor.h cleanup
 - further clean up the um arch specific header
 - add SPDX identifier to the new build system files
 - use bool for xor_forced
 - fix an incorrect printk level conversion from warn to info
 - include xor_impl.h in xor-neon.c
 - remove unused exports for riscv
 - simply move the sparc code instead of splititng it
 - simplify the makefile for the x86-specific implementations
 - remove stray references to xor_blocks in crypto/async_tx
 - rework __DO_XOR_BLOCKS to avoid (theoretical) out of bounds references
 - improve the kerneldoc API documentration for xor_gen()
 - spell the name of the srcs argument to xor_gen correctly in xor.h
 - add a kunit test, and a new random helper for it.

Diffstat:
 arch/arm64/include/asm/xor.h              |   73 --
 arch/loongarch/include/asm/xor.h          |   68 --
 arch/loongarch/include/asm/xor_simd.h     |   34 -
 arch/loongarch/lib/xor_simd_glue.c        |   72 --
 arch/powerpc/include/asm/xor.h            |   47 -
 arch/powerpc/include/asm/xor_altivec.h    |   22 
 arch/powerpc/lib/xor_vmx.h                |   22 
 arch/powerpc/lib/xor_vmx_glue.c           |   63 --
 arch/riscv/include/asm/xor.h              |   68 --
 arch/s390/include/asm/xor.h               |   21 
 arch/sparc/include/asm/xor.h              |    9 
 arch/um/include/asm/xor.h                 |   24 
 arch/x86/include/asm/xor_64.h             |   28 -
 b/arch/alpha/Kconfig                      |    1 
 b/arch/arm/Kconfig                        |    1 
 b/arch/arm/lib/Makefile                   |    5 
 b/arch/arm64/Kconfig                      |    1 
 b/arch/arm64/lib/Makefile                 |    6 
 b/arch/loongarch/Kconfig                  |    1 
 b/arch/loongarch/lib/Makefile             |    2 
 b/arch/powerpc/Kconfig                    |    1 
 b/arch/powerpc/lib/Makefile               |    5 
 b/arch/riscv/Kconfig                      |    1 
 b/arch/riscv/lib/Makefile                 |    1 
 b/arch/s390/Kconfig                       |    1 
 b/arch/s390/lib/Makefile                  |    2 
 b/arch/sparc/Kconfig                      |    1 
 b/arch/sparc/include/asm/asm-prototypes.h |    1 
 b/arch/sparc/lib/Makefile                 |    2 
 b/arch/um/Kconfig                         |    1 
 b/arch/x86/Kconfig                        |    1 
 b/crypto/Kconfig                          |    2 
 b/crypto/Makefile                         |    1 
 b/crypto/async_tx/async_xor.c             |   34 -
 b/drivers/char/random.c                   |   26 -
 b/fs/btrfs/raid56.c                       |   27 -
 b/include/asm-generic/Kbuild              |    1 
 b/include/linux/raid/xor.h                |   27 -
 b/include/linux/random.h                  |    1 
 b/lib/Kconfig                             |    1 
 b/lib/Makefile                            |    2 
 b/lib/raid/Kconfig                        |   19 
 b/lib/raid/Makefile                       |    3 
 b/lib/raid/xor/Makefile                   |   43 +
 b/lib/raid/xor/alpha/xor.c                |   46 -
 b/lib/raid/xor/alpha/xor_arch.h           |   22 
 b/lib/raid/xor/arm/xor-neon-glue.c        |   19 
 b/lib/raid/xor/arm/xor-neon.c             |   22 
 b/lib/raid/xor/arm/xor.c                  |  105 ----
 b/lib/raid/xor/arm/xor_arch.h             |   22 
 b/lib/raid/xor/arm64/xor-neon-glue.c      |   26 +
 b/lib/raid/xor/arm64/xor-neon.c           |   94 +--
 b/lib/raid/xor/arm64/xor-neon.h           |    6 
 b/lib/raid/xor/arm64/xor_arch.h           |   21 
 b/lib/raid/xor/loongarch/xor_arch.h       |   33 +
 b/lib/raid/xor/loongarch/xor_simd_glue.c  |   37 +
 b/lib/raid/xor/powerpc/xor_arch.h         |   22 
 b/lib/raid/xor/powerpc/xor_vmx.c          |   40 -
 b/lib/raid/xor/powerpc/xor_vmx.h          |   10 
 b/lib/raid/xor/powerpc/xor_vmx_glue.c     |   28 +
 b/lib/raid/xor/riscv/xor-glue.c           |   25 +
 b/lib/raid/xor/riscv/xor.S                |    4 
 b/lib/raid/xor/riscv/xor_arch.h           |   17 
 b/lib/raid/xor/s390/xor.c                 |   15 
 b/lib/raid/xor/s390/xor_arch.h            |   13 
 b/lib/raid/xor/sparc/xor-sparc32.c        |   32 -
 b/lib/raid/xor/sparc/xor-sparc64-glue.c   |   48 -
 b/lib/raid/xor/sparc/xor-sparc64.S        |   10 
 b/lib/raid/xor/sparc/xor_arch.h           |   35 +
 b/lib/raid/xor/tests/Makefile             |    3 
 b/lib/raid/xor/tests/xor_kunit.c          |  180 +++++++
 b/lib/raid/xor/um/xor_arch.h              |    2 
 b/lib/raid/xor/x86/xor-avx.c              |   52 --
 b/lib/raid/xor/x86/xor-mmx.c              |  120 +---
 b/lib/raid/xor/x86/xor-sse.c              |  105 +---
 b/lib/raid/xor/x86/xor_arch.h             |   36 +
 b/lib/raid/xor/xor-32regs-prefetch.c      |  267 ++++++++++
 b/lib/raid/xor/xor-32regs.c               |  217 ++++++++
 b/lib/raid/xor/xor-8regs-prefetch.c       |  146 +++++
 b/lib/raid/xor/xor-8regs.c                |  103 ++++
 b/lib/raid/xor/xor-core.c                 |  191 +++++++
 b/lib/raid/xor/xor_impl.h                 |   60 ++
 crypto/xor.c                              |  174 -------
 include/asm-generic/xor.h                 |  738 ------------------------------
 84 files changed, 1840 insertions(+), 2078 deletions(-)

