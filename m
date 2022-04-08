Return-Path: <SRS0=C8GT=US=zx2c4.com=Jason@kernel.org>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH RFC v1 01/10] random: use sched_clock() for random_get_entropy() if no get_cycles()
Date: Fri,  8 Apr 2022 20:21:36 +0200
Message-Id: <20220408182145.142506-2-Jason@zx2c4.com>
In-Reply-To: <20220408182145.142506-1-Jason@zx2c4.com>
References: <20220408182145.142506-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, arnd@arndb.de
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, Theodore Ts'o <tytso@mit.edu>, Dominik Brodowski <linux@dominikbrodowski.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "David S . Miller" <davem@davemloft.net>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org, linux-xtensa@linux-xtensa.org
List-ID: <linux-um.lists.infradead.org>

In the event that a given arch does not define get_cycles(), falling
back to the get_cycles() default implementation that returns 0 is really
not the best we can do. Instead, at least calling sched_clock() would be
preferable, because that always needs to return _something_, even
falling back to jiffies eventually. It's not as though sched_clock() is
super high precision or guaranteed to be entropic, but basically
anything that's not zero all the time is better than returning zero all
the time.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 include/linux/timex.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/timex.h b/include/linux/timex.h
index 5745c90c8800..bd78f784762e 100644
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -61,6 +61,7 @@
 #include <linux/compiler.h>
 #include <linux/types.h>
 #include <linux/param.h>
+#include <linux/sched/clock.h>
 
 #include <asm/timex.h>
 
@@ -74,8 +75,13 @@
  *
  * By default we use get_cycles() for this purpose, but individual
  * architectures may override this in their asm/timex.h header file.
+ * If a given arch does not have get_cycles(), then we fallback to
+ * using sched_clock().
  */
+#ifdef get_cycles
 #define random_get_entropy()	((unsigned long)get_cycles())
+#else
+#define random_get_entropy()	((unsigned long)sched_clock())
 #endif
 
 /*
-- 
2.35.1


