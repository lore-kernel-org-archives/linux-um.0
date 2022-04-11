Return-Path: <tglx@linutronix.de>
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 03/11] m68k: use ktime_read_raw_clock() for
 random_get_entropy() instead of zero
In-Reply-To: <20220410214951.55294-4-Jason@zx2c4.com>
References: <20220410214951.55294-1-Jason@zx2c4.com>
 <20220410214951.55294-4-Jason@zx2c4.com>
Date: Mon, 11 Apr 2022 10:18:30 +0200
Message-ID: <87sfqkf2y1.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, arnd@arndb.de
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, Theodore Ts'o <tytso@mit.edu>, Dominik Brodowski <linux@dominikbrodowski.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "David S . Miller" <davem@davemloft.net>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin  <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov" <jcmvbkbc@gmail.com>, John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org, linux-xtensa@linux-xtensa.org
List-ID: <linux-um.lists.infradead.org>

On Sun, Apr 10 2022 at 23:49, Jason A. Donenfeld wrote:

> In the event that random_get_entropy() can't access a cycle counter or
> similar, falling back to returning 0 is really not the best we can do.
> Instead, at least calling ktime_read_raw_clock() would be preferable,
> because that always needs to return _something_, even falling back to
> jiffies eventually. It's not as though ktime_read_raw_clock() is super
> high precision or guaranteed to be entropic, but basically anything
> that's not zero all the time is better than returning zero all the time.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/m68k/include/asm/timex.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/m68k/include/asm/timex.h b/arch/m68k/include/asm/timex.h
> index 6a21d9358280..5351b10e1b18 100644
> --- a/arch/m68k/include/asm/timex.h
> +++ b/arch/m68k/include/asm/timex.h
> @@ -35,7 +35,7 @@ static inline unsigned long random_get_entropy(void)
>  {
>  	if (mach_random_get_entropy)
>  		return mach_random_get_entropy();
> -	return 0;
> +	return ktime_read_raw_clock();

I'd rather do something like this in a common header:

unsigned long random_get_entropy_fallback(void);

and use random_get_entropy_fallback() in the architecture specific
files.

That way you can encapsulate the fallback implementation in the random
code and if it turns out that ktime_read_raw_clock() is a stupid idea or
someone has a better idea then you have to change exactly one place and
not patch the whole tree again.

Thanks,

        tglx

