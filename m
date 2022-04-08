Return-Path: <SRS0=C8GT=US=zx2c4.com=Jason@kernel.org>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH RFC v1 06/10] x86: use sched_clock() for random_get_entropy() instead of zero
Date: Fri,  8 Apr 2022 20:21:41 +0200
Message-Id: <20220408182145.142506-7-Jason@zx2c4.com>
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

If CONFIG_X86_TSC=n, then it's possible that we're running on a 486 with
no RDTSC, so we only need the fallback code for that case.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: x86@kernel.org
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/x86/include/asm/tsc.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index 01a300a9700b..b0c0b2b9e0f7 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -5,6 +5,7 @@
 #ifndef _ASM_X86_TSC_H
 #define _ASM_X86_TSC_H
 
+#include <linux/sched/clock.h>
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
 
@@ -28,6 +29,16 @@ static inline cycles_t get_cycles(void)
 	return rdtsc();
 }
 
+static inline unsigned long random_get_entropy(void)
+{
+#ifndef CONFIG_X86_TSC
+	if (!boot_cpu_has(X86_FEATURE_TSC))
+		return sched_clock();
+#endif
+	return rdtsc();
+}
+#define random_get_entropy random_get_entropy
+
 extern struct system_counterval_t convert_art_to_tsc(u64 art);
 extern struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns);
 
-- 
2.35.1


