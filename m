Return-Path: <SRS0=C8GT=US=zx2c4.com=Jason@kernel.org>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH RFC v1 07/10] arm64: use sched_clock() for random_get_entropy() instead of zero
Date: Fri,  8 Apr 2022 20:21:42 +0200
Message-Id: <20220408182145.142506-8-Jason@zx2c4.com>
In-Reply-To: <20220408182145.142506-1-Jason@zx2c4.com>
References: <20220408182145.142506-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, arnd@arndb.de
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, Theodore Ts'o <tytso@mit.edu>, Dominik Brodowski <linux@dominikbrodowski.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "David S . Miller" <davem@davemloft.net>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org, linux-xtensa@linux-xtensa.org
List-ID: <linux-um.lists.infradead.org>

In the event that random_get_entropy() can't access a cycle counter or
similar, falling back to returning 0 is really not the best we can do.
Instead, at least calling sched_clock() would be preferable, because
that always needs to return _something_, even falling back to jiffies
eventually. It's not as though sched_clock() is super high precision or
guaranteed to be entropic, but basically anything that's not zero all
the time is better than returning zero all the time.

If CONFIG_ARM_ARCH_TIMER=n, then get_cycles() will return 0, so we only
need the fallback code for that case.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/arm64/include/asm/timex.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/include/asm/timex.h b/arch/arm64/include/asm/timex.h
index cf59ce91b22d..bfebd2e1ce45 100644
--- a/arch/arm64/include/asm/timex.h
+++ b/arch/arm64/include/asm/timex.h
@@ -13,6 +13,15 @@
  */
 #define get_cycles()	arch_timer_read_counter()
 
+#ifndef CONFIG_ARM_ARCH_TIMER
+/*
+ * The default implementation of random_get_entropy() calls get_cycles(),
+ * which will return 0 if CONFIG_ARM_ARCH_TIMER=n, so we fall back to
+ * sched_clock() here. Not a great situation, but better than nothing.
+ */
+#define random_get_entropy() ((unsigned long)sched_clock())
+#endif
+
 #include <asm-generic/timex.h>
 
 #endif
-- 
2.35.1


