Return-Path: <ebiggers@kernel.org>
Date: Sun, 10 Apr 2022 16:03:22 -0700
From: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH RFC v1 00/10] archs/random: fallback to using
 sched_clock() if no cycle counter
Message-ID: <YlNiOunUd5xfQiSL@sol.localdomain>
References: <20220408182145.142506-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408182145.142506-1-Jason@zx2c4.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, arnd@arndb.de, Theodore Ts'o <tytso@mit.edu>, Dominik Brodowski <linux@dominikbrodowski.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "David S . Miller" <davem@davemloft.net>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org, linux-xtensa@linux-xtensa.org
List-ID: <linux-um.lists.infradead.org>

On Fri, Apr 08, 2022 at 08:21:35PM +0200, Jason A. Donenfeld wrote:
> By my first guess, we have ktime_get_boottime_ns(), jiffies, and
> sched_clock(). It seems like sched_clock() has already done a lot of
> work in being always available with some incrementing value, falling
> back to jiffies as necessary. So this series goes with that as a
> fallback, for when the architecture doesn't define random_get_entropy in
> its own way and when there's no working cycle counter.

Won't this interact badly with how try_to_generate_entropy() (a.k.a. the "Linus
Jitter Dance") detects the presence of an appropriate timer currently?

        stack.cycles = random_get_entropy();

        /* Slow counter - or none. Don't even bother */
        if (stack.cycles == random_get_entropy())
                return;

So if random_get_entropy() always returns 0, then try_to_generate_entropy()
won't run.  However, if random_get_entropy() is even just a low-precision timer,
then try_to_generate_entropy() will have a chance of running, since the timer
might change between the two calls to random_get_entropy().  And if
try_to_generate_entropy() does run, then it credits 1 bit of entropy for every
iteration, regardless of the timer's precision.

This is an existing problem, but this patchset will make it worse, as it changes
a lot of cases from "no timer" to "low precision timer".

Perhaps try_to_generate_entropy() should check the timer at least 3 times and
verify that it changed each time?

- Eric

