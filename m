Return-Path: <robh@kernel.org>
MIME-Version: 1.0
References: <20220413115411.21489-1-Jason@zx2c4.com> <20220413115411.21489-4-Jason@zx2c4.com>
In-Reply-To: <20220413115411.21489-4-Jason@zx2c4.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 13 Apr 2022 09:40:13 -0500
Message-ID: <CAL_JsqJ86vZKZQO+9_Kva-EbZrRPMbcgDm+UvjJdnR=GL-qHSw@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] riscv: use fallback for random_get_entropy()
 instead of zero
Content-Type: text/plain; charset="UTF-8"
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Theodore Ts'o <tytso@mit.edu>, Dominik Brodowski <linux@dominikbrodowski.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "David S . Miller" <davem@davemloft.net>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-m68k@lists.linux-m68k.org, "open list:MIPS" <linux-mips@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>, sparclinux <sparclinux@vger.kernel.org>, linux-um@lists.infradead.org, X86 ML <x86@kernel.org>, linux-xtensa@linux-xtensa.org
List-ID: <linux-um.lists.infradead.org>

On Wed, Apr 13, 2022 at 6:56 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> In the event that random_get_entropy() can't access a cycle counter or
> similar, falling back to returning 0 is really not the best we can do.
> Instead, at least calling random_get_entropy_fallback() would be
> preferable, because that always needs to return _something_, even
> falling back to jiffies eventually. It's not as though
> random_get_entropy_fallback() is super high precision or guaranteed to
> be entropic, but basically anything that's not zero all the time is
> better than returning zero all the time.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/riscv/include/asm/timex.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
> index 507cae273bc6..d6a7428f6248 100644
> --- a/arch/riscv/include/asm/timex.h
> +++ b/arch/riscv/include/asm/timex.h
> @@ -41,7 +41,7 @@ static inline u32 get_cycles_hi(void)
>  static inline unsigned long random_get_entropy(void)
>  {
>         if (unlikely(clint_time_val == NULL))

Moving this check to get_cycles() implementation would eliminate the
RiscV implementation of random_get_entropy() if you follow my other
suggestion.

I guess there's some advantage to skipping a NULL check every time for
get_cycles(), but really the register read time will be much slower
than an added check.

> -               return 0;
> +               return random_get_entropy_fallback();
>         return get_cycles();
>  }
>  #define random_get_entropy()   random_get_entropy()

