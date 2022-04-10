Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <YlNiOunUd5xfQiSL@sol.localdomain>
References: <20220408182145.142506-1-Jason@zx2c4.com>
 <YlNiOunUd5xfQiSL@sol.localdomain>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Mon, 11 Apr 2022 01:29:34 +0200
Message-ID: <CAHmME9quorveHN-z=n4r_gfj8ShEfprXcTvsc7bYj9_caxx7sg@mail.gmail.com>
Subject: Re: [PATCH RFC v1 00/10] archs/random: fallback to using
 sched_clock() if no cycle counter
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, arnd@arndb.de, Theodore Ts'o <tytso@mit.edu>, Dominik Brodowski <linux@dominikbrodowski.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "David S . Miller" <davem@davemloft.net>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org, linux-xtensa@linux-xtensa.org

Hi Eric,

On 4/11/22, Eric Biggers <ebiggers@kernel.org> wrote:
> On Fri, Apr 08, 2022 at 08:21:35PM +0200, Jason A. Donenfeld wrote:
>> By my first guess, we have ktime_get_boottime_ns(), jiffies, and
>> sched_clock(). It seems like sched_clock() has already done a lot of
>> work in being always available with some incrementing value, falling
>> back to jiffies as necessary. So this series goes with that as a
>> fallback, for when the architecture doesn't define random_get_entropy in
>> its own way and when there's no working cycle counter.
>
> Won't this interact badly with how try_to_generate_entropy() (a.k.a. the
> "Linus
> Jitter Dance") detects the presence of an appropriate timer currently?
>
>         stack.cycles = random_get_entropy();
>
>         /* Slow counter - or none. Don't even bother */
>         if (stack.cycles == random_get_entropy())
>                 return;
>
> So if random_get_entropy() always returns 0, then try_to_generate_entropy()
> won't run.  However, if random_get_entropy() is even just a low-precision
> timer,
> then try_to_generate_entropy() will have a chance of running, since the
> timer
> might change between the two calls to random_get_entropy().  And if
> try_to_generate_entropy() does run, then it credits 1 bit of entropy for
> every
> iteration, regardless of the timer's precision.
>
> This is an existing problem, but this patchset will make it worse, as it
> changes
> a lot of cases from "no timer" to "low precision timer".
>
> Perhaps try_to_generate_entropy() should check the timer at least 3 times
> and
> verify that it changed each time?

What you've identified is actually already the case for platforms
where the cycle counter is already just slow (and there are a few such
platforms; my odroid C2 even exhibits this). As you identified, the
cycle counter might already be too slow, yet we get [un]lucky and
reach this code right on the cusp or a change.

So the problem isn't new here, per say, for this patchset. But indeed
perhaps we should consider adjusting the heuristics for that a bit in
a separate patch. Your check three times idea seems like a good
starting point, if you want to send a patch and we can poke at it.

Jason

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

