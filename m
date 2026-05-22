Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC33CD5BB4
	for <linux-um@archiver.kernel.org>; Fri, 22 May 2026 14:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=l8o4qxxyXUsM6nW61kzZqbSodrtu5C3fCsYL1oX+iOc=; b=geR27tgH6SVU3HK1NWVs2dbavK
	i4ngS6vd8PxvsNGdum1Gh/ZAhWmRpC/RmWtSKD0VLNVuJVP9YYZdbNS6RNN1xLoPsSET4gQ+y6RFo
	Uua3TpJY+zTzmjJOm5jj18w5dE9Gqy7natKgrq4yYYcczAHpdkuHDI0Qa4V2IgPNjpnP7uAGXlkX5
	q7vfta0KXv3aBg9XVsjRH1gfwS4xzZl5cIoHrOwcmvrz66y1EwsLnQlGZNY+7kg1PseacWYFQrhMC
	/TOkocenQLiUSzYJc8bckQvXjwUeGV4PxLgwWAKNbUudRSMDl0MERJnGaenLAJ2iny1jRgT0FgEte
	BMgMoYAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQQjj-0000000B6wX-3rBG;
	Fri, 22 May 2026 14:20:27 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQQjg-0000000B6vx-2gVL
	for linux-um@lists.infradead.org;
	Fri, 22 May 2026 14:20:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 74CEB41AE6;
	Fri, 22 May 2026 14:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDE21F000E9;
	Fri, 22 May 2026 14:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779459623;
	bh=l8o4qxxyXUsM6nW61kzZqbSodrtu5C3fCsYL1oX+iOc=;
	h=From:To:Cc:Subject:Date;
	b=JIAO7RIvv9eKzx6nZf14SThBpc8S6yZLlVUSyXvAkDnqmFXYPaEg5uHoiw8A4fs1k
	 pnNFoBS1gyUX2fdagQBbfz/0JSTUBhyLUC8JUE8mNSonJJHY8KK1gZIbrlZU8Vq7JA
	 A4W74DaOElxUcdWX1hbM5esU6gW6IVKZZr2l1FilPq7MesDPvswz+qx92yaHAIPkvu
	 zQ4xVlUFZsDdpAyzxffA/311mebPndLTyRgmvADvbXNrR+OfXLxriooyrX2/QbKpPf
	 erEdWP0kDCYMpr7eEKIFIyvdYAf8otvmcRtNz3FStkyJz3rHA3dYTtyVEuqbKiosBW
	 K5pGb1U0s/C5A==
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
Subject: [PATCH 0/8] x86-32 CPU configuration cleanups
Date: Fri, 22 May 2026 16:19:51 +0200
Message-Id: <20260522141959.1071595-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_072024_721766_B9B20689 
X-CRM114-Status: GOOD (  13.86  )
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

From: Arnd Bergmann <arnd@arndb.de>

Hi Ingo,

Here are some follow-ups to your x86-32 CPU level changes based on
patches I did last year but rebased onto current linux-next.

The first four just drop code that is no longer relevant now that Élan
is gone and all CPUs support both TSC and CX8.

The other four patches change the CPU configuration to be more like
x86-64 and other architectures where all kernels are expected to be
generic by default.  I did keep the distinction between i586 and i686
class, but everything else is now just an optimization, building e.g. for
CONFIG_MATOM will still run on all other i686 class CPUs, and picking
any i586-class option will work on everything.

      Arnd

Arnd Bergmann (8):
  x86: remove ts5500 platforms support
  x86: remove AMD Élan remnants
  x86: make TSC usage unconditional
  x86: make CX8 usage unconditional
  x86: remove dependencies on CONFIG_M... CPU options
  x86: require minimum 64 byte cache lines
  x86: remove dependencies on per-CPU options
  x86: simplify 32-bit instruction set selection

 .../ABI/testing/sysfs-platform-ts5500         |  54 ---
 Documentation/virt/kvm/x86/timekeeping.rst    |   1 -
 MAINTAINERS                                   |   5 -
 arch/um/include/asm/asm-prototypes.h          |   4 -
 arch/x86/Kconfig                              |  10 -
 arch/x86/Kconfig.cpu                          |  41 +--
 arch/x86/Kconfig.cpufeatures                  |  15 +-
 arch/x86/Makefile_32.cpu                      |  16 +-
 arch/x86/events/msr.c                         |   5 -
 arch/x86/include/asm/asm-prototypes.h         |   4 -
 arch/x86/include/asm/atomic64_32.h            |  15 -
 arch/x86/include/asm/bitops.h                 |   4 +-
 arch/x86/include/asm/cmpxchg_32.h             |  76 +---
 arch/x86/include/asm/debugreg.h               |  10 +-
 arch/x86/include/asm/percpu.h                 |  14 +-
 arch/x86/include/asm/ptrace.h                 |   6 +-
 arch/x86/include/asm/timex.h                  |   3 -
 arch/x86/include/asm/trace_clock.h            |   8 -
 arch/x86/include/asm/tsc.h                    |  13 -
 arch/x86/include/asm/vermagic.h               |  36 +-
 arch/x86/kernel/Makefile                      |   4 +-
 arch/x86/kernel/apic/apic.c                   |  23 +-
 arch/x86/kernel/apic/io_apic.c                |  22 +-
 arch/x86/kernel/cpu/amd.c                     |  20 -
 arch/x86/kernel/cpu/centaur.c                 |   2 -
 arch/x86/kernel/cpu/common.c                  |   4 +-
 arch/x86/kernel/cpu/proc.c                    |  15 +-
 arch/x86/kernel/i8253.c                       |   3 -
 arch/x86/kernel/tsc.c                         |  30 +-
 arch/x86/lib/Makefile                         |   4 -
 arch/x86/lib/atomic64_386_32.S                | 195 ----------
 arch/x86/lib/cmpxchg8b_emu.S                  |  97 -----
 arch/x86/lib/kaslr.c                          |  20 +-
 arch/x86/platform/Makefile                    |   1 -
 arch/x86/platform/ts5500/Makefile             |   2 -
 arch/x86/platform/ts5500/ts5500.c             | 341 ------------------
 arch/x86/um/Kconfig                           |   2 +-
 arch/x86/um/Makefile                          |   3 +-
 arch/x86/xen/Kconfig                          |   3 +-
 arch/x86/xen/time.c                           |   2 -
 drivers/misc/mei/Kconfig                      |   2 +-
 drivers/net/ethernet/intel/igc/igc_ptp.c      |   4 +-
 drivers/ptp/Kconfig                           |   2 +-
 lib/atomic64_test.c                           |   7 +-
 tools/power/cpupower/debug/kernel/Makefile    |   5 +-
 45 files changed, 75 insertions(+), 1078 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-platform-ts5500
 delete mode 100644 arch/x86/lib/atomic64_386_32.S
 delete mode 100644 arch/x86/lib/cmpxchg8b_emu.S
 delete mode 100644 arch/x86/platform/ts5500/Makefile
 delete mode 100644 arch/x86/platform/ts5500/ts5500.c

-- 
2.39.5

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

