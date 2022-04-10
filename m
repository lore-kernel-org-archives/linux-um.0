Return-Path: <SRS0=O4Mn=UU=zx2c4.com=Jason@kernel.org>
Date: Sun, 10 Apr 2022 16:25:52 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH RFC v1 00/10] archs/random: fallback to using
 sched_clock() if no cycle counter
Message-ID: <YlLo8JVOS6FDmWUM@zx2c4.com>
References: <20220408182145.142506-1-Jason@zx2c4.com>
 <87wnfxhm3n.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wnfxhm3n.ffs@tglx>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, arnd@arndb.de, Theodore Ts'o <tytso@mit.edu>, Dominik Brodowski <linux@dominikbrodowski.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "David S . Miller" <davem@davemloft.net>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org, linux-xtensa@linux-xtensa.org
List-ID: <linux-um.lists.infradead.org>

Hi Thomas,

On Sun, Apr 10, 2022 at 01:29:32AM +0200, Thomas Gleixner wrote:
> But the below uncompiled hack gives you access to the 'best' clocksource
> of a machine, i.e. the one which the platform decided to be the one
> which is giving the best resolution. The minimal bitwidth of that is
> AFAICT 20 bits. In the jiffies case this will at least advance every
> tick.

Oh, huh, that's pretty cool. I can try to make a commit out of that. Are
you suggesting I use this as the fallback for all platforms that
currently return zero, or just for m68k per Arnd's suggestion, and then
use sched_clock() for the others? It sounds to me like you're saying
this would be best for all of them. If so, that'd be quite nice.


> The price, e.g. on x86 would be that RDTSC would be invoked via an
> indirect function call. Not the end of the world...

Well on x86, random_get_entropy() is overridden in the arch/ code to
call get_cycles(). So this would really just be for 486 and for other
architectures with no cycle counter that are currently returning zero.
However, this brings up a good point: if your proposed
ktime_read_raw_clock() function really is so nice, should it be used
everywhere unconditionally with no arch-specific overrides? On x86, is
it really guaranteed to be RDTSC, and not, say, some off-core HPET
situation? And is this acceptable to call from the hard irq handler?

Not yet having too much knowledge, I'm tentatively leaning toward the
safe side, of just using ktime_read_raw_clock() in the current places
that return zero all the time -- that is, for the purpose this patchset
has.

Jason

