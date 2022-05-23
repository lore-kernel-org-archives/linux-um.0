Return-Path: <dinguyen@kernel.org>
Message-ID: <8e440c28-d4b9-2fc6-0294-f77544264d5c@kernel.org>
Date: Mon, 23 May 2022 08:58:16 -0500
MIME-Version: 1.0
Subject: Re: [PATCH v4 06/11] nios2: use fallback for random_get_entropy()
 instead of zero
Content-Language: en-US
References: <20220413115411.21489-1-Jason@zx2c4.com>
 <20220413115411.21489-7-Jason@zx2c4.com>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20220413115411.21489-7-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, tglx@linutronix.de, arnd@arndb.de
Cc: Theodore Ts'o <tytso@mit.edu>, Dominik Brodowski <linux@dominikbrodowski.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "David S . Miller" <davem@davemloft.net>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org, linux-xtensa@linux-xtensa.org
List-ID: <linux-um.lists.infradead.org>



On 4/13/22 06:54, Jason A. Donenfeld wrote:
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
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>   arch/nios2/include/asm/timex.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/nios2/include/asm/timex.h b/arch/nios2/include/asm/timex.h
> index a769f871b28d..d9a3f426cdda 100644
> --- a/arch/nios2/include/asm/timex.h
> +++ b/arch/nios2/include/asm/timex.h
> @@ -9,4 +9,6 @@ typedef unsigned long cycles_t;
>   
>   extern cycles_t get_cycles(void);
>   
> +#define random_get_entropy() (((unsigned long)get_cycles()) ?: random_get_entropy_fallback())
> +
>   #endif

Acked-by: Dinh Nguyen <dinguyen@kernel.org>

