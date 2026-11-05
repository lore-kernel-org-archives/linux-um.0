Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F510606EE86
	for <linux-um@archiver.kernel.org>; Thu,  5 Nov 2026 16:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hlPi/dfo;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XEJ8IsVm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=KeOLiIzJxpfmiLshHLz2qYHvDd4SD5yPvBKJUX6WQ7o=; b=hlPi/dfoEOXORt+ZAj/3qYz16E
	boocHf7jJ+TNWc5Ur4VVAjXlLCq66+kpMbcj1KQlSjUOlxR8Kbm8egsdaZE8gTJCvjgJt9s5o6xGv
	wttX5zsTD6AB0iA2Xn0xwG8A9L8OGM1CCa4DEwk0/LMb4Jz7WEEUCA7UUJGpcwPDzSR1MahTEhp5G
	S0zRSsGJByo8e2UG3wyfv59dS5pF2P0KJfiK7hn7ihlGdYP8ScA4Qp9YuJwWP1OlnjwvMRS8SABYo
	6YlptKyQ85EzGMtYUJ5vMjrU1vGcmTgHeV+jMAdfsSHo1pWZZF/Uu1fdRA18y8I8aNA1pyc4UjtvJ
	gASyT4BA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP0QP-00000009eRV-2VzR;
	Thu, 05 Nov 2026 16:34:53 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP0QO-00000009eRL-0eYK
	for linux-um@lists.infradead.org;
	Thu, 05 Nov 2026 16:34:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8808E60A02;
	Thu,  5 Nov 2026 16:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009BD1F00A1F;
	Thu,  5 Nov 2026 16:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793896491;
	bh=KeOLiIzJxpfmiLshHLz2qYHvDd4SD5yPvBKJUX6WQ7o=;
	h=From:To:Cc:Subject:Date;
	b=XEJ8IsVmUMQs2Bw45dm6T2sy0DrruDROy51FRHVZsjNjM3hsI9ywV64xK3WMGfR4V
	 PjOI5a47xwbYj3JUyStbkNGEZjAols9gi6ooaH4ZyAbRJbcLfe9cS8GcunshCbLmOt
	 +16Wx9eTHZ28mNqbaljuF03bd7DfGdjUMT/G/9cGIT4mChGJhBiX9Bbh+YyomYGZnu
	 XFsQMwWdoP8YRfYIBEwjwbxZS6yl3XOJNjTdeytOd5rBbyF2hPQNhzFac9IihO9djg
	 YSlinCSpFCas4LWJ6cXeAkE17KVcuZ6hLiO03JG6j9Wr5eKIwdNH4XCZ4rXU5g97u2
	 bSkxaXS+Sc0iw==
From: Arnd Bergmann <arnd@kernel.org>
To: Ingo Molnar <mingo@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: [PATCH v2 0/7] x86-32 CPU configuration cleanups
Date: Thu,  5 Nov 2026 17:34:31 +0100
Message-ID: <20261105163440.2381661-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arnd Bergmann <arnd@arndb.de>

Hi Ingo,

Here are some follow-ups to your x86-32 CPU level changes based on
patches I did last year but rebased onto current mainline.

The first three just drop code that is no longer relevant now that Élan
is gone and all CPUs support both TSC and CX8.

The other four patches change the CPU configuration to be more like
x86-64 and other architectures where all kernels are expected to be
generic by default.  I did keep the distinction between i586 and i686
class, but everything else is now just an optimization, building e.g. for
CONFIG_MATOM will still run on all other i686 class CPUs, and picking
any i586-class option will work on everything.

Changes since v1:
 https://lore.kernel.org/all/20260522141959.1071595-1-arnd@kernel.org/

 - rebase to 7.4-rc1
 - drop ts5500 removal patch that was merged [Sean Young]
 - reorder patches for cache line size [Juergen Gross]
  
	Arnd

Arnd Bergmann (7):
  x86: remove AMD Élan remnants
  x86: make TSC usage unconditional
  x86: make CX8 usage unconditional
  x86: require minimum 64 byte cache lines
  x86: remove dependencies on CONFIG_M... CPU options
  x86: remove dependencies on per-CPU options
  x86: simplify 32-bit instruction set selection

 Documentation/virt/kvm/x86/timekeeping.rst |   1 -
 arch/um/include/asm/asm-prototypes.h       |   4 -
 arch/x86/Kconfig.cpu                       |  42 ++---
 arch/x86/Kconfig.cpufeatures               |  14 +-
 arch/x86/Makefile_32.cpu                   |  16 +-
 arch/x86/events/msr.c                      |   5 -
 arch/x86/include/asm/asm-prototypes.h      |   4 -
 arch/x86/include/asm/atomic64_32.h         |  15 --
 arch/x86/include/asm/bitops.h              |   4 +-
 arch/x86/include/asm/cmpxchg_32.h          |  76 +-------
 arch/x86/include/asm/debugreg.h            |  10 +-
 arch/x86/include/asm/percpu.h              |  14 +-
 arch/x86/include/asm/ptrace.h              |   6 +-
 arch/x86/include/asm/timex.h               |   2 -
 arch/x86/include/asm/tsc.h                 |   2 -
 arch/x86/include/asm/vermagic.h            |  36 +---
 arch/x86/kernel/apic/apic.c                |  23 +--
 arch/x86/kernel/apic/io_apic.c             |  22 +--
 arch/x86/kernel/cpu/amd.c                  |  20 ---
 arch/x86/kernel/cpu/centaur.c              |   2 -
 arch/x86/kernel/cpu/common.c               |   4 +-
 arch/x86/kernel/cpu/proc.c                 |  15 +-
 arch/x86/kernel/i8253.c                    |   3 -
 arch/x86/kernel/tsc.c                      |  18 +-
 arch/x86/lib/Makefile                      |   4 -
 arch/x86/lib/atomic64_386_32.S             | 195 ---------------------
 arch/x86/lib/cmpxchg8b_emu.S               |  97 ----------
 arch/x86/lib/kaslr.c                       |  20 +--
 arch/x86/um/Kconfig                        |   2 +-
 arch/x86/um/Makefile                       |   3 +-
 arch/x86/xen/Kconfig                       |   1 -
 arch/x86/xen/time.c                        |   2 -
 drivers/misc/mei/Kconfig                   |   2 +-
 drivers/net/ethernet/intel/igc/igc_ptp.c   |   4 +-
 drivers/ptp/Kconfig                        |   2 +-
 lib/atomic64_test.c                        |   7 +-
 tools/power/cpupower/debug/kernel/Makefile |   5 +-
 37 files changed, 72 insertions(+), 630 deletions(-)
 delete mode 100644 arch/x86/lib/atomic64_386_32.S
 delete mode 100644 arch/x86/lib/cmpxchg8b_emu.S

-- 
2.53.0

Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>
Cc: Gary Guo <gary@garyguo.net>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-um@lists.infradead.org

